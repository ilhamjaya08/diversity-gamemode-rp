// Function
Actor_IsExists(index)
{
	if(Iter_Contains(ServerActor, index))
		return 1;
	
	return 0;
}

Actor_Create(playerid, model, name[])
{
	static
		index;
	new 
		string[255],
		Float:x,
		Float:y,
		Float:z,
		Float:a,
		vw,
		int
	;
	if((index = Iter_Free(ServerActor)) != cellmin)
	{
		Iter_Add(ServerActor, index);

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		vw = GetPlayerVirtualWorld(playerid);
		int = GetPlayerInterior(playerid);

		ActorData[index][actorPos][0] = x;
		ActorData[index][actorPos][1] = y;
		ActorData[index][actorPos][2] = z;
		ActorData[index][actorPos][3] = a;
		ActorData[index][actorVirtualWorld] = vw;
		ActorData[index][actorInterior] = int;
		ActorData[index][actorModel] = model;
		ActorData[index][actorStatus] = 0;
		ActorData[index][actorType] = ACTOR_TYPE_NONE;
		ActorData[index][actorCash] = 15000;
		ActorData[index][actorNotification] = 0;
		format(ActorData[index][actorAnimLib], 128, "");
		format(ActorData[index][actorAnimName], 128, "");

		format(ActorData[index][actorName], MAX_PLAYER_NAME+1, name);

		ActorData[index][actorObject] = CreateDynamicActor(ActorData[index][actorModel], ActorData[index][actorPos][0], ActorData[index][actorPos][1], ActorData[index][actorPos][2], ActorData[index][actorPos][3], true, 100, ActorData[index][actorVirtualWorld], ActorData[index][actorInterior]);

		format(string, sizeof(string), ""RED"[Actor] "WHITE"%s (%d)", ActorData[index][actorName], index);
		ActorData[index][actorText] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ActorData[index][actorPos][0], ActorData[index][actorPos][1], ActorData[index][actorPos][2]+1, 30, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ActorData[index][actorVirtualWorld], ActorData[index][actorInterior]);
		
		Streamer_SetIntData(STREAMER_TYPE_ACTOR, ActorData[index][actorObject], E_STREAMER_EXTRA_ID, index);

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `actor`(`actorInterior`,`actorVirtualWorld`) VALUES('%d', '%d');", ActorData[index][actorInterior], ActorData[index][actorVirtualWorld]), "OnActorCreated", "d", index);
		return index;
	}
	return -1;
}
Actor_SetType(index, type)
{
	if(Actor_IsExists(index))
	{
		ActorData[index][actorType] = type;
		Actor_Save(index);
		return 1;
	}
	return 0;
}

Actor_GetCash(index)
{
	if(Actor_IsExists(index))
	{
		return ActorData[index][actorCash];
	}
	return 0;
}
Actor_SetAnim(index, animlib[], animname[])
{
	if(Actor_IsExists(index))
	{
		format(ActorData[index][actorAnimLib], 128, "%s", animlib);
		format(ActorData[index][actorAnimName], 128, "%s", animname);
		ApplyDynamicActorAnimation(ActorData[index][actorObject], animlib, animname, 4.1, 1, 0, 0, 1, 0);
//		printf("%d %s %s %s %s", index, animlib, animname, ActorData[index][actorAnimLib], ActorData[index][actorAnimName]);
		Actor_Save(index);
		return 1;
	}
	return 0;
}
Actor_SetCash(index, amount, bool:reduce = false)
{
	if(Actor_IsExists(index))
	{
		if(reduce)
		{
			ActorData[index][actorCash] -= amount;
			if(ActorData[index][actorCash] <= 0)
				ActorData[index][actorCash] = 0;
		}
		else
		{
			ActorData[index][actorCash] = amount;
		}
		Actor_Save(index);
		return 1;
	}
	return 0;
}

Actor_Delete(index)
{
	if(Actor_IsExists(index))
	{
		Iter_Remove(ServerActor, index);
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `actor` WHERE `actorID`='%d';", ActorData[index][actorID]));

		if(IsValidDynamicActor(ActorData[index][actorObject]))
			DestroyDynamicActor(ActorData[index][actorObject]);

		if(IsValidDynamic3DTextLabel(ActorData[index][actorText]))
			DestroyDynamic3DTextLabel(ActorData[index][actorText]);
	
		new tmp_ActorData[E_ACTOR_DATA];
		ActorData[index] = tmp_ActorData;

		ActorData[index][actorText] = Text3D:INVALID_STREAMER_ID;
		ActorData[index][actorObject] = INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

stock Actor_Sync(index)
{
	if(Actor_IsExists(index))
	{	
		new string[255];
		if(IsValidDynamicActor(ActorData[index][actorObject]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_ACTOR, ActorData[index][actorObject], E_STREAMER_X, ActorData[index][actorPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_ACTOR, ActorData[index][actorObject], E_STREAMER_Y, ActorData[index][actorPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_ACTOR, ActorData[index][actorObject], E_STREAMER_Z, ActorData[index][actorPos][2]);
			Streamer_SetFloatData(STREAMER_TYPE_ACTOR, ActorData[index][actorObject], E_STREAMER_R_Z, ActorData[index][actorPos][3]);

			Streamer_SetIntData(STREAMER_TYPE_ACTOR, ActorData[index][actorObject], E_STREAMER_INTERIOR_ID, ActorData[index][actorInterior]);
			Streamer_SetIntData(STREAMER_TYPE_ACTOR, ActorData[index][actorObject], E_STREAMER_WORLD_ID, ActorData[index][actorVirtualWorld]);
		}
		else 
		{
			if(strcmp(ActorData[index][actorAnimLib], "", true) && strcmp(ActorData[index][actorAnimName], "", true))
			{
				ActorData[index][actorObject] = CreateDynamicActor(ActorData[index][actorModel], ActorData[index][actorPos][0], ActorData[index][actorPos][1], ActorData[index][actorPos][2], ActorData[index][actorPos][3], true, 100, ActorData[index][actorVirtualWorld], ActorData[index][actorInterior]);
			}
			else
			{
				ActorData[index][actorObject] = CreateDynamicActor(ActorData[index][actorModel], ActorData[index][actorPos][0], ActorData[index][actorPos][1], ActorData[index][actorPos][2], ActorData[index][actorPos][3], true, 100, ActorData[index][actorVirtualWorld], ActorData[index][actorInterior]);
				ApplyDynamicActorAnimation(ActorData[index][actorObject], ActorData[index][actorAnimLib], ActorData[index][actorAnimName], 4.1, 1, 0, 0, 1, 0);
			}
			Streamer_SetIntData(STREAMER_TYPE_ACTOR, ActorData[index][actorObject], E_STREAMER_EXTRA_ID, index);
		}
		if(IsValidDynamic3DTextLabel(ActorData[index][actorText]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ActorData[index][actorText], E_STREAMER_X, ActorData[index][actorPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ActorData[index][actorText], E_STREAMER_Y, ActorData[index][actorPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ActorData[index][actorText], E_STREAMER_Z, ActorData[index][actorPos][1]);

			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, ActorData[index][actorText], E_STREAMER_INTERIOR_ID, ActorData[index][actorInterior]);
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, ActorData[index][actorText], E_STREAMER_WORLD_ID, ActorData[index][actorVirtualWorld]);
		}
		else 
		{
			format(string, sizeof(string), ""RED"[Actor] "WHITE"%s (%d)", ActorData[index][actorName], index);
			ActorData[index][actorText] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ActorData[index][actorPos][0], ActorData[index][actorPos][1], ActorData[index][actorPos][2]+1, 30, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ActorData[index][actorVirtualWorld], ActorData[index][actorInterior]);
		}
	}
	return 1;
}

Actor_Save(index)
{
	if(Actor_IsExists(index))
	{
		//printf("Saving %d %s %s", index, ActorData[index][actorAnimLib], ActorData[index][actorAnimName]);
		mysql_tquery(g_iHandle, sprintf("UPDATE actor SET actorName='%s',actorAnimLib='%s',actorAnimName='%s',actorX='%.3f',actorY='%.3f',actorZ='%.3f',actorA='%.3f',actorInterior='%d',actorVirtualWorld='%d',actorModel='%d', actorType='%d', actorCash='%d' WHERE actorID='%d';", 
			SQL_ReturnEscaped(ActorData[index][actorName]),
			ActorData[index][actorAnimLib],
			ActorData[index][actorAnimName],
			ActorData[index][actorPos][0],
			ActorData[index][actorPos][1],
			ActorData[index][actorPos][2],
			ActorData[index][actorPos][3],
			ActorData[index][actorInterior],
			ActorData[index][actorVirtualWorld],
			ActorData[index][actorModel],
			ActorData[index][actorType],
			ActorData[index][actorCash],
			ActorData[index][actorID]
		));
		return 1;
	}
	return 0;
}

Actor_Nearest(playerid, Float:range = 6.0)
{
	foreach(new i : ServerActor) if(IsPlayerInRangeOfPoint(playerid, range, ActorData[i][actorPos][0], ActorData[i][actorPos][1], ActorData[i][actorPos][2]))
	{
		if(GetPlayerInterior(playerid) == ActorData[i][actorInterior] && GetPlayerVirtualWorld(playerid) == ActorData[i][actorVirtualWorld])
			return i;
	}
	return -1;
}

timer Player_Grabcash[1000](playerid, actorid)
{
	new last_biz = PlayerData[playerid][pLastBiz];
	if(++GrabCashCounter[playerid] > 3)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 5.0 , ActorData[actorid][actorPos][0], ActorData[actorid][actorPos][1], ActorData[actorid][actorPos][2]))
		{
			GrabCash[playerid] = 0;
			GrabCashCounter[playerid] = 0;
			SendErrorMessage(playerid, "You are not near cashier!");
			ClearAnimations(playerid);
			stop GrabCashTimer[playerid];
			return 1;
		}
		if(GrabCash[playerid] && Actor_GetCash(actorid) > 0)
		{
			new rand = RandomEx(50, 70), string[128];
			GiveMoney(playerid, rand);
			Actor_SetCash(actorid, rand, true);
			format(string, sizeof(string), "grabbing %s cash from the cashier", FormatNumber(rand));
			cmd_ame(playerid, string);
		}
		else
		{
			GrabCash[playerid] = 0;
			ActorData[actorid][actorNotification]++;
			ClearAnimations(playerid);
			ClearDynamicActorAnimations(ActorData[actorid][actorObject]);
			
			if(ActorData[actorid][actorNotification] > 0 && ActorData[actorid][actorNotification] < 2)
			{
				SendFactionMessageEx(FACTION_POLICE, COLOR_HOSPITAL, ""COL_LIGHTBLUE"[ALARM] "WHITE"%s Business alarm is triggered, "RED"business is getting rob", BusinessData[last_biz][bizName]);
				defer ResetRobberyNotification(actorid);
			}
			stop GrabCashTimer[playerid];
		}
		GrabCashCounter[playerid] = 0;
	}
	ApplyAnimation(playerid, "ROB_BANK", "CAT_SAFE_ROB", 4.1, 1, 0, 0, 1, 0, 1);
	return 1;
}

task Server_RestockCash[10800000]()
{
	foreach(new i : ServerActor)
	{
		Actor_SetCash(i, 15000);
	}
	return 1;
}

timer ResetRobberyNotification[5000](actorid)
{
	ActorData[actorid][actorNotification] = 0;
	return 1;
}