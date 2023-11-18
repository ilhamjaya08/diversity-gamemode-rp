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