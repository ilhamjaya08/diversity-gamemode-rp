CMD:weapons(playerid, params[]) 
{
	ShowPlayerWeapon(playerid, playerid);
	return 1;
}

CMD:weapon(playerid, params[]) 
{
/*	if(PlayerData[playerid][pInjured])
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak bisa menggunakan perintah ini ketika injured.");*/

    if(PlayerData[playerid][pHospitalTime])
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak bisa menggunakan perintah ini ketika dalam masa pemulihan.");

	if(IsPlayerDuty(playerid))
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak bisa menggunakan perintah ini ketika on duty.");

	new category[32], string[32];

	if(sscanf(params, "s[32]S()[32]", category, string))
		return SendSyntaxMessage(playerid, "/weapon [give/view/acceptview/scrap/destroy]");

	if(!strcmp(category, "give"))
	{
		new userid;

		if(sscanf(string, "u", userid))
			return SendSyntaxMessage(playerid, "/weapon give [userid]");

		if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tidak login atau tidak berada didekatmu.");

		if(PlayerData[userid][pScore] < 2)
			return SendErrorMessage(playerid, "They must level 2 to use this.");

		if(IsPlayerInAnyVehicle(userid))
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tersebut harus turun terlebih dahulu dari kendaraan!.");
		selectedTarget[playerid] = userid;
		WeaponGivePlayer(playerid);
	}
	else if(!strcmp(category, "scrap"))
	{
		new weaponid, confirm[10] ;

		if(!IsPlayerInRangeOfPoint(playerid, 3.0, -50.3808,-232.8592,6.7646)) 
    	    return ShowPlayerFooter(playerid, "~g~INFO: ~w~Kamu tidak berada di blackmarket.");

		if(PlayerData[playerid][pInjured])
			return SendErrorMessage(playerid, "Kondisimu terluka, kamu tidak bisa scrap senjata ketika injured!");

		if(!(weaponid = GetWeapon(playerid)))
			return ShowPlayerFooter(playerid, "Kamu tidak memegang ~r~senjata ~w~apapun.");

		if(g_aWeaponSlots[weaponid] != 2 && g_aWeaponSlots[weaponid] != 3 && g_aWeaponSlots[weaponid] !=  4 && g_aWeaponSlots[weaponid] != 5 && g_aWeaponSlots[weaponid] != 6)
			return ShowPlayerFooter(playerid, "Senjata ini tidak dapat di ~r~scrap!.");

		if(sscanf(string, "s[10]", confirm)) {
			SendCustomMessage(playerid, "USAGE","/weapon scrap ['confirm']");
			SendCustomMessage(playerid, "INFO","Perintah ini untuk menggantikan senjata dan peluru menjadi material!");
			return 1;
		}

		if(!strcmp(confirm, "confirm"))
		{
			if(Inventory_Add(playerid, "Materials", 11746, floatround((ReturnWeaponMaterial(weaponid)/4))) == -1)
				return 1;

			SendCustomMessage(playerid, "WEAPON", "Berhasil melakukan scrap senjata "RED"%s "WHITE"menjadi "YELLOW"%d material(s)", ReturnWeaponName(weaponid), floatround((ReturnWeaponMaterial(weaponid)/4)));

			if(Inventory_Add(playerid, "Materials", 11746, floatround((PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]/2))) == -1)
				return 1;
			
			SendCustomMessage(playerid, "WEAPON", "Berhasil melakukan scrap "RED"%d aminisi "WHITE"menjadi "YELLOW"%d material(s)", PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo], floatround((PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_ammo]/2)));

			ResetWeaponID(playerid, weaponid);
		}
	}
	else if(!strcmp(category, "destroy"))
	{
		new weaponid, confirm[10];

		if((weaponid = GetWeapon(playerid)) == 0)
			return ShowPlayerFooter(playerid, "Kamu tidak memegang senjata apapun.");

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
		new userid;

		if(sscanf(string, "u", userid))
			return SendSyntaxMessage(playerid, "/weapon view [playerid/PartOfName]");

		if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) 
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tidak login atau tidak bedara didekatmu.");

		ShowPlayerWeapon(playerid, userid);		
		SendServerMessage(playerid, "Kamu memperlihatkan senjatamu kepada %s.", ReturnName(userid, 0, 1));
	}
	else SendSyntaxMessage(playerid, "/weapon [give/view/acceptview/scrap/destroy]");
	return 1;
}
CMD:repairgun(playerid, params[]) 
{
	new
		is_at_location = Location_IsPlayerAt(playerid, LOCATION_BLACKMARKET)
	;

	if(is_at_location < 1)
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Kamu tidak berada di blackmarket.");

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Turun dari kendaraan terlebih dahulu!");

	if(IsPlayerDuty(playerid)) 
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu sedang duty faction.");

	if(GetPlayerJob(playerid) != JOB_ARMS_DEALER)
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak bekerja sebagai arms dealer.");

	PlayerRepairWeapon(playerid);
	return 1;
}

CMD:craft(playerid, params[])
{
	new
		is_at_location = Location_IsPlayerAt(playerid, LOCATION_BLACKMARKET)
	;

	if(is_at_location < 1)
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Kamu tidak berada di blackmarket.");

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Turun dari kendaraan terlebih dahulu!");

	if(IsPlayerDuty(playerid)) 
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu sedang duty faction.");

	if(GetPlayerJob(playerid) != JOB_ARMS_DEALER)
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak bekerja sebagai arms dealer.");

	if(PlayerData[playerid][pScore] < 4)
		return SendErrorMessage(playerid, "They must level 2 to use this.");

	Dialog_Show(playerid, Crafting, DIALOG_STYLE_LIST, "Crafting", "Bobby Pin\t20 Materials", "Create", "Cancel");		
	return 1;
}

CMD:creategun(playerid, params[]) 
{
	new
		is_at_location = Location_IsPlayerAt(playerid, LOCATION_BLACKMARKET)
	;

	if(is_at_location < 1)
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Kamu tidak berada di blackmarket.");

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Turun dari kendaraan terlebih dahulu!");

	if(IsPlayerDuty(playerid)) 
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu sedang duty faction.");

	if(GetPlayerJob(playerid) != JOB_ARMS_DEALER)
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak bekerja sebagai arms dealer.");

	if(PlayerData[playerid][pScore] < 2)
		return SendErrorMessage(playerid, "They must level 2 to use this.");
		
	new string[300];

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

CMD:buymaterials(playerid, params[]) 
{
	new 
		amount,
		id,
		price = Economy_GetMaterialPrice(),
		total = 0
	;

	if((id = Job_NearestPoint(playerid)) != -1 && JobData[id][jobType] == JOB_ARMS_DEALER) 
	{   
		if(sscanf(params, "d", amount))
			return SendSyntaxMessage(playerid, "/buymaterials [jumlah (%s/mats)]", FormatNumber(price));

		if(amount < 0)
			return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Jumlah yang di masukkan tidak boleh kurang dari nol.");

		total = price * amount;

		if(GetMoney(playerid) < (total))
			return SendErrorMessage(playerid, "Uang yang kamu miliki kurang untuk membeli %d material (%s).", amount, FormatNumber(total));

		if((Inventory_Count(playerid, "Materials") + amount) > 10000)
			return SendErrorMessage(playerid, "Kamu hanya dapat membeli %d material.", (10000-Inventory_Count(playerid, "Materials")));

		if(Inventory_Add(playerid, "Materials", 11746, amount) == -1)
			return 1;

		SendServerMessage(playerid, "Berhasil membeli "YELLOW"%d material "WHITE"dengan total harga "GREEN"%s.", amount, FormatNumber((total)));
		GiveMoney(playerid, -(total));
	}
	else SendServerMessage(playerid, "Kamu tidak berada digudang penjualan material.");

	return 1;
}

CMD:checkserial(playerid, params[])
{
	new weaponid;
	if((weaponid = GetWeapon(playerid)) == 0) 
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memegang senjata apapun.");

	new 
		serial_number[15],
		serial_id[10],
		length = strlen(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_serial])
	;
	if(!strcmp(PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_serial], "0", true)) 
	{
		SendServerMessage(playerid, "Weapon Serial Number: "RED"None");
	}
	else
	{
		strmid(serial_number, PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_serial], 0, 4);
		strmid(serial_id, PlayerGuns[playerid][g_aWeaponSlots[weaponid]][weapon_serial], 4, length);
		SendServerMessage(playerid, "Weapon Serial Number: %s-%s", serial_number, serial_id);
	}
	return 1;
}
CMD:createammo(playerid, params[])
{
	new
		is_at_location = Location_IsPlayerAt(playerid, LOCATION_BLACKMARKET)
	;

	if(is_at_location < 1) 
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Kamu tidak berada di blackmarket.");

	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Turun dari kendaraan terlebih dahulu!");

	if(IsPlayerDuty(playerid)) 
		return ShowPlayerFooter(playerid, "~r~ERROR~w~Kamu sedang duty faction.");

	if(GetPlayerJob(playerid) != JOB_ARMS_DEALER)
		return ShowPlayerFooter(playerid, "~r~ERROR~w~Kamu tidak bekerja sebagai arms dealer.");

	if(!Inventory_HasItem(playerid, "Materials"))
		return ShowPlayerFooter(playerid, "~r~ERROR~w~Kamu tidak memiliki material.");

	new
		confirm[24],
		weaponid
	;

	if((weaponid = GetWeapon(playerid)) == 0) 
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memegang senjata apapun.");

	if(g_aWeaponSlots[weaponid] == 1)
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Senjata ini tidak memerlukan amunisi.");

	if(sscanf(params, "s[24]", confirm)) {
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

        if(PlayerHasWeapon(playerid, model))
			return SendErrorMessage(playerid, "You already have %s, /createammo to add more ammo.", ReturnWeaponName(model));

        if(PlayerHasWeaponInSlot(playerid, model))
        	return SendErrorMessage(playerid, "You already have weapon in the same slot.");

		GivePlayerWeaponEx(playerid, model, ((MaxGunAmmo[model] * 2)/10));
        Inventory_Remove(playerid, "Materials", material);
		SendCustomMessage(playerid, "WEAPON", "Berhasil membuat "RED"%s (%d ammo) "WHITE"dengan "YELLOW"%d material.", ReturnWeaponName(model), ((MaxGunAmmo[model] * 2)/10), material);
	}
	return 1;
}

Dialog:Crafting(playerid, response, listitem, inputtext[]) 
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				Dialog_Show(playerid, CraftQuantity, DIALOG_STYLE_INPUT, "Crafting Amount", "Quantity / Amount you want to craft for this item?", "Craft", "Cancel");
			}
		}
	}
	return 1;
}

Dialog:CraftQuantity(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new jumlah = (20*strval(inputtext));

		if(!(1 <= strval(inputtext) <= 20))
			return Dialog_Show(playerid, CraftQuantity, DIALOG_STYLE_INPUT, "Crafting Amount", WHITE"(ERROR): Jumlah hanya di batasi 1 sampai 20!\n\nBerapa banyak quantity yang akan kamu buat? "YELLOW"(minimal 1 lockpick - maximal 20)", "Craft", "Cancel");
		
		if(Inventory_Count(playerid, "Materials") < jumlah)
			return Dialog_Show(playerid, CraftQuantity, DIALOG_STYLE_INPUT, "Crafting Amount", WHITE"(ERROR): Materials kamu kurang!\n\nBerapa banyak quantity yang akan kamu buat? "YELLOW"(minimal 1 lockpick - maximal 20)", "Craft", "Cancel");

		if(Inventory_Count(playerid, "Bobby Pin") > 20)
			return Dialog_Show(playerid, CraftQuantity, DIALOG_STYLE_INPUT, "Crafting Amount", WHITE"(ERROR): Anda tidak bisa menampung bobby pin lebih dari 20!\n\nBerapa banyak quantity yang akan kamu buat? "YELLOW"(minimal 1 lockpick - maximal 20)", "Craft", "Cancel");

		if(Inventory_Add(playerid, "Bobby Pin", 11746, strval(inputtext)) != -1)
		{
			Inventory_Remove(playerid, "Materials", jumlah);
			SendServerMessage(playerid, "Sukses membuat %d bobby pin menggunakan %d materials", strval(inputtext), jumlah);
		}
	}
	return 1;
}