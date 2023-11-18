CMD:ban(playerid, params[])
{
    new userid, reason[128];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "us[128]", userid, reason))
        return SendSyntaxMessage(playerid, "/ban [playerid/PartOfName] [reason]");

    if(userid == INVALID_PLAYER_ID || (!IsPlayerConnected(userid) && PlayerData[userid][pKicked]))
        return SendErrorMessage(playerid, "Player tersebut tidak login didalam server.");

    if(AccountData[userid][pAdmin] > AccountData[userid][pAdmin])
        return SendErrorMessage(playerid, "Level admin yang ingin kamu ban lebih tinggi darimu.");

    AdminActivity_Write(
		playerid,
		userid,
		ADMIN_ACTIVITY_BAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) bans %s (playerid=%d, IP=%s). Reason: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,ReturnName(userid, 0)
			,userid
			,ReturnIP(userid)
            ,reason
		)
	);

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s was banned by %s.", ReturnName(userid, 0), ReturnAdminName(playerid));
    SendClientMessageToAllEx(X11_TOMATO_1, "Reason: %s", reason);
    AccountData[playerid][pAdminBanned]++;
    SQL_SaveAccounts(playerid);

    Blacklist_Add("", NormalName(userid), "", ReturnAdminName(playerid), reason);
    Dialog_Show(userid, ShowOnly, DIALOG_STYLE_MSGBOX, "Banned", ""WHITE"Your account has been banned by the server.\n\n"WHITE"Username: "COL_RED"%s\n"WHITE"Reason: "COL_RED"%s\n"WHITE"Admin who banned you: "COL_RED"%s\n\n"WHITE"Press F8 to take a screenshot and request a ban appeal on our forums.", "Close", "", ReturnName(userid), reason, ReturnAdminName(playerid));

    Log_Save(E_LOG_BAN, sprintf("[%s] %s was banned by %s for: %s.", ReturnDate(), ReturnName(userid, 1), ReturnAdminName(playerid), reason));
    KickEx(userid);
    return 1;
}

CMD:unban(playerid, params[])
{
    new character[MAX_PLAYER_NAME];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "s[24]", character))
        return SendSyntaxMessage(playerid, "/unban [character name]");

    if(strlen(character) > 24)
        return SendErrorMessage(playerid, "Nama karakter tidak bisa lebih dari 24 karakter.");

    if(!Blacklist_Exists("Characters", character))
        return SendErrorMessage(playerid, "Nama karakter tidak terdaftar diserver.");

    AdminActivity_Write(
		playerid,
		INVALID_PLAYER_ID,
		ADMIN_ACTIVITY_UNBAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) unbans %s."
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,character
		)
	);

    Blacklist_RemoveChar(character);
    SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has unbanned character name \"%s\".", ReturnAdminName(playerid), character);
    AccountData[playerid][pAdminUnbanned]++;
    SQL_SaveAccounts(playerid);

    Log_Save(E_LOG_BAN, sprintf("[%s] %s has unbanned character named \"%s\".", ReturnDate(), ReturnAdminName(playerid), character));
    return 1;
}

CMD:banacp(playerid, params[])
{
    new username[MAX_PLAYER_NAME], reason[124];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);
    
    if(sscanf(params, "s[24]s[124]", username, reason))
        return SendSyntaxMessage(playerid, "/banacp [accounts name] [reason]");

    if(!Blacklist_ACPExists("Username", username))
        return SendErrorMessage(playerid, "Nama ACP tidak terdaftar diserver.");

    if(Blacklist_Exists("Username", username))
        return SendErrorMessage(playerid, "Nama telah dibanned sebelumnya.");

    AdminActivity_Write(
		playerid,
		INVALID_PLAYER_ID,
		ADMIN_ACTIVITY_BAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) bans account %s. Reason: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
            ,username
            ,reason
		)
	);

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: ACP %s was banned by %s.", username, ReturnAdminName(playerid));
    SendClientMessageToAllEx(X11_TOMATO_1, "Reason: %s", reason);
    AccountData[playerid][pAdminBanned]++;
    SQL_SaveAccounts(playerid);

    foreach(new i : Player) if(!strcmp(ReturnAdminName(i), username)) {
        KickEx(i);
    }

    Blacklist_Add("", "", username, ReturnAdminName(playerid), reason);
    Log_Save(E_LOG_ACP_BAN, sprintf("[%s] %s was banned by %s for: %s.", ReturnDate(), username, ReturnAdminName(playerid), reason));
    return 1;
}

CMD:unbanacp(playerid, params[])
{
    new username[MAX_PLAYER_NAME];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "s[24]", username))
        return SendSyntaxMessage(playerid, "/unbanacp [accounts name]");

    if(!Blacklist_Exists("Username", username))
        return SendErrorMessage(playerid, "Nama UCP tidak dalam list banned.");

    AdminActivity_Write(
		playerid,
		INVALID_PLAYER_ID,
		ADMIN_ACTIVITY_UNBAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) unbans account %s."
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,username
		)
	);

    Blacklist_RemoveACP(username);
    AccountData[playerid][pAdminUnbanned]++;
    SQL_SaveAccounts(playerid);

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s has been unbanned ACP owned by %s.", ReturnAdminName(playerid), username);
    Log_Save(E_LOG_ACP_BAN, sprintf("[%s] %s has unbanned account \"%s\".", ReturnDate(), ReturnAdminName(playerid), username));
    return 1;
}

CMD:oban(playerid, params[])
{
    new character[MAX_PLAYER_NAME], reason[128];
        
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "s[24]s[124]", character, reason))
        return SendSyntaxMessage(playerid, "/o(ffline)ban [character name] [reason]");
        
    if(!IsValidRoleplayName(character))
        return SendErrorMessage(playerid, "Format nama tidak sesuai, gunakan format nama roleplay.");

    if(!Blacklist_CharExists("Character", character))
        return SendErrorMessage(playerid, "Nama karakter tidak terdaftar diserver.");

    if(Blacklist_Exists("Characters", character))
        return SendErrorMessage(playerid, "Nama karakter telah dibanned sebelumnya.");

    Blacklist_Add("", character, "", ReturnAdminName(playerid), reason);

    AdminActivity_Write(
		playerid,
		INVALID_PLAYER_ID,
		ADMIN_ACTIVITY_BAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) offline bans character %s. Reason: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,character
            ,reason
		)
	);

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s has offline banned %s", ReturnAdminName(playerid), character);
    SendClientMessageToAllEx(X11_TOMATO_1, "Reason: %s ", reason);
    AccountData[playerid][pAdminBanned]++;
    SQL_SaveAccounts(playerid);

    Log_Save(E_LOG_BAN, sprintf("[%s] %s has offline banned \"%s\" reason: %s.", ReturnDate(), ReturnAdminName(playerid), character, reason));
    return 1;
}

CMD:banip(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    new ip[16], reason[128];
        
    if(sscanf(params, "s[16]s[124]", ip, reason))
        return SendSyntaxMessage(playerid, "/banip [ip address] [reason]");

    if(!IsAnIP(ip))
        return SendErrorMessage(playerid, "Format ip salah, ikuti format berikut: xx.xx.xx.xx");

    if(Blacklist_Exists("IP", ip))
        return SendErrorMessage(playerid, "IP telah dibanned sebelumnya.");

    Blacklist_Add(ip, "", "", ReturnAdminName(playerid), reason);

    AdminActivity_Write(
		playerid,
		INVALID_PLAYER_ID,
		ADMIN_ACTIVITY_BAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) bans IP address %s. Reason: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,ip
            ,reason
		)
	);

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s has banned IP address \"%s\"", ReturnAdminName(playerid), ip);
    SendClientMessageToAllEx(X11_TOMATO_1, "Reason: %s", reason);
    AccountData[playerid][pAdminBanned]++;
    SQL_SaveAccounts(playerid);

    foreach (new i : Player) if(!strcmp(ReturnIP(i), ip)) {
        KickEx(i);
    }
    Log_Save(E_LOG_IP_BAN, sprintf("[%s] %s has banned IP \"%s\".", ReturnDate(), ReturnAdminName(playerid), ip));
    return 1;
}

CMD:unbanip(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    new ip[16];
        
    if(sscanf(params, "s[16]", ip))
        return SendSyntaxMessage(playerid, "/unbanip [ip address]");

    if(!IsAnIP(ip))
        return SendErrorMessage(playerid, "Format ip salah, ikuti format berikut: xx.xx.xx.xx");

    if(!Blacklist_Exists("IP", ip))
        return SendErrorMessage(playerid, "IP tidak ada dalam daftar banned.");

    AdminActivity_Write(
		playerid,
		INVALID_PLAYER_ID,
		ADMIN_ACTIVITY_UNBAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) unbans IP address %s."
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,ip
		)
	);

    Blacklist_RemoveIP(ip);
    AccountData[playerid][pAdminUnbanned]++;
    SQL_SaveAccounts(playerid);

    SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has unbanned IP \"%s\".", ReturnAdminName(playerid), ip);
    Log_Save(E_LOG_IP_BAN, sprintf("[%s] %s has unbanned IP \"%s\".", ReturnDate(), ReturnAdminName(playerid), ip));
    return 1;
}

CMD:tempban(playerid, params[])
{
    new userid, day, reason[64];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "uds[64]", userid, day, reason)) 
        return SendSyntaxMessage(playerid, "/tempban [playerid/PartOfName] [day(s)] [reason]");

    if(userid == INVALID_PLAYER_ID || (!IsPlayerConnected(userid) && PlayerData[userid][pKicked]))
        return SendErrorMessage(playerid, "Player tersebut tidak login didalam server.");

    if(day < 0 || day > 30) 
        return SendErrorMessage(playerid, "Hari dibatasi dari 0 - 30.");

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have been temporary banned %d day(s) by %s for %s", ReturnName(userid, 0), day, ReturnAdminName(playerid), reason);
    
    Blacklist_Add("", ReturnName(userid), "", ReturnAdminName(playerid), reason, day);

    AdminActivity_Write(
		playerid,
		INVALID_PLAYER_ID,
		ADMIN_ACTIVITY_BAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) temporary bans %s (playerid=%d, IP=%s). Reason: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
            ,ReturnName(userid, 0)
			,userid
			,ReturnIP(userid)
            ,reason
		)
	);

    KickEx(userid);

    Log_Save(E_LOG_TEMP_BAN, sprintf("[%s] %s was temporary banned by %s (%d days) for: %s.", ReturnDate(), ReturnName(userid), ReturnAdminName(playerid), day, reason));
    return 1;
}

CMD:otempban(playerid, params[])
{
    new day, reason[64], character[MAX_PLAYER_NAME];

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "s["#MAX_PLAYER_NAME"]ds[32]", character, day, reason)) 
        return SendSyntaxMessage(playerid, "/otempban [character name] [day(s)] [reason]");

    if(day < 0 || day > 30) 
        return SendErrorMessage(playerid, "Hari dibatasi dari 0 - 30.");

    if(Blacklist_Exists("Characters", character))
        return SendErrorMessage(playerid, "Nama karakter telah dibanned sebelumnya.");

    SendClientMessageToAllEx(X11_TOMATO_1, "AdmCmd: %s have been offline temporary banned %d day(s) by %s for %s", character, day, ReturnAdminName(playerid), reason);
    AccountData[playerid][pAdminBanned]++;

    Blacklist_Add("", character, "", ReturnAdminName(playerid), reason, day);

    AdminActivity_Write(
		playerid,
		INVALID_PLAYER_ID,
		ADMIN_ACTIVITY_BAN,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) offline temporary bans %s. Reason: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
            ,character
            ,reason
		)
	);

    Log_Save(E_LOG_TEMP_BAN, sprintf("[%s] %s was temporary offline banned by %s (%d days) for: %s.", ReturnDate(), character, ReturnAdminName(playerid), day, reason));
    return 1;
}

CMD:baninfo(playerid, params[])
{
    new Cache:execute;

    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(isnull(params) || strlen(params) > 24)
        return SendSyntaxMessage(playerid, "/baninfo [character username].");

    if(!Blacklist_Exists("Characters", params))
        return SendErrorMessage(playerid, "Nama karakter tidak dalam daftar banned.");

    execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `blacklist` WHERE `Characters` = '%s'", SQL_ReturnEscaped(params)));

    new reason[64], banby[24], time, date;

    if(cache_num_rows()) 
    {
        time = cache_get_field_int(0, "Temp");
        date = cache_get_field_int(0, "Date");

        cache_get_field_content(0, "BannedBy", banby);
        cache_get_field_content(0, "Reason", reason);

        if(time) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Banned Info", ""WHITE"Ban Lookup: "RED"%s\n"WHITE"Date Banned: "RED"%s\n"WHITE"By Admin/Helper: "RED"%s\n"WHITE"Reason: "RED"%s\n\n"WHITE"Unban Date: "RED"%s", "Close", "", params, ConvertTimestamp(Timestamp:date), banby, reason, ConvertTimestamp(Timestamp:time));
        else Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Banned Info", ""WHITE"Ban Lookup: "RED"%s\n"WHITE"Date Banned: "RED"%s\n"WHITE"By Admin/Helper: "RED"%s\n"WHITE"Reason: "RED"%s\n\n"WHITE"Unban Date: "RED"Permanent", "Close", "", params, ConvertTimestamp(Timestamp:date), banby, reason);
    }
    cache_delete(execute);
    return 1;
}

CMD:blacklisthelp(playerid, params[])
{
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    SendServerMessage(playerid, "/ban, /unban, /banacp, /unbanacp, /banip, /unbanip, /oban, /tempban, /otempban, /baninfo.");
    return 1;
}