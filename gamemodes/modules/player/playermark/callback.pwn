#include <YSI\y_hooks>

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{

    if(GetPlayerWayPointStatus(playerid))
    {
        RemovePlayerMapIcon(playerid, 20);
        // RemoveDriverMarkerPoint(playerid);
        // SetPlayerWayPointStatus(playerid, false);
    }

    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        SetDriverMarkerPoint(playerid, fX, fY, fZ);
    }
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);
	
    new vehicleid = GetPlayerVehicleID(playerid);
    if(vehicleid > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
            SetVehiclePos(vehicleid, fX, fY, fZ+10);
    }
    else
    {
            SetPlayerPosFindZ(playerid, fX, fY, 999.0);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
    }
    SendClientMessage(playerid, -1, "Kamu Telah Berhasil Teleport Ke Marker Di Peta di peta..");
	
    return 1;
}

hook OnPlayerConnect(playerid)
{
    playerWayPoint[playerid] = false;
}

hook OnPlayerDisconnect(playerid, reason)
{
    playerWayPoint[playerid] = false;
}