#include <YSI\y_hooks>


// Functions
forward OnSpeedCreated(index);
public OnSpeedCreated(index)
{
	SpeedData[index][speedID] = cache_insert_id();

	Speed_Sync(index);
	Speed_Save(index);
	return 1;
}

forward Speed_Load();
public Speed_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Speed, i);

			format(SpeedData[i][speedDetail], MAX_PLAYER_NAME, "CLEAR");

	        SpeedData[i][speedID] = cache_get_field_int(i, "speedID");
	        SpeedData[i][speedMax] = cache_get_field_int(i, "speedLimit");
	        
	        SpeedData[i][speedPos][0] = cache_get_field_float(i, "speedX");
	        SpeedData[i][speedPos][1] = cache_get_field_float(i, "speedY");
	        SpeedData[i][speedPos][2] = cache_get_field_float(i, "speedZ");
	        SpeedData[i][speedPos][3] = cache_get_field_float(i, "speedAngle");

	        Speed_Sync(i);
		}
		printf("*** Loaded %d speed camera", cache_num_rows());
	}
	return 1;
}


// Events
hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, "SELECT * FROM `speedcameras` ORDER BY `speedID` ASC LIMIT "#MAX_DYNAMIC_SPEED";", "Speed_Load", "");
}

hook OnPlayerConnect(playerid)
{
	SetPlayerToggleSpeedTrap(playerid, 0);
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	new streamer_info[2];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, streamer_info);

    if(streamer_info[0] == SPEED_AREA_INDEX)
    {
        new index = streamer_info[1];

        if(Speed_IsExists(index))
        {
        	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsEngineVehicle(GetPlayerVehicleID(playerid)) && !IsACruiser(GetPlayerVehicleID(playerid)))
        	{
        		if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) > SpeedData[index][speedMax])
        		{
        			new Float:x, Float:y, Float:z;
	                GetPlayerPos(playerid, x, y, z);

	                foreach(new i : Player) if(GetFactionType(i) == FACTION_POLICE && !IsPlayerToggleSpeedTrap(i))
		                SendClientMessageEx(i, COLOR_RADIO, "SPEEDTRAP: Vehicle: %s, Plate: %s{8D8DFF}, Location: %s, Speed: %d of %d KM/H.", GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)), GetVehicleNumberPlate(GetPlayerVehicleID(playerid)), GetLocation(x, y, z), floatround(GetVehicleSpeed(GetPlayerVehicleID(playerid))), SpeedData[index][speedMax]);

					format(SpeedData[index][speedDetail], 128, "V: %s | P: %s"ORANGE" | S: %d km/h", GetVehicleNameByVehicle(GetPlayerVehicleID(playerid)), GetVehicleNumberPlate(GetPlayerVehicleID(playerid)), floatround(GetVehicleSpeed(GetPlayerVehicleID(playerid))));
					Speed_Sync(index, true);

	            	ShowPlayerFooter(playerid, "~g~~h~Speed Camera ~w~merekam kecepatan dan data kendaraan di karenakan...~n~melewati batas ~r~~h~maksimum kecepatan~w~!", 3000, 1);
        		}
        	}
        }
    }
}


// Function
Speed_IsExists(index)
{
	if(Iter_Contains(Speed, index))
		return 1;
	
	return 0;
}

Speed_Create(playerid, speed)
{
	static
		index;

	if((index = Iter_Free(Speed)) != cellmin)
	{
		Iter_Add(Speed, index);

		SpeedData[index][speedMax] = speed;
		format(SpeedData[index][speedDetail], MAX_PLAYER_NAME, "CLEAR");

		GetPlayerPos(playerid, SpeedData[index][speedPos][0], SpeedData[index][speedPos][1], SpeedData[index][speedPos][2]);
		GetPlayerFacingAngle(playerid, SpeedData[index][speedPos][3]);

		new Float:x, Float:y;
		GetXYInFrontOfPlayer(playerid, x, y, 1.5);
		SetPlayerPos(playerid, x, y, SpeedData[index][speedPos][2]);

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `speedcameras` (`speedLimit`) VALUES('%d');", speed), "OnSpeedCreated", "d", index);
		return index;
	}
	return -1;
}

Speed_Delete(index)
{
	if(Speed_IsExists(index))
	{
		Iter_Remove(Speed, index);

		mysql_tquery(g_iHandle, sprintf("DELETE FROM `speedcameras` WHERE `speedID`='%d';", SpeedData[index][speedID]));

		if(IsValidDynamicArea(SpeedData[index][speedArea]))
			DestroyDynamicArea(SpeedData[index][speedArea]);

		if(IsValidDynamicObject(SpeedData[index][speedObject]))
			DestroyDynamicObject(SpeedData[index][speedObject]);

		if(IsValidDynamic3DTextLabel(SpeedData[index][speedLabel]))
			DestroyDynamic3DTextLabel(SpeedData[index][speedLabel]);

		new tmp_SpeedData[E_SPEED_DATA];
		SpeedData[index] = tmp_SpeedData;

		SpeedData[index][speedObject] = INVALID_STREAMER_ID;
		SpeedData[index][speedArea] = INVALID_STREAMER_ID;
		SpeedData[index][speedLabel] = Text3D:INVALID_STREAMER_ID;		
		return 1;
	}
	return 0;
}

Speed_Save(index, bool:save_speed = false)
{
	if(Speed_IsExists(index))
	{
		if(!save_speed)
		{
			mysql_tquery(g_iHandle, sprintf("UPDATE speedcameras SET `speedX`='%.3f',`speedY`='%.3f',`speedZ`='%.3f',`speedAngle`='%.3f' WHERE `speedID`='%d';",
				SpeedData[index][speedPos][0],
				SpeedData[index][speedPos][1],
				SpeedData[index][speedPos][2],
				SpeedData[index][speedPos][3],
				SpeedData[index][speedID]
			));
		}
		else mysql_tquery(g_iHandle, sprintf("UPDATE `speedcameras` SET `speedLimit`='%d' WHERE `speedID`='%d';", SpeedData[index][speedMax], SpeedData[index][speedID]));

		return 1;
	}
	return 0;
}

Speed_Sync(index, bool:label_only = false)
{
	if(Speed_IsExists(index))
	{
		if(!label_only)
		{
			if(IsValidDynamicArea(SpeedData[index][speedArea]))
			{
				Streamer_SetFloatData(STREAMER_TYPE_AREA, SpeedData[index][speedArea], E_STREAMER_X, SpeedData[index][speedPos][0]);
				Streamer_SetFloatData(STREAMER_TYPE_AREA, SpeedData[index][speedArea], E_STREAMER_Y, SpeedData[index][speedPos][1]);
				Streamer_SetFloatData(STREAMER_TYPE_AREA, SpeedData[index][speedArea], E_STREAMER_MIN_Z, SpeedData[index][speedPos][2] - 1.0);
				Streamer_SetFloatData(STREAMER_TYPE_AREA, SpeedData[index][speedArea], E_STREAMER_MAX_Z, SpeedData[index][speedPos][2] + 3.0);
			}
			else
			{
				SpeedData[index][speedArea] = CreateDynamicCylinder(SpeedData[index][speedPos][0], SpeedData[index][speedPos][1], SpeedData[index][speedPos][2] - 1.0, SpeedData[index][speedPos][2] + 3.0, 20, 0, 0);

				new streamer_info[2];

				streamer_info[0] = SPEED_AREA_INDEX;
				streamer_info[1] = index;
				Streamer_SetArrayData(STREAMER_TYPE_AREA, SpeedData[index][speedArea], E_STREAMER_EXTRA_ID, streamer_info);
			}

			if(IsValidDynamicObject(SpeedData[index][speedObject]))
			{
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, SpeedData[index][speedObject], E_STREAMER_X, SpeedData[index][speedPos][0]);
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, SpeedData[index][speedObject], E_STREAMER_Y, SpeedData[index][speedPos][1]);
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, SpeedData[index][speedObject], E_STREAMER_Z, SpeedData[index][speedPos][2] - 2.0);
				Streamer_SetFloatData(STREAMER_TYPE_OBJECT, SpeedData[index][speedObject], E_STREAMER_R_Z, SpeedData[index][speedPos][3]);
			}
			else SpeedData[index][speedObject] = CreateDynamicObject(18880, SpeedData[index][speedPos][0], SpeedData[index][speedPos][1], SpeedData[index][speedPos][2] - 2.0, 0.0, 0.0, SpeedData[index][speedPos][3], 0, 0, -1, 100.0, 100.0);
		}

		new display[180];
		format(display, sizeof(display), "[Speed Camera, %d]"WHITE"\nSpeed Limit: "RED"%d km/h\n"WHITE"["ORANGE"%s"WHITE"]", index, SpeedData[index][speedMax], SpeedData[index][speedDetail]);

		if(IsValidDynamic3DTextLabel(SpeedData[index][speedLabel]))
		{
			UpdateDynamic3DTextLabelText(SpeedData[index][speedLabel], COLOR_CLIENT, display);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, SpeedData[index][speedLabel], E_STREAMER_X, SpeedData[index][speedPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, SpeedData[index][speedLabel], E_STREAMER_Y, SpeedData[index][speedPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, SpeedData[index][speedLabel], E_STREAMER_Z, SpeedData[index][speedPos][2] + 2.0);
		}
		else SpeedData[index][speedLabel] = CreateDynamic3DTextLabel(display, COLOR_CLIENT, SpeedData[index][speedPos][0], SpeedData[index][speedPos][1], SpeedData[index][speedPos][2] + 2.0, 15, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	}
	return 1;
}

Speed_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Speed) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, SpeedData[i][speedPos][0], SpeedData[i][speedPos][1], SpeedData[i][speedPos][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}