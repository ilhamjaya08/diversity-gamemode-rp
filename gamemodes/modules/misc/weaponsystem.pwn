/*
	Script name 	: weaponsystem.pwn
	Author			: Agus Syahputra
	Idea 			: MTRP Server
	Time Creation 	: 12/06/2017 - 20:23
	System			: Module

	Keterangan:
	- Player hanya bisa holding 1 senjata saja. Dalam 1 senjata menu akan -
	  menampilkan reload, add to inventory dan drop
	
	- Setelah /pgun senjata dan ammo jadi terpisa, dan tidak dalam keadaan -
	  Hold weapon

	- /dgun berguna untuk meletakkan senjata, akan ada Dialog GUI untuk menam -
	  pilkan senjata yang akan di drop.

	- Pilih weapon dari My Weapon > pilih senjata, seterusnya akan di alihkan sesuai -
	  Ammo type yang di pilih, dan jika tidak ada akan di beri notice tidak ada.

	- 1 Kali penembakan, durability berkurang 1

	- Ammo jika kosong, senjata akan masuk ke inventory kembali.
	- Ammo dapat di reload jika di beri notice, dan menggunakan ammo slot lain

	- /takegun untuk ke menu My Weapon

	Keterangan Kendala:

*/
#define MAX_WEAPON	11

#define GetPlayerWeaponIndex(%0)	SelectWeapon[%0]
#define GetPlayerAmmoIndex(%0)		SelectAmmo[%0]

enum weaponEnums {
	weaponID,
	weaponExists,
	weaponModel,
	weaponDurability,
	weaponUsing
};

enum ammoEnums {
	ammoID,
	ammoExists,
	ammoAmount,
	ammoWeapon,
	ammoUsing
};

new	weaponData[MAX_PLAYERS][MAX_WEAPON][weaponEnums],
	ammoData[MAX_PLAYERS][MAX_WEAPON][ammoEnums];

new ListedWeapon[MAX_PLAYERS][MAX_WEAPON],
	ListedAmmo[MAX_PLAYERS][MAX_WEAPON];

new	SelectWeapon[MAX_PLAYERS] = 0,
	SelectAmmo[MAX_PLAYERS] = 0,
	AmmoReload[MAX_PLAYERS] = 0;

AddWeaponItem(playerid, weaponid, durability = 500)
{
	for(new i = 1; i != MAX_WEAPON; i++) if(!weaponData[playerid][i][weaponExists])
	{
		weaponData[playerid][i][weaponExists] = true;

		weaponData[playerid][i][weaponModel] = weaponid;
		weaponData[playerid][i][weaponDurability] = durability;
		weaponData[playerid][i][weaponUsing] = false;

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `playerweapon` (`owned`, `durability`, `used`, `model`) VALUES ('%d', '%d', '0', '%d')", PlayerData[playerid][pID], durability, weaponid), "OnWeaponCreated", "dd", playerid, i);
		return i;
	}
	return -1;
}

Function:OnWeaponCreated(playerid, index)
{
	weaponData[playerid][index][weaponID] = cache_insert_id();
	return 1;
}

RemoveWeaponItem(playerid, slot)
{
	if(weaponData[playerid][slot][weaponExists])
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `playerweapon` WHERE ID = %d AND owned = %d", weaponData[playerid][slot][weaponID], PlayerData[playerid][pID]));

		weaponData[playerid][slot][weaponID] = 0;
		weaponData[playerid][slot][weaponModel] = 0;
		weaponData[playerid][slot][weaponDurability] = 0;
		weaponData[playerid][slot][weaponExists] = false;
		weaponData[playerid][slot][weaponUsing] = false;

		HoldWeapon(playerid, 0);
	}
	return 1;
}

AddAmmoItem(playerid, weaponid, ammo = 0)
{
	for(new i = 1; i != MAX_WEAPON; i++) if(!ammoData[playerid][i][ammoExists])
	{
		ammoData[playerid][i][ammoExists] = true;

		ammoData[playerid][i][ammoWeapon] = weaponid;
		ammoData[playerid][i][ammoUsing] = false;

		if(ammo) ammoData[playerid][i][ammoAmount] = ammo;	
		else
		{
			switch(weaponid)
			{
				case 23: ammoData[playerid][i][ammoAmount] = 17;
				case 24: ammoData[playerid][i][ammoAmount] = 7;
				case 25: ammoData[playerid][i][ammoAmount] = 25;
				case 27: ammoData[playerid][i][ammoAmount] = 7;
				case 29: ammoData[playerid][i][ammoAmount] = 30;
				case 30: ammoData[playerid][i][ammoAmount] = 30;
				case 33: ammoData[playerid][i][ammoAmount] = 10;
				case 34: ammoData[playerid][i][ammoAmount] = 10;
			}
		}

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `playerammo` (`owned`, `ammo`, `used`, `weapon`) VALUES ('%d', '%d', '0', '%d')", PlayerData[playerid][pID], ammoData[playerid][i][ammoAmount], weaponid), "OnAmmoCreated", "dd", playerid, i);
		return i;
	}
	return -1;
}

Function:OnAmmoCreated(playerid, index)
{
	ammoData[playerid][index][ammoID] = cache_insert_id();
	return 1;
}

RemoveAmmoItem(playerid, slot)
{
	if(ammoData[playerid][slot][ammoExists])
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `playerammo` WHERE ID = %d AND owned = %d", ammoData[playerid][slot][ammoID], PlayerData[playerid][pID]));

		ammoData[playerid][slot][ammoID] = 0;
		ammoData[playerid][slot][ammoWeapon] = 0;
		ammoData[playerid][slot][ammoUsing] = false;
		ammoData[playerid][slot][ammoExists] = false;
	}
	return 1;
}

ReloadAmmo(playerid)
{
	if(AmmoReload[playerid])
	{
		for(new i = 1; i != MAX_WEAPON; i++) if(ammoData[playerid][i][ammoExists] && ammoData[playerid][i][ammoWeapon] == weaponData[playerid][SelectWeapon[playerid]][weaponModel])
		{
			SelectAmmo[playerid] = i;
			ammoData[playerid][SelectAmmo[playerid]][ammoUsing] = true; 

			PlayReloadAnimation(playerid, weaponData[playerid][SelectWeapon[playerid]][weaponModel]);
			GivePlayerWeapon(playerid, weaponData[playerid][SelectWeapon[playerid]][weaponModel], 99999);

			UpdateAmmo(playerid, sprintf("%d", ammoData[playerid][SelectAmmo[playerid]][ammoAmount]));

			AmmoReload[playerid] = false;
			HoldWeapon(playerid, 0);

			GameTextForPlayer(playerid, "~r~~h~ammo reloaded!", 2500, 4);
			return 1;
		}
		weaponData[playerid][SelectWeapon[playerid]][weaponUsing] = false;
		UpdateAmmo(playerid, "_");
		SendCustomMessage(playerid, "WEAPON", "Kamu tidak memiliki magazine yang tersisa, senjata di masukkan kembali ke dalam inventory.");

		SelectWeapon[playerid] = 0;
		SelectAmmo[playerid] = 0;
		AmmoReload[playerid] = false;
		HoldWeapon(playerid, 0);
	}
	return 1;
}

SQL_SaveWeapon(playerid)
{
    if(!PlayerData[playerid][pLogged])
        return 0;

    new
        query[255];

    for(new i = 1; i != MAX_WEAPON; i++)
	{
		if(weaponData[playerid][i][weaponExists]) {
			format(query, sizeof(query), "UPDATE playerweapon SET durability=%d, used=%d, model=%d WHERE ID = %d AND owned = %d", 
				weaponData[playerid][i][weaponDurability],
				weaponData[playerid][i][weaponUsing],
				weaponData[playerid][i][weaponModel],
				weaponData[playerid][i][weaponID],
				PlayerData[playerid][pID]
			);
			mysql_tquery(g_iHandle, query);
		}

		if(ammoData[playerid][i][ammoExists]) {
			format(query, sizeof(query), "UPDATE playerammo SET ammo=%d, used=%d, weapon=%d WHERE ID = %d AND owned = %d", 
				ammoData[playerid][i][ammoAmount],
				ammoData[playerid][i][ammoUsing],
				ammoData[playerid][i][ammoWeapon],
				ammoData[playerid][i][ammoID],
				PlayerData[playerid][pID]
			);
			mysql_tquery(g_iHandle, query);
		}
	}

    return 1;
}

UpdateAmmo(playerid, text[])
{
	PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_ammo], text);
	return 1;
}


CMD:testbuyammo(playerid, params[])
{
	Dialog_Show(playerid, BuyAmmoNew, DIALOG_STYLE_TABLIST_HEADERS, "Buy Weapon", "Weapon ID\tWeapon Name\n%d\t%s\n%d\t%s\n%d\t%s\n%d\t%s\n%d\t%s\n%d\t%s\n%d\t%s\n%d\t%s", "Select", "Close",
		23, ReturnWeaponName(23),
		24, ReturnWeaponName(24), 
		25, ReturnWeaponName(25), 
		27, ReturnWeaponName(27), 
		29, ReturnWeaponName(29), 
		30, ReturnWeaponName(30), 
		33, ReturnWeaponName(33), 
		34, ReturnWeaponName(34)
	);
	return 1;
}

Dialog:BuyAmmoNew(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = AddAmmoItem(playerid, strval(inputtext));

		if(id == -1)
			return SendErrorMessage(playerid, "There are no slot for that player.");

		SendServerMessage(playerid, "Buy magazine %s with %d ammo.", ReturnWeaponName(strval(inputtext)), ammoData[playerid][id][ammoAmount]);		
	}
	return 1;
}

CMD:resetall(playerid, params[])
{
	new 
		targetid;

	if(sscanf(params, "d", targetid))
		return SendSyntaxMessage(playerid, "/resetall [userid]");

	for(new i = 1; i != MAX_WEAPON; i++)
	{
		if(weaponData[targetid][i][weaponExists])
		{
			RemoveWeaponItem(targetid, i);
		}
		if(ammoData[targetid][i][ammoExists])
		{
			RemoveAmmoItem(targetid, i);	
		}
	}

	RemoveWeaponInSlot(playerid, g_aWeaponSlots[weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]]);

	HoldWeapon(targetid, 0);
	SelectWeapon[targetid] = 0;
	SelectAmmo[targetid] = 0;

	SendServerMessage(playerid, "Reset %s weapon item.", ReturnName(targetid));
	return 1;
}

CMD:addweaponitem(playerid, params[])
{
	new 
		targetid, 
		weaponid, 
		durability;

	CheckAdmin(playerid, 7);

	if(sscanf(params, "ddD(500)", targetid, weaponid, durability))
		return SendSyntaxMessage(playerid, "/addweaponitem [userid] [weaponid (/addweapon)] [durability]");

	if(weaponid < 0 || weaponid > 46)
		return SendErrorMessage(playerid, "Invalid weapon id.");

	if(durability > 500 || durability < 0)
		return SendErrorMessage(playerid, "Durability must be between 0-500");

	new id = AddWeaponItem(targetid, weaponid, durability);

	if(id == -1)
		return SendErrorMessage(playerid, "There are no slot for that player.");

	SendServerMessage(playerid, "You've give item %s with %d durability for %s.", ReturnWeaponName(weaponid), durability, ReturnName(targetid, 0));	
	return 1;
}

CMD:addammoitem(playerid, params[])
{
	new 
		targetid, 
		weaponid;

	CheckAdmin(playerid, 7);

	if(sscanf(params, "dd", targetid, weaponid))
		return SendSyntaxMessage(playerid, "/addammoitem [userid] [weaponid (/addweapon)]");

	if(weaponid < 0 || weaponid > 46)
		return SendErrorMessage(playerid, "Invalid weapon id.");

	new id = AddAmmoItem(targetid, weaponid);

	if(id == -1)
		return SendErrorMessage(playerid, "There are no slot for that player.");

	SendServerMessage(playerid, "You've give ammo item %s with %d ammo for %s.", ReturnWeaponName(weaponid), ammoData[targetid][id][ammoAmount], ReturnName(targetid, 0));	
	return 1;
}

CMD:myweapons(playerid, params[])
{
	new
		weapon[MAX_WEAPON*64],
		count = 0;

	if(PlayerData[playerid][pOnDuty]) return SendErrorMessage(playerid, "You're on faction duty.");

	if(SelectWeapon[playerid])
	{
		Dialog_Show(playerid, SettingWeapon, DIALOG_STYLE_LIST, "My Weapons", "Reload\nPut weapon to inventory\nWeapon inventory", "Select", "Close");
		return 1;
	}
	format(weapon, sizeof(weapon), "Weapon\tDurability\n");
	for(new i = 1; i != MAX_WEAPON; i++) if(weaponData[playerid][i][weaponExists])
	{
		format(weapon, sizeof(weapon), "%s%s\t%s\n", weapon, ReturnWeaponName(weaponData[playerid][i][weaponModel]), g_aWeaponSlots[weaponData[playerid][i][weaponModel]] == 1 ? " " : sprintf("%d",weaponData[playerid][i][weaponDurability]));
		ListedWeapon[playerid][count++] = i;
	}
	if(count) Dialog_Show(playerid, MyWeapons, DIALOG_STYLE_TABLIST_HEADERS, "My Weapons", weapon, "Select", "Close");
	else SendErrorMessage(playerid, "Kamu tidak memiliki item senjata");
	return 1;
}

//---------------------------------------------------------------------------------------------------------------------------------------------------

Dialog:SettingWeapon(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: 
			{
				if(g_aWeaponSlots[weaponData[playerid][SelectWeapon[playerid]][weaponModel]] == 1)
					return SendErrorMessage(playerid, "Senjata ini tidak dapat di reload.");

				if(AmmoReload[playerid]) ReloadAmmo(playerid);
				else SendErrorMessage(playerid, "Tidak dapat reload senjata ini.");
			}
			case 1: {
				SendCustomMessage(playerid, "WEAPON", "Kamu telah meletakkan %s ke dalam inventory.", ReturnWeaponName(weaponData[playerid][SelectWeapon[playerid]][weaponModel]));

				RemoveWeaponInSlot(playerid, g_aWeaponSlots[weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]]);
				HoldWeapon(playerid, 0);

				UpdateAmmo(playerid, "_");

				SelectWeapon[playerid] = 0;
				SelectAmmo[playerid] = 0;
			}
			case 2: {
				new weaponstr[MAX_WEAPON*64];

				for(new i = 1; i != MAX_WEAPON; i++) if(weaponData[playerid][i][weaponExists]) {
					format(weaponstr, sizeof(weaponstr), "%s"COL_CLIENT"Weapon: %s %s %s\n", weaponstr, ReturnWeaponName(weaponData[playerid][i][weaponModel]), g_aWeaponSlots[weaponData[playerid][i][weaponModel]] == 1 ? (" ") : sprintf("- %d durability",weaponData[playerid][i][weaponDurability]), weaponData[playerid][i][weaponUsing] ? ("Used") : " ");
				}
				for(new i = 1; i != MAX_WEAPON; i++) if(ammoData[playerid][i][ammoExists]) {
					format(weaponstr, sizeof(weaponstr), "%s"COL_WHITE"Magazine: %s - %d bullet's %s\n", weaponstr, ReturnWeaponName(ammoData[playerid][i][ammoWeapon]), ammoData[playerid][i][ammoAmount], ammoData[playerid][i][ammoUsing] ? ("Used") : " ");
				}
				if(strlen(weaponstr)) Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Weapon Inventory", weaponstr, "Close", "");
				else SendErrorMessage(playerid, "Weapon inventory kosong.");
			}
		}
	}
	return 1;
}

Dialog:MyWeapons(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = ListedWeapon[playerid][listitem],
			weapon[MAX_WEAPON * 64],
			count = 0;

		if(g_aWeaponSlots[weaponData[playerid][id][weaponModel]] == 1)
		{
			SelectWeapon[playerid] = id;

			weaponData[playerid][id][weaponUsing] = true;

			GivePlayerWeapon(playerid, weaponData[playerid][id][weaponModel], 1);
			SendCustomMessage(playerid, "WEAPON", "Kamu telah mengambil %s dari dalam inventory.", ReturnWeaponName(weaponData[playerid][SelectWeapon[playerid]][weaponModel]));
			return 1;
		}

		format(weapon, sizeof(weapon), "Ammo Magazine\tAmmo\n");
		for(new i = 1; i != MAX_WEAPON; i++) if(ammoData[playerid][i][ammoExists]) {
			if(ammoData[playerid][i][ammoWeapon] == weaponData[playerid][id][weaponModel]) {
				format(weapon, sizeof(weapon), "%s%s\t%d bullets\n", weapon, ReturnWeaponName(ammoData[playerid][i][ammoWeapon]), ammoData[playerid][i][ammoAmount]);
				ListedAmmo[playerid][count++] = i;
			}
		}
		strcat(weapon, "Remove Weapon Item");
		Dialog_Show(playerid, ManageWeapon, DIALOG_STYLE_TABLIST_HEADERS, "Manage Weapon Item", weapon, "Select", "Back");

		SelectWeapon[playerid] = id;
	}
	return 1;
}

Dialog:RemoveWeapon(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = SelectWeapon[playerid];

		SendServerMessage(playerid, "Kamu telah menghapus %s dari inventorymu.", ReturnWeaponName(weaponData[playerid][id][weaponModel]));
		RemoveWeaponItem(playerid, id);

		SelectWeapon[playerid] = 0;
	}
	return 1;
}

Dialog:ManageWeapon(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!strcmp(inputtext, "Remove Weapon Item", true))
		{
			new id = SelectWeapon[playerid];
			Dialog_Show(playerid, RemoveWeapon, DIALOG_STYLE_MSGBOX, "Remove Weapon Item", "Kamu yakin ingin menghapus senjata ini dari inventory kamu?\n\nNama Senjata: %s\nKetahanan: %d\n\nNOTE: Tidak ada pengembalian untuk item yang di hilangkan, pilih \"yes\" untuk menghapus item.", "Yes", "No", 
				ReturnWeaponName(weaponData[playerid][id][weaponModel]),
				weaponData[playerid][id][weaponDurability]
			);
			return 1;
		}

		new id = ListedAmmo[playerid][listitem];

		SelectAmmo[playerid] = id;

		weaponData[playerid][SelectWeapon[playerid]][weaponUsing] = true;
		ammoData[playerid][SelectAmmo[playerid]][ammoUsing] = true;

		GivePlayerWeapon(playerid, weaponData[playerid][SelectWeapon[playerid]][weaponModel], 99999);

		UpdateAmmo(playerid, sprintf("%d", ammoData[playerid][SelectAmmo[playerid]][ammoAmount]));
		SendCustomMessage(playerid, "WEAPON", "Kamu telah mengambil %s dengan %d amunisi dari dalam inventory.", ReturnWeaponName(weaponData[playerid][SelectWeapon[playerid]][weaponModel]), ammoData[playerid][SelectAmmo[playerid]][ammoAmount]);
	}
	else {
		SelectWeapon[playerid] = 0;
		cmd_myweapons(playerid, "\1");
	}
	return 1;
}

ptask WeaponTimerUpdate[1000](playerid)
{
	if(!SQL_IsLogged(playerid))  return 0;
	if(IsPlayerInEvent(playerid))  return 0;

	if(PlayerData[playerid][pLogged] && IsPlayerSpawned(playerid))
    {
    	if(GetPlayerWeapon(playerid) != 0 && SelectWeapon[playerid] && GetPlayerWeapon(playerid) == weaponData[playerid][SelectWeapon[playerid]][weaponModel]) {
    		UpdateAmmo(playerid, sprintf("%d", ammoData[playerid][SelectAmmo[playerid]][ammoAmount]));
	    	return 1;
	    }
		UpdateAmmo(playerid, "_");

 /*       if(GetPlayerWeapon(playerid) != PlayerData[playerid][pWeapon])
        {
            PlayerData[playerid][pWeapon] = GetPlayerWeapon(playerid);

            for(new i = 1; i != MAX_WEAPON; i++) if(weaponData[playerid][i][weaponExists] && weaponData[playerid][i][weaponUsing] && weaponData[playerid][i][weaponModel] == PlayerData[playerid][pWeapon]) {
            	return 1;
            }
            SendAdminMessage(COLOR_LIGHTRED, "[ANTICHEAT]: %s (%d) has possibly used weapon hacks (%s).", ReturnName(playerid, 0), playerid, ReturnWeaponName(PlayerData[playerid][pWeapon]));
            ResetWeapon(playerid, PlayerData[playerid][pWeapon]);
            PlayerData[playerid][pWeapon] = 0;
        }*/
    } 
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(GetPlayerWeapon(playerid) && SelectWeapon[playerid])
	{
		if(weaponid == weaponData[playerid][SelectWeapon[playerid]][weaponModel]) 
		{
			if(--weaponData[playerid][SelectWeapon[playerid]][weaponDurability] == 0)
			{
				SendCustomMessage(playerid, "WEAPON","Durablity %s kamu sudah melebihi batas, item senjata di hapus secara otomatis.", ReturnWeaponName(weaponData[playerid][SelectWeapon[playerid]][weaponModel]));
				RemoveWeaponInSlot(playerid, g_aWeaponSlots[weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]]);
				RemoveWeaponItem(playerid, SelectWeapon[playerid]);

				SelectWeapon[playerid] = 0;
				SelectAmmo[playerid] = 0;
				return 1;
			}

			ammoData[playerid][SelectAmmo[playerid]][ammoAmount] --;

			UpdateAmmo(playerid, sprintf("%d", ammoData[playerid][SelectAmmo[playerid]][ammoAmount]));

			if(ammoData[playerid][SelectAmmo[playerid]][ammoAmount] == 0) {
				UpdateAmmo(playerid, "_");
				
				RemoveWeaponInSlot(playerid, g_aWeaponSlots[weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]]);
				HoldWeapon(playerid, weaponData[playerid][SelectWeapon[playerid]][weaponModel]);

				RemoveAmmoItem(playerid, SelectAmmo[playerid]);
				
				SelectAmmo[playerid] = 0;
				AmmoReload[playerid] = true;

				SendCustomMessage(playerid, "WEAPON","Kamu kehabisan peluru, gunakan "COL_LIGHTRED"\"~k~~CONVERSATION_YES~\" "COL_WHITE"untuk reload senjata ini.");
				return 1;
			}
		}
	}
	#if defined weap_OnPlayerWeaponShot
		return weap_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif

#define OnPlayerWeaponShot weap_OnPlayerWeaponShot
#if defined weap_OnPlayerWeaponShot
	forward weap_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerSpawned(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER){
			ReloadAmmo(playerid);
		}
	}
	#if defined weap_OnPlayerKeyStateChange
		return weap_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange weap_OnPlayerKeyStateChange
#if defined weap_OnPlayerKeyStateChange
	forward weap_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif