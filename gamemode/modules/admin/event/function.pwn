#include <YSI\y_hooks>

stock IsPlayerInEvent(playerid)
{
	if(eventJoin[playerid])
		return 1;

	return 0;
}
stock EventType(type)
{
	new name[25];
	switch(type)
	{
		case TYPE_TDM: name = "Team Deathmatch";
		case TYPE_JETPACK: name = "Jetpack";
		case TYPE_DM: name = "Deathmatch";
		case TYPE_NONE: name = "N/A";
	}
	return name;
}

stock eventCount()
{
	new count = 0;
	foreach(new i : Player) if(IsPlayerInEvent(i)) {
		count++;
	}
	return count;
}

stock SendEventMessageAll(color, message[])
{
	foreach(new i : Player) if(IsPlayerInEvent(i)) 
	{
		SendClientMessage(i, color, message);
	}
	return 1;
}
stock SendEventTeamMessage(playerid, color, message[])
{
	foreach(new i : Player) if(IsPlayerInEvent(i) && eventTeams[playerid] == eventTeams[i]) {
		SendClientMessage(i, color, message);
	}
	return 1;
}

stock eventTextdraw(playerid, text[])
{
	if(IsPlayerInEvent(playerid))
	{
		TextDrawSetString(eventTextdraws[2], sprintf("%d!", EventData[eventTarget]));
		TextDrawSetString(eventTextdraws[3], sprintf("~r~Team_A:_%d~n~~b~Team_B:_%d", EventData[eventScore][0], EventData[eventScore][1]));

		eventMessageText[0] = eventMessageText[1];
		eventMessageText[1] = eventMessageText[2];
		eventMessageText[2] = eventMessageText[3];
		format(eventMessageText[3], 128, text);

		TextDrawSetString(eventTextdraws[4],eventMessageText[0]);
		TextDrawSetString(eventTextdraws[5],eventMessageText[1]);
		TextDrawSetString(eventTextdraws[6],eventMessageText[2]);
		TextDrawSetString(eventTextdraws[7],eventMessageText[3]);
	}
	return 1;
}

stock Player_ToggleEventAntiCheat(playerid, bool:toggle)
{
    if (!IsPlayerConnected(playerid))
    {
        return 0;
    }
	EnableAntiCheatForPlayer(playerid, 2, toggle);
	EnableAntiCheatForPlayer(playerid, 3, toggle);
	EnableAntiCheatForPlayer(playerid, 4, toggle);
	EnableAntiCheatForPlayer(playerid, 5, toggle);
	EnableAntiCheatForPlayer(playerid, 6, toggle);
	EnableAntiCheatForPlayer(playerid, 15, toggle);
	EnableAntiCheatForPlayer(playerid, 16, toggle);
	EnableAntiCheatForPlayer(playerid, 17, toggle);
	EnableAntiCheatForPlayer(playerid, 18, toggle);
	EnableAntiCheatForPlayer(playerid, 19, toggle);
	EnableAntiCheatForPlayer(playerid, 20, toggle);
	EnableAntiCheatForPlayer(playerid, 21, toggle);
	return 1;
}
stock eventSpawn(playerid)
{
	if(IsPlayerInEvent(playerid))
	{
		if(EventData[eventType] == TYPE_TDM)
		{

			Player_ToggleEventAntiCheat(playerid, false);
			SetPlayerPos(playerid, EventData[eventSpawnX][eventTeams[playerid]-1], EventData[eventSpawnY][eventTeams[playerid]-1], EventData[eventSpawnZ][eventTeams[playerid]-1]);
			SetPlayerFacingAngle(playerid, EventData[eventSpawnA][eventTeams[playerid]-1]);
			SetCameraBehindPlayer(playerid);

			SetPlayerSkinEx(playerid, EventData[eventSkin][eventTeams[playerid]-1], 0, 1);

			SetPlayerInterior(playerid, EventData[eventInt]);
			SetPlayerVirtualWorld(playerid, EventData[eventWorld]);

			for(new i = 0; i != 3; i++) 
			{
				if(EventData[eventWeapons][i]) 
				{
					GivePlayerEventWeapon(playerid, EventData[eventWeapons][i], EventData[eventAmmo][i]);
				}
			}
			SendServerMessage(playerid, "You're spawn to the event.");

			haupdate[playerid] = defer eventSpawnProp[500](playerid);

		}
		else if(EventData[eventType] == TYPE_DM)
		{
			Player_ToggleEventAntiCheat(playerid, false);

			SetPlayerTeam(playerid, NO_TEAM);
			SetPlayerPos(playerid, EventData[eventSpawnX_DM], EventData[eventSpawnY_DM], EventData[eventSpawnZ_DM]);
			SetCameraBehindPlayer(playerid);

			SetPlayerInterior(playerid, EventData[eventInt]);
			SetPlayerVirtualWorld(playerid, EventData[eventWorld]);

			for(new i = 0; i != 3; i++) 
			{
				if(EventData[eventWeapons][i]) 
				{
					GivePlayerEventWeapon(playerid, EventData[eventWeapons][i], EventData[eventAmmo][i]);
				}
			}
			SendServerMessage(playerid, "You're spawn to the event.");

			haupdate[playerid] = defer eventSpawnProp[500](playerid);
		}
	}
	return 1;
}
stock GivePlayerEventWeapon(playerid, weaponid, ammo)
{
	if(IsPlayerInEvent(playerid))
	{
		GivePlayerWeapon(playerid, weaponid, ammo);
	}
	return 1;
}
stock eventLeave(playerid)
{
	ResetPlayerWeapons(playerid);
	eventTeams[playerid] = TEAM_NONE;
	for(new id = 0; id != 8; id++) 
	{
		TextDrawHideForPlayer(playerid, eventTextdraws[id]);
	}

	Player_ToggleEventAntiCheat(playerid, true);

	eventScore_DM[playerid] = 0;
	eventJoin[playerid] = 0;

	SetPlayerTeam(playerid, 1);
    SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
	SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);

	if(GetPlayerState(playerid) == PLAYER_STATE_WASTED)
	{
		SetSpawnInfo(playerid, 1, PlayerData[playerid][pSkin], PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2], 0.0, 0, 0, 0, 0, 0, 0);
	}

	SetPlayerPosEx(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);

	SetHealth(playerid, GetHealth(playerid));
	SetArmour(playerid, GetArmour(playerid));

	if(AccountData[playerid][pAdminDuty]) 
	{
		SetPlayerSkinEx(playerid, PlayerData[playerid][pSkin], 0, 1); 
		SetPlayerColor(playerid, X11_RED);
	}
	else if(PlayerData[playerid][pOnDuty])
	{ 
		if(PlayerData[playerid][pUndercoverDuty])
		{
			SetPlayerColor(playerid, DEFAULT_COLOR);
		}
		else
		{
			SetFactionColor(playerid);
		}
		SetPlayerSkinEx(playerid, PlayerData[playerid][pSkinFaction], 1);
		RefreshFactionWeapon(playerid);
	}
	else 
	{
		SetPlayerSkinEx(playerid, PlayerData[playerid][pSkin], 0, 1);
		SetPlayerColor(playerid, DEFAULT_COLOR);
		RefreshWeapon(playerid);
	}
	DisablePlayerRaceCheckpoint(playerid);
	return 1;
}


timer eventSpawnProp[500](playerid)
{
	if(SQL_IsLogged(playerid) && IsPlayerInEvent(playerid))
	{
		SetPlayerHealth(playerid, EventData[eventHealth]);
		SetPlayerArmour(playerid, EventData[eventArmor]);
	}
	return 1;
}


