public OnPlayerFakeKill(playerid, spoofedid, spoofedreason, faketype) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: Fake kill.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (Fake kill).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerFakeConnect(playerid) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: Fake Connecting.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (Fake Connecting).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerJetpackCheat(playerid) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: Jetpack Cheats.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (Jetpack Cheats).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerSpamChat(playerid) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: SPAM.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (SPAM).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerGunCheat(playerid, weaponid, ammo, hacktype) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: Wepon/Ammo hack.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (Wepon/Ammo hack).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerSpeedCheat(playerid, speedtype) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: Speed cheat.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (Speed cheat).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerBreakAir(playerid, breaktype) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: airbreak/teleport cheats.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (airbreak/teleport cheats).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerSpamCars(playerid, number) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: spammed a vehicle.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (spammed a vehicle).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

/*public OnPlayerCarTroll(playerid, vehicleid, trolledid, trolltype) 
{ 
    if(trolledid == INVALID_PLAYER_ID) 
        format(Test_String, sizeof(Test_String), "ID %d used car troll cheats vehicle %d type %d !", playerid, vehicleid, trolltype); 
    else 
        format(Test_String, sizeof(Test_String), "ID %d used car troll cheats on ID %d vehicle %d type %d !", playerid, trolledid vehicleid, trolltype);  
    SendClientMessageToAll(-1, Test_String); 
    print(Test_String); 
    return 1; 
} */

public OnPlayerCarSwing(playerid, vehicleid) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: car swing cheats.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (car swing cheats).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerParticleSpam(playerid, vehicleid) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: car particle spam cheats.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (car particle spam cheats).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnVehicleModEx(playerid, vehicleid, componentid, illegal) 
{ 
    if(illegal) 
    { 
        SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: car mod cheats.", ReturnName2(playerid, 0));
        Log_Write("logs/anticheat_log.txt", "[%s] %s: (car mod cheats).", ReturnDate(), ReturnName2(playerid, 0));
        KickEx(playerid);
    } 
    return 1; 
} 

public OnPlayerSlide(playerid, weaponid, Float:speed) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: slide bugging weapon.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (slide bugging weapon).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
} 

public OnPlayerBugAttempt(playerid, bugcode) 
{ 
    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by Anticheat. Reason: using bug cheats.", ReturnName2(playerid, 0));
    Log_Write("logs/anticheat_log.txt", "[%s] %s: (using bug cheats).", ReturnDate(), ReturnName2(playerid, 0));
    KickEx(playerid);
    return 1; 
}  