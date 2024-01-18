/*
	Textdraw info made by agus syahputra.
*/

#if defined _inc_infotd
	#undef _inc_infotd
#endif

#if defined _infotd_included
	#endinput
#endif
#define _infotd_included

/*
	Include packages
*/

#include <a_samp>

#include <YSI\y_timers>
#include <YSI\y_hooks>

/*
	Variable
*/
static
	bool:info_textdraw_shown[MAX_PLAYERS],
	Timer:info_textdraw_timer[MAX_PLAYERS],
	PlayerText:info_textdraw[MAX_PLAYERS];

/*
	SAMP Function
*/
hook OnPlayerConnect(playerid) {
	LoadInfoTextdraw(playerid);
	return 1;
}

/*
	Callback
*/

stock LoadInfoTextdraw(playerid)
{
	info_textdraw[playerid] = CreatePlayerTextDraw(playerid, 335.199859, 352.375030, "Initializing...");
	PlayerTextDrawLetterSize(playerid, info_textdraw[playerid], 0.183001, 1.000000);
	PlayerTextDrawAlignment(playerid, info_textdraw[playerid], 2);
	PlayerTextDrawColor(playerid, info_textdraw[playerid], -1);
	PlayerTextDrawSetShadow(playerid, info_textdraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid, info_textdraw[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, info_textdraw[playerid], 255);
	PlayerTextDrawFont(playerid, info_textdraw[playerid], 2);
	PlayerTextDrawSetProportional(playerid, info_textdraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid, info_textdraw[playerid], 0);

	return 1;
}

stock ShowInfoTextdraw(playerid, string[], time = 2000)
{
	if(IsPlayerInfoTextdrawShown(playerid)) {
		return 0;
	}

	PlayerTextDrawSetString(playerid, info_textdraw[playerid], string);
	PlayerTextDrawShow(playerid, info_textdraw[playerid]);

	info_textdraw_shown[playerid] = true;
	info_textdraw_timer[playerid] = defer HideInfoTextdraw[time](playerid);
	return 1;
}

stock bool:IsPlayerInfoTextdrawShown(playerid)
{
	if(!IsPlayerConnected(playerid)) {
		return false;
	}

	return info_textdraw_shown[playerid];
}

/*
	Timer
*/

timer HideInfoTextdraw[1000](playerid)
{
	if(IsPlayerInfoTextdrawShown(playerid))
	{
		PlayerTextDrawHide(playerid, info_textdraw[playerid]);
		info_textdraw_shown[playerid] = false;
	}
	return 1;
}