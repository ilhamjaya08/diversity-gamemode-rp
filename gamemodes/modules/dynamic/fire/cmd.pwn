CMD:explode(playerid, params[])
{
    new userid;

    if (CheckAdmin(playerid, 6))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/explode [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    new Float:x, Float:y, Float:z, vw, int;
    GetPlayerPos(userid, x, y, z);
    vw = GetPlayerVirtualWorld(userid);
    int = GetPlayerInterior(userid);
    SetHealth(userid, 0);
    CreateExplosionEx(x, y, z);
    Fire_Create(18690, x, y, z, int, vw);
    return 1;
}
CMD:nearestfire(playerid, params[])
{
    if (CheckAdmin(playerid, 3))
        return PermissionError(playerid);

    new
        id = -1;

    if((id = Fire_Nearest(playerid)) != -1) SendServerMessage(playerid, "You are standing near fire "YELLOW"ID: %d.", id);
    else SendServerMessage(playerid, "Kamu tidak berada didekat api apapun!");
    return 1;
}

CMD:destroyfire(playerid, params[])
{
    static
        id
    ;

    if (CheckAdmin(playerid, 7))
        return PermissionError(playerid);

    if(sscanf(params, "d", id))
       return SendSyntaxMessage(playerid, "/destroyfire [fireid]");

    if(!Fire_IsExists(id))
        return SendErrorMessage(playerid, "ID Fire yang kamu input tidak terdaftar!");

    Fire_Delete(id);
    SendServerMessage(playerid, "You remove fire id %d", id);
    return 1;
}