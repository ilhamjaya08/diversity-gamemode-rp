
ResetAFK(playerid)
{
	AFKMath[playerid] = 0;
	Angka1[playerid] = 0;
	Angka2[playerid] = 0;
	Hasil[playerid] = 0;
	stop AFKTimerHolder[playerid];
	return 1;
}

AFKMathQuiz(playerid)
{
	AFKMath[playerid]++;
	Angka1[playerid] = random(40);
	Angka2[playerid] = random(50);
	Hasil[playerid] = Angka1[playerid] + Angka2[playerid];
	AFKTimerHolder[playerid] = repeat AFKMathTimer(playerid);
	SendClientMessageEx(playerid, COLOR_WHITE, ""RED"[AFK] "WHITE"%d + %d = ? Use /afkmath (answer)", Angka1[playerid], Angka2[playerid]);
	return 1;
}

CMD:afkmath(playerid, params[])
{
	static amount;
	new counter;
	if(AFKMath[playerid] <= 0)
		return SendClientMessage(playerid, COLOR_WHITE, ""RED"[AFK] "WHITE" You're not in AFK mode");

	if(sscanf(params, "d", amount))
        return SendSyntaxMessage(playerid, "/afkmath [answer]");

	if(amount == Hasil[playerid])
	{
		SendClientMessageEx(playerid, COLOR_WHITE, ""RED"[AFK] "WHITE"You no longer AFK!", Angka1[playerid], Angka2[playerid], Hasil[playerid]);
		ResetAFK(playerid);
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_WHITE, ""RED"[AFK] "WHITE"Wrong answer, %d + %d = ? Use /afkmath (answer)", Angka1[playerid], Angka2[playerid]);
		counter++;
	}
	
	if(counter > 3)
	{
		SendClientMessage(playerid, COLOR_WHITE, ""RED"[AFK] "WHITE"You're kicked for answering a "RED"wrong answer "WHITE"3 times");
		KickEx(playerid);
	}
	return 1;
}

timer AFKMathTimer[120000](playerid) //60000
{
	if(AFKMath[playerid] >= 1)
	{
		if(AFKMath[playerid] > 2)
		{
			ResetAFK(playerid);
			SendClientMessage(playerid, COLOR_WHITE, ""RED"[AFK] "WHITE"You're kicked for "RED"AFK");
			TogglePlayerControllable(userid, 0);
			PlayerData[playerid][pFreeze] = 1;
		}
		AFKMath[playerid]++;
	}
	return 1;
}

ptask StopAFK[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

	if(AFKMath[playerid] >= 1 && !IsPlayerInRangeOfPoint(playerid, 2.0, PlayerPosAFK[playerid][3], PlayerPosAFK[playerid][4], PlayerPosAFK[playerid][5]))
	{
		SendClientMessage(playerid, COLOR_WHITE, ""RED"[AFK] "WHITE"You no longer in AFK mode!");
		ResetAFK(playerid);
	}
	return 1;
}

ptask AFKTimer[600000](playerid) //300000
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	if(GetAdminLevel(playerid) >= 1) 
		return 0;

	if(IsPlayerPaused(playerid) || !IsPlayerPaused(playerid)) 
	{	
		GetPlayerPos(playerid, PlayerPosAFK[playerid][0], PlayerPosAFK[playerid][1], PlayerPosAFK[playerid][2]);
		PlayerPosAFK[playerid][3] = PlayerPosAFK[playerid][0];
		PlayerPosAFK[playerid][4] = PlayerPosAFK[playerid][1];
		PlayerPosAFK[playerid][5] = PlayerPosAFK[playerid][2];	
		if(IsPlayerInRangeOfPoint(playerid, 2.0, PlayerPosAFK[playerid][3], PlayerPosAFK[playerid][4], PlayerPosAFK[playerid][5]) && AFKMath[playerid] == 0) 
		{	
			AFKMathQuiz(playerid);	
		}
	}
	return 1;
}