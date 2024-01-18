#include <YSI\y_hooks>


hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, "SELECT * FROM `dealership` ORDER BY `ID` ASC LIMIT "#MAX_DYNAMIC_DEALERSHIP";", "Dealership_Load", "");
}


// Callback
forward OnDealershipCreated(id);
public OnDealershipCreated(id)
{
	DealershipData[id][dealerID] = cache_insert_id();

	Dealership_Save(id);
	Dealership_Sync(id);
	return 1;
}

forward Dealership_Load();
public Dealership_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Dealership, i);

			DealershipData[i][dealerID] = cache_get_field_int(i, "ID");
			DealershipData[i][dealerLock] = !!cache_get_field_int(i, "Lock");
			DealershipData[i][dealerStock] = cache_get_field_int(i, "Stock");

        	cache_get_field_content(i, "Name", DealershipData[i][dealerName], 24);

			DealershipData[i][dealerPos][0] = cache_get_field_float(i, "PosX");
			DealershipData[i][dealerPos][1] = cache_get_field_float(i, "PosY");
			DealershipData[i][dealerPos][2] = cache_get_field_float(i, "PosZ");

			DealershipData[i][dealerSpawn][0] = cache_get_field_float(i, "SpawnX");
			DealershipData[i][dealerSpawn][1] = cache_get_field_float(i, "SpawnY");
			DealershipData[i][dealerSpawn][2] = cache_get_field_float(i, "SpawnZ");
			DealershipData[i][dealerSpawn][3] = cache_get_field_float(i, "SpawnRZ");

			Dealership_Sync(i);
		}
		printf("*** Loaded %d dealership.", cache_num_rows());
	}
	return 1;
}


// Function
Dealership_IsExists(id)
{
	if(Iter_Contains(Dealership, id))
		return 1;

	return 0;
}

Dealership_Add(playerid, const dealer_name[])
{
	static
		id;

	if((id = Iter_Free(Dealership)) != cellmin)
	{
		Iter_Add(Dealership, id);

		GetPlayerPos(playerid, DealershipData[id][dealerPos][0], DealershipData[id][dealerPos][1], DealershipData[id][dealerPos][2]);

		DealershipData[id][dealerSpawn][0] = DealershipData[id][dealerSpawn][1] = DealershipData[id][dealerSpawn][2] = DealershipData[id][dealerSpawn][3] = 0;

		format(DealershipData[id][dealerName], 24, dealer_name);

		DealershipData[id][dealerLock] = true;
		DealershipData[id][dealerStock] = 0;

		mysql_tquery(g_iHandle, "INSERT INTO `dealership`(`Stock`) VALUES('0');", "OnDealershipCreated", "d", id);
		return id;
	}
	return -1;
}

Dealership_Delete(id)
{
	if(Dealership_IsExists(id))
	{
		Iter_Remove(Dealership, id);

        mysql_tquery(g_iHandle, sprintf("DELETE FROM `dealership` WHERE `ID` = '%d';", DealershipData[id][dealerID]));
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `dealer_vehicles` WHERE `dealer_id` = '%d';", DealershipData[id][dealerID]));

		if(IsValidDynamic3DTextLabel(DealershipData[id][dealerLabel]))
			DestroyDynamic3DTextLabel(DealershipData[id][dealerLabel]);

		if(IsValidDynamicPickup(DealershipData[id][dealerPickup]))
			DestroyDynamicPickup(DealershipData[id][dealerPickup]);

		if(IsValidDynamicMapIcon(DealershipData[id][dealerMapIcon]))
			DestroyDynamicMapIcon(DealershipData[id][dealerMapIcon]);

		new tmp_DealershipData[E_DEALERSHIP_DATA];
		DealershipData[id] = tmp_DealershipData;

		DealershipData[id][dealerLabel] = Text3D:INVALID_STREAMER_ID;
		DealershipData[id][dealerPickup] = INVALID_STREAMER_ID;
		DealershipData[id][dealerMapIcon] = INVALID_STREAMER_ID;
	}
	return 1;
}

Dealership_Sync(id, bool:label = false)
{
	if(Dealership_IsExists(id))
	{
		if(IsValidDynamic3DTextLabel(DealershipData[id][dealerLabel]))
		{
			UpdateDynamic3DTextLabelText(DealershipData[id][dealerLabel], COLOR_CLIENT, sprintf("[%s Dealership]\n%s\n"WHITE"Perintah "YELLOW"'/buyvehicle'", DealershipData[id][dealerName], DealershipData[id][dealerLock] ? (""WHITE"Status: "RED"Locked") : (sprintf(""WHITE"Persediaan: "GREEN"%d kendaraan", DealershipData[id][dealerStock]))));

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealershipData[id][dealerLabel], E_STREAMER_X, DealershipData[id][dealerPos][0]);
        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealershipData[id][dealerLabel], E_STREAMER_Y, DealershipData[id][dealerPos][1]);
        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealershipData[id][dealerLabel], E_STREAMER_Z, DealershipData[id][dealerPos][2] + 0.5);
		}
		else DealershipData[id][dealerLabel] = CreateDynamic3DTextLabel(sprintf("[%s Dealership]\n%s\n"WHITE"Perintah "YELLOW"'/buyvehicle'", DealershipData[id][dealerName], DealershipData[id][dealerLock] ? (""WHITE"Status: "RED"Locked") : (sprintf(""WHITE"Persediaan: "GREEN"%d kendaraan", DealershipData[id][dealerStock]))), COLOR_CLIENT, DealershipData[id][dealerPos][0], DealershipData[id][dealerPos][1], DealershipData[id][dealerPos][2] + 0.5, 5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	
		if(!label)
		{
			if(IsValidDynamicPickup(DealershipData[id][dealerPickup]))
			{
				Streamer_SetFloatData(STREAMER_TYPE_PICKUP, DealershipData[id][dealerPickup], E_STREAMER_X, DealershipData[id][dealerPos][0]);
	        	Streamer_SetFloatData(STREAMER_TYPE_PICKUP, DealershipData[id][dealerPickup], E_STREAMER_Y, DealershipData[id][dealerPos][1]);
	        	Streamer_SetFloatData(STREAMER_TYPE_PICKUP, DealershipData[id][dealerPickup], E_STREAMER_Z, DealershipData[id][dealerPos][2]);
			}
			else DealershipData[id][dealerPickup] = CreateDynamicPickup(19133, 23, DealershipData[id][dealerPos][0], DealershipData[id][dealerPos][1], DealershipData[id][dealerPos][2], 0, 0);

			if(IsValidDynamicMapIcon(DealershipData[id][dealerMapIcon]))
			{
				Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, DealershipData[id][dealerMapIcon], E_STREAMER_X, DealershipData[id][dealerPos][0]);
	        	Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, DealershipData[id][dealerMapIcon], E_STREAMER_Y, DealershipData[id][dealerPos][1]);
	        	Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, DealershipData[id][dealerMapIcon], E_STREAMER_Z, DealershipData[id][dealerPos][2]);
			}
			else DealershipData[id][dealerMapIcon] = CreateDynamicMapIcon(DealershipData[id][dealerPos][0], DealershipData[id][dealerPos][1], DealershipData[id][dealerPos][2], 55, 10, 0, 0, -1, _, MAPICON_GLOBAL);
			
		}
	}
	return 1;
}

Dealership_Save(id, menu = DEALER_SAVE_ALL)
{
	if(Dealership_IsExists(id))
	{
		switch(menu)
		{
			case DEALER_SAVE_ALL:
			{
				new query[500];

				mysql_format(g_iHandle, query, sizeof(query), "UPDATE `dealership` SET `Name`='%s', `Lock`=%d, `Stock`=%d, PosX='%.2f', PosY='%.2f', PosZ='%.2f', spawnX='%.4f', spawnY='%.4f', spawnZ='%.4f', spawnRZ='%.4f' WHERE `ID`='%d';",
					SQL_ReturnEscaped(DealershipData[id][dealerName]),
					DealershipData[id][dealerLock],
					DealershipData[id][dealerStock],
					DealershipData[id][dealerPos][0],
					DealershipData[id][dealerPos][1],
					DealershipData[id][dealerPos][2],
					DealershipData[id][dealerSpawn][0],
					DealershipData[id][dealerSpawn][1],
					DealershipData[id][dealerSpawn][2],
					DealershipData[id][dealerSpawn][3],
					DealershipData[id][dealerID]
				);

				mysql_tquery(g_iHandle, query);
			}
			case DEALER_SAVE_POS:
			{
				mysql_tquery(g_iHandle, sprintf("UPDATE `dealership` SET PosX='%.2f', PosY='%.2f', PosZ='%.2f' WHERE `ID`='%d';",
					DealershipData[id][dealerPos][0],
					DealershipData[id][dealerPos][1],
					DealershipData[id][dealerPos][2],
					DealershipData[id][dealerID]
				));
			}
			case DEALER_SAVE_SPAWN:
			{
				mysql_tquery(g_iHandle, sprintf("UPDATE `dealership` SET SpawnX='%.4f', SpawnY='%.4f', SpawnZ='%.4f', SpawnRZ='%.4f' WHERE `ID`='%d';",
					DealershipData[id][dealerSpawn][0],
					DealershipData[id][dealerSpawn][1],
					DealershipData[id][dealerSpawn][2],
					DealershipData[id][dealerSpawn][3],
					DealershipData[id][dealerID]
				));
			}
			case DEALER_SAVE_NAME:
			{
				mysql_tquery(g_iHandle, sprintf("UPDATE `dealership` SET `Name`='%s' WHERE `ID`='%d';", SQL_ReturnEscaped(DealershipData[id][dealerName]), DealershipData[id][dealerID]));
			}
			case DEALER_SAVE_STOCK:
			{
				mysql_tquery(g_iHandle, sprintf("UPDATE `dealership` SET `Stock`='%d' WHERE `ID`='%d';", DealershipData[id][dealerStock], DealershipData[id][dealerID]));
			}
			case DEALER_SAVE_LOCK:
			{
				mysql_tquery(g_iHandle, sprintf("UPDATE `dealership` SET `Lock`='%d' WHERE `ID`='%d';", DealershipData[id][dealerLock], DealershipData[id][dealerID]));
			}
		}
	}
	return 1;
}

Dealership_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Dealership) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, DealershipData[i][dealerPos][0], DealershipData[i][dealerPos][1], DealershipData[i][dealerPos][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}


// Player Function
Dealership_Buy(playerid, index)
{
	new Cache:execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `dealer_vehicles` WHERE `dealer_id`='%d' LIMIT 10;", DealershipData[index][dealerID]));

	if(cache_num_rows())
	{
		new output[2048], model, price;

		for(new i = 0; i != cache_num_rows(); i++)
		{
			model = cache_get_field_int(i, "model");
			price = cache_get_field_int(i, "price");

	        strcat(output, sprintf("%i(0, 0, 40, 1.0, 1, 1)\t%s~n~~g~~h~%s\n", model, GetVehicleNameByModel(model), FormatNumber(price)));
	        gListedDealerVehiclePrice[playerid][i] = price;
		}

		SetPVarInt(playerid, "DealerIndex", DealershipData[index][dealerID]);
		SetPVarInt(playerid, "DealerID", index);
		ShowPlayerDialog(playerid, DIALOG_BUYVEHICLE, DIALOG_STYLE_PREVIEW_MODEL, "Vehicle Dealership", output, "Select", "Cancel");
	}
	else SendErrorMessage(playerid, "Tidak ada kendaraan pada dealer ini!");

	return cache_delete(execute);
}

Dealership_GPS(playerid)
{
	new output[500], count;

	strcat(output, "#ID\tName\n");

	foreach(new i : Dealership)
		strcat(output, sprintf("%d\t%s\n", i, DealershipData[i][dealerName])), count++;

	if(count) Dialog_Show(playerid, DealershipGPS, DIALOG_STYLE_TABLIST_HEADERS, "Dealership", output, "Track", "Close");
	else SendErrorMessage(playerid, "Tidak ada dealer yang dispawn!");

	return 1;
}

// Dialog response
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_BUYVEHICLE)
	{
		if(response)
		{
			new price = gListedDealerVehiclePrice[playerid][listitem];

			SetPVarInt(playerid, "DealerVehiclePrice", price);
			SetPVarInt(playerid, "DealerVehicleModel", strval(inputtext));

			Dialog_Show(playerid, BuyVehicle, DIALOG_STYLE_MSGBOX, "Buy Vehicle", WHITE"Apa kamu yakin ingin membeli: "CYAN"%s "GREEN"(%s)?", "Beli", "Tidak", GetVehicleNameByModel(strval(inputtext)), FormatNumber(price));
		}
		else
		{
			DeletePVar(playerid, "DealerIndex");
			DeletePVar(playerid, "DealerID");
		}
	}
}

Dialog:DeleteDealerVeh(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `dealer_vehicles` WHERE `model`='%d' AND `dealer_id`='%d';", strval(inputtext), GetPVarInt(playerid, "DealerIndex")));
		SendServerMessage(playerid, "Kendaraan "CYAN"%s "WHITE"telah "RED"dihapus "WHITE"dari dealer "YELLOW"(id: %d).", GetVehicleNameByModel(strval(inputtext)), GetPVarInt(playerid, "DealerID"));

		DeletePVar(playerid, "DealerIndex");
		DeletePVar(playerid, "DealerID");
	}
	return 1;
}

Dialog:BuyVehicle(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			index,
			id = GetPVarInt(playerid, "DealerID"), 
			price = GetPVarInt(playerid, "DealerVehiclePrice"), 
			model = GetPVarInt(playerid, "DealerVehicleModel"),
			housevehicleslot = House_CountVehicleSlot(playerid);

		if(GetMoney(playerid) < price)
			return ShowPlayerFooter(playerid, sprintf("Uang kamu kurang, butuh ~g~%s ~w~untuk membeli!", FormatNumber(price)), 3000, 1);

		if(IsVIPVehicle(model))
            return ShowPlayerFooter(playerid, "Ini kendaraan ~y~VIP~w~, tidak diperuntukkan dijual didalam dealer!", 3000, 1);

        if(!DealershipData[id][dealerStock])
            return ShowPlayerFooter(playerid, "Persediaan kendaraan didealer sudah ~r~habis~w~, kamu terlambat!", 3000, 1);

        if(DealershipData[id][dealerLock])
            return ShowPlayerFooter(playerid, "Dealer ~r~dinonaktifkan ~w~oleh admin sementara!", 3000, 1);

        if(GetPlayerVIPLevel(playerid) > 2)
        {
            if(Vehicle_PlayerTotalCount(playerid) >= MAX_VIP_VEHICLES+housevehicleslot)
                return ShowPlayerFooter(playerid, "Kendaraanmu sudah mencapai batas maksimal.", 3000, 1);
        }
        else
        {
            if(Vehicle_PlayerTotalCount(playerid) >= MAX_PLAYER_VEHICLES+housevehicleslot)
                return ShowPlayerFooter(playerid, "Kendaraanmu sudah mencapai batas maksimal.", 3000, 1);
        }

        if((index = Vehicle_Create(model, DealershipData[id][dealerSpawn][0], DealershipData[id][dealerSpawn][1], DealershipData[id][dealerSpawn][2], DealershipData[id][dealerSpawn][3], 1, 1)) != RETURN_INVALID_VEHICLE_ID)
        {
            // Fine money
            GiveMoney(playerid, -price, ECONOMY_ADD_SUPPLY, "bought vehicle from dealership");
            Vehicle_SetOwner(playerid, index);

            // Decrease stock
            DealershipData[id][dealerStock] --;
            Dealership_Sync(id, true);
			Dealership_Save(id, DEALER_SAVE_STOCK);

            // Reset Variables
            DeletePVar(playerid, "DealerID");
            DeletePVar(playerid, "DealerIndex");

            DeletePVar(playerid, "DealerVehiclePrice");
            DeletePVar(playerid, "DealerVehicleModel");

            // Send message
            SetPlayerWaypoint(playerid, "Vehicle Spawn", DealershipData[id][dealerSpawn][0],DealershipData[id][dealerSpawn][1],DealershipData[id][dealerSpawn][2]);
            SendServerMessage(playerid, "Sukses membeli kendaraan "YELLOW"%s "WHITE"seharga "GREEN"%s "WHITE"dari dealership.", GetVehicleNameByModel(model), FormatNumber(price));
            SendServerMessage(playerid, "Posisi kendaraan berada diposisi yang ditunjukkan pada tanda merah dimap.");
        }
        else SendErrorMessage(playerid, "Slot kendaraan server sudah mencapai batas maksimal!");
	}
	else ShowPlayerFooter(playerid, "Gagal membeli kendaraan!", 3000, 1);
	return 1;
}

Dialog:DealershipGPS(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index = strval(inputtext);

		if(Dealership_IsExists(index))
		{
			SetPlayerWaypoint(playerid, DealershipData[index][dealerName], DealershipData[index][dealerPos][0], DealershipData[index][dealerPos][1], DealershipData[index][dealerPos][2]);
	        ShowPlayerFooter(playerid, "Ikuti checkpoint di map!", 3000, 1);
		}
	}
	return 1;
}