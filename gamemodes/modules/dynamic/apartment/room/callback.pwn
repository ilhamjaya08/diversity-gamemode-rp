#include <YSI\y_hooks>


hook OnGameModeInitEx()
{
    // TODO: Disable load apartment_room.
    // mysql_tquery(g_iHandle, "SELECT * FROM `apartment_room` ORDER BY `apartmentRoomID` ASC", "ApartmentRoom_Load", "");
}

// Event
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CTRL_BACK && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) //Key H
	{             
        new index;
        if((index = ApartmentRoom_Nearest(playerid)) != -1)
        {
            if(ApartmentRoomData[index][apartmentRoomLock]) GameTextForPlayer(playerid, "~r~Locked", 1500, 1);
            else Apartment_SetPlayerInsideRoom(playerid, index);
        }
        else if((index = ApartmentRoom_Inside(playerid)) != -1)
        {
            if(IsPlayerInRangeOfPoint(playerid, 5.0, ApartmentRoomData[index][apartmentRoomInteriorPosX], ApartmentRoomData[index][apartmentRoomInteriorPosY], ApartmentRoomData[index][apartmentRoomInteriorPosZ]))
            {
                Apartment_SetPlayerOutsideRoom(playerid, index);
            }
        }
    }
}