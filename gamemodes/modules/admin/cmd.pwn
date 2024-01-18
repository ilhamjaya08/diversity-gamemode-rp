#include <realtime-clock>

CMD:admins(playerid, params[])
{
    new count = 0;

    SendClientMessageEx(playerid, X11_LIGHTBLUE, "Server Team Staff Online:");

    foreach (new i : Player) if (IsPlayerConnected(i) && AccountData[i][pAdmin] && AccountData[i][pAdminHide] != 1) {
	    SendClientMessageEx(playerid, X11_WHITE, "{33CCFF}* {FFFF00}%s | %s (%d) {FFFFFF}(%s)", NormalName(i), ReturnAdminName(i), i, ReturnAdminRankName(i));
	    count++;
	}
    
    if(!count) SendClientMessage(playerid, X11_WHITE, "* No admin/helper online.");

    if(count > 0)
    {
        SendClientMessageEx(playerid, X11_LIGHTBLUE, "Bila butuh bantuan bisa /report");//, /requesthelp .");
    }
    return 1;
}

CMD:netstats(playerid, params[])
{
	if (GetAdminLevel(playerid))
	{
		new
			stats[ 512 ]
		;

		GetNetworkStats(stats, sizeof(stats)); // get the servers networkstats
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Server Network Stats", stats, "Close", "");
	}

	return 1;
}

CMD:adminactivity(playerid, params[])
{
	if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    new 
		Cache:admincheck,
		string[1500]
	;

	admincheck = mysql_query(g_iHandle, "SELECT * FROM `accounts` WHERE `Admin`>='1' ORDER BY `Admin` DESC");

	format(string, sizeof(string), "Account ID\tAdmin Name\tRank\n");
	for(new i = 0; i != cache_num_rows(); i++) 
	{
		new
			accountid,
			accountname[25],
			accountrankname[32]
		;
		cache_get_field_content(i, "Username", accountname, 25);
		cache_get_field_content(i, "AdminRankName", accountrankname, 32);
		accountid = cache_get_field_int(i, "ID"),

		format(string, sizeof(string), "%s%d\t%s\t%s\n", string, accountid, accountname, accountrankname);
	}
	Dialog_Show(playerid, AdminActivity, DIALOG_STYLE_TABLIST_HEADERS, "Admin/Helper list", string, "Select", "Close");

	cache_delete(admincheck);
    return 1;
}

Dialog:AdminActivity(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			Cache:adminstatscheck,
			query[255],
			string[2000],
			adminname[500],
			account_admin_name[25],
			account_admin_rankname[32],
			account_accept_report,
			account_denied_report,
			account_accept_stuck,
			account_denied_stuck,
			account_banned_record,
			account_unbanned_record,
			account_jail_record,
			account_answer_record,
			account_duty_hour
		;

		format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `ID` = '%d'", strval(inputtext));
		adminstatscheck = mysql_query(g_iHandle, query);

		if(cache_num_rows())
    	{
			cache_get_field_content(0, "Username", account_admin_name, 25);
			cache_get_field_content(0, "AdminRankName", account_admin_rankname, 32);

			account_accept_report = cache_get_field_int(0, "AdminAcceptReport");
			account_denied_report = cache_get_field_int(0, "AdminDeniedReport");
			account_accept_stuck = cache_get_field_int(0, "AdminAcceptStuck");
			account_denied_stuck = cache_get_field_int(0, "AdminDeniedStuck");
			account_banned_record = cache_get_field_int(0, "AdminBanned");
			account_unbanned_record = cache_get_field_int(0, "AdminUnbanned");
			account_jail_record = cache_get_field_int(0, "AdminJail");
			account_answer_record = cache_get_field_int(0, "AdminAnswer");
			account_duty_hour = cache_get_field_int(0, "AdminDutyTime");

			cache_delete(adminstatscheck);		
		}
		format(adminname, sizeof(adminname), "Account ID - %d - %s - %s", strval(inputtext), account_admin_name, account_admin_rankname);
		format(string, sizeof(string), "Admin Name : "RED"%s\n"WHITE"Admin Rankname : "RED"%s\n"WHITE"Admin Duty Minute(s) : "GREEN"%d\n"WHITE"Answered Question : "GREEN"%d\n"WHITE"Accepted Report : "GREEN"%d\n"WHITE"Denied Report : "GREEN"%d\n"WHITE"Accepted Stuck : "GREEN"%d\n"WHITE"Denied Stuck : "GREEN"%d\n"WHITE"Banned Record : "GREEN"%d\n"WHITE"Unbanned Record : "GREEN"%d\n"WHITE"Jail Record : "GREEN"%d", account_admin_name, account_admin_rankname, account_duty_hour, account_answer_record, account_accept_report, account_denied_report, account_accept_stuck, account_denied_stuck, account_banned_record, account_unbanned_record, account_jail_record);

		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, adminname, string, "Close", "");
	}
	return 1;
}


// task UpdateAdminStatus[5000]()
// {
// 	new 
// 		string[3072],
// 		str[128],
// 		query[3072]
// 	;
// 	TimeFormat(Timestamp:Now()+Hours:7, "Last Check : %A, %d %B %Y -- %H:%M:%S\n\n", string);
// 	foreach (new i : Player)
// 	{ 
// 		if (IsPlayerConnected(i) && AccountData[i][pAdmin] > 0) 
// 		{
// 			if(!strcmp(AccountData[i][pAdminRankName], "None")) 
// 			{
// 				format(str, sizeof(str), "* (%s) %s (ID: %d), ON-DUTY: %s *\n",gAdminLevel[AccountData[i][pAdmin]], ReturnAdminName(i), i, (AccountData[i][pAdminDuty]) ? ("Yes") : ("No"));
// 				strcat(string, str);
				
// 			}
// 			else
// 			{
// 				format(str, sizeof(str), "* (%s) %s (ID: %d), ON-DUTY: %s *\n",ReturnAdminRankName(i), ReturnAdminName(i), i, (AccountData[i][pAdminDuty]) ? ("Yes") : ("No"));
// 				strcat(string, str);
// 			}
// 		}
// 	}
// 	mysql_format(g_iHandle, query, sizeof(query), "UPDATE `server` SET `admin_online` = '%s' WHERE `ID` = '1'", string);
// 	mysql_tquery(g_iHandle, query);
// 	return 1;
// }

CMD:worldtime(playerid, params[])
{
	if (CheckAdmin(playerid, 7))
		return PermissionError(playerid);

	new
		args[8],
		hour,
		minute,
		interval,
		operation[25]
	;

	if(sscanf(params,"s[25]S()[8]", operation, args))
	{
		SendSyntaxMessage(playerid, "/worldtime [operation]");
		SendSyntaxMessage(playerid, "");
		SendSyntaxMessage(playerid, "sethour, setminute, settime, setinterval");
		SendSyntaxMessage(playerid, "start, stop, status, save, sync");
		return 1;
	}

	if (!strcmp(operation, "sethour", true, 7))
	{
		if (sscanf(args, "d", hour))
		{
			SendSyntaxMessage(playerid, "/worldtime sethour [0 - 23]");
			SendSyntaxMessage(playerid, "HELP: Set world time hour.");
			return 1;
		}

		if (hour < 0 || hour > 24)
		{
			SendErrorMessage(playerid, "Hour only accept 0 - 23");
			return 1;
		}

		RealTime_SetHour(hour);
		CallLocalFunction("SaveServerSettings", "");
		SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have changed world time to %02d:%02d.", ReturnAdminName(playerid), hour, RealTime_GetMinute());
		return 1;
	}

	if (!strcmp(operation, "setminute", true, 9))
	{
		if (sscanf(args, "d", minute))
		{
			SendSyntaxMessage(playerid, "/worldtime setminute [0 - 59]");
			SendSyntaxMessage(playerid, "HELP: Set world time minute.");
			return 1;
		}

		if (minute < 0 || minute > 59)
		{
			SendErrorMessage(playerid, "Minute only accept 0 - 59");
			return 1;
		}

		RealTime_SetMinute(minute);
		CallLocalFunction("SaveServerSettings", "");
		SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have changed world time to %02d:%02d.", ReturnAdminName(playerid), RealTime_GetHour(), minute);
		return 1;
	}

	if (!strcmp(operation, "settime", true, 7))
	{
		if (sscanf(args, "dd", hour, minute))
		{
			SendSyntaxMessage(playerid, "/worldtime settime [0 - 23] [0 - 59]");
			SendSyntaxMessage(playerid, "HELP: Set world time hour and minute.");
			return 1;
		}

		if (hour < 0 || hour > 24)
		{
			SendErrorMessage(playerid, "Hour only accept 0 - 23");
			return 1;
		}

		if (minute < 0 || minute > 59)
		{
			SendErrorMessage(playerid, "Minute only accept 0 - 59");
			return 1;
		}

		RealTime_SetWorldTime(hour, minute);
		CallLocalFunction("SaveServerSettings", "");
		SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have changed world time to %02d:%02d.", ReturnAdminName(playerid), hour, minute);
		return 1;
	}

	if (!strcmp(operation, "setinterval", true, 11))
	{
		if (sscanf(args, "d", interval))
		{
			SendSyntaxMessage(playerid, "/worldtime setinterval [1 - 60]");
			SendSyntaxMessage(playerid, "HELP: Set world time interval to next minute.");
			return 1;
		}

		if (interval < 1 || interval > 60)
		{
			SendErrorMessage(playerid, "Interval only accept 1 - 60");
			return 1;
		}

		ServerData[ServerTimeInterval] = interval;

		RealTime_SetInterval(interval * 1000);
		CallLocalFunction("SaveServerSettings", "");
		SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have changed world time interval to %d second(s) for 1 minute in-game clock.", ReturnAdminName(playerid), interval);
		return 1;
	}

	if (!strcmp(operation, "start", true, 5))
	{
		RealTime_StartTime();
		ServerData[IsRealTimeEnabled] = true;
		SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have (re)started world time.", ReturnAdminName(playerid));
		return 1;
	}

	if (!strcmp(operation, "stop", true, 4))
	{
		RealTime_StopTime();
		ServerData[IsRealTimeEnabled] = false;
		SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have stopped world time.", ReturnAdminName(playerid));
		return 1;
	}

	if (!strcmp(operation, "status", true, 6))
	{
		SendServerMessage(playerid, "[REALTIME] Time: %02d:%02d", RealTime_GetHour(), RealTime_GetMinute());
		SendServerMessage(playerid, "[REALTIME] Interval: 1 minute in-game = %d second(s)", (RealTime_GetInterval() / 1000));
		SendServerMessage(playerid, "[REALTIME] Status: %s", ServerData[IsRealTimeEnabled] ? ""GREEN"Running" : ""RED"Stopped");
		return 1;
	}

	if (!strcmp(operation, "save", true, 4))
	{
		ServerData[ServerTime] = RealTime_GetHour();
		ServerData[ServerTimeMinute] = RealTime_GetMinute();

		CallLocalFunction("SaveServerSettings", "");
		SendServerMessage(playerid, "[REALTIME] World time saved.");
		return 1;
	}

    if (!strcmp(operation, "sync", true, 4))
	{
        new string:toggle[4];

		if (sscanf(args, "s[3]", interval))
		{
			SendSyntaxMessage(playerid, "/worldtime sync [on/off]");
			SendSyntaxMessage(playerid, "HELP: Set world time sync with server time.");
			return 1;
		}

        if (!strcmp(toggle, "on", true, 2))
        {
            ServerData[ServerTimeSync] = 1;
            RealTime_Sync(true);
            SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have synced world time.", ReturnAdminName(playerid));
        }
        else if (!strcmp(toggle, "off", true, 3))
        {
            ServerData[ServerTimeSync] = 0;
		    RealTime_SetInterval((ServerData[ServerTimeInterval] <= 0 ? 1 : ServerData[ServerTimeInterval]) * 1000);
            RealTime_Sync(false);
            SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have un-synced world time.", ReturnAdminName(playerid));
        }
        else
        {
            SendSyntaxMessage(playerid, "/worldtime sync [on/off]");
			SendSyntaxMessage(playerid, "HELP: Set world time sync with server time.");
			return 1;
        }

		CallLocalFunction("SaveServerSettings", "");
		return 1;
	}

	return 1;
}
CMD:a(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(PlayerData[playerid][pDisableAdmin])
        return SendErrorMessage(playerid, "Aktifkan admin chat terlebih dahulu (/toggle).");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/a [admin text]");

    if(!strcmp(AccountData[playerid][pAdminRankName], "None")) SendAdminMessage(X11_OLIVE_DRAB_1, "%s %s: {33EE33}%s", gAdminLevel[AccountData[playerid][pAdmin]], ReturnAdminName(playerid), params);
	else SendAdminMessage(X11_OLIVE_DRAB_1, "%s %s: {33EE33}%s", AccountData[playerid][pAdminRankName], ReturnAdminName(playerid), params);

    Log_Save(E_LOG_ADMIN_CHAT, sprintf("[%s] %s: %s", ReturnDate(), ReturnAdminName(playerid), params));
    return 1;
}

CMD:aduty(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);
    if(PlayerData[playerid][pMaskOn]) return SendErrorMessage(playerid, "You're using a mask remove the mask first");
    if(!AccountData[playerid][pAdminDuty])
    {
        if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
            SetHealth(playerid, 99999);
            
        SetPVarInt(playerid, "PreviousColor", GetPlayerColor(playerid));

        AccountData[playerid][pAdminDuty] = 1;
        SetPlayerColor(playerid, RemoveAlpha(0xFF800000));
        SetPlayerName(playerid, ReturnAdminName(playerid));
        //ResetNameTag(playerid, false, false, true);
        AdminDutyTime_WriteStartTime(playerid);
        SendAdminMessage(0xFF800000, "* %s is now duty as an admin.", ReturnName(playerid,1));
    }
    else
    {
        new faction_id = GetPlayerFaction(playerid);

        SetHealth(playerid, 100);
        AccountData[playerid][pAdminDuty] = 0;
        SetPlayerColor(playerid, (faction_id != -1 && IsPlayerDuty(playerid)) ? (RemoveAlpha(FactionData[faction_id][factionColor])) : (RemoveAlpha(GetPVarInt(playerid, "PreviousColor"))));
        SetPlayerName(playerid, NormalName(playerid));
        //ResetNameTag(playerid, false, false, false, true);
        AdminDutyTime_UpdateEndTime(playerid);
        SendAdminMessage(0xFF800000, "* %s is no longer on admin duty.", ReturnName(playerid,1));
    }
    return 1;
}

CMD:asay(playerid, params[])
{
    if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/asay [text]");

    if (strlen(params) > 64)
    {
        SendClientMessageToAllEx(X11_TOMATO_1, "Admin %s: %.64s ..", ReturnAdminName(playerid), ColouredText(params));
        SendClientMessageToAllEx(X11_TOMATO_1, "Admin %s: .. %s", ReturnAdminName(playerid), ColouredText(params[64]));
        return 1;
    }

    SendClientMessageToAllEx(X11_TOMATO_1, "Admin %s: %s", ReturnAdminName(playerid), ColouredText(params));
    return 1;
}

CMD:checkacc(playerid, params[])
{

    if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(isnull(params))
    	return SendSyntaxMessage(playerid, "/checkacc [character name]");

    new Cache:execute, username[MAX_PLAYER_NAME];
    execute = mysql_query(g_iHandle, sprintf("SELECT `Username` FROM `characters` WHERE `Character` = '%s' LIMIT 1;", params));

    if(cache_num_rows()) {
        cache_get_field_content(0, "Username", username, MAX_PLAYER_NAME);
        SendServerMessage(playerid, "Karakter "YELLOW"%s "WHITE"menggunakan ACP dengan nama "LIGHTBLUE"%s", params, username);
    }
    else SendErrorMessage(playerid, "%s tidak terdaftar.", params);
    cache_delete(execute);
    return 1;
}

CMD:check(playerid, params[])
{
    new userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
    	return SendSyntaxMessage(playerid, "/check [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
    	return SendErrorMessage(playerid, "You have specified an invalid player.");

    ShowStatsForPlayer(playerid, userid);
    return 1;
}

CMD:spec(playerid, params[]) 
    return cmd_spectate(playerid, params);

CMD:spectate(playerid, params[])
{
    new userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(!isnull(params) && !strcmp(params, "off", true))
    {
        if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
            return SendErrorMessage(playerid, "You are not spectating any player.");

        SetHealth(playerid, GetHealth(playerid));
        SetArmour(playerid, GetArmour(playerid));

        PlayerData[playerid][pSpectator] = INVALID_PLAYER_ID;

        PlayerSpectatePlayer(playerid, INVALID_PLAYER_ID);
        PlayerSpectateVehicle(playerid, INVALID_VEHICLE_ID);

        SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2], PlayerData[playerid][pPos][3], 0, 0, 0, 0, 0, 0);
        TogglePlayerSpectating(playerid, false);

        if(IsPlayerDuty(playerid))
            SetPlayerSkin(playerid, PlayerData[playerid][pSkinFaction]);

        PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][textdraw_spectate][1]);
        PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][textdraw_spectate][0]);

        if(IsPlayerDuty(playerid)) {
            RefreshFactionWeapon(playerid);
            SetPlayerSkin(playerid, PlayerData[playerid][pSkinFaction]);
        }
        else RefreshWeapon(playerid);

        for (new i = 0; i != MAX_ACC; i ++) if(AccData[playerid][i][accExists] && AccData[playerid][i][accShow]) {
            Aksesoris_Attach(playerid, i);
        }

        return SendServerMessage(playerid, "You are no longer in spectator mode.");
    }

    if(sscanf(params, "u", userid)) 
        return SendSyntaxMessage(playerid, "/spectate [playerid/PartOfName] - Gunakan \"/spectate off\" untuk stop spectate.");

    if(userid == INVALID_PLAYER_ID) 
        return SendErrorMessage(playerid, "Player tersebut tidak login kedalam server.");

    if(userid == playerid) 
        return SendErrorMessage(playerid, "Tidak diizinkan spectate id sendiri.");

    if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
    {
        if (AccountData[playerid][pAdminDuty])
            SetHealth(playerid, 99999);

        GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
        GetPlayerFacingAngle(playerid, PlayerData[playerid][pPos][3]);

        PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
        PlayerData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
    }

    PlayerData[playerid][pSpectator] = userid;
    TogglePlayerSpectating(playerid, 1);

    SetPlayerInterior(playerid, GetPlayerInterior(userid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(userid));

    if(IsPlayerInAnyVehicle(userid)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(userid));
    else PlayerSpectatePlayer(playerid, userid);

    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][textdraw_spectate][1]);
    PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][textdraw_spectate][0]);

    if(GetAdminLevel(playerid) < GetAdminLevel(userid))
        return SendCustomMessage(userid, "SPECTATE", ""YELLOW"%s "WHITE"sedang melakukan spectate kamu!", ReturnName(playerid, 0));

    SendServerMessage(playerid, "Kamu sedang melakukan spectate kepada %s (ID: %d).", ReturnName(userid, 0), userid);
    return 1;
}

CMD:jail(playerid, params[])
{
    new userid, minutes, reason[64];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "uds[64]", userid, minutes, reason))
        return SendSyntaxMessage(playerid, "/jail [playerid/PartOfName] [minutes] [reason]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(minutes < 1 || minutes > 10000)
        return SendErrorMessage(playerid, "You can't jail a player for under 0 minutes or more than 10000 minutes for now.");

    SpawnPlayerInJail(userid);

    PlayerData[userid][pInjured] = 0;

    PlayerData[userid][pJailTime] = minutes * 60;
    PlayerData[userid][pPrisoned] = 0;
    format(PlayerData[userid][pJailedBy], 32, ReturnAdminName(playerid));
    format(PlayerData[userid][pJailReason], 64, reason);

    AdminActivity_Write(
		playerid,
		userid,
		ADMIN_ACTIVITY_JAIL,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) jails %s (playerid=%d, IP=%s) for %d minutes. Reason: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
            ,ReturnName(userid, 0)
			,userid
			,ReturnIP(userid)
            ,minutes
            ,reason
		)
	);

    AccountData[playerid][pAdminJail]++;
    SQL_SaveAccounts(playerid);

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s was admin/helper jailed by %s for %d minutes.", ReturnName2(userid, 0), ReturnAdminName(playerid), minutes);
    SendClientMessageToAllEx(X11_TOMATO_1, "Reason: %s", reason);
    Log_Save(E_LOG_JAIL, sprintf("[%s] %s has jailed %s for %d minutes, reason: %s.", ReturnDate(), ReturnAdminName(playerid), ReturnName(userid, 0), minutes, reason));
    return 1;
}

CMD:release(playerid, params[])
{
    new userid, reason[32];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "us[32]", userid, reason))
        return SendSyntaxMessage(playerid, "/release [playerid/PartOfName] [reason]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(!PlayerData[userid][pJailTime])
        return SendErrorMessage(playerid, "You can't release a player that's not in jail.");

    PlayerData[userid][pJailTime] = 3;
    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s was released %s from admin/helper jail reason: %s.", ReturnAdminName(playerid), ReturnName(userid, 0), reason);
    Log_Save(E_LOG_JAIL, sprintf("[%s] %s has released %s from jail.", ReturnDate(), ReturnName(playerid, 0), ReturnName(userid, 0)));
    return 1;
}

CMD:kick(playerid, params[])
{
    new
        userid,
        reason[128];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "us[128]", userid, reason))
        return SendSyntaxMessage(playerid, "/kick [playerid/PartOfName] [reason]");

    if(userid == INVALID_PLAYER_ID || (IsPlayerConnected(userid) && PlayerData[userid][pKicked]))
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s was kicked by %s. Reason: %s", ReturnName2(userid, 0), ReturnAdminName(playerid), reason);
    Log_Save(E_LOG_KICK, sprintf("[%s] %s has kicked %s for: %s", ReturnDate(), ReturnAdminName(playerid), ReturnName2(userid, 0), reason));

    KickEx(userid);
    return 1;
}

CMD:unwarn(playerid, params[])
{
    new
        userid,
        reason[32];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "uS(No Reason Given)[32]", userid, reason)) 
        return SendErrorMessage(playerid, "/unwarn [userid] [reason]");
    
    if(userid == INVALID_PLAYER_ID) 
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(strval(reason) > 32) 
        return SendErrorMessage(playerid, "Reason too long.");

    if(PlayerData[userid][pWarnings] < 1) 
        return SendErrorMessage(playerid, "That player not have warning record.");

    PlayerData[userid][pWarnings] --;

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s was unwarned by admin/helper %s reason: %s", ReturnName2(userid), ReturnAdminName(playerid), reason);
    SendAdminAction(userid, "%s has removed one warning for you, reason: \"%s\" (%d/20).", ReturnAdminName(playerid), reason, PlayerData[userid][pWarnings]);

    Log_Save(E_LOG_UNWARN, sprintf("[%s] %s has unwarned %s for %s.", ReturnDate(), ReturnAdminName(playerid), ReturnName(userid, 0), reason));
    return 1;
}
CMD:bizwarn(playerid, params[])
{
    new
        bizid,
        reason[32];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "ds[32]", bizid, reason)) 
        return SendSyntaxMessage(playerid, "/bizwarn [bizid] [reason]");

    if((bizid < 0 || bizid >= MAX_BUSINESSES) || !BusinessData[bizid][bizExists])
        return SendErrorMessage(playerid, "You have specified an invalid business ID.");

    if(strval(reason) > 32) 
        return SendErrorMessage(playerid, "Reason too long.");

    new query[255];

    format(query, sizeof(query), "INSERT INTO `bizwarn` (`bizID`, `bwarnBy`, `bwarnReason`, `bwarnDate`) VALUES ('%d','%s','%s','%s')", BusinessData[bizid][bizID], ReturnAdminName(playerid), SQL_ReturnEscaped(reason), SQL_ReturnEscaped(ReturnDate()));
    mysql_tquery(g_iHandle, query);

    BusinessData[bizid][bizWarn]++;
    Business_Save(bizid);
    SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s telah menambah warn pada biz id %d, total warn %d.", ReturnAdminName(playerid), bizid, BusinessData[bizid][bizWarn]);
    return 1;
}
CMD:bizwarnlist(playerid, params[])
{
    new Cache:checkwarns, query[255],string[2500], bizid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "d", bizid)) 
        return SendSyntaxMessage(playerid, "/bizwarnlist [bizid]");

    format(query, sizeof(query), "SELECT * FROM `bizwarn` WHERE `bizID`='%d'", BusinessData[bizid][bizID]);
    checkwarns = mysql_query(g_iHandle, query);

    if(!cache_num_rows())
        return SendErrorMessage(playerid, "There are no warns record on this business.");

    format(string, sizeof(string), "WarnID\tWarn Date\tWarn By\tReason\n");

    for(new i; i != cache_num_rows(); i++)
    {
        new warnid,
            warnby[24],
            warndate[64],
            warnreason[64];

        warnid = cache_get_field_int(i, "ID");
        cache_get_field_content(i, "bwarnBy", warnby);
        cache_get_field_content(i, "bwarnDate", warndate);
        cache_get_field_content(i, "bwarnReason", warnreason);

        format(string, sizeof(string), "%s%d\t%s\t%s\t%s\n", string, warnid, warndate, warnby, warnreason);
    }
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Biz Warn Log", string, "Close","");

    cache_delete(checkwarns);
    return 1;
}
CMD:bizremovewarn(playerid, params[])
{
    new
        bizid,
        warnid;

    new Cache:checkwarns;
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "dd", bizid, warnid)) 
        return SendSyntaxMessage(playerid, "/bizremovewarn [bizid] [warnid]");

    if(BusinessData[bizid][bizWarn] <= 0)
        return SendErrorMessage(playerid, "This business have no warning!");

    if((bizid < 0 || bizid >= MAX_BUSINESSES) || !BusinessData[bizid][bizExists])
        return SendErrorMessage(playerid, "You have specified an invalid business ID.");

    checkwarns = mysql_query(g_iHandle, sprintf("SELECT `ID` FROM `bizwarn` WHERE bizID = '%d' AND ID = '%d'", BusinessData[bizid][bizID], warnid));

    if(cache_num_rows()) 
    {
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `bizwarn` WHERE bizID='%d' AND ID='%d'", BusinessData[bizid][bizID], warnid));
        BusinessData[bizid][bizWarn]--;
        Business_Save(bizid);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s telah menghapus warn pada biz id %d, total warn %d.", ReturnAdminName(playerid), bizid, BusinessData[bizid][bizWarn]);
    }
    else SendErrorMessage(playerid, "There no warn on this busines with this id!.");
    cache_delete(checkwarns);
    return 1;
}
CMD:warn(playerid, params[])
{
    new
        userid,
        reason[32];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "us[32]", userid, reason)) 
        return SendSyntaxMessage(playerid, "/warn [playerid/PartOfName] [reason]");

    if(userid == INVALID_PLAYER_ID) 
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(strval(reason) > 32) 
        return SendErrorMessage(playerid, "Reason too long.");

    new query[255];

    format(query, sizeof(query), "INSERT INTO `wanrslog` (`ID`, `warnBy`, `warnReason`, `warnDate`) VALUES ('%d','%s','%s','%s')", PlayerData[userid][pID], ReturnAdminName(playerid), SQL_ReturnEscaped(reason), SQL_ReturnEscaped(ReturnDate()));
    mysql_tquery(g_iHandle, query);

    PlayerData[userid][pWarnings] ++;

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s has been warned by admin/helper %s.", ReturnName2(userid), ReturnAdminName(playerid));
    SendClientMessageToAllEx(X11_TOMATO_1, "Reason: %s (Total Warn: %d/20)", reason, PlayerData[userid][pWarnings]);
    //SendAdminAction(userid, "%s has warned you for \"%s\" (%d/20).", ReturnAdminName(playerid), reason, PlayerData[userid][pWarnings]);

    if(PlayerData[userid][pWarnings] >= 20)
    {
        ResetWarnings(userid);

        SendAdminAction(userid, "You've been banned for exceeding your warnings (\"%s\").", reason);
        SendTesterMessage(X11_TOMATO_1, "AdmCmd: %s was banned for 20 warnings by %s, reason: %s", ReturnName(userid, 0), ReturnName(playerid, 0), reason);
        Blacklist_Add("0.0.0.0", NormalName(userid), ReturnAdminName(playerid), "Maximum warning 20/20.", " ");
        KickEx(userid);
    }

    Log_Save(E_LOG_WARN, sprintf("[%s] %s has warned %s for %s.", ReturnDate(), ReturnName(playerid, 0), ReturnName(userid, 0), reason));
    return 1;
}

CMD:mute(playerid, params[])
{
    static
        userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/mute [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(userid == playerid)
        return SendErrorMessage(playerid, "You can't mute yourself!");

    if(PlayerData[userid][pMuted])
        return SendErrorMessage(playerid, "The player you're attempting to mute is muted already.");

    PlayerData[userid][pMuted] = 1;

    SendAdminAction(playerid, "You have muted %s from using text and commands.", ReturnName(userid, 0));
    SendAdminAction(userid, "%s has muted you from using text and commands.", ReturnAdminName(playerid));

    return 1;
}

CMD:unmute(playerid, params[])
{
    new
        userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/unmute [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(!PlayerData[userid][pMuted])
        return SendErrorMessage(playerid, "The player you're attempting to mute is not muted.");

    PlayerData[userid][pMuted] = 0;

    SendAdminAction(playerid, "You have unmuted %s from using text and commands.", ReturnName(userid, 0));
    SendAdminAction(userid, "You have been unmuted by %s.", ReturnAdminName(playerid));

    return 1;
}

CMD:freeze(playerid, params[])
{
    new
        userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/freeze [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    PlayerData[playerid][pFreeze] = 1;

    TogglePlayerControllable(userid, 0);
    SendAdminAction(playerid, "You have frozen %s's movements.", ReturnName(userid, 0));
    return 1;
}

CMD:unfreeze(playerid, params[])
{
    new
        userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/unfreeze [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    PlayerData[playerid][pFreeze] = 0;

    TogglePlayerControllable(userid, 1);
    SendAdminAction(playerid, "You have unfrozen %s's movements.", ReturnName(userid, 0));
    return 1;
}

CMD:goto(playerid, params[])
{
    new id, type[24], string[64];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", id))
    {
        SendSyntaxMessage(playerid, "/goto [player or name]");
        SendClientMessage(playerid, X11_YELLOW_2, "[NAMES]:"WHITE" house, business, entrance, job, interior, houseint, basement, tags, plant, lumber");
        SendClientMessage(playerid, X11_YELLOW_2, "[NAMES]:"WHITE" objecttext, atm, speed, crate, workshop, pump, marketplace, rental, druglab");
        return 1;
    }
    else if(id == INVALID_PLAYER_ID)
    {
        if(sscanf(params, "s[24]S()[64]", type, string))
        {
            SendSyntaxMessage(playerid, "/goto [player or name]");
            SendClientMessage(playerid, X11_YELLOW_2, "[NAMES]:"WHITE" house, business, entrance, job, interior, houseint, basement, tags, plant, lumber");
            SendClientMessage(playerid, X11_YELLOW_2, "[NAMES]:"WHITE" objecttext, atm, speed, crate, workshop, pump, marketplace, rental, druglab");
            return 1;
        }
        
        if(!strcmp(type, "objecttext", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto objecttext [objecttext ID]");

            if((id < 0 || id >= MAX_TEXTOBJECT) || !ObjectData[id][oExists])
                return SendErrorMessage(playerid, "You have specified an invalid object text ID.");

            SetPlayerPos(playerid, ObjectData[id][oPos][0], ObjectData[id][oPos][1], ObjectData[id][oPos][2]);
            return SendServerMessage(playerid, "You have teleported to object text ID: %d.", id);
        }
        else if(!strcmp(type, "druglab", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto druglab [1 - 3]");

            if(id < 1 || id > 3)
                return SendErrorMessage(playerid, "You have specified an invalid druglab location.");

            if(id == 1)
            {
                SendPlayerPos(playerid, 2350.9465,-648.0103,128.0547, 0, 0, 0);
            }
            else if(id == 2)
            {
                SendPlayerPos(playerid, -1630.2352,-2238.9636,31.4766, 0, 0, 0);
            }
            else if(id == 3)
            {
                SendPlayerPos(playerid, -753.9861,-132.3419,65.8281, 0, 0, 0);
            }
            return SendServerMessage(playerid, "You have teleported to druglab : %d.", id);
        }
        else if(!strcmp(type, "chopshop", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto chopshop [1 - 4]");

            if(id < 1 || id > 4)
                return SendErrorMessage(playerid, "You have specified an invalid chopshop location.");

            if(id == 1)
            {
                SendPlayerPos(playerid, 2488.7637,-1460.4315,24.0184, 0, 0, 0);
            }
            else if(id == 2)
            {
                SendPlayerPos(playerid, 2446.1292,-1761.6219,13.5859, 0, 0, 0);
            }
            else if(id == 3)
            {
                SendPlayerPos(playerid, 1687.5428,-2024.3988,14.1289, 0, 0, 0);
            }
            else if(id == 4)
            {
                SendPlayerPos(playerid, 2031.8624,-1290.8844,20.9403, 0, 0, 0);
            }
            return SendServerMessage(playerid, "You have teleported to chopshop : %d.", id);
        }
        else if(!strcmp(type, "vending", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto vending [vending ID]");

            if(!Vending_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid vending ID.");

            SendPlayerPos(playerid, VendingData[id][vendPosX], VendingData[id][vendPosY] + 1.0, VendingData[id][vendPosZ], 0, VendingData[id][vendInterior], VendingData[id][vendWorld]);
            return SendServerMessage(playerid, "You have teleported to vending ID: %d.", id);
        }
        else if(!strcmp(type, "apartmentroom", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto apartmentroom [apartmentroom ID]");

            if(!ApartmentRoom_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid apartment room ID.");

            SendPlayerPos(playerid, ApartmentRoomData[id][apartmentRoomExteriorPosX], ApartmentRoomData[id][apartmentRoomExteriorPosY], ApartmentRoomData[id][apartmentRoomExteriorPosZ], 0, 0, ApartmentRoomData[id][apartmentRoomWorld]);
            return SendServerMessage(playerid, "You have teleported to apartment room ID: %d.", id);
        }
        else if(!strcmp(type, "apartment", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto apartment [apartment ID]");

            if(!Apartment_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid apartment ID.");

            SendPlayerPos(playerid, ApartmentData[id][apartmentExteriorPosX], ApartmentData[id][apartmentExteriorPosY], ApartmentData[id][apartmentExteriorPosZ], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to apartment ID: %d.", id);
        }
        else if(!strcmp(type, "lumber", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto lumber [lumber ID]");

            if(!Lumber_Exists(id))
                return SendErrorMessage(playerid, "You have specified an invalid lumber ID.");

            SendPlayerPos(playerid, LumberData[id][lumberPos][0] + 1.0, LumberData[id][lumberPos][1] + 1.0, LumberData[id][lumberPos][2] + 2.0, 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to lumber ID: %d.", id);
        }
        else if(!strcmp(type, "animal", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto animal [animal ID]");

            if(!Animal_Exists(id))
                return SendErrorMessage(playerid, "You have specified an invalid animal ID.");

            SendPlayerPos(playerid, AnimalData[id][animalPos][0] + 1.0, AnimalData[id][animalPos][1] + 1.0, AnimalData[id][animalPos][2] + 2.0, 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to animal ID: %d.", id);
        }
        else if(!strcmp(type, "rental", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto rental [rental ID]");

            if(!Rental_Exists(id))
                return SendErrorMessage(playerid, "You have specified an invalid rental ID.");

            SendPlayerPos(playerid, RentalData[id][rentPosX], RentalData[id][rentPosY], RentalData[id][rentPosZ], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to rental ID: %d.", id);
        }
        else if(!strcmp(type, "plant", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto plant [plant ID]");

            if(!Plant_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid plant ID.");

            SendPlayerPos(playerid, PlantData[id][plantPos][0], PlantData[id][plantPos][1], PlantData[id][plantPos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to plant ID: %d.", id);
        }
        else if(!strcmp(type, "tags", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto tags [tags ID]");

            if(!Tags_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid tags ID.");

            SendPlayerPos(playerid, TagsData[id][tagPosition][0], TagsData[id][tagPosition][1], TagsData[id][tagPosition][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to tags ID: %d.", id);
        }
        else if(!strcmp(type, "basement", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto basement [basement ID]");

            if(!Underground_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid basement ID.");

            SendPlayerPos(playerid, UndergroundData[id][underEnter][0], UndergroundData[id][underEnter][1], UndergroundData[id][underEnter][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to basement ID: %d.", id);
        }
        else if(!strcmp(type, "marketplace", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto marketplace [market ID]");

            if(!Marketplace_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid marketplace ID.");

            SendPlayerPos(playerid, MarketplaceData[id][marketPos][0], MarketplaceData[id][marketPos][1], MarketplaceData[id][marketPos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to marketplace ID: %d.", id);
        }
        else if(!strcmp(type, "crate", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto crate [crate ID]");

            if((id < 0 || id >= MAX_CRATES) || !CrateData[id][crateExists])
                return SendErrorMessage(playerid, "You have specified an invalid crate ID.");

            SendPlayerPos(playerid, CrateData[id][cratePos][0], CrateData[id][cratePos][1], CrateData[id][cratePos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to crate ID: %d.", id);
        }
        else if(!strcmp(type, "dealer", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto dealer [dealer ID]");

            if(!Dealership_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid dealer ID.");

            SendPlayerPos(playerid, DealershipData[id][dealerPos][0], DealershipData[id][dealerPos][1], DealershipData[id][dealerPos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to dealership ID: %d.", id);
        }
        else if(!strcmp(type, "house", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto house [house ID]");

            if((id < 0 || id >= MAX_HOUSES) || !HouseData[id][houseExists])
                return SendErrorMessage(playerid, "You have specified an invalid house ID.");

            SendPlayerPos(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to house ID: %d.", id);
        }
        else if(!strcmp(type, "business", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto business [business ID]");

            if((id < 0 || id >= MAX_BUSINESSES) || !BusinessData[id][bizExists])
                return SendErrorMessage(playerid, "You have specified an invalid business ID.");

            SendPlayerPos(playerid, BusinessData[id][bizPos][0], BusinessData[id][bizPos][1], BusinessData[id][bizPos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to business ID: %d.", id);
        }
        else if(!strcmp(type, "entrance", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto entrance [entrance ID]");

            if((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
                return SendErrorMessage(playerid, "You have specified an invalid entrance ID.");

            SendPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to entrance ID: %d.", id);
        }
        else if(!strcmp(type, "job", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto job [job ID pickup]");

            if((id < 0 || id >= MAX_DYNAMIC_JOBS) || !JobData[id][jobExists])
                return SendErrorMessage(playerid, "You have specified an invalid job ID.");

            SendPlayerPos(playerid, JobData[id][jobPos][0], JobData[id][jobPos][1], JobData[id][jobPos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to job ID: %d.", id);
        }
        else if(!strcmp(type, "workshop", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto workshop [workshop ID]");

            if((id < 0 || id >= MAX_WORKSHOP) || !Iter_Contains(Workshop,id))
                return SendErrorMessage(playerid, "You have specified an invalid workshop ID.");

            SendPlayerPos(playerid, WorkshopData[id][wPos][0], WorkshopData[id][wPos][1], WorkshopData[id][wPos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to workshop ID: %d.", id);
        }
        else if(!strcmp(type, "speed", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto speed [speed ID]");

            if(!Speed_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid speed ID.");

            SendPlayerPos(playerid, SpeedData[id][speedPos][0] + 1, SpeedData[id][speedPos][1] + 1, SpeedData[id][speedPos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to speed ID: %d.", id);
        }
        else if(!strcmp(type, "atm", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto atm [atm ID]");

            if(!ATM_IsExists(id))
                return SendErrorMessage(playerid, "You have specified an invalid atm ID.");

            SendPlayerPos(playerid, AtmData[id][atmPos][0], AtmData[id][atmPos][1], AtmData[id][atmPos][2] + 0.5, 0, AtmData[id][atmInterior], 0);
            return SendServerMessage(playerid, "You have teleported to atm ID: %d.", id);
        }
        else if(!strcmp(type, "pump", true))
        {
            if(sscanf(string, "d", id))
                return SendSyntaxMessage(playerid, "/goto pump [pump ID]");

            if(!Pump_Exists(id))
                return SendErrorMessage(playerid, "You have specified an invalid pump ID.");

            SendPlayerPos(playerid, PumpData[id][pumpPos][0] + 1, PumpData[id][pumpPos][1] + 1, PumpData[id][pumpPos][2], 0, 0, 0);
            return SendServerMessage(playerid, "You have teleported to pump ID: %d.", id);
        }
        else if(!strcmp(type, "interior", true))
        {
            static
                str[1536];

            str[0] = '\0';

            for (new i = 0; i < sizeof(g_arrInteriorData); i ++)
                strcat(str, sprintf("%s\n", g_arrInteriorData[i][e_InteriorName]));

            return Dialog_Show(playerid, TeleportInterior, DIALOG_STYLE_LIST, "Teleport: Interior List", str, "Select", "Cancel");
        }
        else if(!strcmp(type, "houseint", true))
        {
            static
                str[512];

            format(str, sizeof(str), "#\tInterior Name\n");

            for(new i; i < sizeof(arrHouseInteriors); i++)
                format(str, sizeof(str), "%s%d\t%s\n", str, i, arrHouseInteriors[i][eHouseDesc]);

            return Dialog_Show(playerid, FurnitureHouse, DIALOG_STYLE_TABLIST_HEADERS, "House Interior", str, "Teleport", "Close");
        }
        else return SendErrorMessage(playerid, "You have specified an invalid player.");
    }
    if(!IsPlayerSpawned(id))
        return SendErrorMessage(playerid, "You can't teleport to a player that's not spawned.");

    SendPlayerToPlayer(playerid, id);
    SendCustomMessage(id, "TELE",""RED"%s "WHITE"have been "YELLOW"teleported"WHITE" to you!", ReturnName(playerid, 0));
    SendCustomMessage(playerid, "TELE",""WHITE"You have been teleported to "RED"%s", ReturnName(id, 0));
    return 1;
}

CMD:send(playerid, params[])
{
    new
        userid,
        type[128];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "us[128]", userid, type))
    {
        SendSyntaxMessage(playerid, "/send [player] [location]");
        SendClientMessage(playerid, X11_YELLOW_2, "[LOCATION]:"WHITE" ls, lv, sf, mechanic, smb, bank, ANANTAbus, blackmarket, fish, miner");
        SendClientMessage(playerid, X11_YELLOW_2, "[LOCATION]:"WHITE" insurance, hospital, jail, bus, trashmaster, sweeper, vippoint, ads, dmv");
        return 1;
    }
    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(!strcmp(type,"ls")) SendPlayerPos(userid, 1482.0356,-1724.5726,13.5469, 179.4088);
    else if(!strcmp(type,"sf")) SendPlayerPos(userid, -1425.8307,-292.4445,14.1484, 179.4088);
    else if(!strcmp(type,"miner")) SendPlayerPos(userid, 593.8552, 923.6052, -38.7922, 179.4088);
    else if(!strcmp(type,"lv")) SendPlayerPos(userid, 1686.0118,1448.9471,10.7695, 179.4088);
    else if(!strcmp(type,"bank")) SendPlayerPos(userid, 591.0228,-1238.2648,17.8898,199.7479);
    else if(!strcmp(type,"smb")) SendPlayerPos(userid, 161.0615,-1828.1801,3.7568,87.8241);
    else if(!strcmp(type,"mechanic")) SendPlayerPos(userid, 2519.2666,-1511.0056,24.0000,180.6171);
    else if(!strcmp(type,"blackmarket")) SendPlayerPos(userid, -50.3808,-232.8592,6.7646,0);
    else if(!strcmp(type,"insurance")) SendPlayerPos(userid, 1111.6385,-1795.5822,16.5938,0);
    else if(!strcmp(type,"hospital")) SendPlayerPos(userid, 1188.7565,-1323.5248,13.5668,255);
    else if(!strcmp(type,"jail")) SendPlayerPos(userid, -3426.8687,1569.8800,98.9130,255, 3, 100);
    else if(!strcmp(type,"sweeper")) SendPlayerPos(userid, 1700.1438,-1543.4144,13.3828,309.6099);
    else if(!strcmp(type,"bus")) SendPlayerPos(userid, 1001.4980,-1314.1094,13.5469,178.5546);
    else if(!strcmp(type,"ANANTAbus")) SendPlayerPos(userid, 1789.9645,-1911.4059,13.5041,326.1944);
    else if(!strcmp(type,"trashmaster")) SendPlayerPos(userid, 2217.6836,-2193.3879,13.5469,315.9835);
    else if(!strcmp(type,"vippoint")) SendPlayerPos(userid, 477.4115,-1498.9061,20.4821,85.3803);
    else if(!strcmp(type,"ads")) SendPlayerPos(userid, 620.9863,-1348.8933,13.5470,278.9489);
    else if(!strcmp(type,"dmv")) SendPlayerPos(userid, 1081.1647,-1719.6147,13.5469,359.2921);
    else if(!strcmp(type,"fish")) SendPlayerPos(userid, 2863.2415,-1963.7777,11.1094,91.6908);
    else 
    {
        SendSyntaxMessage(playerid, "/send [player] [location]");
        SendClientMessage(playerid, X11_YELLOW_2, "[LOCATION]:"WHITE" ls, lv, sf, mechanic, smb, bank, ANANTAbus, blackmarket, fish, miner");
        SendClientMessage(playerid, X11_YELLOW_2, "[LOCATION]:"WHITE" insurance, hospital, jail, bus, trashmaster, sweeper, vippoint, ads, dmv");
    }
    SendTesterMessage(X11_TOMATO_1, "AdmCmd: %s have teleported %s to %s.", ReturnAdminName(playerid), ReturnName(userid, 0), type);
    return 1;
}

CMD:ogethere(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/ogethere [character name]");

    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `Character` FROM `characters` WHERE `Character`='%s'", params));
    
    if(cache_num_rows())
    {
        new Float:x,Float:y,Float:z;
        GetPlayerPos(playerid, x, y, z);

        mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `PosX`='%.4f', `PosY`='%.4f', `PosZ`='%.4f' WHERE `Character`='%s'", x, y, z, params));    
        SendServerMessage(playerid, "Sukses meletakkan posisi "YELLOW"%s "WHITE"diposisimu saat ini.", params);
    }
    else SendErrorMessage(playerid, "Nama karakter tidak ditemukan.");
    cache_delete(execute);
    printf("remove me!");
    return 1;
}

CMD:sendto(playerid, params[])
{
    new userid, targetid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "uu", userid, targetid))
        return SendSyntaxMessage(playerid, "/sendto [playerid/PartOfName] [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID || targetid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "The specified user(s) are not connected.");

    SendPlayerToPlayer(userid, targetid);

    SendServerMessage(playerid, "You have teleported "RED"%s"WHITE" to "RED"%s.", ReturnName(userid, 0), ReturnName(targetid));
    SendServerMessage(userid, ""RED"%s"WHITE" has teleported you to "RED"%s.", ReturnName(playerid, 0), ReturnName(targetid));
    return 1;
}

CMD:setint(playerid, params[])
{
    new userid, interior;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "ud", userid, interior))
        return SendSyntaxMessage(playerid, "/setinterior [playerid/PartOfName] [interior]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    SetPlayerInterior(userid, interior);
    PlayerData[userid][pInterior] = interior;
    SendServerMessage(playerid, "You have set %s's interior to %d.", ReturnName(userid, 0), interior);
    return 1;
}

CMD:setvw(playerid, params[])
{
    new userid, world;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "ud", userid, world))
        return SendSyntaxMessage(playerid, "/setvw [playerid/PartOfName] [world]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    SetPlayerVirtualWorld(userid, world);
    PlayerData[userid][pWorld] = world;
    SendServerMessage(playerid, "You have set %s's virtual world to %d.", ReturnName(userid, 0), world);
    return 1;
}

CMD:apm(playerid, params[])
{
    new userid, text[128];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "us[128]", userid, text))
        return SendSyntaxMessage(playerid, "/apm [playerid/PartOfName] [message]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if (strlen(text) > 48)
    {
        SendClientMessageEx(userid, X11_TOMATO_1, "PM from "RED"Admin: "WHITE"%.48s ..", text);
        SendClientMessageEx(userid, X11_TOMATO_1, ""WHITE".. %s", text[48]);
        //
        SendTesterMessage(X11_TOMATO_1, "(!) "YELLOW"%s "WHITE"PMED to "COL_RED"%s"WHITE"(%d)", ReturnAdminName(playerid), ReturnName2(userid,0), userid);
        SendTesterMessage(X11_TOMATO_1, "(!) Text: "YELLOW"%.64s ..", text);
        SendTesterMessage(X11_TOMATO_1, "(!) Text: "YELLOW".. %s", text[64]);
        return 1;
    }

    SendClientMessageEx(userid, X11_TOMATO_1, "PM from "RED"Admin: "WHITE"%s", text);
    //
    SendTesterMessage(X11_TOMATO_1, "(!) "YELLOW"%s "WHITE"PMED to "COL_RED"%s"WHITE"(%d)", ReturnAdminName(playerid), ReturnName2(userid,0), userid);
    SendTesterMessage(X11_TOMATO_1, "(!) Text: "YELLOW"%s", text);
    return 1;
}

CMD:gotocar(playerid, params[])
{
    new vehicleid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "d", vehicleid))
        return SendSyntaxMessage(playerid, "/gotocar [veh]");

    if(vehicleid < 1 || vehicleid > GetVehiclePoolSize() || !IsValidVehicle(vehicleid))
        return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

    new Float:x, Float:y, Float:z;

    GetVehiclePos(vehicleid, x, y, z);

    SetPlayerPos(playerid, x, y, z + 3);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(vehicleid));
    return 1;
}

CMD:getcar(playerid, params[])
{
    new vehicleid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "d", vehicleid))
        return SendSyntaxMessage(playerid, "/getcar [veh]");

    if(vehicleid < 1 || vehicleid > GetVehiclePoolSize() || !IsValidVehicle(vehicleid))
        return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, z, z, z);

    GetXYInFrontOfPlayer(playerid, x, y, 3.0);
    SetVehiclePos(vehicleid, x, y, z);

    SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
    LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
    return 1;
}

CMD:entercar(playerid, params[])
{
    new vehicleid, seatid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "d", vehicleid))
        return SendSyntaxMessage(playerid, "/entercar [veh]");

    if(vehicleid < 1 || vehicleid > GetVehiclePoolSize() || !IsValidVehicle(vehicleid))
        return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

    seatid = GetAvailableSeat(vehicleid, 0);

    if(seatid == -1)
        return SendErrorMessage(playerid, "There are no seats left to enter.");

    PutPlayerInVehicleEx(playerid, vehicleid, seatid);
    return 1;
}

CMD:gethere(playerid, params[])
{
    new userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/gethere [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(!IsPlayerSpawned(userid))
        return SendErrorMessage(playerid, "You can't teleport a player that's not spawned.");

    SendPlayerToPlayer(userid, playerid);
    SendCustomMessage(userid, "TELEPORT", "You have been teleported by "RED"%s", ReturnName(playerid));
    SendServerMessage(playerid, "You have teleported "RED"%s "WHITE"to you.", ReturnName(userid, 0));
    return 1;
}

CMD:mark(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);
    
    GetPlayerPos(playerid, PlayerData[playerid][pAdmMark][0], PlayerData[playerid][pAdmMark][1], PlayerData[playerid][pAdmMark][2]);
    PlayerData[playerid][pAdmMarkInt] = GetPlayerInterior(playerid);
    PlayerData[playerid][pAdmMarkVW] = GetPlayerVirtualWorld(playerid);
    SendClientMessage(playerid, COLOR_CLIENT, "ADMIN: You've been set your "YELLOW"mark location!");
    return 1;
}

CMD:gotomark(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    SetPlayerPos(playerid, PlayerData[playerid][pAdmMark][0], PlayerData[playerid][pAdmMark][1], PlayerData[playerid][pAdmMark][2]);
    SetPlayerInterior(playerid, PlayerData[playerid][pAdmMarkInt]);
    SetPlayerVirtualWorld(playerid, PlayerData[playerid][pAdmMarkVW]);
    SendClientMessage(playerid, COLOR_CLIENT, "Teleport: "WHITE"You have been teleport to the "YELLOW"marked location!");
    return 1;
}

CMD:checknumber(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);
        
    if(isnull(params) || strlen(params) > 24)
        return SendSyntaxMessage(playerid, "/checknumber [phone number]");

    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `Character` FROM `characters` WHERE `Phone` = '%d';", strval(params)));
    if(cache_num_rows()) {
        new name[MAX_PLAYER_NAME];
        cache_get_field_content(0, "Character", name);
        SendServerMessage(playerid, "Nomor "LIGHTBLUE"%d "WHITE"milik akun "YELLOW"%s.", strval(params), name);
    }
    else SendErrorMessage(playerid, "Tidak ada karakter yang menggunakan nomor tersebut.");
    cache_delete(execute);
    return 1;
}

CMD:checkmask(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);
        
    if(isnull(params) || strlen(params) > 24)
        return SendSyntaxMessage(playerid, "/checknumber [mask number]");

    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `Character` FROM `characters` WHERE `MaskID` = '%d';", strval(params)));
    if(cache_num_rows()) {
        new name[MAX_PLAYER_NAME];
        cache_get_field_content(0, "Character", name);
        SendServerMessage(playerid, "Mask id "LIGHTBLUE"%d "WHITE"milik akun "YELLOW"%s.", strval(params), name);
    }
    else SendErrorMessage(playerid, "Tidak ada karakter yang menggunakan mask tersebut.");
    cache_delete(execute);
    return 1;
}

CMD:masked(playerid, params[])
{
    if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    SendClientMessage(playerid, X11_GREY_60, "-----------------------------------------------------------");

    foreach (new i : Player) if(PlayerData[i][pMaskOn]) {
        SendClientMessageEx(playerid, X11_WHITE, "* %s (#%d)", ReturnName(i, 0), PlayerData[i][pMaskID]);
    }
    SendClientMessage(playerid, X11_GREY_60, "-----------------------------------------------------------");
    return 1;
}

CMD:maxenergy(playerid, params[])
{
    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    SetPlayerHunger(playerid, 100);
    SetPlayerEnergy(playerid, 100);
    SendServerMessage(playerid, "Kamu telah melakukan refill untuk "GREEN"body status mu.");
    return 1;
}

CMD:aslap(playerid, params[])
{
    new userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/aslap [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(userid, x, y, z);
    SetPlayerPos(userid, x, y, z + 5);

    PlayerPlaySound(userid, 1130, 0.0, 0.0, 0.0);
    return 1;
}

CMD:aremovecall(playerid, params[])
{
    new vehicleid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "i", vehicleid)) 
        return SendErrorMessage(playerid, "Must enter a vehicle ID.");

    if(vehicleid < 1 || vehicleid > GetVehiclePoolSize() || !IsValidVehicle(vehicleid))
        return SendErrorMessage(playerid, "You have specified an invalid vehicle ID.");

    Delete3DTextLabel(vehicle3Dtext[vehicleid]);
    SendServerMessage(playerid, "Kamu telah menghapus "RED"callsign "WHITE"pada kendaraan tersebut.");
    return 1;
}

CMD:changeboard(playerid, params[])
{
    new text[128],string[128];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(!IsPlayerInNewbieSchool(playerid))
        return SendErrorMessage(playerid, "You're not in newbie school.");

    if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) != 0)
        return SendErrorMessage(playerid, "Auction telah berlangsung, jangan di ubah dahulu sebelum selesai.");

    if(sscanf(params, "s[128]", text))
        return SendSyntaxMessage(playerid, "/changeboard [text]");

    if(strlen(text) > 128)
        return SendErrorMessage(playerid, "Text terlalu panjang.");

    FixText(text);
    format(string,sizeof(string), "%s",ColouredText(text));
    
    SetDynamicObjectMaterialText(newbieschool, 0, string, 130, "Ariel", 27, 1, -1, -16777216, 1);
    return 1;
}

CMD:spawn(playerid, params[])
{
    new Float:x, Float:y, Float:z, interior;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "dfff", interior, x, y, z))
        return SendSyntaxMessage(playerid, "/spawn [interior] [x] [y] [z]");

    SetPlayerPos(playerid, x, y, z);
    SetPlayerInterior(playerid, interior);
    return 1;
}

CMD:sethp(playerid, params[])
{
    new userid, Float:amount;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "uf", userid, amount))
        return SendSyntaxMessage(playerid, "/sethp [playerid/PartOfName] [amount]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(amount > 100 || amount < 0)
        return SendErrorMessage(playerid, "Amount of sethp must between 0 - 100");

    SetHealth(userid, amount);
    SendServerMessage(playerid, "You have set %s's health to %.2f.", ReturnName(userid, 0), amount);
    return 1;
}

CMD:revive(playerid, params[])
{
    new userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/revive [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(!PlayerData[userid][pInjured])
        return SendErrorMessage(playerid, "You can't revive a player that's not injured.");

    if(IsPlayerDuty(userid)) RefreshFactionWeapon(userid);
    else RefreshWeapon(userid);

    ClearAnimations(userid);

    PlayerData[userid][pInjured] = 0;
    PlayerData[userid][pGiveupTime] = 0;
    PlayerData[userid][pDead] = 100.0;
    PlayerData[userid][pBandage] = 0;

    SetPVarInt(userid, "GiveUptime", 0);
    SetHealth(userid, 100);

    SetPlayerArmedWeapon(userid, 0);
    TextDrawHideForPlayer(userid, gServerTextdraws[0]);

    InjuredTag(userid, false, false, true);
    PlayerDeath[userid] = 0;

    SendAdminAction(playerid, "You have revived %s's character.", ReturnName(userid, 0));
    SendAdminAction(userid, "%s has revived your character.", ReturnName(playerid, 0));
    return 1;
}

CMD:jetpack(playerid, params[])
{
    new userid;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
    {
        PlayerData[playerid][pJetpack] = 1;
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    }
    else
    {
        PlayerData[userid][pJetpack] = 1;
        SetPlayerSpecialAction(userid, SPECIAL_ACTION_USEJETPACK);
        SendServerMessage(playerid, "You have spawned a jetpack for %s.", ReturnName(userid, 0));
    }
    return 1;
}

CMD:jailed(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    new times[3];

    SendClientMessage(playerid, X11_WHITE, "Jailed list:");

    foreach (new i : Player) if(PlayerData[i][pJailTime]) {
        GetElapsedTime(PlayerData[i][pJailTime], times[0], times[1], times[2]);

        SendClientMessageEx(playerid, X11_WHITE, "* "COL_LIGHTBLUE"%s "WHITE"(time left %02d hours %02d min %02d sec) | Reason: "YELLOW"%s "WHITE"(%s)", ReturnName(i, 0), times[0], times[1], times[2], PlayerData[i][pJailReason], PlayerData[i][pJailedBy]);
    }
    return 1;
}

CMD:checkitem(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);
    
    new targetid;

    if(sscanf(params, "u", targetid))
        return SendSyntaxMessage(playerid, "/checkitem [playerid/PartOfName]");

    if(targetid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Invalid Player ID!");

    Player_Item(playerid, targetid);
    return 1;
}

CMD:togod(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    SetGVarInt("toggleOOCDept", GetGVarInt("toggleOOCDept", GLOBAL_VARTYPE_INT) ? false : true, GLOBAL_VARTYPE_INT);
    SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s telah %s OOC department chat.", ReturnAdminName(playerid), GetGVarInt("toggleOOCDept", GLOBAL_VARTYPE_INT) ? ("menonaktifkan") : ("mengaktifkan"));
    return 1;
}

CMD:togor(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    SetGVarInt("toggleOOCRadio", GetGVarInt("toggleOOCRadio", GLOBAL_VARTYPE_INT) ? false : true, GLOBAL_VARTYPE_INT);
    SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s telah %s OOC department chat.", ReturnAdminName(playerid), GetGVarInt("toggleOOCRadio", GLOBAL_VARTYPE_INT) ? ("menonaktifkan") : ("mengaktifkan"));
    return 1;
}

CMD:newbies(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/newbies [level (1-3)]");

    if(!(0 < strval(params) <= 3))
        return SendErrorMessage(playerid, "Level hanya dibatasi dari 0 sampai 3");

    new output[1000];
    strcat(output, "Name\tMoney\tBank\n");
    foreach(new i : Player) if(GetPlayerScore(i) == strval(params)) {
        strcat(output, sprintf("%s\t%s\t%s\n", ReturnName(i, 0), FormatNumber(GetMoney(i)), FormatNumber(GetBank(i))));
    }
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Newbie Level: %d", strval(params)), output, "Close", "");
    return 1;
}

CMD:fine(playerid, params[])
{
    new userid, amount, reason[32];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "uds[32]", userid, amount, reason))
        return SendSyntaxMessage(playerid, "/fine [playerid/PartOfName] [money] [reason]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut tidak login ke server.");

    if(!(0 < amount <= 100000))
        return SendErrorMessage(playerid, "Uang dibatasi mulai dari 0 sampai 100000!");

    GiveMoney(userid, -amount, ECONOMY_ADD_SUPPLY, "fined by admin");
    SendServerMessage(userid, "Kamu didenda oleh admin "RED"%s "WHITE"sebanyak "RED"-%s.", ReturnAdminName(playerid), FormatNumber(amount));
    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s was fined by %s for %s. Reason %s.", ReturnName(userid, 0), ReturnName(playerid, 0), FormatNumber(amount), reason);
    Log_Save(E_LOG_FINE, sprintf("[%s] %s was fined %s for %s, reason: %s.", ReturnDate(), ReturnName(playerid, 0), ReturnName(userid, 0), FormatNumber(amount), reason));
    return 1;
}

CMD:ofine(playerid, params[])
{
    new character[MAX_PLAYER_NAME], reason[24], amount;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "s[24]ds[24]", character, amount, reason))
        return SendSyntaxMessage(playerid, "/ofine [character name] [money] [reason]");

    if(!(0 < amount <= 100000))
        return SendErrorMessage(playerid, "Uang dibatasi mulai dari 0 sampai 100000!");

    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `Money` FROM `characters` WHERE `Character`='%s'", character));

    if(cache_num_rows())
    {
        new money = cache_get_row_int(0, 0),
            fined = money - amount;

        mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `Money`='%d' WHERE `Character`='%s';", fined, character));

        SendServerMessage(playerid, "%s: last money: "GREEN"%s"WHITE" | current money: "RED"-%s", character, FormatNumber(money), FormatNumber(fined));
        SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s was offline fined by %s for %s. Reason %s.", character, ReturnName(playerid, 0), FormatNumber(amount), reason);
        Log_Save(E_LOG_OFFLINE_FINE, sprintf("[%s] %s was offline fined %s for %s, reason: %s.", ReturnDate(), ReturnName(playerid, 0), character, FormatNumber(amount), reason));
    }
    else SendErrorMessage(playerid, "Character tidak teradftar diserver!");

    cache_delete(execute);
    return 1;
}
CMD:ofinecoin(playerid, params[])
{
    new character[MAX_PLAYER_NAME], reason[24], amount;

    if (CheckAdmin(playerid, 6))
        return PermissionError(playerid);

    if(sscanf(params, "s[24]ds[24]", character, amount, reason))
        return SendSyntaxMessage(playerid, "/ofinecoin [character name] [coin] [reason]");

    if(!(0 < amount <= 100000))
        return SendErrorMessage(playerid, "coin dibatasi mulai dari 0 sampai 100000!");

    new Cache:execute;
    
    execute = mysql_query(g_iHandle, sprintf("SELECT `coins`,`pid` FROM `donation_coin_list` LEFT JOIN `characters` ON donation_coin_list.pid=characters.ID WHERE `Character` = '%s';", SQL_ReturnEscaped(character)));

    if(cache_num_rows())
    {
        new coin = cache_get_field_int(0, "coins"),
            pid = cache_get_field_int(0, "pid"),
            fined = coin - amount;

        mysql_tquery(g_iHandle, sprintf("UPDATE `donation_coin_list` SET `coins`='%d' WHERE `pid`='%d';", fined, pid));

        SendServerMessage(playerid, "%s: last coin: "GREEN"%d"WHITE" | current coin: "RED"-%d", character, coin, fined);
        SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s was offline fined by %s for %d. Reason %s.", character, ReturnName(playerid, 0), amount, reason);
        Log_Save(E_LOG_OFFLINE_FINE_COIN, sprintf("[%s] %s was offline fined %s for %s, reason: %s.", ReturnDate(), ReturnName(playerid, 0), character, FormatNumber(amount), reason));
    }
    else SendErrorMessage(playerid, "Character tidak teradftar diserver!");

    cache_delete(execute);
    return 1;
}
CMD:ostats(playerid, params[])
{
    new username[MAX_PLAYER_NAME];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "s["#MAX_PLAYER_NAME"]", username))
        return SendSyntaxMessage(playerid, "/ostats [character name]");

    if(strlen(username) < 3)
        return SendErrorMessage(playerid, "Nama terlalu pendek, minimal 3 karakter.");

    if(strlen(username) > 24)
        return SendErrorMessage(playerid, "Nama terlalu panjang, maksimal 24 karakter.");

    new
        query[833]
    ;

    mysql_format(g_iHandle, query, sizeof(query), "" \
        "SELECT" \
        "    `characters`.`ID`," \
        "    `characters`.`Character`," \
        "    `characters`.`Username`," \
        "    `characters`.`Job`," \
        "    `characters`.`World`," \
        "    `characters`.`Money`," \
        "    `characters`.`Phone`," \
        "    `characters`.`Gender`," \
        "    `characters`.`BankMoney`," \
        "    `characters`.`Faction`," \
        "    `characters`.`Interior`," \
        "    `characters`.`MaskID`," \
        "    `characters`.`Warnings`," \
        "    `characters`.`FactionRank`," \
        "    `characters`.`RegisterDate`," \
        "    `characters`.`PlayingHours`," \
        "    `characters`.`pScore`," \
        "    `characters`.`Played`," \
        "    `characters`.`Origin`," \
        "    `characters`.`Birthdate`," \
        "    `accounts`.`Admin`" \
        "FROM" \
        "    `characters`" \
        "LEFT JOIN `accounts` ON `accounts`.`Username` = `characters`.`Username`" \
        "WHERE" \
        "    `characters`.`Character` = '%e'" \
        "    OR `characters`.`ID` = '%e'"
        , username
        , username);

    mysql_tquery(g_iHandle, query, "OnPlayerLookupCharStats", "d", playerid);
    return 1;
}

CMD:acpcharacters(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/acpcharacters [acp name]");

    if(strlen(params) > MAX_PLAYER_NAME)
        return SendErrorMessage(playerid, "Masukan nama acp hanya dibatasi 24 karakter!");

    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `Character`, `pScore` FROM `characters` WHERE `Username`='%s';", params));

    if(cache_num_rows())
    {
        new username[MAX_PLAYER_NAME], output[128], level;

        strcat(output, "Character\tLevel\n");
        for(new i = 0; i != cache_num_rows(); i++) {
            cache_get_field_content(i, "Character", username, MAX_PLAYER_NAME);
            level = cache_get_field_int(i, "pScore");

            strcat(output, sprintf("%s\t%d\n", username, level));
        }
        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Character List: %s", params), output, "Close", "");
    }
    else SendErrorMessage(playerid, "Tidak ada karakter di ACP ini!.");
    cache_delete(execute);
    return 1;
}
CMD:setadmin(playerid, params[])
{
    if (CheckAdmin(playerid, 9))
        return PermissionError(playerid);

    new targetid, level;
            
    if(sscanf(params, "ud", targetid, level))
        return SendSyntaxMessage(playerid, "/setadmin [playerid/PartOfName] [level]");
            
    if(targetid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut tidak login kedalam server.");
            
    AccountData[targetid][pAdmin] = level;
    AccountData[targetid][pAdminHide] = 0;
    format(AccountData[targetid][pAdminRankName], 24, gAdminLevel[level]);
    mysql_tquery(g_iHandle, sprintf("UPDATE `accounts` SET `AdminRankName`='%s', `Admin`='%d' WHERE `ID`='%d';", AccountData[targetid][pAdminRankName], level, GetUCPSQLID(targetid)));

    SendAdminAction(targetid, "%s telah %s menjadi admin level %d.", ReturnAdminName(playerid), (level <= 0) ? ("menurunkanmu") : ("mempromosikanmu"), level);
    SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s telah %s %s menjadi admin level %d.", ReturnAdminName(playerid), (level <= 0) ? ("menurunkanmu") : ("mempromosikanmu"), ReturnName(targetid), level);
    Log_Save(E_LOG_SET_ADMIN, sprintf("[%s] %s menjadikan %s admin level %d", ReturnDate(), ReturnName(playerid), ReturnName(targetid), level));
    return 1;
}

CMD:setrankname(playerid, params[])
{
    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    new name[25], userid;

    if(sscanf(params,"us[25]", userid, name))
        return SendSyntaxMessage(playerid, "/setrankname [userid] [name]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut tidak login keserver!");

    if (CheckAdmin(playerid, 0))
        return SendErrorMessage(playerid, "Player tersebut bukan admin");

    format(AccountData[userid][pAdminRankName], 25, name);
    mysql_tquery(g_iHandle, sprintf("UPDATE `accounts` SET `AdminRankName`='%s' WHERE `ID`='%d';", name, GetUCPSQLID(userid)));
    SendServerMessage(playerid, "Kamu telah mengganti rankname "YELLOW"%s "WHITE"menjadi "LIGHTBLUE"%s", ReturnAdminName(userid), name);
    return 1;
}

CMD:ahide(playerid, params[])
{
    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    AccountData[playerid][pAdminHide] = AccountData[playerid][pAdminHide] ? (false) : (true);
    mysql_tquery(g_iHandle, sprintf("UPDATE `accounts` SET `AdminHide`='%d' WHERE `ID`='%d';", AccountData[playerid][pAdminHide], GetUCPSQLID(playerid)));
    SendServerMessage(playerid, "Nama kamu "YELLOW"%s "WHITE"pada admin list!.", AccountData[playerid][pAdminHide] ? ("disembunyikan") : ("perlihatkan"));
    return 1;
}

CMD:resetpassword(playerid, params[])
{
    new password[32], accounts[MAX_PLAYER_NAME];

    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    if(sscanf(params, "s[24]s[32]", accounts, password))
        return SendSyntaxMessage(playerid, "/resetpassword [ACP name] [password 32 char]");

    if(!(8 < strlen(password) < 32))
        return SendErrorMessage(playerid, "Password harus sebanyak 8 sampai 32 karakter.");

    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `Username`, `Salt`, `ID` FROM `accounts` WHERE `Username`='%s';", accounts));

    if(cache_num_rows())
    {
        new salt[65], hash[65], output[400];
        cache_get_field_content(0, "Salt", salt);

        SHA256_PassHash(password, salt, hash, 65);

        format(output, sizeof output, "UPDATE `accounts` SET `Password` = '%s' WHERE `ID` = '%d';", hash, cache_get_field_int(0, "ID"));
        mysql_tquery(g_iHandle, output);

        SendServerMessage(playerid, "ACP "RED"%s "WHITE"telah direset passwordnya menjadi "GREEN"%s", accounts, password);
        Log_Save(E_LOG_ADMIN_RESET_PASSWORD, sprintf("[%s] %s reset %s password", ReturnDate(), ReturnName(playerid), accounts));
    }
    else SendErrorMessage(playerid, "Nama ACP tidak ditemukan!");

    cache_delete(execute);
    return 1;
}

CMD:changeacpname(playerid, params[])
{
    new userid, username[MAX_PLAYER_NAME];

    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    if(sscanf(params, "us[24]", userid, username))
        return SendSyntaxMessage(playerid, "/changeacpname [playerid/PartOfName] [new name]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut tidak terhubung keserver!");
    
    if(IsValidRoleplayName(username))
        return SendErrorMessage(playerid, "Jangan menggunakan nama yang berformat roleplay!");

    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `Username` FROM `accounts` WHERE `Username`='%s';", username));

    if(!cache_num_rows())
    {
        mysql_tquery(g_iHandle, sprintf("UPDATE `accounts` SET `Username`='%s' WHERE `Username`='%s';", username, ReturnAdminName(userid)));
        mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `Username`='%s' WHERE `Username`='%s';", username, ReturnAdminName(userid)));

        SendServerMessage(userid, ""RED"%s "WHITE"mengganti nama ACP mu menjadi "YELLOW"%s.", ReturnAdminName(playerid), username);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: ACP %s telah diganti menjadi %s oleh %s", ReturnAdminName(userid), username, ReturnAdminName(playerid));

        Discord_Log(SETNAMELOG, sprintf("%s mengganti ACP name %s menjadi %s.", ReturnAdminName(playerid), ReturnAdminName(userid), username));
        Log_Save(E_LOG_SET_ACP_NAME, sprintf("%s mengganti ACP name %s menjadi %s.", ReturnAdminName(playerid), ReturnAdminName(userid), username));
        format(AccountData[userid][pUsername], MAX_PLAYER_NAME, username);
    }
    else SendErrorMessage(playerid, "Nama ACP sudah terdaftar!");

    cache_delete(execute);
    return 1;
}