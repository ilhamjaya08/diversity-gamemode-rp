// Callback

forward OnApartmentRoomCreated(index);
public OnApartmentRoomCreated(index)
{
	ApartmentRoomData[index][apartmentRoomID] = cache_insert_id();

	ApartmentRoomData[index][apartmentRoomWorld] = ApartmentRoomData[index][apartmentRoomID];
	ApartmentRoomData[index][apartmentRoomInterior] = 0;

	ApartmentRoom_Sync(index);
	ApartmentRoom_Save(index);
	return 1;
}

forward ApartmentRoom_Load();
public ApartmentRoom_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(ApartmentRoom, i);

			ApartmentRoomData[i][apartmentRoomID] = cache_get_field_int(i, "apartmentRoomID");
			ApartmentRoomData[i][apartmentID] = cache_get_field_int(i, "apartmentID");

			ApartmentRoomData[i][apartmentRoomOwner] = cache_get_field_int(i, "apartmentRoomOwner");
			ApartmentRoomData[i][apartmentRoomPrice] = cache_get_field_int(i, "apartmentRoomPrice");

			cache_get_field_content(i, "apartmentRoomOwnerName", ApartmentRoomData[i][apartmentRoomOwnerName], 128);
			cache_get_field_content(i, "apartmentRoomName", ApartmentRoomData[i][apartmentRoomName], 128);

			ApartmentRoomData[i][apartmentRoomInterior] = cache_get_field_int(i, "apartmentRoomInterior");
			ApartmentRoomData[i][apartmentRoomWorld] = cache_get_field_int(i, "apartmentRoomWorld");

            ApartmentRoomData[i][apartmentRoomExteriorPosX] = cache_get_field_float(i, "apartmentExteriorRoomPosX");
            ApartmentRoomData[i][apartmentRoomExteriorPosY] = cache_get_field_float(i, "apartmentExteriorRoomPosY");
            ApartmentRoomData[i][apartmentRoomExteriorPosZ] = cache_get_field_float(i, "apartmentExteriorRoomPosZ");
            ApartmentRoomData[i][apartmentRoomExteriorPosA] = cache_get_field_float(i, "apartmentExteriorRoomPosA");

            ApartmentRoomData[i][apartmentRoomInteriorPosX] = cache_get_field_float(i, "apartmentInteriorRoomPosX");
            ApartmentRoomData[i][apartmentRoomInteriorPosY] = cache_get_field_float(i, "apartmentInteriorRoomPosY");
            ApartmentRoomData[i][apartmentRoomInteriorPosZ] = cache_get_field_float(i, "apartmentInteriorRoomPosZ");
            ApartmentRoomData[i][apartmentRoomInteriorPosA] = cache_get_field_float(i, "apartmentInteriorRoomPosA");

            ApartmentRoomData[i][apartmentRoomLock] = cache_get_field_int(i, "apartmentRoomLock");

			mysql_tquery(g_iHandle, sprintf("SELECT * FROM `weapon_apartment` WHERE `apartmentRoomID`='%d' ORDER BY `WeaponSlot` DESC LIMIT 10", ApartmentRoomData[i][apartmentRoomID]), "LoadApartmentWeapon", "d", i);
			mysql_tquery(g_iHandle, sprintf("SELECT * FROM `apartment_storage` WHERE `apartmentRoomID`='%d' ORDER BY `itemID` DESC LIMIT 10", ApartmentRoomData[i][apartmentRoomID]), "LoadApartmentStorage", "d", i);

			ApartmentRoom_Sync(i);
		}
		printf("*** Loaded %d Apartments Room", cache_num_rows());
	}
	return 1;
}

// Function
ApartmentRoom_IsExists(index)
{
	if(Iter_Contains(ApartmentRoom, index))
		return 1;
	
	return 0;
}

ApartmentRoom_Create(playerid, apartmentid)
{
	new index;
	if((index = Iter_Free(ApartmentRoom)) != cellmin)
	{
		Iter_Add(ApartmentRoom, index);
		format(ApartmentRoomData[index][apartmentRoomName], 128, "%s", ApartmentData[apartmentid][apartmentName]);
		format(ApartmentRoomData[index][apartmentRoomOwnerName], 128, "Real Estate");

		ApartmentRoomData[index][apartmentRoomPrice] = 150000;
		ApartmentRoomData[index][apartmentRoomOwner] = -1;

		ApartmentRoomData[index][apartmentID] = ApartmentData[apartmentid][apartmentID];
		GetPlayerPos(playerid, ApartmentRoomData[index][apartmentRoomExteriorPosX], ApartmentRoomData[index][apartmentRoomExteriorPosY], ApartmentRoomData[index][apartmentRoomExteriorPosZ]);

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `apartment_room`(`apartmentID`) VALUES('%d');", ApartmentRoomData[index][apartmentID]), "OnApartmentRoomCreated", "d", index);
		return index;
	}
	return -1;
}

ApartmentRoom_Delete(index, bool:removeall = false)
{
	if(ApartmentRoom_IsExists(index))
	{
		if(!removeall) Iter_Remove(ApartmentRoom, index);

		mysql_tquery(g_iHandle, sprintf("DELETE FROM `apartment_room` WHERE `apartmentRoomID`='%d';", ApartmentRoomData[index][apartmentRoomID]));

		if(IsValidDynamicPickup(ApartmentRoomData[index][apartmentRoomPickup]))
			DestroyDynamicArea(ApartmentRoomData[index][apartmentRoomPickup]);

		if(IsValidDynamic3DTextLabel(ApartmentRoomData[index][apartmentRoomText]))
			DestroyDynamic3DTextLabel(ApartmentRoomData[index][apartmentRoomText]);

		new tmp_ApartmentRoomData[E_APARTMENTROOM_DATA];
		ApartmentRoomData[index] = tmp_ApartmentRoomData;

		ApartmentRoomData[index][apartmentRoomPickup] = INVALID_STREAMER_ID;
		ApartmentRoomData[index][apartmentRoomText] = Text3D:INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

ApartmentRoom_Sync(index)
{
	if(ApartmentRoom_IsExists(index))
	{
		new 
			Float:x_ext = ApartmentRoomData[index][apartmentRoomExteriorPosX], 
			Float:y_ext = ApartmentRoomData[index][apartmentRoomExteriorPosY],
			Float:z_ext = ApartmentRoomData[index][apartmentRoomExteriorPosZ],

			int_ext = ApartmentRoomData[index][apartmentRoomInterior],
			vw_ext = ApartmentRoomData[index][apartmentRoomWorld]
		;		
		
		new 
				string[1024],
				ownerid = ApartmentRoomData[index][apartmentRoomOwner]
		;
		if(IsValidDynamic3DTextLabel(ApartmentRoomData[index][apartmentRoomText]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentRoomData[index][apartmentRoomText], E_STREAMER_X, x_ext);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentRoomData[index][apartmentRoomText], E_STREAMER_Y, y_ext);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentRoomData[index][apartmentRoomText], E_STREAMER_Z, z_ext);

			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentRoomData[index][apartmentRoomText], E_STREAMER_INTERIOR_ID, int_ext);
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, ApartmentRoomData[index][apartmentRoomText], E_STREAMER_WORLD_ID, vw_ext);
			
			if(ownerid == -1) format(string, sizeof(string), ""WHITE"[ID : %d]\n "RED"%s\n"WHITE"Apartment Room "YELLOW"%d\n"WHITE"Owner : "YELLOW"Real Estate\n"WHITE"Price : "GREEN"%s\n"WHITE"Type '"COL_RED"/buy"WHITE"' to buy this property", index, ApartmentRoomData[index][apartmentRoomName], ApartmentRoomData[index][apartmentRoomWorld], FormatNumber(ApartmentRoomData[index][apartmentRoomPrice]));
			else format(string, sizeof(string), ""WHITE"[ID : %d]\n"RED" %s\n"WHITE"Apartment Room "YELLOW"%d\n"WHITE"Owner : %s\nPress '"COL_RED"~k~~GROUP_CONTROL_BWD~"WHITE"' to enter", index, ApartmentRoomData[index][apartmentRoomName], ApartmentRoomData[index][apartmentRoomWorld], ApartmentRoomData[index][apartmentRoomOwnerName]);
			UpdateDynamic3DTextLabelText(ApartmentRoomData[index][apartmentRoomText], X11_TURQUOISE_1, string);
		}
		else 
		{
			if(ownerid == -1) format(string, sizeof(string), ""WHITE"[ID : %d]\n "RED"%s\n"WHITE"Apartment Room "YELLOW"%d\n"WHITE"Owner : "YELLOW"Real Estate\n"WHITE"Price : "GREEN"%s\n"WHITE"Type '"COL_RED"/buy"WHITE"' to buy this property", index, ApartmentRoomData[index][apartmentRoomName], ApartmentRoomData[index][apartmentRoomWorld], FormatNumber(ApartmentRoomData[index][apartmentRoomPrice]));
			else format(string, sizeof(string), ""WHITE"[ID : %d]\n"RED" %s\n"WHITE"Apartment Room "YELLOW"%d\n"WHITE"Owner : %s\nPress '"COL_RED"~k~~GROUP_CONTROL_BWD~"WHITE"' to enter", index, ApartmentRoomData[index][apartmentRoomName], ApartmentRoomData[index][apartmentRoomWorld], ApartmentRoomData[index][apartmentRoomOwnerName]);
			ApartmentRoomData[index][apartmentRoomText] = CreateDynamic3DTextLabel(string, X11_TURQUOISE_1, x_ext, y_ext, z_ext, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vw_ext, int_ext);
		}

		if(IsValidDynamicPickup(ApartmentRoomData[index][apartmentRoomPickup]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentRoomData[index][apartmentRoomPickup], E_STREAMER_X, x_ext);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentRoomData[index][apartmentRoomPickup], E_STREAMER_Y, y_ext);
			Streamer_SetFloatData(STREAMER_TYPE_PICKUP, ApartmentRoomData[index][apartmentRoomPickup], E_STREAMER_Z, z_ext);

			Streamer_SetIntData(STREAMER_TYPE_PICKUP, ApartmentRoomData[index][apartmentRoomPickup], E_STREAMER_INTERIOR_ID, int_ext);
			Streamer_SetIntData(STREAMER_TYPE_PICKUP, ApartmentRoomData[index][apartmentRoomPickup], E_STREAMER_WORLD_ID, vw_ext);
		}
		else
		{			
			ApartmentRoomData[index][apartmentRoomPickup] = CreateDynamicPickup(1273, 23, x_ext, y_ext, z_ext, vw_ext, int_ext, -1, 10);
		}
	}
	return 1;
}

ApartmentRoom_Save(index)
{
	if(ApartmentRoom_IsExists(index))
	{
		new query[4098];
		format(query, sizeof(query), "UPDATE apartment_room SET apartmentRoomOwner='%d', apartmentRoomOwnerName='%s', apartmentRoomName='%s', apartmentID='%d', apartmentRoomPrice='%d', apartmentRoomLock='%d'", 
			ApartmentRoomData[index][apartmentRoomOwner],
			SQL_ReturnEscaped(ApartmentRoomData[index][apartmentRoomOwnerName]),
			SQL_ReturnEscaped(ApartmentRoomData[index][apartmentRoomName]),
			ApartmentRoomData[index][apartmentID],
			ApartmentRoomData[index][apartmentRoomPrice],
			ApartmentRoomData[index][apartmentRoomLock]
		);
		format(query, sizeof(query), "%s, apartmentRoomInterior='%d', apartmentRoomWorld='%d', apartmentExteriorRoomPosX='%.2f', apartmentExteriorRoomPosY='%.2f', apartmentExteriorRoomPosZ='%.2f', apartmentExteriorRoomPosA='%.2f'",
			query, 
			ApartmentRoomData[index][apartmentRoomInterior],
			ApartmentRoomData[index][apartmentRoomWorld],
			ApartmentRoomData[index][apartmentRoomExteriorPosX],
			ApartmentRoomData[index][apartmentRoomExteriorPosY],
			ApartmentRoomData[index][apartmentRoomExteriorPosZ],
			ApartmentRoomData[index][apartmentRoomExteriorPosA]
		);
		format(query, sizeof(query), "%s, apartmentInteriorRoomPosX='%.2f', apartmentInteriorRoomPosY='%.2f', apartmentInteriorRoomPosZ='%.2f', apartmentInteriorRoomPosA='%.2f' WHERE apartmentRoomID = '%d'",
			query, 
			ApartmentRoomData[index][apartmentRoomInteriorPosX],
			ApartmentRoomData[index][apartmentRoomInteriorPosY],
			ApartmentRoomData[index][apartmentRoomInteriorPosZ],
			ApartmentRoomData[index][apartmentRoomInteriorPosA],
			ApartmentRoomData[index][apartmentRoomID]
		);
		return mysql_tquery(g_iHandle, query);
	}
	return 0;
}

ApartmentRoom_Nearest(playerid)
{
	foreach(new roomid : ApartmentRoom)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, ApartmentRoomData[roomid][apartmentRoomExteriorPosX], ApartmentRoomData[roomid][apartmentRoomExteriorPosY], ApartmentRoomData[roomid][apartmentRoomExteriorPosZ]))
		{
			if(GetPlayerInterior(playerid) == ApartmentRoomData[roomid][apartmentRoomInterior] && GetPlayerVirtualWorld(playerid) == ApartmentRoomData[roomid][apartmentRoomWorld])
				return roomid;
		}
	}
	return -1;
}

ApartmentRoom_Inside(playerid)
{
	foreach(new i : ApartmentRoom)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, ApartmentRoomData[i][apartmentRoomInteriorPosX], ApartmentRoomData[i][apartmentRoomInteriorPosY], ApartmentRoomData[i][apartmentRoomInteriorPosZ]))
		{
			if(GetPlayerInterior(playerid) == ApartmentRoomData[i][apartmentRoomInterior] && GetPlayerVirtualWorld(playerid) == ApartmentRoomData[i][apartmentRoomWorld])
				return i;
		}
		else if(PlayerData[playerid][pApartment] != -1)
        {
            if(i == PlayerData[playerid][pApartment] && GetPlayerInterior(playerid) == ApartmentRoomData[i][apartmentRoomInterior] && GetPlayerVirtualWorld(playerid) == ApartmentRoomData[i][apartmentRoomWorld])
                return i;
        }
	}
    return -1;
}

Apartment_RoomCount(apartmentid)
{
	new count = 0;
	foreach(new i : ApartmentRoom) if(ApartmentRoomData[i][apartmentID] == ApartmentData[apartmentid][apartmentID])
	{
		count++;
	}
	return count;
}

Apartment_SetPlayerInsideRoom(playerid, roomid)
{
	if(ApartmentRoom_IsExists(roomid))
	{
		SetPlayerPosEx(playerid, ApartmentRoomData[roomid][apartmentRoomInteriorPosX],ApartmentRoomData[roomid][apartmentRoomInteriorPosY],ApartmentRoomData[roomid][apartmentRoomInteriorPosZ], 3000);
		SetPlayerFacingAngle(playerid, ApartmentRoomData[roomid][apartmentRoomInteriorPosA]);
		SetCameraBehindPlayer(playerid);
		PlayerData[playerid][pApartment] = roomid;
		return 1;
	}
	return -1;
}

Apartment_SetPlayerOutsideRoom(playerid, roomid)
{
	if(ApartmentRoom_IsExists(roomid))
	{
		if(ChargePhone[playerid] >= 1)
		{
			ChargePhone[playerid] = 0;
			SendClientMessage(playerid, COLOR_WHITE, "You "RED"stop "WHITE"charging your battery as you get out from the vehicle");
			SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s removes charge from his phone and stop charging their phone.", ReturnName(playerid, 0));
		}
		SetPlayerPosEx(playerid, ApartmentRoomData[roomid][apartmentRoomExteriorPosX],ApartmentRoomData[roomid][apartmentRoomExteriorPosY],ApartmentRoomData[roomid][apartmentRoomExteriorPosZ], 3000);
		SetPlayerFacingAngle(playerid, ApartmentRoomData[roomid][apartmentRoomExteriorPosA]);
		SetCameraBehindPlayer(playerid);
		PlayerData[playerid][pApartment] = -1;
		return 1;
	}
	return -1;
}

Apartment_SetPlayerInside(playerid, apartmentid, roomid)
{
	if(ApartmentRoom_IsExists(roomid) && Apartment_IsExists(apartmentid))
	{
		Player_ToggleTelportAntiCheat(playerid, false);
		SetPlayerPosEx(playerid, ApartmentData[apartmentid][apartmentInteriorPosX],ApartmentData[apartmentid][apartmentInteriorPosY],ApartmentData[apartmentid][apartmentInteriorPosZ], 3000);
		SetPlayerFacingAngle(playerid, ApartmentData[apartmentid][apartmentInteriorPosA]);
		SetPlayerVirtualWorld(playerid, ApartmentRoomData[roomid][apartmentRoomWorld]);
		SetPlayerInterior(playerid, ApartmentRoomData[roomid][apartmentRoomInterior]);
		SetCameraBehindPlayer(playerid);
		PlayerData[playerid][pApartmentBuilding] = ApartmentData[apartmentid][apartmentID];
		return 1;
	}
	return -1;
}

Apartment_SetPlayerOutside(playerid, apartmentid)
{
	if(Apartment_IsExists(apartmentid))
	{
		SetPlayerPosEx(playerid, ApartmentData[apartmentid][apartmentExteriorPosX],ApartmentData[apartmentid][apartmentExteriorPosY],ApartmentData[apartmentid][apartmentExteriorPosZ]);
		SetPlayerFacingAngle(playerid, ApartmentData[apartmentid][apartmentExteriorPosA]);
		SetPlayerVirtualWorld(playerid, ApartmentData[apartmentid][apartmentExteriorWorld]);
		SetPlayerInterior(playerid, ApartmentData[apartmentid][apartmentExteriorInt]);
		SetCameraBehindPlayer(playerid);
		PlayerData[playerid][pApartmentBuilding] = -1;
		return 1;
	}
	return -1;
}

ApartmentRoom_IsOwned(playerid, index)
{
	if(ApartmentRoom_IsExists(index) && ApartmentRoomData[index][apartmentRoomOwner] == GetPlayerSQLID(playerid))
	{
		return 1;	
	}
	return 0;
}

ApartmentRoom_GetCount(playerid)
{
	new count = 0;
    foreach(new i : ApartmentRoom) 
	{
		if(ApartmentRoom_IsOwned(playerid, i))
		{
			count++;
		}
	}
    return count;
}