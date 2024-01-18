CMD:apark(playerid, params[])
{
	new vehicleid,
        vehicle_index,
        apartment_id
    ;	
	
	if((apartment_id = IsAtApartmentParking(playerid)) == -1)
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Harus berada di ~y~apartment parking ~w~ atau kamu tidak memiliki ~y~apartment parking~w~ disini!.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You need to be inside a vehicle to use this command!");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "You need to be driver to use this command!");
		
	vehicleid = GetPlayerVehicleID(playerid);
	vehicle_index = Vehicle_ReturnID(vehicleid);
	
	if(vehicle_index == -1)
		return SendErrorMessage(playerid, "Invalid Vehicle ID");
	
	if(Vehicle_IsOwned(playerid, vehicle_index))
	{
		Vehicle_SaveData(vehicle_index);
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
		Vehicle_Save(vehicle_index);
		mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET `apartment_id` = '%d', `state`='%d' WHERE `id`='%d';", ApartmentData[apartment_id][apartmentID], VEHICLE_STATE_APARTPARKED, VehicleData[vehicle_index][vehIndex]));

		Vehicle_Delete(vehicle_index, false);
		SendServerMessage(playerid, "You park your vehicle on apartment parking!");
	}
    else SendErrorMessage(playerid, "This is not your vehicle!");
	return 1;
}

CMD:aunpark(playerid, params[])
{
    new apartment_id;
	if((apartment_id = IsAtApartmentParking(playerid)) == -1)
		return ShowPlayerFooter(playerid, "~g~INFO: ~w~Harus berada di ~y~apartment parking ~w~ atau kamu tidak memiliki ~y~apartment parking~w~ disini!.");

	new 
        Cache:execute, 
        output[255],
        apartid = ApartmentData[apartment_id][apartmentID]
    ;

	execute = mysql_query(g_iHandle, sprintf("SELECT `id`, `model` FROM `server_vehicles` WHERE `state` = '%d' AND `apartment_id` = '%d' AND `extraid`='%d' AND `type`='%d';", VEHICLE_STATE_APARTPARKED, apartid, GetPlayerSQLID(playerid), VEHICLE_TYPE_PLAYER));

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
		Dialog_Show(playerid, ApartmentUnparkVehicle, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle Parking", output, "Unpark", "Close");
	}
	else ShowPlayerFooter(playerid, "~r~ERROR: ~w~Tidak ada kendaraanmu pada apartment parking!");

	cache_delete(execute);
	return 1;
}