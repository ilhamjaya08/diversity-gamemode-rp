/*	Weapon faction system	*/

#include <YSI\y_hooks>

// Local function
hook OnPlayerDisconnect(playerid, reason) {
	if(IsPlayerDuty(playerid)) {
		SaveFactionWeapon(playerid);
	}
}

hook OnPlayerDeath(playerid) {
	if(SQL_IsLogged(playerid) && IsPlayerDuty(playerid)) {
		SaveFactionWeapon(playerid);
	}
}

// Callback
SQL_FactionWeapon(playerid)
{
	if(IsPlayerDuty(playerid)) {
		mysql_tquery(g_iHandle, sprintf("SELECT * FROM `weapon_factions` WHERE `userid` = '%d'", GetPlayerSQLID(playerid)), "OnLoadPlayerFacWeapons", "d", playerid);
	}
	return 1;
}

GiveFactionWeapon(playerid, weaponid, ammo) {
	if(IsPlayerDuty(playerid)) {
		if(!(0 <= weaponid <= 46)) {
			return printf("[debug] Invalid weapon id (%d).", weaponid);
		}

		GivePlayerWeapon(playerid, weaponid, ammo);
		mysql_tquery(g_iHandle, sprintf("DELETE FROM weapon_factions WHERE slot = %d", g_aWeaponSlots[weaponid]));

		new
			query[164]
		;
		mysql_format(g_iHandle, query, sizeof(query), "INSERT INTO weapon_factions VALUES ('%d', '%d', '%d', '%d', '%d') ON DUPLICATE KEY UPDATE ammo = %d, created = %d", GetPlayerSQLID(playerid), weaponid, ammo, gettime(), g_aWeaponSlots[weaponid], ammo, gettime());
		return mysql_tquery(g_iHandle, query);
	}
	return 1;
}

SaveFactionWeapon(playerid) {
	static
		weaponid,
		ammo
	;
	for(new i = 1; i < MAX_WEAPON_SLOT; i++) {
		GetPlayerWeaponData(playerid, i, weaponid, ammo);

		if(!weaponid) continue;
		
		new 
			query[164]
		;
		mysql_format(g_iHandle, query, sizeof(query), "INSERT INTO weapon_factions VALUES ('%d', '%d', '%d', '%d', '%d') ON DUPLICATE KEY UPDATE ammo = %d, created = %d", GetPlayerSQLID(playerid), weaponid, ammo, gettime(), g_aWeaponSlots[weaponid], ammo, gettime());
		mysql_tquery(g_iHandle, query);
	}
	return 1;
}

ResetFactionWeapon(playerid) {
	if(IsPlayerDuty(playerid)) {
		ResetPlayerWeapons(playerid);
		return mysql_tquery(g_iHandle, sprintf("DELETE FROM weapon_factions WHERE userid = %d", GetPlayerSQLID(playerid)));
	}
	return 0;
}

// Funtion
Function:OnLoadPlayerFacWeapons(playerid) {
	static
	    weaponid,
	    ammo;
	
	for(new i = 0; i < cache_num_rows(); i++)
	{
	    weaponid 	= cache_get_field_int(i, "weaponid");
	    ammo    	= cache_get_field_int(i, "ammo");
		
		if(!(0 <= weaponid <= 46))
		{
			printf("[info] Warning: OnLoadPlayerFacWeapons - Unknown weaponid '%d'. Skipping.", weaponid);
			continue;
		}
		GivePlayerWeapon(playerid, weaponid, ammo);
	}
	SetPlayerArmedWeapon(playerid, 0);
	return 1;
}