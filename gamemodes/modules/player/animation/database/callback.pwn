#include <YSI\y_hooks>

hook OnPlayerLogin(playerid)
{
	mysql_tquery(g_iHandle, sprintf("SELECT * FROM `player_animation` WHERE `playerid` = '%d' ORDER BY `slot` ASC LIMIT %d", PlayerData[playerid][pID], MAX_PLAYER_ANIMATION), "LoadPlayerAnimation", "d", playerid);
}

hook OnPlayerConnect(playerid)
{
	for(new i = 0; i != MAX_PLAYER_ANIMATION; i++)
	{
		AnimData[playerid][i][AnimExists] = false;
	}
}