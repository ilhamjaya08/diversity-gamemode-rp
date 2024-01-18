/*	Anti spam detection	*/

#include <YSI\y_hooks>
#include <YSI\y_timers>

#define MAX_FLOODS	5

static
	chat_flood[MAX_PLAYERS] = {0, ...},
	bool:flood_detect[MAX_PLAYERS] = {false, ...};


hook OnPlayerText(playerid, text[])
{
	if(chat_flood[playerid] < MAX_FLOODS)
	{
		chat_flood[playerid]++;
		if(chat_flood[playerid] == MAX_FLOODS)
		{
			defer EnableChat(playerid);
			flood_detect[playerid] = true;
		}
		return 1;
	}
	return 0;
}

IsPlayerFlooding(playerid) {
	return flood_detect[playerid];
}

ptask FloodTimer[2500](playerid)
{
	if(SQL_IsLogged(playerid) && flood_detect[playerid] == false)
	{
		chat_flood[playerid] = 0;
	}
}

timer EnableChat[5000](playerid)
{
	chat_flood[playerid] = 0;
	flood_detect[playerid] = false;
}
