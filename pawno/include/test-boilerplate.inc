// built-in include guard removal
// just in case the user has a local dependency with the same file name
#if defined _inc_test_boilerplate
	#undef _inc_test_boilerplate
#endif
// custom include-guard to ensure we don't duplicate
#if defined _test_boilerplate_included
	#endinput
#endif
#define _test_boilerplate_included

#include <a_samp>
#include <YSI_Coding\y_hooks>

#define _TB_DEFAULT_POS_X (300.0)
#define _TB_DEFAULT_POS_Y (1800.0)
#define _TB_DEFAULT_POS_Z (18.0)

hook OnGameModeInit() 
{
	AddPlayerClass(101, _TB_DEFAULT_POS_X, _TB_DEFAULT_POS_Y, _TB_DEFAULT_POS_Z, 0.0, 0, 0, 0, 0, 0, 0);
}

hook OnPlayerRequestClass(playerid, classid) 
{
	SetSpawnInfo(playerid, NO_TEAM, 101, _TB_DEFAULT_POS_X, _TB_DEFAULT_POS_Y, _TB_DEFAULT_POS_Z, 0.0, 0, 0, 0, 0, 0, 0);
	TogglePlayerSpectating(playerid, true);
	TogglePlayerSpectating(playerid, false);
}

hook OnPlayerSpawn(playerid) 
{
	SendClientMessage(playerid, -1, "Running with ScavengeSurvive/test-boilerplate...");
	TogglePlayerControllable(playerid, true);
	SetPlayerPos(playerid, _TB_DEFAULT_POS_X, _TB_DEFAULT_POS_Y, _TB_DEFAULT_POS_Z);
	SetCameraBehindPlayer(playerid);
}
