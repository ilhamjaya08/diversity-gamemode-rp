forward OnRentalCreated(rental_id);
public OnRentalCreated(rental_id)
{
	RentalData[rental_id][rentIndex] = cache_insert_id();

	Rental_Sync(rental_id);
	Rental_Save(rental_id);
	return 1;
}

forward Rental_Load();
public Rental_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(RentalPoints, i);

	        RentalData[i][rentIndex] = cache_get_field_int(i, "ID");

	        RentalData[i][rentPosX] = cache_get_field_float(i, "PosX");
	        RentalData[i][rentPosY] = cache_get_field_float(i, "PosY");
	        RentalData[i][rentPosZ] = cache_get_field_float(i, "PosZ");

	        RentalData[i][rentSpawnX] = cache_get_field_float(i, "SpawnX");
	        RentalData[i][rentSpawnY] = cache_get_field_float(i, "SpawnY");
	        RentalData[i][rentSpawnZ] = cache_get_field_float(i, "SpawnZ");
	        RentalData[i][rentSpawnRZ] = cache_get_field_float(i, "SpawnRZ");

	        Rental_Sync(i);
		}
        printf("*** Loaded %d rental points.", cache_num_rows());
    }
	return 1;
}

hook OnGameModeInitEx()
{
	mysql_tquery(g_iHandle, "SELECT * FROM `rentals` ORDER BY `ID` ASC LIMIT "#MAX_DYNAMIC_RENTAL";", "Rental_Load", "");
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_RENTVEH)
	{
		if(response)
		{
			new model = rental_vehicles_model[playerid][listitem],
				price = rental_vehicles_price[playerid][listitem];

			SetPVarInt(playerid, "RentalModel", model);
			SetPVarInt(playerid, "RentalPrice", price);

			Dialog_Show(playerid, RentalVehicleTime, DIALOG_STYLE_INPUT, "Rental Duration", WHITE"Model: "CYAN"%s\n"WHITE"Harga: "GREEN"%s/jam\n\n"WHITE"Masukkan berapa jam yang akan anda sewa? (batasan maksimal 3 jam)", "Rental", "Close", GetVehicleNameByModel(model), FormatNumber(price));
		}
	}
}


Rental_Create(Float:x, Float:y, Float:z)
{
	static rental_id;

	if((rental_id = Iter_Free(RentalPoints)) != cellmin)
	{
		Iter_Add(RentalPoints, rental_id);

		RentalData[rental_id][rentPosX] = x;
		RentalData[rental_id][rentPosY] = y;
		RentalData[rental_id][rentPosZ] = z;

		RentalData[rental_id][rentSpawnX] = 0;
		RentalData[rental_id][rentSpawnY] = 0;
		RentalData[rental_id][rentSpawnZ] = 0;
		RentalData[rental_id][rentSpawnRZ] = 0;

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `rentals` (`PosX`) VALUES ('%.3f');", x), "OnRentalCreated", "d", rental_id);
		return rental_id;
	}
	return -1;
}

Rental_Delete(rental_id)
{
	if(Rental_Exists(rental_id))
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `rentals` WHERE `ID`='%d';", RentalData[rental_id][rentIndex]));
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `rental_vehicles` WHERE `rental_id`='%d';", RentalData[rental_id][rentIndex]));

		DestroyDynamicPickup(RentalData[rental_id][rentPickup]);
		DestroyDynamic3DTextLabel(RentalData[rental_id][rentLabel]);

		new tmp_RentalData[ENUM_RENTAL_DATA];
		RentalData[rental_id] = tmp_RentalData;

		RentalData[rental_id][rentLabel] = Text3D:INVALID_STREAMER_ID;
		RentalData[rental_id][rentPickup] = INVALID_STREAMER_ID;

		Iter_Remove(RentalPoints, rental_id);
		return 1;
	}
	return 0;
}

Rental_Save(rental_id)
{
	if(Rental_Exists(rental_id))
	{
		new query[500];

		mysql_format(g_iHandle, query, sizeof(query), "UPDATE `rentals` SET `PosX`='%.3f',`PosY`='%.3f',`PosZ`='%.3f',`SpawnX`='%.3f',`SpawnY`='%.3f',`SpawnZ`='%.3f',`SpawnRZ`='%.3f' WHERE `ID`='%d';",
			RentalData[rental_id][rentPosX],
			RentalData[rental_id][rentPosY],
			RentalData[rental_id][rentPosZ],
			RentalData[rental_id][rentSpawnX],
			RentalData[rental_id][rentSpawnY],
			RentalData[rental_id][rentSpawnZ],
			RentalData[rental_id][rentSpawnRZ],
			RentalData[rental_id][rentIndex]
		);

		return mysql_tquery(g_iHandle, query);
	}
	return 0;
}

Rental_Exists(rental_id)
{
	if(Iter_Contains(RentalPoints, rental_id))
		return 1;

	return 0;
}

Rental_Sync(rental_id)
{
	if(Rental_Exists(rental_id))
	{
		if(IsValidDynamicPickup(RentalData[rental_id][rentPickup])) {
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, RentalData[rental_id][rentPickup], E_STREAMER_X, RentalData[rental_id][rentPosX]);
    		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, RentalData[rental_id][rentPickup], E_STREAMER_Y, RentalData[rental_id][rentPosY]);
    		Streamer_SetFloatData(STREAMER_TYPE_PICKUP, RentalData[rental_id][rentPickup], E_STREAMER_Z, RentalData[rental_id][rentPosZ]);
		}
		else RentalData[rental_id][rentPickup] = CreateDynamicPickup(1239, 23, RentalData[rental_id][rentPosX], RentalData[rental_id][rentPosY], RentalData[rental_id][rentPosZ], 0, 0);

    	if(IsValidDynamic3DTextLabel(RentalData[rental_id][rentLabel])) {
    		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, RentalData[rental_id][rentLabel], E_STREAMER_X, RentalData[rental_id][rentPosX]);
    		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, RentalData[rental_id][rentLabel], E_STREAMER_Y, RentalData[rental_id][rentPosY]);
    		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, RentalData[rental_id][rentLabel], E_STREAMER_Z, RentalData[rental_id][rentPosZ] + 0.5);

    		UpdateDynamic3DTextLabelText(RentalData[rental_id][rentLabel], COLOR_CLIENT, sprintf("[Rental Point (%d)]\n"WHITE"Gunakan "YELLOW"/renthelp"WHITE" untuk bantuan", rental_id));
    	}
    	else RentalData[rental_id][rentLabel] = CreateDynamic3DTextLabel(sprintf("[Rental Point (%d)]\n"WHITE"Gunakan "YELLOW"/renthelp"WHITE" untuk bantuan", rental_id), COLOR_CLIENT, RentalData[rental_id][rentPosX], RentalData[rental_id][rentPosY], RentalData[rental_id][rentPosZ]+0.5, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);

    	return 1;
	}
	return 0;
}

Rental_Nearest(playerid, Float:range = 5.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : RentalPoints) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, RentalData[i][rentPosX], RentalData[i][rentPosY], RentalData[i][rentPosZ]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}


// Dialog
Dialog:DeleteRentalVeh(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `rental_vehicles` WHERE `model`='%d' AND `rental_id`='%d';", strval(inputtext), GetPVarInt(playerid, "RentalIndex")));
		SendServerMessage(playerid, "Kendaraan "CYAN"%s "WHITE"telah "RED"dihapus "WHITE"dari rental "YELLOW"(id: %d).", GetVehicleNameByModel(strval(inputtext)), GetPVarInt(playerid, "RentalID"));

		DeletePVar(playerid, "RentalIndex");
		DeletePVar(playerid, "RentalID");
	}
	return 1;
}

Dialog:RentalVehicleTime(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new vehicle_index,
			count,
			model = GetPVarInt(playerid, "RentalModel"),
			price = GetPVarInt(playerid, "RentalPrice"),
			rental_id = GetPVarInt(playerid, "RentalID");

		if(!(0 < strval(inputtext) <= 3))
			return Dialog_Show(playerid, RentalVehicleTime, DIALOG_STYLE_INPUT, "Rental Duration", WHITE"(error) Durasi hanya dibatasi mulai dari 1 sampai 3 jam\n\nModel: "CYAN"%s\n"WHITE"Harga: "GREEN"%s/jam\n\n"WHITE"Masukkan berapa jam yang akan anda sewa? (batasan maksimal 3 jam)", "Rental", "Close", GetVehicleNameByModel(model), FormatNumber(price));

		if(GetMoney(playerid) < (price*strval(inputtext)))
			return SendErrorMessage(playerid, "Uang tidak mencukupi %d x %s total: %s", strval(inputtext), FormatNumber(price), FormatNumber(price*strval(inputtext)));
       	
		foreach(new i : Player)
        {
            if(PlayerData[i][pJobDuty] && PlayerData[i][pJob] == JOB_TAXI)
            {
                count++;
                if(IsVehicleHasTireNotTruck(model))
                    return SendClientMessageEx(playerid, COLOR_WHITE, "There are %d Taxi on duty, go call them instead of using a rental!", count);
            }
        }

		if((vehicle_index = Vehicle_Create(model, RentalData[rental_id][rentSpawnX], RentalData[rental_id][rentSpawnY], RentalData[rental_id][rentSpawnZ], RentalData[rental_id][rentSpawnRZ], 12, 12, true, ""OLIVE_DRAB"RENTAL")) != RETURN_INVALID_VEHICLE_ID) {
			GiveMoney(playerid, -(price * strval(inputtext)), ECONOMY_ADD_SUPPLY, "rent vehicle");
			Vehicle_SetRentalOwned(playerid, vehicle_index);
			Vehicle_SetRentTime(vehicle_index, strval(inputtext) * (3600));
			SendServerMessage(playerid, "Kamu telah menyewa "CYAN"%s "WHITE"selama "YELLOW"%d jam!", GetVehicleNameByModel(model), strval(inputtext));
		}
		else SendErrorMessage(playerid, "Slot kendaraan sudah mencapai batas maksimal, tidak dapat menyewa lagi!");
	}
	return 1;
}