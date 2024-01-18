#include <YSI\y_hooks>

#define send->%0(%1) SendClientMessageEx(%0,COLOR_GREEN,"RENT:"%1)
#define put->%0(%1,%2) RentPoint[%1][%0] = %2
#define get->%0(%1) RentPoint[%1][%0]
#define create->Rent(%0) CreateRentPoint(%0)
#define refresh->Rent(%0) Refresh_RentPoint(%0)
#define delete->Rent(%0) Delete_RentPoint(%0)
#define save->Rent(%0) Save_RentPoint(%0)
#define fmt->%0(%1) format(%0, sizeof(%0), %1)
#define exec->%0(%1) mysql_tquery(g_iHandle, %0, %1)
#define clear->%0() %0[0] = EOS

#define KHUSUS_ADMIN_LEVEL_5 if (AccountData[playerid][pAdmin] < 5) return PermissionError(playerid);



CMD:createrent(playerid, params[]) {

    KHUSUS_ADMIN_LEVEL_5

    static
        createID;

    createID = CreateRentPoint(playerid);

    if (createID == -1)
        return SendErrorMessage(playerid, "Maximum rent point has been reached the server limit!");

    send->playerid("Successfully created rent point, ID: %d", createID);
    return 1;
}


CMD:editrent(playerid, params[]) {

    KHUSUS_ADMIN_LEVEL_5

    new 
        editID, editType[24], editValue[128];

    if (sscanf(params, "is[24]s()[128]", editID, editType, editValue))
        return SendSyntaxMessage(playerid, "/editrent [rentid] [list]"), SendClientMessage(playerid, COLOR_WHITE, GREEN"LIST:"WHITE" pos");

    if (!get->rentExists(editID) || (editID >= MAX_RENT_POINT || editID < 0))
        return SendErrorMessage(playerid, "Invalid Rent ID");

    if (!strcmp(editType, "pos", true)) {
        new 
            Float:editRentX, Float:editRentY, Float:editRentZ;

        GetPlayerPos(playerid, editRentX, editRentY, editRentZ);

        put->rentPosX(editID, editRentX);
        put->rentPosY(editID, editRentY);
        put->rentPosZ(editID, editRentZ);

        refresh->Rent(editID);
        save->Rent(editID);

        send->playerid("Sukses mengedit posisi rental point ID: %d", editID);
    }
    return 1;
}

CMD:managerentcar(playerid, params[]) {

    KHUSUS_ADMIN_LEVEL_5

    new 
        srentID;

    if (sscanf(params, "i", srentID))
        return SendSyntaxMessage(playerid, "/managerentcar [rental point ID]");

    if (!get->rentExists(srentID) || (srentID >= MAX_RENT_POINT || srentID < 0))
        return SendErrorMessage(playerid, "Invalid Rent ID");

    ShowRentCarMenu(playerid, srentID);
    return 1;
}

CMD:deleterentcar(playerid, params[]) {

    KHUSUS_ADMIN_LEVEL_5

    new 
        deleteRentID, deleteLimit;

    if (sscanf(params, "ii", deleteRentID, deleteLimit))
        return SendSyntaxMessage(playerid, "/deleterentcar [rental point ID] [1-5]");

    if (!get->rentExists(deleteRentID) || (deleteRentID >= MAX_RENT_POINT || deleteRentID < 0))
        return SendErrorMessage(playerid, "Invalid Rent ID");

    //magic number boi
    deleteLimit = (7 - deleteLimit);

    //seharusnya deleteLimit entah itu 5 sampe 1
    for (new i = deleteLimit; i --> 0;) {
        RentPoint[deleteRentID][rentList][i] = 0;
        RentPoint[deleteRentID][rentPrice][i] = 0;
    }
    save->Rent(deleteRentID);
    return 1;
}


ShowRentCarMenu(playerid, showRentID) {
    new 
        kszk_Output[224], addCount;

    fmt->kszk_Output("Name\tPrice\n");
    for (new i ; i < MAX_RENT_LIST; i ++) {
        format(kszk_Output, sizeof(kszk_Output), "%s%s\t%s\n", kszk_Output, GetVehicleNameByModel(RentPoint[showRentID][rentList][i]), FormatNumber(RentPoint[showRentID][rentPrice][i]));
        addCount++;
    }

    if (addCount < MAX_RENT_LIST)
        fmt->kszk_Output("%sCreate Car...", kszk_Output);

    SetPVarInt(playerid, "holdingRentID", showRentID);
    Dialog_Show(playerid, rentEdit, DIALOG_STYLE_TABLIST_HEADERS, "Edit Rent Car", kszk_Output, "Edit", "Close");
    return 1;
}

Dialog:rentEdit(playerid, response, listitem, inputtext[])  {
    if (!response)  {
        SetPVarInt(playerid, "holdingRentID", 0);
        SetPVarInt(playerid, "holdingSelectedItem", 0);
        SetPVarInt(playerid, "holdingRentModel", 0);
        return 0;
    }

    SetPVarInt(playerid, "holdingSelectedItem", listitem);
    Dialog_Show(playerid, rentEditName, DIALOG_STYLE_INPUT, "Put Rent Car", "Put vehicle Model/Name below to put into Rent List\n(Example: 400 or Bravura)", "Select", "Back");    
    return 1;
}

Dialog:rentEditName(playerid, response, listitem, inputtext[]) {
    if (!response)
        return ShowRentCarMenu(playerid, GetPVarInt(playerid, "holdingRentID"));


    if((inputtext[0] = GetVehicleModelByName(inputtext)) == 0)
        return SendErrorMessage(playerid, "Invalid Vehicle ID"), Dialog_Show(playerid, rentEditName, DIALOG_STYLE_INPUT, "Put Rent Car" , "Put vehicle Model/Name below to put into Rent List\n(Example: 400 or Bravura)", "Select", "Back");    
    
    SetPVarInt(playerid, "holdingRentModel", inputtext[0]);
    Dialog_Show(playerid, rentEditPrice, DIALOG_STYLE_INPUT, "Edit Rent Price", "Please put a price for vehicle %s\n(Example: $2000 or 2000)", "Done", "Back", GetVehicleNameByModel(inputtext[0]));
    return 1;
}

Dialog:rentEditPrice(playerid, response, listitem, inputtext[]) {
    if (!response) 
        return Dialog_Show(playerid, rentEditName, DIALOG_STYLE_INPUT, "Put Rent Car" , "Put vehicle Model/Name below to put into Rent List\n(Example: 400 or Bravura)", "Select", "Back");    
    new 
        letakDollar = strfind(inputtext, "$", true);

    if (letakDollar != -1) {
        strdel(inputtext, 0, letakDollar);
    }

    if (!IsNumeric(inputtext) || strval(inputtext) > 500)
        return SendErrorMessage(playerid, "Invalid Price Number."), Dialog_Show(playerid, rentEditPrice, DIALOG_STYLE_INPUT, "Edit Rent Price", "Please put a price for vehicle %s\n(Example: $2000 or 2000)", "Done", "Back", GetVehicleNameByModel(GetPVarInt(playerid, "holdingRentModel")));

    new 
        carRentID = GetPVarInt(playerid, "holdingRentID"),
        carRentIdx = GetPVarInt(playerid, "holdingSelectedItem"),
        carRentModel = GetPVarInt(playerid, "holdingRentModel");

    RentPoint[carRentID][rentList][carRentIdx] = carRentModel;
    RentPoint[carRentID][rentPrice][carRentIdx] = strval(inputtext);

    save->Rent(carRentID);

    send->playerid("Sukses memsukan mobil, mengembalikan ke rental menu...");
    ShowRentCarMenu(playerid, GetPVarInt(playerid, "holdingRentID"));
    return 1;
}

CMD:deleterent(playerid, params[]) {

    KHUSUS_ADMIN_LEVEL_5

    new 
        deleteID;

    if (sscanf(params, "i", deleteID))
        return SendSyntaxMessage(playerid, "/deleterent [rentid]");

    if (!get->rentExists(deleteID) || (deleteID >= MAX_RENT_POINT || deleteID < 0))
        return SendErrorMessage(playerid, "Invalid Rent ID");

    delete->Rent(deleteID);
    send->playerid("Sukses menghapus rental dengan ID: %d", deleteID);
    return 1;
}
CMD:rentveh(playerid, params[]) {
    if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "Anda harus turun dari kendaraan untuk menggunakan perintah ini");

    new 
        nearestID;

    if (PlayerPunyaRental(playerid))
        return SendErrorMessage(playerid, "Anda sudah memiliki kendaraan sewa.");


    if ((nearestID = GetNearestRentalPoint(playerid)) != -1)
        return GiveRentalMenu(playerid, nearestID);

    SendErrorMessage(playerid, "Anda tidak dekat dengan Rental Point apapun.");
    return 1;
}

static PlayerPunyaRental(playerid) {
    for (new i; i < MAX_DYNAMIC_CARS; i ++) if (VehicleData[i][cExists]) {
        if (VehicleData[i][cRentOwned] == PlayerData[playerid][pID])
            return 1;
    }
    return 0;
}

static GiveRentalMenu(plrID, xrentID) {
    new
        combineString[1024];

    SetPVarInt(plrID, "holdingRentID", xrentID);

    fmt->combineString("Nama\tHarga\n");
    for (new i; i < MAX_RENT_LIST; i ++) {
        fmt->combineString("%s %s\t%s\n", combineString, GetVehicleNameByModel(RentPoint[xrentID][rentList][i]), FormatNumber(RentPoint[xrentID][rentPrice][i]));
    }
    Dialog_Show(plrID, RentCar, DIALOG_STYLE_TABLIST_HEADERS, "Rental Menu", combineString, "Select", "Back");
    return 1;
}

static CreateRentPoint(plrID) {
    static 
        Float:prentPosX, Float:prentPosY, Float:prentPosZ;

    if (GetPlayerPos(plrID, prentPosX, prentPosY, prentPosZ)) {
        for (new i; i != MAX_RENT_POINT; i ++) if (!RentPoint[i][rentExists]) {

            put->rentExists(i, true);
            put->rentPosX(i, prentPosX);
            put->rentPosY(i, prentPosY);
            put->rentPosZ(i, prentPosZ);

            //RentPoint[i][rentIcon] = 1239;
            new 
                rentQuery[64];

            fmt->rentQuery("INSERT INTO TABLE `RentPoint` (`PosX`, `PosY`, `PosZ`) VALUES (0.0, 0.0, 0.0)");
            exec->rentQuery("OnRentPointCreated", "i", i);

            refresh->Rent(i);
            return i;
        }
    }
    return -1;
}

Dialog:RentCar(playerid, response, listitem, inputtext[]) {
    if (!response) {
        SetPVarInt(playerid, "holdingRentID", 0);
        SetPVarInt(playerid, "holdingSelectedItem", 0);
        return 0;
    }

    new 
        selectedRentID = GetPVarInt(playerid, "holdingRentID");

    SetPVarInt(playerid, "holdingSelectedItem", listitem);
    Dialog_Show(playerid, RentConfirm, DIALOG_STYLE_INPUT, "Sewa Kendaraan", "Tolong masukkan berapa jam anda ingin menyewa kendaraan %s", "Oke", "Cancel", GetVehicleNameByModel(RentPoint[selectedRentID][rentList][listitem]));
    return 1;
}

Dialog:RentConfirm(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new
            value = strval(inputtext)
        ;

        SetPVarInt(playerid, "Rent_Time", value);
        Dialog_Show(playerid, RentVehicle, DIALOG_STYLE_MSGBOX, "Rental Kendaraan", WHITE"Apakah anda akan menyewa kendaran selama "YELLOW"%d jam\n\n"WHITE"Jumlah tagihan: "GREEN"%s.", "Ya", "Tidak", value, FormatNumber((value*(RentPoint[GetPVarInt(playerid, "holdingRentID")][rentPrice][GetPVarInt(playerid, "holdingSelectedItem")]))));
    }
    else {
        Dialog_Show(playerid, RentConfirm, DIALOG_STYLE_INPUT, "Sewa Kendaraan", "Tolong masukkan berapa jam anda ingin menyewa kendaraan %s", "Oke", "Cancel", GetVehicleNameByModel(RentPoint[GetPVarInt(playerid, "holdingRentID")][rentList][GetPVarInt(playerid, "holdingSelectedItem")]));
    }
    return 1;
}

Dialog:RentVehicle(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        static 
            time,
            selectedItem,
            prices;

        selectedItem = GetPVarInt(playerid, "holdingSelectedItem");
        prices = (RentPoint[GetPVarInt(playerid, "holdingRentID")][rentPrice][selectedItem]*time);
        time = GetPVarInt(playerid, "Rent_Time");

        if(GetMoney(playerid) < prices)
        {
            SendErrorMessage(playerid, "Uang Anda tidak cukup untuk menyewa kendaraan ini.");
            return GiveRentalMenu(playerid, GetPVarInt(playerid, "holdingRentID"));
        }

        static
            Float:x,
            Float:y,
            Float:z,
            Float:angle,
            modelid,
            id = -1,
            count;

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);

        modelid = RentPoint[GetPVarInt(playerid, "holdingRentID")][rentList][selectedItem];

        id = Vehicle_Create(0, modelid, x, y, z, angle, random(255), random(255), 0, "{000000}RENTAL");

        if(id == -1)
            return SendErrorMessage(playerid, "The server has reached the limit for dynamic vehicles.");
        
        DeletePVar(playerid, "Rent_Time");
        VehicleData[id][cRentTime] = (3600*time);
        VehicleData[id][cRentOwned] = PlayerData[playerid][pID];

        PutPlayerInVehicle(playerid, VehicleData[id][cVehicle], 0);

        GiveMoney(playerid, -(prices*time), ECONOMY_ADD_SUPPLY, "rent vehicle");

        Vehicle_Save(id);

        SendServerMessage(playerid,"Anda telah menyewa kendaraan "CYAN"%s"WHITE" dengan jangkan waktu "YELLOW"%d jam.", GetVehicleNameByVehicle(VehicleData[id][cVehicle]), time);
        SendServerMessage(playerid,"Anda di perbolehkan menggunakan perintah "YELLOW"/v engine "WHITE"dan "YELLOW"/v lock");
        SendServerMessage(playerid,"Jika kendaraan sewa meledak, kendaraan akan otomatis hilang dan anda harus menyewa kendaraan baru lagi");
    }
    else {
        Dialog_Show(playerid, RentConfirm, DIALOG_STYLE_MSGBOX, "Sewa Kendaraan", "Tolong masukkan berapa jam anda ingin menyewa kendaraan %s", "Oke", "Cancel ya mas", GetVehicleNameByModel(RentPoint[GetPVarInt(playerid, "holdingRentID")][rentList][GetPVarInt(playerid, "holdingSelectedItem")]));
    }
    return 1;
}


Function: OnRentPointCreated(rentid) {
    put->rentID(rentid, cache_insert_id());
    save->Rent(rentid);
    return 1;
}

static Refresh_RentPoint(rentid) {

    if (!get->rentExists(rentid))
        return -1;


    if (IsValidDynamicPickup(get->rentObj(rentid)))
        DestroyDynamicPickup(get->rentObj(rentid));

    if (IsValidDynamic3DTextLabel(get->rentText(rentid)))
        DestroyDynamic3DTextLabel(get->rentText(rentid));

    new 
        rentFmt[64];


    fmt->rentFmt("[ID:%d] Rent Vehicle\nType "YELLOW"\"/rentveh\""WHITE" for rent your own vehicle!", rentid);
    put->rentText(rentid, CreateDynamic3DTextLabel(rentFmt, COLOR_WHITE, get->rentPosX(rentid), get->rentPosY(rentid), get->rentPosZ(rentid), 15.0));
    put->rentObj(rentid, CreateDynamicMapIcon(get->rentPosX(rentid), get->rentPosY(rentid), get->rentPosZ(rentid), 0, COLOR_WHITE));
    return 1;
}

static Save_RentPoint(rentid) {
    new 
        rentQuery[64];

    if (!get->rentExists(rentid))
        return -1;

    format(rentQuery, sizeof(rentQuery), "UPDATE `RentPoint` SET `PosX` = '%.4f', `PosY` = '%.4f', `PosZ` = '%.4f'",
        get->rentPosX(rentid),
        get->rentPosY(rentid),
        get->rentPosZ(rentid)
    );

    for (new i; i < MAX_RENT_POINT; i ++) {
        format(rentQuery, sizeof(rentQuery), "%s, `RentList_%d` = '%d', `RentPrice` = '%d'", rentQuery, i, RentPoint[rentid][rentList][i], i, RentPoint[rentid][rentPrice][i]);
    }

    format(rentQuery, sizeof(rentQuery), "%s WHERE `ID` = '%d'", 
        get->rentID(rentid)
    );
    mysql_query(g_iHandle, rentQuery, false);
    return 1;
}

static Delete_RentPoint(rentid) {
    new 
        rentQuery[64];

    if (!get->rentExists(rentid))
        return -1;

    if (IsValidDynamicPickup(get->rentObj(rentid)))
        DestroyDynamicPickup(get->rentObj(rentid));

    if (IsValidDynamic3DTextLabel(get->rentText(rentid)))
        DestroyDynamic3DTextLabel(get->rentText(rentid));

    fmt->rentQuery("DELETE FROM `RentPoint` WHERE `ID` = '%d", get->rentID(rentid));
    mysql_query(g_iHandle, rentQuery, false);

    new dummyOnDummy[rentPoint];
    RentPoint[rentid] = dummyOnDummy;

    put->rentExists(rentid, false);
    return 1;
}

GetNearestRentalPoint(playerid) {
    for (new i;  i < MAX_RENT_POINT; i ++) if (get->rentExists(i)) {
        if (IsPlayerInRangeOfPoint(playerid, 8.0, get->rentPosX(i), get->rentPosY(i), get->rentPosZ(i)))
            return i;
    }
    return -1;
}