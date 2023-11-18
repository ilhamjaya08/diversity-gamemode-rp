
/*==============================================================================
    Timer
==============================================================================*/
task Server_FeatureUpdate[1000]()
{
    /*Server restaer timer*/
    if(g_ServerRestart)
    {
        switch(g_RestartTime)
        {
            case 1:
            {
                g_ServerRestart = 0;
                g_RestartTime = 0;
                TextDrawHideForAll(gServerTextdraws[1]);

                SaveAll();
                SendRconCommand("password notallowed");
            }
            case 3:
            {
                for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++) if(IsPlayerConnected(i))
                    KickEx(i);

                g_RestartTime--;
            }
            default: {
                new times[3];
                GetElapsedTime(g_RestartTime--, times[0], times[1], times[2]);
                TextDrawSetString(gServerTextdraws[1], sprintf("~r~Server Restart:~w~ %02d:%02d", times[1], times[2]));
            }
        }
    }

    /*Server countdown timer*/
    if(GetGVarInt("Countdown") && GetGVarInt("CDInterval") > 0)
    {
        new string[64], times[3];

        SetGVarInt("CDInterval", GetGVarInt("CDInterval")-1);
        GetElapsedTime(GetGVarInt("CDInterval"), times[0], times[1], times[2]);

        switch(GetGVarInt("CDInterval"))
        {
            case 0:
            {
                format(string, 32, "~p~Countdown:~w~Done");
                TextDrawHideForAll(gServerTextdraws[1]);
                SetGVarInt("Countdown", 0);
            }
            case 1:format(string, 32, "~p~Countdown:~g~~h~ %02d:%02d", times[1], times[2]);
            case 2:format(string, 32, "~p~Countdown:~y~~h~ %02d:%02d", times[1], times[2]);
            case 3:format(string, 32, "~p~Countdown:~r~~h~ %02d:%02d", times[1], times[2]);
            default: format(string, 32, "~p~Countdown:~w~~h~ %02d:%02d", times[1], times[2]);
        }
        TextDrawSetString(gServerTextdraws[1], string);
    }

    /*Server player time update*/

    // Sudah di-handle oleh module server/realtime_clock
    // new
    //     hour = ServerData[ServerTime]
    // ;
    
    // if(++ServerData[ServerTimer] >= 600) 
    // {
    //     ServerData[ServerTime]++;
    //     ServerData[ServerTimer] = 0;
    //     if(ServerData[ServerTime] >= 23)
    //     {
    //         ServerData[ServerTime] = 0;
    //         ServerData[ServerTimer] = 0;
    //     }
    // }
    // SetWorldTime(hour);

    /*Player record timer*/
    if(Iter_Count(Player) > ServerData[g_Players])
    {
        ServerData[g_Players] = Iter_Count(Player);
        mysql_tquery(g_iHandle, sprintf("UPDATE `server` SET `g_Players`='%d' WHERE `ID`='1'", ServerData[g_Players]));
    }
    return 1;
}