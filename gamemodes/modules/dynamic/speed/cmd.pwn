SSCANF:SpeedMenu(string[]) 
{
 	if(!strcmp(string,"create",true)) return 1;
 	else if(!strcmp(string,"delete",true)) return 2;
 	else if(!strcmp(string,"position",true)) return 3;
 	else if(!strcmp(string,"speed",true)) return 4;
 	return 0;
}

CMD:sm(playerid, params[])
	return cmd_speedmenu(playerid, params);

CMD:speedmenu(playerid, params[])
{
	static index, action, nextParams[128];

	if(GetAdminLevel(playerid) < 8)
        return PermissionError(playerid);

	if(sscanf(params, "k<SpeedMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/speedmenu [create/delete/position/speed]");

	switch(action)
	{
		case 1: // Create
		{
			new speed;

			if(sscanf(nextParams, "d", speed))
				return SendSyntaxMessage(playerid, "/speedmenu [max speed]");

			if((index = Speed_Create(playerid, speed)) != -1) SendServerMessage(playerid, "Sukses membuat Speed Cam "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "Jumlah Speed Cam sudah mencapai batas limit ("#MAX_DYNAMIC_SPEED" speed cam)");
		}
		case 2: // Delete
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/speedmenu delete [speed cam ID]");

			if(Speed_Delete(index)) SendServerMessage(playerid, "Sukses menghapus Speed Cam "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "ID Speed Cam yang kamu input tidak terdaftar!");
		}
		case 3: // Position
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/speedmenu position [speed cam ID (/near)]");

			if(!Speed_IsExists(index))
				return SendErrorMessage(playerid, "ID Speed Cam yang kamu input tidak terdaftar!");

			GetPlayerPos(playerid, SpeedData[index][speedPos][0], SpeedData[index][speedPos][1], SpeedData[index][speedPos][2]);
			GetPlayerFacingAngle(playerid, SpeedData[index][speedPos][3]);

			new Float:x, Float:y;
			GetXYInFrontOfPlayer(playerid, x, y, 1.5);
			SetPlayerPos(playerid, x, y, SpeedData[index][speedPos][2]);

			Speed_Sync(index);
			Speed_Save(index);
			SendServerMessage(playerid, "Sukses memindahkan Speed Cam "YELLOW"id: %d.", index);
		}
		case 4: // Speed
		{
			new speed;

			if(sscanf(nextParams, "dd", index, speed))
				return SendSyntaxMessage(playerid, "/speedmenu speed [speed cam ID (/near)] [max speed]");

			if(!Speed_IsExists(index))
				return SendErrorMessage(playerid, "ID speed cam yang kamu input tidak terdaftar!");

			if(speed < 50 || speed > 200)
				return SendErrorMessage(playerid, "Batas kecepatan hanya 50 sampai 200 km/h");

			SpeedData[index][speedMax] = speed;
			Speed_Sync(index, true);
			Speed_Save(index, true);

			SendServerMessage(playerid, "Sukses mengubah kecepatan Speed Cam "YELLOW"id: %d "WHITE"menjadi "ORANGE"%d km/h.", index, speed);
		}
		default: SendSyntaxMessage(playerid, "/atmmenu [create/delete/position/speed]");
	}
	return 1;
}

CMD:togspeedtrap(playerid, params[])
{
	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendSyntaxMessage(playerid, "Kamu bukan seorang polisi!");

	SetPlayerToggleSpeedTrap(playerid, !IsPlayerToggleSpeedTrap(playerid));
	SendServerMessage(playerid, "Speedtrap log %s", IsPlayerToggleSpeedTrap(playerid) ? (""RED"disabled") : (""GREEN"enable"));
	return 1;
}