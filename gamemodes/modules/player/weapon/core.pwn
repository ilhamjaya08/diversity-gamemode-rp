#include 	<YSI\y_hooks>


#define 	MULTIPLE_MATERIAL	10
#define 	MAX_WEAPON_SLOT		13
#define 	DEFAULT_AMMO		20
#define 	WEAPON_DURABILITY	500

#define 	PLAYER_NORMAL 		1
#define 	PLAYER_OFFICIAL		2

#define		WEAPON_ILEGAL		1
#define		WEAPON_LEGAL		2


enum e_WeaponItems {
	wep_model,
	wep_material,
	wep_auth
};

new const g_aWeaponItems[][e_WeaponItems] = {
	{WEAPON_KNIFE, 150, PLAYER_NORMAL},
	{WEAPON_BAT, 150, PLAYER_NORMAL},
	{WEAPON_KATANA, 250, PLAYER_NORMAL},
	{WEAPON_BRASSKNUCKLE, 250, PLAYER_NORMAL},
	{WEAPON_COLT45, 500, PLAYER_NORMAL},
	{WEAPON_SILENCED, 700, PLAYER_NORMAL},
	{WEAPON_SHOTGUN, 1200, PLAYER_NORMAL},
	{WEAPON_DEAGLE, 800, PLAYER_OFFICIAL},
	{WEAPON_RIFLE, 2700, PLAYER_OFFICIAL},
	{WEAPON_AK47, 3100, PLAYER_OFFICIAL},
	{WEAPON_TEC9, 1500, PLAYER_OFFICIAL}
};

new const MaxGunAmmo[54] = {
	0,-1,-1,-1,-1,-1,-1,-1,-1,-1,
	-1,-1,-1,-1,-1,-1,10,10,10,0,
	0,0,850,350,350,100,200,350,2000,2000,
	2000,750,2000,100,50,5,5,10,9999,10,
	-1,500,500,10,-1,-1,-1,0,0,0,
	0,0,0,0
};


enum E_WEAPON_DATA {
	weapon_id,
	weapon_slot,
	weapon_durability,
	weapon_ammo,
	weapon_serial[64]
};


new 
	PlayerGuns[MAX_PLAYERS][MAX_WEAPON_SLOT][E_WEAPON_DATA];

forward OnLoadPlayerWeapons(playerid);
public OnLoadPlayerWeapons(playerid) 
{
	new weaponid;
	
	for(new i = 0; i < cache_num_rows(); i++)
	{
		weaponid = cache_get_field_int(i, "weaponid");
		new slot = g_aWeaponSlots[weaponid];

		if(!(0 < weaponid < 46))
			continue;

	    PlayerGuns[playerid][slot][weapon_id] 			= weaponid;
		PlayerGuns[playerid][slot][weapon_slot] 		= slot;
		PlayerGuns[playerid][slot][weapon_ammo] 		= cache_get_field_int(i, "ammo");
		PlayerGuns[playerid][slot][weapon_durability] 	= cache_get_field_int(i, "durability");
		cache_get_field_content(i, "serial", PlayerGuns[playerid][slot][weapon_serial], 64);
		
	}

	if(!IsPlayerDuty(playerid))
	 	RefreshWeapon(playerid); 

	SetPlayerArmedWeapon(playerid, 0);
	return 1; 
}

hook OnPlayerLogin(playerid)
{
	if(IsPlayerDuty(playerid)) RefreshFactionWeapon(playerid);
    else mysql_tquery(g_iHandle, sprintf("SELECT * FROM `weapon_players` WHERE `userid` = '%d';", GetPlayerSQLID(playerid)), "OnLoadPlayerWeapons", "d", playerid);
}

hook OnPlayerDisconnectEx(playerid, reason) 
{
	if(SQL_IsCharacterLogged(playerid))
	{
		SavePlayerWeapon(playerid);

		for (new i = 0; i < MAX_WEAPON_SLOT; i ++) if(PlayerGuns[playerid][i][weapon_id]) {
	        PlayerGuns[playerid][i][weapon_id] = 0;
	        PlayerGuns[playerid][i][weapon_ammo] = 0;
	        PlayerGuns[playerid][i][weapon_slot] = 0;
	        PlayerGuns[playerid][i][weapon_durability] = 0;
	    }
	    ResetPlayerWeapons(playerid);
	}
}
 
hook OnPlayerShootDynObj(playerid, weaponid, objectid, Float:x, Float:y, Float:z)
{
	if(!IsPlayerDuty(playerid) && GetWeapon(playerid) == weaponid)
	{
		new slot = g_aWeaponSlots[weaponid];

		if(--PlayerGuns[playerid][slot][weapon_ammo] <= 0) {
			SetPlayerArmedWeapon(playerid, 0);
			PlayerGuns[playerid][slot][weapon_ammo] = 0;
			SendCustomMessage(playerid, "WEAPON", "Kamu kehabisan amunisi, isi kembali dengan perintah "YELLOW"/createammo.");
		}

		if(--PlayerGuns[playerid][slot][weapon_durability] <= 0) {
			SendCustomMessage(playerid, "WEAPON", "Senjata "RED"%s "WHITE"rusak, otomatis senjata kamu tidak dapat di gunakan kembali.", ReturnWeaponName(weaponid));

			if(PlayerGuns[playerid][slot][weapon_ammo])
			{
				if(Inventory_Add(playerid, "Materials", 11746, floatround((PlayerGuns[playerid][slot][weapon_ammo]/2))) != -1) {
					SendCustomMessage(playerid, "WEAPON", "Amunisi masih tersisa, otomatis digantikan dengan "YELLOW"%d material(s).", floatround((PlayerGuns[playerid][slot][weapon_ammo]/2)));
				}
			}
			ResetWeaponID(playerid, weaponid);
		}
	}
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(!IsPlayerInEvent(playerid))
	{
		if(!IsPlayerDuty(playerid) && GetWeapon(playerid) == weaponid)
		{
			new slot = g_aWeaponSlots[weaponid];

			if(--PlayerGuns[playerid][slot][weapon_ammo] <= 0) {
				SetPlayerArmedWeapon(playerid, 0);
				PlayerGuns[playerid][slot][weapon_ammo] = 0;
				SendCustomMessage(playerid, "WEAPON", "Kamu kehabisan amunisi, isi kembali dengan perintah "YELLOW"/createammo.");
			}

			if(--PlayerGuns[playerid][slot][weapon_durability] <= 0) {
				SendCustomMessage(playerid, "WEAPON", "Senjata "RED"%s "WHITE"rusak, otomatis senjata kamu tidak dapat di gunakan kembali.", ReturnWeaponName(weaponid));

				if(PlayerGuns[playerid][slot][weapon_ammo])
				{
					if(Inventory_Add(playerid, "Materials", 11746, floatround((PlayerGuns[playerid][slot][weapon_ammo]/2))) != -1) {
						SendCustomMessage(playerid, "WEAPON", "Amunisi masih tersisa, otomatis digantikan dengan "YELLOW"%d material(s).", floatround((PlayerGuns[playerid][slot][weapon_ammo]/2)));
					}
				}
				ResetWeaponID(playerid, weaponid);
			}
		}
	}
	return 1;
}

ptask Player_AmmoUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	if(SQL_IsCharacterLogged(playerid) && !IsPlayerInEvent(playerid))
	{
		static
			weaponid;

		if((weaponid = GetWeapon(playerid)) != 0) 
			PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_ammo], sprintf("%s", (PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]) ? (sprintf("%d", PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo])) : ("No Ammo")));
		else 
			PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_ammo], "_");
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSED(KEY_FIRE) || PRESSED(KEY_HANDBRAKE))
	{
		new weaponid;

		if((weaponid = GetWeapon(playerid)) != 0 && !PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]) 
		{
			TogglePlayerControllable(playerid, 0);
			SetPlayerArmedWeapon(playerid, 0);
			TogglePlayerControllable(playerid, 1);
			SetCameraBehindPlayer(playerid);

			ShowPlayerFooter(playerid, "~y~~h~WARNING: ~w~Tidak ada amunisi di senjata ini.", 1500, 1);
		}
	}
}


RemoveWeaponInSlot(playerid, slotid) 
{
    new
        arrWeapons[2][13];
        
    for (new i = 0; i < 13; i ++) {
        GetPlayerWeaponData(playerid, i, arrWeapons[0][i], arrWeapons[1][i]);
    }
    ResetPlayerWeapons(playerid);
    
    for (new i = 0; i < 13; i ++) if (i != slotid) {
        GivePlayerWeapon(playerid, arrWeapons[0][i], arrWeapons[1][i]);
    }
    return 1;
}

PlayerHasWeaponInSlot(playerid, weaponid) 
{
	if(weaponid == 0){
		return 0;
	}
	
    if(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_slot] == g_aWeaponSlots[weaponid]) {
        return 1;
    }
    return 0;
}

GivePlayerWeaponEx(playerid, weaponid, ammo = DEFAULT_AMMO, durability = WEAPON_DURABILITY, serial[] = "0") 
{
	if(!(0 < weaponid < 46))
		return 0;

	if(PlayerHasWeapon(playerid, weaponid))
		return 1;

	new query[255],
		slot = g_aWeaponSlots[weaponid];

	if(slot == 1 || slot == 10)
		ammo = durability = 1;

	PlayerGuns[playerid][slot][weapon_id] 			= weaponid;
	PlayerGuns[playerid][slot][weapon_ammo] 		= ammo;
	PlayerGuns[playerid][slot][weapon_slot] 		= slot;
	PlayerGuns[playerid][slot][weapon_durability] 	= durability;
	format(PlayerGuns[playerid][slot][weapon_serial], 64, "%s", serial);

	GivePlayerWeapon(playerid, weaponid, 999999);

	mysql_format(g_iHandle, query, sizeof(query), "INSERT INTO weapon_players VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%s') ON DUPLICATE KEY UPDATE ammo = %d, durability = %d, created = %d", GetPlayerSQLID(playerid), slot, weaponid, ammo, durability, gettime(), SQL_ReturnEscaped(serial), ammo, durability, gettime());
	mysql_tquery(g_iHandle, query);
	return 1;
}

SavePlayerWeapon(playerid) 
{
	for(new i = 1; i < MAX_WEAPON_SLOT; i++)
	{
		if(!PlayerGuns[playerid][i][weapon_id]) 
			continue;
		
		new query[255];
		mysql_format(g_iHandle, query, sizeof(query), "INSERT INTO weapon_players VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%s') ON DUPLICATE KEY UPDATE ammo = %d, durability = %d", GetPlayerSQLID(playerid), i, PlayerGuns[playerid][i][weapon_id], PlayerGuns[playerid][i][weapon_ammo], PlayerGuns[playerid][i][weapon_durability], gettime(), SQL_ReturnEscaped(PlayerGuns[playerid][i][weapon_serial]), PlayerGuns[playerid][i][weapon_ammo], PlayerGuns[playerid][i][weapon_durability]);
		mysql_tquery(g_iHandle, query);
	}
	return 1;
}

ResetWeaponID(playerid, weaponid) 
{
	new slot = g_aWeaponSlots[weaponid];

    PlayerGuns[playerid][slot][weapon_id] = PlayerGuns[playerid][slot][weapon_ammo] = 0;
	PlayerGuns[playerid][slot][weapon_slot] = PlayerGuns[playerid][slot][weapon_durability] = 0;
	mysql_tquery(g_iHandle, sprintf("DELETE FROM `weapon_players` WHERE `slot` = '%d' AND `userid` = '%d';", slot, GetPlayerSQLID(playerid)));

	RemoveWeaponInSlot(playerid, slot);
	return 1;
}

ResetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

    for (new i = 0; i < MAX_WEAPON_SLOT; i ++) if(PlayerGuns[playerid][i][weapon_id]) {
        PlayerGuns[playerid][i][weapon_id] = PlayerGuns[playerid][i][weapon_ammo] = 0;
		PlayerGuns[playerid][i][weapon_slot] = PlayerGuns[playerid][i][weapon_durability] = 0;

    }
	mysql_tquery(g_iHandle, sprintf("DELETE FROM `weapon_players` WHERE `userid` = '%d';", GetPlayerSQLID(playerid)));
	return 1;
}

GetWeapon(playerid) 
{
    new weaponid = GetPlayerWeapon(playerid);

    if(1 < weaponid < 46 && PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_id] == weaponid)
        return weaponid;

    return 0;
}

ReturnWeaponCount(playerid) 
{
	new count;

	for (new i = 0; i < MAX_WEAPON_SLOT; i ++) if(PlayerGuns[playerid][i][weapon_id]) {
		count++;
    }
    return count;
}

PlayerHasWeapon(playerid, weaponid) 
{
    for (new i = 0; i < MAX_WEAPON_SLOT; i ++) if(PlayerGuns[playerid][i][weapon_id] == weaponid) {
        return 1;
    }
    return 0;
}
ReturnWeaponSerial(playerid, weaponid)
{
	new slot = g_aWeaponSlots[weaponid];

	if(PlayerGuns[playerid][slot][weapon_id] != 0)
		return strval(PlayerGuns[playerid][slot][weapon_serial]);

	return 0;
}

ReturnWeaponAmmo(playerid, weaponid)
{
	new slot = g_aWeaponSlots[weaponid];

	if(PlayerGuns[playerid][slot][weapon_id] != 0)
		return PlayerGuns[playerid][slot][weapon_ammo];

	return 0;
}

ReturnWeaponDurability(playerid, weaponid)
{
	new slot = g_aWeaponSlots[weaponid];
	
	if(PlayerGuns[playerid][slot][weapon_id] != 0)
		return PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_durability];

	return 0;
}

ReturnWeaponMaterial(weaponid)
{
	for(new i = 0; i < sizeof(g_aWeaponItems); i++) if(weaponid == g_aWeaponItems[i][wep_model]) {
		return g_aWeaponItems[i][wep_material];
	}
	return 0;
}

RefreshWeapon(playerid)
{
	ResetPlayerWeapons(playerid);

	for(new i = 1; i != MAX_WEAPON_SLOT; i++) if(PlayerGuns[playerid][i][weapon_id]) {
        GivePlayerWeapon(playerid, PlayerGuns[playerid][i][weapon_id], 999999);
    }
}

stock RefreshWeaponSlot(playerid, weaponid)
{
	if (weaponid < 0 || weaponid > 46)
		return 0;

	new slot = g_aWeaponSlots[weaponid];

	RemoveWeaponInSlot(playerid, slot);

	if(!PlayerGuns[playerid][slot][weapon_id])
		return 0;

    GivePlayerWeapon(playerid, PlayerGuns[playerid][slot][weapon_id], 999999);
    return 1;
}

WeaponGivePlayer(playerid)
{
	new
		weapon_list[128],
		count = 0;

	strcat(weapon_list, "WeaponID\tWeapon\tAmmo\tDurability\n");
	for(new i = 1; i != MAX_WEAPON_SLOT; i++) if(PlayerGuns[playerid][i][weapon_id]) {
		strcat(weapon_list, sprintf("%d\t%s\t%s\t%s\n", PlayerGuns[playerid][i][weapon_id],ReturnWeaponName(PlayerGuns[playerid][i][weapon_id]), (i == 1) ? (" ") : sprintf("%d", PlayerGuns[playerid][i][weapon_ammo]), (i == 1) ? (" ") :  (sprintf("%d", PlayerGuns[playerid][i][weapon_durability]))));
		count++;
	}

	if(count) Dialog_Show(playerid, GiveOnly, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", weapon_list, "Give", "Close");
	else {
		strcat(weapon_list, "There is no weapon\t \t \n");
		Dialog_Show(playerid, GiveOnly, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", weapon_list, "Give", "Close");
	}
	return 1;
}
ShowPlayerWeapon(playerid, userid)
{
	new
		weapon_list[1024],
		count = 0;

	strcat(weapon_list, "Weapon\tAmmo\tDurability\tSerial\n");
	for(new i = 1; i != MAX_WEAPON_SLOT; i++) if(PlayerGuns[playerid][i][weapon_id]) 
	{

		new 
			serial_number[15],
			serial_id[10],
			length = strlen(PlayerGuns[playerid][i][weapon_serial])
		;

		strmid(serial_number, PlayerGuns[playerid][i][weapon_serial], 0, 4);
		strmid(serial_id, PlayerGuns[playerid][i][weapon_serial], 4, length);
		
		if(!strcmp(PlayerGuns[playerid][i][weapon_serial], "0", true)) 
		{
			strcat(weapon_list, sprintf("%s\t%s\t%s\tNone\n", ReturnWeaponName(PlayerGuns[playerid][i][weapon_id]), (i == 1) ? (" ") : sprintf("%d", PlayerGuns[playerid][i][weapon_ammo]), (i == 1) ? (" ") :  (sprintf("%d", PlayerGuns[playerid][i][weapon_durability]))));
		}
		else
		{
			strcat(weapon_list, sprintf("%s\t%s\t%s\t%s-%s\n", ReturnWeaponName(PlayerGuns[playerid][i][weapon_id]), (i == 1) ? (" ") : sprintf("%d", PlayerGuns[playerid][i][weapon_ammo]), (i == 1) ? (" ") :  (sprintf("%d", PlayerGuns[playerid][i][weapon_durability])), serial_number, serial_id));
		}
		count++;
	}

	if(count) Dialog_Show(userid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", weapon_list, "Close", "");
	else {
		strcat(weapon_list, "There is no weapon\t \t \n");
		Dialog_Show(userid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", weapon_list, "Close", "");
	}
	return 1;
}
PlayerRepairWeapon(playerid)
{
	new
		weapon_list[128],
		count = 0;
        

	strcat(weapon_list, "WeaponID\tWeapon\tDurability\tRepair\n");
	for(new i = 1; i != MAX_WEAPON_SLOT; i++) if(PlayerGuns[playerid][i][weapon_id]) 
	{
		strcat(weapon_list, sprintf("%d\t%s\t%s\t(%s Materials)\n", PlayerGuns[playerid][i][weapon_id],ReturnWeaponName(PlayerGuns[playerid][i][weapon_id]), (i == 1) ? (" ") :  (sprintf("%d", PlayerGuns[playerid][i][weapon_durability])), (i == 1) ? (" ") :  (sprintf("%d", WEAPON_DURABILITY-PlayerGuns[playerid][i][weapon_durability]))));
		count++;
	}

	if(count) Dialog_Show(playerid, RepairOnly, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", weapon_list, "Repair", "Close");
	else {
		strcat(weapon_list, "There is no weapon to repair\t \t \n");
		Dialog_Show(playerid, RepairOnly, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", weapon_list, "Repair", "Close");
	}
	return 1;
}

stock IsValidWeaponSlot(weaponid)
{
	if (g_aWeaponSlots[weaponid] == 7 || g_aWeaponSlots[weaponid] == 8)
		return 0;

	if (g_aWeaponSlots[weaponid] == 11 && weaponid != 46)
		return 0;

	return 1;
}