#include <YSI\y_hooks>


// Defined list
#define GetPlayerCoin(%0)		donation_coins[%0]


// Variable list
new donation_coins[MAX_PLAYERS] = {0, ...};


// Event list
hook OnPlayerLogin(playerid)
{
	new Cache:execute;

	execute = mysql_query(g_iHandle, sprintf("SELECT `coins` FROM `donation_coin_list` WHERE `pid`='%d';", GetPlayerSQLID(playerid)));

	if(cache_num_rows())
	{
		new coins = cache_get_field_int(0, "coins");
		donation_coins[playerid] = coins;
	}
	else
	{
		donation_coins[playerid] = 0;
		mysql_tquery(g_iHandle, sprintf("INSERT INTO `donation_coin_list` (`pid`, `coins`) VALUES (%d,%d) ON DUPLICATE KEY UPDATE `coins` = 0;", GetPlayerSQLID(playerid), GetPlayerCoin(playerid)));
	}

	cache_delete(execute);
}

hook OnPlayerDisconnect(playerid, reason)
{
	donation_coins[playerid] = 0;
}


GivePlayerCoin(playerid, coin)
{
	donation_coins[playerid] += coin;
	return mysql_tquery(g_iHandle, sprintf("INSERT INTO `donation_coin_list` (`pid`, `coins`) VALUES ('%d','%d') ON DUPLICATE KEY UPDATE `coins`='%d';", GetPlayerSQLID(playerid), GetPlayerCoin(playerid), GetPlayerCoin(playerid)));
}