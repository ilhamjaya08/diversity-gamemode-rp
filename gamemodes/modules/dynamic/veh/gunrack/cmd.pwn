CMD:gunrack(playerid, params[])
{
	new vehicleid, vehicle_index;
	if(!IsPlayerDuty(playerid))
		return SendErrorMessage(playerid, "On-Duty first before using gun rack");

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "You must be a police officer.");

	if((vehicleid = Vehicle_Nearest(playerid)) != -1)
	{
		vehicle_index = Vehicle_ReturnID(vehicleid);
		if(vehicle_index == -1) return 0;

		if(Vehicle_GetExtraID(vehicle_index) != GetPlayerFactionID(playerid))
			return SendErrorMessage(playerid, "This is not your faction vehicle!");

		if(!IsFourWheelVehicle(vehicleid))
			return SendErrorMessage(playerid, "This vehicle have no gun rack!");

		SetPVarInt(playerid, "GunrackVehicleNearest", vehicleid);
		SetPVarInt(playerid, "GunrackVehicleIndex", vehicle_index);
		Vehicle_ShowRack(playerid, vehicle_index);
		cmd_ame(playerid, "reaches out gun rack panel and opens it");
	}
	return 1;
}

CMD:takeweapon(playerid, params[])
{
	new vehicleid, vehicle_index, slot;

	if(!IsPlayerDuty(playerid))
		return SendErrorMessage(playerid, "On-Duty first before using gun rack");

	if(GetFactionType(playerid) != FACTION_POLICE)
		return SendErrorMessage(playerid, "You must be a police officer.");

	if(sscanf(params, "d", slot))
        return SendSyntaxMessage(playerid, "/takeweapon [1-5]");

	if((vehicleid = Vehicle_Nearest(playerid)) != -1)
	{
		vehicle_index = Vehicle_ReturnID(vehicleid);
		if(vehicle_index == -1) return 0;

		if(Vehicle_GetExtraID(vehicle_index) != GetPlayerFactionID(playerid))
			return SendErrorMessage(playerid, "This is not your faction vehicle!");

		if(!IsFourWheelVehicle(vehicleid))
			return SendErrorMessage(playerid, "This vehicle have no gun rack!");

		if(slot < 1 || slot > 5)
			return SendSyntaxMessage(playerid, "/takeweapon [1-5]");

		if(GunrackData[vehicle_index][weaponExists][slot - 1])
		{
			GiveFactionWeapon(playerid, GunrackData[vehicle_index][weaponModel][slot - 1], GunrackData[vehicle_index][weaponAmmo][slot - 1]);
			SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s takes a %s from the gunrack.", ReturnName(playerid, 0, 1), ReturnWeaponName(GunrackData[vehicle_index][weaponModel][slot - 1]));
			GunrackData[vehicle_index][weaponModel][slot - 1] = GunrackData[vehicle_index][weaponAmmo][slot - 1] = GunrackData[vehicle_index][weaponExists][slot - 1] = 0;
		}
		else
		{
			SendErrorMessage(playerid, "This gunrack slot is empty!");
		}
	}
	return 1;
}
