forward UndergroundCreated(index);
public UndergroundCreated(index)
{
	UndergroundData[index][underID] = cache_insert_id();

	Underground_Save(index);
	Underground_Sync(index);
	return 1;
}

forward Underground_Load();
public Underground_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Underground, i);

	        UndergroundData[i][underID] = cache_get_field_int(i, "id");
	        
	        UndergroundData[i][underEnter][0] = cache_get_field_float(i, "enterX");
	        UndergroundData[i][underEnter][1] = cache_get_field_float(i, "enterY");
	        UndergroundData[i][underEnter][2] = cache_get_field_float(i, "enterZ");

	        UndergroundData[i][underExitSpawn][0] = cache_get_field_float(i, "exitX");
	        UndergroundData[i][underExitSpawn][1] = cache_get_field_float(i, "exitY");
	        UndergroundData[i][underExitSpawn][2] = cache_get_field_float(i, "exitZ");
	        UndergroundData[i][underExitSpawn][3] = cache_get_field_float(i, "exitRZ");

	        Underground_Sync(i);
    	}
    	printf("*** Loaded %d basement.", cache_num_rows());
	}
	return 1;
}


Underground_IsExists(index)
{
	if(Iter_Contains(Underground, index))
		return 1;

	return 0;
}

Underground_Create(playerid)
{
	static
		index;

	if((index = Iter_Free(Underground)) != cellmin)
	{
		Iter_Add(Underground, index);

		GetPlayerPos(playerid, UndergroundData[index][underEnter][0], UndergroundData[index][underEnter][1], UndergroundData[index][underEnter][2]);
		mysql_tquery(g_iHandle, "INSERT INTO `underground` (`enterX`) VALUES('0');", "UndergroundCreated", "d", index);
		return index;
	}
	return -1;
}

Underground_Delete(index)
{
	if(Underground_IsExists(index))
	{
		Iter_Remove(Underground, index);

		if(IsValidDynamic3DTextLabel(UndergroundData[index][enterLabel]))
			DestroyDynamic3DTextLabel(UndergroundData[index][enterLabel]);

		if(IsValidDynamicCP(UndergroundData[index][enterCP]))
			DestroyDynamicCP(UndergroundData[index][enterCP]);

		new tmp_UndergroundData[E_UNDERGROUND_DATA];
		UndergroundData[index] = tmp_UndergroundData;

		UndergroundData[index][enterLabel] = Text3D:INVALID_STREAMER_ID;
		UndergroundData[index][enterCP] = INVALID_STREAMER_ID;
	}
	return 1;
}

Underground_Sync(index)
{
	if(Underground_IsExists(index))
	{
		// Label
		if(IsValidDynamic3DTextLabel(UndergroundData[index][enterLabel]))
		{
			UpdateDynamic3DTextLabelText(UndergroundData[index][enterLabel], COLOR_CLIENT, sprintf("[Basement Park, %d]\n"WHITE"Press "RED"'H' "WHITE"to enter", index));

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, UndergroundData[index][enterLabel], E_STREAMER_X, UndergroundData[index][underEnter][0]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, UndergroundData[index][enterLabel], E_STREAMER_Y, UndergroundData[index][underEnter][1]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, UndergroundData[index][enterLabel], E_STREAMER_Z, UndergroundData[index][underEnter][2] + 0.75);
		}
		else UndergroundData[index][enterLabel] = CreateDynamic3DTextLabel(sprintf("[Basement Park, %d]\n"WHITE"Press "RED"'H' "WHITE"to enter", index), COLOR_CLIENT, UndergroundData[index][underEnter][0], UndergroundData[index][underEnter][1], UndergroundData[index][underEnter][2] + 0.75, 5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);

		if(IsValidDynamic3DTextLabel(UndergroundData[index][exitLabel]))
		{
			UpdateDynamic3DTextLabelText(UndergroundData[index][exitLabel], COLOR_CLIENT, sprintf("[Basement Park, %d]\n"WHITE"Press "RED"'H' "WHITE"to exit", index));

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, UndergroundData[index][exitLabel], E_STREAMER_X, -1745.4021);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, UndergroundData[index][exitLabel], E_STREAMER_Y, 987.9285);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, UndergroundData[index][exitLabel], E_STREAMER_Z, 17.6099 + 0.75);

			Streamer_SetIntData(STREAMER_TYPE_OBJECT, UndergroundData[index][exitLabel], E_STREAMER_WORLD_ID, (index + 2));
		}
		else UndergroundData[index][exitLabel] = CreateDynamic3DTextLabel(sprintf("[Basement Park, %d]\n"WHITE"Press "RED"'H' "WHITE"to exit", index), COLOR_CLIENT, -1745.4021,987.9285,17.6099 + 0.75, 5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, (index + 2), 0);

		// Checkpoint
		if(IsValidDynamicCP(UndergroundData[index][enterCP]))	
		{
			Streamer_SetFloatData(STREAMER_TYPE_CP, UndergroundData[index][enterCP], E_STREAMER_X, UndergroundData[index][underEnter][0]);
			Streamer_SetFloatData(STREAMER_TYPE_CP, UndergroundData[index][enterCP], E_STREAMER_Y, UndergroundData[index][underEnter][1]);
			Streamer_SetFloatData(STREAMER_TYPE_CP, UndergroundData[index][enterCP], E_STREAMER_Z, UndergroundData[index][underEnter][2]);
		}
		else UndergroundData[index][enterCP] = CreateDynamicCP(UndergroundData[index][underEnter][0], UndergroundData[index][underEnter][1], UndergroundData[index][underEnter][2], 5, 0, 0, -1, 5);

		if(IsValidDynamicCP(UndergroundData[index][exitCP]))	
		{
			Streamer_SetFloatData(STREAMER_TYPE_CP, UndergroundData[index][exitCP], E_STREAMER_X, -1745.4021);
			Streamer_SetFloatData(STREAMER_TYPE_CP, UndergroundData[index][exitCP], E_STREAMER_Y, 987.9285);
			Streamer_SetFloatData(STREAMER_TYPE_CP, UndergroundData[index][exitCP], E_STREAMER_Z, 17.6099);

			Streamer_SetIntData(STREAMER_TYPE_CP, UndergroundData[index][exitCP], E_STREAMER_WORLD_ID, (index + 2));
		}
		else UndergroundData[index][exitCP] = CreateDynamicCP(-1745.4021,987.9285,17.6099, 5, (index + 2), 0, -1, 5);
	}
	return 1;
}

Underground_Save(index)
{
	new query[255];

	if(Underground_IsExists(index))
	{
		mysql_format(g_iHandle, query, sizeof query, "UPDATE `underground` SET `enterX`='%.4f',`enterY`='%.4f',`enterZ`='%.4f',`exitX`='%.4f',`exitY`='%.4f',`exitZ`='%.4f',`exitRZ`='%.4f' WHERE id=%d", 
			UndergroundData[index][underEnter][0],
			UndergroundData[index][underEnter][1],
			UndergroundData[index][underEnter][2],
			UndergroundData[index][underExitSpawn][0],
			UndergroundData[index][underExitSpawn][1],
			UndergroundData[index][underExitSpawn][2],
			UndergroundData[index][underExitSpawn][3],
			UndergroundData[index][underID]
		);
	}
	return mysql_tquery(g_iHandle, query);
}

Underground_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Underground) 
	{
        GetPlayerDistanceFromPoint(playerid, UndergroundData[i][underEnter][0], UndergroundData[i][underEnter][1], UndergroundData[i][underEnter][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	        break;
	    }
	}
	return id;
}

Underground_NearestExit(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Underground) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, UndergroundData[i][underExitSpawn][0], UndergroundData[i][underExitSpawn][1], UndergroundData[i][underExitSpawn][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	        break;
 

	    }
	}
	return id;
}