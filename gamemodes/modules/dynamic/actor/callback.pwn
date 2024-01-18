#include <YSI\y_hooks>

forward OnActorCreated(index);
public OnActorCreated(index)
{
	ActorData[index][actorID] = cache_insert_id();
	//Actor_Sync(index);
	Actor_Save(index);
	return 1;
}

forward Actor_Load();
public Actor_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(ServerActor, i);

			cache_get_field_content(i, "actorName", ActorData[i][actorName], 128);
			cache_get_field_content(i, "actorAnimLib", ActorData[i][actorAnimLib], 128);
			cache_get_field_content(i, "actorAnimName", ActorData[i][actorAnimName], 128);


			ActorData[i][actorID] = cache_get_field_int(i, "actorID");
			ActorData[i][actorInterior] = cache_get_field_int(i, "actorInterior");
			ActorData[i][actorVirtualWorld] = cache_get_field_int(i, "actorVirtualWorld");

            ActorData[i][actorPos][0] = cache_get_field_float(i, "actorX");
            ActorData[i][actorPos][1] = cache_get_field_float(i, "actorY");
            ActorData[i][actorPos][2] = cache_get_field_float(i, "actorZ");
            ActorData[i][actorPos][3] = cache_get_field_float(i, "actorA");
			ActorData[i][actorModel] = cache_get_field_int(i, "actorModel");
			ActorData[i][actorType] = cache_get_field_int(i, "actorType");
			ActorData[i][actorCash] = cache_get_field_int(i, "actorCash");
			ActorData[i][actorStatus] = 0;

			Actor_Sync(i);
		}
		printf("*** Loaded %d Actor's", cache_num_rows());
	}
	return 1;
}

hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, "SELECT * FROM `actor` ORDER BY `actorID` ASC LIMIT "#MAX_DYNAMIC_ACTOR";", "Actor_Load", "");
}

hook OnPlayerConnect(playerid)
{
	GrabCash[playerid] = 0;
	GrabCashCounter[playerid] = 0;
}

hook OnPlayerUpdate(playerid)
{
	if(IsPlayerAiming(playerid) && GetPlayerWeapon(playerid) >= 22 && GetPlayerWeapon(playerid) <= 38)
	{
		new 
			last_actorid = PlayerData[playerid][pLastActor],
			last_bizid = PlayerData[playerid][pLastBiz]
		;

		if(last_actorid != INVALID_DYNAMIC_ACTOR_ID && ActorData[last_actorid][actorType] == ACTOR_TYPE_STORE)
		{
			if(GetPlayerTargetDynamicActor(playerid) != 0 && !ActorData[last_actorid][actorStatus])
			{
				if(!ActorData[last_actorid][actorCooldown])
				{
					if(FactionMember_GetTypeCount(FACTION_POLICE, true) >= 4)
					{
						ApplyDynamicActorAnimation(ActorData[last_actorid][actorObject], "ROB_BANK", "SHP_HandsUp_Scr", 4.1, 0, 0, 0, 1, 0);
						ActorData[last_actorid][actorStatus] = 1;
						PlayerData[playerid][pLastActor] = last_actorid;
					}
					else
					{
						SendErrorMessage(playerid, "There are not enough PD in-town at the moment!");
						PlayerData[playerid][pLastActor] = INVALID_DYNAMIC_ACTOR_ID;
					}
				}
				else
				{
					SendErrorMessage(playerid, "This actor is on cooldown, it will reset on 23:00 Phonetime!");
					PlayerData[playerid][pLastActor] = INVALID_DYNAMIC_ACTOR_ID;	
				}
			}
			else if(GetPlayerTargetDynamicActor(playerid) == 0 && ActorData[last_actorid][actorStatus])
			{
				ClearDynamicActorAnimations(ActorData[last_actorid][actorObject]);
				if(!strcmp(ActorData[last_actorid][actorAnimLib], "", true) && !strcmp(ActorData[last_actorid][actorAnimName], "", true))
				{
					ApplyDynamicActorAnimation(ActorData[last_actorid][actorObject], ActorData[last_actorid][actorAnimLib], ActorData[last_actorid][actorAnimName], 4.1, 1, 0, 0, 1, 0);
				}
				ActorData[last_actorid][actorStatus] = 0;
				PlayerData[playerid][pLastActor] = INVALID_DYNAMIC_ACTOR_ID;
				ActorData[last_actorid][actorNotification]++;
				ActorData[last_actorid][actorCooldown] = 1;
				if(last_bizid != -1 && ActorData[last_actorid][actorNotification] > 0 && ActorData[last_actorid][actorNotification] < 2)
				{
					SendFactionMessageEx(FACTION_POLICE, COLOR_HOSPITAL, ""COL_LIGHTBLUE"[ALARM] "WHITE"%s Business alarm is triggered, business is under robbery", BusinessData[last_bizid][bizName]);
					defer ResetRobberyNotification(last_actorid);
				}
			}
		}
	}
	return 1;
}

hook OnWorldTimeUpdate(hour, minute)
{
	if(hour == 23 && minute == 0)
	{
		foreach(new i : ServerActor)
		{
			if(ActorData[i][actorCooldown])
				ActorData[i][actorCooldown] = 0;
		}
	}
}


public OnPlayerStartAim(playerid, weaponid)
{
	new index, bizid, actorid = GetPlayerCameraTargetDynActor(playerid);
	if(weaponid >= 22 && weaponid <= 38)
	{
		if(actorid > 0 && (index = Streamer_GetIntData(STREAMER_TYPE_ACTOR, actorid, E_STREAMER_EXTRA_ID)) != -1)
		{
			if(ActorData[index][actorType] == ACTOR_TYPE_STORE)
			{
				if((bizid = Business_Inside(playerid)) != -1)
				{
					PlayerData[playerid][pLastActor] = index;
					PlayerData[playerid][pLastBiz] = bizid;
				}
			}
		}
	}
	return 1;
}
public OnPlayerStopAim(playerid)
{
	new 
		index = PlayerData[playerid][pLastActor],
		last_bizid = PlayerData[playerid][pLastBiz]
	;
	if(index != INVALID_DYNAMIC_ACTOR_ID)
	{
		ClearDynamicActorAnimations(ActorData[index][actorObject]);
		if(!strcmp(ActorData[index][actorAnimLib], "", true) && !strcmp(ActorData[index][actorAnimName], "", true))
		{
			ApplyDynamicActorAnimation(ActorData[index][actorObject], ActorData[index][actorAnimLib], ActorData[index][actorAnimName], 4.1, 1, 0, 0, 1, 0);
		}
		ActorData[index][actorStatus] = 0;
		PlayerData[playerid][pLastActor] = INVALID_DYNAMIC_ACTOR_ID;
		ActorData[index][actorNotification]++;
		if(last_bizid != -1 && ActorData[index][actorNotification] > 0 && ActorData[index][actorNotification] < 2)
		{
			SendFactionMessageEx(FACTION_POLICE, COLOR_HOSPITAL, ""COL_LIGHTBLUE"[ALARM] "WHITE"%s Business alarm is triggered, business is under robbery", BusinessData[last_bizid][bizName]);
			defer ResetRobberyNotification(index);
		}
	}
	return 1;
}
