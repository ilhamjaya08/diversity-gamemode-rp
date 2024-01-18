CMD:report(playerid, params[])
{
	if(report_posted{playerid})
		return SendErrorMessage(playerid, "Kamu sudah membuat laporan sebelumnya, tunggu laporan anda diproses terlebih dahulu!");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/report [laporan (maksimal 100 karakter)]");

	if(strlen(params) >= 100)
		return SendErrorMessage(playerid, "Text terlalu panjang, hanya dibatasi sebanyak 100 karakter!");

	report_posted{playerid} = true;
	report_time[playerid] = gettime() + 300;
	format(report_message[playerid], sizeof report_message, params);

	SendCustomMessage(playerid, "REPORT SENDED", "%s",params);
    SendAdminMessage(X11_TOMATO_1, "[REPORT: #%d] "COL_DEPARTMENT"%s: %s", playerid, ReturnName(playerid, 0), params);
	return 1;
}

CMD:reports(playerid, params[])
{
	if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    new count, sourch[500];

    strcat(sourch, "ID\tName\tMessage\n");
    foreach(new i : Player) if(report_posted{i}) {
		strcat(sourch, sprintf("%d\t%s\t%s\n", i, ReturnName(i, 0), report_message[i]));
		count++;
    }
    if(count) Dialog_Show(playerid, AllReports, DIALOG_STYLE_TABLIST_HEADERS, "All Reports", sourch, "Close", "");
    else SendErrorMessage(playerid, "Tidak ada laporan yang dapat ditampilkan!");
	return 1;
}

CMD:clearreports(playerid, params[])
{
	if(CheckAdmin(playerid, 4))
        return PermissionError(playerid);

    foreach(new i : Player) if(report_posted{i}) {
    	Report_Reset(i);
    }

    SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s mengosongkan semua laporan yang ada!", ReturnAdminName(playerid));
	return 1;
}

CMD:ar(playerid, params[])
{
	new userid;

	if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/ar [playerid/PartOfName]");

	if(userid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Player tersebut tidak terhubung keserver.");

	if(!report_posted{userid})
		return SendErrorMessage(playerid, "Player tersebut tidak membuat laporan");

	AdminActivity_Write(
		playerid,
		userid,
		ADMIN_ACTIVITY_ACCEPT_REPORT,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) accept report from %s (playerid=%d, IP=%s). Report message: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,ReturnName(userid, 0)
			,userid
			,ReturnIP(userid)
			,report_message[userid]
		)
	);

	Report_Reset(userid);
	SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s menerima laporan %s.", ReturnAdminName(playerid), ReturnName(userid, 0));
	SendCustomMessage(userid, "ACCEPT REPORT", RED"%s "WHITE"menerima laporanmu.", ReturnAdminName(playerid));
	AccountData[playerid][pAdminAcceptReport]++;
	SQL_SaveAccounts(playerid);
	return 1;
}

CMD:dr(playerid, params[])
{
	new userid, reason[128];

	if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	if(sscanf(params, "us[128]", userid, reason))
		return SendSyntaxMessage(playerid, "/dr [playerid/PartOfName] [alasan]");

	if(userid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Player tersebut tidak terhubung keserver.");

	if(!report_posted{userid})
		return SendErrorMessage(playerid, "Player tersebut tidak membuat laporan");

	AdminActivity_Write(
		playerid,
		userid,
		ADMIN_ACTIVITY_DENY_REPORT,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) deny report from %s (playerid=%d, IP=%s). Report message: %s | Deny reason: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,ReturnName(userid, 0)
			,userid
			,ReturnIP(userid)
			,report_message[userid]
			,reason
		)
	);

	Report_Reset(userid);
	SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s menolak laporan %s.", ReturnAdminName(playerid), ReturnName(userid, 0));
	SendCustomMessage(userid, "DENIED REPORT", RED"%s "WHITE"menolak laporanmu, alasan: %s.", ReturnAdminName(playerid), reason);
	AccountData[playerid][pAdminDeniedReport]++;
	SQL_SaveAccounts(playerid);
	return 1;
}


CMD:ask(playerid, params[])
{
	if(ask_posted{playerid})
		return SendErrorMessage(playerid, "Kamu sudah membuat pertanyaan sebelumnya, tunggu pertanyaan anda diproses terlebih dahulu!");

	if(isnull(params))
		return SendSyntaxMessage(playerid, "/ask [pertanyaan (maksimal 128 karakter)]");

	if(strlen(params) > 128)
		return SendErrorMessage(playerid, "Text terlalu panjang, hanya dibatasi sebanyak 128 karakter!");

	ask_posted{playerid} = true;
	ask_time[playerid] = gettime() + 300;
	format(ask_message[playerid], 128, params);

	if (strlen(params) > 64)
	{
		SendCustomMessage(playerid, "ASK SENDED", "%.64s ..", params);
		SendCustomMessage(playerid, "ASK SENDED", ".. %s", params[64]);
		SendAdminMessage(X11_TURQUOISE_1, "[ASK] "YELLOW"%s [%d]: "WHITE"%.64s ..", ReturnName(playerid, 0), playerid, params);
		SendAdminMessage(X11_TURQUOISE_1, "[ASK] "WHITE".. %s", params[64]);
		return 1;
	}

	SendCustomMessage(playerid, "ASK SENDED", "%s", params);
	SendAdminMessage(X11_TURQUOISE_1, "[ASK] "YELLOW"%s [%d]: "WHITE"%s", ReturnName(playerid, 0), playerid, params);
	return 1;
}

CMD:asks(playerid, params[])
{
	if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    new count, sourch[500];

    strcat(sourch, "ID\tName\tQuestion\n");
    foreach(new i : Player) if(ask_posted{i}) {
		strcat(sourch, sprintf("%d\t%s\t%s\n", i, ReturnName(i, 0), ask_message[i]));
		count++;
    }
    if(count) Dialog_Show(playerid, AllReports, DIALOG_STYLE_TABLIST_HEADERS, "All Questions", sourch, "Close", "");
    else SendErrorMessage(playerid, "Tidak ada pertanyaan yang dapat ditampilkan!");
	return 1;
}

CMD:ans(playerid, params[])
{
	new userid, text[128];

	if (CheckAdmin(playerid, 1))
		return PermissionError(playerid);

	if(sscanf(params, "us[128]", userid, text)) 
		return SendSyntaxMessage(playerid, "/ans [playerid/PartOfName] [message]");

	if(userid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Player tersebut tidak terhubung keserver.");

	if(!ask_posted{userid})
		return SendErrorMessage(playerid, "Player tersebut tidak membuat pertanyaan");

	AdminActivity_Write(
		playerid,
		userid,
		ADMIN_ACTIVITY_ANSWER,
		sprintf(
			"Admin %s (playerid=%d, IP=%s) answer %s (playerid=%d, IP=%s) question. Question: %s | Answer: %s"
			,ReturnAdminName(playerid)
			,playerid
			,ReturnIP(playerid)
			,ReturnName(userid, 0)
			,userid
			,ReturnIP(userid)
			,ask_message[userid]
			,text
		)
	);

	if (strlen(ask_message[userid]) > 64)
	{
		SendClientMessageEx(userid, X11_TURQUOISE_1, "PERTANYAAN: "YELLOW"%.64s ..", ask_message[userid]);
		SendClientMessageEx(userid, X11_TURQUOISE_1, ""YELLOW".. %s", ask_message[userid][64]);
	}
	else
	{
		SendClientMessageEx(userid, X11_TURQUOISE_1, "PERTANYAAN: "YELLOW"%s", ask_message[userid]);
	}

	if (strlen(text) > 64)
	{
		SendClientMessageEx(userid, X11_TURQUOISE_1, "JAWABAN: "YELLOW"%.64s ..", text);
		SendClientMessageEx(userid, X11_TURQUOISE_1, ""YELLOW".. %s", text[64]);
	}
	else
	{
		SendClientMessageEx(userid, X11_TURQUOISE_1, "JAWABAN: "YELLOW"%s", text);
	}

	if (strlen(text) > 32)
	{
		SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s menjawab pertanyaan %s: %.32s ..", ReturnAdminName(playerid), ReturnName(userid, 0), text);
		SendAdminMessage(X11_TOMATO_1, ".. %s", text[32]);
	}
	else
	{
		SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s menjawab pertanyaan %s: %s", ReturnAdminName(playerid), ReturnName(userid, 0), text);
	}

	AccountData[playerid][pAdminAnswer]++;
	Ask_Reset(userid);
	return 1;
}

CMD:clearasks(playerid, params[])
{
	if(CheckAdmin(playerid, 4))
        return PermissionError(playerid);

    foreach(new i : Player) if(ask_posted{i}) {
    	Ask_Reset(i);
    }
    SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s mengosongkan semua pertanyaan yang ada!", ReturnAdminName(playerid));
	return 1;
}

CMD:atalk(playerid, params[])
{
    if(isnull(params))
        return SendSyntaxMessage(playerid, "/atalk [request]");

    if(GetPVarInt(playerid,"waitingAtalk") >= gettime())
        return SendErrorMessage(playerid, "Tunggu %d detik untuk menggunakan perintah ini kembali.", GetPVarInt(playerid,"waitingAtalk") - gettime());

    SetPVarInt(playerid,"waitingAtalk", (gettime() + 60));
    SendServerMessage(playerid, "Kamu telah mengirimkan percakapan kepada admin/helper.");
    SendAdminMessage(X11_MAROON, "[ATALK]: %s (%d): %s", ReturnName2(playerid, 0), playerid, params);
    return 1;
}