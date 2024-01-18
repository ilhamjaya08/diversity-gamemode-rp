Function:OnClothesStore(houseid, slot)
{
    ClothesData[houseid][slot][clothesID] = cache_insert_id();
    Clothes_Save(houseid, slot);
    return 1;
}

Function:OnLoadClothes(houseid)
{
    static
        rows,
        fields;

    cache_get_data(rows, fields);

    for (new i = 0; i != rows; i ++) 
    {
        ClothesData[houseid][i][clothesID] = cache_get_field_int(i, "ID");
        cache_get_field_content(i, "clothesName", ClothesData[houseid][i][clothesName], 32);
        ClothesData[houseid][i][clothesModel]    = cache_get_field_int(i, "clothesModel");
        ClothesData[houseid][i][clothesExists] = 1;
    }
    return 1;
}

Function:OnAccesoriesStore(houseid, slot)
{
    AccesoriesData[houseid][slot][accID] = cache_insert_id();
    Accesories_Save(houseid, slot);
    return 1;
}

Function:OnLoadAccesories(houseid)
{
    static
        rows,
        fields;

    cache_get_data(rows, fields);

    for (new i = 0; i != rows; i ++) 
    {
        AccesoriesData[houseid][i][accID] = cache_get_field_int(i, "ID");
        cache_get_field_content(i, "accName", AccesoriesData[houseid][i][accName], 32);
        AccesoriesData[houseid][i][accModel]    = cache_get_field_int(i, "accModel");
        AccesoriesData[houseid][i][accExists] = 1;
    }
    return 1;
}


Clothes_Save(houseid, slot)
{
    new query[355];
    format(query, sizeof(query), "UPDATE `clothes_wardrobe` SET `houseid` = '%d', `clothesModel` = '%d', `clothesName` = '%s' WHERE `ID` = '%d'",
    HouseData[houseid][houseID],
    ClothesData[houseid][slot][clothesModel],
    SQL_ReturnEscaped(ClothesData[houseid][slot][clothesName]),
    ClothesData[houseid][slot][clothesID]
    );
    mysql_tquery(g_iHandle, query);
}

Accesories_Save(houseid, slot)
{
    new query[355];
    format(query, sizeof(query), "UPDATE `accesories_wardrobe` SET `houseid` = '%d', `accModel` = '%d', `accName` = '%s' WHERE `ID` = '%d'",
    HouseData[houseid][houseID],
    AccesoriesData[houseid][slot][accModel],
    SQL_ReturnEscaped(AccesoriesData[houseid][slot][accName]),
    AccesoriesData[houseid][slot][accID]
    );
    mysql_tquery(g_iHandle, query);
}

ShowHouseWardrobe(playerid, houseid)
{
    SetPVarInt(playerid, "WardrobeHouseID", houseid);
    Dialog_Show(playerid, WARDROBEMENU, DIALOG_STYLE_LIST, "House Wardrobe", "Clothes Wardrobe\nAccesories Wardrobe", "Select", "Close");
    return 1;
}

ShowClothesWardrobe(playerid, houseid)
{
    new string[1024];
    strcat(string, "Model\tClothes Name\n");
    for(new i=0; i<MAX_CLOTHES_WARDROBE; i++)
    {
        if(ClothesData[houseid][i][clothesExists])
        {
            strcat(string, sprintf("%d\t%s\n", ClothesData[houseid][i][clothesModel], ClothesData[houseid][i][clothesName]));            
        }
        else
        {
            strcat(string, "None\t \n");
        }
    }
    Dialog_Show(playerid, WARDROBE_CLOTHES, DIALOG_STYLE_TABLIST_HEADERS, "Clothes Wardrobe", string, "Select", "Close");
    return 1;
}


ShowAccesoriesWardrobe(playerid, houseid)
{
    new 
        string[1024]
    ;
    strcat(string, "Model\tAccesories Name\n");
    for(new i=0; i<MAX_ACCESORIES_WARDROBE; i++)
    {
        if(AccesoriesData[houseid][i][accExists])
        {
            strcat(string, sprintf("%d\t%s\n", AccesoriesData[houseid][i][accModel], AccesoriesData[houseid][i][accName]));
        }
        else
        {
            strcat(string, "None\t \n");
        }
    }
    Dialog_Show(playerid, WARDROBE_ACCESORIES, DIALOG_STYLE_TABLIST_HEADERS, "Accesories Wardrobe", string, "Select", "Close");
    return 1;
}
IsSameClothesInWardrobe(playerid, houseid)
{
    for(new i=0; i<MAX_ACCESORIES_WARDROBE; i++)
    {
        if(GetPlayerSkin(playerid) == ClothesData[houseid][i][clothesModel])
            return 1;
    }
    return 0;
}

DepositClothes(playerid, houseid, slot, inputtext[])
{
    if(IsSameClothesInWardrobe(playerid, houseid))
        return SendErrorMessage(playerid, "You already have this type of clothes inside your wardrobe");

    new query[355];
    ClothesData[houseid][slot][clothesExists] = 1;
    ClothesData[houseid][slot][clothesModel] = GetPlayerSkin(playerid);
    format(ClothesData[houseid][slot][clothesName], 32, "%s", inputtext);

    format(query,sizeof(query),"INSERT INTO `clothes_wardrobe` (`houseid`) VALUES (%d)", HouseData[houseid][houseID]);
    mysql_tquery(g_iHandle, query, "OnClothesStore", "dd", houseid, slot);

    SendServerMessage(playerid, "You store you %s clothes into wardrobe", ClothesData[houseid][slot][clothesName]);
    return 1;
}

WithdrawClothes(playerid, houseid, slot)
{
    new tempSkin;
    tempSkin = GetPlayerSkin(playerid);
    SetPlayerSkinEx(playerid, ClothesData[houseid][slot][clothesModel]);
    ClothesData[houseid][slot][clothesModel] = tempSkin;
    Clothes_Save(houseid, slot);
    // format(string,sizeof(string),"DELETE FROM `clothes_wardrobe` WHERE `ID`='%d'", ClothesData[houseid][slot][clothesID]);
    // mysql_tquery(g_iHandle, string);
    return 1;
}

RemoveClothes(houseid, slot)
{
    new string[255];
    ClothesData[houseid][slot][clothesExists] = 0;
    ClothesData[houseid][slot][clothesModel] = INVALID_SKIN_ID;
    format(ClothesData[houseid][slot][clothesName], 6, "");

    format(string,sizeof(string),"DELETE FROM `clothes_wardrobe` WHERE `ID`='%d'", ClothesData[houseid][slot][clothesID]);
    mysql_tquery(g_iHandle, string);
    return 1;
}

RemoveAccesories(houseid, slot)
{
    new string[255];
    AccesoriesData[houseid][slot][accExists] = 0;
    AccesoriesData[houseid][slot][accModel] = INVALID_SKIN_ID;
    format(AccesoriesData[houseid][slot][accName], 6, "");

    format(string,sizeof(string),"DELETE FROM `accesories_wardrobe` WHERE `ID`='%d'", AccesoriesData[houseid][slot][accID]);
    mysql_tquery(g_iHandle, string);
    return 1;
}

DepositAccesories(playerid, houseid, slot, accid)
{
    new string[128], query[355];
    if(IsPlayerAttachedObjectSlotUsed(playerid, accid))
    {
        RemovePlayerAttachedObject(playerid, accid);
        AccData[playerid][accid][accShow] = 0;
    }
    format(string,sizeof(string),"DELETE FROM `aksesoris` WHERE `ID`='%d'", AccData[playerid][accid][accID]);
    mysql_tquery(g_iHandle, string);

    AccesoriesData[houseid][slot][accExists] = 1;
    AccesoriesData[houseid][slot][accModel] = AccData[playerid][accid][accModel]; //Belom di set.
    format(AccesoriesData[houseid][slot][accName], 32, "%s", AccData[playerid][accid][accName]);

    AccData[playerid][accid][accExists] = 0;
    AccData[playerid][accid][accModel] = 0;

    format(query,sizeof(query),"INSERT INTO `accesories_wardrobe` (`houseid`) VALUES (%d)", HouseData[houseid][houseID]);
    mysql_tquery(g_iHandle, query, "OnAccesoriesStore", "dd", houseid, slot);


    Aksesoris_Save(playerid, accid);
    SendServerMessage(playerid, "You store you %s acc into wardrobe", AccesoriesData[houseid][slot][accName]);
    return 1;
}

WithdrawAccesories(playerid, houseid, slot)
{
    new query[355];
    if(Aksesoris_GetCount(playerid) > MAX_ACC)
    {
        return SendErrorMessage(playerid, "Slot untuk aksesoris sudah penuh.");
    }
    new string[128];
    for (new i = 0; i != MAX_ACC; i++)
    { 
        if(!AccData[playerid][i][accExists]) 
        {
            AccData[playerid][i][accExists] = 1;

            format(AccData[playerid][i][accName], 32, AccesoriesData[houseid][slot][accName]);

            AccData[playerid][i][accModel] = AccesoriesData[houseid][slot][accModel];

            AccData[playerid][i][accBone] = 1;

            PlayerData[playerid][pAksesoris] = i;
            AccData[playerid][i][accColor1][0] = AccData[playerid][i][accColor1][1] = AccData[playerid][i][accColor1][2] = 255;
            AccData[playerid][i][accColor2][0] = AccData[playerid][i][accColor2][1] = AccData[playerid][i][accColor2][2] = 255;

            AccData[playerid][i][accScale][0] = AccData[playerid][i][accScale][1] = AccData[playerid][i][accScale][2] = 1.0;

            format(AccesoriesData[houseid][slot][accName], 6, "");
            AccesoriesData[houseid][slot][accModel] = INVALID_MODEL_ID;
            AccesoriesData[houseid][slot][accExists] = 0;

            format(string,sizeof(string),"DELETE FROM `accesories_wardrobe` WHERE `ID`='%d'", AccesoriesData[houseid][slot][accID]);
            mysql_tquery(g_iHandle, string);

            format(query,sizeof(query),"INSERT INTO `aksesoris` (`accID`) VALUES (%d)", PlayerData[playerid][pID]);
            mysql_tquery(g_iHandle, query, "OnAksesorisCreated", "dd", playerid, i);
            return i;
        }
    }
    return 1;
}

OpenPlayerAccesories(playerid)
{
    new 
        string[355],
        count = 0
    ;
    
    format(string,sizeof(string),"Model\tName\n");
    for (new id = 0; id != MAX_ACC; id++)
    if(AccData[playerid][id][accExists])
    {
        format(string,sizeof(string),"%s%d\t%s\n", string, AccData[playerid][id][accModel], AccData[playerid][id][accName]);
        if (count < 4)
        {
            ListedAcc[playerid][count] = id;
            count = count + 1;
        }
    }
    if(!count) SendErrorMessage(playerid, "You don't have some accesories to store!");
    else Dialog_Show(playerid, WARDROBE_ACC_STORE2, DIALOG_STYLE_TABLIST_HEADERS, "Choose Accesories", string, "Select","Exit");
    return 1;
}