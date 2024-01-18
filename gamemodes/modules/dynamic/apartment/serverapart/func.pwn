// Callback

forward OnApartmentCreated(index);
public OnApartmentCreated(index)
{
	ApartmentData[index][apartmentID] = cache_insert_id();

	Apartment_Sync(index);
	Apartment_Save(index);
	return 1;
}

forward Apartment_Load();
public Apartment_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Apartment, i);

			ApartmentData[i][apartmentID] = cache_get_field_int(i, "apartmentID");
			ApartmentData[i][apartmentType] = cache_get_field_int(i, "apartmentType");
			cache_get_field_content(i, "apartmentName", ApartmentData[i][apartmentName], 128);

			ApartmentData[i][apartmentExteriorInt] = cache_get_field_int(i, "apartmentExteriorInt");
			ApartmentData[i][apartmentExteriorWorld] = cache_get_field_int(i, "apartmentExteriorWorld");
            ApartmentData[i][apartmentExteriorPosX] = cache_get_field_float(i, "apartmentExteriorPosX");
            ApartmentData[i][apartmentExteriorPosY] = cache_get_field_float(i, "apartmentExteriorPosY");
            ApartmentData[i][apartmentExteriorPosZ] = cache_get_field_float(i, "apartmentExteriorPosZ");
            ApartmentData[i][apartmentExteriorPosA] = cache_get_field_float(i, "apartmentExteriorPosA");

			ApartmentData[i][apartmentInteriorInt] = cache_get_field_int(i, "apartmentInteriorInt");
			ApartmentData[i][apartmentInteriorWorld] = cache_get_field_int(i, "apartmentInteriorWorld");
            ApartmentData[i][apartmentInteriorPosX] = cache_get_field_float(i, "apartmentInteriorPosX");
            ApartmentData[i][apartmentInteriorPosY] = cache_get_field_float(i, "apartmentInteriorPosY");
            ApartmentData[i][apartmentInteriorPosZ] = cache_get_field_float(i, "apartmentInteriorPosZ");
            ApartmentData[i][apartmentInteriorPosA] = cache_get_field_float(i, "apartmentInteriorPosA");

            ApartmentData[i][apartmentParkingPosX] = cache_get_field_float(i, "apartmentParkingPosX");
            ApartmentData[i][apartmentParkingPosY] = cache_get_field_float(i, "apartmentParkingPosY");
            ApartmentData[i][apartmentParkingPosZ] = cache_get_field_float(i, "apartmentParkingPosZ");
            ApartmentData[i][apartmentParkingPosA] = cache_get_field_float(i, "apartmentParkingPosA");
			Apartment_Sync(i);
		}
		printf("*** Loaded %d Apartment's", cache_num_rows());
	}
	return 1;
}

// Function
Apartment_IsExists(index)
{
	if(Iter_Contains(Apartment, index))
		return 1;
	
	return 0;
}

Apartment_Create(playerid, type, name[])
{
	static
		index;

	if((index = Iter_Free(Apartment)) != cellmin)
	{
		Iter_Add(Apartment, index);

		ApartmentData[index][apartmentType] = type;
		format(ApartmentData[index][apartmentName], 128, "%s", name);

		GetPlayerPos(playerid, ApartmentData[index][apartmentExteriorPosX], ApartmentData[index][apartmentExteriorPosY], ApartmentData[index][apartmentExteriorPosZ]);
		GetPlayerFacingAngle(playerid, ApartmentData[index][apartmentExteriorPosA]);
		ApartmentData[index][apartmentExteriorInt] = GetPlayerInterior(playerid);
		ApartmentData[index][apartmentExteriorWorld] = GetPlayerVirtualWorld(playerid);

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `apartment`(`apartmentExteriorInt`) VALUES('%d');", ApartmentData[index][apartmentExteriorInt]), "OnApartmentCreated", "d", index);
		return index;
	}
	return -1;
}

Apartment_Delete(index)
{
	if(Apartment_IsExists(index))
	{
		Iter_Remove(Apartment, index);

		mysql_tquery(g_iHandle, sprintf("DELETE FROM `apartment` WHERE `apartmentID`='%d';", ApartmentData[index][apartmentID]));

		if(IsValidDynamicPickup(ApartmentData[index][apartmentExteriorPickup]))
			DestroyDynamicPickup(ApartmentData[index][apartmentExteriorPickup]);

		if(IsValidDynamic3DTextLabel(ApartmentData[index][apartmentExteriorText]))
			DestroyDynamic3DTextLabel(ApartmentData[index][apartmentExteriorText]);

		if(IsValidDynamicCP(ApartmentData[index][apartmentExteriorCheckpoint]))
			DestroyDynamicCP(ApartmentData[index][apartmentExteriorCheckpoint]);

		if(IsValidDynamicPickup(ApartmentData[index][apartmentExteriorPickupParking]))
			DestroyDynamicPickup(ApartmentData[index][apartmentExteriorPickupParking]);

		if(IsValidDynamic3DTextLabel(ApartmentData[index][apartmentExteriorTextParking]))
			DestroyDynamic3DTextLabel(ApartmentData[index][apartmentExteriorTextParking]);


		new tmp_ApartmentData[E_APARTMENT_DATA];
		ApartmentData[index] = tmp_ApartmentData;

		ApartmentData[index][apartmentExteriorPickup] = INVALID_STREAMER_ID;
		ApartmentData[index][apartmentExteriorText] = Text3D:INVALID_STREAMER_ID;
		ApartmentData[index][apartmentExteriorCheckpoint] = INVALID_STREAMER_ID;
		ApartmentData[index][apartmentExteriorPickupParking] = INVALID_STREAMER_ID; 
		ApartmentData[index][apartmentExteriorTextParking] = Text3D:INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

Apartment_Sync(index)
{
	if(Apartment_IsExists(index))
	{
		new 
			Float:x_ext = ApartmentData[index][apartmentExteriorPosX], 
			Float:y_ext = ApartmentData[index][apartmentExteriorPosY],
			Float:z_ext = ApartmentData[index][apartmentExteriorPosZ],
			int_ext = ApartmentData[index][apartmentExteriorInt],
			vw_ext = ApartmentData[index][apartmentExteriorWorld],

			Float:x_parking = ApartmentData[index][apartmentParkingPosX],
			Float:y_parking = ApartmentData[index][apartmentParkingPosY],
			Float:z_parking = ApartmentData[index][apartmentParkingPosZ]
		;		
		
		if(IsValidDynamic3DTextLabel(ApartmentData[index][apartmentExteriorText]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorText], E_STREAMER_X, x_ext);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorText], E_STREAMER_Y, y_ext);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorText], E_STREAMER_Z, z_ext);

			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorText], E_STREAMER_INTERIOR_ID, int_ext);
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorText], E_STREAMER_WORLD_ID, vw_ext);

			new string[255];
			format(string, sizeof(string), "[ID : %d]\n"YELLOW"%s\n"WHITE"%s Apartment\n"WHITE"Press '"COL_RED"~k~~GROUP_CONTROL_BWD~"WHITE"' to enter", index, ApartmentData[index][apartmentName], Apartment_GetType(ApartmentData[index][apartmentType]));
			UpdateDynamic3DTextLabelText(ApartmentData[index][apartmentExteriorText], X11_TURQUOISE_1, string);
		}
		else 
		{
			new string[255];
			format(string, sizeof(string), "[ID : %d]\n"YELLOW"%s\n"WHITE"%s Apartment\n"WHITE"Press '"COL_RED"~k~~GROUP_CONTROL_BWD~"WHITE"' to enter", index, ApartmentData[index][apartmentName], Apartment_GetType(ApartmentData[index][apartmentType]));
			ApartmentData[index][apartmentExteriorText] = CreateDynamic3DTextLabel(string, X11_TURQUOISE_1, x_ext, y_ext, z_ext, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vw_ext, int_ext);
		}

		if(IsValidDynamicPickup(ApartmentData[index][apartmentExteriorPickup]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickup], E_STREAMER_X, x_ext);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickup], E_STREAMER_Y, y_ext);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickup], E_STREAMER_Z, z_ext);

			Streamer_SetIntData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickup], E_STREAMER_INTERIOR_ID, int_ext);
			Streamer_SetIntData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickup], E_STREAMER_WORLD_ID, vw_ext);
		}
		else
		{			
			ApartmentData[index][apartmentExteriorPickup] = CreateDynamicPickup(19130, 23, x_ext, y_ext, z_ext, vw_ext, int_ext, -1, 10);
		}

		if(IsValidDynamicPickup(ApartmentData[index][apartmentExteriorCheckpoint]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_CP, ApartmentData[index][apartmentExteriorCheckpoint], E_STREAMER_X, x_ext);
			Streamer_SetFloatData(STREAMER_TYPE_CP, ApartmentData[index][apartmentExteriorCheckpoint], E_STREAMER_Y, y_ext);
			Streamer_SetFloatData(STREAMER_TYPE_CP, ApartmentData[index][apartmentExteriorCheckpoint], E_STREAMER_Z, z_ext);

			Streamer_SetIntData(STREAMER_TYPE_CP, ApartmentData[index][apartmentExteriorCheckpoint], E_STREAMER_INTERIOR_ID, int_ext);
			Streamer_SetIntData(STREAMER_TYPE_CP, ApartmentData[index][apartmentExteriorCheckpoint], E_STREAMER_WORLD_ID, vw_ext);

			new streamer_info[2];
			streamer_info[0] = APARTMENT_CHECKPOINT_INDEX;
			streamer_info[1] = index;

			Streamer_SetArrayData(STREAMER_TYPE_CP, ApartmentData[index][apartmentExteriorCheckpoint], E_STREAMER_EXTRA_ID, streamer_info);
		}
		else
		{
        	ApartmentData[index][apartmentExteriorCheckpoint] = CreateDynamicCP(x_ext, y_ext, z_ext, 1.5, vw_ext, int_ext, -1, 5);

			new streamer_info[2];
			streamer_info[0] = APARTMENT_CHECKPOINT_INDEX;
			streamer_info[1] = index;

			Streamer_SetArrayData(STREAMER_TYPE_CP, ApartmentData[index][apartmentExteriorCheckpoint], E_STREAMER_EXTRA_ID, streamer_info);

		}

		if(IsValidDynamicPickup(ApartmentData[index][apartmentExteriorPickupParking]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickupParking], E_STREAMER_X, x_parking);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickupParking], E_STREAMER_Y, y_parking);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickupParking], E_STREAMER_Z, z_parking);

			Streamer_SetIntData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickupParking], E_STREAMER_INTERIOR_ID, -1);
			Streamer_SetIntData(STREAMER_TYPE_PICKUP, ApartmentData[index][apartmentExteriorPickupParking], E_STREAMER_WORLD_ID, -1);
		}
		else
		{			
			ApartmentData[index][apartmentExteriorPickupParking] = CreateDynamicPickup(19130, 23, x_parking, y_parking, z_parking, -1, -1);
		}

        if(IsValidDynamic3DTextLabel(ApartmentData[index][apartmentExteriorTextParking]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorTextParking], E_STREAMER_X, x_parking);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorTextParking], E_STREAMER_Y, y_parking);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorTextParking], E_STREAMER_Z, z_parking);

			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorTextParking], E_STREAMER_INTERIOR_ID, -1);
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentData[index][apartmentExteriorTextParking], E_STREAMER_WORLD_ID, -1);

			new string[255];
			format(string, sizeof(string), "[ID : %d]\n"RED"%s\n"YELLOW"Parking Lot\n"RED"'/apark' & '/aunpark'", index, ApartmentData[index][apartmentName]);
			UpdateDynamic3DTextLabelText(ApartmentData[index][apartmentExteriorTextParking], X11_TURQUOISE_1, string);
		}
		else 
		{
			new string[255];
			format(string, sizeof(string), "[ID : %d]\n"RED"%s\n"YELLOW"Parking Lot\n"RED"'/apark' & '/aunpark'", index, ApartmentData[index][apartmentName]);
			ApartmentData[index][apartmentExteriorTextParking] = CreateDynamic3DTextLabel(string, X11_TURQUOISE_1, x_parking, y_parking, z_parking, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1);
		}
	}
	return 1;
}
Apartment_GetType(type)
{
	new model[255];
	switch(type)
	{
		case APARTMENT_TYPE_MODERN: model = "Modern";
		case APARTMENT_TYPE_LUXURY: model = "Luxury";
		case APARTMENT_TYPE_PENTHOUSE: model = "Penthouse";
	}
	return model;
}

Apartment_Save(index)
{
	if(Apartment_IsExists(index))
	{
		new query[4098];
		format(query, sizeof(query), "UPDATE apartment SET apartmentName='%s', apartmentType='%d'", 
			SQL_ReturnEscaped(ApartmentData[index][apartmentName]),
			ApartmentData[index][apartmentType]
		);
		format(query, sizeof(query), "%s, apartmentExteriorInt='%d', apartmentExteriorWorld='%d', apartmentExteriorPosX='%.2f', apartmentExteriorPosY='%.2f', apartmentExteriorPosZ='%.2f', apartmentExteriorPosA='%.2f'",
			query, 
			ApartmentData[index][apartmentExteriorInt],
			ApartmentData[index][apartmentExteriorWorld],
			ApartmentData[index][apartmentExteriorPosX],
			ApartmentData[index][apartmentExteriorPosY],
			ApartmentData[index][apartmentExteriorPosZ],
			ApartmentData[index][apartmentExteriorPosA]
		);
		format(query, sizeof(query), "%s, apartmentInteriorInt='%d', apartmentInteriorWorld='%d', apartmentInteriorPosX='%.2f', apartmentInteriorPosY='%.2f', apartmentInteriorPosZ='%.2f', apartmentInteriorPosA='%.2f'",
			query, 
			ApartmentData[index][apartmentInteriorInt],
			ApartmentData[index][apartmentInteriorWorld],
			ApartmentData[index][apartmentInteriorPosX],
			ApartmentData[index][apartmentInteriorPosY],
			ApartmentData[index][apartmentInteriorPosZ],
			ApartmentData[index][apartmentInteriorPosA]
		);
		format(query, sizeof(query), "%s, apartmentParkingPosX='%.2f', apartmentParkingPosY='%.2f', apartmentParkingPosZ='%.2f', apartmentParkingPosA='%.2f' WHERE apartmentID = '%d'",
			query, 
			ApartmentData[index][apartmentParkingPosX],
			ApartmentData[index][apartmentParkingPosY],
			ApartmentData[index][apartmentParkingPosZ],
			ApartmentData[index][apartmentParkingPosA],
			ApartmentData[index][apartmentID]
		);
		return mysql_tquery(g_iHandle, query);
	}
	return 0;
}

Apartment_Nearest(playerid)
{
	foreach(new i : Apartment)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, ApartmentData[i][apartmentExteriorPosX], ApartmentData[i][apartmentExteriorPosY], ApartmentData[i][apartmentExteriorPosZ]))
		{
			if(GetPlayerInterior(playerid) == ApartmentData[i][apartmentExteriorInt] && GetPlayerVirtualWorld(playerid) == ApartmentData[i][apartmentExteriorWorld])
				return i;
		}
	}
	return -1;
}

Apartment_Inside(playerid)
{
	foreach(new i : Apartment)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, ApartmentData[i][apartmentInteriorPosX], ApartmentData[i][apartmentInteriorPosY], ApartmentData[i][apartmentInteriorPosZ]) && ApartmentData[i][apartmentID] == PlayerData[playerid][pApartmentBuilding])
		{
			return i;
		}
	}
	return -1;
}

Apartment_ShowRoom(playerid, index)
{
	new headers[128], string[2048];
	format(headers, sizeof(headers), "Apartment - %s", ApartmentData[index][apartmentName]);
	strcat(string, ""GREEN"Floor\t"YELLOW"Owner\t"RED"Room\t"GREEN"Price\n");
	foreach(new i : ApartmentRoom)
	{
		if(ApartmentRoomData[i][apartmentID] == ApartmentData[index][apartmentID])
		{
			if(ApartmentRoomData[i][apartmentRoomOwner] == -1) strcat(string, sprintf(""WHITE"%d\t"RED"%s\t"YELLOW"%d\t"GREEN"For Sell %s\n", i, ApartmentRoomData[i][apartmentRoomOwnerName], ApartmentRoomData[i][apartmentRoomWorld], FormatNumber(ApartmentRoomData[i][apartmentRoomPrice])));
			else strcat(string, sprintf(""WHITE"%d\t"RED"%s\t"YELLOW"%d\t"GREEN"Owned\n", i, ApartmentRoomData[i][apartmentRoomOwnerName], ApartmentRoomData[i][apartmentRoomWorld]));
		}
	}
	SetPVarInt(playerid, "ApartmentID", index);
	Dialog_Show(playerid, APARTMENT_SHOW, DIALOG_STYLE_TABLIST_HEADERS, headers, string, "Enter", "Close");
	return 1;
}