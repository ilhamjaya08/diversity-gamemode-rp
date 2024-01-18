CMD:wardrobe(playerid, params[])
{
	new houseid = House_Inside(playerid);

	if(houseid == -1)
		return SendErrorMessage(playerid, "You are not inside any house!");

	if(House_IsOwner(playerid, houseid) || House_IsShared(playerid, houseid))
	{
		ShowHouseWardrobe(playerid, houseid);
	}
	return 1;
}
