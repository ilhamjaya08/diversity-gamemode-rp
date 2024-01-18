// ========================[ COMMANDS ]========================
CMD:mm(playerid, params[])
{
	cmd_mechanicmenu(playerid, params);
	return 1;
}

CMD:mw(playerid, params[])
{
	cmd_mechanicmenu(playerid, params);
	return 1;
}

CMD:mechanicworkshop(playerid, params[])
{
	cmd_mechanicmenu(playerid, params);
	return 1;
}

CMD:mechanicmenu(playerid, params[])
{
	new
		action[10],
		result = sscanf(params, "s[10]", action),
		vehicleid = Vehicle_Nearest(playerid, 5)
	;

	if(PlayerData[playerid][pJob] != JOB_MECHANIC)
		return ShowPlayerFooter(playerid, "Kamu bukan seorang ~g~mekanik!", 3000, 1);

	if(PlayerData[playerid][pHunger] <= 20.0)
		return ShowPlayerFooter(playerid, "Kamu terlalu lelah, isi ~g~energi ~w~terlebih dahulu!", 3000, 1);

	if(PlayerData[playerid][pCuffed] || PlayerData[playerid][pTied] || PlayerData[playerid][pInjured])
		return ShowPlayerFooter(playerid, "Kondisi ~r~injured/borgol ~w~tidak dapat menggunakan perintah ini!", 3000, 1);

	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return ShowPlayerFooter(playerid, "Keluar dari kendaraan untuk melakukan perbaikan!", 3000, 1);

	if(!IsABicycle(vehicleid) && GetEngineStatus(vehicleid))
		return ShowPlayerFooter(playerid, "~r~Nonaktifkan mesin ~w~motor terlebih dahulu!", 3000, 1);
	
	if(IsRepairingVehicle(playerid) || (result && (strcmp(action, "applymod") != 0 || strcmp(action, "cancelmod") != 0)))
		return ShowPlayerFooter(playerid, "Kamu menggagalkan perbaikan kendaraan!", 3000, 1), Mechanic_Reset(playerid);

	if (vehicleid < 1) // Harus ada kendaraan dalam radius 5 meter di sekitar player.
	{
		ShowPlayerFooter(playerid, "Tidak ada kendaraan di dekatmu (radius ~g~5 meter~w~).");
		return 1;
	}

	new 
		work_time,
		engine_component,
		level = GetMechanicLevel(playerid),
		id = Workshop_Nearest(playerid),
		is_at_mechanic_center = (IsPlayerInDynamicArea(playerid, mechanic_zone_repair[0]) || IsPlayerInDynamicArea(playerid, mechanic_zone_repair[1]) || IsPlayerInDynamicArea(playerid, mechanic_zone_ship)),
		is_owner = Workshop_IsOwner(playerid, id),
		mechanic_menu,
		is_vehicle_has_tire = IsVehicleHasTire(vehicleid),
		is_four_wheel_vehicle = IsFourWheelVehicle(vehicleid),
		is_bicycle = IsABicycle(vehicleid),
		// Interim Maintenance
		interim_mt_work_time,
		interim_mt_component,
		// Full Maintenance
		full_mt_work_time,
		full_mt_component
	;

	// Kendaraan roda empat harus membuka kap mobilnya terlebih dahulu.
	if(is_four_wheel_vehicle && !GetHoodStatus(vehicleid))
	{
		ShowPlayerFooter(playerid, "Buka ~g~kap ~w~kendaraan terlebih dahulu!", 3000, 1);
		return 1;
	}

	// Untuk memasang mod setelah memilih modifikasi.
	if (!result && strcmp(action, "applymod") == 0)
	{
		Mechanic_ApplyMod(playerid, vehicleid);
		return 1;
	}

	// Untuk melepas preview modifikasi setelah memilih modifikasi.
	if (!result && strcmp(action, "cancelmod") == 0)
	{
		Mechanic_CancelMod(playerid, vehicleid);
		return 1;
	}

	// Menghitung komponen yang diperlukan dan waktu pengerjaan untuk repair engine.
	Mechanic_CalculateRepairEngine(playerid, vehicleid, engine_component, work_time);

	// Menghitung komponen yang diperlukan dan waktu pengerjaan untuk servis mesin.
	Mechanic_CalculateMaintenance(playerid, vehicleid, interim_mt_component, interim_mt_work_time, full_mt_component, full_mt_work_time);

	// Blok ini untuk ketika player dekat dengan workshop.
	if(id != -1)
	{
		if (is_owner || Workshop_Employe(playerid, id)) // Blok ini untuk player yang merupakan pemilik atau pegawai workshop.
		{
			if (is_bicycle)
			{
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE, engine_component);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR, componentUsed[level][repair_color]);

				mechanic_menu =
					(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE) > 0 ? MECH_MENU_REPAIR_ENGINE : 0) |
					(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR) > 0 ? MECH_MENU_CHANGE_COLOR : 0)
				;
			}
			else if (IsABike(vehicleid) || IsSportBike(vehicleid) || IsABoat(vehicleid))
			{
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE, engine_component);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE, IsABoat(vehicleid) ? 0 : componentUsed[level][repair_tire]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR, componentUsed[level][repair_color]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_UPGRADE, componentUsed[level][upgrade]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT, 0);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_FULL_MT, 0);

				mechanic_menu =
					(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE) > 0 ? MECH_MENU_REPAIR_ENGINE : 0) |
					(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE) > 0 ? MECH_MENU_REPAIR_TIRE : 0) |
					(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR) > 0 ? MECH_MENU_CHANGE_COLOR : 0) |
					(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_UPGRADE) > 0 ? MECH_MENU_UPGRADE : 0) |
					(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT) > 0 ? MECH_MENU_INTERIM_MT : 0) |
					(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_FULL_MT) > 0 ? MECH_MENU_FULL_MT : 0)
				;
			}
			else
			{
				// Menentukan komponen yang dibutuhkan.
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE, engine_component);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE, componentUsed[level][repair_tire]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_BODY, componentUsed[level][repair_body]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR, componentUsed[level][repair_color]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_PAINTJOB, componentUsed[level][repair_paintjob]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_WHEELS, componentUsed[level][repair_wheels]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_INSTALL_HYDRAULICS, componentUsed[level][repair_hydraulics]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_UPGRADE, componentUsed[level][upgrade]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_MODIF, componentUsed[level][modif]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_UNINSTALL_MODIF, componentUsed[level][uninstall_modif]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_NEON, componentUsed[level][neon]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_TURBO, componentUsed[level][turbo]);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT, 0);
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_FULL_MT, 0);
			}


			// Jika ada is_four_wheel_vehicle, artinya menu tersebut hanya muncul di kendaraan roda empat.
			mechanic_menu =
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE) > 0 ? MECH_MENU_REPAIR_ENGINE : 0) |
				(is_vehicle_has_tire && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE) > 0 ? MECH_MENU_REPAIR_TIRE : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_BODY) > 0 ? MECH_MENU_REPAIR_BODY : 0) |
				(is_vehicle_has_tire && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR) > 0 ? MECH_MENU_CHANGE_COLOR : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_PAINTJOB) > 0 ? MECH_MENU_CHANGE_PAINTJOB : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_WHEELS) > 0 ? MECH_MENU_CHANGE_WHEELS : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INSTALL_HYDRAULICS) > 0 ? MECH_MENU_INSTALL_HYDRAULICS : 0) |
				(is_vehicle_has_tire && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_UPGRADE) > 0 ? MECH_MENU_UPGRADE : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_MODIF) > 0 ? MECH_MENU_MODIF : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_UNINSTALL_MODIF) > 0 ? MECH_MENU_UNINSTALL_MODIF : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_NEON) > 0 ? MECH_MENU_NEON : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_TURBO) > 0 ? MECH_MENU_TURBO : 0) |
				// Maintenance
				(!is_bicycle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT) > 0 ? MECH_MENU_INTERIM_MT : 0) |
				(!is_bicycle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_FULL_MT) > 0 ? MECH_MENU_FULL_MT : 0)
			;
		}
		else // Blok ini untuk player yang bukan pemilik atau pegawai workshop.
		{
			// Jika kendaraan bisa diperbaiki, maka menentukan jumlah komponen yang diperlukan.
			if (engine_component > 0)
			{
				Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_HALF_REPAIR_ENGINE, engine_component);
			}
			// Menetapkan jumlah komponen untuk memperbaiki ban.
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE, componentUsed[level][repair_tire]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT, interim_mt_component);

			// Memunculkan menu repair engine dan tire.
			mechanic_menu =
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE) > 0 ? MECH_MENU_REPAIR_ENGINE : 0) |
				(!IsABicycle(vehicleid) && is_vehicle_has_tire && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE) ? MECH_MENU_REPAIR_TIRE : 0) |
				(IsABike(vehicleid) && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT) > 0 ? MECH_MENU_INTERIM_MT : 0)
			;
		}
	}
	else if(is_at_mechanic_center) // Blok ini untuk ketika player dekat dengan mechanic center.
	{
		if (IsABicycle(vehicleid))
		{
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE, engine_component);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR, componentUsed[level][repair_color]);

			mechanic_menu =
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE) > 0 ? MECH_MENU_REPAIR_ENGINE : 0) |
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR) > 0 ? MECH_MENU_CHANGE_COLOR : 0)
			;
		}
		else if (IsABike(vehicleid) || IsSportBike(vehicleid) || IsABoat(vehicleid))
		{
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE, engine_component);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE, IsABoat(vehicleid) ? 0 : componentUsed[level][repair_tire]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR, componentUsed[level][repair_color]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_UPGRADE, componentUsed[level][upgrade]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT, 0);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_FULL_MT, 0);

			mechanic_menu =
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE) > 0 ? MECH_MENU_REPAIR_ENGINE : 0) |
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE) > 0 ? MECH_MENU_REPAIR_TIRE : 0) |
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR) > 0 ? MECH_MENU_CHANGE_COLOR : 0) |
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_UPGRADE) > 0 ? MECH_MENU_UPGRADE : 0) |
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT) > 0 ? MECH_MENU_INTERIM_MT : 0) |
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_FULL_MT) > 0 ? MECH_MENU_FULL_MT : 0)
			;
		}
		else
		{
			// Menentukan komponen yang dibutuhkan.
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE, engine_component);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE, componentUsed[level][repair_tire]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_BODY, componentUsed[level][repair_body]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR, componentUsed[level][repair_color]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_PAINTJOB, componentUsed[level][repair_paintjob]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_CHANGE_WHEELS, componentUsed[level][repair_wheels]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_INSTALL_HYDRAULICS, 0);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_UPGRADE, componentUsed[level][upgrade]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_MODIF, 0);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_UNINSTALL_MODIF, componentUsed[level][uninstall_modif]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_NEON, componentUsed[level][neon]);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_TURBO, 0);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT, 0);
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_FULL_MT, 0);

			// Jika ada is_four_wheel_vehicle, artinya menu tersebut hanya muncul di kendaraan roda empat.
			mechanic_menu =
				(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE) > 0 ? MECH_MENU_REPAIR_ENGINE : 0) |
				(is_vehicle_has_tire && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE) > 0 ? MECH_MENU_REPAIR_TIRE : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_BODY) > 0 ? MECH_MENU_REPAIR_BODY : 0) |
				(is_vehicle_has_tire && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR) > 0 ? MECH_MENU_CHANGE_COLOR : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_PAINTJOB) > 0 ? MECH_MENU_CHANGE_PAINTJOB : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_WHEELS) > 0 ? MECH_MENU_CHANGE_WHEELS : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INSTALL_HYDRAULICS) > 0 ? MECH_MENU_INSTALL_HYDRAULICS : 0) |
				(is_vehicle_has_tire && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_UPGRADE) > 0 ? MECH_MENU_UPGRADE : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_MODIF) > 0 ? MECH_MENU_MODIF : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_UNINSTALL_MODIF) > 0 ? MECH_MENU_UNINSTALL_MODIF : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_NEON) > 0 ? MECH_MENU_NEON : 0) |
				(is_four_wheel_vehicle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_TURBO) > 0 ? MECH_MENU_TURBO : 0) |
				// Maintenance
				(!is_bicycle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT) > 0 ? MECH_MENU_INTERIM_MT : 0) |
				(!is_bicycle && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_FULL_MT) > 0 ? MECH_MENU_FULL_MT : 0)
			;
		}
	}
	else // Blok ini untuk player yang bukan pemilik atau pegawai workshop.
	{
		// Jika kendaraan bisa diperbaiki, maka menentukan jumlah komponen yang diperlukan.
		if (engine_component > 0)
		{
			Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_HALF_REPAIR_ENGINE, engine_component);
		}
		// Menetapkan jumlah komponen untuk memperbaiki ban.
		Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE, componentUsed[level][repair_tire]);
		Mechanic_SetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT, 0);

		// SendClientMessageEx(playerid, -1, "vehicleid=%d | IsABike=%d", vehicleid, IsABike(vehicleid));
		// SendClientMessageEx(playerid, -1, "interim_mt_component=%d | interim_mt_work_time=%d | full_mt_component=%d | full_mt_work_time=%d", interim_mt_component, interim_mt_work_time, full_mt_component, full_mt_work_time);

		// Memunculkan menu repair engine dan tire.
		mechanic_menu =
			(Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_HALF_REPAIR_ENGINE) > 0 ? MECH_MENU_HALF_REPAIR_ENGINE : 0) |
			(is_vehicle_has_tire && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE) ? MECH_MENU_REPAIR_TIRE : 0) |
			(IsABike(vehicleid) && Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT) > 0 ? MECH_MENU_INTERIM_MT : 0)
		;
	}

	// Menetapkan kendaraan yang ingin dikendarai.
	SetRepairVehicle(playerid, vehicleid);

	// Mengirim pesan server ke pemilik kendaraan (jika ada).
	if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
	{
		SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memeriksa kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));
	}

	// Memunculkan menu mekanik.
	mechanic_menu = Mechanic_ShowMenu(playerid, mechanic_menu);

	// Jika tidak bisa menampilkan apapun, maka munculkan pesan.
	if (mechanic_menu == 0)
	{
		ShowPlayerFooter(playerid, "Tidak ada aksi mekanik yang bisa dimunculkan!", 3000, 1);
	}
	return 1;
}
