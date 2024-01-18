SSCANF:UndergroundMenu(string[]) 
{
 	if(!strcmp(string,"create",true)) return 1;
 	else if(!strcmp(string,"delete",true)) return 2;
 	else if(!strcmp(string,"enter",true)) return 3;
 	else if(!strcmp(string,"exit",true)) return 4;
 	return 0;
}

CMD:basement(playerid, params[])
{
	static
		index, action, nextParams[128];

	if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

	if(sscanf(params, "k<UndergroundMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/basement [create/delete/enter/exit]");

	switch(action)
	{
		case 1: // Create
		{
			if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
				return SendErrorMessage(playerid, "Pastikan kondisi interior/virtual worldmu berada diangka 0!");

			if((index = Underground_Create(playerid)) != -1) SendServerMessage(playerid, "Sukses membuat basement "YELLOW"id %d.", index);
			else SendErrorMessage(playerid, "Gagal membuat basement, sudah mencapai batas maksimal!");
		}
		case 2: // Delete
		{
			if(sscanf(nextParams, "d", index))
				return SendErrorMessage(playerid, "/basement delete [basement id]");

			if(!Underground_IsExists(index))
				return SendErrorMessage(playerid, "Basement tidak terdaftar!");

			Underground_Delete(index);
			SendServerMessage(playerid, "Sukses menghapus basement "YELLOW"id %d.", index);
		}
		case 3: // Enter
		{
			if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
				return SendErrorMessage(playerid, "Pastikan kondisi interior/virtual worldmu berada diangka 0!");

			if(sscanf(nextParams, "d", index))
				return SendErrorMessage(playerid, "/basement enter [basement id]");

			if(!Underground_IsExists(index))
				return SendErrorMessage(playerid, "Basement tidak terdaftar!");

			GetPlayerPos(playerid, UndergroundData[index][underEnter][0], UndergroundData[index][underEnter][1], UndergroundData[index][underEnter][2]);

			Underground_Sync(index);
			Underground_Save(index);
			SendServerMessage(playerid, "Sukses mengubah posisi masuk basement "YELLOW"id %d.", index);
		}
		case 4: // Exit
		{
			if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
				return SendErrorMessage(playerid, "Pastikan kondisi interior/virtual worldmu berada diangka 0!");

			if(sscanf(nextParams, "d", index))
				return SendErrorMessage(playerid, "/basement exit [basement id]");

			if(!Underground_IsExists(index))
				return SendErrorMessage(playerid, "Basement tidak terdaftar!");

			GetPlayerPos(playerid, UndergroundData[index][underExitSpawn][0], UndergroundData[index][underExitSpawn][1], UndergroundData[index][underExitSpawn][2]);
			GetPlayerFacingAngle(playerid, UndergroundData[index][underExitSpawn][3]);

			Underground_Sync(index);
			Underground_Save(index);
			SendServerMessage(playerid, "Sukses mengubah posisi keluar basement "YELLOW"id %d.", index);
		}
		default: SendSyntaxMessage(playerid, "/basement [create/delete/enter/exit]");
	}
	return 1;
}