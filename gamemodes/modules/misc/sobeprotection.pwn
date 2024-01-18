#include <YSI\y_hooks>

hook OnGameModeInit()
{
    MapAndreas_Init(MAP_ANDREAS_MODE_FULL, "scriptfiles/SAFull.hmap");
    return 1;
}

new VehicleDestroyed = 136;
IRPC:VehicleDestroyed(playerid, BitStream:bs)
{
    new vehicleid;

    BS_ReadUint16(bs, vehicleid);

    if (GetVehicleModel(vehicleid) < 400)
    {
        SendAdminMessage(X11_DARKORANGE, "Anticheat debug: RPC VehicleDestroyed detected. Player: (%d) %s | vehicleid: %d", playerid, ReturnName(playerid), vehicleid);
        Log_Save(E_LOG_CHEAT, sprintf("[%s] %s has try to destroy the vehicle (id: %d) with some hacks.", ReturnDate(), ReturnName(playerid, 0), vehicleid));
        return 0;
    }

    return OnVehicleRequestDeath(vehicleid, playerid);
}

forward OnVehicleRequestDeath(vehicleid, killerid);
public OnVehicleRequestDeath(vehicleid, killerid)
{
    new Float:X, Float:Y, Float:Z, Float:health;
    GetVehiclePos(vehicleid, X, Y, Z);
    MapAndreas_FindZ_For2DCoord(X, Y, Z);
    GetVehicleHealth(vehicleid, health);
    
    printf("RPC OnVehicleRequestDeath detected. Killer: (%d) %s | vehicleid: %d | Z: %.2f | health: %.2f", killerid, killerid != INVALID_PLAYER_ID ? ReturnName(killerid) : "(Unknown)", vehicleid, Z, health);
    SendAdminMessage(X11_DARKORANGE, "Anticheat debug: (%d) %s just trying to kill the vehicle id %d. Extra info -> X: %.2f | Y: %.2f | Z: %.2f | health: %.2f", killerid, killerid != INVALID_PLAYER_ID ? ReturnName(killerid) : "(Unknown)", vehicleid, X, Y, Z, health);
    Log_Save(E_LOG_CHEAT, sprintf("[%s] %s has try to destroy the vehicle (id: %d) with some hacks.", ReturnDate(), ReturnName(killerid, 0), vehicleid));

    // If car above the water MapAndreas return a height 0.0
    if (health >= 250.0 && Z != 0.0)
    {
        SendAdminMessage(X11_DARKORANGE, "Anticheat debug: (%d) %s just trying to kill the vehicle id %d. Extra info -> X: %.2f | Y: %.2f | Z: %.2f | health: %.2f", killerid, killerid != INVALID_PLAYER_ID ? ReturnName(killerid) : "(Unknown)", vehicleid, X, Y, Z, health);
        Log_Save(E_LOG_CHEAT, sprintf("[%s] %s has try to destroy the vehicle (id: %d) with some hacks.", ReturnDate(), ReturnName(killerid, 0), vehicleid));
        printf("RPC OnVehicleRequestDeath detected. Killer: (%d) %s | vehicleid: %d | Z: %.2f | health: %.2f", killerid, killerid != INVALID_PLAYER_ID ? ReturnName(killerid) : "(Unknown)", vehicleid, Z, health);
        return 0;
    }

    return 1;
}