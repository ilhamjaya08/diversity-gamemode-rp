#include <YSI\y_hooks>

// Local function
hook OnPlayerDisconnectEx(playerid, reason)
{
	if(IsPlayerDuty(playerid))
		SaveFactionWeapon(playerid);
}

hook OnPlayerDeath(playerid) 
{
	if(SQL_IsLogged(playerid) && IsPlayerDuty(playerid))
		SaveFactionWeapon(playerid);
}


// Callback
GiveFactionWeapon(playerid, weaponid, ammo) 
{
	if(!IsPlayerDuty(playerid))
		return 0;

	if(!(0 <= weaponid <= 46))
		return 0;

	GivePlayerWeapon(playerid, weaponid, ammo);
	mysql_tquery(g_iHandle, sprintf("INSERT INTO `weapon_factions` VALUES ('%d', '%d', '%d', '%d') ON DUPLICATE KEY UPDATE ammo = %d, weaponid = %d", GetPlayerSQLID(playerid), g_aWeaponSlots[weaponid], weaponid, ammo,  ammo, weaponid));
	return 1;
}

SaveFactionWeapon(playerid)
{
	if(!IsPlayerDuty(playerid))
		return 0;

	new weaponid, ammo;

	for(new i = 1; i < MAX_WEAPON_SLOT; i++) {
		GetPlayerWeaponData(playerid, i, weaponid, ammo);

		if(!weaponid) 
			continue;

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `weapon_factions` VALUES ('%d', '%d', '%d', '%d') ON DUPLICATE KEY UPDATE ammo = %d", GetPlayerSQLID(playerid), g_aWeaponSlots[weaponid], weaponid, ammo, ammo));
	}
	return 1;
}

DeleteFactionWeapon(playerid, weaponid) 
{
	if(!IsPlayerDuty(playerid))
		return 0;

	mysql_tquery(g_iHandle, sprintf("DELETE FROM weapon_factions WHERE userid = %d AND weaponid = %d", GetPlayerSQLID(playerid), weaponid));
	return 1;
}
ResetFactionWeapon(playerid) 
{
	if(!IsPlayerDuty(playerid))
		return 0;

	ResetPlayerWeapons(playerid);
	mysql_tquery(g_iHandle, sprintf("DELETE FROM weapon_factions WHERE userid = %d", GetPlayerSQLID(playerid)));
	return 1;
}

RefreshFactionWeapon(playerid)
{
	if(!IsPlayerDuty(playerid))
		return 0;

	ResetPlayerWeapons(playerid);

	mysql_tquery(g_iHandle, sprintf("SELECT * FROM `weapon_factions` WHERE `userid` = '%d';", GetPlayerSQLID(playerid)), "OnLoadPlayerFacWeapons", "d", playerid);
	return 1;
}

/*IsFactionWeaponInSlot(playerid, weaponid) {
	for(new i = 1; i < MAX_WEAPON_SLOT; i++) {
		GetPlayerWeaponData(playerid, i, weaponid, ammo);

		if(i == g_aWeaponSlots[weaponid])
			return 1;
	}
	return 0;
}*/

// Funtion
Function:OnLoadPlayerFacWeapons(playerid)
{
	new weaponid, ammo;

	ResetPlayerWeapons(playerid);
	for(new i = 0; i < cache_num_rows(); i++)
	{
	    weaponid 	= cache_get_field_int(i, "weaponid");
	    ammo    	= cache_get_field_int(i, "ammo");
		if(!(0 <= weaponid <= 46))
			continue;

		GivePlayerWeapon(playerid, weaponid, ammo);
	}
	SetPlayerArmedWeapon(playerid, 0);
	return 1;
}