#include <YSI\y_hooks>

hook OnScriptExit()
{
	static Iterator:vehicles<MAX_VEHICLES>;
	Iter_Init(vehicles);

	foreach(new vehicle : Vehicle)
	{
		Iter_Add(vehicles, VehicleData[vehicle][vehVehicleID]);

		Vehicle_DeleteNeon(VehicleData[vehicle][vehVehicleID]);
		Vehicle_ObjectDestroy(VehicleData[vehicle][vehVehicleID]);
		Vehicle_ResetVariable(vehicle);
	}

	foreach (new vehicle : vehicles)
	{
		DestroyVehicle(vehicle);
	}
	return 1;
}

hook OnGameModeInitEx()
{
	Vehicle_SidejobLoad();
	Vehicle_DMVLoad();
}

timer Vehicle_UpdatePosition[2000](vehicleid)
{
	new
		Float:x,
		Float:y,
		Float:z,
		Float:a
	;

	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, a);

	SetVehiclePos(vehicleid, x, y, z);
	SetVehicleZAngle(vehicleid, a);
}

task Vehicle_FeatureUpdate[1000]()
{
	// Fuel Update
	new Float:mass, Float:speed, Float:dist;

	foreach(new i : Vehicle)
	{
		if(IsValidVehicle(VehicleData[i][vehVehicleID]) && IsEngineVehicle(VehicleData[i][vehVehicleID]) && GetEngineStatus(VehicleData[i][vehVehicleID]))
		{
			dist = GetVehicleDistanceFromPoint(VehicleData[i][vehVehicleID], VehicleData[i][vehLastCoords][0], VehicleData[i][vehLastCoords][1], VehicleData[i][vehLastCoords][2]);
			mass = GetVehicleModelInfoAsFloat(GetVehicleModel(VehicleData[i][vehVehicleID]), "fMass");
			speed = GetVehicleSpeed(VehicleData[i][vehVehicleID]) + 0.001;

			VehicleData[i][vehFuel] -= ((mass / (mass * 4.5)) * ((speed / 60) + 0.015) / 30) * ((dist / 10) + 0.001);
			
			if(VehicleData[i][vehFuel] < 0.1) {
				SetEngineStatus(VehicleData[i][vehVehicleID], false);
				VehicleData[i][vehFuel] = 0.0;
			}

			// Hanya kendaraan selain sepeda yang dicatat mileage-nya.
			if (Vehicle_GetType(i) == VEHICLE_TYPE_FACTION || Vehicle_GetType(i) == VEHICLE_TYPE_PLAYER)
			{
				// Mileage
				new
					// Ubah kilometer per jam menjadi kilometer per detik.
					Float:kilometer_per_sec = (GetVehicleSpeed(i) / 3600)
				;

				Vehicle_AddCurrentMileage(i, kilometer_per_sec);
			}

			new
				overused_mileage
				// rand = random(100)
			;
			Vehicle_GetOverusedMileage(i, overused_mileage);

			// if (overused_mileage >= 10 && overused_mileage < 20)
			// {
			// 	if (rand % 4 == 0)
			// 	{
			// 		SetEngineStatus(i, false);
			// 		SetLightStatus(i, false); 
			// 		VehicleData[i][vehEngineStatus] = 0;

			// 		new playerid = GetVehicleDriverID(i);
			// 		if (playerid != INVALID_PLAYER_ID)
			// 		{
			// 			ShowPlayerFooter(playerid, "Mesin ~r~mati ~w~mendadak!");
			// 		}
			// 	}
			// }
			// else if (overused_mileage >= 20 && overused_mileage < 30)
			// {
			// 	if (rand % 3 == 0)
			// 	{
			// 		SetEngineStatus(i, false);
			// 		SetLightStatus(i, false); 
			// 		VehicleData[i][vehEngineStatus] = 0;

			// 		new playerid = GetVehicleDriverID(i);
			// 		if (playerid != INVALID_PLAYER_ID)
			// 		{
			// 			ShowPlayerFooter(playerid, "Mesin ~r~mati ~w~mendadak!");
			// 		}
			// 	}
			// }
			// else if (overused_mileage >= 30 && overused_mileage < 40)
			// {
			// 	if (ReturnVehicleHealth(i) > 645)
			// 	{
			// 		SetVehicleHealth(i, 645.0);
			// 	}
			// }
			// else if (overused_mileage >= 40 && overused_mileage < 45)
			// {
			// 	if (ReturnVehicleHealth(i) > 500)
			// 	{
			// 		SetVehicleHealth(i, 500.0);
			// 	}
			// }
			// else if (overused_mileage >= 45 && overused_mileage < 50)
			// {
			// 	if (ReturnVehicleHealth(i) > 450)
			// 	{
			// 		SetVehicleHealth(i, 450.0);
			// 	}
			// }
			// else if (overused_mileage >= 60)
			// {
			// 	if (ReturnVehicleHealth(i) > 300)
			// 	{
			// 		SetVehicleHealth(i, 300.0);
			// 	}
			// }

			GetVehiclePos(VehicleData[i][vehVehicleID], VehicleData[i][vehLastCoords][0], VehicleData[i][vehLastCoords][1], VehicleData[i][vehLastCoords][2]);
		}
	}
	return 1;
}

// ptask Vehicle_FeatureUpdate[1000](playerid)
// {
// 	// Fuel Update
// 	new Float:mass, Float:speed, Float:dist, i;
// 	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
// 	{
// 		new vehicleid = GetPlayerVehicleID(playerid);
// 		if((i = Vehicle_ReturnID(vehicleid)) != -1 && IsValidVehicle(VehicleData[i][vehVehicleID]) && IsEngineVehicle(VehicleData[i][vehVehicleID]) && GetEngineStatus(VehicleData[i][vehVehicleID]))
// 		{
// 			dist = GetVehicleDistanceFromPoint(VehicleData[i][vehVehicleID], VehicleData[i][vehLastCoords][0], VehicleData[i][vehLastCoords][1], VehicleData[i][vehLastCoords][2]);
// 			mass = GetVehicleModelInfoAsFloat(GetVehicleModel(VehicleData[i][vehVehicleID]), "fMass");
// 			speed = GetVehicleSpeed(VehicleData[i][vehVehicleID]) + 0.001;

// 			VehicleData[i][vehFuel] -= ((mass / (mass * 4.5)) * ((speed / 60) + 0.015) / 30) * ((dist / 10) + 0.001);
			
// 			if(VehicleData[i][vehFuel] < 0.1) {
// 				SetEngineStatus(VehicleData[i][vehVehicleID], false);
// 				VehicleData[i][vehFuel] = 0.0;
// 			}

// 			// Hanya kendaraan selain sepeda yang dicatat mileage-nya.
// 			if (Vehicle_GetType(i) == VEHICLE_TYPE_FACTION || Vehicle_GetType(i) == VEHICLE_TYPE_PLAYER)
// 			{
// 				// Mileage
// 				new
// 					// Ubah kilometer per jam menjadi kilometer per detik.
// 					Float:kilometer_per_sec = (GetVehicleSpeed(i) / 3600)
// 				;

// 				Vehicle_AddCurrentMileage(i, kilometer_per_sec);
// 			}

// 			new
// 				overused_mileage
// 				// rand = random(100)
// 			;
// 			Vehicle_GetOverusedMileage(i, overused_mileage);

// 			// if (overused_mileage >= 10 && overused_mileage < 20)
// 			// {
// 			// 	if (rand % 4 == 0)
// 			// 	{
// 			// 		SetEngineStatus(i, false);
// 			// 		SetLightStatus(i, false); 
// 			// 		VehicleData[i][vehEngineStatus] = 0;

// 			// 		new playerid = GetVehicleDriverID(i);
// 			// 		if (playerid != INVALID_PLAYER_ID)
// 			// 		{
// 			// 			ShowPlayerFooter(playerid, "Mesin ~r~mati ~w~mendadak!");
// 			// 		}
// 			// 	}
// 			// }
// 			// else if (overused_mileage >= 20 && overused_mileage < 30)
// 			// {
// 			// 	if (rand % 3 == 0)
// 			// 	{
// 			// 		SetEngineStatus(i, false);
// 			// 		SetLightStatus(i, false); 
// 			// 		VehicleData[i][vehEngineStatus] = 0;

// 			// 		new playerid = GetVehicleDriverID(i);
// 			// 		if (playerid != INVALID_PLAYER_ID)
// 			// 		{
// 			// 			ShowPlayerFooter(playerid, "Mesin ~r~mati ~w~mendadak!");
// 			// 		}
// 			// 	}
// 			// }
// 			// else if (overused_mileage >= 30 && overused_mileage < 40)
// 			// {
// 			// 	if (ReturnVehicleHealth(i) > 645)
// 			// 	{
// 			// 		SetVehicleHealth(i, 645.0);
// 			// 	}
// 			// }
// 			// else if (overused_mileage >= 40 && overused_mileage < 45)
// 			// {
// 			// 	if (ReturnVehicleHealth(i) > 500)
// 			// 	{
// 			// 		SetVehicleHealth(i, 500.0);
// 			// 	}
// 			// }
// 			// else if (overused_mileage >= 45 && overused_mileage < 50)
// 			// {
// 			// 	if (ReturnVehicleHealth(i) > 450)
// 			// 	{
// 			// 		SetVehicleHealth(i, 450.0);
// 			// 	}
// 			// }
// 			// else if (overused_mileage >= 60)
// 			// {
// 			// 	if (ReturnVehicleHealth(i) > 300)
// 			// 	{
// 			// 		SetVehicleHealth(i, 300.0);
// 			// 	}
// 			// }

// 			GetVehiclePos(VehicleData[i][vehVehicleID], VehicleData[i][vehLastCoords][0], VehicleData[i][vehLastCoords][1], VehicleData[i][vehLastCoords][2]);
// 		}
// 	}
// 	return 1;
// }
hook OnPlayerLogin(playerid)
{
	Iter_Init(OwnedVehicles<playerid>);
	Iter_Init(RentedVehicles<playerid>);

	foreach(new i : OwnedVehicles<playerid>)
		printf("Owned: %d", i);

	foreach(new i : RentedVehicles<playerid>)
		printf("Rental: %d", i);

	Vehicle_PlayerLoad(playerid);
	Vehicle_RentalLoad(playerid);
}

hook OnVehicleSpawn(vehicleid) //Harus tambahin disini juga untuk create , delete / respawn
{
	new index = RETURN_INVALID_VEHICLE_ID;

	printf("Reloaded vid: %d", vehicleid);

	defer Vehicle_UpdatePosition(vehicleid);

	if((index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
	{
		switch(Vehicle_GetType(index))
		{
			case VEHICLE_TYPE_DRIVING_SCHOOL, VEHICLE_TYPE_SIDEJOB:
			{
				SetEngineStatus(vehicleid, false);
				Vehicle_SetFuel(vehicleid, 100);
				SetDoorStatus(vehicleid, false);
				SetLightStatus(vehicleid, false);
				RepairVehicle(vehicleid);
			}
		}

		if(Vehicle_GetState(index) == VEHICLE_STATE_DEAD)
		{
			if(Vehicle_GetType(index) == VEHICLE_TYPE_PLAYER)
			{
				
				foreach(new i : Player) if(GetPlayerSQLID(i) == Vehicle_GetExtraID(index))
				{
					Vehicle_DeleteNeon(VehicleData[vehicleid][vehVehicleID]);
					Vehicle_ObjectDestroy(VehicleData[vehicleid][vehVehicleID]);
					SendServerMessage(i, "Kendaraan "CYAN"%s "WHITE"milikmu "RED"rusak parah "WHITE"dan telah masuk kedalam "YELLOW"insurance center.", GetVehicleNameByModel(VehicleData[index][vehModel]));

					// Insert log
					new query[300], 
						killerid = Vehicle_GetKillerID(index);

					mysql_format(g_iHandle, query, sizeof query, "INSERT INTO `cardestroy`(`destroyBy`, `destroyModel`, `destroyOwner`, `destroyTime`) VALUES ('%s','%d','%s','%d');", (killerid == INVALID_PLAYER_ID) ? ("nothing") : (NormalName(killerid)), VehicleData[index][vehModel], NormalName(i), gettime());
					mysql_tquery(g_iHandle, query);

					// Delete vehicle cargo
					mysql_tquery(g_iHandle, sprintf("DELETE FROM `vehicle_cargo` WHERE `vehicle_id`='%d';", VehicleData[index][vehIndex]));
					break;
				}

				if(--VehicleData[index][vehInsurance] < 0)
				{
					foreach(new i : Player) if(GetPlayerSQLID(i) == Vehicle_GetExtraID(index))
					{
						SendServerMessage(i, "Kendaraan "CYAN"%s "WHITE"milikmu "RED"dihapus "WHITE"karena kehabisan slot asuransi.", GetVehicleNameByModel(VehicleData[index][vehModel]));
						break;
					}
					RemoveAllVehicleKey(index);
					Vehicle_Delete(index, true);
					return 1;
				}

				new claim_date = gettime() + 10800;
				mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET insurancetime=%d,insurance=%d,state=%d WHERE id=%d;", claim_date, VehicleData[index][vehInsurance], VEHICLE_STATE_INSURANCE, VehicleData[index][vehIndex]));

				Vehicle_Delete(index, false);
			}
			else if(Vehicle_GetType(index) == VEHICLE_TYPE_RENTAL)
			{
				foreach(new i : Player) if(GetPlayerSQLID(i) == Vehicle_GetExtraID(index))
				{
					Vehicle_RemoveRented(i, index);
					SendServerMessage(i, "Kendaraan "CYAN"%s "WHITE"sewaanmu "RED"hancur/tenggelam"WHITE", kendaraan tidak dapat digunakan kembali.", GetVehicleNameByModel(VehicleData[index][vehModel]));
					SendServerMessage(i, "Kamu di kenakan denda %s karena kerusakaan yang ada sebagai bentuk pengganti!", FormatNumber(Economy_GetRentVehDestroyedFine()));
					GiveMoney(i, -Economy_GetRentVehDestroyedFine(), ECONOMY_ADD_SUPPLY, "paid broken rental vehicle");
					break;
				}

				// Delete vehicle cargo
				mysql_tquery(g_iHandle, sprintf("DELETE FROM `vehicle_cargo` WHERE `vehicle_id`='%d';", VehicleData[index][vehIndex]));
					
				Vehicle_Delete(index);
			}
			else if(Vehicle_GetType(index) == VEHICLE_TYPE_NONE)
			{
				Vehicle_Delete(index, false);
			}
			else if(Vehicle_GetType(index) == VEHICLE_TYPE_FACTION)
			{
				RepairVehicle(vehicleid);
				UpdateVehicleDamageStatus(vehicleid, VehicleData[index][vehPanel], VehicleData[index][vehDoor], VehicleData[index][vehLight], VehicleData[index][vehTires]);
			}
		}
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	new id = RETURN_INVALID_VEHICLE_ID;
	printf("OnVehicleDeath -> vehicleid: %d | killerid: %d", vehicleid, killerid);
	
	if((id = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
	{
		if(Vehicle_GetType(id) == VEHICLE_TYPE_PLAYER || Vehicle_GetType(id) == VEHICLE_TYPE_RENTAL || Vehicle_GetType(id) == VEHICLE_TYPE_NONE || Vehicle_GetType(id) == VEHICLE_TYPE_FACTION)
		{
			if(Vehicle_GetType(id) == VEHICLE_TYPE_PLAYER && VehicleData[id][vehModel] == 508)
			{
				foreach(new i : Player) 
				{
					new vw = GetPlayerVirtualWorld(i);
					if(vw > MIN_VIRTUAL_WORLD && vw < MAX_VIRTUAL_WORLD && (vw-MIN_VIRTUAL_WORLD) == VehicleData[id][vehVehicleID])
					{
						new Float:health;
						GetVehicleHealth(VehicleData[id][vehVehicleID], health);
						SetOutsideRV(i, VehicleData[id][vehVehicleID], health);					
					}
				}
			}
			Vehicle_StopHandbrake(id);
			Vehicle_SetKillerID(id, killerid);
			Vehicle_SetState(id, VEHICLE_STATE_DEAD);
		}
	}
	return 1;
}
ptask Player_VehicleEngine[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static vehicleid, Float:health;

		if((vehicleid = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID)
		{
			// Turn off engine if below 300 health
			if(GetEngineStatus(vehicleid) && !IsABicycle(vehicleid)) //Bike totalled fix
			{
				GetVehicleHealth(vehicleid, health);
				
				if(health <= 300) {
					GameTextForPlayer(playerid, "~r~TOTALLED", 2000, 6);
					SetEngineStatus(vehicleid, false);
				}
			}
		}
	}
	return 1;
}
ptask Player_VehicleRefuel[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

	if(PlayerData[playerid][pFuelCan])
	{
		SetPVarInt(playerid, "RefillingVehicleCounter", GetPVarInt(playerid, "RefillingVehicleCounter") - 1);

		if(!GetPVarInt(playerid, "RefillingVehicleCounter"))
		{
			new 
				vehicleid = GetPVarInt(playerid, "RefillingVehicle");


			if(Vehicle_Nearest(playerid) == vehicleid)
			{
				Vehicle_AddFuel(vehicleid, 15);

				if(VehicleData[Vehicle_ReturnID(vehicleid)][vehGasUpgrade] != 2 && Vehicle_GetFuel(vehicleid) > 100)
				{
					Vehicle_SetFuel(vehicleid, 100);
				}
				else if(VehicleData[Vehicle_ReturnID(vehicleid)][vehGasUpgrade] == 2 && Vehicle_GetFuel(vehicleid) > 100)
				{
					Vehicle_SetFuel(vehicleid, 125);
				}

			    Inventory_Remove(playerid, "Fuel Can");
				ShowPlayerFooter(playerid, sprintf("Sukses menambahkan bahan bakar sebanya ~g~15%% ~w~untuk kendaraan ~b~%s", GetVehicleNameByVehicle(vehicleid)), 3000);
			}
			else ShowPlayerFooter(playerid, sprintf("Gagal mengisi bahan bakar kendaraan, terlalu jauh dari kendaraan yang akan kamu isi!", GetVehicleNameByVehicle(vehicleid)), 3000);

			PlayerData[playerid][pFuelCan] = 0;

			DeletePVar(playerid, "RefillingVehicle");
			DeletePVar(playerid, "RefillingVehicleCounter");
		}
		else ShowPlayerFooter(playerid, "Mengisi bahan bakar kendaraan ...", 1000);
	}
	return 1;
}
ptask Player_VehicleRental[1000](playerid)
{
	if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
	{
		return 0;
	}

	if(Iter_Count(RentedVehicles<playerid>) > 0)
	{
		foreach(new i : RentedVehicles<playerid>) if(Vehicle_GetRentTime(i))
		{
			Vehicle_SetRentTime(i, Vehicle_GetRentTime(i)-1);
			//Vehicle_ExecuteInt(i, "renttime", Vehicle_GetRentTime(i));

			if(Vehicle_GetRentTime(i) < 1)
			{
				SendServerMessage(playerid, "Kendaraan "CYAN"%s "WHITE"habis masa penyewaannya.", GetVehicleNameByVehicle(VehicleData[i][vehVehicleID]));
				SendServerMessage(playerid, "Kamu telat mengembalikan kendaraan rental dan telah di denda %s", FormatNumber(Economy_GetRentVehOvertimeFine()));
				GiveMoney(playerid, -Economy_GetRentVehOvertimeFine(), ECONOMY_ADD_SUPPLY, "paid for late unrent vehicle");

				if(IsValidVehicle(VehicleData[i][vehVehicleID]))
					DestroyVehicle(VehicleData[i][vehVehicleID]);

				// Cargo on vehicle remove
				mysql_tquery(g_iHandle, sprintf("DELETE FROM `vehicle_cargo` WHERE `vehicle_id`='%d';", VehicleData[i][vehIndex]));

				// Weapon on vehicle remove (soon)
				mysql_tquery(g_iHandle, sprintf("DELETE FROM `weapon_vehicles` WHERE `vehicleid`='%d';", VehicleData[i][vehIndex]));

				// Modding remove
				mysql_tquery(g_iHandle, sprintf("DELETE FROM `vehicle_mod` WHERE `vehicleid`='%d';", VehicleData[i][vehIndex]));

				// Vehicle database
				mysql_tquery(g_iHandle, sprintf("DELETE FROM `server_vehicles` WHERE `id` = '%d';", VehicleData[i][vehIndex]));
				
				Vehicle_ResetVariable(i);

				new next = i;
				Iter_SafeRemove(RentedVehicles<playerid>, next, i);
			}
		}
	}
	return 1;
}

hook OnPlayerDisconnectEx(playerid, reason)
{
	if(Iter_Count(OwnedVehicles<playerid>)) {
		Vehicle_PlayerUnload(playerid);
	}

	if(Iter_Count(RentedVehicles<playerid>)) {
		Vehicle_RentalUnload(playerid);
	}
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER)
	{
		static vehicleid;

		if((vehicleid = GetPlayerLastVehicle(playerid)) != INVALID_VEHICLE_ID)
		{
			static vehicle_index;

			if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
			{
				if(Vehicle_IsOwned(playerid, vehicle_index) || Vehicle_IsRented(playerid, vehicle_index) || Vehicle_IsSharedToPlayer(playerid, vehicle_index))
				{
					Vehicle_SaveData(vehicle_index);
					Vehicle_Save(vehicle_index, VEHICLE_SAVE_POSITION);
				}
			}
		}

		// Speedometer
		if(PlayerData[playerid][pHudStyle] == 0) Speedometer_Hide(playerid);
		else SpeedometerNew_Hide(playerid);

	}

	if(newstate == PLAYER_STATE_DRIVER)
	{
		static vehicle_index;

    	if(PlayerData[playerid][pDrivingLicenseExpired] < gettime())
    		SendServerMessage(playerid, "Kamu tidak memiliki "YELLOW"Driving License "WHITE"atau sudah tidak berlaku lagi!");

    	if(IsABicycle(GetPlayerVehicleID(playerid)) && !GetEngineStatus(GetPlayerVehicleID(playerid)))
    		SetEngineStatus(GetPlayerVehicleID(playerid), true);

		if((vehicle_index = Vehicle_ReturnID(GetPlayerVehicleID(playerid))) != RETURN_INVALID_VEHICLE_ID) 
		{
			switch(Vehicle_GetType(vehicle_index))
			{
				case VEHICLE_TYPE_NONE:
				{
					if(GetAdminLevel(playerid))
						SendServerMessage(playerid, "Ini kendaraan statis, "YELLOW"(/destroyveh) "WHITE"untuk menghapus.", Faction_GetNameID(Vehicle_GetExtraID(vehicle_index)));
				}
				case VEHICLE_TYPE_FACTION:
				{
					if(Vehicle_GetExtraID(vehicle_index) != GetPlayerFactionID(playerid)) {
						RemovePlayerFromVehicle(playerid);
						SendServerMessage(playerid, "Kamu tidak diizinkan menggunakan kendaraan ini "RED"(admin/faction vehicle)!");
					}
				}
				case VEHICLE_TYPE_PLAYER:
				{
					if(Vehicle_IsOwned(playerid, vehicle_index)) {
						SendServerMessage(playerid, "Kamu pemilik kendaraan "CYAN"%s "WHITE"ini.", GetVehicleNameByVehicle(VehicleData[vehicle_index][vehVehicleID]));
					}
				}
				case VEHICLE_TYPE_SIDEJOB:
				{
					switch(Vehicle_GetExtraID(vehicle_index))
					{
						case VEHICLE_SIDEJOB_BUS: CallLocalFunction("EnterBusVehicle", "dd", playerid, VehicleData[vehicle_index][vehVehicleID]);
						case VEHICLE_SIDEJOB_SWEEPER: CallLocalFunction("EnterSweeperVehicle", "dd", playerid, VehicleData[vehicle_index][vehVehicleID]);
						case VEHICLE_SIDEJOB_TRASHMASTER: CallLocalFunction("EnterTrashmasterVehicle", "dd", playerid, VehicleData[vehicle_index][vehVehicleID]);
						case VEHICLE_SIDEJOB_MONEYTRANS: CallLocalFunction("EnterMoneytransVehicle", "dd", playerid, VehicleData[vehicle_index][vehVehicleID]);
						case VEHICLE_SIDEJOB_BOXVILLE: CallLocalFunction("EnterBoxvilleVehicle", "dd", playerid, VehicleData[vehicle_index][vehVehicleID]);
					}
				}
				case VEHICLE_TYPE_RENTAL:
				{
					if(Vehicle_IsRented(playerid, vehicle_index)) {
        				new times[3];
        				GetElapsedTime(Vehicle_GetRentTime(vehicle_index), times[0], times[1], times[2]);

        				if(times[0] > 0) SendServerMessage(playerid, "Kendaraan "CYAN"%s "WHITE"sewaanmu, sisa waktu "YELLOW"%d jam %d menit", GetVehicleNameByVehicle(VehicleData[vehicle_index][vehVehicleID]), times[0], times[1]);
        				else if(times[1] > 0) SendServerMessage(playerid, "Kendaraan "CYAN"%s "WHITE"sewaanmu, sisa waktu "YELLOW"%d menit %d detik", GetVehicleNameByVehicle(VehicleData[vehicle_index][vehVehicleID]), times[1], times[2]);
        				else SendServerMessage(playerid, "Kendaraan "CYAN"%s "WHITE"sewaanmu, sisa waktu "YELLOW"%d detik", GetVehicleNameByVehicle(VehicleData[vehicle_index][vehVehicleID]), times[2]);
					}
				}
				case VEHICLE_TYPE_DRIVING_SCHOOL:
				{
					if(!IsAdminOnDuty(playerid))
					{
						if(DMV_GetTest(playerid))
						{
							DMV_Start(playerid);
							SetEngineStatus(GetPlayerVehicleID(playerid), true);
							SetDoorStatus(GetPlayerVehicleID(playerid), true);
							SetLightStatus(GetPlayerVehicleID(playerid), true);
						}
						else
						{
							RemovePlayerFromVehicle(playerid);
							SendServerMessage(playerid, "Silahkan melakukan registrasi terlebih dahulu didalam!");
						}
					}
				}
			}

			if(VehicleData[vehicle_index][vehLumber])
				SendServerMessage(playerid, "Kendaraan ini menampung "YELLOW"%d pohon!.", VehicleData[vehicle_index][vehLumber]);

			// Speedometer
			if(!PlayerData[playerid][pDisableSpeedo] && !IsABicycle(GetPlayerVehicleID(playerid)))
			{
				if(PlayerData[playerid][pHudStyle] == 0) Speedometer_Show(playerid);
				else SpeedometerNew_Show(playerid);
			}
		}
	}

	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new index = Vehicle_ReturnID(vehicleid);
		if(PRESSED(KEY_SUBMISSION) && Vehicle_GetType(index) != VEHICLE_TYPE_DRIVING_SCHOOL && Vehicle_GetType(index) != VEHICLE_TYPE_SIDEJOB)
		{
			cmd_v(playerid, "lock");
		}
		else if(PRESSED(KEY_NO))
		{
			cmd_v(playerid, "engine");
		}
		else if(PRESSED(KEY_YES) && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsABicycle(GetPlayerVehicleID(playerid)))
		{
			Dialog_Show(playerid, VehicleOperation, DIALOG_STYLE_LIST, "Vehicle Operation", "Engine\nLock\nLights\nHood\nTrunk\nSpeedometer\nToggle Neon", "Select", "Close");
		}
	}
}
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	#if defined DEBUG_MODE
	    printf("[debug] OnVehicleDamageStatusUpdate(VehicleID %d, PID : %d)", vehicleid, playerid);
	#endif

    new vehicleid_index; // Index = Vehicle id ingame, vehicleid = Index DB
    vehicleid_index = Vehicle_ReturnID(vehicleid);
    if(vehicleid_index != -1)
    {
		new panels, doors, lights, tires;
		GetVehicleDamageStatus(VehicleData[vehicleid_index][vehVehicleID], panels, doors, lights, tires);
        if(VehicleData[vehicleid_index][vehBodyUpgrade] == 3 && VehicleData[vehicleid_index][vehBodyRepair] > 0)
        {
			panels = doors = lights = tires = 0;
            UpdateVehicleDamageStatus(VehicleData[vehicleid_index][vehVehicleID], panels, doors, lights, tires);
			VehicleData[vehicleid_index][vehBodyRepair] -= 50.0;
        }
		else if(VehicleData[vehicleid_index][vehBodyRepair] <= 0)
		{
			VehicleData[vehicleid_index][vehBodyRepair] = 0;
		}
	}
	return 1;
}
