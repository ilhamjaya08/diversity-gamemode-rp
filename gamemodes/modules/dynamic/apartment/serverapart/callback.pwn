#include <YSI\y_hooks>

// Event
hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, "SELECT * FROM `apartment` ORDER BY `apartmentID` ASC LIMIT "#MAX_DYNAMIC_APARTMENT";", "Apartment_Load", "");
}

// hook OnPlayerEnterDynamicCP(playerid, checkpointid)
// {
// 	new streamer_info[2];
// 	Streamer_GetArrayData(STREAMER_TYPE_CP, checkpointid, E_STREAMER_EXTRA_ID, streamer_info);
// 	if(streamer_info[0] == APARTMENT_CHECKPOINT_INDEX)
// 	{
// 		new index = streamer_info[1];
// 		if(Apartment_IsExists(index))
// 		{
// 			Apartment_SetInside(playerid, index);
// 		}
// 	}
// }


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CTRL_BACK) //Key H
	{
		new index;
		if((index = Apartment_Nearest(playerid)) != INVALID_APARTMENT_ID && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			if(IsPlayerInDynamicCP(playerid, ApartmentData[index][apartmentExteriorCheckpoint])) Apartment_ShowRoom(playerid, index);
		}
		else if((index = Apartment_Inside(playerid)) != INVALID_APARTMENT_ID && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			Apartment_SetPlayerOutside(playerid, index);
		}
	}
}