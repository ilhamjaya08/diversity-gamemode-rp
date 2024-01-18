#include <a_samp>
#include <streamer>
#include <zcmd>

#undef MAX_PLAYERS
#define MAX_SLOTS           50

#define MAX_SNOW_OBJECTS    8
#define UPDATE_INTERVAL     750

#if MAX_SLOTS == -1
	#error Change MAX_SLOTS to the max players of your server! (At line 6)
#endif

#define ploop(%0)			for(new %0 = 0; %0 < MAX_SLOTS; %0++) if(IsPlayerConnected(%0))
#define CB:%0(%1)           forward %0(%1); public %0(%1)

new bool:snowOn[MAX_SLOTS char],
	snowObject[MAX_SLOTS][MAX_SNOW_OBJECTS],
	updateTimer[MAX_SLOTS char]
;

public OnFilterScriptExit()
{
	ploop(i)
	{
	    if(snowOn{i})
	    {
	        for(new j = 0; j < MAX_SNOW_OBJECTS; j++) DestroyDynamicObject(snowObject[i][j]);
			KillTimer(updateTimer{i});
		}
	}
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	if(snowOn{playerid})
	{
	    for(new i = 0; i < MAX_SNOW_OBJECTS; i++) DestroyDynamicObject(snowObject[playerid][i]);
		snowOn{playerid} = false;
		KillTimer(updateTimer{playerid});
	}
	return 1;
}

CB:UpdateSnow(playerid)
{
	if(!snowOn{playerid}) return 0;
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++) SetDynamicObjectPos(snowObject[playerid][i], pPos[0] + random(25), pPos[1] + random(25), pPos[2] - 5 + random(10));
	return 1;
}

stock CreateSnow(playerid)
{
	if(snowOn{playerid}) return 0;
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++) snowObject[playerid][i] = CreateDynamicObject(18864, pPos[0] + random(25), pPos[1] + random (25), pPos[2] - 5 + random(10), random(280), random(280), 0, -1, -1, playerid);
	snowOn{playerid} = true;
	updateTimer{playerid} = SetTimerEx("UpdateSnow", UPDATE_INTERVAL, true, "i", playerid);
	return 1;
}

stock DeleteSnow(playerid)
{
	if(!snowOn{playerid}) return 0;
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++) DestroyDynamicObject(snowObject[playerid][i]);
	KillTimer(updateTimer{playerid});
	snowOn{playerid} = false;
	return 1;
}

CMD:snow(playerid, params[])
{
	if(snowOn{playerid})
	{
	    DeleteSnow(playerid);
	    SendClientMessage(playerid, 0x00FF00AA, "* It's not snowing anymore now.");
	}
	else
	{
	    CreateSnow(playerid);
	    SendClientMessage(playerid, 0x00FF00AA, "* Let it snow, let it snow, let it snow!");
	}
	return 1;
}

CMD:allsnowon(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return 0;
    ploop(i) //This is included in my FS! It's the '#define ploop(%0)' thing.
    {
        if(snowOn{i}) continue;
        CreateSnow(i);
    }
    return 1;
}

CMD:allsnowoff(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return 0;
    ploop(i)
    {
        if(!snowOn{i}) continue;
        DeleteSnow(i);
    }
    return 1;
}
