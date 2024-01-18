Vehicle_ResetGunrack(vehicleid, slot)
{
	if(Iter_Contains(Vehicle, vehicleid))
	{
		GunrackData[vehicleid][weaponModel][slot] = 0;
		GunrackData[vehicleid][weaponAmmo][slot] = 0;
		GunrackData[vehicleid][weaponExists][slot] = 0;
		return 1;
	}
	return 0;
}

Vehicle_ShowRack(playerid, vehicleid)
{
	new output[300], weaponid, weaponammo;

	strcat(output, "Weapon Name\tAmmo\n");
	for(new i = 0; i != MAX_GUNRACK_SLOT; i++)
	{
		if(GunrackData[vehicleid][weaponExists][i])
		{
			weaponid = GunrackData[vehicleid][weaponModel][i];
			weaponammo = GunrackData[vehicleid][weaponAmmo][i];
			strcat(output, sprintf(""RED"%s\t"GREEN"%d\n", ReturnWeaponName(weaponid), weaponammo));
		}
		else
		{
			strcat(output, "Empty\t \t \n");
		}
	}

	Dialog_Show(playerid, VehicleGunRack, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Gunrack", output, "Select", "Close");
	return 1;
}
Dialog:VehicleGunRack(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			slot = listitem,
			nearest_vehicle = GetPVarInt(playerid, "GunrackVehicleNearest"),
			vehicleid = GetPVarInt(playerid, "GunrackVehicleIndex")
		;

		SetPVarInt(playerid, "GunrackVehicleListitem", listitem);
		if(GunrackData[vehicleid][weaponExists][slot])
		{
			if(!IsPlayerDuty(playerid)) 
				return SendErrorMessage(playerid, "Off duty untuk mengambil senjata!.");

			if(Vehicle_Nearest(playerid) != nearest_vehicle)
				return SendErrorMessage(playerid, "Terlalu jauh dari posisi kendaraan yang kamu operasikan, gagal mengambil senjata!");

			GiveFactionWeapon(playerid, GunrackData[vehicleid][weaponModel][slot], GunrackData[vehicleid][weaponAmmo][slot]);

			SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s takes a %s from the gunrack.", ReturnName(playerid, 0, 1), ReturnWeaponName(GunrackData[vehicleid][weaponModel][slot]));

			GunrackData[vehicleid][weaponModel][slot] = GunrackData[vehicleid][weaponAmmo][slot] = GunrackData[vehicleid][weaponExists][slot] = 0;
		}
		else
		{
			Dialog_Show(playerid, VehicleGunrackAdd, DIALOG_STYLE_LIST, "Gunrack", "Store Weapon", "Select", "<<");
		}
	}
	return 1;
}

Dialog:VehicleGunrackAdd(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		static weaponid = 0;
		new 
			ammo,
			nearest_vehicle = GetPVarInt(playerid, "GunrackVehicleNearest"),
			vehicleid = GetPVarInt(playerid, "GunrackVehicleIndex"),
			slot = GetPVarInt(playerid, "GunrackVehicleListitem")
		;

		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
			return SendErrorMessage(playerid, "You need to be onfoot to store your weapon!");
			
		if((weaponid = GetPlayerWeapon(playerid)) == 0) 
			return SendErrorMessage(playerid, "Kamu tidak memegang senjata.");
		
		if(PlayerHasTazer(playerid)) 
			return SendErrorMessage(playerid, "Tazer tidak diperbolehkan disimpan.");

		if(Vehicle_Nearest(playerid) != nearest_vehicle)
			return SendErrorMessage(playerid, "Terlalu jauh dari posisi kendaraan yang kamu operasikan, gagal meletakkan senjata!");

		ammo = GetPlayerAmmo(playerid);

		GunrackData[vehicleid][weaponModel][slot]      	= weaponid;
		GunrackData[vehicleid][weaponAmmo][slot]        = ammo;
		GunrackData[vehicleid][weaponExists][slot] 		= 1;

		ResetFactionWeaponInSlot(playerid, weaponid);
		DeleteFactionWeapon(playerid, weaponid);
		SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s stored a %s into the gunrack.", ReturnName(playerid, 0, 1), ReturnWeaponName(GunrackData[vehicleid][weaponModel][slot]));

	}
	return 1;
}

ResetFactionWeaponInSlot(playerid, weaponid) 
{
	new slot = g_aWeaponSlots[weaponid];
	RemoveWeaponInSlot(playerid, slot);
	return 1;
}