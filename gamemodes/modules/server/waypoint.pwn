/*
    Script description.

    Module name: waypoint.pwn
    Made by: Agus Syahputra.
    Date: 02/02/18 - 18:01
*/

// ------------------------------------------------------------------------------

#include <YSI\y_hooks>


new 
    recentWaypoint[MAX_PLAYERS],
    playerWaypoint[MAX_PLAYERS],
    waypointName[MAX_PLAYERS][24],
    Float:waypointLoc[MAX_PLAYERS][3],
    PlayerText:waypointTD[MAX_PLAYERS][2];


IsPlayerShowWaypoint(playerid)
    return playerWaypoint[playerid];


SetPlayerWaypoint(playerid, const name[], Float:x, Float:y, Float:z)
{
    format(waypointName[playerid], 24, name);

    waypointLoc[playerid][0] = x;
    waypointLoc[playerid][1] = y;
    waypointLoc[playerid][2] = z;

    PlayerTextDrawSetString(playerid, waypointTD[playerid][1], "Tracking ...");

    if(!playerWaypoint[playerid]) {
        PlayerTextDrawShow(playerid, waypointTD[playerid][0]);
        PlayerTextDrawShow(playerid, waypointTD[playerid][1]);
    }

    playerWaypoint[playerid] = true;

    SetPlayerRaceCheckpoint(playerid, 1, x, y, z, -1, -1, -1, 3);
    ShowPlayerFooter(playerid, "Gunakan ~r~/disablecp ~w~untuk menghilangkan checkpoint");
    return 1;
}

DisableWaypoint(playerid)
{
    if(IsPlayerShowWaypoint(playerid))
    {
        playerWaypoint[playerid] = false;

        DisablePlayerRaceCheckpoint(playerid);

        PlayerTextDrawHide(playerid, waypointTD[playerid][0]);
        PlayerTextDrawHide(playerid, waypointTD[playerid][1]);
    }
    return 1;
}

GetRecentWaypoint(playerid)
{
    return recentWaypoint[playerid];
}

IsPlayerWaypointRecentlyShow(playerid)
{
    return ((gettime() - GetRecentWaypoint(playerid)) < 4);
}

ResetRecentWaypoint(playerid)
{
    recentWaypoint[playerid] = 0;
}

UpdateRecentWaypoint(playerid)
{
    recentWaypoint[playerid] = gettime();
}


hook OnPlayerDisconnect(playerid, reason)
{
    DisableWaypoint(playerid);
    waypointTD[playerid][0] = waypointTD[playerid][1] = PlayerText:INVALID_TEXT_DRAW;
    ResetRecentWaypoint(playerid);
}

hook OnPlayerEnterRaceCP(playerid)
{
    if(IsPlayerShowWaypoint(playerid))
    {
        DisableWaypoint(playerid);
        UpdateRecentWaypoint(playerid);
        GameTextForPlayer(playerid, "~b~~h~You are now arrived!", 1500, 3);
    }
}

hook OnPlayerLogin(playerid)
{
    SetPVarInt(playerid, "TogglePhone", 1);

    if (!Inventory_HasItem(playerid, "Cellphone"))
    {
        TogglePhone(playerid);
    }

    waypointTD[playerid][0] = CreatePlayerTextDraw(playerid, 34.299453, 363.551025, "hud:radarRingPlane");
    PlayerTextDrawLetterSize(playerid, waypointTD[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, waypointTD[playerid][0], 105.000000, 59.000000);
    PlayerTextDrawAlignment(playerid, waypointTD[playerid][0], 1);
    PlayerTextDrawColor(playerid, waypointTD[playerid][0], 127);
    PlayerTextDrawSetShadow(playerid, waypointTD[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, waypointTD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, waypointTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, waypointTD[playerid][0], 4);
    PlayerTextDrawSetProportional(playerid, waypointTD[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, waypointTD[playerid][0], 0);
    PlayerTextDrawUseBox(playerid, waypointTD[playerid][0], 0);

    waypointTD[playerid][1] = CreatePlayerTextDraw(playerid, 86.500000, 396.937500, "Tracking ...");
    PlayerTextDrawLetterSize(playerid, waypointTD[playerid][1], 0.140999, 0.847500);
    PlayerTextDrawAlignment(playerid, waypointTD[playerid][1], 2);
    PlayerTextDrawColor(playerid, waypointTD[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, waypointTD[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, waypointTD[playerid][1], 1);
    PlayerTextDrawBackgroundColor(playerid, waypointTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, waypointTD[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, waypointTD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, waypointTD[playerid][1], 0);
    PlayerTextDrawUseBox(playerid, waypointTD[playerid][0], 0);
}


ptask Player_WayPointUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
        
    if(IsPlayerShowWaypoint(playerid))
    {
        PlayerTextDrawSetString(playerid, waypointTD[playerid][1], sprintf("%s~n~Jarak: %.1fm", waypointName[playerid], GetPlayerDistanceFromPoint(playerid, waypointLoc[playerid][0], waypointLoc[playerid][1], waypointLoc[playerid][2])));
    }
    return 1;
}