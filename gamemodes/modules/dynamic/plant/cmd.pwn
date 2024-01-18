SSCANF:PlantMenu(string[]) 
{
 	if(!strcmp(string,"place",true)) return 1;
 	else if(!strcmp(string,"harvest",true)) return 2;
 	else if(!strcmp(string,"seize",true)) return 3;
 	return 0;
}

CMD:plant(playerid, params[])
{
	static index, action, nextParams[128];

	if(sscanf(params, "k<PlantMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/plant [place/harvest/seize]");

	switch(action)
	{
		case 1: // Place
		{
			if(PlayerData[playerid][pScore] < 5)
		        return SendErrorMessage(playerid, "Hanya level 5 keatas yang dapat menggunakan perintah ini!");

		    if(!IsPlayerInDynamicArea(playerid, tempatganja[0]) && !IsPlayerInDynamicArea(playerid, tempatganja[1]) &&
		        !IsPlayerInDynamicArea(playerid, tempatganja[2]) && !IsPlayerInDynamicArea(playerid, tempatganja[3]) &&
		        !IsPlayerInDynamicArea(playerid, tempatganja[4]) && !IsPlayerInDynamicArea(playerid, tempatganja[5]) &&
		        !IsPlayerInDynamicArea(playerid, tempatganja[6]))
		        return SendErrorMessage(playerid, "Kamu tidak berada diladang!");

		    if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
	            return SendErrorMessage(playerid, "Hanya bisa menanam di outdoor!.");

			new type;
	
			if(Plant_Nearest(playerid, 3) != -1)
				return ShowPlayerFooter(playerid, "Terlalu dekat dengan tanaman lain!");

			if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
		        return ShowPlayerFooter(playerid, "Jongkok untuk menanam (tekan ~g~'C' ~w~untuk jongkok).", 2000, 1);

			if(sscanf(nextParams, "d", type))
				return SendSyntaxMessage(playerid, "/plant place [type (0: weed, 1: cocaine, 2: heroin)]");

			if(!(0 <= type <= 2))
				return SendErrorMessage(playerid, "Type: 0: weed, 1: cocaine, 2: heroin.");

			switch(type)
			{
				case 0:
				{
					if(Inventory_Count(playerid, "Marijuana Seeds") < PLANT_SEEDS_AMOUNT)
			            return ShowPlayerFooter(playerid, "Kamu butuh ~g~"#PLANT_SEEDS_AMOUNT" marijuana seeds ~w~untuk menanam.", 2000, 1);
				}
				case 1:
				{
					if(Inventory_Count(playerid, "Cocaine Seeds") < PLANT_SEEDS_AMOUNT)
			            return ShowPlayerFooter(playerid, "Kamu butuh ~g~"#PLANT_SEEDS_AMOUNT" cocaine seeds ~w~untuk menanam.", 2000, 1);
				}
				case 2:
				{
					if(Inventory_Count(playerid, "Heroin Opium Seeds") < PLANT_SEEDS_AMOUNT)
			            return ShowPlayerFooter(playerid, "Kamu butuh ~g~"#PLANT_SEEDS_AMOUNT" heroin opium seeds~w~ untuk menanam.", 2000, 1);
				}
			}

			if((index = Plant_Create(playerid, (type+1))) != -1)
			{
				switch(type)
				{
					case 0: Inventory_Remove(playerid, "Marijuana Seeds", PLANT_SEEDS_AMOUNT);
					case 1: Inventory_Remove(playerid, "Cocaine Seeds", PLANT_SEEDS_AMOUNT);
					case 2: Inventory_Remove(playerid, "Heroin Opium Seeds", PLANT_SEEDS_AMOUNT);
				}

				cmd_bomb(playerid, "\0");
				SendServerMessage(playerid, "Sukses menanam "YELLOW"%s, "WHITE"tunggu "GREEN""#PLANT_HARVEST_TIME" menit "WHITE"untuk panen!", Plant_GetName(index));
			}
			else ShowPlayerFooter(playerid, "Tanaman sudah mencapai batas maksimal, coba lain waktu!", 2000, 1);
		}
		case 2: // Harvest
		{
			if(PlayerData[playerid][pScore] < 5)
		        return SendErrorMessage(playerid, "Hanya level 5 keatas yang dapat menggunakan perintah ini!");

		    if((index = GetPlayerNearestPlant(playerid)) != INVALID_PLANT_ID)
		    {
		    	if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
			        return ShowPlayerFooter(playerid, "Jongkok untuk memanen (tekan ~r~'C' ~w~untuk jongkok).", 2000, 1);

		    	if(Plant_GetTime(index))
		    		return ShowPlayerFooter(playerid, "Tanaman belum siap untuk ~y~dipanen!", 2000, 1);

			    if(GetPlayerHarvestingPlant(playerid))
			        return ShowPlayerFooter(playerid, "Kamu sedang ~g~memanen tanaman~w~, tunggu hingga ~r~selesai~w~ ...", 2000, 1);

			    if(PlantData[index][plantHarvest] != INVALID_PLANT_ID)
			    	return ShowPlayerFooter(playerid, "Tanaman ini sedang dipanen seseorang, coba tanaman lainnya!", 2000, 1);

			    SetPlayerHarvestingPlant(playerid, true);
			    SetPlayerHarvestingType(playerid, Plant_GetType(index));
			    SetPlayerHarvestingTime(playerid, PLANT_HARVEST_WAITING);

			    PlantData[index][plantHarvest] = GetPlayerSQLID(playerid);

				cmd_bomb(playerid, "\0");
			    SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s begins to harvest the drug plant.", ReturnName(playerid, 0));
		    }
		    else ShowPlayerFooter(playerid, "Kamu tidak berada dekat dengan tanaman!", 2000, 1);
		}
		case 3: // Delete
		{
			if(GetAdminLevel(playerid) < 8 && GetFactionType(playerid) != FACTION_POLICE)
		        return PermissionError(playerid);

		    if(GetAdminLevel(playerid) < 8 && GetFactionType(playerid) == FACTION_POLICE && !IsPlayerDuty(playerid))
		        return SendErrorMessage(playerid, "Duty terlebih dahulu!");

        	if((index = GetPlayerNearestPlant(playerid)) != INVALID_PLANT_ID)
		    {
		    	Plant_Delete(index);
    			SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has seized a %s plant.", ReturnName(playerid, 0, 1), Plant_GetName(index));
		    }
		    else ShowPlayerFooter(playerid, "Kamu tidak berada dekat dengan tanaman!", 2000, 1);
		}
		default: SendSyntaxMessage(playerid, "/plant [place/harvest/seize]");
	}
	return 1;
}