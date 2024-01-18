/*
	Nex-Ac anticheat callback
*/

#include <YSI\y_hooks>


static
    hack_health[MAX_PLAYERS] = {0, ...},
    hack_armour[MAX_PLAYERS] = {0, ...},
    hack_teleport[MAX_PLAYERS] = {0, ...},
    hack_airbreak[MAX_PLAYERS] = {0, ...},
    hack_vehiclehealth[MAX_PLAYERS] = {0, ...},
    hack_vehtele[MAX_PLAYERS] = {0, ...},
    hack_fly[MAX_PLAYERS] = {0, ...}
;

Function: OnCheatDetected(playerid, ip_address[], type, code)
{
    if(!IsPlayerConnected(playerid))
        return SendErrorMessage(playerid, "Player isn't connected!");

    switch(code)
    {
        //Onfoot airbreak
        case 0: {
            if(++hack_airbreak[playerid] == 3)
            {
                SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: airbreak hack", ReturnName(playerid));

                hack_airbreak[playerid] = 0;

                //KickEx(playerid);
                return 1;
            }
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible onfoot airbreak hack.", ReturnName(playerid));
        }
        //Vehicle airbreak
        case 1: {
            if(++hack_airbreak[playerid] == 3)
            {
                SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: vehicle airbreak hack", ReturnName(playerid));

                hack_airbreak[playerid] = 0;

                //KickEx(playerid);
                return 1;
            }
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible vehicle airbreak hack.", ReturnName(playerid));
        }
        //Teleport hack
        case 2:
        {
            new Float:x, Float:y, Float:z;
            new vw, int;
            int = GetPlayerInterior(playerid);
            vw = GetPlayerVirtualWorld(playerid);
            AntiCheatGetPos(playerid, x, y, z);
            SetPlayerInterior(playerid, int);
            SetPlayerVirtualWorld(playerid, vw);
            SetPlayerPos(playerid, x, y, z);

            if(!IsPlayerPaused(playerid))
            {
                if(++hack_teleport[playerid] == 3)
                {
                    SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: possible teleport hack", ReturnName(playerid));

                    hack_teleport[playerid] = 0;

                    //KickEx(playerid);
                    return 1;
                }
                SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible teleport hack.", ReturnName(playerid));
            }
        }

        //Vehicle teleport hack
        case 3: 
        {
            if(++hack_vehtele[playerid] == 3) 
            {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible vehicle teleport hack.", ReturnName(playerid));
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            //KickEx(playerid);
            return 1;
            }
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible vehicle teleport hack.", ReturnName(playerid));
        }

        //Wrap vehicle hack
        case 4: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible wrap vehicle hack.", ReturnName(playerid));
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            //KickEx(playerid);
        }

        //Vehicle teleport to player hack
        case 5: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible vehicle teleport to player hack.", ReturnName(playerid)); 
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            //KickEx(playerid);
        }
        
        //Flyhack on foot
        case 7: {
            if(++hack_fly[playerid] == 3)
            {
                SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: fly hack", ReturnName(playerid));

                hack_fly[playerid] = 0;

                //KickEx(playerid);
                return 1;
            }
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible on foot flyhack hack.", ReturnName(playerid));
        }    
        //Flyhack in vehicle
        case 8: {
            if(++hack_fly[playerid] == 3)
            {
                SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: vehicle fly hack", ReturnName(playerid));

                hack_fly[playerid] = 0;

                //KickEx(playerid);
                return 1;
            }
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible vehicle fly hack.", ReturnName(playerid));
        }
        //Speedhack in vehicle
        case 10: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible vehicle speed hack.", ReturnName(playerid));
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            //KickEx(playerid);
        }
        
        //Vehicle speed hack
        case 11: {
            if(++hack_vehiclehealth[playerid] == 3)
            {
                SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: vehicle health hack", ReturnName(playerid));
                hack_vehiclehealth[playerid] = 0;
                //KickEx(playerid);
                return 1;
            }
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible vehicle health hack.", ReturnName(playerid));
        }
        //Health hack
        case 12: {
            new Float:health;
            AntiCheatGetHealth(playerid, health);
            SetPlayerHealth(playerid, health);
            if(++hack_health[playerid] == 3)
            {
                SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: health hack", ReturnName(playerid));
                hack_health[playerid] = 0;
                KickEx(playerid);
                return 1;
            }
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible health hack.", ReturnName(playerid));
        }
        //Weapon hack
        case 15: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible weapon hack.", ReturnName(playerid));
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            KickEx(playerid);
        }

        //Ammo hack
        case 16: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible add ammo hack.", ReturnName(playerid));
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            KickEx(playerid);
        }

        //Ammo hack infinite
        case 17: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible infinite ammo hack.", ReturnName(playerid)); 
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            KickEx(playerid);
        }

        case 18: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s is using special animations hack.", ReturnName(playerid));
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            //KickEx(playerid);
        }
        //Vehicle health hack
        case 13: {
            new Float:armour;
            AntiCheatGetArmour(playerid, armour);
            SetPlayerArmour(playerid, armour);

            if(++hack_armour[playerid] == 3)
            {
                SendClientMessageToAllEx(X11_TOMATO_1, "Anticheat: %s have been kicked by BOT for: armour hack", ReturnName(playerid));

                hack_armour[playerid] = 0;

                //KickEx(playerid);
                return 1;
            }
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible armour hack.", ReturnName(playerid));
        }
        //Rapid fire hack
        case 26: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible rapid fire hack.", ReturnName(playerid)); 
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            //KickEx(playerid);   
        }

        /*case 32: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s possible car-jack cheat (change stat too fast!)", ReturnName(playerid));
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            //KickEx(playerid);
        }*/
        // sandbox
        case 40: {
            SendAdminMessage(X11_DARKORANGE, "Anticheat: %s is using sandboxie.", ReturnName(playerid));
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            //KickEx(playerid);
        }

        /*//flood incoming
        case 48: {
            printf("Anticheat: %s is flooding on server! [code: %d]", ReturnName(playerid), code);
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            KickEx(playerid);
        }
        //Flood callback hack
        case 49: {
            printf("Anticheat: %s is flooding call back on server! [code: %d]", ReturnName(playerid), code);
            SendServerMessage(playerid, "You have been kicked out because of some file detection on server!.");
            KickEx(playerid);
        }*/
    }
    //MarkhereAC
    SendAdminMessage(X11_DARKORANGE, "Anticheat debug: %s (%s) type: %d code %d", ReturnName(playerid), ReturnIP(playerid), type, code);
    return 1;
}

hook OnGameModeInit()
{
    EnableAntiCheat(18, true); //Special animation
    EnableAntiCheat(38, false); //Anti-High ping
    EnableAntiCheat(39, false); //Dialog hack
    EnableAntiCheat(40, false); //Sanbox hack
    EnableAntiCheat(49, false); //Flood callback hack
    EnableAntiCheat(48, false); // floods
    EnableAntiCheat(32, false); // floods
}

/*cheat yang masih bisa:

1. Cheat di S0Beit -> N20
                   -> Mega jump hack on bike


*/