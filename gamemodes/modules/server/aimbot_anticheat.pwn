/* Credits to pottus from 420Dayz*/

#include <YSI\y_hooks>

#define         NUM_SHOT_CHECK          10
#define         EXCESS_AMOUNT           7

forward OnPlayerExcessAccuracy(playerid, total);

static PlayerTargetShots[MAX_PLAYERS];
static PlayerTargetHits[MAX_PLAYERS];
static LastShots[MAX_PLAYERS][NUM_SHOT_CHECK];
static Currshot[MAX_PLAYERS];
static TotalChecks[MAX_PLAYERS];

hook OnGameModeInit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
        for(new j = 0; j < NUM_SHOT_CHECK; j++) { LastShots[i][j] = -1; }
	}
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	// player was targeted
	if(GetPlayerTargetPlayer(playerid) != INVALID_PLAYER_ID)
	{
		// Was a player hit?
		if(hittype == BULLET_HIT_TYPE_PLAYER)
		{
			// No NPCs
			if(!IsPlayerNPC(hitid))
			{
				// Check if player shot is standing still
				new Float:vx, Float:vy, Float:vz;
				GetPlayerVelocity(hitid, vx, vy, vz);

				if(vx != 0.0 || vy != 0.0 || vz != 0.0)
				{
					PlayerTargetShots[playerid]++;
					PlayerTargetHits[playerid]++;
					LastShots[playerid][Currshot[playerid]] = 1;

					new total = CheckLastShots(playerid);

					if(total > 0)
					{
						TotalChecks[playerid]++;
						CallLocalFunction("OnPlayerExcessAccuracy", "ii", playerid, total);
					}

					Currshot[playerid]++;
					if(Currshot[playerid] == NUM_SHOT_CHECK)
					{
						Currshot[playerid] = 0;
						for(new i = 0; i < NUM_SHOT_CHECK; i++) { LastShots[playerid][i] = -1; }
					}
				}
			}
		}
		else
		{
			PlayerTargetShots[playerid]++;
			LastShots[playerid][Currshot[playerid]] = 0;

			new total = CheckLastShots(playerid);

			if(total > 0)
			{
				TotalChecks[playerid]++;
				CallLocalFunction("OnPlayerExcessAccuracy", "ii", playerid, total);
			}
			
			Currshot[playerid]++;
			if(Currshot[playerid] == NUM_SHOT_CHECK)
			{
				Currshot[playerid] = 0;
				for(new i = 0; i < NUM_SHOT_CHECK; i++) { LastShots[playerid][i] = -1; }
			}
		}
	}

	if (funcidx("AntiEA_OnPlayerWeaponShot") != -1)
  	{
    	return CallLocalFunction("AntiEA_OnPlayerWeaponShot", "iiiifff", playerid, weaponid, hittype, hitid, fX, fY, fZ);
  	}
  	return 1;
 }

#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot AntiEA_OnPlayerWeaponShot

forward AntiEA_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);

hook OnPlayerDisconnect(playerid, reason)
{
	PlayerTargetShots[playerid] = 0;
	PlayerTargetHits[playerid] = 0;
	Currshot[playerid] = 0;
	TotalChecks[playerid] = 0;
	for(new i = 0; i < NUM_SHOT_CHECK; i++) { LastShots[playerid][i] = -1; }

	return 1;
}

stock GetPlayerShotStats(playerid, &shots, &hits, &Float:accuracy)
{
	if(IsPlayerConnected(playerid))
	{
		shots = PlayerTargetShots[playerid];
	    hits = PlayerTargetHits[playerid];
	    accuracy = floatdiv(float(PlayerTargetHits[playerid]), float(PlayerTargetShots[playerid]));
		return 1;
	}
	return 0;
}

stock CheckLastShots(playerid)
{
	new count;
	for(new i = 0; i < NUM_SHOT_CHECK; i++)
	{
	    if(LastShots[playerid][i] == -1) return 0;
	    if(LastShots[playerid][i]) count++;
	}

	if(count >= EXCESS_AMOUNT) return count;
	return 0;
}

public OnPlayerExcessAccuracy(playerid, total)
{
	new shots, hits, Float:accuracy;
    GetPlayerShotStats(playerid, shots, hits, accuracy);

	new line[128];
	format(line, sizeof(line), "Aimbot Check: %s(%i) Total Shots: %i Total Hits: %i Accuracy: %.2f (%i/10) Total Checks: %i", ReturnName(playerid), playerid, shots, hits, accuracy, total, TotalChecks[playerid]);

	if(AccountData[playerid][pAdmin] > 1)
	{
		SendClientMessage(playerid, X11_YELLOW_2, line);
	}
	return 1;
}