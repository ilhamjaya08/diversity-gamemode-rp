/*
	Custom loading bar.
	Dibuat oleh agus syahputra at 24/12/2017 - 10:56.

	Credits:
	- tianmetal untuk ide tampilan loading barnya.

Callback:

stock StartPlayerLoadingBar(playerid, callback[], subject[], time, color = -1429936641)
stock StopPlayerLoadingBar(playerid)
stock CreateLoadingTextdraw(playerid, subject[])

Respond function:

forward your_function(playerid);
public your_function(playerid) 
{
	//add here
	return 1;
}

*/


#if defined _inc_loadingbar
	#undef _inc_loadingbar
#endif

#if defined _loadingbar_included
	#endinput
#endif
#define _loadingbar_included

/* Include library. */
#include <a_samp>
#include <progress2>	//http://github.com/Southclaw/progress2/

/* Variable. */
new
	PlayerText:loadingBar_Textdraw[MAX_PLAYERS],
	PlayerBar:loadingBar_PorgressBar[MAX_PLAYERS],
	
	loadingBar_Value[MAX_PLAYERS] = {0, ...},
	bool:loadingBar_Shown[MAX_PLAYERS] = {false, ...},
	loadingBar_Callback[MAX_PLAYERS][32],
	loadingBar_Timer[MAX_PLAYERS];

/* Forward function */
forward ProgressBarTimer(playerid);

/* Callback */
stock StartPlayerLoadingBar(playerid, callback[], subject[], time, color = -1429936641)
{
	if(!IsPlayerConnected(playerid)) {
		return 0;
	}

	StopPlayerLoadingBar(playerid);

	format(loadingBar_Callback[playerid], 32, "%s", callback);
	loadingBar_Value[playerid] = time;
	loadingBar_Shown[playerid] = true;

	CreateLoadingTextdraw(playerid, subject);

	loadingBar_PorgressBar[playerid] = CreatePlayerProgressBar(playerid, 234.000000, 429.000000, 179.500000, 12.699999, color, time, 0);
	SetPlayerProgressBarValue(playerid, loadingBar_PorgressBar[playerid], time);
	ShowPlayerProgressBar(playerid, loadingBar_PorgressBar[playerid]);

	loadingBar_Timer[playerid] = SetTimerEx("ProgressBarTimer", 1000, true, "d", playerid);
	return 1;
}


stock StopPlayerLoadingBar(playerid)
{
	if(!IsPlayerConnected(playerid)) {
		return 0;
	}
	
	KillTimer(loadingBar_Timer[playerid]);

	loadingBar_Value[playerid] = 0;
	loadingBar_Shown[playerid] = false;

	PlayerTextDrawDestroy(playerid, loadingBar_Textdraw[playerid]);
	DestroyPlayerProgressBar(playerid, loadingBar_PorgressBar[playerid]);
	return 1;
}

stock CreateLoadingTextdraw(playerid, subject[])
{
	loadingBar_Textdraw[playerid] = PlayerText:INVALID_TEXT_DRAW;

	loadingBar_Textdraw[playerid] = CreatePlayerTextDraw(playerid, 323.200225, 415.474609, subject);
	PlayerTextDrawLetterSize(playerid, loadingBar_Textdraw[playerid], 0.342500, 1.196875);
	PlayerTextDrawAlignment(playerid, loadingBar_Textdraw[playerid], 2);
	PlayerTextDrawColor(playerid, loadingBar_Textdraw[playerid], -1);
	PlayerTextDrawSetShadow(playerid, loadingBar_Textdraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid, loadingBar_Textdraw[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, loadingBar_Textdraw[playerid], 255);
	PlayerTextDrawFont(playerid, loadingBar_Textdraw[playerid], 3);
	PlayerTextDrawSetProportional(playerid, loadingBar_Textdraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid, loadingBar_Textdraw[playerid], 0);

	PlayerTextDrawShow(playerid, loadingBar_Textdraw[playerid]);
	return 1;
}

/* Timer function */
public ProgressBarTimer(playerid) 
{
	if(loadingBar_Shown[playerid]) 
	{
		if(--loadingBar_Value[playerid] == 0) 
		{
			CallLocalFunction(loadingBar_Callback[playerid], "d", playerid);
			StopPlayerLoadingBar(playerid);
			return 1;
		}
		SetPlayerProgressBarValue(playerid, loadingBar_PorgressBar[playerid], loadingBar_Value[playerid]);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	StopPlayerLoadingBar(playerid);

	#if defined loadbar_OnPlayerDisconnect
		return loadbar_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect loadbar_OnPlayerDisconnect
#if defined loadbar_OnPlayerDisconnect
	forward loadbar_OnPlayerDisconnect(playerid, reason);
#endif

#if defined FILTERSCRIPT
	public OnFilterScriptExit()
	{
		for(new i = 0, j = GetPlayerPoolSize(); i != j; i++) if(IsPlayerConnected(i)) {
			StopPlayerLoadingBar(i);
		}
		#if defined loadbar_OnFilterScriptExit
			return loadbar_OnFilterScriptExit();
		#else
			return 1;
		#endif
	}
	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif
	
	#define OnFilterScriptExit loadbar_OnFilterScriptExit
	#if defined loadbar_OnFilterScriptExit
		forward loadbar_OnFilterScriptExit();
	#endif
#else
	public OnGameModeExit()
	{
		for(new i = 0, j = GetPlayerPoolSize(); i != j; i++) if(IsPlayerConnected(i)) {
			StopPlayerLoadingBar(i);
		}
		#if defined loadbar_OnGameModeExit
			return loadbar_OnGameModeExit();
		#else
			return 1;
		#endif
	}
	#if defined _ALS_OnGameModeExit
		#undef OnGameModeExit
	#else
		#define _ALS_OnGameModeExit
	#endif
	
	#define OnGameModeExit loadbar_OnGameModeExit
	#if defined loadbar_OnGameModeExit
		forward loadbar_OnGameModeExit();
	#endif
#endif