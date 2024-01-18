#include <YSI\y_hooks>

// Function
stock Caller_IsExists(index)
{
	if(Iter_Contains(CallerCP, index))
		return 1;
	
	return 0;
}

callerCP_Create(callerid)
{
	callerCP_Delete(callerid);
	Iter_Add(CallerCP, callerid);

	callerData[callerid][callerExists] = true;
	callerData[callerid][accepted] = false;
	callerData[callerid][callerPhoneNumber] = PlayerData[callerid][pPhone];
	GetPlayerName(callerid, callerData[callerid][callerName], MAX_PLAYER_NAME + 1);
	GetPlayerPos(callerid, callerData[callerid][callerPos][0], callerData[callerid][callerPos][1], callerData[callerid][callerPos][2]);
	format(callerData[callerid][callerPosName], 32, "%s", GetLocation(callerData[callerid][callerPos][0], callerData[callerid][callerPos][1], callerData[callerid][callerPos][2]));

	return callerid;
}

callerCP_Delete(playerid)
{
	Iter_Remove(CallerCP, playerid);

	callerData[playerid][callerID] = INVALID_CALLER_CP;
	callerData[playerid][callerExists] = false;
	format(callerData[playerid][callerName], MAX_PLAYER_NAME, "");
	format(callerData[playerid][callerPosName], 32, "");
	return 1;
}