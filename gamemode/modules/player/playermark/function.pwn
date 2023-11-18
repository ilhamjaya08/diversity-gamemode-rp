GetPlayerWayPointStatus(playerid)
{
    return playerWayPoint[playerid];
}

SetPlayerWayPointStatus(playerid, bool:status)
{
    if(IsPlayerConnected(playerid) && IsPlayerSpawned(playerid))
    {
        playerWayPoint[playerid] = status;
    }
    return 1;
}
stock RemoveDriverMarkerPoint(playerid)
{
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        new driverid = GetVehicleDriverID(GetPlayerVehicleID(playerid)),
            string[1024];
        if(driverid != INVALID_PLAYER_ID && GetPlayerWayPointStatus(driverid))
        {
            RemovePlayerMapIcon(driverid, 20);
            format(string, sizeof(string), "~r~%s~w~ has ~r~remove ~w~their waypoint!", ReturnName(playerid));
            ShowPlayerFooter(driverid, string);
            SetPlayerWayPointStatus(driverid, false);
        }
    }
    return 1;
}

SetDriverMarkerPoint(playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        new driverid = GetVehicleDriverID(GetPlayerVehicleID(playerid)),
            string[1024];
        if(driverid != INVALID_PLAYER_ID)
        {
            SetPlayerMapIcon(driverid, 20, x, y, z, 41, 0, MAPICON_GLOBAL);
            format(string, sizeof(string), "~r~%s~w~ has set their waypoint, check your ~g~GPS!", ReturnName(playerid));
            ShowPlayerFooter(driverid, string);
            SendServerMessage(driverid, "Right click pada map untuk menghilangkan waypoint yang aktif!");
            SetPlayerWayPointStatus(driverid, true);
        }
    }
    return 1;
}