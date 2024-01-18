SSCANF:CargoMenu(string[]) 
{
 	if(!strcmp(string,"buy",true)) return 1;
 	else if(!strcmp(string,"sell",true)) return 2;
 	else if(!strcmp(string,"list",true)) return 3;
 	else if(!strcmp(string,"place",true)) return 4;
 	else if(!strcmp(string,"pickup",true)) return 5;
 	else if(!strcmp(string,"putdown",true)) return 6;
 	else if(!strcmp(string,"sellback",true)) return 7;
 	return 0;
}

CMD:cargo(playerid, params[])
{
	static action, nextParams[128];

	if (PlayerData[playerid][pJob] != JOB_COURIER) 
		return SendErrorMessage(playerid, "Kamu bukan seorang trucker.");

	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendErrorMessage(playerid, "Turun dari kendaraan untuk menggunakan perintah ini!");

	if(sscanf(params, "k<CargoMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/cargo [buy/sell/list/sellback/place/putdown/pickup]");

	switch(action)
	{
		case 1: // Buy Cargo
		{
			new market_id;

			if((market_id = Marketplace_Nearest(playerid)) != -1)
			{
				if(GetMoney(playerid) < Marketplace_GetPrice(market_id))
					return SendErrorMessage(playerid, "Uang kamu tidak cukup (%s)", FormatNumber(Marketplace_GetPrice(market_id)));

				if(GetPlayerCargoType(playerid) != CARGO_NONE)
					return SendErrorMessage(playerid, "Kamu sedang mengangkat kargo, (/cargo sellback) untuk mengembalikan sebanyak 1/3 dari harga penjualan.");

				Cargo_AnimPlay(playerid);
				SetPlayerCargoType(playerid, Marketplace_GetType(market_id));
				SetPlayerCargoProduct(playerid, Marketplace_GetProduct(market_id));

				GiveMoney(playerid, -Marketplace_GetPrice(market_id), ECONOMY_ADD_SUPPLY, "bought cargo");
				SendServerMessage(playerid, "Sukses membeli kargo "LIGHTBLUE"%s "YELLOW"(%d produk) "WHITE"dengan harga "GREEN"%s.", Marketplace_TypeName(Marketplace_GetType(market_id)), Marketplace_GetProduct(market_id), FormatNumber(Marketplace_GetPrice(market_id)));
			}
			else SendErrorMessage(playerid, "Kamu tidak berada didekat marketplace!");
		}
		case 2: // Sell Cargo
		{
			new index, confirm[8];

			if((index = Business_NearestDeliver(playerid)) != -1)
			{
				if(Business_IsOwner(playerid, index))
           	 		return SendErrorMessage(playerid, "Tidak diizinkan menjual barang pada bisnis sendiri, silahkan menggunakan jasa truker!.");
				
				if(GetPlayerCargoType(playerid) == CARGO_NONE)
					return SendErrorMessage(playerid, "Kamu sedang tidak mengangkut kargo!.");

				if(sscanf(nextParams, "s[8]", confirm)) {
					SendSyntaxMessage(playerid, "/cargo sell ['confirm']");
					return SendCustomMessage(playerid, "NOTICE","Bisnis ini menawarkan "GREEN"%s "WHITE"untuk kargomu!.", FormatNumber(BusinessData[index][bizCargo]));
				}

				if(!strcmp(confirm, "confirm", false))
				{
					if (BusinessData[index][bizType] != GetPlayerCargoType(playerid))
						return SendErrorMessage(playerid, "Cargo yang kamu bawa tidak sesuai dengan bisnis ini!.");

					if (BusinessData[index][bizVault] < BusinessData[index][bizCargo])
						return SendErrorMessage(playerid, "Bisnis tidak memiliki cukup uang untuk membayar kargomu.");

					if ((BusinessData[index][bizProducts] + GetPlayerCargoProduct(playerid)) > 100)
						return SendErrorMessage(playerid, "Bisnis ini belum membutuhkan produk tambahan.");

					new rand = RandomEx(50, 100);
					AddPlayerSalary(playerid, (BusinessData[index][bizCargo]+rand), "Cargo");
					BusinessData[index][bizVault] -= BusinessData[index][bizCargo];
					BusinessData[index][bizProducts] += GetPlayerCargoProduct(playerid);
					SetTruckerSkill(playerid, 1.0);

					Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Information", ""WHITE"Kamu telah menjual kargo: "LIGHTGREEN"%s\n"WHITE"Produk dalam kargo: "YELLOW"%d pcs\n"WHITE"Pendapatan: "GREEN"%s (+ bonus: %s)\n\n"WHITE"NOTE: Terima kasih telah menjual ke bisnis kami!", "Close", "", 
						Cargo_TypeName(GetPlayerCargoType(playerid)),
						GetPlayerCargoProduct(playerid),
						FormatNumber(rand),
						FormatNumber(BusinessData[index][bizCargo])
					);

					Cargo_AnimStop(playerid);
					SetPlayerCargoProduct(playerid, 0);
					SetPlayerCargoType(playerid, CARGO_NONE);
				}
				return 1;
			}
			else SendErrorMessage(playerid, "Kamu tidak berada dekat dengan business delivery point.");
		}
		case 3: // List vehicle cargo
		{
			new nearest_veh, index;

			if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
				return SendErrorMessage(playerid, "Keluar kendaraan untuk menggunakan perintah ini.");

			if((nearest_veh = Vehicle_Nearest(playerid, 7.0)) == -1)
				return SendErrorMessage(playerid, "Tidak ada kendaraan disekitarmu");

			if(GetDoorStatus(nearest_veh))
				return SendErrorMessage(playerid, "Kendaraan dalam keadaan terkunci, tidak dapat melihat isi muatan!");

			if((index = Vehicle_ReturnID(nearest_veh)) != RETURN_INVALID_VEHICLE_ID)
			{
				new Cache:execute, output[4098];

				execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `vehicle_cargo` WHERE `vehicle_id`='%d';", VehicleData[index][vehIndex]));

				if(cache_num_rows())
				{
					strcat(output, "Cargo\tProducts\n");
					for(new i = 0; i != cache_num_rows(); i++)
					{
						strcat(output, sprintf(""LIGHTGREEN"%s\t%d\n", Cargo_TypeName(cache_get_field_int(i, "type")), cache_get_field_int(i, "product")));
						cargo_listed[playerid][i] = cache_get_field_int(i, "id");
					}
					SetPVarInt(playerid, "NearestVehicle", nearest_veh);
					Dialog_Show(playerid, CargoList, DIALOG_STYLE_TABLIST_HEADERS, "Cargo List", output, "Pickup", "Close");
				}
				else SendErrorMessage(playerid, "Tidak ada muatan dikendaraan ini!");

				cache_delete(execute);
			}
			else SendErrorMessage(playerid, "Tidak dapat melihat isi kendaraan ini!");
		}
		case 4: // Place into vehicle
		{
			new nearest_veh, index;

			if(GetPlayerCargoType(playerid) == CARGO_NONE)
				return SendErrorMessage(playerid, "Kamu sedang tidak mengangkut kargo!.");

			if((nearest_veh = Vehicle_Nearest(playerid, 7)) == -1)
				return SendErrorMessage(playerid, "Tidak ada kendaraan disekitarmu");

			if(GetDoorStatus(nearest_veh))
				return SendErrorMessage(playerid, "Kendaraan dalam keadaan terkunci, tidak dapat memuat pada kendaraan ini!");

            if(!IsLoadableVehicle(nearest_veh)) 
            	return SendErrorMessage(playerid, "Tidak dapat memuat kargo untuk kendaraan jenis ini.");

			if((index = Vehicle_ReturnID(nearest_veh)) != RETURN_INVALID_VEHICLE_ID)
			{
				if(Vehicle_GetType(index) != VEHICLE_TYPE_PLAYER && Vehicle_GetType(index) != VEHICLE_TYPE_RENTAL && Vehicle_GetType(index) != VEHICLE_TYPE_FACTION)
					return SendErrorMessage(playerid, "Hanya dapat dimuat pada kendaraan player dan rental!");

				new maximum_cargo, level = GetTruckerLevel(playerid);
				switch(level)
				{
					case 1: maximum_cargo = 5;
					case 2: maximum_cargo = 10;
					case 3: maximum_cargo = 15;
					default: maximum_cargo = 30;
				}

				if(Vehicle_CargoCount(index) >= maximum_cargo)
					return SendErrorMessage(playerid, "Muatan kendaraan sudah penuh!");

				mysql_tquery(g_iHandle, sprintf("INSERT INTO `vehicle_cargo`(`type`, `product`, `vehicle_id`) VALUES ('%d','%d','%d')",
					GetPlayerCargoType(playerid),
					GetPlayerCargoProduct(playerid),
					VehicleData[index][vehIndex]
				));

				SendServerMessage(playerid, "Sukses meletakkan kargo "YELLOW"%s "WHITE"kedalam "CYAN"%s.", Cargo_TypeName(GetPlayerCargoType(playerid)), GetVehicleNameByModel(VehicleData[index][vehModel]));

				Cargo_AnimStop(playerid);
				SetPlayerCargoProduct(playerid, 0);
				SetPlayerCargoType(playerid, CARGO_NONE);
			}
			else SendErrorMessage(playerid, "Tidak dapat meletakkan dikendaraan ini!");
		}
		case 5: // Pickup
		{
			new cargo_id;

			if(GetPlayerCargoType(playerid) != CARGO_NONE)
				return SendErrorMessage(playerid, "Kamu sedang mengangkut kargo!.");

			if((cargo_id = Cargo_Nearest(playerid)) != -1)
			{
				Cargo_AnimPlay(playerid);
				SetPlayerCargoType(playerid, CargoData[cargo_id][cargoType]);
				SetPlayerCargoProduct(playerid, CargoData[cargo_id][cargoProduct]);

				SendServerMessage(playerid, "Kemu mendapatkan kargo "YELLOW"%s "LIGHTBLUE"(%d product(s)).", Cargo_TypeName(GetPlayerCargoType(playerid)), GetPlayerCargoProduct(playerid));

				Cargo_Delete(cargo_id);
			}
			else SendErrorMessage(playerid, "Tidak ada kargo disekitarmu!.");
		}
		case 6: // Putdown
		{
			if(GetPlayerCargoType(playerid) == CARGO_NONE)
				return SendErrorMessage(playerid, "Kamu tidak memiliki kargo untuk diletakkan.");

			if(Cargo_Nearest(playerid) != -1)
				return SendErrorMessage(playerid, "Beri jarak antara satu kargo ke kargo lainnya.");

			if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
				return SendErrorMessage(playerid, "Tidak bisa meletakkan jika interior atau virtual world tidak 0!");

			if(Cargo_Place(playerid, GetPlayerCargoType(playerid), GetPlayerCargoProduct(playerid)) != -1) {
				SendServerMessage(playerid, "Sukses meletakkan kargo "YELLOW"%s "WHITE"dan akan "RED"hilang "WHITE"dalam waktu "LIGHTBLUE"24 jam kedepan.", Cargo_TypeName(GetPlayerCargoType(playerid)));

				Cargo_AnimStop(playerid);
				SetPlayerCargoProduct(playerid, 0);
				SetPlayerCargoType(playerid, CARGO_NONE);
			}
			else SendErrorMessage(playerid, "Tidak dapat meletakkan kargo, dikarenakan sudah mencapai batas maksimal dari server!.");
		}
		case 7: // Sell Back Cargo
		{
			new market_id;

			if((market_id = Marketplace_Nearest(playerid)) != -1)
			{
				if(GetPlayerCargoType(playerid) == CARGO_NONE)
					return SendErrorMessage(playerid, "Kamu tidak memiliki kargo untuk dikembalikan.");

				if(GetPlayerCargoType(playerid) != Marketplace_GetType(market_id))
					return SendErrorMessage(playerid, "Ini bukan marketplace kargo %s.", Cargo_TypeName(GetPlayerCargoType(playerid)));

				Cargo_AnimStop(playerid);
				GiveMoney(playerid, (Marketplace_GetPrice(market_id)/3), ECONOMY_TAKE_SUPPLY, "sell back cargo");
				SendServerMessage(playerid, "Kamu mengembalikan kargo dan mendapatkan uang "YELLOW"1/3 "WHITE"dari harga aslinya menjadi "GREEN"%s", FormatNumber((Marketplace_GetPrice(market_id)/3)));

				SetPlayerCargoProduct(playerid, 0);
				SetPlayerCargoType(playerid, CARGO_NONE);
			}
			else SendErrorMessage(playerid, "Kamu tidak berada didekat marketplace!");
		}
		default: SendSyntaxMessage(playerid, "/cargo [buy/sell/list/sellback/place/putdown/pickup]");
	}
	return 1;
}