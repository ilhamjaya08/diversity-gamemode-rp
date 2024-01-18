// VIP Generator
CMD:generatevip(playerid, params[])
{
	if(GetAdminLevel(playerid) < 8)
		return 0;

	new donations_level, donations_duration, donations_code[16];
	
	if(sscanf(params, "dd", donations_level, donations_duration))
		return SendSyntaxMessage(playerid, "/generatevip [level (1. Diamond | 2. Ruby | 3. Sapphire | 4. Emerald)] [durasi (bulan)]");

	if(!(0 < donations_level <= 4))
		return SendErrorMessage(playerid, "Level donasi dibatasi dari 1 - 4.");

	if(!(0 < donations_duration <= 24))
		return SendErrorMessage(playerid, "Durasi dibatasi dari 1 - 24 bulan.");

	new expired = gettime() + (donations_duration * 2628000);

	format(donations_code, sizeof donations_code, "U-%c%c%c%c%04d", RandomLetter(), RandomLetter(), RandomLetter(), RandomLetter(), RandomEx(1000, 9999));

	SendServerMessage(playerid, "New code "GREEN"%s", donations_code);
	SendServerMessage(playerid, "Type: "LIGHTBLUE"%s"WHITE" | Expired on "RED"%s", ReturnVIPName(donations_level), ConvertTimestamp(Timestamp:expired));

	mysql_tquery(g_iHandle, sprintf("INSERT INTO `donation_token`(`added_by`, `code`, `expired`, `type`) VALUES ('%s','%s','%d','%d');", ReturnAdminName(playerid), donations_code, expired, donations_level));
	Log_Save(E_LOG_GENERATE_VIP, sprintf("[%s] %s membuat code %s (type: %s, expired: %s).", ReturnDate(), ReturnAdminName(playerid), donations_code, ReturnVIPName(donations_level), ConvertTimestamp(Timestamp:expired)));
	return 1;
}

CMD:allvipcode(playerid, params[])
{
	if(GetAdminLevel(playerid) < 8)
		return 0;

	new Cache:execute, data[1024], code[16], added[MAX_PLAYER_NAME], expired, type, count;

	execute = mysql_query(g_iHandle, "SELECT * FROM `donation_token`;");

	if(cache_num_rows())
	{
		strcat(data, sprintf("Code\tType\tAdded\tExpired\n"));
		for(new i = 0; i != cache_num_rows(); i++) 
		{
			cache_get_field_content(i, "code", code);

			if((expired = cache_get_field_int(i, "expired")) < gettime()) {
				mysql_tquery(g_iHandle, sprintf("DELETE FROM `donation_token` WHERE `code` = '%s';", code));
				continue;
			}

			cache_get_field_content(i, "added_by", added);
			type = cache_get_field_int(i, "type");

			strcat(data, sprintf(GREEN"%s\t"WHITE"%s\t%s\t"RED"%s\n", code, ReturnVIPName(type), added, ConvertTimestamp(Timestamp:expired)));
			count++;
		}

		if(count) Dialog_Show(playerid, ShowCodes, DIALOG_STYLE_TABLIST_HEADERS, "All Codes", data, "Delete", "Close");
		else SendErrorMessage(playerid, "Tidak ada code yang dibuat!");
	}
	else SendServerMessage(playerid, "Tidak ada data code yang dapat ditampilkan!.");

	cache_delete(execute);
	return 1;
}

CMD:resetvip(playerid, params[])
{
    new userid, reason[32];

    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    if(sscanf(params, "us[32]", userid, reason))
        return SendSyntaxMessage(playerid, "/resetvip [userid] [reason]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut tidak sedang login diserver!");

    if(!IsPlayerVIP(userid))
        return SendErrorMessage(playerid, "Player tersebut bukan member VIP.");

    RemovePlayerVIP(userid);
    SendServerMessage(playerid, "Kamu telah mereset akses VIP milik "YELLOW"%s.", ReturnName(userid));
    SendServerMessage(userid, "Akses VIPmu dinonaktifkan oleh "RED"%s"WHITE" karena: "YELLOW"%s", ReturnAdminName(playerid), reason);
    Log_Save(E_LOG_RESET_VIP, sprintf("[%s] %s mereset vip %s, alasan: %s.", ReturnDate(), ReturnAdminName(playerid), ReturnName(userid, 0), reason));
    return 1;
}


// Redeem code
CMD:redeemvip(playerid, params[])
{
	if(isnull(params))
        return SendSyntaxMessage(playerid, "/redeemvip [code]");

    new Cache:execute, expired, type;

    execute = mysql_query(g_iHandle, sprintf("SELECT `expired`, `type` FROM `donation_token` WHERE `code`='%s';", SQL_ReturnEscaped(params)));
    
    if(cache_num_rows()) {
		type = cache_get_field_int(0, "type");
    	expired = cache_get_field_int(0, "expired");
		
		if(expired < gettime()){
			SendServerMessage(playerid, "VIP code telah expired!");
	    	mysql_tquery(g_iHandle, sprintf("DELETE FROM `donation_token` WHERE `code`='%s';", SQL_ReturnEscaped(params)));
		}
		else {

			SetPlayerVIP(playerid, type, expired);
			GivePlayerCoin(playerid, ReturnVIPCoin(type));

	    	SendServerMessage(playerid, "Kamu telah klaim kode "GREEN"%s.", params);
	    	SendServerMessage(playerid, "Sekarang statusmu sudah menjadi "LIGHTBLUE"%s.", ReturnVIPName(type));
	    	SendServerMessage(playerid, "Masa donaturmu akan berakhir hingga "YELLOW"%s"WHITE".", ConvertTimestamp(Timestamp:expired));
	    	SendServerMessage(playerid, "Gunakan perintah "GREY"/viphelp "WHITE"untuk melihat semua perintah donasi.");

	    	mysql_tquery(g_iHandle, sprintf("DELETE FROM `donation_token` WHERE `code`='%s';", SQL_ReturnEscaped(params)));

	    	new output[300];
	    	mysql_format(g_iHandle, output, sizeof(output), "INSERT INTO `donation_characters` (`pid`, `name`, `type`, `expired`) VALUES ('%d','%s','%d','%d') ON DUPLICATE KEY UPDATE `type`='%d', `expired`='%d';", GetPlayerSQLID(playerid), NormalName(playerid), type, expired, type, expired);
	    	mysql_tquery(g_iHandle, output);

	    	SetVIPChangeName(playerid, ReturnVIPChangeName(type));
	    	SetVIPChangeMask(playerid, ReturnVIPMask(type));
	    	SetVIPChangePhone(playerid, ReturnVIPPhone(type));

		    Log_Save(E_LOG_REDEEM_CODE, sprintf("[%s] %s menggunakan code %s (type: %s, expired: %s).", ReturnDate(), ReturnName(playerid, 0), params, ReturnVIPName(type), ConvertTimestamp(Timestamp:expired)));
	    }
    }
    else SendErrorMessage(playerid, "Kode tidak terdaftar!");

    cache_delete(execute);
	return 1;
}

// Command list
CMD:viphelp(playerid, params[])
{
	SendServerMessage(playerid, "/vip, /vips, /redeemvip, /spendcoins, /redeemcoin, /buyvipveh");

	if(GetAdminLevel(playerid) >= 8)
		SendServerMessage(playerid, "/resetvip, /finecoin, /generatevip, /allvipcode, /generatecoin, /allcoins, /addvipveh, /deletevipveh, /togvipchat");
	
	return 1;
}


// Feature Commands
CMD:vip(playerid, params[])
{
	if(!IsPlayerVIP(playerid))
        return SendErrorMessage(playerid, "Hanya member donatur yang dapat menggunakan perintah ini!");

    if(GetGVarInt("VIPChat", GLOBAL_VARTYPE_INT))
		return SendErrorMessage(playerid, "Chat VIP dinonaktifkan sementara!");

	if(IsToggleVIPMessage(playerid))
		return SendErrorMessage(playerid, "Aktifkan vip chat terlebih dahulu pada perintah (/toggle)");
	
	if(isnull(params))
		return SendSyntaxMessage(playerid, "/vip [text]");

	if(strlen(params) > 128)
		return SendErrorMessage(playerid, "Text hanya dibatasi sebanyak 128 karakter!");

	foreach (new i : Player) if(IsPlayerVIP(i) && !IsToggleVIPMessage(i)) {
		SendClientMessageEx(i, X11_PEACH_PUFF_2, "* (%s) %s: %s", ReturnVIPName(GetPlayerVIPLevel(playerid)), ReturnName(playerid, 0), params);
	}
	SendAdminMessage(X11_PEACH_PUFF_2, "* Admin Log (%s) %s: %s", ReturnVIPName(GetPlayerVIPLevel(playerid)), ReturnName(playerid, 0), params);
	return 1;
}

CMD:vips(playerid, params[])
{
	if(!GetAdminLevel(playerid) && !IsPlayerVIP(playerid))
		return SendErrorMessage(playerid, "Hanya member donatur yang dapat menggunakan perintah ini!");

	SendClientMessageEx(playerid, X11_PEACH_PUFF_2, "VIP Members:");
	foreach(new i : Player) if(IsPlayerVIP(i)) {
		SendClientMessageEx(playerid, -1, "* %s: %s", ReturnVIPName(GetPlayerVIPLevel(i)), ReturnName(i, 0));
	}
	return 1;
}

CMD:buyvipveh(playerid, params[])
{
	if(!IsPlayerVIP(playerid))
        return SendErrorMessage(playerid, "Hanya member donatur yang dapat menggunakan perintah ini.");

	if(!IsPlayerInRangeOfPoint(playerid, 3, 477.4115,-1498.9061,20.4821))
    	return SendErrorMessage(playerid, "Kamu tidak berada didonation point!");

	new Cache:execute;

	execute = mysql_query(g_iHandle, "SELECT * FROM `donation_vehicles`;");

	if(cache_num_rows())
	{
		new model, coin, output[2048];

		for(new i = 0; i != cache_num_rows(); i++) {
			model = cache_get_field_int(i, "model");
			coin = cache_get_field_int(i, "coin");

			strcat(output, sprintf("%i\tUGCoin: %d\n", model, coin));
		}
	    ShowPlayerDialog(playerid, DIALOG_VIPCAR, DIALOG_STYLE_PREVIEW_MODEL, "Buy VIP Vehicle", output, "Select", "Close");
	}
	else SendErrorMessage(playerid, "Mohon maaf, belum ada kendaraan yang dimasukkan kedalam list.");

	cache_delete(execute);
	return 1;
}

CMD:addvipveh(playerid, params[])
{
    new model[32], coin;

    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    if(sscanf(params, "s[32]d", model, coin))
        return SendSyntaxMessage(playerid, "/addvipveh [model id/name] [spend coin]");

    if((model[0] = GetVehicleModelByName(model)) == 0)
        return SendErrorMessage(playerid, "Invalid model ID.");

    SendServerMessage(playerid, "Berhasil menambahkan "LIGHTBLUE"%s "WHITE"dengan menghabiskan "YELLOW"%d UCoin.", GetVehicleNameByModel(model[0]), coin);
    mysql_tquery(g_iHandle, sprintf("INSERT INTO `donation_vehicles` (`model`, `coin`) VALUES ('%d','%d') ON DUPLICATE KEY UPDATE `coin`='%d'", model[0], coin, coin));
    return 1;
}

CMD:deletevipveh(playerid, params[])
{
	if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

	new Cache:execute;

	execute = mysql_query(g_iHandle, "SELECT `model` FROM `donation_vehicles`;");

	if(cache_num_rows())
	{
		new model, output[500];

		for(new i = 0; i != cache_num_rows(); i++) {
			model = cache_get_field_int(i, "model");

			strcat(output, sprintf("%i\t%s\n", model, GetVehicleNameByModel(model)));
		}
	    ShowPlayerDialog(playerid, DIALOG_DELETE_VIPCAR, DIALOG_STYLE_PREVIEW_MODEL, "Delete VIP Vehicle", output, "Delete", "Close");
	}
	else SendErrorMessage(playerid, "Mohon maaf, belum ada kendaraan yang dimasukkan kedalam list.");

	cache_delete(execute);
	return 1;
}

CMD:togvipchat(playerid, params[])
{
	if (CheckAdmin(playerid, 3))
        return PermissionError(playerid);

    SetGVarInt("VIPChat", (GetGVarInt("VIPChat", GLOBAL_VARTYPE_INT) ? false : true), GLOBAL_VARTYPE_INT);
    SendAdminMessage(X11_TOMATO, "AdmCmd: %s %s vip chat!", ReturnAdminName(playerid), GetGVarInt("VIPChat", GLOBAL_VARTYPE_INT) ? ("disable") : ("enable"));
    return 1;
}

// Dialog Response
Dialog:ShowCodes(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SetPVarString(playerid, "collectedCode", inputtext);
		Dialog_Show(playerid, DeletedCode, DIALOG_STYLE_MSGBOX, "Delete Code", WHITE"Apa anda yakin ingin menghapus code: "GREEN"%s", "Confirm", "Back", inputtext);
	}
	return 1;
}

Dialog:DeletedCode(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new code[16];
		GetPVarString(playerid, "collectedCode", code, sizeof code);

		SendServerMessage(playerid, "Code "GREEN"%s "WHITE"telah dihapus dari database!.", code);
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `donation_token` WHERE `code` = '%s';", code));
	}
	else cmd_allvipcode(playerid, "\0");
	return 1;
}