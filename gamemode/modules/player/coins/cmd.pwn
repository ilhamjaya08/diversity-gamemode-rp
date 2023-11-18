// Coin Generator
CMD:generatecoin(playerid, params[])
{
	if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

	new coin_value, coin_code[16];
	
	if(sscanf(params, "d", coin_value))
		return SendSyntaxMessage(playerid, "/generatecoin [jumlah coin]");

	if(!(0 < coin_value <= 5000))
		return SendErrorMessage(playerid, "Jumlah coin dibatasi 1 - 5000.");

	format(coin_code, sizeof coin_code, "UCOIN-%c%c%c%c%04d", RandomLetter(), RandomLetter(), RandomLetter(), RandomLetter(), RandomEx(1000, 9999));
	SendServerMessage(playerid, "New code "GREEN"%s", coin_code);
	SendServerMessage(playerid, "Amount of coin "RED"%d", coin_value);

	mysql_tquery(g_iHandle, sprintf("INSERT INTO `donation_coins` (`added_by`, `code`, `coin`) VALUES ('%s','%s','%d');", ReturnAdminName(playerid), coin_code, coin_value));
	Log_Save(E_LOG_GENERATE_COIN, sprintf("[%s] %s membuat coin code %s total coin: %d.", ReturnDate(), ReturnAdminName(playerid), coin_code, coin_value));
	return 1;
}

CMD:allcoins(playerid, params[])
{
	if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

	new Cache:execute, data[1024], code[16], added[MAX_PLAYER_NAME], coin;

	execute = mysql_query(g_iHandle, "SELECT * FROM `donation_coins`;");

	if(cache_num_rows())
	{
		strcat(data, sprintf("Code\tAdded\tAmount\n"));
		for(new i = 0; i != cache_num_rows(); i++) 
		{
			cache_get_field_content(i, "code", code);
			cache_get_field_content(i, "added_by", added);
			coin = cache_get_field_int(i, "coin");

			strcat(data, sprintf(GREEN"%s\t"WHITE"%s\t"YELLOW"%d\n", code, added, coin));
		}
		Dialog_Show(playerid, ShowCoins, DIALOG_STYLE_TABLIST_HEADERS, "All Coins", data, "Delete", "Close");
	}
	else SendServerMessage(playerid, "Tidak ada data coin yang dapat ditampilkan!.");

	cache_delete(execute);
	return 1;
}

// Redeem coin
CMD:redeemcoin(playerid, params[])
{
	if(isnull(params))
        return SendSyntaxMessage(playerid, "/redeemcoin [coin code]");

    new Cache:execute;

    execute = mysql_query(g_iHandle, sprintf("SELECT `coin` FROM `donation_coins` WHERE `code`='%s';", SQL_ReturnEscaped(params)));
    
    if(cache_num_rows()) {
			new coin = cache_get_field_int(0, "coin");
			GivePlayerCoin(playerid, coin);

			SendServerMessage(playerid, "Kamu telah menggunakan: "YELLOW"%s.", params);
			SendServerMessage(playerid, "Total koin yang kamu dapatkan: "GREEN"%d.", coin);

			mysql_tquery(g_iHandle, sprintf("DELETE FROM `donation_coins` WHERE `code`='%s';", params));
			Log_Save(E_LOG_REDEEM_COIN, sprintf("[%s] %s klaim coin %s total coin %d.", ReturnDate(), ReturnName(playerid), params, coin));
    }
    else SendErrorMessage(playerid, "Kode koin tidak terdaftar!");

    cache_delete(execute);
	return 1;
}

CMD:finecoin(playerid, params[])
{
    new userid, coin;

    if (CheckAdmin(playerid, 6))
        return PermissionError(playerid);

    if(sscanf(params, "ud", userid, coin))
        return SendSyntaxMessage(playerid, "/finecoin [userid] [UGoin]");

    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Player tersebut tidak sedang login diserver!");

    if(GetPlayerCoin(userid) < 1)
        return SendErrorMessage(playerid, "Player tersebut tidak memiliki UGoin.");

    if(!(0 < coin <= 10000))
        return SendErrorMessage(playerid, "Pengurangan UGoin hanya dibatasi mulai dari 1 - 10000.");

    if((GetPlayerCoin(userid)-coin) < 0)
        return SendErrorMessage(playerid, "Player tersebut hanya memiliki %d UGoin, anda memasukkan angka terlalu banyak dari total UGoin.", GetPlayerCoin(userid));

    GivePlayerCoin(userid, -coin);
    SendServerMessage(playerid, "Pengurangi UCoin milik "YELLOW"%s "RED"(-%d) "WHITE"(UCoin total: "YELLOW"%d"WHITE")", ReturnName(userid), coin, GetPlayerCoin(userid));
    SendServerMessage(userid, "UCoin milikmu dikurangi oleh "RED"%s "WHITE"sebanyak: "RED"%d UCoin", ReturnAdminName(playerid), coin);
    Log_Save(E_LOG_FINE_COIN, sprintf("[%s] %s mengurangi UCoin %s sebanyak %d UCoin.", ReturnDate(), ReturnAdminName(playerid), ReturnName(userid, 0), coin));
    return 1;
}

// Using coins
CMD:spendcoins(playerid, params[])
{
	if(!IsPlayerVIP(playerid))
        return SendErrorMessage(playerid, "Hanya member donatur yang dapat menggunakan perintah ini.");

    if(!IsPlayerInRangeOfPoint(playerid, 3, 477.4115,-1498.9061,20.4821))
    	return SendErrorMessage(playerid, "Kamu tidak berada didonation point!");

	new output[128];

	strcat(output, sprintf("Menu\tSlot\n", ReturnVIPCNSlot(playerid)));
	strcat(output, sprintf("Ganti Nama\t%d\n", ReturnVIPCNSlot(playerid)));
	strcat(output, sprintf("Ganti Nomor Handphone\t%d\n", ReturnVIPPhoneSlot(playerid)));
	strcat(output, sprintf("Ganti ID Masker\t%d", ReturnVIPMaskSlot(playerid)));

	Dialog_Show(playerid, SpendCoin, DIALOG_STYLE_TABLIST_HEADERS, "Spend Coin", output, "Select", "Close");
	return 1;
}

// Dialog Response
Dialog:ShowCoins(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SetPVarString(playerid, "collectedCoin", inputtext);
		Dialog_Show(playerid, DeletedCoin, DIALOG_STYLE_MSGBOX, "Delete Coin", WHITE"Apa anda yakin ingin menghapus coin code: "GREEN"%s", "Confirm", "Back", inputtext);
	}
	return 1;
}

Dialog:DeletedCoin(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new code[16];
		GetPVarString(playerid, "collectedCoin", code, sizeof code);

		SendServerMessage(playerid, "Coin code "GREEN"%s "WHITE"telah dihapus dari database!.", code);
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `donation_coins` WHERE `code` = '%s';", code));
	}
	else cmd_allcoins(playerid, "\0");
	return 1;
}

Dialog:SpendCoin(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: {
				if(ReturnVIPCNSlot(playerid) <= 0)
					return SendErrorMessage(playerid, "Tidak ada slot untuk mengganti nama karakter!");

				Dialog_Show(playerid, VIPChangeName, DIALOG_STYLE_INPUT, "Ganti Nama", WHITE"Masukkan nama karakter barumu:", "Ganti", "Kembali");
			} 
			case 1: {
				if(ReturnVIPPhoneSlot(playerid) <= 0)
					return SendErrorMessage(playerid, "Tidak ada slot untuk mengganti nomor handphone!");

				Dialog_Show(playerid, VIPChangePhone, DIALOG_STYLE_INPUT, "Ganti Nomor Handphone", WHITE"Masukkan nomor handphone barumu (maksimal 5 angka):", "Ganti", "Kembali");
			}
			case 2: {
				if(ReturnVIPMaskSlot(playerid) <= 0)
					return SendErrorMessage(playerid, "Tidak ada slot untuk mengganti id mask!");

				Dialog_Show(playerid, VIPChangeMask, DIALOG_STYLE_INPUT, "Ganti ID Masker", WHITE"Masukkan id mask barumu (maksimal 5 angka):", "Ganti", "Kembali");
			}
		}
	}
	return 1;
}

Dialog:VIPChangeName(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new Cache:execute;

		if(!IsValidRoleplayName(inputtext))
			return Dialog_Show(playerid, VIPChangeName, DIALOG_STYLE_INPUT, "Ganti Nama", WHITE"(error) Gunakan nama dengan format roleplay 'Firstname_Lastname'\n\nMasukkan nama karakter barumu:", "Ganti", "Kembali");

		execute = mysql_query(g_iHandle, sprintf("SELECT `Character` FROM `characters` WHERE `Character`='%s';", inputtext));

		if(cache_num_rows()) Dialog_Show(playerid, VIPChangeName, DIALOG_STYLE_INPUT, "Change Name", WHITE"(error) Nama karakter sudah ada yang menggunakan!\n\nMasukkan nama karakter barumu:", "Ganti", "Kembali");
		else {
			UpdateCharacterString(playerid, "Character", inputtext);

			format(NormalName(playerid), MAX_PLAYER_NAME, inputtext);

			if(!AccountData[playerid][pAdminDuty])
			    SetPlayerName(playerid, inputtext);

			for(new id; id < MAX_BUSINESSES; id++) if(BusinessData[id][bizExists] && BusinessData[id][bizOwner] == GetPlayerSQLID(playerid)) {
		        format(BusinessData[id][bOwnerName], MAX_PLAYER_NAME, inputtext);
		        Business_Refresh(id);
		    }

		    for(new id; id < MAX_HOUSES; id++) if(HouseData[id][houseExists] && HouseData[id][houseOwner] == GetPlayerSQLID(playerid)) {
		        format(HouseData[id][houseOwnerName], MAX_PLAYER_NAME, inputtext);
		        House_Refresh(id);
		    }

		    for(new id; id < MAX_WORKSHOP; id++) if(WorkshopData[id][wExists] && WorkshopData[id][wOwner] == GetPlayerSQLID(playerid)) {
		        format(WorkshopData[id][wOwner], MAX_PLAYER_NAME, inputtext);
		        Workshop_Refresh(id);
		    }

			SetVIPChangeName(playerid, (ReturnVIPCNSlot(playerid)-1));
			SendServerMessage(playerid, "Nama karaktermu telah diganti menjadi '"YELLOW"%s"WHITE"'", inputtext);
			//ResetNameTag(playerid, false, false, false, false, true);
    		Log_Save(E_LOG_CHANGE_CHAR_NAME, sprintf("[%s] %s mengganti nama karakter menjadi %s.", ReturnDate(), ReturnAdminName(playerid), inputtext));
		}
		cache_delete(execute);
	}
	return 1;
}

Dialog:VIPChangePhone(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new phonenumber, Cache:execute;

		if(sscanf(inputtext, "d", phonenumber))
			return Dialog_Show(playerid, VIPChangePhone, DIALOG_STYLE_INPUT, "Ganti Nomor Handphone", WHITE"(error): Hanya angka yang diperbolehkan!\n\nMasukkan nomor handphone barumu (maksimal 5 angka):", "Ganti", "Kembali");

		if(!(0 < phonenumber <= 99999))
			return Dialog_Show(playerid, VIPChangePhone, DIALOG_STYLE_INPUT, "Ganti Nomor Handphone", WHITE"(error): Nomor handphone dibatasi dari angka 1 - 99999!\n\nMasukkan nomor handphone barumu (maksimal 5 angka):", "Ganti", "Kembali");

		execute = mysql_query(g_iHandle, sprintf("SELECT `Phone` FROM `characters` WHERE `Phone`='%d';", phonenumber));

		if(cache_num_rows()) Dialog_Show(playerid, VIPChangePhone, DIALOG_STYLE_INPUT, "Ganti Nomor Handphone", WHITE"(error): Nomor handphone sudah ada yang menggunakan!\n\nMasukkan nomor handphone barumu (maksimal 5 angka):", "Ganti", "Kembali");
		else {
			PlayerData[playerid][pPhone] = phonenumber;
			UpdateCharacterInt(playerid, "Phone", phonenumber);

			SetVIPChangePhone(playerid, (ReturnVIPPhoneSlot(playerid)-1));
			SendServerMessage(playerid, "Nomor barumu adalah ("YELLOW"%d"WHITE")", phonenumber);
		}
		cache_delete(execute);
	}
	return 1;
}

Dialog:VIPChangeMask(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new masknumber, Cache:execute;

		if(sscanf(inputtext, "d", masknumber))
			return Dialog_Show(playerid, VIPChangeMask, DIALOG_STYLE_INPUT, "Ganti ID Masker", WHITE"(error): Hanya angka yang diperbolehkan!\n\nMasukkan id masker barumu (maksimal 5 angka):", "Ganti", "Kembali");

		if(!(0 < masknumber <= 99999))
			return Dialog_Show(playerid, VIPChangeMask, DIALOG_STYLE_INPUT, "Ganti ID Masker", WHITE"(error): ID masker dibatasi dari angka 1 - 99999!\n\nMasukkan id masker barumu (maksimal 5 angka):", "Ganti", "Kembali");

		execute = mysql_query(g_iHandle, sprintf("SELECT `MaskID` FROM `characters` WHERE `MaskID`='%d';", masknumber));

		if(cache_num_rows()) Dialog_Show(playerid, VIPChangeMask, DIALOG_STYLE_INPUT, "Ganti ID Masker", WHITE"(error): ID masker sudah ada yang menggunakan!\n\nMasukkan id masker barumu (maksimal 5 angka):", "Ganti", "Kembali");
		else {
			PlayerData[playerid][pMaskID] = masknumber;
			UpdateCharacterInt(playerid, "MaskID", masknumber);

			SetVIPChangeMask(playerid, (ReturnVIPMaskSlot(playerid)-1));
			SendServerMessage(playerid, "ID masker barumu adalah ("YELLOW"Mask_#%d"WHITE")", masknumber);
		}
		cache_delete(execute);
	}
	return 1;
}