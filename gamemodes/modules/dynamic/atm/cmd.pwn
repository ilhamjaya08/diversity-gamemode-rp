SSCANF:AtmMenu(string[]) 
{
 	if(!strcmp(string,"create",true)) return 1;
 	else if(!strcmp(string,"delete",true)) return 2;
 	else if(!strcmp(string,"position",true)) return 3;
 	else if(!strcmp(string,"capacity",true)) return 4;
 	else if(!strcmp(string,"reset",true)) return 5;
 	return 0;
}

CMD:am(playerid, params[])
	return cmd_atmmenu(playerid, params);

CMD:atmmenu(playerid, params[])
{
	static index, action, nextParams[128];

	if(GetAdminLevel(playerid) < 8)
        return PermissionError(playerid);

	if(sscanf(params, "k<AtmMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/atmmenu [create/delete/position/capacity/reset]");

	switch(action)
	{
		case 1: // Create
		{
			if((index = ATM_Create(playerid)) != -1) SendServerMessage(playerid, "Sukses membuat ATM "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "Jumlah ATM sudah mencapai batas limit ("#MAX_DYNAMIC_ATM" atm)");
		}
		case 2: // Delete
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/atmmenu delete [atm ID (/near)]");

			if(ATM_Delete(index)) SendServerMessage(playerid, "Sukses menghapus ATM "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "ID ATM yang kamu input tidak terdaftar!");
		}
		case 3: // Position
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/atmmenu position [atm ID (/near)]");

			if(!ATM_IsExists(index))
				return SendErrorMessage(playerid, "ID ATM yang kamu input tidak terdaftar!");

			GetPlayerPos(playerid, AtmData[index][atmPos][0], AtmData[index][atmPos][1], AtmData[index][atmPos][2]);
			GetPlayerFacingAngle(playerid, AtmData[index][atmPos][3]);

			AtmData[index][atmInterior] = GetPlayerInterior(playerid);

			ATM_Sync(index);
			ATM_Save(index);
			SendServerMessage(playerid, "Sukses memindahkan ATM "YELLOW"id: %d.", index);
		}
		case 4: // Capacity
		{
			new amount;
			if(sscanf(nextParams, "dd", index, amount))
				return SendSyntaxMessage(playerid, "/atmmenu capacity [id] [amount]");

			if(!ATM_IsExists(index))
				return SendErrorMessage(playerid, "ID ATM yang kamu input tidak terdaftar!");

			AtmData[index][atmCapacity] = amount;

			ATM_Save(index);
			SendServerMessage(playerid, "Sukses mengisi capacity ATM "YELLOW"id: %d jumlah $%d", index, amount);
		}
		case 5: // Reset
		{
			foreach(new i : Atms)
			{
				if(AtmData[i][atmCapacity] != 0)
				{
					AtmData[i][atmCapacity] = 0;
					ATM_Save(i);
				}
			}
			SendServerMessage(playerid, "Sukses me-reset capacity ATM");
		}
		default: SendSyntaxMessage(playerid, "/atmmenu [create/delete/position/capacity/reset]");
	}
	return 1;
}