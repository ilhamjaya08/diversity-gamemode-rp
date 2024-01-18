CMD:createpump(playerid, params[])
{
    static id, bizid = -1;

    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    if(sscanf(params, "d", bizid))
        return SendSyntaxMessage(playerid, "/createpump [business id]");

    if((bizid < 0 || bizid >= MAX_BUSINESSES) || !BusinessData[bizid][bizExists])
        return SendErrorMessage(playerid, "Bisnis tidak terdaftar.");

    if(BusinessData[bizid][bizType] != 6)
        return SendErrorMessage(playerid, "Bisnis tersebut bukan tipe gas station!");

    if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
        return SendErrorMessage(playerid, "Set interior dan world mu ke 0 terlebih dahulu.");

    if((id = Pump_Create(playerid, bizid)) != -1) SendServerMessage(playerid, "Sukses membuat pompa bahan bakar dengan id: %d.", id);
    else SendErrorMessage(playerid, "Pompa bahan bakar sudah mencapai batas maksimal.");

    return 1;
}

CMD:destroypump(playerid, params[])
{
    static
        id = 0;

    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/destroypump [pump id]");

    if(!Pump_Exists(id))
        return SendErrorMessage(playerid, "Pompa bahan bakar tidak terdaftar.");

    Pump_Delete(id);
    SendServerMessage(playerid, "Berhasil menghapus pompa bahan bakar id: %d.", id);
    return 1;
}

CMD:setpump(playerid, params[])
{
    static
        id = 0,
        amount;

    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    if(sscanf(params, "dd", id, amount))
        return SendSyntaxMessage(playerid, "/setpump [pump id] [fuel amount]");

    if(!Pump_Exists(id))
        return SendErrorMessage(playerid, "Pompa bahan bakar tidak terdaftar.");

    PumpData[id][pumpFuel] = amount;

    Pump_Sync(id);
    Pump_Save(id, false);

    SendServerMessage(playerid, "Kamu telah mengubah kapasitas pompa bahan bakar id "YELLOW"%d "WHITE"menjadi "GREEN"%d.", id, amount);
    return 1;
}

CMD:editpump(playerid, params[])
{
    static
        id = 0;

    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/editpump [pump id]");

    if(!Pump_Exists(id))
        return SendErrorMessage(playerid, "Pompa bahan bakar tidak terdaftar.");

    if(Pump_Nearest(playerid, 5) != id)
        return SendErrorMessage(playerid, "Dekati pompa bahan bakar untuk merubah posisi");

    if(GetPVarInt(playerid, "EditingPump") != -1)
        return SendErrorMessage(playerid, "Kamu sedang mengedit posisi pompa bahan bakar!");

    SetPVarInt(playerid, "EditingPump", id);
    EditDynamicObject(playerid, PumpData[id][pumpObject]);
    SendServerMessage(playerid, "Posisikan pompa bahan bakar id "YELLOW"%d", id);
    return 1;
}