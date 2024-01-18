
// ========================[ FUNCTIONS ]========================
Mechanic_CalculateMaintenance(playerid, vehicleid, &interim_required_component, &interim_work_time, &full_required_component, &full_work_time)
{
	interim_required_component = 0;
	full_required_component = 0;
	interim_work_time = 0;
	full_work_time = 0;

	if (!IsPlayerConnected(playerid))
	{
		return 1;
	}

	if (!IsValidVehicle(vehicleid))
	{
		return 1;
	}

	new
		current_mileage = Vehicle_GetCurrentMileage(vehicleid),
		durability_mileage = Vehicle_GetDurabilityMileage(vehicleid),
		bool:above_minimum = (current_mileage > MINIMUM_MILEAGE),
		bool:above_half = current_mileage > (floatround((floatabs(durability_mileage - current_mileage))) / 2),
		level = GetMechanicLevel(playerid),
		interim_component_used = 0,
		full_component_used = 0,
		nearest_workshop = Workshop_Nearest(playerid),
		is_at_workshop = nearest_workshop != -1,
		is_part_of_workshop = is_at_workshop ? Workshop_IsOwner(playerid, nearest_workshop) || Workshop_Employe(playerid, nearest_workshop) : false,
		is_at_mechanic_center = (IsPlayerInDynamicArea(playerid, mechanic_zone_repair[0]) || IsPlayerInDynamicArea(playerid, mechanic_zone_repair[1]) || IsPlayerInDynamicArea(playerid, mechanic_zone_ship))
	;

	// Mileage kendaraan harus di atas minimum mileage untuk bisa melakukannya.
	if (!above_minimum)
	{
		return 1;
	}

	// Jika mileage-nya di bawah separuhnya durability, maka tidak bisa menyediakan jasa interim maintenance.
	if (!above_half)
	{
		interim_component_used = componentUsed[level][interim_mt];
	}
	full_component_used = componentUsed[level][full_mt];

	if (is_at_workshop)
	{
		if (!is_part_of_workshop)
		{
			return 1;
		}

		if (interim_component_used > 0)
		{
			interim_required_component = ((floatround(floatabs(current_mileage))) * interim_component_used);
			interim_work_time 				 = interim_required_component;
		}
		else
		{
			full_required_component = (current_mileage * full_component_used);
			full_work_time					= full_required_component;
		}
	}
	else if (is_at_mechanic_center)
	{
		if (interim_component_used > 0)
		{
			interim_required_component = ((floatround(floatabs(current_mileage))) * interim_component_used);
			interim_work_time 				 = interim_required_component;
		}
		else
		{
			full_required_component = (current_mileage * full_component_used);
			full_work_time					= full_required_component;
		}
	}
	else // Di luar mekanik & workshop hanya bisa separuh saja.
	{
		new rounded_current_mileage = ((floatround(floatabs(current_mileage))));
		rounded_current_mileage     = (rounded_current_mileage > (SAFE_MILEAGE / 2)) ? (SAFE_MILEAGE / 2) : rounded_current_mileage;

		full_required_component		 = 0;
		full_work_time						 = 0;
		interim_required_component = rounded_current_mileage * interim_component_used;
		interim_work_time 				 = interim_required_component;
	}

	return 1;
}

Mechanic_CalculateRepairEngine(playerid, vehicleid, &required_component, &work_time)
{
	required_component = 0;
	work_time = 0;

	if (!IsPlayerConnected(playerid))
	{
		return 1;
	}

	if (!IsValidVehicle(vehicleid))
	{
		return 1;
	}

	new
		Float:health,
		vhp,
		level = GetMechanicLevel(playerid),
		component_used = componentUsed[level][repair_engine],
		veh_engine_level = VehicleData[Vehicle_ReturnID(vehicleid)][vehEngineUpgrade],
		nearest_workshop = Workshop_Nearest(playerid),
		is_at_workshop = nearest_workshop != -1,
		is_part_of_workshop = is_at_workshop ? Workshop_IsOwner(playerid, nearest_workshop) || Workshop_Employe(playerid, nearest_workshop) : false,
		is_at_mechanic_center = (IsPlayerInDynamicArea(playerid, mechanic_zone_repair[0]) || IsPlayerInDynamicArea(playerid, mechanic_zone_repair[1]) || IsPlayerInDynamicArea(playerid, mechanic_zone_ship))
	;

	// Mendapatkan HP kendaraan.
	GetVehicleHealth(vehicleid, health);
	// Membulatkan nilai HP kendaraan ke bawah.
	vhp = floatround(health, floatround_floor);

	// Menghitung waktu yang harus dikerjakan berdasarkan lokasi, mekanik, dan HP kendaraannya.
	if (is_at_workshop)
	{
		if (is_part_of_workshop)
		{
			if (veh_engine_level == 0)
			{
				required_component = (((1000 - vhp) / 100) * component_used);
				work_time = ((1000 - vhp) / 10);
			}
			else
			{
				required_component = (((2000 - vhp) / 200) * component_used);
				work_time = ((2000 - vhp) / 20);
			}
		}
		else
		{
			if (veh_engine_level == 0)
			{
				if (vhp > 400)
				{
					required_component = 0;
					work_time = 0;

					return 1;
				}

				required_component = (((500 - vhp) / 100) * component_used);
				work_time = ((500 - vhp) / 10);
			}
			else
			{
				required_component = (((1000 - vhp) / 200) * component_used);
				work_time = ((1000 - vhp) / 20);
			}
		}
	}
	else if (is_at_mechanic_center)
	{
		if (veh_engine_level == 0)
		{
			required_component = (((1000 - vhp) / 100) * component_used);
			work_time = ((1000 - vhp) / 10);
		}
		else
		{
			required_component = (((2000 - vhp) / 200) * component_used);
			work_time = ((2000 - vhp) / 20);
		}
	}
	else
	{
		if (veh_engine_level == 0)
		{
			if (vhp > 400)
			{
				required_component = 0;
				work_time = 0;

				return 1;
			}

			required_component = (((500 - vhp) / 100) * component_used);
			work_time = ((500 - vhp) / 10);
		}
		else
		{
			required_component = (((1000 - vhp) / 200) * component_used);
			work_time = ((1000 - vhp) / 20);
		}
	}

	return 1;
}

Mechanic_GetRequiredComponent(playerid, E_MECHANIC_SERVICE:service)
{
	return g_PlayerRepairRequirement[playerid][service];
}

Mechanic_SetRequiredComponent(playerid, E_MECHANIC_SERVICE:service, amount)
{
	g_PlayerRepairRequirement[playerid][service] = amount;
	return 1;
}

Mechanic_Reset(playerid, bool:anim = true)
{
	new vehicleid = GetRepairVehicle(playerid);

	if (vehicleid >= 1)
	{
		VehicleData[vehicleid][vehModSectionPreview] = 0;
		VehicleData[vehicleid][vehModCompPreview] = 0;
	}

	if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
	{
		new
			Float:x,
			Float:y,
			Float:z
		;

		GetPlayerPos(playerid, x, y, z);
		SetPlayerPos(playerid, x, y, z + 1.0);
	}


	SetRepairingVehicle(playerid, 0);

	SetRepairTime(playerid, 0);
	SetRepairType(playerid, 0);
	SetRepairVehicle(playerid, 0);
	SetRepairComponent(playerid, 0);

	DeletePVar(playerid, "MechanicColor1");
	DeletePVar(playerid, "MechanicColor2");
	DeletePVar(playerid, "MechanicUninstallCompSection");
	DeletePVar(playerid, "MechanicUninstallCompMod");

	if(anim) ClearAnimations(playerid);

	g_PlayerRepairRequirement[playerid] = g_PlayerRepairRequirement[MAX_PLAYERS];
	return 1;
}

Mechanic_AddEXP(playerid, exp)
{
	new level_unlock[] = {500, 2500, 5000};

	if(GetMechanicLevel(playerid) >= 3)
		return 1;

	SetMechanicEXP(playerid, GetMechanicEXP(playerid) + exp);

	if(GetMechanicEXP(playerid) >= level_unlock[GetMechanicLevel(playerid)])
	{
		SetMechanicLevel(playerid, GetMechanicLevel(playerid) + 1);
		UpdateCharacterInt(playerid, "MechanicLevel", GetMechanicLevel(playerid));
		SendServerMessage(playerid, "Level mekanik naik menjadi "YELLOW"level %d"WHITE", selamat!", (GetMechanicLevel(playerid) + 1));
	}
	
	UpdateCharacterInt(playerid, "MechanicEXP", GetMechanicEXP(playerid));
	return 1;
}

Mechanic_ApplyMod(playerid, vehicleid)
{
	if (!IsPlayerConnected(playerid))
	{
		return 1;
	}

	if(IsRepairingVehicle(playerid))
	{
		ShowPlayerFooter(playerid, "Anda sedang memperbaiki kendaraan!", 3000, 1);
		return 1;
	}

	if (vehicleid < 1 || vehicleid == INVALID_VEHICLE_ID)
	{
		ShowPlayerFooter(playerid, "Tidak ada kendaraan terdekat!", 3000, 1);
		return 1;
	}

	if (VehicleData[vehicleid][vehModCompPreview] < 1000)
	{
		ShowPlayerFooter(playerid, "Kendaraan ini tidak memiliki mod yang sedang dipratinjau!", 3000, 1);
		return 1;
	}

	SetPVarInt(playerid, "MechanicModif", VehicleData[vehicleid][vehModCompPreview]);
	SetRepairingVehicle(playerid, 1);
	SetRepairType(playerid, REPAIR_MODIF);

	if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
	{
		SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"memasang komponen kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));
	}

	SendServerMessage(playerid, "Mulai memasang "YELLOW"komponent "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
	return 1;
}

Mechanic_CancelMod(playerid, vehicleid)
{
	if (!IsPlayerConnected(playerid))
	{
		return 1;
	}

	if (vehicleid < 1 || vehicleid == INVALID_VEHICLE_ID)
	{
		ShowPlayerFooter(playerid, "Tidak ada kendaraan terdekat!", 3000, 1);
		return 1;
	}

	new
		previewsectionid = VehicleData[vehicleid][vehModSectionPreview],
		previewcomponentid = VehicleData[vehicleid][vehModCompPreview]
	;

	if (previewsectionid < 0 || previewsectionid > MAX_VEHICLE_MOD_SECTIONS || previewcomponentid < 1000)
	{
		ShowPlayerFooter(playerid, "Kendaraan ini tidak memiliki mod yang sedang dipratinjau!", 3000, 1);
		return 1;
	}

	new currentcomponentid = VehicleData[vehicleid][vehMod][previewsectionid];

	RemoveVehicleComponent(vehicleid, previewcomponentid);
	AddVehicleComponent(vehicleid, currentcomponentid);

	if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
	{
		SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"telah melepas pratinjau (preview) komponen kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));
	}

	SendServerMessage(playerid, "Pratinjau (preview) "YELLOW"component "WHITE"Anda telah dibatalkan.");

	VehicleData[vehicleid][vehModSectionPreview] = 0;
	VehicleData[vehicleid][vehModCompPreview] = 0;
	return 1;
}

Mechanic_ShowMenu(playerid, menu)
{
	if (menu == 0)
	{
		return 0;
	}

	new
		// Untuk daftar menu di dialog.
		output[768]
	;

	// Header untuk tablist di dialog.
	strcat(output, "ID\tMenu\tComponent\n");

	if (menu & MECH_MENU_CHANGE_COLOR)
	{
		strcat(output, sprintf("%d\tChange Color\t(%d)\n", MECH_MENU_ID_CHANGE_COLOR, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_COLOR)));
	}

	if (menu & MECH_MENU_REPAIR_TIRE)
	{
		strcat(output, sprintf("%d\tFix Tire\t(%d)\n", MECH_MENU_ID_REPAIR_TIRE, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_TIRE)));
	}

	if (menu & MECH_MENU_REPAIR_BODY)
	{
		strcat(output, sprintf("%d\tRepair Body\t(%d)\n", MECH_MENU_ID_REPAIR_BODY, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_BODY)));
	}

	if (menu & MECH_MENU_HALF_REPAIR_ENGINE)
	{
		strcat(output, sprintf("%d\tRepair Engine (50%%)\t(%d)\n", MECH_MENU_ID_HALF_REPAIR_ENGINE, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_HALF_REPAIR_ENGINE)));
	}

	if (menu & MECH_MENU_REPAIR_ENGINE)
	{
		strcat(output, sprintf("%d\tRepair Engine\t(%d)\n", MECH_MENU_ID_REPAIR_ENGINE, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_REPAIR_ENGINE)));
	}

	if (menu & MECH_MENU_CHANGE_PAINTJOB)
	{
		strcat(output, sprintf("%d\tChange Paintjob\t(%d)\n", MECH_MENU_ID_CHANGE_PAINTJOB, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_PAINTJOB)));
	}

	if (menu & MECH_MENU_INSTALL_HYDRAULICS)
	{
		strcat(output, sprintf("%d\tInstall Hydraulics\t(%d)\n", MECH_MENU_ID_INSTALL_HYDRAULICS, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INSTALL_HYDRAULICS)));
	}

	if (menu & MECH_MENU_CHANGE_WHEELS)
	{
		strcat(output, sprintf("%d\tChange Wheels\t(%d)\n", MECH_MENU_ID_CHANGE_WHEELS, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_CHANGE_WHEELS)));
	}

	if (menu & MECH_MENU_UPGRADE)
	{
		strcat(output, sprintf("%d\tUpgrade Vehicle\t(%d)\n", MECH_MENU_ID_UPGRADE, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_UPGRADE)));
	}

	if (menu & MECH_MENU_MODIF)
	{
		strcat(output, sprintf("%d\tVehicle Modification\t(%d)\n", MECH_MENU_ID_MODIF, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_MODIF)));
	}

	if (menu & MECH_MENU_UNINSTALL_MODIF)
	{
		strcat(output, sprintf("%d\tUninstall Vehicle Modification\t(%d)\n", MECH_MENU_ID_UNINSTALL_MODIF, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_UNINSTALL_MODIF)));
	}

	if (menu & MECH_MENU_NEON)
	{
		strcat(output, sprintf("%d\tVehicle Neon\t(%d)\n", MECH_MENU_ID_NEON, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_NEON)));
	}

	if (menu & MECH_MENU_TURBO)
	{
		strcat(output, sprintf("%d\tTurbo Charge\t(%d)\n", MECH_MENU_ID_TURBO, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_TURBO)));
	}

	if (menu & MECH_MENU_INTERIM_MT)
	{
		strcat(output, sprintf("%d\tInterim Maintenance\t(%d)\n", MECH_MENU_ID_INTERIM_MT, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_INTERIM_MT)));
	}

	if (menu & MECH_MENU_FULL_MT)
	{
		strcat(output, sprintf("%d\tFull Maintenance\t(%d)\n", MECH_MENU_ID_FULL_MT, Mechanic_GetRequiredComponent(playerid, MECH_SERVICE_FULL_MT)));
	}

	Dialog_Show(playerid, MechanicMenu, DIALOG_STYLE_TABLIST_HEADERS, "Mechanic Menu", output, "Select", "Close");
	return 1;
}




forward MechanicOnTuneLoad(playerid, idx);
public MechanicOnTuneLoad(playerid, idx)
{
    static rows, fields;
    switch (idx)
    {
        case 0:
        {
            new dialog_info[79], part_name[14];

            cache_get_data(rows, fields);
            for (new i; i != rows; i++)
            {
                cache_get_value_index(i, 0, part_name);

                strcat(dialog_info, part_name);
                strcat(dialog_info, "\n");
            }
			Dialog_Show(playerid, MechanicTune, DIALOG_STYLE_LIST, "Available Parts", dialog_info, "Select", "Cancle");
        }
        case 1:
        {            
            cache_get_data(rows, fields);		
            if (rows)
            {
                new dialog_info[80], part_name[13];
                //static rows, fields;
 
                for (new i; i != rows; i++)
                {
                    cache_get_value_index(i, 0, part_name);

                    if (!isnull(part_name))
                    {
                        strcat(dialog_info, part_name);
                        strcat(dialog_info, "\n");
                    }
                }
				
                Dialog_Show(playerid, MechanicTune, DIALOG_STYLE_LIST, "Available Parts", dialog_info, "Select", "Cancle");
            }
            else SendErrorMessage(playerid, "You cannot tune this vehicle.");
        }
        case 2:
        {
            static dialog_info[716];
            new componentid, type[32];

            dialog_info = "{FF0000}Component ID\t{FF8000}Type\n";
	        cache_get_data(rows, fields);
            for (new i; i != rows; i++)
            {
                componentid = cache_get_row_int(i, 0);
                cache_get_value_index(i, 1, type);
                
                format(dialog_info, sizeof dialog_info, "%s%i\t%s\n", dialog_info, componentid, type);
            }
	        
            if (componentid == 1087) strcat(dialog_info, " ----\tRemove Hydraulics");
            
            Dialog_Show(playerid, MechanicTuneTwo, DIALOG_STYLE_TABLIST_HEADERS, "Available Parts", dialog_info, "Install", "Back");
        }
    }
}

