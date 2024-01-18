Dialog:ApartmentUnparkVehicle(playerid, response, listitem, inputtext[]) 
{
	if(response)
	{
		new
			id = parking_selected_vehicle[playerid][listitem],
            apartment_id
        ;

        if((apartment_id = IsAtApartmentParking(playerid)) == -1)
            return ShowPlayerFooter(playerid, "~g~INFO: ~w~Harus berada di ~y~apartment parking ~w~ atau kamu tidak memiliki ~y~apartment parking~w~ disini!.");
		
        new 
            Float:x = ApartmentData[apartment_id][apartmentParkingPosX],
            Float:y = ApartmentData[apartment_id][apartmentParkingPosY],
            Float:z = ApartmentData[apartment_id][apartmentParkingPosZ],
            Float:a = ApartmentData[apartment_id][apartmentParkingPosA]
        ;

        mysql_tquery(g_iHandle, sprintf("UPDATE server_vehicles SET `apartment_id` = '-1', `posX`='%.2f',`posY`='%.2f',`posZ`='%.2f',`posRZ`='%.2f',`state`='%d' WHERE `id`='%d';", x, y, z, a, VEHICLE_STATE_SPAWNED ,id));
		mysql_tquery(g_iHandle, sprintf("SELECT * FROM `server_vehicles` WHERE `id`='%d';", id), "VehicleLoaded", "d", playerid);

		SendServerMessage(playerid, "Kamu telah mengeluarkan "CYAN"%s "WHITE"dari "YELLOW"apartment parking.", inputtext);
	}
	return 1;
}
