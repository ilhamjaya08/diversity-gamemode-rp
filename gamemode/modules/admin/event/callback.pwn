#include <YSI\y_hooks>


hook OnPlayerText(playerid, text[])
{
	if(IsPlayerInEvent(playerid))
	{
		foreach(new i : Player)
		{ 
			if(IsPlayerInEvent(i) && eventTeams[playerid] == eventTeams[i] && EventData[eventType] == TYPE_TDM) 
			{
				if (strlen(text) > 64)
				{
					SendClientMessageEx(i, eventTeams[playerid] == TEAM_A ? X11_RED : COLOR_BLUE, "%s: "WHITE"%.64s ..", ReturnName(playerid, 0), text);
					SendClientMessageEx(i, eventTeams[playerid] == TEAM_A ? X11_RED : COLOR_BLUE, "%s: "WHITE".. %s", ReturnName(playerid, 0), text[64]);
				}
				else
				{
					SendClientMessageEx(i, eventTeams[playerid] == TEAM_A ? X11_RED : COLOR_BLUE, "%s: "WHITE"%s", ReturnName(playerid, 0), text);
				}
			}
			else if(IsPlayerInEvent(i) && EventData[eventType] == TYPE_DM)
			{
				if (strlen(text) > 64)
				{
					SendClientMessageEx(i, COLOR_LIGHTRED, "%s: "WHITE"%.64s ..", ReturnName(playerid, 0), text);
					SendClientMessageEx(i, COLOR_LIGHTRED, "%s: "WHITE".. %s", ReturnName(playerid, 0), text[64]);
				}
				else
				{
					SendClientMessageEx(i, COLOR_LIGHTRED, "%s: "WHITE"%s", ReturnName(playerid, 0), text);
				}
			}
		}
	}
}
hook OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPlayerInEvent(playerid))
	{
		ClearAnimations(playerid);
		if(killerid != INVALID_PLAYER_ID)
		{
			if(EventData[eventType] == TYPE_TDM)
			{
				EventData[eventScore][eventTeams[killerid]-1]++;
		
				eventTextdraw(playerid, sprintf("%s%s~w~_has_killed_by_%s%s_~w~Team_%s%s:_~g~%d", eventTeams[playerid] == TEAM_A ? ("~r~") : ("~b~"), 
					ReturnName(playerid), eventTeams[killerid] == TEAM_A ? ("~r~") : ("~b~"),
					ReturnName(killerid), eventTeams[killerid] == TEAM_A ? ("~r~") : ("~b~"),
					eventTeams[killerid] == TEAM_A ? ("A") : ("B"), EventData[eventScore][eventTeams[killerid]-1])
				);

				if(EventData[eventScore][eventTeams[killerid]-1] >= EventData[eventTarget]) 
				{
					EventData[eventWinner] = eventTeams[killerid];

					SendEventMessageAll(COLOR_CLIENT, sprintf("EVENT: "WHITE"Event telah selesai dan "YELLOW"team %s "WHITE"sebagai pemenang.", (eventTeams[killerid] == TEAM_A) ? ("A") : ("B")));

					foreach(new i : Player)
					{ 
						if(IsPlayerInEvent(i))
						{
							if(eventTeams[i] == EventData[eventWinner]) 
							{
								GiveMoney(i, EventData[eventBonus]*3, ECONOMY_TAKE_SUPPLY, "Event prize");
								SendCustomMessage(i, "EVENT", "Team anda menang dalam event ini dan mendapat hadiah sebanyak "GREEN"%s.", FormatNumber(EventData[eventBonus]*3));
							}
							else
							{
								GiveMoney(i, EventData[eventBonus], ECONOMY_TAKE_SUPPLY, "Event prize");
								SendCustomMessage(i, "EVENT", "Kamu mendapat bonus "GREEN"%s "WHITE"dari partisipasi event.", FormatNumber(EventData[eventBonus]));
							} 
							eventLeave(i);
						}
					}
					static const empty_player[E_EVENT];
					EventData = empty_player;
				}
				else 
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_WASTED)
					{
						SetSpawnInfo(playerid, eventTeams[playerid], EventData[eventSkin][eventTeams[playerid]-1], EventData[eventSpawnX][eventTeams[playerid]-1], EventData[eventSpawnY][eventTeams[playerid]-1], EventData[eventSpawnZ][eventTeams[playerid]-1], 0.0, 0, 0, 0, 0, 0, 0);
					}
					eventWaitingSpawn[playerid] = 1;
				}
			}
			else if(EventData[eventType] == TYPE_DM)
			{
				eventScore_DM[killerid]++;
				SendEventMessageAll(COLOR_CLIENT, sprintf("EVENT: "WHITE"%s telah dibunuh oleh "RED"%s "WHITE"jumlah point %d.", ReturnName(playerid), ReturnName(killerid), eventScore_DM[killerid]));
				if(eventScore_DM[killerid] >= EventData[eventTarget])
				{
					EventData[eventWinner] = killerid;
					SendEventMessageAll(COLOR_CLIENT, sprintf("EVENT: "WHITE"Event telah selesai dan "YELLOW"%s "WHITE"adalah pemenangnya.", ReturnName(killerid)));

					foreach(new i : Player)
					{ 
						if(IsPlayerInEvent(i))
						{
							if(i == EventData[eventWinner]){
								GiveMoney(i, EventData[eventBonus]*3, ECONOMY_TAKE_SUPPLY, "Event prize");
								SendCustomMessage(i, "EVENT", "Anda menang dalam event ini dan mendapat hadiah sebanyak "GREEN"%s.", FormatNumber(EventData[eventBonus]*3));
							}
							else
							{
								GiveMoney(i, EventData[eventBonus], ECONOMY_TAKE_SUPPLY, "Event prize");
								SendCustomMessage(i, "EVENT", "Kamu mendapat bonus "GREEN"%s "WHITE"dari partisipasi event.", FormatNumber(EventData[eventBonus]));
							}

							eventLeave(i);
						}
					}
					static const empty_player[E_EVENT];
					EventData = empty_player;
				}
				else 
				{
					if(GetPlayerState(playerid) == PLAYER_STATE_WASTED)
					{
						SetSpawnInfo(playerid, eventTeams[playerid], PlayerData[playerid][pSkin], EventData[eventSpawnX_DM], EventData[eventSpawnY_DM], EventData[eventSpawnZ_DM], 0.0, 0, 0, 0, 0, 0, 0);
					}
					eventWaitingSpawn[playerid] = 1;
				}
			}
		}	
		ResetPlayerWeapons(playerid);
	}
}
hook OnPlayerEnterRaceCP(playerid)
{
	if(IsPlayerInEvent(playerid) && EventData[eventType] == TYPE_JETPACK)
	{
		eventCheckpoint[playerid]++;

		if(eventCheckpoint[playerid] < (EventData[eventJetpackType]*16))
		{
			SetPlayerRaceCheckpoint(playerid, 4, arrJetEvent[eventCheckpoint[playerid]][jX], arrJetEvent[eventCheckpoint[playerid]][jY], 
				arrJetEvent[eventCheckpoint[playerid]][jZ], arrJetEvent[eventCheckpoint[playerid]+1][jX], arrJetEvent[eventCheckpoint[playerid]+1][jY], 
				arrJetEvent[eventCheckpoint[playerid]+1][jZ], 3
			);
		}
		
		if(eventCheckpoint[playerid] == (EventData[eventJetpackType]*16)-1)
		{
			SetPlayerRaceCheckpoint(playerid, 1, arrJetEvent[eventCheckpoint[playerid]][jX], arrJetEvent[eventCheckpoint[playerid]][jY], 
				arrJetEvent[eventCheckpoint[playerid]][jZ], 0.0, 0.0, 0.0, 3
			);
		}
		
		if(eventCheckpoint[playerid] == (EventData[eventJetpackType]*16)) 
		{
			EventData[eventWinner] = playerid;
			DisablePlayerRaceCheckpoint(playerid);

			SendEventMessageAll(COLOR_CLIENT, sprintf("EVENT: "WHITE"Event "RED"Jetpack "WHITE"telah selesai dan dimenangkan oleh "YELLOW"%s", ReturnName(playerid, 0)));
			SendAdminMessage(X11_TOMATO_1, "AdmWarn: Event Jetpack dimenangkan oleh %s", ReturnName(playerid, 0));

		    foreach(new i : Player) if(IsPlayerInEvent(i))
		    {
		    	if(EventData[eventWinner] == playerid)
					{
						GiveMoney(playerid, EventData[eventBonus], ECONOMY_TAKE_SUPPLY, "Event prize");
						SendCustomMessage(playerid, "EVENT", "Kamu menang dalam event "RED"jetpack.");
					}
		    	else
					{
						GiveMoney(playerid, EventData[eventBonus], ECONOMY_TAKE_SUPPLY, "Event prize");
						SendCustomMessage(playerid, "EVENT", "Kamu mendapat bonus {00FF00}%s "WHITE"dari partisipasi jetpack event.", FormatNumber(EventData[eventBonus]));
					}

			    eventLeave(i);
			}
			static const empty_player[E_EVENT];
		    EventData = empty_player;
		}
	}
}

hook OnPlayerSpawn(playerid)
{
	if(IsPlayerInEvent(playerid))
	{
		eventSpawn(playerid);
	}
}

hook OnScriptInit()
{
	eventTextdraws[0] = TextDrawCreate(503.306060, 147.999954, "box");
	TextDrawLetterSize(eventTextdraws[0], 0.000000, 8.594435);
	TextDrawTextSize(eventTextdraws[0], 631.395507, 0.000000);
	TextDrawAlignment(eventTextdraws[0], 1);
	TextDrawColor(eventTextdraws[0], -1);
	TextDrawUseBox(eventTextdraws[0], 1);
	TextDrawBoxColor(eventTextdraws[0], 189);
	TextDrawSetShadow(eventTextdraws[0], 0);
	TextDrawSetOutline(eventTextdraws[0], 0);
	TextDrawBackgroundColor(eventTextdraws[0], 255);
	TextDrawFont(eventTextdraws[0], 1);
	TextDrawSetProportional(eventTextdraws[0], 1);
	TextDrawSetShadow(eventTextdraws[0], 0);

	eventTextdraws[1] = TextDrawCreate(567.464721, 150.716690, "TDM_EVENT_SCOREBOARD");
	TextDrawLetterSize(eventTextdraws[1], 0.251010, 1.349166);
	TextDrawTextSize(eventTextdraws[1], 0.000000, 123.000000);
	TextDrawAlignment(eventTextdraws[1], 2);
	TextDrawColor(eventTextdraws[1], -1061109505);
	TextDrawUseBox(eventTextdraws[1], 1);
	TextDrawBoxColor(eventTextdraws[1], -1061109505);
	TextDrawSetShadow(eventTextdraws[1], 0);
	TextDrawSetOutline(eventTextdraws[1], 1);
	TextDrawBackgroundColor(eventTextdraws[1], 255);
	TextDrawFont(eventTextdraws[1], 1);
	TextDrawSetProportional(eventTextdraws[1], 1);
	TextDrawSetShadow(eventTextdraws[1], 0);

	eventTextdraws[2] = TextDrawCreate(565.522460, 166.834075, "0!");
	TextDrawLetterSize(eventTextdraws[2], 0.466158, 2.332501);
	TextDrawAlignment(eventTextdraws[2], 2);
	TextDrawColor(eventTextdraws[2], -1061109505);
	TextDrawSetShadow(eventTextdraws[2], 0);
	TextDrawSetOutline(eventTextdraws[2], 1);
	TextDrawBackgroundColor(eventTextdraws[2], 255);
	TextDrawFont(eventTextdraws[2], 3);
	TextDrawSetProportional(eventTextdraws[2], 1);
	TextDrawSetShadow(eventTextdraws[2], 0);

	eventTextdraws[3] = TextDrawCreate(505.045623, 190.785247, "Team_A:_0");
	TextDrawLetterSize(eventTextdraws[3], 0.270000, 1.399999);
	TextDrawAlignment(eventTextdraws[3], 1);
	TextDrawColor(eventTextdraws[3], -16777023);
	TextDrawSetShadow(eventTextdraws[3], 0);
	TextDrawSetOutline(eventTextdraws[3], 1);
	TextDrawBackgroundColor(eventTextdraws[3], 255);
	TextDrawFont(eventTextdraws[3], 1);
	TextDrawSetProportional(eventTextdraws[3], 1);
	TextDrawSetShadow(eventTextdraws[3], 0);

	eventTextdraws[4] = TextDrawCreate(635.461364, 332.133422, "_");
	TextDrawLetterSize(eventTextdraws[4], 0.203220, 1.174166);
	TextDrawAlignment(eventTextdraws[4], 3);
	TextDrawColor(eventTextdraws[4], -1);
	TextDrawSetShadow(eventTextdraws[4], 0);
	TextDrawSetOutline(eventTextdraws[4], 1);
	TextDrawBackgroundColor(eventTextdraws[4], 255);
	TextDrawFont(eventTextdraws[4], 1);
	TextDrawSetProportional(eventTextdraws[4], 1);
	TextDrawSetShadow(eventTextdraws[4], 0);

	eventTextdraws[5] = TextDrawCreate(635.461364, 343.133422, "_");
	TextDrawLetterSize(eventTextdraws[5], 0.203220, 1.174166);
	TextDrawAlignment(eventTextdraws[5], 3);
	TextDrawColor(eventTextdraws[5], -1);
	TextDrawSetShadow(eventTextdraws[5], 0);
	TextDrawSetOutline(eventTextdraws[5], 1);
	TextDrawBackgroundColor(eventTextdraws[5], 255);
	TextDrawFont(eventTextdraws[5], 1);
	TextDrawSetProportional(eventTextdraws[5], 1);
	TextDrawSetShadow(eventTextdraws[5], 0);

	eventTextdraws[6] = TextDrawCreate(635.461364, 354.133422, "_");
	TextDrawLetterSize(eventTextdraws[6], 0.203220, 1.174166);
	TextDrawAlignment(eventTextdraws[6], 3);
	TextDrawColor(eventTextdraws[6], -1);
	TextDrawSetShadow(eventTextdraws[6], 0);
	TextDrawSetOutline(eventTextdraws[6], 1);
	TextDrawBackgroundColor(eventTextdraws[6], 255);
	TextDrawFont(eventTextdraws[6], 1);
	TextDrawSetProportional(eventTextdraws[6], 1);
	TextDrawSetShadow(eventTextdraws[6], 0);

	eventTextdraws[7] = TextDrawCreate(635.461364, 365.133422, "_");
	TextDrawLetterSize(eventTextdraws[7], 0.203220, 1.174166);
	TextDrawAlignment(eventTextdraws[7], 3);
	TextDrawColor(eventTextdraws[7], -1);
	TextDrawSetShadow(eventTextdraws[7], 0);
	TextDrawSetOutline(eventTextdraws[7], 1);
	TextDrawBackgroundColor(eventTextdraws[7], 255);
	TextDrawFont(eventTextdraws[7], 1);
	TextDrawSetProportional(eventTextdraws[7], 1);
	TextDrawSetShadow(eventTextdraws[7], 0);
}