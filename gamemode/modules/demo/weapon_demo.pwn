// ==================[ Includes ]==================
// =============================================

#include 	<YSI\y_hooks>


// ==================[ Defined ]================
// =============================================

#define 	MULTIPLE_MATERIAL	1
#define 	MAX_WEAPON_SLOT		13
#define 	DEFAULT_AMMO		20
#define 	WEAPON_DURABILITY	1000

#define 	PLAYER_NORMAL 		1
#define 	PLAYER_OFFICIAL		2


// ==================[ Arrays ]=================
// =============================================

enum e_WeaponItems {
	wep_model,
	wep_material,
	wep_auth
};

new const g_aWeaponItems[][e_WeaponItems] = {
	{WEAPON_KNIFE, 2000, PLAYER_NORMAL},
	{WEAPON_SILENCED, 6000, PLAYER_NORMAL},
	{WEAPON_SHOTGUN, 14000, PLAYER_NORMAL},
	{WEAPON_RIFLE, 18000, PLAYER_NORMAL},
	{WEAPON_DEAGLE, 15000, PLAYER_NORMAL},
	{WEAPON_MP5, 7000, PLAYER_OFFICIAL},
	{WEAPON_AK47, 8000, PLAYER_OFFICIAL}
};

static const MaxGunAmmo[54] = {
	0,-1,-1,-1,-1,-1,-1,-1,-1,-1,
	-1,-1,-1,-1,-1,-1,10,10,10,0,
	0,0,850,350,350,100,200,350,2000,2000,
	2000,750,2000,100,50,5,5,10,9999,10,
	-1,500,500,10,-1,-1,-1,0,0,0,
	0,0,0,0
};

/*static const MaxGunAmmo[54] = 
{
	0, // Fist
	-1, // Brass Knuckle
	-1, // Golf Club
	-1, // Nighstick
	-1, // Knife
	-1, // Baseball Bat
	-1, // Shovel
	-1, // Pool Clue
	-1, // Katana
	-1, // Chainsaw
	-1, // Pfrple Dildo
	-1, // Dildo
	-1, // Vibrator
	-1, // Silver Vibrator
	10,
	10,
	10,
	0,
	0,
	0,
	850,
	350,
	350,
	100,
	200,
	350,
	2000,
	2000,
	2000,
	750,
	2000,
	100,
	50,
	5,
	5,
	10,
	9999,
	10,
	-1,
	500,
	500,
	10,
	-1,
	-1,
	-1,
	0,
	0,
	0,
	0,
	0,
	0,
	0
};*/

// =============[ Enums & Variable ]============
// =============================================

static 
	view_weapon[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};

enum E_WEAPON_DATA {
	weapon_id,
	weapon_slot,
	weapon_durability,
	weapon_ammo
};

new PlayerGuns[MAX_PLAYERS][MAX_WEAPON_SLOT][E_WEAPON_DATA];


// ==================[ Hooks ]==================
// =============================================
hook OnPlayerDisconnect(playerid, reason) {
	if((GetPlayerSQLID(playerid) != -1)) {

		foreach(new i : Player) if(view_weapon[i] == playerid) {
			view_weapon[i] = INVALID_PLAYER_ID;
		}
		view_weapon[playerid] = INVALID_PLAYER_ID;

		SavePlayerWeapon(playerid);

		for (new i = 0; i < MAX_WEAPON_SLOT; i ++) if(PlayerGuns[playerid][i][weapon_id])
	    {
	        PlayerGuns[playerid][i][weapon_id]          = 0;
	        PlayerGuns[playerid][i][weapon_ammo]        = 0;
	        PlayerGuns[playerid][i][weapon_slot]        = 0;
	        PlayerGuns[playerid][i][weapon_durability]  = 0;
	    }
	    ResetPlayerWeapons(playerid);
	}
}
 
//hook OnPlayerShootDynObj(playerid, weaponid, STREAMER_TAG_OBJECT objectid, Float:x, Float:y, Float:z) -< sebelum update streamer

hook OnPlayerShootDynObj(playerid, weaponid, objectid, Float:x, Float:y, Float:z)
{
	if(!IsPlayerDuty(playerid)) 
	{
		if(GetWeapon(playerid) == weaponid)
		{
			if(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]) {
				if(--PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo] == 0) {
					SendCustomMessage(playerid, "WEAPON", "Kamu kehabisan amunisi, isi kembali dengan perintah "YELLOW"/createammo.");

					SetPlayerArmedWeapon(playerid, 0);
				}
			}

			if(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_durability]) {
				if(--PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_durability] == 0) {
					SendCustomMessage(playerid, "WEAPON", "Senjata "RED"%s "WHITE"rusak, otomatis senjata kamu tidak dapat di gunakan kembali.", ReturnWeaponName(weaponid));

					if(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]) {
						Inventory_Add(playerid, "Materials", 11746, floatround((PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]/2)));
						SendCustomMessage(playerid, "WEAPON", "Amunisi masih tersisa, otomatis digantikan dengan "YELLOW"%d material(s).", floatround((PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]/2)));
					}
					ResetWeaponID(playerid, weaponid);
				}
			}
		}
	}
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(!IsPlayerDuty(playerid)) 
	{
		if(GetWeapon(playerid) == weaponid)
		{
			if(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]) {
				if(--PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo] == 0) {
					SendCustomMessage(playerid, "WEAPON", "Kamu kehabisan amunisi, isi kembali dengan perintah "YELLOW"/createammo.");

					SetPlayerArmedWeapon(playerid, 0);
				}
			}

			if(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_durability]) {
				if(--PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_durability] == 0) {
					SendCustomMessage(playerid, "WEAPON", "Senjata "RED"%s "WHITE"rusak, otomatis senjata kamu tidak dapat di gunakan kembali.", ReturnWeaponName(weaponid));

					if(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]) {
						Inventory_Add(playerid, "Materials", 11746, floatround((PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]/2)));
						SendCustomMessage(playerid, "WEAPON", "Amunisi masih tersisa, otomatis digantikan dengan "YELLOW"%d material(s).", floatround((PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]/2)));
					}
					ResetWeaponID(playerid, weaponid);
				}
			}
		}
	}
	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if(SQL_IsCharacterLogged(playerid))
	{
		static
			weaponid;

		if((weaponid = GetWeapon(playerid)) != 0) PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_ammo], sprintf("%s", (PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]) ? (sprintf("%d", PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo])) : ("No Ammo")));
		else PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_ammo], "_");
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSED(KEY_FIRE) || PRESSED(KEY_HANDBRAKE))
	{
		static
			weaponid
		;
		if((weaponid = GetWeapon(playerid)) != 0) {
			if(!PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]) {
				TogglePlayerControllable(playerid, 0);
				SetPlayerArmedWeapon(playerid, 0);
				TogglePlayerControllable(playerid, 1);
				SetCameraBehindPlayer(playerid);

				ShowPlayerFooter(playerid, "~y~~h~WARNING: ~w~Tidak ada amunisi di senjata ini.", 1500, 1);
			}
		}
	}
}
// ==================[ Function ]===============
// =============================================

RemoveWeaponInSlot(playerid, slotid) {
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

PlayerHasWeaponSlot(playerid, weaponid) {
    if(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_slot] == g_aWeaponSlots[weaponid]) {
        return 1;
    }
    return 0;
}

GivePlayerWeaponEx(playerid, weaponid, ammo = DEFAULT_AMMO, durability = WEAPON_DURABILITY) {
	/*if(!(0 < weaponid < 46)) {
	//if(IsValidWeaponSlot(weaponid)){
		return printf("[debug] Invalid weapon id (%d).", weaponid);
	}*/

	if(!(0 < weaponid < 46)) {
		return printf("[debug] Invalid weapon id (%d).", weaponid);
	}

	/*if(!IsValidWeaponSlot(weaponid))
		return SendErrorMessage(playerid, "Invalid weapon id!");*/

	if(PlayerHasWeaponEx(playerid, weaponid)) {
		return 1;
	}

	new 
		slot = g_aWeaponSlots[weaponid]
	;

	if(slot == 1 || slot == 10)  {
		ammo = 1;
		durability = 1;
	}

	PlayerGuns[playerid][slot][weapon_id] 			= weaponid;
	PlayerGuns[playerid][slot][weapon_ammo] 		= ammo;
	PlayerGuns[playerid][slot][weapon_slot] 		= slot;
	PlayerGuns[playerid][slot][weapon_durability] 	= durability;

	GivePlayerWeapon(playerid, weaponid, 999999);

	mysql_tquery(g_iHandle, sprintf("DELETE FROM `weapon_players` WHERE `slot` = '%d'", slot));

	new
		query[300]
	;

	mysql_format(g_iHandle, query, sizeof(query), "INSERT INTO weapon_players VALUES ('%d', '%d', '%d', '%d', '%d', '%d') ON DUPLICATE KEY UPDATE ammo = %d, durability = %d, created = %d", GetPlayerSQLID(playerid), slot, weaponid, ammo, durability, gettime(), ammo, gettime(), durability);
	mysql_tquery(g_iHandle, query);
	return 1;
}

SavePlayerWeapon(playerid) {
	for(new i = 1; i < MAX_WEAPON_SLOT; i++)
	{
		new 
			query[300]
		;

		if(!PlayerGuns[playerid][i][weapon_id]) continue;
		
		mysql_format(g_iHandle, query, sizeof(query), "INSERT INTO weapon_players VALUES ('%d', '%d', '%d', '%d', '%d', '%d') ON DUPLICATE KEY UPDATE ammo = %d, durability = %d, created = %d", GetPlayerSQLID(playerid), i, PlayerGuns[playerid][i][weapon_id], PlayerGuns[playerid][i][weapon_ammo], PlayerGuns[playerid][i][weapon_durability], gettime(), PlayerGuns[playerid][i][weapon_ammo], PlayerGuns[playerid][i][weapon_durability], gettime());
		mysql_tquery(g_iHandle, query);
	}
	return 1;
}

ResetWeaponID(playerid, weaponid) {
	ResetPlayerWeapons(playerid);

    for (new i = 0; i < MAX_WEAPON_SLOT; i ++) {
        if(PlayerGuns[playerid][i][weapon_id] != weaponid) {
            GivePlayerWeapon(playerid, PlayerGuns[playerid][i][weapon_id], 999999);
        }
        else {
            PlayerGuns[playerid][i][weapon_id] 			= 0;
			PlayerGuns[playerid][i][weapon_ammo] 		= 0;
			PlayerGuns[playerid][i][weapon_slot] 		= 0;
			PlayerGuns[playerid][i][weapon_durability] 	= 0;

			mysql_tquery(g_iHandle, sprintf("DELETE FROM `weapon_players` WHERE `weaponid` = '%d' AND `userid` = '%d'", weaponid, GetPlayerSQLID(playerid)));
        }
    }
	return 1;
}

ResetWeapons(playerid) {
	ResetPlayerWeapons(playerid);

    for (new i = 0; i < MAX_WEAPON_SLOT; i ++) {
    	if(!PlayerGuns[playerid][i][weapon_id])
    		continue;

        PlayerGuns[playerid][i][weapon_id] 			= 0;
		PlayerGuns[playerid][i][weapon_ammo] 		= 0;
		PlayerGuns[playerid][i][weapon_slot] 		= 0;
		PlayerGuns[playerid][i][weapon_durability] 	= 0;

    }
	mysql_tquery(g_iHandle, sprintf("DELETE FROM `weapon_players` WHERE `userid` = '%d'", GetPlayerSQLID(playerid)));
	return 1;
}

GetWeapon(playerid) {
    new 
    	weaponid = GetPlayerWeapon(playerid)
    ;

    if(1 < weaponid < 46 && PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_id] == weaponid) // tadinya 1 <= weaponid <= 46
        return weaponid;

    return 0;
}

ReturnWeaponCount(playerid) {
	new
		count = 0
	;
	for (new i = 0; i < MAX_WEAPON_SLOT; i ++) if(PlayerGuns[playerid][i][weapon_id]) {
		count++;
    }
    return count;
}

PlayerHasWeaponEx(playerid, weaponid) {
    new
        weapon,
        ammo;

    for (new i = 0; i < MAX_WEAPON_SLOT; i ++) if(PlayerGuns[playerid][i][weapon_id] == weaponid) {
        GetPlayerWeaponData(playerid, i, weapon, ammo);

        if(weapon == weaponid && ammo > 0) return 1;
    }
    return 0;
}

ReturnWeaponAmmo(playerid, weaponid)
{
	if(weaponid != 0) {
		return PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo];
	}
	return 0;
}

ReturnWeaponDurability(playerid, weaponid)
{
	if(weaponid != 0) {
		return PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_durability];
	}
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

	for(new i = 1; i != MAX_WEAPON_SLOT; i++) { 

	//if(PlayerGuns[playerid][i][weapon_id]) {
        GivePlayerWeapon(playerid, PlayerGuns[playerid][i][weapon_id], 999999);
    }
}

stock RefreshWeaponSlot(playerid, weaponid)
{
	// Melebihi ID weapon yang tersedia di GTA SA.
	if (weaponid < 0 || weaponid > 46)
	{
		// Mengembalikan nilai 0 sebagai penanda gagal untuk refresh weapon slot.
		return 0;
	}

	RemoveWeaponInSlot(playerid, g_aWeaponSlots[weaponid]);

	if(!PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_id])
		return 1;

    GivePlayerWeapon(playerid, PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_id], 999999);
    return 1;
}

ShowPlayerWeapon(playerid, userid)
{
	new
		weapon_list[128],
		count = 0;

	strcat(weapon_list, "Weapon\tAmmo\tDurability\n");
	for(new i = 1; i != MAX_WEAPON_SLOT; i++) if(PlayerGuns[playerid][i][weapon_id]) {
		strcat(weapon_list, sprintf("%s\t%s\t%s\n", ReturnWeaponName(PlayerGuns[playerid][i][weapon_id]), (i == 1) ? (" ") : sprintf("%d", PlayerGuns[playerid][i][weapon_ammo]), (i == 1) ? (" ") :  (sprintf("%d", PlayerGuns[playerid][i][weapon_durability]))));
		count++;
	}

	if(count) Dialog_Show(userid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", weapon_list, "Close", "");
	else {
		strcat(weapon_list, "There is no weapon\t \t \n");
		Dialog_Show(userid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Weapons", weapon_list, "Close", "");
	}
	return 1;
}

stock IsValidWeaponSlot(weaponid)
{
	// Invalid slot untuk granat dan heave weapons (rpg, minigun, flamethrower, dan heat-seek rocket).
	if (g_aWeaponSlots[weaponid] == 7 || g_aWeaponSlots[weaponid] == 8)
	{
		return false;
	}

	// Slot 11 hanya parasut yg diperbolehkan.
	if (g_aWeaponSlots[weaponid] == 11 && weaponid != 46)
	{
		return false;
	}

	return true;
}
/*ReturnWeapon(playerid) {
	static
		weapons,
		ammo
	;
	for(new i = 1; i != MAX_WEAPON_SLOT; i++)
	{
		GetPlayerWeaponData(playerid, i, weapons, ammo);

		if(!weapons) continue;

		PlayerGuns[playerid][i][weapon_id] = weapons;
		PlayerGuns[playerid][i][weapon_slot] = i;
	}
	return 1;
}*/

// ================[ Callback ]=================
// =============================================

Function:OnLoadPlayerWeapons(playerid) {
	static
	    weaponid,
	    ammo,
	    durability;
	
	for(new i = 0; i < cache_num_rows(); i++)
	{
	    weaponid 	= cache_get_field_int(i, "weaponid");
	    ammo    	= cache_get_field_int(i, "ammo");
	    durability 	= cache_get_field_int(i, "durability");
		
		if(!(0 < weaponid < 46))
		{
			printf("[info] Warning: OnLoadPlayerWeapons - Unknown weaponid '%d'. Skipping.", weaponid);
			continue;
		}

		if(!IsPlayerDuty(playerid)) {
			GivePlayerWeaponEx(playerid, weaponid, ammo, durability);
		}
	}
	SetPlayerArmedWeapon(playerid, 0);
	return 1; 
}

// ================[ Commands ]=================
// =============================================

CMD:weapons(playerid, params[]) {
	ShowPlayerWeapon(playerid, playerid);
	return 1;
}

CMD:weapon(playerid, params[]) {

	if(PlayerData[playerid][pInjured])
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak bisa menggunakan perintah ini ketika injured.");

    if(PlayerData[playerid][pHospitalTime])
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak bisa menggunakan perintah ini ketika dalam masa pemulihan.");

	static
		category[32],
		string[32]
	;

	if(sscanf(params, "s[32]S()[32]", category, string))
		return SendSyntaxMessage(playerid, "/weapon [give/view/acceptview/scrap/destroy]");

	if(!strcmp(category, "give"))
	{
		static
			userid,
			weaponid
		;

		if(sscanf(string, "u", userid))
			return SendSyntaxMessage(playerid, "/weapon give [userid]");

		if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) 
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tidak login atau tidak bedara didekatmu.");

		if((weaponid = GetWeapon(playerid)) == 0)
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memegang senjata apapun.");

		if(IsPlayerInjured(playerid))
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu sedang sekarat, tidak bisa menggunakan perintah ini.");

        if(PlayerHasWeaponSlot(userid, weaponid))
        	return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tersebut memiliki senjata di slot yang sama.");

		GivePlayerWeaponEx(userid, weaponid, PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo], PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_durability]);
		ResetWeaponID(playerid, weaponid);

		SendServerMessage(playerid, "Kamu telah memberi "RED"%s"WHITE" kepada "YELLOW"%s.", ReturnWeaponName(weaponid), ReturnName(userid));
		SendServerMessage(userid, ""YELLOW"%s"WHITE" memberikan "RED"%s"WHITE" kepadamu.", ReturnName(playerid), ReturnWeaponName(weaponid));
	}
	else if(!strcmp(category, "scrap"))
	{
		static
			weaponid,
			confirm[10]
		;
		if((weaponid = GetWeapon(playerid)) == 0)
			return ShowPlayerFooter(playerid, "Kamu tidak memegang senjata apapun.");

		if(IsPlayerInjured(playerid))
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu sedang sekarat, tidak bisa menggunakan perintah ini.");

		if(sscanf(string, "s[10]", confirm)) {
			SendCustomMessage(playerid, "USAGE","/weapon scrap ['confirm']");
			SendCustomMessage(playerid, "INFO","Perintah ini untuk menggantikan senjata dan peluru menjadi material!");
			return 1;
		}

		if(!strcmp(confirm, "confirm"))
		{
			Inventory_Add(playerid, "Materials", 11746, floatround((ReturnWeaponMaterial(weaponid)/2)));
			SendCustomMessage(playerid, "WEAPON", "Berhasil melakukan senjata "RED"%s "WHITE"untuk "YELLOW"%d material(s)", ReturnWeaponName(weaponid), floatround((ReturnWeaponMaterial(weaponid)/2)));

			Inventory_Add(playerid, "Materials", 11746, floatround((PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]/2)));
			SendCustomMessage(playerid, "WEAPON", "Berhasil melakukan scrap amunisi "RED"%s "WHITE"untuk "YELLOW"%d material(s)", ReturnWeaponName(weaponid), floatround((PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]/2)));

			ResetWeaponID(playerid, weaponid);
		}
	}
	else if(!strcmp(category, "destroy"))
	{
		static
			weaponid,
			confirm[10]
		;
		if((weaponid = GetWeapon(playerid)) == 0)
			return ShowPlayerFooter(playerid, "Kamu tidak memegang senjata apapun.");

		if(IsPlayerInjured(playerid))
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu sedang sekarat, tidak bisa menggunakan perintah ini.");

		if(sscanf(string, "s[10]", confirm)) {
			SendCustomMessage(playerid, "USAGE", "/weapon destroy ['confirm']");
			SendCustomMessage(playerid, "WARNING","Perintah ini digunakan untuk menghancurkan habis senjatamu, termasuk peluru di dalamnya!");
			SendCustomMessage(playerid, "WARNING","Tidak ada refund setelah menggunakan perintah ini!");
			return 1;
		}

		if(!strcmp(confirm, "confirm"))
		{
			SendCustomMessage(playerid, "WEAPON", "Berhasil menghancurkan senjata "RED"%s.", ReturnWeaponName(weaponid));
			ResetWeaponID(playerid, weaponid);
		}
	}
	else if(!strcmp(category, "view"))
	{
		static
			userid
		;
		if(sscanf(string, "u", userid))
			return SendSyntaxMessage(playerid, "/weapon view [playerid/PartOfName]");

		if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) 
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tidak login atau tidak bedara didekatmu.");

		view_weapon[userid] = playerid;

		SendServerMessage(userid, ""YELLOW"%s "WHITE"meminta izin melihat senjata milikmu ("YELLOW"/weapon acceptview"WHITE").", ReturnName(playerid, 0, 1));
		SendServerMessage(playerid, "Kamu sedang meminta izin melihat senjata "YELLOW"%s"WHITE", tunggu beberapa saat.", ReturnName(userid, 0, 1));
	}
	else if(!strcmp(category, "acceptview"))
	{
		if(view_weapon[playerid] == INVALID_PLAYER_ID)
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Gunakan perintah ~y~~h~/weapon view ~w~terlebih dahulu.");

		if(!SQL_IsCharacterLogged(view_weapon[playerid]))
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tersebut tidak login ke dalam server.");

		if(!IsPlayerNearPlayer(playerid, view_weapon[playerid], 5.0)) 
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tidak tersebut tidak bedara didekatmu.");

		ShowPlayerWeapon(playerid, view_weapon[playerid]);		
	}
	else if(!strcmp(category, "adjust"))
	{

	}
	else if(!strcmp(category, "toggle"))
	{

	}
	else SendSyntaxMessage(playerid, "/weapon [give/view/acceptview/scrap/destroy]");
	return 1;
}



CMD:creategun(playerid, params[]) 
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -50.3808,-232.8592,6.7646)) 
        return ShowPlayerFooter(playerid, "~g~INFO: ~w~Kamu tidak berada di blackmarket.");

	if(IsPlayerDuty(playerid)) 
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu sedang duty faction.");

    if(GetPlayerJob(playerid) != JOB_ARMS_DEALER)
    	return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak bekerja sebagai arms dealer.");

    new 
    	string[156]
    ;

    strcat(string, "Weapon\tAmmo\tMaterial\n");
    for(new i = 0; i < sizeof(g_aWeaponItems); i++) {
    	if(g_aWeaponItems[i][wep_auth] == PLAYER_NORMAL) {
	    	strcat(string, sprintf("%s\t%d\t%d\n", ReturnWeaponName(g_aWeaponItems[i][wep_model]), (g_aWeaponSlots[g_aWeaponItems[i][wep_model]] == 1) ? (1) : (((MaxGunAmmo[g_aWeaponItems[i][wep_model]] * 2)/10)), g_aWeaponItems[i][wep_material]));
	    }

	   	if(GetFactionType(playerid) == FACTION_GANG)
	   	{
	    	if(g_aWeaponItems[i][wep_auth] == PLAYER_OFFICIAL) {
		    	strcat(string, sprintf("%s\t%d\t%d\n", ReturnWeaponName(g_aWeaponItems[i][wep_model]), (g_aWeaponSlots[g_aWeaponItems[i][wep_model]] == 1) ? (1) : (((MaxGunAmmo[g_aWeaponItems[i][wep_model]] * 2)/10)), g_aWeaponItems[i][wep_material]));
		    }
	   	}
    }
    Dialog_Show(playerid, CreateGun, DIALOG_STYLE_TABLIST_HEADERS, "Create Gun", string, "Create", "Cancel");
	return 1;
}

CMD:buymaterials(playerid, params[]) {
    static 
        amount;

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -1855.1879,-1561.4839,21.7500)) 
        return ShowPlayerFooter(playerid, "~g~INFO: ~w~Kamu tidak berada di gudang pembelian material.");

    if(sscanf(params, "d", amount))
        return SendSyntaxMessage(playerid, "/buymaterials [jumlah]"), SendServerMessage(playerid, "satu material di hargai $2");

    if(amount < 0)
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Jumlah yang di masukkan tidak boleh kurang dari nol.");

    if(GetMoney(playerid) < (MULTIPLE_MATERIAL*amount))
        return SendErrorMessage(playerid, "Uang yang kamu miliki kurang untuk membeli %d material (%s).", amount, FormatNumber(MULTIPLE_MATERIAL*amount));

    if((Inventory_Count(playerid, "Materials")+amount) > 10000)
    	return SendErrorMessage(playerid, "Kamu hanya dapat membeli %d material.", (10000-Inventory_Count(playerid, "Materials")));

    new id = Inventory_Add(playerid, "Materials", 11746, amount);

    if(id == -1)
        return SendErrorMessage(playerid, "Sisa slot di inventory kamu sudah penuh, buang atau gunakan beberapa item yang tidak terpakai.");

    SendServerMessage(playerid, "Berhasil membeli "YELLOW"%d material "WHITE"dengan total harga "GREEN"%s.", amount, FormatNumber((MULTIPLE_MATERIAL*amount)));
    GiveMoney(playerid, -(MULTIPLE_MATERIAL*amount), ECONOMY_ADD_SUPPLY, "bought materials");
    return 1;
}

CMD:createammo(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -50.3808,-232.8592,6.7646)) 
        return ShowPlayerFooter(playerid, "~g~INFO: ~w~Kamu tidak berada di blackmarket.");

    if(IsPlayerDuty(playerid)) 
        return ShowPlayerFooter(playerid, "~r~ERROR~w~Kamu sedang duty faction.");

    if(GetPlayerJob(playerid) != JOB_ARMS_DEALER)
    	return ShowPlayerFooter(playerid, "~r~ERROR~w~Kamu tidak bekerja sebagai arms dealer.");

    if(!Inventory_HasItem(playerid, "Materials"))
        return ShowPlayerFooter(playerid, "~r~ERROR~w~Kamu tidak memiliki material.");

    static
        confirm[24],
        weaponid;

    if((weaponid = GetWeapon(playerid)) == 0) 
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memegang senjata apapun.");

    if(g_aWeaponSlots[weaponid] == 1)
    	return ShowPlayerFooter(playerid, "~g~INFO: ~w~Senjata ini tidak memerlukan amunisi.");

    if(sscanf(params, "s[24]", confirm)){
        SendCustomMessage(playerid, "USAGE", "/createammo ['confirm']");
    	SendCustomMessage(playerid, "DETAILS", "Weapon: "RED"%s"WHITE", current: "YELLOW"%d/%d ammo", ReturnWeaponName(weaponid), ReturnWeaponAmmo(playerid, weaponid), MaxGunAmmo[weaponid]);
    	SendCustomMessage(playerid, "DETAILS", "Creating ammo: "YELLOW"%d"WHITE", material cost: "YELLOW"%d unit(s)", (MaxGunAmmo[weaponid]-ReturnWeaponAmmo(playerid, weaponid)), floatround(((MaxGunAmmo[weaponid]-ReturnWeaponAmmo(playerid, weaponid))/2)));
    	return 1;
    }

    new amount = (MaxGunAmmo[weaponid]-ReturnWeaponAmmo(playerid, weaponid));

    if(!strcmp(confirm, "confirm"))
    {
	    if(floatround(amount/2) > Inventory_Count(playerid, "Materials"))
	        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Jumlah material tidak mencukupi.");

	    if(weaponid > 22 || weaponid < 38)
	    {
	        PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo] += amount;
	        Inventory_Remove(playerid, "Materials", floatround((amount/2)));

	        SendCustomMessage(playerid, "AMMO","Sukses membuat "YELLOW"%d amunisi (%d material) "WHITE"untuk senjata "RED"%s.", amount, floatround((amount/2)), ReturnWeaponName(weaponid));
	    }
	    else ShowPlayerFooter(playerid, "~g~INFO: ~w~Senjata ini tidak memerlukan amunisi.");
    }
    return 1;
}

// ================[ Dialogs ]=================
// =============================================
Dialog:CreateGun(playerid, response, listitem, inputtext[]) 
{
	if(response)
	{
		new 
			material = g_aWeaponItems[listitem][wep_material],
			model = g_aWeaponItems[listitem][wep_model]
		;
		if(Inventory_Count(playerid, "Materials") < material)
        	return SendErrorMessage(playerid, "You don't have enough materials.");

        if(PlayerHasWeaponEx(playerid, model))
			return SendErrorMessage(playerid, "You already have %s, /buyammo to add more ammo.", ReturnWeaponName(model));

        if(PlayerHasWeaponSlot(playerid, model))
        	return SendErrorMessage(playerid, "You already have weapon in the same slot.");

		GivePlayerWeaponEx(playerid, model, ((MaxGunAmmo[model] * 2)/10));
        Inventory_Remove(playerid, "Materials", material);
		SendCustomMessage(playerid, "WEAPON", "Berhasil membuat "RED"%s (%d ammo) "WHITE"dengan "YELLOW"%d material.", ReturnWeaponName(model), ((MaxGunAmmo[model] * 2)/10), material);
	}
	return 1;
}