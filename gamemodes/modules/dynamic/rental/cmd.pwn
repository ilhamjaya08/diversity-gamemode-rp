SSCANF:RentalMenu(string[]) 
{
 	if(!strcmp(string,"create",true)) return 1;
 	else if(!strcmp(string,"make",true)) return 1;
 	else if(!strcmp(string,"delete",true)) return 2;
 	else if(!strcmp(string,"remove",true)) return 2;
 	else if(!strcmp(string,"destroy",true)) return 2;
 	else if(!strcmp(string,"position",true)) return 3;
 	else if(!strcmp(string,"pos",true)) return 3;
 	else if(!strcmp(string,"spawn",true)) return 4;
 	else if(!strcmp(string,"addveh",true)) return 5;
 	else if(!strcmp(string,"deleteveh",true)) return 6;
 	return 0;
}

CMD:rm(playerid, params[])
	return cmd_rentalmenu(playerid, params);

CMD:rentalmenu(playerid, params[])
{
	static
		rental_id, action, nextParams[128],
		Float:x, Float:y, Float:z
	;

	if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

	if(sscanf(params, "k<RentalMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/rentalmenu [create/delete/position/spawn/addveh/deleteveh]");

	switch(action)
	{
		case 1: // Create
		{
			GetPlayerPos(playerid, x, y, z);
			if((rental_id = Rental_Create(x, y, z)) != -1)
			{
				SendServerMessage(playerid, "Sukses membuat rental point "YELLOW"(id: %d)", rental_id);
			}
			else SendErrorMessage(playerid, "Rental point sudah mencapai batas maksimal "LIGHTBLUE"(%d points)", MAX_DYNAMIC_RENTAL);
		}
		case 2: // Delete
		{
			if(sscanf(nextParams, "d", rental_id))
				return SendSyntaxMessage(playerid, "/rentalmenu delete [rental id]");

			if(!Rental_Exists(rental_id))
				return SendErrorMessage(playerid, "Rental point tidak terdaftar!");

			Rental_Delete(rental_id);
			SendServerMessage(playerid, "Kamu telah "LIGHTBLUE"menghapus "WHITE"rental point "RED"(id: %d)", rental_id);
		}
		case 3: // Position
		{
			if(sscanf(nextParams, "d", rental_id))
				return SendSyntaxMessage(playerid, "/rentalmenu position [rental id]");

			if(!Rental_Exists(rental_id))
				return SendErrorMessage(playerid, "Rental point tidak terdaftar!");

			GetPlayerPos(playerid, RentalData[rental_id][rentPosX], RentalData[rental_id][rentPosY], RentalData[rental_id][rentPosZ]);

			Rental_Sync(rental_id);
			Rental_Save(rental_id);

			SendServerMessage(playerid, "Kamu telah mengubah "LIGHTBLUE"posisi "WHITE"rental point "YELLOW"(id: %d)", rental_id);
		}
		case 4: // Spawn
		{
			if(sscanf(nextParams, "d", rental_id))
				return SendSyntaxMessage(playerid, "/rentalmenu spawn [rental id]");

			if(!Rental_Exists(rental_id))
				return SendErrorMessage(playerid, "Rental point tidak terdaftar!");

			GetPlayerPos(playerid, RentalData[rental_id][rentSpawnX], RentalData[rental_id][rentSpawnY], RentalData[rental_id][rentSpawnZ]);
			GetPlayerFacingAngle(playerid, RentalData[rental_id][rentSpawnRZ]);
			Rental_Save(rental_id);

			SendServerMessage(playerid, "Kamu telah mengubah "LIGHTBLUE"posisi spawn "WHITE"rental point "YELLOW"(id: %d)", rental_id);
		}
		case 5: // Addveh
		{
			new model[32], price;

			if(sscanf(nextParams, "ds[32]d", rental_id, model, price))
				return SendSyntaxMessage(playerid, "/rentalmenu addveh [rental id] [modelid/modelname] [price]");

			if(!Rental_Exists(rental_id))
				return SendErrorMessage(playerid, "Rental point tidak terdaftar!");

			if((model[0] = GetVehicleModelByName(model)) == 0)
				return SendErrorMessage(playerid, "Model ID kendaraan tidak valid!");

			if(!(0 < price <= 5000))
				return SendErrorMessage(playerid, "Harga dibatasi (1 - 5000)");

			mysql_tquery(g_iHandle, sprintf("INSERT INTO `rental_vehicles`(`rental_id`, `model`, `price`) VALUES ('%d','%d','%d') ON DUPLICATE KEY UPDATE `price`='%d';", RentalData[rental_id][rentIndex], model[0], price, price));
			SendServerMessage(playerid, "Berhasil menambahkan "CYAN"%s "GREEN"(%s) "WHITE"untuk rental "YELLOW"(id %d).", GetVehicleNameByModel(model[0]), FormatNumber(price), rental_id);
		}
		case 6: // Deleteveh
		{
			if(sscanf(nextParams, "d", rental_id))
				return SendSyntaxMessage(playerid, "/rentalmenu deleteveh [rental id]");

			if(!Rental_Exists(rental_id))
				return SendErrorMessage(playerid, "Rental point tidak terdaftar!");

			new Cache:execute;

			execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `rental_vehicles` WHERE `rental_id`='%d';", RentalData[rental_id][rentIndex]));

			if(cache_num_rows())
			{
				new output[128];

				for(new i = 0; i != cache_num_rows(); i++)
				{
					new model = cache_get_field_int(i, "model");
			        strcat(output, sprintf("%d - %s (%s)\n", model, GetVehicleNameByModel(model), FormatNumber(cache_get_field_int(i, "price"))));
				}

				SetPVarInt(playerid, "RentalIndex", RentalData[rental_id][rentIndex]);
				SetPVarInt(playerid, "RentalID", rental_id);
				Dialog_Show(playerid, DeleteRentalVeh, DIALOG_STYLE_LIST, sprintf("Delete Vehicle | ID: %d", rental_id), output, "Delete", "Close");
			}
			else SendErrorMessage(playerid, "Tidak ada kendaraan pada rental point tersebut");

			cache_delete(execute);
		}
		default: SendSyntaxMessage(playerid, "/rentalmenu [create/delete/position/spawn/addveh/deleteveh]");
	}
	return 1;
}

// Player Vehicle
CMD:rentvehicle(playerid, params[])
{
	new rental_id;

	if((rental_id = Rental_Nearest(playerid)) == -1)
		return SendErrorMessage(playerid, "Kamu tidak berada didekat rental point!");

	if(GetAdminLevel(playerid) < 8 && Vehicle_RentedCount(playerid))
		return SendErrorMessage(playerid, "Kamu sudah memiliki kendaraan rental, (/unrentvehicle) untuk dapat menyewa kendaraan kembali.");

	if(Vehicle_RentedCount(playerid) >= MAX_RENTED_VEHICLES)
		return SendErrorMessage(playerid, "Penyewaan telah mencapai batas maksimal!");

	if(RentalData[rental_id][rentSpawnX] == 0.0 || RentalData[rental_id][rentSpawnX] == 0.0 || RentalData[rental_id][rentSpawnX] == 0.0)
		return SendErrorMessage(playerid, "Posisi spawn kendaraan rental belum ditetapkan, /atalk untuk melaporkan!");

	new Cache:execute;
	execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `rental_vehicles` WHERE `rental_id`='%d';", RentalData[rental_id][rentIndex]));

	if(cache_num_rows())
	{
		new output[128];

		for(new i = 0; i != cache_num_rows(); i++)
		{
			new model = cache_get_field_int(i, "model"),
				price = cache_get_field_int(i, "price");

			strcat(output, sprintf("%i\tHarga: %s/jam\n", model, FormatNumber(price)));

	        rental_vehicles_model[playerid][i] = model;
	        rental_vehicles_price[playerid][i] = price;
		}
		SetPVarInt(playerid, "RentalID", rental_id);

	    ShowPlayerDialog(playerid, DIALOG_RENTVEH, DIALOG_STYLE_PREVIEW_MODEL, "Rent Vehicle", output, "Select", "Close");
	}
	else SendErrorMessage(playerid, "Tidak ada kendaraan pada rental point ini!");

	cache_delete(execute);
	return 1;
}

CMD:unrentvehicle(playerid, params[])
{
	if(Rental_Nearest(playerid) == -1)
		return SendErrorMessage(playerid, "Kamu tidak berada didekat rental point!");

	if(!Vehicle_RentedCount(playerid))
		return SendErrorMessage(playerid, "Kamu tidak memiliki kendaraan rental!.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "Kemudikan kendaraan rentalmu!");

	new vehicleid, Float:health, vehid, price;

	if((vehicleid = Vehicle_ReturnID(GetPlayerVehicleID(playerid))) != RETURN_INVALID_VEHICLE_ID && !Vehicle_IsRented(playerid, vehicleid))
		return SendErrorMessage(playerid, "This is not a rented vehicle !");

	vehid = GetPlayerVehicleID(playerid);
	GetVehicleHealth(vehid, health);
	price = floatround(floatmul((1000.0 - health), Economy_GetRentVehDamagedFine()), floatround_ceil);

	Dialog_Show(playerid, UnrentVehicle, DIALOG_STYLE_MSGBOX, "Unrent Vehicle", "Your car's health is %.2f - You will get charge %s for the repair\n Are you sure you want to unrent the vehicle ?", "Unrent", "Cancel",health, FormatNumber(price));
	return 1;
}

CMD:rentinfo(playerid, params[])
{
	Vehicle_RentInfo(playerid);
	return 1;
}

CMD:renthelp(playerid, params[])
{
	SendClientMessage(playerid, X11_LIGHTGREEN, "Bantuan penyewaan kendaraan:");
	SendCustomMessage(playerid, "/rentinfo", "Untuk melihat informasi kendaraan yang disewa.");
	SendCustomMessage(playerid, "/rentvehicle", "Untuk menyewa kendaraan di "YELLOW"rental point.");
	SendCustomMessage(playerid, "/unrentvehicle", "Untuk mengembalikan kendaraan yang telah disewa sebelumnya.");

	if(GetAdminLevel(playerid) >= 8)
		SendServerMessage(playerid, "/rm (rentalmenu)");
	
	return 1;
}