#define TIME_TO_NEXT_CHECK              (30)
#define MAXIMUM_REPORTED_CHEAT          (5)

#include <YSI\y_hooks>
#include <YSI\y_iterate>

new 
    airbreak_anticheat[MAX_PLAYERS],
    vehairbreak_anticheat[MAX_PLAYERS],
    teleport_anticheat[MAX_PLAYERS],
    vehteleport_anticheat[MAX_PLAYERS],
    vehhealthhack_anticheat[MAX_PLAYERS],
    healthhack_anticheat[MAX_PLAYERS],
    flyhack_anticheat[MAX_PLAYERS],
    vehflyhack_anticheat[MAX_PLAYERS],
    armourhack_anticheat[MAX_PLAYERS],
    //
    tele_pickup_ac[MAX_PLAYERS],
    tele_pickup_ac_report_time[MAX_PLAYERS]
;

Anticheat_GetReportAmount(playerid, code)
{
    if (code == 6)
    {
        return tele_pickup_ac[playerid];
    }

    return 0;
}

bool:Anticheat_IsReportTimeExpired(playerid, code)
{
    new now = GetTickCount();

    if (code == 6)
    {
        return (tele_pickup_ac_report_time[playerid] <= now);
    }

    return true;
}

Anticheat_IncreaseReport(playerid, code, amount = 1)
{
    if (code == 6)
    {
        tele_pickup_ac[playerid] += amount;
    }

    return 1;
}

Anticheat_SetReport(playerid, code, value)
{
    if (code == 6)
    {
        tele_pickup_ac[playerid] = value;
    }

    return 1;
}

Anticheat_ReduceReport(playerid, code, amount = 1)
{
    if (code == 6)
    {
        new new_value = tele_pickup_ac[playerid] - amount;

        if (new_value < 0)
        {
            tele_pickup_ac[playerid] = 0;
        }
        else
        {
            tele_pickup_ac[playerid] = new_value;
        }
    }

    return 1;
}

Anticheat_SetReportTime(playerid, code, time)
{
    if (code == 6)
    {
        tele_pickup_ac_report_time[playerid] = time;
    }

    return 1;
}

Anticheat_IncreaseReportTime(playerid, code, time = TIME_TO_NEXT_CHECK)
{
    new now = GetTickCount();

    if (code == 6)
    {
        tele_pickup_ac_report_time[playerid] = now + (1000 * time);
    }

    return 1;
}

Anticheat_ResetReport(playerid, code)
{
    if (code == 6)
    {
        Anticheat_SetReport(playerid, code, 0);
        Anticheat_SetReportTime(playerid, code, 0);
    }
}

task Anticheat_ResetReportCount[1000]()
{
    foreach(new playerid : Player)
    {
        if ((Anticheat_GetReportAmount(playerid, 6) > 0) && Anticheat_IsReportTimeExpired(playerid, 6))
        {
            Anticheat_ReduceReport(playerid, 6);
            Anticheat_IncreaseReportTime(playerid, 6);
        }
    }

    return 1;
}

hook OnPlayerConnect(playerid)
{
    airbreak_anticheat{playerid} = 0;
    vehairbreak_anticheat{playerid} = 0;
    teleport_anticheat{playerid} = 0;
    vehteleport_anticheat{playerid} = 0;
    vehhealthhack_anticheat{playerid} = 0;
    healthhack_anticheat{playerid} = 0;
    flyhack_anticheat{playerid} = 0;
    vehflyhack_anticheat{playerid} = 0;
    armourhack_anticheat{playerid} = 0;
    Anticheat_ResetReport(playerid, 6);
}

forward RestoreHealth(playerid, Float:health);
forward RestoreArmour(playerid, Float:armour);
forward OnCheatDetected(playerid, ip_address[], type, code);


public OnCheatDetected(playerid, ip_address[], type, code)
{
    if(!IsPlayerConnected(playerid))
        return 0;

    switch(code)
    {
        case 0: {
            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible onfoot airbreak hack.", ReturnName(playerid));
        }
        case 1: {
            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible vehicle airbreak hack.", ReturnName(playerid));
        }
        case 2: {
            new Float:x, Float:y, Float:z;
            new vw, int;
            AntiCheatGetPos(playerid, x, y, z);
            int = GetPlayerInterior(playerid); 
            vw = GetPlayerVirtualWorld(playerid);
            SetPlayerPos(playerid, x, y, z);
            SetPlayerVirtualWorld(playerid, vw);
            SetPlayerInterior(playerid, int);

            if(teleport_anticheat{playerid}++ > 2) 
            {
                PlayerData[playerid][pInterior] = int;
                PlayerData[playerid][pWorld] = vw;
                //SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: Teleport Hack", ReturnName(playerid));
            }
            else 
            {
                if(IsCookingDrug(playerid))
                {
                    Cooking_Reset(playerid);
                    SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible teleport hack while cooking drugs!!!!!.", ReturnName(playerid));
                }
                SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible teleport hack.", ReturnName(playerid));
            }
        }
        case 3: {
            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible vehicle teleport hack.", ReturnName(playerid));
        }
        case 4: SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s have been kicked by BOT for: wrap vehicle hack.", ReturnName(playerid));
        case 5: SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible vehicle teleport to player hack.", ReturnName(playerid));
        case 6: {
            Anticheat_IncreaseReportTime(playerid, code);
            Anticheat_IncreaseReport(playerid, code);
            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible teleport to pickup hack. (%d/%d)", ReturnName(playerid), Anticheat_GetReportAmount(playerid, code), MAXIMUM_REPORTED_CHEAT);
        }
        case 7: {
            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible fly hack.", ReturnName(playerid));
        }    
        case 8: {
           SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible vehicle fly hack.", ReturnName(playerid));
        }
        case 10: SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s have been kicked by BOT for: vehicle speed hack.", ReturnName(playerid));
        case 11: 
        {
            new Float:health;
            AntiCheatGetVehicleHealth(AntiCheatGetVehicleID(playerid), health);
            SetVehicleHealth(AntiCheatGetVehicleID(playerid), health);

            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible vehicle health hack.", ReturnName(playerid));
        }
        case 12: 
        {
            new Float:health;
            AntiCheatGetHealth(playerid, health);
            SetTimerEx("RestoreHealth", 10, 0, "df", playerid, health);

            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible health hack.", ReturnName(playerid));
        }
        case 13: 
        {
            new Float:armor;
            AntiCheatGetArmour(playerid, armor);
            SetTimerEx("RestoreArmour", 10, 0, "df", playerid, armor);

            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible armour hack.", ReturnName(playerid));
        }//MarkhereAC
        case 15: SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s have been kicked by BOT for: weapon hack.", ReturnName(playerid)), KickEx(playerid);
        case 16: SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s have been kicked by BOT for: add ammo hack.", ReturnName(playerid)), KickEx(playerid);
        case 17: SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s have been kicked by BOT for: infinite ammo hack.", ReturnName(playerid)), KickEx(playerid);
        case 18: SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s possible using special animations hack.", ReturnName(playerid));

        default: 
        {
            new Float:x, Float:y, Float:z;
            new vw, int;
            //ngesave VW dan Interior
            //Masuk ke bank > set pos interior bank > anticheatgetpos(last position) > setplayerpos ke last position yang di get anti cheat, tapi tidak di set vw dan interior. 
            //bisa kena anti cheat karena jarak perpindahan dari luar ke dalam terlalu jauh
            AntiCheatGetPos(playerid, x, y, z);
            int = GetPlayerInterior(playerid);
            vw = GetPlayerVirtualWorld(playerid);
            SetPlayerVirtualWorld(playerid, vw);
            SetPlayerInterior(playerid, int);
            SetPlayerPos(playerid, x, y, z);


            AntiCheatKickWithDesync(playerid, code);
            SendAdminMessage(X11_LIGHTSKYBLUE1, "Anticheat: %s (%s) type: %d code %d", ReturnName(playerid), ip_address, type, code);
        }
    }    
    return 1;
}

public RestoreHealth(playerid, Float:health)
{
    if(IsPlayerConnected(playerid))
        SetPlayerHealth(playerid, health);
}

public RestoreArmour(playerid, Float:armour)
{
    if(IsPlayerConnected(playerid))
        SetPlayerArmour(playerid, armour);
}