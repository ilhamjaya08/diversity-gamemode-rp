SSCANF:DealerMenu(string[]) 
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
 	else if(!strcmp(string,"stock",true)) return 7;
 	else if(!strcmp(string,"lock",true)) return 8;
 	else if(!strcmp(string,"name",true)) return 9;
 	return 0;
}

CMD:dm(playerid, params[])
	return cmd_dealermenu(playerid, params);

CMD:dealermenu(playerid, params[])
{
	static
		index, action, nextParams[128];

	if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

	if(sscanf(params, "k<DealerMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/dealermenu [create/delete/position/spawn/addveh/deleteveh/stock/lock/name]");

	switch(action)
	{
		case 1: // Create
		{
			if(isnull(nextParams))
				return SendSyntaxMessage(playerid, "/dealermenu create [name]");

			if(strlen(nextParams) > 24)
				return SendErrorMessage(playerid, "Nama dealer maksimal 24 karakter!");

			if((index = Dealership_Add(playerid, nextParams)) != -1) SendServerMessage(playerid, "Sukses membuat dealership "YELLOW"(id: %d)", index);
			else SendErrorMessage(playerid, "Dealership sudah mencapai batas maksimal "LIGHTBLUE"(%d points)", MAX_DYNAMIC_DEALERSHIP);
		}
		case 2: // Delete
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/dealermenu delete [dealer id]");

			if(!Dealership_IsExists(index))
				return SendErrorMessage(playerid, "Dealership tidak terdaftar!");

			Dealership_Delete(index);
			SendServerMessage(playerid, "Kamu telah "LIGHTBLUE"menghapus "WHITE"dealer "RED"(id: %d)", index);
		}
		case 3: // Position
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/dealermenu position [dealer id]");

			if(!Dealership_IsExists(index))
				return SendErrorMessage(playerid, "Dealer tidak terdaftar!");

			GetPlayerPos(playerid, DealershipData[index][dealerPos][0], DealershipData[index][dealerPos][1], DealershipData[index][dealerPos][2]);

			Dealership_Sync(index);
			Dealership_Save(index, DEALER_SAVE_POS);

			SendServerMessage(playerid, "Kamu telah mengubah "LIGHTBLUE"posisi "WHITE"dealer "YELLOW"(id: %d)", index);
		}
		case 4: // Spawn
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/dealermenu spawn [dealer id]");

			if(!Dealership_IsExists(index))
				return SendErrorMessage(playerid, "Dealer tidak terdaftar!");

			GetPlayerPos(playerid, DealershipData[index][dealerSpawn][0], DealershipData[index][dealerSpawn][1], DealershipData[index][dealerSpawn][2]);
			GetPlayerFacingAngle(playerid, DealershipData[index][dealerSpawn][3]);

			Dealership_Save(index, DEALER_SAVE_SPAWN);

			SendServerMessage(playerid, "Kamu telah mengubah "LIGHTBLUE"spawn "WHITE"dealer "YELLOW"(id: %d)", index);
		}
		case 5: // Addveh
		{
			new model[32], price;

			if(sscanf(nextParams, "ds[32]d", index, model, price))
				return SendSyntaxMessage(playerid, "/dealermenu addveh [dealer id] [modelid/modelname] [price]");

			if(!Dealership_IsExists(index))
				return SendErrorMessage(playerid, "Dealer tidak terdaftar!");

			if((model[0] = GetVehicleModelByName(model)) == 0)
				return SendErrorMessage(playerid, "Model ID kendaraan tidak valid!");

			if(!(0 < price <= 1000000))
				return SendErrorMessage(playerid, "Harga dibatasi (1 - 1,000,000)");

			// Check amount of vehicle

			new Cache:execute = mysql_query(g_iHandle, sprintf("SELECT COUNT(*) AS `total` FROM `dealer_vehicles` WHERE `dealer_id`='%d' LIMIT 10;", DealershipData[index][dealerID]));

			if(cache_get_field_int(0, "total") >= 10)
				return SendErrorMessage(playerid, "Kendaraan sudah mencapai batas maksimal pada dealer ini (10 kendaraan)"), cache_delete(execute);

			// End checking

			mysql_tquery(g_iHandle, sprintf("INSERT INTO dealer_vehicles (dealer_id,model,price) VALUES (%d,%d,%d) ON DUPLICATE KEY UPDATE price=%d;", DealershipData[index][dealerID], model[0], price, price));
			SendServerMessage(playerid, "Berhasil menambahkan "CYAN"%s "GREEN"(%s) "WHITE"untuk dealer "YELLOW"(id %d).", GetVehicleNameByModel(model[0]), FormatNumber(price), index);
		}
		case 6: // Deleteveh
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/dealermenu deleteveh [dealer id]");

			if(!Dealership_IsExists(index))
				return SendErrorMessage(playerid, "Dealer tidak terdaftar!");

			new Cache:execute;

			execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `dealer_vehicles` WHERE `dealer_id`='%d' LIMIT 10;", DealershipData[index][dealerID]));

			if(cache_num_rows())
			{
				new output[300];

				for(new i = 0; i != cache_num_rows(); i++)
				{
					new model = cache_get_field_int(i, "model");
			        strcat(output, sprintf("%d - %s (%s)\n", model, GetVehicleNameByModel(model), FormatNumber(cache_get_field_int(i, "price"))));
				}

				SetPVarInt(playerid, "DealerIndex", DealershipData[index][dealerID]);
				SetPVarInt(playerid, "DealerID", index);
				Dialog_Show(playerid, DeleteDealerVeh, DIALOG_STYLE_LIST, sprintf("Delete Vehicle | dealer ID: %d", index), output, "Delete", "Close");
			}
			else SendErrorMessage(playerid, "Tidak ada kendaraan pada dealer tersebut");

			cache_delete(execute);
		}
		case 7: // Stock
		{
			new stok;

			if(sscanf(nextParams, "dd", index, stok))
				return SendSyntaxMessage(playerid, "/dealermenu stock [dealer id] [value]");

			if(!Dealership_IsExists(index))
				return SendErrorMessage(playerid, "Dealer tidak terdaftar!");

			if(!(0 <= stok <= 100))
				return SendErrorMessage(playerid, "Stok dibatasi (1 - 100)");

			DealershipData[index][dealerStock] = stok;

			Dealership_Sync(index, true);
			Dealership_Save(index, DEALER_SAVE_STOCK);

			SendServerMessage(playerid, "Berhasil menetapkan stok dealer "YELLOW"(id %d) "WHITE"menjadi "GREEN"%d kendaraan.", index, stok);
		}
		case 8: // Lock
		{
			new lock;

			if(sscanf(nextParams, "dd", index, lock))
				return SendSyntaxMessage(playerid, "/dealermenu lock [dealer id] [value (0: unlock, 1: lock)]");

			if(!Dealership_IsExists(index))
				return SendErrorMessage(playerid, "Dealer tidak terdaftar!");

			if(!(0 <= lock <= 1))
				return SendErrorMessage(playerid, "Hanya opsi 0 atau 1 yang diperintahkan!");

			DealershipData[index][dealerLock] = !!lock;

			Dealership_Sync(index, true);
			Dealership_Save(index, DEALER_SAVE_LOCK);

			SendServerMessage(playerid, "Berhasil %s "WHITE"dealer "YELLOW"(id %d).", lock ? (""RED"menonaktifkan") : (""GREEN"mengaktifkan"), index);
		}
		case 9: // Name
		{
			new name[24];

			if(sscanf(nextParams, "ds[24]", index, name))
				return SendSyntaxMessage(playerid, "/dealermenu name [dealer id] [dealer name]");

			if(!Dealership_IsExists(index))
				return SendErrorMessage(playerid, "Dealer tidak terdaftar!");

			format(DealershipData[index][dealerName], 24, name);

			Dealership_Sync(index, true);
			Dealership_Save(index, DEALER_SAVE_NAME);

			SendServerMessage(playerid, "Berhasil mengganti nama dealer "YELLOW"(id %d) "WHITE"menjadi "LIGHTBLUE"%s", index, name);
		}
		default: SendSyntaxMessage(playerid, "/dealermenu [create/delete/position/spawn/addveh/deleteveh/stock/lock/name]");
	}
	return 1;
}

CMD:buyvehicle(playerid, params[])
{
	static index;

	if((index = Dealership_Nearest(playerid)) != -1)
	{
		if(DealershipData[index][dealerLock])
			return SendErrorMessage(playerid, "Dealership dikunci, tidak dapat membeli kendaraan sementara waktu!");

		if(DealershipData[index][dealerStock] < 1)
			return SendErrorMessage(playerid, "Persediaan kendaraan pada dealer kosong!");

		if(DealershipData[index][dealerSpawn][0] == 0 || DealershipData[index][dealerSpawn][2] == 0 || DealershipData[index][dealerSpawn][3] == 0)
			return SendErrorMessage(playerid, "Posisi spawn dealer belum ditetapkan, silahkan hubungi high admin melalui '/atalk'.");

		Dealership_Buy(playerid, index);
	}
	else SendErrorMessage(playerid, "Kamu tidak berada dekat dengan dealership!");
	return 1;
}