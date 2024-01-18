SSCANF:ActorMenu(string[]) 
{
 	if(!strcmp(string,"create",true)) return 1;
 	else if(!strcmp(string,"delete",true)) return 2;
 	else if(!strcmp(string,"type",true)) return 3;
 	else if(!strcmp(string,"cash",true)) return 4;
 	else if(!strcmp(string,"anim",true)) return 5;
 	else if(!strcmp(string,"info",true)) return 6;
 	return 0;
}

CMD:resetactor(playerid, params[])
{
	if(GetAdminLevel(playerid) < 6)
        return PermissionError(playerid);

	foreach(new i : ServerActor)
	{
		if(ActorData[i][actorCooldown])
		{
			ActorData[i][actorCooldown] = 0;
		}
	}
	SendAdminMessage(X11_TOMATO_1, "AdmWarn: %s has using reset actor robbery cooldown.", ReturnName(playerid, 0));
	return 1;
}

CMD:actormenu(playerid, params[])
{
	static index, action, nextParams[128];

	if(GetAdminLevel(playerid) < 8)
        return PermissionError(playerid);

	if(sscanf(params, "k<ActorMenu>S()[128]", action, nextParams))
	{
		SendSyntaxMessage(playerid, "/actormenu [entity]");
		SendSyntaxMessage(playerid, "ENTITY: [create/delete/type/cash/info]");
		return 1;
	}

	switch(action)
	{
		case 1: // Create
		{
			new name[128], model;
			if(sscanf(nextParams, "ds[128]", model, name))
				return SendSyntaxMessage(playerid, "/actormenu create [model] [name]");

			if((index = Actor_Create(playerid, model, name)) != -1) SendServerMessage(playerid, "Sukses membuat Actor "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "Jumlah Actor sudah mencapai batas limit ("#MAX_DYNAMIC_ACTOR" actor)");
		}
		case 2: // Delete
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/actormenu delete [actorid]");

			if(Actor_Delete(index)) SendServerMessage(playerid, "Sukses menghapus Actor "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "ID Actor yang kamu input tidak terdaftar!");
		}
		case 3:
		{
			new type;
			if(sscanf(nextParams, "dd", index, type))
				return SendSyntaxMessage(playerid, "/actormenu type [actorid] [type] (0 = NONE | 1 = STORE)");

			if(type < 0 || type > 1)
				return SendErrorMessage(playerid, "Invalid actor type!");
			
			if(Actor_SetType(index, type)) SendServerMessage(playerid, "You set actor id %d type to %d", index, type);
			else SendErrorMessage(playerid, "ID Actor yang kamu input tidak terdaftar!");
		}
		case 4:
		{
			new amount;
			if(sscanf(nextParams, "dd", index, amount))
				return SendSyntaxMessage(playerid, "/actormenu cash [actorid] [amount]");
			
			if(Actor_SetCash(index, amount)) SendServerMessage(playerid, "You set actor id %d cash to $%d", index, amount);
			else SendErrorMessage(playerid, "ID Actor yang kamu input tidak terdaftar!");
		}
		case 5:
		{
			new animlib[128], animname[128];
			if(sscanf(nextParams, "ds[128]s[128]", index, animlib, animname))
				return SendSyntaxMessage(playerid, "/actormenu anim [actorid] [animlib] [animname]");
			
			if(isnull(animname) || isnull(animlib))
        		return SendSyntaxMessage(playerid, "/actormenu anim [actorid] [animlib] [animname]");

			if(Actor_SetAnim(index, animlib, animname)) SendServerMessage(playerid, "You set actor id %d animation", index);
			else SendErrorMessage(playerid, "ID Actor yang kamu input tidak terdaftar!");
		}
		default: 
		{
			SendSyntaxMessage(playerid, "/actormenu [entity]");
			SendSyntaxMessage(playerid, "ENTITY: [create/delete/type/cash/info]");
		}
	}
	return 1;
}

CMD:grabcash(playerid, params[])
{
	new actorid, bizid;
	if((actorid = Actor_Nearest(playerid, 5.0)) != -1 && ActorData[actorid][actorStatus] && !GrabCash[playerid])
	{
		if(Actor_GetCash(actorid) <= 0)
			return SendErrorMessage(playerid, "This store is out of cash!");

		if((bizid = Business_Inside(playerid)) != -1)
		{
			SendServerMessage(playerid, "Use /stopgrabcash to stop grabbing the cash from cashier!");
			ApplyAnimation(playerid, "ROB_BANK", "CAT_SAFE_ROB", 4.1, 1, 0, 0, 1, 0, 1);
			PlayerData[playerid][pLastBiz] = bizid;
			GrabCash[playerid] = 1;
			GrabCashTimer[playerid] = repeat Player_Grabcash(playerid, actorid);
			cmd_ame(playerid, "takes out a bag and start grabbing a cash");
		}
		else SendErrorMessage(playerid, "You are not inside any business");
	}
	else SendErrorMessage(playerid, "This shopkeeper need to puts their handsup first!");
	return 1;
}

CMD:stopgrabcash(playerid, params[])
{
	if(GrabCash[playerid])
	{
		GrabCash[playerid] = 0;
		GrabCashCounter[playerid] = 0;
		stop GrabCashTimer[playerid];
		SendServerMessage(playerid, "You stop grabbing a cash from the cashier!");
		ClearAnimations(playerid);
	}
	else SendErrorMessage(playerid, "You are not grabbing any cash!");
	return 1;
}

CMD:cctv(playerid, params[])
{
	new 
		bizid, 
		count = 0,
		header[30],
		string[1024]
	;
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || !IsPlayerSpawned(playerid))
		return SendErrorMessage(playerid, "You can't use this command right now.");

    if(GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "You must be a police officer.");

    if(!IsPlayerDuty(playerid))
        return SendErrorMessage(playerid, "You must on duty to use cctv.");

	if((bizid = Business_Inside(playerid)) != -1)
	{
		format(header, sizeof(header), "CCTV Recorder");
		strcat(string, "ID\tDescription\n");
		foreach(new i : Player)
		{
			if(PlayerData[i][pLastBiz] == bizid)
        	{
                strcat(string, sprintf("%d\t%s\n", i, ReturnName(i)));
                count++;
			}
		}
		if (count) Dialog_Show(playerid, CCTVRecorder, DIALOG_STYLE_TABLIST_HEADERS, header, string, "Close", "");
		else SendErrorMessage(playerid, "There is nothing to review on the CCTV.");
	}
	return 1;
}