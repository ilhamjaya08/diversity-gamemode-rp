Blacklist_Check(playerid, const type[], target[])
{
    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `blacklist` WHERE `%s` = '%s' LIMIT 1;", type, target));

    new date, time;
    new reason[128], ip[16], username[MAX_PLAYER_NAME], characters[MAX_PLAYER_NAME], banby[MAX_PLAYER_NAME];

    if(cache_num_rows()) 
    {
        time = cache_get_field_int(0, "Temp");
        date = cache_get_field_int(0, "Date");

        cache_get_field_content(0, "IP", ip);
        cache_get_field_content(0, "Reason", reason);
        cache_get_field_content(0, "BannedBy", banby);
        cache_get_field_content(0, "Username", username);
        cache_get_field_content(0, "Characters", characters);

        if(GetPVarInt(playerid, "ACPBlacklist"))
        {
            Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Ban Notice - ACP Banned", ""WHITE"Your ACP is banned from this server.\n\nUsername: "RED"%s\n"WHITE"Date: "RED"%s\n"WHITE"Banned by admin: "RED"%s\n"WHITE"Reason: "RED"%s\n\n"WHITE"To request a ban appeal, please visit our website and submit a ban appeal.", "Close", "", AccountData[playerid][pUsername], ConvertTimestamp(Timestamp:date), banby, reason);
            DeletePVar(playerid, "ACPBlacklist");
        }
        else if(GetPVarInt(playerid, "IPBlacklist"))
        {
            Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Ban Notice - IP Banned", ""WHITE"Your IP is banned from this server.\n\nIP: "RED"%s\n"WHITE"Date: "RED"%s\n"WHITE"Banned by admin: "RED"%s\n"WHITE"Reason: "RED"%s\n\n"WHITE"To request a ban appeal, please visit our website and submit a ban appeal.", "Close", "", ReturnIP(playerid), ConvertTimestamp(Timestamp:date), banby, reason);
            DeletePVar(playerid, "IPBlacklist");
        }
        else
        {
            if(!time)
                Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Ban Notice - Character Banned", ""WHITE"You are banned from this server.\n\nCharacter: "RED"%s\n"WHITE"Date: "RED"%s\n"WHITE"Banned by admin: "RED"%s\n"WHITE"Reason: "RED"%s\n\n"WHITE"To request a ban appeal, please visit our website and submit a ban appeal.", "Close", "", ReturnName(playerid), ConvertTimestamp(Timestamp:date), banby, reason);

            else if((time) && (gettime() < time))
                Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Temp Ban - Character Banned", ""WHITE"You are banned from this server.\n\nCharacter: "RED"%s\n"WHITE"Date: "RED"%s\n"WHITE"Banned by admin: "RED"%s\n"WHITE"Reason: "RED"%s\n"WHITE"Unban Date: "RED"%s\n\n"WHITE"To request a ban appeal, please visit our website and submit a ban appeal.", "Close", "", ReturnName(playerid), ConvertTimestamp(Timestamp:date), banby, reason, ConvertTimestamp(Timestamp:time));

            else 
            {
                Blacklist_RemoveChar(ReturnName(playerid, 1));
                SendServerMessage(playerid, "Akun ini telah diunban secara otomatis, silahkan login kembali.");
            }
        }
        KickEx(playerid);
        return 1;
    }

    cache_delete(execute);
	return 0;
}

Blacklist_Exists(const type[], const target[])
{
    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `%s` FROM `blacklist` WHERE `%s` = '%s' LIMIT 1;", type, type, target));

    if(cache_num_rows()) {
        cache_delete(execute);
        return 1;
    }
    cache_delete(execute);
    return 0;
}

Blacklist_ACPExists(const type[], const target[])
{
    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `%s` FROM `accounts` WHERE `%s` = '%s' LIMIT 1;", type, type, target));

    if(cache_num_rows()) {
        cache_delete(execute);
        return 1;
    }
    cache_delete(execute);
    return 0;
}

Blacklist_CharExists(const type[], const target[])
{
    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `%s` FROM `characters` WHERE `%s` = '%s' LIMIT 1;", type, type, target));

    if(cache_num_rows()) {
        cache_delete(execute);
        return 1;
    }
    cache_delete(execute);
    return 0;
}

Blacklist_Add(const ip[], const character[], const username[], const banner[], const reason[], day = 0)
{
    new query[500];

    format(query, sizeof(query), "INSERT INTO `blacklist` (`IP`, `Username`, `Characters`, `BannedBy`, `Reason`, `Date`, `Temp`) VALUES('%s', '%s', '%s', '%s', '%s', '%i', '%i');",
        SQL_ReturnEscaped(ip), SQL_ReturnEscaped(username), SQL_ReturnEscaped(character),
        SQL_ReturnEscaped(banner), SQL_ReturnEscaped(reason), gettime(), (!day) ? 0 : (gettime()+(day*86400))
    );
    mysql_tquery(g_iHandle, query);
    return 1;
}

Blacklist_RemoveACP(const username[])
{
    mysql_tquery(g_iHandle, sprintf("DELETE FROM `blacklist` WHERE `Username` = '%s';", SQL_ReturnEscaped(username)));
    return 1;
}

Blacklist_RemoveChar(const character[])
{
    mysql_tquery(g_iHandle, sprintf("DELETE FROM `blacklist` WHERE `Characters` = '%s';", SQL_ReturnEscaped(character)));
    return 1;
}

Blacklist_RemoveIP(const ip[])
{
    mysql_tquery(g_iHandle, sprintf("DELETE FROM `blacklist` WHERE `IP` = '%s';", SQL_ReturnEscaped(ip)));
    return 1;
}

