#include <YSI\y_hooks>

Dialog:eventWeapon(playerid, response, listitem, inputtext[])
{
	if(response) {
		SetPVarInt(playerid, "selectWeapon", listitem);
		Dialog_Show(playerid, editWeaponId, DIALOG_STYLE_INPUT, "Weapon Id", "Insert Weapon ID:", "Set", "Back");
	}
	return 1;
}

Dialog:editWeaponId(playerid, response, listitem, inputtext[])
{
	if(response) {
		new id = GetPVarInt(playerid, "selectWeapon");

		if(strval(inputtext) <= 0 || strval(inputtext) > 46 || (strval(inputtext) >= 19 && strval(inputtext) <= 21))
			return Dialog_Show(playerid, editWeaponId, DIALOG_STYLE_INPUT, "Weapon Id", "You have specified an invalid weapon!\n\nInsert Weapon ID:", "Set", "Back");

		EventData[eventWeapons][id] = strval(inputtext);
		Dialog_Show(playerid, editWeaponAmmo, DIALOG_STYLE_INPUT, "Weapon Ammo", "Insert the ammo for %s:", "Set", "Back", ReturnWeaponName(EventData[eventWeapons][id]));
	}
	else cmd_event(playerid, "weapon");
	return 1;
}

Dialog:editWeaponAmmo(playerid, response, listitem, inputtext[])
{
	if(response) {
		new id = GetPVarInt(playerid, "selectWeapon");

		if(strval(inputtext) < 1 || strval(inputtext) > 1000)
			return Dialog_Show(playerid, editWeaponId, DIALOG_STYLE_INPUT, "Weapon Id", "You have specified an invalid weapon ammo, 1 - 1,000!\n\nInsert the ammo for %s:", "Set", "Back", EventData[eventWeapons][id]);

		EventData[eventAmmo][id] = strval(inputtext);
		DeletePVar(playerid, "selectWeapon");

		cmd_event(playerid, "weapon");
	}
	else Dialog_Show(playerid, editWeaponId, DIALOG_STYLE_INPUT, "Weapon Id", "Insert Weapon ID:", "Set", "Back");
	return 1;
}

Dialog:eventType(playerid, response, listitem, inputtext[])
{
	if(response) 
	{
		EventData[eventType] = (listitem+1);

		if(EventData[eventType] == TYPE_TDM)
			Dialog_Show(playerid, eventTarget, DIALOG_STYLE_INPUT, "Target Score", "How much target:", "Set", "Back");

		if(EventData[eventType] == TYPE_JETPACK)
			Dialog_Show(playerid, eventBonus, DIALOG_STYLE_INPUT, "Event "GREEN"Bonus", "Masukkan berapa bonus yang akan di berikan:", "Set", "Back");

		if(EventData[eventType] == TYPE_DM)
			Dialog_Show(playerid, eventTarget, DIALOG_STYLE_INPUT, "Target Score", "How much target:", "Set", "Back");
	}
	return 1;
}

Dialog:eventTarget(playerid, response, listitem, inputtext[])
{
	if(response) 
	{
		if(strval(inputtext) < 1 || strval(inputtext) > 150)
			return Dialog_Show(playerid, eventTarget, DIALOG_STYLE_INPUT, "Target Score", "Target score must be betweed 1 - 150\n\nHow much target:", "Set", "Back");

		EventData[eventTarget] = strval(inputtext);

		if(EventData[eventType] == TYPE_TDM)
			Dialog_Show(playerid, eventSkin, DIALOG_STYLE_LIST, "Skin Event", "Team 1: %d\nTeam 2: %d\nNext", "Set", "Back", EventData[eventSkin][0], EventData[eventSkin][1]);
		else if(EventData[eventType] == TYPE_DM)
			Dialog_Show(playerid, eventHealth, DIALOG_STYLE_INPUT, "Event "RED"Health", "Masukkan value darah yang akan di berikan:", "Set", "Back");

	}
	else cmd_event(playerid, "create");
	return 1;
}

Dialog:eventSkin(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem)
		{
			case 0: Dialog_Show(playerid, eventSkin1, DIALOG_STYLE_INPUT, "Skin Team 1", "Masukkan id skin:", "Set", "Back");
			case 1: Dialog_Show(playerid, eventSkin2, DIALOG_STYLE_INPUT, "Skin Team 2", "Masukkan id skin:", "Set", "Back");
			case 2: 
			{
				if(!EventData[eventSkin][0] || !EventData[eventSkin][1])
					return Dialog_Show(playerid, eventSkin, DIALOG_STYLE_LIST, "Skin can't 0", "Team 1: %d\nTeam 2: %d\nNext", "Set", "Back", EventData[eventSkin][0], EventData[eventSkin][1]);

				Dialog_Show(playerid, eventHealth, DIALOG_STYLE_INPUT, "Event "RED"Health", "Masukkan value darah yang akan di berikan:", "Set", "Back");
			}
		}
	}
	else Dialog_Show(playerid, eventTarget, DIALOG_STYLE_INPUT, "Target Score", "How much target:", "Set", "Back");
	return 1;
}

Dialog:eventSkin1(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(strval(inputtext) < 1 || strval(inputtext) > 311)
			return Dialog_Show(playerid, eventSkin1, DIALOG_STYLE_INPUT, "Skin Team 1", "Id skin tidak sesuai\n\nMasukkan id skin:", "Set", "Back");

		EventData[eventSkin][0] = strval(inputtext);
		Dialog_Show(playerid, eventSkin, DIALOG_STYLE_LIST, "Skin Event", "Team 1: %d\nTeam 2: %d\nNext", "Set", "Back", EventData[eventSkin][0], EventData[eventSkin][1]);	
	}
	else Dialog_Show(playerid, eventSkin, DIALOG_STYLE_LIST, "Skin Event", "Team 1: %d\nTeam 2: %d\nNext", "Set", "Back", EventData[eventSkin][0], EventData[eventSkin][1]);
	return 1;
}

Dialog:eventSkin2(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(strval(inputtext) < 1 || strval(inputtext) > 311)
			return Dialog_Show(playerid, eventSkin2, DIALOG_STYLE_INPUT, "Skin Team 2", "Id skin tidak sesuai\n\nMasukkan id skin:", "Set", "Back");

		EventData[eventSkin][1] = strval(inputtext);
		Dialog_Show(playerid, eventSkin, DIALOG_STYLE_LIST, "Skin Event", "Team 1: %d\nTeam 2: %d\nNext", "Set", "Back", EventData[eventSkin][0], EventData[eventSkin][1]);	
	}
	else Dialog_Show(playerid, eventSkin, DIALOG_STYLE_LIST, "Skin Event", "Team 1: %d\nTeam 2: %d\nNext", "Set", "Back", EventData[eventSkin][0], EventData[eventSkin][1]);
	return 1;
}

Dialog:eventHealth(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(strval(inputtext) < 1 || strval(inputtext) > 100)
			return Dialog_Show(playerid, eventHealth, DIALOG_STYLE_INPUT, "Event "RED"Health", "Health must between 0 - 100\n\nMasukkan value darah yang akan di berikan:", "Set", "Back");

		EventData[eventHealth] = floatstr(inputtext);
		Dialog_Show(playerid, eventArmor, DIALOG_STYLE_INPUT, "Event "WHITE"Armor", "Masukkan value darah putih:", "Set", "Back");

	}
	else 
	{
		if(EventData[eventType] == TYPE_TDM)
			Dialog_Show(playerid, eventSkin, DIALOG_STYLE_LIST, "Skin Event", "Team 1: %d\nTeam 2: %d\nNext", "Set", "Back", EventData[eventSkin][0], EventData[eventSkin][1]);
		else if(EventData[eventType] == TYPE_DM)
			Dialog_Show(playerid, eventHealth, DIALOG_STYLE_INPUT, "Event "RED"Health", "Masukkan value darah yang akan di berikan:", "Set", "Back");
	}
	return 1;
}

Dialog:eventArmor(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(strval(inputtext) < 1 || strval(inputtext) > 100)
			return Dialog_Show(playerid, eventArmor, DIALOG_STYLE_INPUT, "Event "WHITE"Armor", "Darah putih harus berada di antara 0 - 100\n\nMasukkan value darah putih:", "Set", "Back");

		EventData[eventArmor] = floatstr(inputtext);
		Dialog_Show(playerid, eventBonus, DIALOG_STYLE_INPUT, "Event "GREEN"Bonus", "Masukkan berapa bonus yang akan di berikan:", "Set", "Back");
	}
	else Dialog_Show(playerid, eventHealth, DIALOG_STYLE_LIST, "Event "RED"Health", "Masukkan value darah yang akan di berikan:", "Set", "Back");
	return 1;
}

Dialog:eventBonus(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(strval(inputtext) < 1 || strval(inputtext) > 1000)
			return Dialog_Show(playerid, eventBonus, DIALOG_STYLE_INPUT, "Event "GREEN"Bonus", "Value bonus harus di antara 0 - 1,000\n\nMasukkan berapa bonus yang akan di berikan:", "Set", "Back");

		EventData[eventBonus] = strval(inputtext);

		if(EventData[eventType] == TYPE_TDM)
		{
			Dialog_Show(playerid, eventFinal, DIALOG_STYLE_LIST, "Event Information", "Score Target\t"YELLOW"%d"WHITE"\nSkin Team 1\t"YELLOW"%d"WHITE"\nSkin Team 2\t"YELLOW"%d"WHITE"\nHealth Spawn\t"YELLOW"%.1f"WHITE"\nArmor Spawn\t"YELLOW"%.1f\n"WHITE"Event Bonus\t"GREEN"%s", "Start", "Back", 
				EventData[eventTarget],
				EventData[eventSkin][0],
				EventData[eventSkin][1],
				EventData[eventHealth],
				EventData[eventArmor],
				FormatNumber(EventData[eventBonus])
			);
		}

		if(EventData[eventType] == TYPE_JETPACK)
			Dialog_Show(playerid, jetpackLoc, DIALOG_STYLE_LIST, "Jetpack Location", "Los Santos\nSan Fierro\nLas Venturas", "Select", "Back");

		if(EventData[eventType] == TYPE_DM)
		{
			Dialog_Show(playerid, eventFinal, DIALOG_STYLE_LIST, "Event Information", "Score Target\t"YELLOW"%d"WHITE"\nHealth Spawn\t"YELLOW"%.1f"WHITE"\nArmor Spawn\t"YELLOW"%.1f\n"WHITE"Event Bonus\t"GREEN"%s", "Start", "Back", 
				EventData[eventTarget],
				EventData[eventHealth],
				EventData[eventArmor],
				FormatNumber(EventData[eventBonus])
			);
		}
	}
	else 
	{
		if(EventData[eventType] == TYPE_TDM) 
			Dialog_Show(playerid, eventHealth, DIALOG_STYLE_INPUT, "Event "RED"Health", "Masukkan value darah yang akan di berikan:", "Set", "Back");
		else if(EventData[eventType] == TYPE_DM)
			Dialog_Show(playerid, eventHealth, DIALOG_STYLE_INPUT, "Event "RED"Health", "Masukkan value darah yang akan di berikan:", "Set", "Back");
		else Dialog_Show(playerid, eventType, DIALOG_STYLE_LIST, "Event Type", "TDM\nJetpack\nDM", "Select", "Close");
	}
	return 1;
}

Dialog:jetpackLoc(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0: SetPlayerPosEx(playerid,725.12,-1460.74,22.21); 
			case 1: SetPlayerPosEx(playerid, -1513.53,-397.74,7.07);
			case 2: SetPlayerPosEx(playerid, 1749.01, 2318.74, 22.82);
		}
		EventData[eventInt] = GetPlayerInterior(playerid);
		EventData[eventWorld] = GetPlayerVirtualWorld(playerid);

		SetPlayerInterior(playerid, EventData[eventInt]);
		SetPlayerVirtualWorld(playerid, EventData[eventWorld]);

		EventData[eventJetpackType] = (listitem+1);
		ShowPlayerFooter(playerid, "~b~[INFO]~n~~w~Kamu di tempatkan di spawn jetpack pertama.");

		new loc[13];

		switch(EventData[eventJetpackType])
		{
			case 1: loc = "Los Santos";
			case 2: loc = "San Fierro";
			case 3: loc = "Las Venturas";
		}

		Dialog_Show(playerid, eventFinal, DIALOG_STYLE_LIST, "Event Information", "Event Type\t"YELLOW"Jetpack"WHITE"\nEvent Location\t"YELLOW"%s"WHITE"\nEvent Bonus\t"GREEN"%s", "Start", "Back", 
			loc,
			FormatNumber(EventData[eventBonus])
		);
	}
	else Dialog_Show(playerid, eventBonus, DIALOG_STYLE_INPUT, "Event "GREEN"Bonus", ""COL_GREEN"Pada event jetpack, bonus hanya untuk partisipasi, bonus pemenang di beri admin secara manual\n\n"WHITE"Masukkan berapa bonus yang akan di berikan:", "Set", "Back");
	return 1;
}

Dialog:eventFinal(playerid, response, listitem, inputtext[])
{
	if(response) {
		EventData[eventCreated] = 1;
		EventData[eventWorld] = GetPlayerVirtualWorld(playerid);
		EventData[eventInt] = GetPlayerInterior(playerid);

		SendServerMessage(playerid, "You've create the event, /event open to open the event.");
	}
	else Dialog_Show(playerid, eventBonus, DIALOG_STYLE_INPUT, "Event "GREEN"Bonus", "Masukkan berapa bonus yang akan di berikan:", "Set", "Back");
	return 1;
}