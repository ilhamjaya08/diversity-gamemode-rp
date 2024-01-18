/** Server Vehicle commands
*
*/

SSCANF:ServerVehicle(string[]) 
{
	if(!strcmp(string,"delete",true)) return 1;
	else if(!strcmp(string,"destroy",true)) return 1;
	else if(!strcmp(string,"remove",true)) return 1;
	else if(!strcmp(string,"pos",true)) return 2;
	else if(!strcmp(string,"position",true)) return 2;
	else if(!strcmp(string,"location",true)) return 2;
	else if(!strcmp(string,"color",true)) return 3;
	else if(!strcmp(string,"colour",true)) return 3;
	else if(!strcmp(string,"playerveh",true)) return 4;
	else if(!strcmp(string,"playercar",true)) return 4;
	else if(!strcmp(string,"factionveh",true)) return 5;
	else if(!strcmp(string,"factioncar",true)) return 5;
	else if(!strcmp(string,"sidejobveh",true)) return 6;
	else if(!strcmp(string,"sidejobcar",true)) return 6;
	else if(!strcmp(string,"insurance",true)) return 7;
	else if(!strcmp(string,"dmvcar",true)) return 8;
	else if(!strcmp(string,"unmod",true)) return 9;
	else if(!strcmp(string,"info",true)) return 10;
	else if(!strcmp(string,"platenumber",true)) return 11;
	else if(!strcmp(string,"siren",true)) return 12;
	else if(!strcmp(string,"engine",true)) return 13;
	else if(!strcmp(string,"body",true)) return 14;
	else if(!strcmp(string,"gas",true)) return 15;
	else if(!strcmp(string,"turbo",true)) return 16;
	else if(!strcmp(string,"current_mileage",true)) return 17;
	else if(!strcmp(string,"durability_mileage",true)) return 18;
	return 0;
}

CMD:vm(playerid, params[])
	return cmd_vehiclemenu(playerid, params);

CMD:vehiclemenu(playerid, params[])
{
	static
		vehicle_index, vehicleid, action, nextParams[255],
		Float:x, Float:y, Float:z, Float:angle
	;

	if (CheckAdmin(playerid, 5))
        return PermissionError(playerid);

	if(sscanf(params, "k<ServerVehicle>S()[255]", action, nextParams))
	{
		SendSyntaxMessage(playerid, "/vehiclemenu [entity]");
		SendSyntaxMessage(playerid, "Entity: playerveh/factionveh/sidejobveh/dmvcar/delete/position/color/insurance/turbo");
		SendSyntaxMessage(playerid, "Entity: unmod/info/platenumber/siren/engine/body/current_mileage/durability_mileage");
		return 1;
	}

	switch(action)
	{
		case 1: // Destroy
		{
			if(sscanf(nextParams, "d", vehicleid))
				return SendSyntaxMessage(playerid, "/vehiclemenu delete [vehicleid]");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_NONE)
					return SendErrorMessage(playerid, "Kendaraan temporary hapus dengan /destroyveh.");
			
				SendServerMessage(playerid, "Kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah dihapus dari server!", GetVehicleNameByVehicle(vehicleid), vehicleid);
				
				foreach(new i : Player) if(GetPlayerSQLID(i) == Vehicle_GetExtraID(vehicle_index))
				{
					if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER)
						SendServerMessage(i, "Kendaraan "CYAN"(%s) "WHITE"milikmu telah "RED"dihapus "WHITE"oleh "RED"%s.", GetVehicleNameByModel(VehicleData[vehicle_index][vehModel]), ReturnAdminName(playerid));

					else if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_RENTAL)
						SendServerMessage(i, "Kendaraan sewa "CYAN"(%s) "WHITE" milikmu telah "RED"dihapus "WHITE"oleh "RED"%s.", GetVehicleNameByModel(VehicleData[vehicle_index][vehModel]), ReturnAdminName(playerid));

					break;
				}
				Vehicle_Delete(vehicle_index);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 2: // Position
		{
			if(sscanf(nextParams, "d", vehicleid))
				return SendSyntaxMessage(playerid, "/vehiclemenu position [vehicleid]");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				Vehicle_SaveData(vehicle_index);

				VehicleData[vehicle_index][vehInterior] = GetPlayerInterior(playerid);
				VehicleData[vehicle_index][vehVirtual] = GetPlayerVirtualWorld(playerid);

				LinkVehicleToInterior(VehicleData[vehicle_index][vehVehicleID], VehicleData[vehicle_index][vehInterior]);
				SetVehicleVirtualWorld(VehicleData[vehicle_index][vehVehicleID], VehicleData[vehicle_index][vehVirtual]);

				Vehicle_Save(vehicle_index, VEHICLE_SAVE_POSITION);

				if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_SIDEJOB || Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_DRIVING_SCHOOL || Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_FACTION)
				{
					SetVehicleNumberPlate(VehicleData[vehicle_index][vehVehicleID], VehicleData[vehicle_index][vehPlate]);
					SetVehicleToRespawn(VehicleData[vehicle_index][vehVehicleID]);
					LinkVehicleToInterior(VehicleData[vehicle_index][vehVehicleID], VehicleData[vehicle_index][vehInterior]);
					SetVehicleVirtualWorld(VehicleData[vehicle_index][vehVehicleID], VehicleData[vehicle_index][vehVirtual]);
				}
				SendServerMessage(playerid, "Posisi kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah diperbaharui!", GetVehicleNameByVehicle(vehicleid), vehicleid);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 3: // Color
		{
			new color1, color2;

			if(sscanf(nextParams, "ddd", vehicleid, color1, color2))
				return SendSyntaxMessage(playerid, "/vehiclemenu color [vehicleid] [color1] [color2] (-1 for random color)");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				Vehicle_SetColor(vehicleid, color1, color2);
				SendServerMessage(playerid, "Warna kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah diperbaharui!", GetVehicleNameByVehicle(vehicleid), vehicleid);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 4: // For player
		{
			new targetid, model[32], color1, color2;

			if(sscanf(nextParams, "us[32]dd", targetid, model, color1, color2))
				return SendSyntaxMessage(playerid, "/vehiclemenu playerveh [targetid] [model id/name] [color1] [color2]");

			if(targetid == INVALID_PLAYER_ID)
				return SendErrorMessage(playerid, "Player tersebut tidak login!");

			new housevehicleslot = House_CountVehicleSlot(targetid);

			if(GetPlayerVIPLevel(targetid) > 2)
			{
				if(Vehicle_PlayerTotalCount(targetid) >= MAX_VIP_VEHICLES+housevehicleslot)
					return SendErrorMessage(playerid, "Kendaraan player tersebut sudah mencapai batas maksimal.");
			}
			else
			{
				if(Vehicle_PlayerTotalCount(targetid) >= MAX_PLAYER_VEHICLES+housevehicleslot)
					return SendErrorMessage(playerid, "Kendaraan player tersebut sudah mencapai batas maksimal.");
			}

			if((model[0] = GetVehicleModelByName(model)) == 0)
				return SendErrorMessage(playerid, "Model ID kendaraan tidak valid!");

			if(!(-2 < color1 <= 255))
				return SendErrorMessage(playerid, "Warna1 hanya dibatasi hingga 0 - 255");

			if(!(-2 < color2 <= 255))
				return SendErrorMessage(playerid, "Warna2 hanya dibatasi hingga 0 - 255");

			GetPlayerPos(targetid, x, y, z);
			GetPlayerFacingAngle(targetid, angle);

			if((vehicle_index = Vehicle_Create(model[0], x, y, z, angle, color1, color2)) != RETURN_INVALID_VEHICLE_ID) {
				SetPlayerPos(targetid, x, y, z+3);
				Vehicle_SetOwner(targetid, vehicle_index);
				SendServerMessage(targetid, "Admin "RED"%s "WHITE"telah membuat "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") untukmu!", ReturnAdminName(playerid), GetVehicleNameByModel(model[0]), VehicleData[vehicle_index][vehVehicleID]);
				SendServerMessage(playerid, "Kamu telah membuatkan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") untuk "YELLOW"%s!", GetVehicleNameByModel(model[0]), VehicleData[vehicle_index][vehVehicleID], ReturnName(targetid, 0));

				Log_Save(E_LOG_CREATE_VEHICLE, sprintf("[%s] %s membuat kendaraan %s untuk %s.", ReturnDate(), ReturnAdminName(playerid), GetVehicleNameByModel(model[0]), ReturnName(targetid, 0)));
			}
			else SendErrorMessage(playerid, "Slot kendaraan sudah mencapai batas maksimal!");
		}
		case 5: // For faction
		{
			new faction_id, model[32], color1, color2, siren, plate[32];

			if(sscanf(nextParams, "ds[32]ddds[32]", faction_id, model, color1, color2, siren, plate))
				return SendSyntaxMessage(playerid, "/vehiclemenu factionveh [factionid] [model id/name] [color1] [color2] [siren (0/1)] [number plate]");

			if(!FactionData[faction_id][factionExists])
				return SendErrorMessage(playerid, "Faction tidak terdaftar (cek /factions)");

			if((model[0] = GetVehicleModelByName(model)) == 0)
				return SendErrorMessage(playerid, "Model ID kendaraan tidak valid!");

			if(!(-2 < color1 <= 255))
				return SendErrorMessage(playerid, "Warna1 hanya dibatasi hingga 0 - 255");

			if(!(-2 < color2 <= 255))
				return SendErrorMessage(playerid, "Warna2 hanya dibatasi hingga 0 - 255");

			if(!(0 <= siren <= 1))
				return SendErrorMessage(playerid, "Opsi siren hanya 0 dan 1");

			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, angle);

			if((vehicle_index = Vehicle_Create(model[0], x, y, z, angle, color1, color2, true, plate, siren)) != RETURN_INVALID_VEHICLE_ID) {
				SetPlayerPos(playerid, x, y, z+3);
				Vehicle_SetFaction(FactionData[faction_id][factionID], vehicle_index);
				SendServerMessage(playerid, "Kamu telah membuatkan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") untuk faction "LIGHTBLUE"%s!", GetVehicleNameByModel(model[0]), VehicleData[vehicle_index][vehVehicleID], FactionData[faction_id][factionName]);
			}
			else SendErrorMessage(playerid, "Slot kendaraan sudah mencapai batas maksimal!");
		}
		case 6: // For sidejob
		{
			new sidejob_id, sidejob_model[] = {431, 574, 408, 428, 498};

			if(sscanf(nextParams, "d", sidejob_id)){
				SendSyntaxMessage(playerid, "/vehiclemenu sidejobveh [sidejobid]");
				return SendCustomMessage(playerid, "SIDEJOB", "1. Bus | 2. Sweeper | 3. Trashmaster | 4. Money Transporter | 5. Boxville");
			}

			if(!(0 < sidejob_id <= 6))
				return SendErrorMessage(playerid, "Sidejob id: 1. Bus | 2. Sweeper | 3. Trashmaster | 4. Money Transporter | 5. Boxville");

			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, angle);

			if((vehicle_index = Vehicle_Create(sidejob_model[(sidejob_id-1)], x, y, z, angle, 6, 6)) != RETURN_INVALID_VEHICLE_ID) {
				SetPlayerPos(playerid, x, y, z+3);
				Vehicle_SetType(vehicle_index, VEHICLE_TYPE_SIDEJOB);
				Vehicle_ExtraID(vehicle_index, sidejob_id);
				SendServerMessage(playerid, "Kamu telah membuatkan (Vehicle-ID: "YELLOW"%d"WHITE") untuk sidejob "LIGHTBLUE"%s!", VehicleData[vehicle_index][vehVehicleID], GetVehicleNameByModel(sidejob_model[sidejob_id-1]));
			}
			else SendErrorMessage(playerid, "Slot kendaraan sudah mencapai batas maksimal!");
		}
		case 7: // Set Insurance
		{
			new insurance;

			if(sscanf(nextParams, "dd", vehicleid, insurance))
				return SendErrorMessage(playerid, "/vehiclemenu insurance [vehicleid] [value (max 3)]");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "ID kendaraan tidak valid!");

			if(!(0 < insurance <= 3))
				return SendErrorMessage(playerid, "Batas pemberian asuransi 1 - 3.");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				if(Vehicle_GetType(vehicle_index) != VEHICLE_TYPE_PLAYER)
					return SendErrorMessage(playerid, "Bukan kendaraan player!");

				VehicleData[vehicle_index][vehInsurance] = insurance;
				Vehicle_ExecuteInt(vehicle_index, "insurance", insurance);

				foreach(new i : Player) if(GetPlayerSQLID(i) == Vehicle_GetExtraID(vehicle_index))
				{
					if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER)
						SendServerMessage(i, "Asuransi kendaraan "CYAN"(%s) "WHITE"milikmu diubah menjadi "YELLOW"%d "WHITE"oleh "RED"%s.", GetVehicleNameByModel(VehicleData[vehicle_index][vehModel]), VehicleData[vehicle_index][vehInsurance], ReturnAdminName(playerid));

					break;
				}
				SendServerMessage(playerid, "Asuransi kendaraan "CYAN"%s "WHITE"menjadi "YELLOW"%d.", GetVehicleNameByModel(VehicleData[vehicle_index][vehModel]), insurance);
			}
			else SendErrorMessage(playerid, "Kendaraan tersebut bukan kendaraan server!");
		}
		case 8: // For DMV
		{
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngle(playerid, angle);

			if((vehicle_index = Vehicle_Create(410, x, y, z, angle, 6, 6, true, ""LIGHTBLUE"DMV")) != RETURN_INVALID_VEHICLE_ID) {
				SetPlayerPos(playerid, x, y, z+3);
				Vehicle_SetType(vehicle_index, VEHICLE_TYPE_DRIVING_SCHOOL);
				SendServerMessage(playerid, "Kamu telah membuatkan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") untuk Driving School!", GetVehicleNameByModel(VehicleData[vehicle_index][vehModel]), VehicleData[vehicle_index][vehVehicleID]);
			}
			else SendErrorMessage(playerid, "Slot kendaraan sudah mencapai batas maksimal!");
		}
		case 9: // Unmod
		{
			if(sscanf(nextParams, "d", vehicleid))
				return SendErrorMessage(playerid, "/vehiclemenu insurance [vehicleid]");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "ID kendaraan tidak valid!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				for (new i = 0; i < 14; i ++)
				{
					if(!VehicleData[vehicle_index][vehMod][i])
						continue;

	                RemoveVehicleComponent(vehicleid, VehicleData[vehicle_index][vehMod][i]);
	                VehicleData[vehicle_index][vehMod][i] = 0;
	            }

	            // Remove paintjob
	            ChangeVehiclePaintjob(vehicleid, 3);

	            // Modding remove
				mysql_tquery(g_iHandle, sprintf("DELETE FROM `vehicle_mod` WHERE `vehicleid`='%d';", VehicleData[vehicle_index][vehIndex]));
	            SendServerMessage(playerid, "Modifikasi kendaraan "CYAN"%s "WHITE" telah dihapus, termasuk paintjob.", GetVehicleNameByVehicle(vehicleid));
			}
			else SendErrorMessage(playerid, "Kendaraan tersebut bukan kendaraan server!");
		}
		case 10: // Info
		{
			new output[255];

			if(sscanf(nextParams, "d", vehicleid))
				return SendErrorMessage(playerid, "/vehiclemenu info [vehicleid]");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "ID kendaraan tidak valid!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				new vehicle_type[][16] = {"TEMPORARY", "PLAYER", "FACTION", "SIDEJOB", "RENTAL", "DRIVING SCHOOL"};
				strcat(output, sprintf("Model\t"YELLOW"%s\n", GetVehicleNameByVehicle(vehicleid)));
				strcat(output, sprintf("Type\t"CYAN"%s\n", vehicle_type[Vehicle_GetType(vehicle_index)]));

				switch(Vehicle_GetType(vehicle_index))
				{
					case VEHICLE_TYPE_PLAYER:
					{
						strcat(output, sprintf("Owned by\t"LIGHTBLUE"%s\n", ReturnName(Vehicle_PlayerID(vehicleid))));
						strcat(output, sprintf("Insurance\t"LIGHTBLUE"%d", VehicleData[vehicle_index][vehInsurance]));
					}
					case VEHICLE_TYPE_RENTAL:
					{
						strcat(output, sprintf("Rented by\t"LIGHTBLUE"%s", ReturnName(Vehicle_PlayerID(vehicleid))));
					}
					case VEHICLE_TYPE_FACTION:
					{
						strcat(output, sprintf("Faction name\t"LIGHTBLUE"%s", Faction_GetNameID(Vehicle_GetExtraID(vehicle_index))));
					}
				}

				Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST, "Vehicle Info", output, "Close", "");
			}
			else SendErrorMessage(playerid, "Kendaraan tersebut bukan kendaraan server!");
		}
		case 11: // Plate Number
		{
			new plate[32];

			if(sscanf(nextParams, "ds[32]", vehicleid, plate))
				return SendSyntaxMessage(playerid, "/vehiclemenu platenumber [vehicleid] [plate]");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				format(VehicleData[vehicle_index][vehPlate], 32, plate);

				Vehicle_Respawn(vehicle_index, true);

				mysql_tquery(g_iHandle, sprintf("UPDATE `server_vehicles` SET `plate`='%s' WHERE `id`='%d';", SQL_ReturnEscaped(VehicleData[vehicle_index][vehPlate]), VehicleData[vehicle_index][vehIndex]));
				SendServerMessage(playerid, "Nomor plate kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah diganti menjadi "LIGHTBLUE"%s!", GetVehicleNameByVehicle(vehicleid), vehicleid, plate);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 12: // Siren
		{
			new siren;

			if(sscanf(nextParams, "dd", vehicleid, siren))
				return SendSyntaxMessage(playerid, "/vehiclemenu siren [vehicleid] [1/0]");

			if(!(0 <= siren <= 1))
				return SendErrorMessage(playerid, "Opsi siren hanya 0 dan 1");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				DestroyVehicle(vehicleid);
				VehicleData[vehicle_index][vehSiren] = siren;
	
				new veh_id = CreateVehicle(VehicleData[vehicle_index][vehModel], VehicleData[vehicle_index][vehPosX], VehicleData[vehicle_index][vehPosY], VehicleData[vehicle_index][vehPosZ], VehicleData[vehicle_index][vehPosRZ], VehicleData[vehicle_index][vehColor1], VehicleData[vehicle_index][vehColor2], -1, siren);
				VehicleData[vehicle_index][vehVehicleID] = veh_id;

				SetVehicleHealth(veh_id, VehicleData[vehicle_index][vehHealth]);
				LinkVehicleToInterior(veh_id, VehicleData[vehicle_index][vehInterior]);
				SetVehicleVirtualWorld(veh_id, VehicleData[vehicle_index][vehVirtual]);
				ChangeVehiclePaintjob(veh_id, VehicleData[vehicle_index][vehPaintjob]);

				for(new i = 0; i != 14; i++)
			    	AddVehicleComponent(veh_id, VehicleData[vehicle_index][vehMod][i]);

				UpdateVehicleDamageStatus(veh_id, VehicleData[vehicle_index][vehPanel], VehicleData[vehicle_index][vehDoor], VehicleData[vehicle_index][vehLight], VehicleData[vehicle_index][vehTires]);

				Vehicle_ExecuteInt(vehicle_index, "siren", siren);
				SendServerMessage(playerid, "Sirine kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah "LIGHTBLUE"%s!", GetVehicleNameByVehicle(veh_id), veh_id, siren ? ("diaktifkan") : ("dinonaktifkan"));
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 13: // engine
		{
			new engine;

			if(sscanf(nextParams, "dd", vehicleid, engine))
				return SendSyntaxMessage(playerid, "/vehiclemenu engine [vehicleid] [0/1]");

			if(!(0 <= engine <= 1))
				return SendErrorMessage(playerid, "Opsi engine hanya 0 dan 1");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				VehicleData[vehicle_index][vehEngineUpgrade] = engine;

				SendServerMessage(playerid, "Engine Upgrade kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah "LIGHTBLUE"di ubah!", GetVehicleNameByVehicle(vehicleid), vehicleid);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 14: // body
		{
			new body;

			if(sscanf(nextParams, "dd", vehicleid, body))
				return SendSyntaxMessage(playerid, "/vehiclemenu body [vehicleid] [0/3]");

			if(!(0 <= body <= 3))
				return SendErrorMessage(playerid, "Opsi body hanya 0 dan 3");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				VehicleData[vehicle_index][vehBodyUpgrade] = body;

				SendServerMessage(playerid, "Body Upgrade untuk kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah "LIGHTBLUE"di ubah!", GetVehicleNameByVehicle(vehicleid), vehicleid);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 15: // gas
		{
			new gas;

			if(sscanf(nextParams, "dd", vehicleid, gas))
				return SendSyntaxMessage(playerid, "/vehiclemenu gas [vehicleid] [0/2]");

			if(!(0 <= gas <= 2))
				return SendErrorMessage(playerid, "Opsi gas hanya 0 dan 2");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				VehicleData[vehicle_index][vehGasUpgrade] = gas;

				SendServerMessage(playerid, "Fuel Tank Upgrade kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah "LIGHTBLUE"di ubah!", GetVehicleNameByVehicle(vehicleid), vehicleid);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 16: // Turbo
		{
			new turbo;

			if(sscanf(nextParams, "dd", vehicleid, turbo))
				return SendSyntaxMessage(playerid, "/vehiclemenu turbo [vehicleid] [0-3]");

			// if(!(0 <= gas <= 3))
			// 	return SendErrorMessage(playerid, "Opsi turbo hanya 1 sampai 3");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				VehicleData[vehicle_index][vehTurbo] = turbo;

				SendServerMessage(playerid, "Turbo Charge Kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah "LIGHTBLUE"di ubah!", GetVehicleNameByVehicle(vehicleid), vehicleid);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 17: // Current Mileage
		{
			new Float:mileage;

			if(sscanf(nextParams, "df", vehicleid, mileage))
				return SendSyntaxMessage(playerid, "/vehiclemenu current_mileage [vehicleid] [amount of current mileage]");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				Vehicle_SetCurrentMileage(vehicleid, mileage);
				SendServerMessage(playerid, "Current Mileage Kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah "LIGHTBLUE"diubah menjadi %.4f!", GetVehicleNameByVehicle(vehicleid), vehicleid, mileage);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		case 18: // Durability Mileage
		{
			new Float:mileage;

			if(sscanf(nextParams, "df", vehicleid, mileage))
				return SendSyntaxMessage(playerid, "/vehiclemenu durability_mileage [vehicleid] [amount of durability mileage]");

			if(!IsValidVehicle(vehicleid))
				return SendErrorMessage(playerid, "Kendaraan tidak valid (tidak spawn)!");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				Vehicle_SetDurabilityMileage(vehicleid, mileage);
				SendServerMessage(playerid, "Durability Mileage Kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") telah "LIGHTBLUE"diubah menjadi %.4f!", GetVehicleNameByVehicle(vehicleid), vehicleid, mileage);
			}
			else SendErrorMessage(playerid, "ID kendaraan tidak terdaftar sebagai kendaraan server!");
		}
		default:
		{
			SendSyntaxMessage(playerid, "/vehiclemenu [entity]");
			SendSyntaxMessage(playerid, "Entity: playerveh/factionveh/sidejobveh/dmvcar/delete/position/color/insurance/turbo");
			SendSyntaxMessage(playerid, "Entity: unmod/info/platenumber/siren/engine/body/current_mileage/durability_mileage");
		}
	}
	return 1;
}


/** Owned Vehicle commands
*
*/

SSCANF:PlayerVehicle(string[]) 
{
	if(!strcmp(string,"engine",true)) return 1;
	else if(!strcmp(string,"lock",true)) return 2;
	else if(!strcmp(string,"trunk",true)) return 3;
	else if(!strcmp(string,"hood",true)) return 4;
	else if(!strcmp(string,"track",true)) return 5;
	else if(!strcmp(string,"lights",true)) return 6;
	else if(!strcmp(string,"list",true)) return 7;
	else if(!strcmp(string,"tow",true)) return 8;
	else if(!strcmp(string,"sell",true)) return 9;
	else if(!strcmp(string,"unmod",true)) return 10;
	else if(!strcmp(string,"registration",true)) return 11;
	else if(!strcmp(string,"speedo",true)) return 12;
	else if(!strcmp(string,"speedometer",true)) return 12;
	else if(!strcmp(string,"checkstorage",true)) return 13;
	else if(!strcmp(string,"park",true)) return 14;
	else if(!strcmp(string,"sharekey",true)) return 15;
	else if(!strcmp(string,"radio", true)) return 16;
	else if(!strcmp(string,"window", true)) return 17;

	return 0;
}

CMD:v(playerid, params[])
	return cmd_vehicle(playerid, params);

CMD:togneon(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kemudikan kendaraan untuk menghidupkan neon!.");

	new vehicleid;
	vehicleid = GetPlayerVehicleID(playerid);
	if(GetEngineStatus(vehicleid))
	{
		Vehicle_TogNeon(playerid, vehicleid);
	}
	else 
	{
		SendErrorMessage(playerid, "Kendaraan belum menyala");
	}
	return 1;
}
PlayerDrivingOwnedVehicle(vehicleid)
{
	foreach(new i : Player)
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid)
		{
			return 1;
		}
	}
	return 0;
}
stock GetVehicleDriverID(vehicleid)
{
	if (vehicleid == INVALID_VEHICLE_ID)
	{
		return INVALID_PLAYER_ID;
	}

	foreach(new i : Player)
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid)
		{
			return i;
		}
	}
	return INVALID_PLAYER_ID;
}
CMD:scrapyard(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 10.0, 2410.4741, -1425.8549, 23.9830))
	{
		new 
			vehid = GetPlayerVehicleID(playerid),
			vehicleid = Vehicle_ReturnID(vehid),
			string[255],
			price
		;
		
		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You need to be inside vehicle to use this command");
		
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return SendErrorMessage(playerid, "You need to be sit inside vehicle as driver to use this command!");

		if(vehicleid == -1)
			return 0;

		if(Vehicle_IsOwned(playerid, vehicleid))
		{
			if(IsABicycle(vehid)) price = 500;
			else if(IsABike(vehid)) price = 1000;
			else if(IsSportCar(vehid)) price = 1500;
			else price = 1750; 

			SetPVarInt(playerid, "VehPrice", price);
			format(string, sizeof(string), "Are you sure you want to destroy this vehicle for "GREEN"%s ?", FormatNumber(price));
			Dialog_Show(playerid, Scrapyard, DIALOG_STYLE_MSGBOX, "Vehicle Scrapyard", string, "Yes", "No");
		}
		else SendErrorMessage(playerid, "This is not your vehicle!");
	}
	else SendErrorMessage(playerid, "You're not at scrapyard!");
	return 1;
}
Dialog:Scrapyard(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			price = GetPVarInt(playerid, "VehPrice"),
			vehid = GetPlayerVehicleID(playerid),
			vehicleid = Vehicle_ReturnID(vehid)
		;

		if(vehicleid == -1)
			return 0;
			
		SendServerMessage(playerid, "Kendaraan "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") milikmu telah di hancurkan!", GetVehicleNameByVehicle(vehid), vehid);
		SendServerMessage(playerid, "Kamu mendapatkan uang sejumlah "GREEN"%s "WHITE"dari kendaraanmu!", FormatNumber(price));
		Vehicle_Delete(vehicleid);
		GiveMoney(playerid, price, ECONOMY_TAKE_SUPPLY, "scrap a vehicle");

	}
	return 1;
}
Dialog:WindowsControl(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new vehicleid = GetPlayerVehicleID(playerid),
            driver, passenger, backleft, backright;

        GetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright);

        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            switch(listitem)
            {
                case 0: SetVehicleParamsCarWindows(vehicleid, !driver, passenger, backleft, backright);
                case 1: SetVehicleParamsCarWindows(vehicleid, driver, !passenger, backleft, backright);
                case 2: SetVehicleParamsCarWindows(vehicleid, driver, passenger, !backleft, backright);
                case 3: SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, !backright);
                default: SetVehicleParamsCarWindows(vehicleid, !driver, !driver, !driver, !driver);
            }
            ShowPlayerFooter(playerid, "You've toggle vehicle window.");
        }
    }
    return 1;
}
// CMD:window(playerid, params[]) 
// {
// 	new type, driver, passenger, backleft, backright, vehicle_index, vehicleid, vehid;
// 	if(sscanf(params, "d", type))
// 		return SendSyntaxMessage(playerid, "/window [0 driver - 1 passenger - 2 backleft - 3 backright");

// 	if(IsPlayerInAnyVehicle(playerid))
// 	{
// 		vehicleid = GetPlayerVehicleID(playerid);
// 		vehicle_index = Vehicle_ReturnID(vehicleid);
// 		if(vehicle_index == -1) return 0;
// 		vehid = VehicleData[vehicle_index][vehVehicleID];
// 		GetVehicleParamsCarWindows(vehid, &driver, &passenger, &backleft, &backright);
// 		switch(type)
// 		{
// 			case 0:
// 			{
// 				if(driver == 1)
// 					SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright)
// 			}
// 			case 1:
// 			{
		
// 			}
// 			case 2:
// 			{

// 			}
// 			case 3:
// 			{

// 			}
// 		}
// 	}
// 	return 1;
// }

CMD:vehicle(playerid, params[]) 
{
	new action, vehicleid, vehicle_index, nextParams[128];

	if(sscanf(params, "k<PlayerVehicle>S()[128]", action, nextParams))
	{
		SendSyntaxMessage(playerid, "/vehicle [entity]");
		SendSyntaxMessage(playerid, "Entity : engine/lock/sharekey/track/lights/hood/trunk/window");
		SendSyntaxMessage(playerid, "Entity : list/tow/sell/registration/unmod/speedometer/checkstorage");
		return 1;
	}	
	switch(action) 
	{
		case 1: // Engine
		{
			vehicleid = GetPlayerVehicleID(playerid);

			if(PlayerData[playerid][pInjured])
				return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu terluka parah, tidak bisa menghidupkan mesin!.");

			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kemudikan kendaraan untuk menghidupkan mesin!.");

			if(!IsEngineVehicle(vehicleid))
            	return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kendaraan ini tidak menggunakan mesin!.");

			if(ReturnVehicleHealth(vehicleid) <= 300)
				return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Mesin kendaraan rusak, gagal menghidupkan mesin!.");

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				if(VehicleData[vehicle_index][vehFuel] <= 0)
					return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Bahan bakar habis!!.");

				if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER && !Vehicle_IsOwned(playerid, vehicle_index) && !Vehicle_IsSharedToPlayer(playerid, vehicle_index))
					return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kunci kendaraan ini!.");

				if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_RENTAL && !Vehicle_IsRented(playerid, vehicle_index))
					return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kunci kendaraan rental ini!");

				if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_FACTION && Vehicle_GetExtraID(vehicle_index) != GetPlayerFactionID(playerid))
					return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kunci kendaraan faction ini!");

				if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_NONE && !GetAdminLevel(playerid))
					return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kendaraan ini hanya dapat dioperasikan oleh admin!");
			}

			if(GetEngineStatus(vehicleid))
			{
				SetEngineStatus(vehicleid, false);
				VehicleData[vehicle_index][vehEngineStatus] = 0;
				SetLightStatus(vehicleid, false); 
				ShowPlayerFooter(playerid, "Mesin kendaraan telah ~r~dinonaktifkan");
				cmd_ame(playerid, "reaches vehicle key, turn the ignition key to off.");
			}
			else 
			{
				if(GetPVarInt(playerid, "VehicleEngine"))
					return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tunggu hingga mesin aktif!");

				defer TurnEngineOn(playerid, vehicleid);
				SetPVarInt(playerid, "VehicleEngine", 1);
				ShowPlayerFooter(playerid, "Mengaktifkan mesin kendaraan ...");
				cmd_ame(playerid, "reaches vehicle key, turn the ignition key to on.");
			}
		}
		case 2: // Lock
		{
			if(IsPlayerInAnyVehicle(playerid)) 
			{
				vehicleid = GetPlayerVehicleID(playerid);
				if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
				{
					if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER && !Vehicle_IsOwned(playerid, vehicle_index) && !Vehicle_IsSharedToPlayer(playerid, vehicle_index))
						return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kunci kendaraan ini!.");

					if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_RENTAL && !Vehicle_IsRented(playerid, vehicle_index))
						return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kunci kendaraan rental ini!");

					if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_FACTION)
						return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kendaraan faction tidak perlu dikunci");

					if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_DRIVING_SCHOOL)
						return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kendaraan DMV tidak bisa di kunci");

					if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_SIDEJOB)
						return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kendaraan sidejob tidak bisa di kunci!");
				}
				SetDoorStatus(vehicleid, ((GetDoorStatus(vehicleid)) ? false : true));
				GameTextForPlayer(playerid, sprintf("~w~VEHICLE %s", ((GetDoorStatus(vehicleid)) ? ("~r~Locked") : ("~g~Unlocked"))), 3000, 6);
			}
			else
			{
				new vw = GetPlayerVirtualWorld(playerid);
				new rvid = (vw - 1000000);
				if(vw > 1000000 && vw < 1200000)
				{
					SetDoorStatus(rvid, ((GetDoorStatus(rvid)) ? false : true));
					GameTextForPlayer(playerid, sprintf("~w~VEHICLE %s", ((GetDoorStatus(rvid)) ? ("~r~Locked") : ("~g~Unlocked"))), 3000, 6);
					return 1;
				}

				if(!Vehicle_PlayerCount(playerid) && !Vehicle_RentedCount(playerid))
					return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kendaraan untuk di kunci!");

				new vehicle_list[4096], count, Float:x, Float:y, Float:z;

				strcat(vehicle_list, "Model\tDistance (m)\n");
				
				foreach(new vehicle : OwnedVehicles<playerid>)
				{
					GetVehiclePos(VehicleData[vehicle][vehVehicleID], x, y, z);
					strcat(vehicle_list, sprintf("%s%s\t%.2f\n", ((GetDoorStatus(VehicleData[vehicle][vehVehicleID])) ? RED : GREEN), GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), GetPlayerDistanceFromPoint(playerid, x, y, z)));
					g_selected_vehicle[playerid][count++] = vehicle;
				}
				
				foreach(new vehicle : RentedVehicles<playerid>)
				{
					GetVehiclePos(VehicleData[vehicle][vehVehicleID], x, y, z);
					strcat(vehicle_list, sprintf("%s%s (Rental)\t%.2f\n", ((GetDoorStatus(VehicleData[vehicle][vehVehicleID])) ? RED : GREEN), GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), GetPlayerDistanceFromPoint(playerid, x, y, z)));
					g_selected_vehicle[playerid][count++] = vehicle;
				}

				foreach(new vehicle : Vehicle)
				{
					if(Vehicle_IsSharedToPlayer(playerid, vehicle))
					{
						GetVehiclePos(VehicleData[vehicle][vehVehicleID], x, y, z);
						strcat(vehicle_list, sprintf("%s%s (Shared)\t%.2f\n", ((GetDoorStatus(VehicleData[vehicle][vehVehicleID])) ? RED : GREEN), GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), GetPlayerDistanceFromPoint(playerid, x, y, z)));
						g_selected_vehicle[playerid][count++] = vehicle;						
					}
				}
				// vehicleid = Vehicle_Nearest(playerid, 5);
				// if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID && Vehicle_IsSharedToPlayer(playerid, vehicle_index))
				// {
				// 	SetDoorStatus(vehicleid, ((GetDoorStatus(vehicleid)) ? false : true));
				// 	GameTextForPlayer(playerid, sprintf("~w~VEHICLE %s", ((GetDoorStatus(vehicleid)) ? ("~r~Locked") : ("~g~Unlocked"))), 3000, 6);
				// }
				// else
				// {
				Dialog_Show(playerid, LockVehicle, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Lock", vehicle_list, "Select", "Close");
				// }

			}
		}
		case 3: // Trunk
		{
			new nearest_vehicle;

			if(PlayerData[playerid][pInjured]) 
                return SendErrorMessage(playerid, "Keadaan terluka (injured) tidak dapat mengoperasikan perintah ini.");
            
            if(IsPlayerInAnyVehicle(playerid))
            {
                if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kemudikan kendaraan untuk mengoperasikan bagasi!.");

			    if((vehicleid = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID)
			    {
					if(IsABike(vehicleid))
				        return SendErrorMessage(playerid, "Kendaraan ini tidak memiliki bagasi!.");

			    	SetTrunkStatus(vehicleid, GetTrunkStatus(vehicleid) ? false : true);
					SendCustomMessage(playerid, "VEHICLE", "Trunk %s", ((GetTrunkStatus(vehicleid)) ? (GREEN"Opened") : (RED"Closed")));
			    }
            }
            else
            {
	            new index;

	            if((nearest_vehicle = Vehicle_Nearest(playerid)) != -1)
				{
		            if(!IsDoorVehicle(nearest_vehicle)) 
		                return SendErrorMessage(playerid, "Kendaraan ini tidak memiliki bagasi!");
					
		            if(GetDoorStatus(nearest_vehicle)) 
		                return SendErrorMessage(playerid, "Kendaraan dalam keadaan terkunci, buka terlebih dahulu!");

		            if((index = Vehicle_ReturnID(nearest_vehicle)) == RETURN_INVALID_VEHICLE_ID)
		            	return SendErrorMessage(playerid, "Ini bukan kendaraan server!");

	            	if(!Vehicle_IsOwned(playerid, index))
		            	return SendErrorMessage(playerid, "Ini bukan kendaraan milikmu");

            		SetPVarInt(playerid, "CarStorage", nearest_vehicle);
            		SetPVarInt(playerid, "CarStorageIndex", index);

			    	Vehicle_ShowTrunk(playerid, index);
			    	SetTrunkStatus(nearest_vehicle, true);
				}
				else SendErrorMessage(playerid, "Kamu tidak berada dekat dengan kendaraan lainnya!");
            }
		}
		case 4: // Hood
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kemudikan kendaraan untuk mengoperasikan kap!.");

		    if((vehicleid = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID)
		    {
				if(IsABike(vehicleid))
			        return SendErrorMessage(playerid, "Kendaraan ini tidak memiliki kap!.");

		    	SetHoodStatus(vehicleid, GetHoodStatus(vehicleid) ? false : true);
				SendCustomMessage(playerid, "VEHICLE", "Hood %s", ((GetHoodStatus(vehicleid)) ? (GREEN"Opened") : (RED"Closed")));
		    }
		}
		case 5: // Tracking
		{
			if(!Vehicle_PlayerCount(playerid) && !Vehicle_RentedCount(playerid))
				return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kendaraan!");

			new vehicle_list[4096], count, Float:x, Float:y, Float:z;

			strcat(vehicle_list, "Name (id)\tStatus\tDistance (m)\n");
			foreach(new vehicle : OwnedVehicles<playerid>)
			{
				if(!PlayerDrivingOwnedVehicle(VehicleData[vehicle][vehVehicleID]))
				{
					GetVehiclePos(VehicleData[vehicle][vehVehicleID], x, y, z);
					strcat(vehicle_list, sprintf(""CYAN"%s (%d)\t%s\t"WHITE"%.2f\n", GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), VehicleData[vehicle][vehVehicleID], GetDoorStatus(VehicleData[vehicle][vehVehicleID]) ? (RED"Locked") : (GREEN"Unlocked"), GetPlayerDistanceFromPoint(playerid, x, y, z)));
					g_selected_vehicle[playerid][count++] = vehicle;
				}
			}

			foreach(new vehicle : RentedVehicles<playerid>)
			{
				GetVehiclePos(VehicleData[vehicle][vehVehicleID], x, y, z);
				strcat(vehicle_list, sprintf(""LIGHTBLUE"%s (%d)\t%s\t"WHITE"%.2f\n", GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), VehicleData[vehicle][vehVehicleID], GetDoorStatus(VehicleData[vehicle][vehVehicleID]) ? (RED"Locked") : (GREEN"Unlocked"), GetPlayerDistanceFromPoint(playerid, x, y, z)));
				g_selected_vehicle[playerid][count++] = vehicle;
			}

			DisableWaypoint(playerid);
			Dialog_Show(playerid, TrackVehicle, DIALOG_STYLE_TABLIST_HEADERS, "Track Vehicle", vehicle_list, "Select", "Close");
		}
		case 6: // Lights
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kemudikan kendaraan untuk mengoperasikan lampu!.");

		    if((vehicleid = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID) 
		    {
		    	SetLightStatus(vehicleid, GetLightStatus(vehicleid) ? false : true);
				SendCustomMessage(playerid, "VEHICLE", "Lights %s", ((GetLightStatus(vehicleid)) ? (GREEN"Enabled") : (RED"Disable")));
		    }
		}
		case 7: //List
		{
			new 
				Cache:execute, 
				output[4096], 
				state_list[][] = 
				{
					"None", 
					GREEN"Spawned", 
					RED"Death", 
					YELLOW"Insurance", 
					LIGHTBLUE"Impounded", 
					LIGHTBLUE"Parked",  
					LIGHTBLUE"House Parked",
					LIGHTBLUE"Apartment Parked"
				};

			execute = mysql_query(g_iHandle, sprintf("SELECT `model`, `state`, `insurance` FROM `server_vehicles` WHERE `extraid`='%d' AND `type`='%d';", GetPlayerSQLID(playerid), VEHICLE_TYPE_PLAYER));

			if(cache_num_rows())
			{
				strcat(output, sprintf("Model\tState\tInsurance\n"));
				for(new i = 0; i != cache_num_rows(); i++)
				{
					new model = cache_get_field_int(i, "model"),
						states = cache_get_field_int(i, "state"),
						insurance = cache_get_field_int(i, "insurance");

					strcat(output, sprintf(WHITE"%s\t%s\t%d\n", GetVehicleNameByModel(model), state_list[states], insurance));
				}
				Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Vehicle List - %s", ConvertTimestamp(Timestamp:gettime())), output, "Close", "");
			}
			else SendErrorMessage(playerid, "Kamu tidak memiliki kendaraan untuk dimuat!");

			cache_delete(execute);
		}
		case 8: // Towing
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
				return SendErrorMessage(playerid, "Kemudikan tow truck untuk menggunakan perintah ini!.");

			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return SendErrorMessage(playerid, "Kamu harus berada diposisi pengemudi!");

			if(GetVehicleTrailer(GetPlayerVehicleID(playerid)))
			{
		        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has unhooked the %s from the tow truck.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid))));
				DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
			}
			else 
			{
				vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid));

	    	    if((vehicleid = GetVehicleFromBehind(GetPlayerVehicleID(playerid))) == INVALID_VEHICLE_ID) 
	    	    	return SendErrorMessage(playerid, "Tidak ada kendaraan didekatmu.");

		        if(!IsDoorVehicle(vehicleid) || IsAPlane(vehicleid) || IsABoat(vehicleid) || IsAHelicopter(vehicleid)) 
		        	return SendErrorMessage(playerid, "Tidak bisa menderek kendaraan tersebut.");

		        AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
		        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has hooked a %s onto their tow truck.", ReturnName(playerid, 0), GetVehicleNameByVehicle(vehicleid));

		        if((vehicle_index = Vehicle_ReturnID(vehicleid)) != -1 && Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER)
		        {
		            foreach(new i : Player) if(GetPlayerSQLID(i) == Vehicle_GetExtraID(vehicle_index))
		            {
						Vehicle_StopHandbrake(vehicle_index);
		                SendServerMessage(playerid, "Kamu telah menderek "YELLOW"%s "WHITE"kendaraan milik "RED"%s.", GetVehicleNameByVehicle(vehicleid), ReturnName(i, 0));
		                SendServerMessage(i, "Kendaraan "YELLOW"%s "WHITE"milikmu diderek oleh "RED"%s.", GetVehicleNameByVehicle(vehicleid), ReturnName(playerid, 0));

		                break;
		            }
		        }
			}
		}
		case 9: // Sell
		{
			static targetid, price;

			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return SendErrorMessage(playerid, "Kemudikan kendaraan milikmu!");

			if(sscanf(nextParams, "ud", targetid, price))
				return SendSyntaxMessage(playerid, "/v sell [playerid/PartOfName] [price]");

			if(targetid == INVALID_PLAYER_ID || targetid == playerid)
				return SendErrorMessage(playerid, "Player yang dituju tidak valid!");

			if(!IsPlayerNearPlayer(playerid, targetid, 5))
				return SendErrorMessage(playerid, "Kamu tidak berada dekat dengan player tersebut!");

			if(IsVIPVehicle(GetVehicleModel(GetPlayerVehicleID(playerid))))
				return SendErrorMessage(playerid, "Ini kendaraan VIP, tidak dapat dijual!");

			new housevehicleslot = House_CountVehicleSlot(targetid);
			if(GetPlayerVIPLevel(targetid) > 2)
			{
				if(Vehicle_PlayerTotalCount(targetid) >= MAX_VIP_VEHICLES+housevehicleslot)
					return SendErrorMessage(playerid, "Kendaraan player tersebut sudah mencapai batas maksimal.");
			}
			else
			{
				if(Vehicle_PlayerTotalCount(targetid) >= MAX_PLAYER_VEHICLES+housevehicleslot)
					return SendErrorMessage(playerid, "Kendaraan player tersebut sudah mencapai batas maksimal.");
			}

			if(price < 1)
				return SendErrorMessage(playerid, "Harga tidak bisa dibawah $1.");

			if((vehicle_index = Vehicle_ReturnID(GetPlayerVehicleID(playerid))) != RETURN_INVALID_VEHICLE_ID)
			{
				if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER && GetPlayerSQLID(playerid) == Vehicle_GetExtraID(vehicle_index))
				{
					PlayerData[targetid][pCarSeller] = playerid;
			        PlayerData[targetid][pCarOffered] = vehicle_index;
			        PlayerData[targetid][pCarValue] = price;

			        SendServerMessage(playerid, "Kamu menawarkan "CYAN"%s "WHITE"seharga "GREEN"%s "WHITE"kepada "YELLOW"%s.", GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)), FormatNumber(price), ReturnName(targetid, 0));
			        SendServerMessage(targetid, ""YELLOW"%s "WHITE"menawarkan "CYAN"%s "WHITE"seharga "GREEN"%s "WHITE"'/approve car' untuk menerima.", ReturnName(playerid, 0), GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)), FormatNumber(price));
				}
				else SendErrorMessage(playerid, "Ini bukan kendaraan milikmu!");
			}
			else SendErrorMessage(playerid, "Ini bukan kendaraan milikmu!");
		}
		case 10: // Unmod
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return SendErrorMessage(playerid, "Kemudikan kendaraan milikmu!");

        	if(isnull(nextParams) || (!isnull(nextParams) && strcmp(nextParams, "confirm", true) != 0))
				return SendSyntaxMessage(playerid, "/vehicle unmod 'confirm' (perintah ini akan menghapus semua modifikasi pada kendaraan ini, termasuk paintjob)");

			if((vehicle_index = Vehicle_ReturnID(GetPlayerVehicleID(playerid))) != RETURN_INVALID_VEHICLE_ID)
			{
				if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER && GetPlayerSQLID(playerid) == Vehicle_GetExtraID(vehicle_index))
				{
					for (new i = 0; i < 14; i ++)
					{
						if(!VehicleData[vehicle_index][vehMod][i])
							continue;

		                RemoveVehicleComponent(GetPlayerVehicleID(playerid), VehicleData[vehicle_index][vehMod][i]);
		                VehicleData[vehicle_index][vehMod][i] = 0;
		            }

		            // Remove paintjob
		            ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 3);

		            // Modding remove
					mysql_tquery(g_iHandle, sprintf("DELETE FROM `vehicle_mod` WHERE `vehicleid`='%d';", VehicleData[vehicle_index][vehIndex]));
		            SendServerMessage(playerid, "Modifikasi kendaraan "CYAN"%s "WHITE"milikmu telah dihapus, termasuk paintjob.", GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)));
				}
				else SendErrorMessage(playerid, "Ini bukan kendaraan milikmu!");
			}
			else SendErrorMessage(playerid, "Ini bukan kendaraan milikmu!");
		}
		case 11: // Registration
		{
			static targetid;
			new string[4089];

			// if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			// 	return SendErrorMessage(playerid, "Kemudikan kendaraan milikmu!");

			if(sscanf(nextParams, "u", targetid))
				return SendSyntaxMessage(playerid, "/v registration [playerid/PartOfName]");

			if(targetid == INVALID_PLAYER_ID)
				return SendErrorMessage(playerid, "Player yang dituju tidak valid!");

			if(!IsPlayerNearPlayer(playerid, targetid, 5))
				return SendErrorMessage(playerid, "Kamu tidak berada dekat dengan player tersebut!");

			if(!Vehicle_PlayerCount(playerid))
				return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kendaraan untuk di show registrasinya!");

			SetPVarInt(playerid, "VehicleTargetRegist", targetid);
			strcat(string, "Vehicle ID\tVehicle Name\n");
			foreach(new vehicle : OwnedVehicles<playerid>)
			{
				strcat(string, sprintf("%d\t%s\n", vehicle, GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID])));
			}
			Dialog_Show(playerid, VehicleRegistration, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Registration", string, "Show", "Close");
		}
		case 12: // Speedometer
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return SendErrorMessage(playerid, "Kemudikan kendaraan untuk menggunakan perintah ini!");

			if(IsABicycle(GetPlayerVehicleID(playerid)))
				return SendErrorMessage(playerid, "Sepeda tidak memiliki speedometer!");

			PlayerData[playerid][pDisableSpeedo] = PlayerData[playerid][pDisableSpeedo] ? (false) : (true);

			if (PlayerData[playerid][pDisableSpeedo])
			{
				if(PlayerData[playerid][pHudStyle] == 0) Speedometer_Hide(playerid);
				else SpeedometerNew_Hide(playerid);
			}
			else
			{
				if(PlayerData[playerid][pHudStyle] == 0) Speedometer_Show(playerid);
				else SpeedometerNew_Show(playerid);
			}

			SendServerMessage(playerid, "Kamu telah %s "WHITE"tampilan speedometer!", PlayerData[playerid][pDisableSpeedo] ? (RED"menonaktifkan") : (GREEN"menampilkan"));
		}
		case 13: // Check Trunk
		{
			new nearest_vehicle;

		    // if(GetAdminLevel(playerid) < 1 && GetFactionType(playerid) != FACTION_POLICE)
            //     return SendErrorMessage(playerid, "Hanya polisi/admin yang dapat menggunakan perintah ini (/v trunk untuk akses kendaraan pribadi)!.");

            // if(GetFactionType(playerid) == FACTION_POLICE && !IsPlayerDuty(playerid))
            // 	return SendErrorMessage(playerid, "Duty terlebih dahulu!");
            
            new index;

            if((nearest_vehicle = Vehicle_Nearest(playerid)) == -1)
            	return SendErrorMessage(playerid, "Kamu tidak berada dekat dengan kendaraan lainnya (5 meter)!");

            if(!IsDoorVehicle(nearest_vehicle)) 
                return SendErrorMessage(playerid, "Kendaraan ini tidak memiliki bagasi!");
			
            if(GetDoorStatus(nearest_vehicle)) 
                return SendErrorMessage(playerid, "Kendaraan dalam keadaan terkunci, buka terlebih dahulu!");

            if((index = Vehicle_ReturnID(nearest_vehicle)) == RETURN_INVALID_VEHICLE_ID)
            	return SendErrorMessage(playerid, "Ini bukan kendaraan server!");

        	if(Vehicle_GetType(index) != VEHICLE_TYPE_PLAYER)
            	return SendErrorMessage(playerid, "Ini bukan kendaraan player, tidak ada item didalam bagasi!");

    		SetPVarInt(playerid, "CarStorageIndex", index);
    		SetPVarInt(playerid, "CarStorage", nearest_vehicle);

	    	Vehicle_ShowTrunk(playerid, index);
	    	SetTrunkStatus(nearest_vehicle, true);
		}
		case 16:
		{
			vehicleid = GetPlayerVehicleID(playerid);
			vehicle_index = Vehicle_ReturnID(vehicleid);

			if(vehicle_index == -1)
				return 1;

			if(!IsVehicleHaveStereoInstalled(vehicle_index))
				return SendErrorMessage(playerid, "You dont have car stereo installed!");

			if(!IsPlayerInAnyVehicle(playerid))
				return SendErrorMessage(playerid, "You need to be inside vehicle to use this command");
			
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return SendErrorMessage(playerid, "You need to be sit as driver to use this command!");

			Dialog_Show(playerid, VehicleAudioPlayer, DIALOG_STYLE_INPUT, "Vehicle Radio", "Input link URL to start listening to Radio - Masukan Off untuk mematikan lagu!", "Insert", "Close");

		}
		case 17:
		{
			vehicleid = GetPlayerVehicleID(playerid);
			vehicle_index = Vehicle_ReturnID(vehicleid);

			if(vehicle_index == -1)
				return 1;

			if(!IsPlayerInAnyVehicle(playerid))
				return SendErrorMessage(playerid, "You need to be inside vehicle to use this command");
			
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				return SendErrorMessage(playerid, "You need to be sit as driver to use this command!");

			if(!IsFourWheelVehicle(vehicleid))
				return SendErrorMessage(playerid, "You only able to use this command inside a car!");

			Dialog_Show(playerid, WindowsControl, DIALOG_STYLE_LIST, "Vehicle Windows Control", "Driver Seat\nPassenger Seat\nBack Left\nBack Right\nClose All", "Choose", "Close");
		}
		default: 
		{
			SendSyntaxMessage(playerid, "/vehiclemenu [entity]");
			SendSyntaxMessage(playerid, "Entity: playerveh/factionveh/sidejobveh/dmvcar/delete/position/color/insurance/turbo");
			SendSyntaxMessage(playerid, "Entity: unmod/info/platenumber/siren/engine/body/current_mileage/durability_mileage");
		}
	}
	return 1;
}


// Admin Commands
CMD:gpc(playerid, params[])
	return cmd_gotoplayercars(playerid, params);

CMD:gotoplayercars(playerid, params[])
{
	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	new targetid;

	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/gotoplayercars [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Player tersebut tidak login!");

	if(!Vehicle_PlayerCount(targetid) && !Vehicle_RentedCount(targetid))
		return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Player tersebut tidak memiliki kendaraan!", _, 1);

	new vehicle_list[500], count, Float:x, Float:y, Float:z;

	strcat(vehicle_list, "Name (id)\tInsu\n");
	foreach(new vehicle : OwnedVehicles<targetid>)
	{
		strcat(vehicle_list, sprintf(""CYAN"%s (%d)\t%d\n", GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), VehicleData[vehicle][vehVehicleID], VehicleData[vehicle][vehInsurance]));
		g_selected_vehicle[playerid][count++] = vehicle;
	}

	foreach(new vehicle : RentedVehicles<targetid>)
	{
		GetVehiclePos(VehicleData[vehicle][vehVehicleID], x, y, z);
		strcat(vehicle_list, sprintf(""LIGHTBLUE"Rental %s (%d)\t \n", GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), VehicleData[vehicle][vehVehicleID]));
		g_selected_vehicle[playerid][count++] = vehicle;
	}

	Dialog_Show(playerid, PlayerCars, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s's - Vehicle(s)", ReturnName(targetid, 0)), vehicle_list, "Teleport", "Close");
	return 1;
}

CMD:pcl(playerid, params[])
	return cmd_playercarlist(playerid, params);

CMD:playercarlist(playerid, params[])
{
	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	new targetid;

	if(sscanf(params, "u", targetid))
		return SendSyntaxMessage(playerid, "/playercarlist [playerid/PartOfName]");

	if(targetid == INVALID_PLAYER_ID)
		return SendErrorMessage(playerid, "Player tersebut tidak login!");

	new
		Cache:execute,
		output[500],
		state_list[][] =
		{
			"None",
			GREEN"Spawned",
			RED"Death",
			YELLOW"Insurance",
			LIGHTBLUE"Impounded",
			LIGHTBLUE"Parked",
			LIGHTBLUE"House Parked",
			LIGHTBLUE"Apartment Parked"
		};

	execute = mysql_query(g_iHandle, sprintf("SELECT `model`, `state`, `insurance` FROM `server_vehicles` WHERE `extraid`='%d' AND `type`='%d';", GetPlayerSQLID(targetid), VEHICLE_TYPE_PLAYER));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\tState\tInsurance\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
			new 
				model = cache_get_field_int(i, "model"),
				states = cache_get_field_int(i, "state"),
				insurance = cache_get_field_int(i, "insurance")
			;

			strcat(output, sprintf(WHITE"%s\t%s\t%d\n",GetVehicleNameByModel(model), state_list[states], insurance));
		}
		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, sprintf("%s's - Vehicle List", ReturnName(targetid, 0)), output, "Close", "");
	}
	else SendErrorMessage(playerid, "Player tersebut tidak memiliki kendaraan untuk dimuat!");

	cache_delete(execute);
	return 1;
}

// Temporary vehicles
CMD:veh(playerid, params[])
{
	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	new vehicle_index, model[32], color1, color2, Float:x, Float:y, Float:z, Float:angle, engine;

	if(sscanf(params, "s[32]D(-1)D(-1)D(0)", model, color1, color2, engine))
		return SendSyntaxMessage(playerid, "/veh [model id/name] [color1] [color2]");

	if((model[0] = GetVehicleModelByName(model)) == 0)
		return SendErrorMessage(playerid, "Model ID kendaraan tidak valid!");

	if(!(-2 < color1 <= 255))
		return SendErrorMessage(playerid, "Warna1 hanya dibatasi hingga 0 - 255");

	if(!(-2 < color2 <= 255))
		return SendErrorMessage(playerid, "Warna2 hanya dibatasi hingga 0 - 255");

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	if((vehicle_index = Vehicle_Create(model[0], x, y, z, angle, color1, color2, false, ""TOMATO"STATIC")) != RETURN_INVALID_VEHICLE_ID) {
		SetPlayerPos(playerid, x, y, z+3);

		if(engine)
		{
			SetEngineStatus(VehicleData[vehicle_index][vehVehicleID], true);
			SetLightStatus(VehicleData[vehicle_index][vehVehicleID], true);
		}
		SendServerMessage(playerid, "Spawn "CYAN"%s "WHITE"(ID: "YELLOW"%d"WHITE") kendaraan temporary (/destroyveh untuk menghapus).", GetVehicleNameByModel(model[0]), VehicleData[vehicle_index][vehVehicleID]);
	}
	else SendErrorMessage(playerid, "Slot kendaraan sudah mencapai batas maksimal!");
	return 1;
}

CMD:dva(playerid, params[])
	return cmd_destroyvehall(playerid, "\0");

CMD:destroyvehall(playerid, params[])
{
	if (CheckAdmin(playerid, 3))
        return PermissionError(playerid);

	Vehicle_TemporaryDelete();
    SendServerMessage(playerid, "Berhasil menghapus semua kendaraan temporary.");
	return 1;
}
CMD:hpark(playerid, params[]) {
    return cmd_housepark(playerid,"");
}
CMD:hunpark(playerid, params[]) {
    return cmd_houseunpark(playerid,"");
}
CMD:houseunpark(playerid, params[])
{
    static id = -1;
	new Cache:execute, output[255], house_index;
	id = House_Nearest(playerid);
	
	if(id == -1)
		return SendErrorMessage(playerid, "You are not near any houses!");

	house_index = HouseData[id][houseID];

	if(house_index == -1)
		return 0;

	execute = mysql_query(g_iHandle, sprintf("SELECT `id`, `model` FROM `server_vehicles` WHERE `house_parking` ='%d' AND `extraid`='%d' AND `type`='%d';", house_index, GetPlayerSQLID(playerid), VEHICLE_TYPE_PLAYER));

    if(!IsPlayerInAnyVehicle(playerid) && House_IsOwner(playerid, id))
    {
		if(cache_num_rows())
		{
			strcat(output, sprintf("Model\n"));
			for(new i = 0; i != cache_num_rows(); i++)
			{
				new 
					vid = cache_get_field_int(i, "id"),
					model = cache_get_field_int(i, "model")
				;

				g_selected_vehicle[playerid][i] = vid;

				strcat(output, sprintf(WHITE"%s\n", GetVehicleNameByModel(model)));
			}
			Dialog_Show(playerid, HouseUnparkVehicle, DIALOG_STYLE_TABLIST_HEADERS, "House Parking", output, "Unpark", "Close");
		}
		else ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak ada kendaraanmu pada house parking!");
	}
	else SendErrorMessage(playerid, "You're not in range of your house!");

	cache_delete(execute);
	return 1;
}
Dialog:VehicleRegistration(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			vehicle_index = strval(inputtext),
			targetid = GetPVarInt(playerid, "VehicleTargetRegist")
		;
		new output[600];
		strcat(output, ""WHITE"["YELLOW"Vehicle Registration"WHITE"]\n\n");
		strcat(output, sprintf("Owned by: "LIGHTBLUE"%s.\n", ReturnName(playerid, 0)));
		strcat(output, sprintf(""WHITE"Vehicle model: "CYAN"%s.\n", GetVehicleNameByModel(VehicleData[vehicle_index][vehModel])));
		strcat(output, sprintf(""WHITE"Registration plate: "GREEN"%s.\n", VehicleData[vehicle_index][vehPlate]));
		strcat(output, sprintf(""WHITE"Insurance left: "YELLOW"%d.\n\n", VehicleData[vehicle_index][vehInsurance]));
		strcat(output, ""WHITE"["GREEN"Vehicle Upgrade"WHITE"]\n\n");
		if(VehicleData[vehicle_index][vehEngineUpgrade] == 1) strcat(output, sprintf(""WHITE"Engine Upgrade: "GREEN"Upgraded\n"));
		else strcat(output, sprintf(""WHITE"Engine Upgrade: "RED"Not Upgraded\n"));

		if(VehicleData[vehicle_index][vehBodyUpgrade] == 3) strcat(output, sprintf(""WHITE"Body Upgrade: "GREEN"Upgraded\n"));
		else strcat(output, sprintf(""WHITE"Body Upgrade: "RED"Not Upgraded\n"));

		if(VehicleData[vehicle_index][vehGasUpgrade] == 2) strcat(output, sprintf(""WHITE"Fuel Tank Upgrade: "GREEN"Upgraded\n"));
		else strcat(output, sprintf(""WHITE"Fuel Tank Upgrade: "RED"Not Upgraded\n"));

		if(VehicleData[vehicle_index][vehTurbo] >= 1) strcat(output, sprintf(""WHITE"Turbo Charge Level : "GREEN"%d\n",VehicleData[vehicle_index][vehTurbo]));
		else strcat(output, sprintf(""WHITE"Turbo Upgrade: "RED"Not Upgraded\n"));
		
		Dialog_Show(targetid, ShowOnly, DIALOG_STYLE_MSGBOX, "Vehicle Registration", output, "Close", "");
	}
	return 1;
}
Dialog:HouseUnparkVehicle(playerid, response, listitem, inputtext[]) 
{
	if(response)
	{
		new id = g_selected_vehicle[playerid][listitem],
			houseid = House_Nearest(playerid)
		;

		if(houseid == -1)
			return 0;

		mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET `house_parking`='-1',`state`='%d' WHERE `id`='%d';", VEHICLE_STATE_SPAWNED ,id));
		
		mysql_tquery(g_iHandle, sprintf("SELECT * FROM `server_vehicles` WHERE `id`='%d';", id), "VehicleLoaded", "d", playerid);

		HouseData[houseid][houseParkingSlotUsed]--;
		if(HouseData[houseid][houseParkingSlotUsed] <= 0)
		{
			HouseData[houseid][houseParkingSlotUsed] = 0;
		}
		SendServerMessage(playerid, "Kamu telah mengeluarkan "CYAN"%s "WHITE"dari "YELLOW"house parking.", inputtext);
		House_Save(houseid);
	}
	return 1;
}

CMD:resethousepark(playerid, params[])
{
    static
        id = -1;

	if(CheckAdmin(playerid, 6))
        return PermissionError(playerid);

    if(!IsPlayerInAnyVehicle(playerid) && (id = House_Nearest(playerid)) != -1)
    {
		HouseData[id][houseParkingSlotUsed] = 0;
		SendServerMessage(playerid, "You reset parking slot used for house id %d", id);
	}
	else SendErrorMessage(playerid, "You're not in range of your house!");
	return 1;
}

CMD:housepark(playerid, params[])
{
    static
        id = -1;

    if(!IsPlayerInAnyVehicle(playerid) && (id = House_Nearest(playerid)) != -1 && House_IsOwner(playerid, id))
    {
		new vehicle_list[2000], count, Float:x, Float:y, Float:z;

		strcat(vehicle_list, "Model\tDistance (m)\n");
		
		foreach(new vehicle : OwnedVehicles<playerid>)
		{
			GetVehiclePos(VehicleData[vehicle][vehVehicleID], x, y, z);
			strcat(vehicle_list, sprintf("%s\t%.2f\n", GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), GetPlayerDistanceFromPoint(playerid, x, y, z)));
			g_selected_vehicle[playerid][count++] = vehicle;
		}
		Dialog_Show(playerid, HouseParkVehicle, DIALOG_STYLE_TABLIST_HEADERS, "House Parking", vehicle_list, "Select", "Close");
	}
	else SendErrorMessage(playerid, "You're not in range of your house!");
	return 1;
}
Dialog:HouseParkVehicle(playerid, response, listitem, inputtext[]) 
{
	if(response)
	{
		new 
			id = g_selected_vehicle[playerid][listitem],
			houseid,
			Float:x,
			Float:y,
			Float:z,
			house_index 	
		;


		GetVehiclePos(VehicleData[id][vehVehicleID], x, y, z);

		if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 20)
		{
			return SendErrorMessage(playerid, "Kendaraan terlalu jauh dari posisi rumahmu!");
		}
		houseid = House_Nearest(playerid);
		house_index = HouseData[houseid][houseID];

		if(houseid == -1)
			return 0;

		if(HouseData[houseid][houseParkingSlotUsed] >= HouseData[houseid][houseParkingSlot])
			return SendErrorMessage(playerid, "Your house parking space is full!");

		if(Vehicle_IsOwned(playerid, id))
		{
			if(VehicleData[id][vehModel] == 508)
			{
				foreach(new i : Player) 
				{
					new vw = GetPlayerVirtualWorld(i);
					if(vw > MIN_VIRTUAL_WORLD && vw < MAX_VIRTUAL_WORLD && (vw-MIN_VIRTUAL_WORLD) == VehicleData[id][vehVehicleID])
					{
						SetOutsideRV(i, VehicleData[id][vehVehicleID]);					
					}
				}
			}
			HouseData[houseid][houseParkingSlotUsed]++;
			if(HouseData[houseid][houseParkingSlotUsed] >= HouseData[houseid][houseParkingSlot])
			{
				HouseData[houseid][houseParkingSlotUsed] = HouseData[houseid][houseParkingSlot];
			}
			Vehicle_Save(id);

			mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET `house_parking`='%d',`state`='%d' WHERE `id`='%d';", house_index, VEHICLE_STATE_HOUSEPARKED, VehicleData[id][vehIndex]));

			Vehicle_Delete(id, false);
			SendServerMessage(playerid, "You park your vehicle on house parking!");
			House_Save(houseid);
		}

	}
	return 1;
}
IsAtPublicParking(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 3, 1630.7808,-1139.1279,23.9063))
		return 1;

	return 0;
}
CMD:park(playerid, params[])
{
	new vehicleid;
	new vehicle_index;	
	
	if(!IsAtPublicParking(playerid))
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Harus berada di ~y~public parking ~w~untuk menggunakan perintah!.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You need to be inside a vehicle to use this command!");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You need to be driver to use this command!");

	if(GetMoney(playerid) < 100)
		return SendErrorMessage(playerid, "You need to have $100 in your pocket to use this!");
		
	if(GetPlayerVIPLevel(playerid) <= 1 && PlayerData[playerid][pParkedVehicle] >= 3)
		return SendErrorMessage(playerid, "You only able to park three vehicle!");

	if(GetPlayerVIPLevel(playerid) >= 2 && PlayerData[playerid][pParkedVehicle] >= 5)
		return SendErrorMessage(playerid, "You only able to park five vehicle!");

	vehicleid = GetPlayerVehicleID(playerid);
	vehicle_index = Vehicle_ReturnID(vehicleid);
	
	if(vehicle_index == -1)
		return 0;
	
	if(Vehicle_IsOwned(playerid, vehicle_index))
	{
		if(VehicleData[vehicle_index][vehModel] == 508)
		{
			foreach(new i : Player) 
			{
				new vw = GetPlayerVirtualWorld(i);
				if(vw > MIN_VIRTUAL_WORLD && vw < MAX_VIRTUAL_WORLD && (vw-MIN_VIRTUAL_WORLD) == VehicleData[vehicle_index][vehVehicleID])
				{
					SetOutsideRV(i, VehicleData[vehicle_index][vehVehicleID]);					
				}
			}
		}
		PlayerData[playerid][pParkedVehicle]++;
		GiveMoney(playerid, -100, ECONOMY_ADD_SUPPLY, "paid vehicle parking lot");
		Vehicle_Save(vehicle_index);
		mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET `parking`='1',`state`='%d' WHERE `id`='%d';", VEHICLE_STATE_PARKED, VehicleData[vehicle_index][vehIndex]));

		Vehicle_Delete(vehicle_index, false);
		SendServerMessage(playerid, "You park your vehicle on public parking! it cost you $100");
	}
	return 1;
}

CMD:unpark(playerid, params[])
{
	if(!IsAtPublicParking(playerid))
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Harus berada di ~y~public parking ~w~untuk menggunakan perintah!.");

	new Cache:execute, output[255];

	execute = mysql_query(g_iHandle, sprintf("SELECT `id`, `model` FROM `server_vehicles` WHERE `parking` ='1' AND `extraid`='%d' AND `type`='%d';", GetPlayerSQLID(playerid), VEHICLE_TYPE_PLAYER));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
			new 
				id = cache_get_field_int(i, "id"),
				model = cache_get_field_int(i, "model")
			;

			parking_selected_vehicle[playerid][i] = id;

			strcat(output, sprintf(WHITE"%s\n", GetVehicleNameByModel(model)));
		}
		Dialog_Show(playerid, UnparkVehicle, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Parking", output, "Unpark", "Close");
	}
	else ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak ada kendaraanmu pada public parking!");

	cache_delete(execute);
	return 1;
}
Dialog:UnparkVehicle(playerid, response, listitem, inputtext[]) 
{
	if(response)
	{
		new
			index = random(sizeof(parkingPosition)),
			// index2 = random(sizeof(parkingPosition2)),
			id = parking_selected_vehicle[playerid][listitem];

		if(!IsAtPublicParking(playerid))
			return SendErrorMessage(playerid, "You're not at range of public parking!");
			
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1630.7808,-1139.1279,23.9063))
		{
			mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET `parking`='0',`posX`='%.2f',`posY`='%.2f',`posZ`='%.2f',`posRZ`='%.2f',`state`='%d' WHERE `id`='%d';", parkingPosition[index][0], parkingPosition[index][1], parkingPosition[index][2], parkingPosition[index][3], VEHICLE_STATE_SPAWNED ,id));
		}

		// if(IsPlayerInRangeOfPoint(playerid, 5.0, 1224.6685,-1376.7126,14.9861))
		// {
		// 	mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET `parking`='0',`posX`='%.2f',`posY`='%.2f',`posZ`='%.2f',`posRZ`='%.2f',`state`='%d' WHERE `id`='%d';", parkingPosition2[index2][0], parkingPosition2[index2][1], parkingPosition2[index2][2], parkingPosition2[index2][3], VEHICLE_STATE_SPAWNED ,id));
		// }

		mysql_tquery(g_iHandle, sprintf("SELECT * FROM `server_vehicles` WHERE `id`='%d';", id), "VehicleLoaded", "d", playerid);
		if(PlayerData[playerid][pParkedVehicle] <= 0)
		{
			PlayerData[playerid][pParkedVehicle] = 0;
		}
		PlayerData[playerid][pParkedVehicle]--;
		SendServerMessage(playerid, "Kamu telah mengeluarkan "CYAN"%s "WHITE"dari "YELLOW"public parking.", inputtext);
	}
	return 1;
}

CMD:destroyveh(playerid, params[])
{
	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(isnull(params))
    	return SendSyntaxMessage(playerid, "/destroyveh [vehicleid]");

    if(!IsValidVehicle(strval(params)))
    	return SendErrorMessage(playerid, "ID kendaraan tidak valid!");

    new vehicle_index;

	if((vehicle_index = Vehicle_ReturnID(strval(params))) != RETURN_INVALID_VEHICLE_ID && Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_NONE) {
		Vehicle_Delete(vehicle_index, false);
	}
	else SendErrorMessage(playerid, "ID tersebut bukan kendaraan temporary");
	return 1;
}

// Respawn
CMD:respawncar(playerid, params[])
{
    new vehicleid, id;

    if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "d", vehicleid)) 
    	return SendSyntaxMessage(playerid, "/respawncar [veh]");

    if(!IsValidVehicle(vehicleid))
    	return SendErrorMessage(playerid, "ID kendaraan tidak valid!");
    
    if((id = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID) {
		Vehicle_Respawn(id);
		SendServerMessage(playerid, "Kamu telah merespawn kendaraan id: %d.", vehicleid);
    }
    else SendErrorMessage(playerid, "ID kendaraan tidak valid!");
    return 1;
}

CMD:respawnnear(playerid, params[])
{
	new Float:range, count;

	if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "F(50.0)", range)) 
    	return SendSyntaxMessage(playerid, "/respawnnear [range]");

	foreach(new vehicle_index : Vehicle)
	{
		if(GetVehicleDriver(VehicleData[vehicle_index][vehVehicleID]) == INVALID_PLAYER_ID)
		{
			if(!IsValidVehicle(VehicleData[vehicle_index][vehVehicleID]))
				continue;

			static
				Float:x, Float:y, Float:z;

			GetVehiclePos(VehicleData[vehicle_index][vehVehicleID], x, y, z);

			if(IsPlayerInRangeOfPoint(playerid, range, x, y, z))
			{
				Vehicle_Respawn(vehicle_index);
				count++;
			}
		}
	}

	if(!count) SendErrorMessage(playerid, "There are no closest vehicles to respawn.");
	else SendServerMessage(playerid, "You have respawned the "YELLOW"%d"WHITE" closest vehicles.", count);
	return 1;
}

CMD:respawncars(playerid, params[])
{
	if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	foreach(new vehicle_index : Vehicle)
	{
		if(GetVehicleDriver(VehicleData[vehicle_index][vehVehicleID]) == INVALID_PLAYER_ID)
		{
			if(Vehicle_GetType(vehicle_index) != VEHICLE_TYPE_FACTION) {
				Vehicle_Respawn(vehicle_index);
			}
		}
	}

	SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: %s respawn all unused vehicles!", ReturnAdminName(playerid));
	return 1;
}

CMD:rfc(playerid, params[])
	return cmd_respawnfactioncars(playerid, "\1");

CMD:respawnfactioncars(playerid, params[])
{
	if(CheckAdmin(playerid, 3))
        return PermissionError(playerid);

	foreach(new vehicle_index : Vehicle)
	{
		if(GetVehicleDriver(VehicleData[vehicle_index][vehVehicleID]) == INVALID_PLAYER_ID)
		{
			if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_FACTION) {
				Vehicle_Respawn(vehicle_index);
			}
		}
	}

	SendClientMessageToAllEx(X11_TOMATO, "AdmCmd: %s respawn all unused faction vehicles!", ReturnAdminName(playerid));
	return 1;
}


// Insurance
CMD:buyinsurance(playerid, params[])
{
	new
		is_at_location = Location_IsPlayerAt(playerid, LOCATION_INSURANCE)
	;

	if(is_at_location < 1)
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Harus berada di ~y~insurance center ~w~untuk menggunakan perintah!.");

	new vehicle_list[4096], count, Float:x, Float:y, Float:z;

	strcat(vehicle_list, "Model\tInsu\tPrice\n");
	foreach(new vehicle : OwnedVehicles<playerid>)
	{
		GetVehiclePos(VehicleData[vehicle][vehVehicleID], x, y, z);
		strcat(vehicle_list, sprintf(WHITE"%s\t"YELLOW"%d\t"GREEN"%s\n", GetVehicleNameByVehicle(VehicleData[vehicle][vehVehicleID]), VehicleData[vehicle][vehInsurance], FormatNumber(Vehicle_InsurancePrice(Model_GetCategory(VehicleData[vehicle][vehModel])))));
		g_selected_vehicle[playerid][count++] = vehicle;
	}

	if(count) Dialog_Show(playerid, BuyInsurance, DIALOG_STYLE_TABLIST_HEADERS, "Buy Insurance", vehicle_list, "Select", "Close");
	else ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak memiliki kendaraan untuk ditambahkan asuransinya!");
	return 1;
}

CMD:claiminsurance(playerid, params[])
{
	new
		is_at_location = Location_IsPlayerAt(playerid, LOCATION_INSURANCE)
	;

	if(is_at_location < 1)
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Harus berada di ~y~insurance center ~w~untuk menggunakan perintah!.");

	new Cache:execute, output[255];

	execute = mysql_query(g_iHandle, sprintf("SELECT `id`, `model`, `insurancetime` FROM `server_vehicles` WHERE `extraid`='%d' AND `type`='%d' AND `state`='%d';", GetPlayerSQLID(playerid), VEHICLE_TYPE_PLAYER, VEHICLE_STATE_INSURANCE));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\tClaim Time\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
			new 
				id = cache_get_field_int(i, "id"),
				model = cache_get_field_int(i, "model"),
				time = cache_get_field_int(i, "insurancetime");

			g_selected_vehicle[playerid][i] = id;
			g_selected_vehicle_time[playerid][i] = time;
			g_selected_vehicle_price[playerid][i] = model;

			strcat(output, sprintf(WHITE"%s\t%s\n", GetVehicleNameByModel(model), ConvertTimestamp(Timestamp:time)));
		}
		Dialog_Show(playerid, ClaimInsurance, DIALOG_STYLE_TABLIST_HEADERS, "Insurance Center", output, "Claim", "Close");
	}
	else ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak ada kendaraanmu pada insurance center!");

	cache_delete(execute);
	return 1;
}

CMD:forceinsurance(playerid, params[])
{
	if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    static targetid;

    if(sscanf(params, "u", targetid))
    	return SendSyntaxMessage(playerid, "/forceinsurance [targetid]");

	new Cache:execute, output[255];

	if (targetid == INVALID_PLAYER_ID) {
		return SendErrorMessage(playerid, "Player ini sedang tidak ada!");
	}

	execute = mysql_query(g_iHandle, sprintf("SELECT `id`, `model`, `insurancetime` FROM `server_vehicles` WHERE `extraid`='%d' AND `type`='%d' AND `state`='%d';", GetPlayerSQLID(targetid), VEHICLE_TYPE_PLAYER, VEHICLE_STATE_INSURANCE));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\tClaim Time\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
			new 
				id = cache_get_field_int(i, "id"),
				model = cache_get_field_int(i, "model"),
				time = cache_get_field_int(i, "insurancetime");

			g_selected_vehicle[playerid][i] = id;
			g_selected_vehicle_price[playerid][i] = model;
			
			strcat(output, sprintf(WHITE"%s\t%s\n", GetVehicleNameByModel(model), ConvertTimestamp(Timestamp:time)));
		}

		SetPVarInt(playerid, "ForceInsurancePlayer", targetid);
		Dialog_Show(playerid, ForceInsurance, DIALOG_STYLE_TABLIST_HEADERS, "Force Insurance", output, "Claim", "Close");
	}
	else SendErrorMessage(playerid, "Tidak ada kendaraan player tersebut pada insurance center!");

	cache_delete(execute);
	return 1;
}


CMD:forcespawn(playerid, params[])
{
	if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    static targetid;

    if(sscanf(params, "u", targetid))
    	return SendSyntaxMessage(playerid, "/forcespawn [targetid]");

	new Cache:execute, output[255];

	execute = mysql_query(g_iHandle, sprintf("SELECT `id`, `model` FROM `server_vehicles` WHERE `extraid`='%d' AND `type`='%d' AND `state`='%d';", GetPlayerSQLID(targetid), VEHICLE_TYPE_PLAYER, VEHICLE_STATE_HOUSEPARKED));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
			new 
				id = cache_get_field_int(i, "id"),
				model = cache_get_field_int(i, "model");

			g_selected_vehicle[playerid][i] = id;
			g_selected_vehicle_price[playerid][i] = model;
			
			strcat(output, sprintf(WHITE"%s\n", GetVehicleNameByModel(model)));
		}
		SetPVarInt(playerid, "ForceSpawnVehicle", targetid);
		Dialog_Show(playerid, ForceVehicleSpawn, DIALOG_STYLE_TABLIST_HEADERS, "Force Spawn", output, "Spawn", "Close");
	}
	else SendErrorMessage(playerid, "Tidak ada kendaraan player tersebut pada list house park!");

	cache_delete(execute);
	return 1;
}

CMD:forcedeath(playerid, params[])
{
	if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    static targetid;

    if(sscanf(params, "u", targetid))
    	return SendSyntaxMessage(playerid, "/forcedeath [targetid]");

	new Cache:execute, output[255];

	execute = mysql_query(g_iHandle, sprintf("SELECT `id`, `model`, `insurancetime` FROM `server_vehicles` WHERE `extraid`='%d' AND `type`='%d' AND `state`='%d';", GetPlayerSQLID(targetid), VEHICLE_TYPE_PLAYER, VEHICLE_STATE_DEAD));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
			new 
				id = cache_get_field_int(i, "id"),
				model = cache_get_field_int(i, "model");

			g_selected_vehicle[playerid][i] = id;
			g_selected_vehicle_price[playerid][i] = model;
			
			strcat(output, sprintf(WHITE"%s\n", GetVehicleNameByModel(model)));
		}
		SetPVarInt(playerid, "ForceDeathPlayer", targetid);
		Dialog_Show(playerid, ForceDeath, DIALOG_STYLE_TABLIST_HEADERS, "Force Death", output, "Claim", "Close");
	}
	else SendErrorMessage(playerid, "Tidak ada kendaraan player tersebut pada list death!");

	cache_delete(execute);
	return 1;
}

CMD:vdl(playerid, params[])
{
	if(CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	new Cache:execute, output[1500], name[MAX_PLAYER_NAME], issued[MAX_PLAYER_NAME];

	DeletePVar(playerid, "VehicleDeleteList");

	execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `cardestroy` ORDER BY `destroyTime` DESC LIMIT %d, 10", GetPVarInt(playerid, "VehicleDeleteList") * 10));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\tOwner\tDestroyer\tDate record\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
        	cache_get_field_content(i, "destroyOwner", name, MAX_PLAYER_NAME);
        	cache_get_field_content(i, "destroyBy", issued, MAX_PLAYER_NAME);

			strcat(output, sprintf("%s\t%s\t%s\t%s\n", GetVehicleNameByModel(cache_get_field_int(i, "destroyModel")), name, issued, ConvertTimestamp(Timestamp:cache_get_field_int(i, "destroyTime"))));
		}
		Dialog_Show(playerid, VehicleDeath, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Death List", output, "Next", "Close");
	}
	else SendErrorMessage(playerid, "Tidak ada data yang dimuat");

	cache_delete(execute);
	return 1;
}

// Impound
CMD:impound(playerid, params[])
{
    new
        price,
    	impound_id,
        vehicleid;

    if(GetFactionType(playerid) != FACTION_POLICE) 
        return SendErrorMessage(playerid, "You must be a police officer.");

    if(!IsPlayerDuty(playerid)) 
        return SendErrorMessage(playerid, "You must duty first.");

    if((impound_id = Impound_Nearest(playerid)) == -1)
        return SendErrorMessage(playerid, "You are not in range of any impound lot.");

    if(ImpoundData[impound_id][impoundRelease][0] == 0.0 || ImpoundData[impound_id][impoundRelease][2] == 0.0)
    	return SendErrorMessage(playerid, "Release point on impound lot doesn't not set yet, contact admin!");

    if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 525)
        return SendErrorMessage(playerid, "You are not driving a tow truck.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    	return SendErrorMessage(playerid, "You must drive the vehicle to use this command.");

    if(sscanf(params, "d", price)) 
        return SendSyntaxMessage(playerid, "/impound [price]");

    if(price < 1 || price > 5000)
        return SendErrorMessage(playerid, "The price can't be above $5,000 or below $1.");

    if(!GetVehicleTrailer(GetPlayerVehicleID(playerid)))
        return SendErrorMessage(playerid, "There is no vehicle hooked.");

    if((vehicleid = Vehicle_ReturnID(GetVehicleTrailer(GetPlayerVehicleID(playerid)))) != RETURN_INVALID_VEHICLE_ID)
    {
        if(Vehicle_GetType(vehicleid) != VEHICLE_TYPE_PLAYER)
            return SendErrorMessage(playerid, "This is not player vehicle.");

        foreach(new i : Player) if(GetPlayerSQLID(i) == Vehicle_GetExtraID(vehicleid))
        {
            SendServerMessage(i, "Your "YELLOW"%s "WHITE"has been impounded by {2641FE}%s "WHITE"for "COL_GREEN"%s.", GetVehicleNameByModel(VehicleData[vehicleid][vehModel]), FactionData[PlayerData[playerid][pFaction]][factionName], FormatNumber(price));
            SendServerMessage(i, "You must waiting "YELLOW"12 hours "WHITE"to release this impounded vehicle.");
        }

        new unimpound_date = gettime() + 43200;
        mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET impoundtime=%d, state=%d, impoundprice=%d WHERE id=%d;", unimpound_date, VEHICLE_STATE_IMPOUND, price, VehicleData[vehicleid][vehIndex]));
		mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET `posX`='%.2f',`posY`='%.2f',`posZ`='%.2f',`posRZ`='%.2f' WHERE `id`='%d';", ImpoundData[impound_id][impoundRelease][0], ImpoundData[impound_id][impoundRelease][1], ImpoundData[impound_id][impoundRelease][2], ImpoundData[impound_id][impoundRelease][3], VehicleData[vehicleid][vehIndex]));

        DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
        SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "RADIO: %s has impounded a %s for %s.", ReturnName(playerid, 0), GetVehicleNameByModel(VehicleData[vehicleid][vehModel]), FormatNumber(price));

        Vehicle_Delete(vehicleid, false);
    }
    else SendErrorMessage(playerid, "You can't impound this vehicle.");
    return 1;
}

CMD:releasecar(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1552.5021,-1609.3511,13.3828))
        return SendErrorMessage(playerid, "You must be at LSPD HQ to release a vehicle.");

	new Cache:execute, output[255];

	execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `server_vehicles` WHERE `extraid`='%d' AND `type`='%d' AND `state`='%d';", GetPlayerSQLID(playerid), VEHICLE_TYPE_PLAYER, VEHICLE_STATE_IMPOUND));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\tFined\tClaim Time\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
			new 
				id = cache_get_field_int(i, "id"),
				model = cache_get_field_int(i, "model"),
				fined = cache_get_field_int(i, "impoundprice"),
				time = cache_get_field_int(i, "impoundtime");

			g_selected_vehicle[playerid][i] = id;
			g_selected_vehicle_time[playerid][i] = time;
			g_selected_vehicle_price[playerid][i] = fined;

			strcat(output, sprintf(WHITE"%s\t%s\t%s\n", GetVehicleNameByModel(model), FormatNumber(fined), ConvertTimestamp(Timestamp:time)));
		}
		Dialog_Show(playerid, ClaimImpound, DIALOG_STYLE_TABLIST_HEADERS, "Release Vehicle", output, "Release", "Close");
	}
	else SendErrorMessage(playerid, "Tidak ada kendaraan pada impound center!");

	cache_delete(execute);
	return 1;
}

CMD:forcerelease(playerid, params[])
{
	if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    static targetid;

    if(sscanf(params, "u", targetid))
    	return SendSyntaxMessage(playerid, "/forceinsurance [targetid]");

	new Cache:execute, output[255];

	execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `server_vehicles` WHERE `extraid`='%d' AND `type`='%d' AND `state`='%d';", GetPlayerSQLID(targetid), VEHICLE_TYPE_PLAYER, VEHICLE_STATE_IMPOUND));

	if(cache_num_rows())
	{
		strcat(output, sprintf("Model\tFined\tClaim Time\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
			new 
				id = cache_get_field_int(i, "id"),
				model = cache_get_field_int(i, "model"),
				time = cache_get_field_int(i, "impoundtime"),
				price = cache_get_field_int(i, "impoundprice");

			g_selected_vehicle[playerid][i] = id;
			strcat(output, sprintf(WHITE"%s\t%s\t%s\n", GetVehicleNameByModel(model), FormatNumber(price), ConvertTimestamp(Timestamp:time)));
		}

		SetPVarInt(playerid, "ForceRelease", targetid);
		Dialog_Show(playerid, ForceRelease, DIALOG_STYLE_TABLIST_HEADERS, "Force Release", output, "Release", "Close");
	}
	else SendErrorMessage(playerid, "Tidak ada kendaraan player tersebut pada impound center!");

	cache_delete(execute);
	return 1;
}

// Refueling
CMD:setfuel(playerid, params[])
{
	if (CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    new vehicleid, fuel;

    if(sscanf(params, "dd", vehicleid, fuel))
    	return SendSyntaxMessage(playerid, "/setfuel [vehicleid] [fuel]");

    if(!IsValidVehicle(vehicleid))
    	return SendErrorMessage(playerid, "ID kendaraan tidak valid!");

	if(!IsEngineVehicle(vehicleid))
		return SendErrorMessage(playerid, "Kendaraan ini tidak membutuhkan bahan bakar!");

    if(!(0 <= fuel <= 100))
    	return SendErrorMessage(playerid, "Bahan bakar dibatasi 0 - 100.");

    if(Vehicle_SetFuel(vehicleid, fuel)) SendServerMessage(playerid, "Sukses mengisi bahan bakar "CYAN"%s "WHITE"menjadi "GREEN"%d/100.", GetVehicleNameByVehicle(vehicleid), fuel);
	else SendErrorMessage(playerid, "Tidak bisa mengisi bahan bakar untuk kendaraan ini!");

	return 1;
}

CMD:refuel(playerid, params[])
{
    static index;

    if((index = Pump_Nearest(playerid)) != -1)
    {
    	// Pump Section
	    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	        return SendErrorMessage(playerid, "Kemudikan kendaraan untuk mengisi bahan bakar.");
	    
	    if(GetEngineStatus(GetPlayerVehicleID(playerid)))
	        return SendErrorMessage(playerid, "Matikan mesin kendaraan!");

        if(BusinessData[PumpData[index][pumpBusiness]][bizSeal]) 
        	return SendErrorMessage(playerid, "Pompa bahan bakar dalam keadaan tersita oleh pemerintahan!");

        if(PumpData[index][pumpFuel] < 1) 
        	return SendErrorMessage(playerid, "Pompa ini tidak memiliki bahan bakar lagi didalamnya.");

        if(GetMoney(playerid) < BusinessData[PumpData[index][pumpBusiness]][bizPrices][5]) 
        	return SendErrorMessage(playerid, "Minimal kamu harus memiliki "GREEN"%s "WHITE"untuk mengisi bahan bakar.", FormatNumber(BusinessData[PumpData[index][pumpBusiness]][bizPrices][5]));
        
        if((VehicleData[Vehicle_ReturnID(GetPlayerVehicleID(playerid))][vehGasUpgrade] != 2 && Vehicle_GetFuel(GetPlayerVehicleID(playerid)) > 100.0)) 
        	return SendErrorMessage(playerid, "Bahan bakar kendaraan sudah mencapai batas maksimal.");

        if((VehicleData[Vehicle_ReturnID(GetPlayerVehicleID(playerid))][vehGasUpgrade] == 2 && Vehicle_GetFuel(GetPlayerVehicleID(playerid)) > 125.0)) 
        	return SendErrorMessage(playerid, "Bahan bakar kendaraan sudah mencapai batas maksimal.");

        //Vehicle Section
		if(Vehicle_ReturnID(GetPlayerVehicleID(playerid)) != RETURN_INVALID_VEHICLE_ID)
		{
	        PlayerData[playerid][pGasPump] = index;
	        Dialog_Show(playerid, RefuelVehicle, DIALOG_STYLE_INPUT, "Refuel Vehicle", ""WHITE"Toko ini menjual "GREEN"%s"YELLOW"/liter "WHITE"nya\n\nBerapa persen literan yang mau kamu beli?", "Beli", "Gagalkan", FormatNumber(BusinessData[PumpData[index][pumpBusiness]][bizPrices][5]));
		}
		else SendErrorMessage(playerid, "Tidak dapat mengisi bahan bakar kendaraan ini.");
    }
    else SendErrorMessage(playerid, "Kamu tidak berada didekat pengisian bahan bakar.");

    return 1;
}

CMD:fill(playerid, params[])
{
    if(!Inventory_HasItem(playerid, "Fuel Can"))
        return SendErrorMessage(playerid, "Beli 'Fuel Can' untuk mengisi bahan bakar kendaraan!.");
    
	if(IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Keluar dari kendaraan terlebih dahulu!");

    new vehicleid = Vehicle_Nearest(playerid);

    if(vehicleid == -1)
        return SendErrorMessage(playerid, "Kamu tidak berada dekat dengan kendaraan!.");

    if(GetEngineStatus(vehicleid))
        return SendErrorMessage(playerid, "Mesin dalam keadaan aktif, nonaktifkan terlebih dahulu.");

    if(Vehicle_GetFuel(vehicleid) > 90)
    	return SendErrorMessage(playerid, "Bahan bakar kendaraan masih ada 90 persen lagi!");

    if(PlayerData[playerid][pFuelCan])
        return SendErrorMessage(playerid, "You are already using a can of fuel.");

    PlayerData[playerid][pFuelCan] = 1;
    SetPVarInt(playerid, "RefillingVehicle", vehicleid);
    SetPVarInt(playerid, "RefillingVehicleCounter", 5);
    return 1;
}

// Number plate [POLICE]
CMD:icp(playerid, params[]) 
    return cmd_installcustomplate(playerid, params);

CMD:installcustomplate(playerid, params[])
{
    static 
        id = RETURN_INVALID_VEHICLE_ID,
        plate[32],
        vehicleid;

    if(GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "You are not member of LSPD official.");

    if(!IsPlayerDuty(playerid)) 
        return SendErrorMessage(playerid, "You must duty first.");

    if(PlayerData[playerid][pFactionRank] < FactionData[PlayerData[playerid][pFaction]][factionRanks] - 3)
        return SendErrorMessage(playerid, "You must be at least rank %d.", FactionData[PlayerData[playerid][pFaction]][factionRanks] - 3);

    if(sscanf(params, "ds[32]", vehicleid, plate))
        return SendSyntaxMessage(playerid,"/installcustomplate [vehicleid] [custom plate]");

    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "Can't use this action if you in vehicle.");

    if(!IsValidVehicle(vehicleid))
    	return SendErrorMessage(playerid, "Kendaraan tidak spawn!");

    if(Vehicle_Nearest(playerid) != vehicleid)
    	return SendErrorMessage(playerid, "Kendaraan tidak berada didekatmu!");

    if(strval(plate) > 32)
        return SendErrorMessage(playerid, "Plate characters is too long");

    if((id = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
    {
    	if(Vehicle_GetType(id) != VEHICLE_TYPE_PLAYER)
    		return SendErrorMessage(playerid, "Ini bukan kendaraan tipe player!");

		Vehicle_SaveData(id);
    	format(VehicleData[id][vehPlate], 32, plate);
		Vehicle_Respawn(id, true);

		mysql_tquery(g_iHandle, sprintf("UPDATE `server_vehicles` SET `plate`='%s' WHERE `id`='%d';", VehicleData[id][vehPlate], VehicleData[id][vehIndex]));
    	SendServerMessage(playerid, "Plate baru untuk "CYAN"%s"WHITE": "GREEN"%s", GetVehicleNameByVehicle(vehicleid), plate);
    }
    else SendErrorMessage(playerid, "Tidak dapat mengubah plate kendaraan ini.");
    return 1;
}

CMD:registerplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, -1087.2913,-971.8285,129.3047))
		return SendErrorMessage(playerid, "Kamu tidak berada di lobby LSPD!");

	if(GetPlayerInterior(playerid) != 15)
		return SendErrorMessage(playerid, "Kamu tidak berada di lobby LSPD!");

	if(GetMoney(playerid) < 500)
		return SendErrorMessage(playerid, "Uang tidak mendukupi ($500)!");

	new vehicleid, vehicle_index;

	if(sscanf(params, "d", vehicleid))
		return SendErrorMessage(playerid, "/registerplate [vehicleid (id sesuai di '/v track')]");

	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ID kendaraan tidak valid!");

	if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
	{
		if(!Vehicle_IsOwned(playerid, vehicle_index))
			return SendErrorMessage(playerid, "Kendaraan tersebut bukan kendaraan milikmu!");

		if(strcmp(VehicleData[vehicle_index][vehPlate], "NONE", true))
			return SendErrorMessage(playerid, "Kendaraan ini tidak dapat diregistrasi kembali!");

		Vehicle_SaveData(vehicle_index);
		format(VehicleData[vehicle_index][vehPlate], 32, "LS-%d%d%d%d%d", RandomEx(0, 9), RandomEx(0, 9), RandomEx(0, 9), RandomEx(0, 9), RandomEx(0, 9));
		Vehicle_Respawn(vehicle_index, true);

		mysql_tquery(g_iHandle, sprintf("UPDATE `server_vehicles` SET `plate`='%s' WHERE `id`='%d';", VehicleData[vehicle_index][vehPlate], VehicleData[vehicle_index][vehIndex]));
		for (new i = 0; i != MAX_FACTIONS; i ++)
        { 
            if(FactionData[i][factionExists])
            {
                if(FactionData[i][factionType] == FACTION_POLICE)
                {
                    FactionData[i][factionMoney] += 500;
                }
            }
        }
		GiveMoney(playerid, -500, ECONOMY_ADD_SUPPLY, "register a new vehicle plate");
    	SendServerMessage(playerid, "Plate baru untuk "CYAN"%s"WHITE": "GREEN"%s", GetVehicleNameByVehicle(vehicleid), VehicleData[vehicle_index][vehPlate]);
	}
	else SendErrorMessage(playerid, "Kendaraan tersebut bukan kendaraan server!");
	return 1;
}

//Vehicle owned
CMD:vowner(playerid, params[])
{
	new vehicleid, vehicle_index, output[255];

	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	if(sscanf(params, "d", vehicleid))
		return SendErrorMessage(playerid, "/vowner [vehicleid]");

	if(!IsValidVehicle(vehicleid))
		return SendErrorMessage(playerid, "ID kendaraan tidak valid!");

	if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
	{
		new vehicle_type[][16] = {"TEMPORARY", "PLAYER", "FACTION", "SIDEJOB", "RENTAL", "DRIVING SCHOOL"};
		strcat(output, sprintf("ID\t"YELLOW"%d\n", vehicle_index));
		strcat(output, sprintf("Model\t"YELLOW"%s\n", GetVehicleNameByVehicle(vehicleid)));
		strcat(output, sprintf("Type\t"CYAN"%s\n", vehicle_type[Vehicle_GetType(vehicle_index)]));

		switch(Vehicle_GetType(vehicle_index))
		{
			case VEHICLE_TYPE_PLAYER:
			{
				strcat(output, sprintf("Owned by\t"LIGHTBLUE"%s\n", ReturnName(Vehicle_PlayerID(vehicleid))));
				strcat(output, sprintf("Insurance\t"LIGHTBLUE"%d", VehicleData[vehicle_index][vehInsurance]));
			}
			case VEHICLE_TYPE_RENTAL:
			{
				strcat(output, sprintf("Rented by\t"LIGHTBLUE"%s", ReturnName(Vehicle_PlayerID(vehicleid))));
			}
			case VEHICLE_TYPE_FACTION:
			{
				strcat(output, sprintf("Faction\t"LIGHTBLUE"%s", Faction_GetNameID(Vehicle_GetExtraID(vehicle_index))));
			}
		}

		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST, "Vehicle Info", output, "Close", "");
	}
	else SendErrorMessage(playerid, "Kendaraan tersebut bukan kendaraan server!");
	return 1;
}
