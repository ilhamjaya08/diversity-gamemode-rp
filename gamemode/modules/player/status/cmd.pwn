
CMD:damages(playerid, params[])
{
    new player;

    if(sscanf(params, "u", player))
    {
        return Damage_Show(playerid, playerid);
    }

    if(player == playerid) return SendErrorMessage(playerid, "Use command /damages to check your damages.");
    if(player == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, player, 3.0)) return SendErrorMessage(playerid, "That player is disconnected or not near you.");
    if(PlayerData[player][pSpectator] != INVALID_PLAYER_ID) return SendErrorMessage(playerid, "That player is disconnected or not near you.");

    SendServerMessage(player, "%s melihat kondisi karakter anda.", ReturnName(playerid, 0));
    SendServerMessage(playerid, "Anda melihat kondisi karakter %s.", ReturnName(player, 0));
    Damage_Show(playerid, player);
    return 1;
}

CMD:resetdamage(playerid, params[])
{
    new player;

    if (CheckAdmin(playerid, 4))
        return PermissionError(playerid);

    if(sscanf(params, "u", player))
        return SendSyntaxMessage(playerid, "/resetdamage [playerid/part of name]");

    if(!IsPlayerConnected(player))
        return SendErrorMessage(playerid, "That player isn't logged in.");

    Damage_Reset(player);
    SendServerMessage(player, "Admin %s telah mereset damage anda.", ReturnAdminName(playerid));
    SendAdminMessage(X11_TOMATO_1, "AdmWarn: %s reset %s damages.", ReturnName2(playerid),ReturnName2(player));
    return 1;
}


CMD:resetshooter(playerid, params[])
{
    static
        userid;

    if (CheckAdmin(playerid, 4))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/shooter [playerid/PartOfName]");
    if(userid == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "You have specified an invalid player.");

    for(new i = 0; i < 10; i++) {
        damageList[userid][i] = "None";
    }
    SendServerMessage(playerid, "Successfull reset shooter list for %s.", ReturnName(userid));
    return 1;
}