Plant_IsExists(index)
{
	if(Iter_Contains(Plants, index))
		return 1;

	return 0;
}

Plant_Create(playerid, type)
{
	static index;

	if((index = Iter_Free(Plants)) != cellmin)
	{
		Iter_Add(Plants, index);

		GetPlayerPos(playerid, PlantData[index][plantPos][0], PlantData[index][plantPos][1], PlantData[index][plantPos][2]);
		GetPlayerFacingAngle(playerid, PlantData[index][plantPos][3]);

		PlantData[index][plantType] = type;
		PlantData[index][plantTime] = PLANT_HARVEST_TIME;
		PlantData[index][plantHarvest] = INVALID_PLANT_ID;

		new query[400];
		mysql_format(g_iHandle, query, sizeof(query), "INSERT INTO `plants` (`plantType`,`plantTime`,`plantX`,`plantY`,`plantZ`,`plantA`) VALUES('%d','"#PLANT_HARVEST_TIME"','%.3f','%.3f','%.3f','%.3f');", type, PlantData[index][plantPos][0], PlantData[index][plantPos][1], PlantData[index][plantPos][2], PlantData[index][plantPos][3]);
		mysql_tquery(g_iHandle, query, "OnPlantCreated", "d", index);
		return index;
	}
	return -1;
}

Plant_Delete(index, bool:loop = false)
{
	if(Plant_IsExists(index))
	{
		if(!loop) Iter_Remove(Plants, index);

		mysql_tquery(g_iHandle, sprintf("DELETE FROM `plants` WHERE `plantID`='%d';", PlantData[index][plantID]));

		if(IsValidDynamicObject(PlantData[index][plantObject]))
			DestroyDynamicObject(PlantData[index][plantObject]);

		if(IsValidDynamicArea(PlantData[index][plantArea]))
			DestroyDynamicArea(PlantData[index][plantArea]);
		
		new tmp_PlantData[E_PLANT_DATA];
		PlantData[index] = tmp_PlantData;

		PlantData[index][plantArea] = INVALID_STREAMER_ID;
		PlantData[index][plantObject] = INVALID_STREAMER_ID;
	}
	return 1;
}

Plant_Save(index)
{
	if(Plant_IsExists(index))
	{
		mysql_tquery(g_iHandle, sprintf("UPDATE `plants` SET `plantTime`='%d' WHERE `plantID`='%d';", PlantData[index][plantTime], PlantData[index][plantID]));
	}
	return 1;
}

Plant_Sync(index)
{
	if(Plant_IsExists(index))
	{
		if(IsValidDynamicObject(PlantData[index][plantObject]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, PlantData[index][plantObject], E_STREAMER_X, PlantData[index][plantPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, PlantData[index][plantObject], E_STREAMER_Y, PlantData[index][plantPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, PlantData[index][plantObject], E_STREAMER_Z, PlantData[index][plantPos][2] - 1.80);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, PlantData[index][plantObject], E_STREAMER_R_Z, PlantData[index][plantPos][3]);
		}
		else
		{
			new type;

			switch(Plant_GetType(index))
			{
				case e_PLANT_WEED: type = 0xFF006600;
				case e_PLANT_COCAINE: type = 0xFFAAFFAA;
				case e_PLANT_HEROIN: type = 0xFF80756B;
				default: type = 0xFFFFFFFF;
			}

			PlantData[index][plantObject] = CreateDynamicObject(19473, PlantData[index][plantPos][0], PlantData[index][plantPos][1], PlantData[index][plantPos][2] - 1.80, 0.0, 0.0, PlantData[index][plantPos][3], 0, 0, -1, 100, 100);
			SetDynamicObjectMaterial(PlantData[index][plantObject], 0, -1, "none", "none", type);
		}

		if(IsValidDynamicArea(PlantData[index][plantArea]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_AREA, PlantData[index][plantArea], E_STREAMER_X, PlantData[index][plantPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, PlantData[index][plantArea], E_STREAMER_Y, PlantData[index][plantPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, PlantData[index][plantArea], E_STREAMER_MIN_Z, PlantData[index][plantPos][2] - 1.0);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, PlantData[index][plantArea], E_STREAMER_MAX_Z, PlantData[index][plantPos][2] + 3.0);
		}
		else
		{
			PlantData[index][plantArea] = CreateDynamicCylinder(PlantData[index][plantPos][0], PlantData[index][plantPos][1], PlantData[index][plantPos][2] - 1.0, PlantData[index][plantPos][2] + 3.0, 1.5, 0, 0);

			new streamer_info[2];

			streamer_info[0] = PLANT_AREA_INDEX;
			streamer_info[1] = index;
			Streamer_SetArrayData(STREAMER_TYPE_AREA, PlantData[index][plantArea], E_STREAMER_EXTRA_ID, streamer_info);
		}
	}
	return 1;
}

Plant_GetTime(index)
{
	if(Plant_IsExists(index))
		return PlantData[index][plantTime];

	return 0;
}

Plant_SetTime(index, time)
{
	if(Plant_IsExists(index))
		return PlantData[index][plantTime] = time;

	return 0;
}

Plant_GetType(index)
{
	if(Plant_IsExists(index))
		return PlantData[index][plantType];

	return e_PLANT_NONE;
}

Plant_GetName(index)
{
	new name[10];

	if(Plant_IsExists(index))
	{
		switch(Plant_GetType(index))
		{
			case e_PLANT_WEED: name = "WEED";
			case e_PLANT_COCAINE: name = "COCAINE";
			case e_PLANT_HEROIN: name = "HEROIN";
			default: name = "NONE";
		}
	}

	return name;
}

Plant_GetExpired(index)
{
	if(Plant_IsExists(index))
		return PlantData[index][plantExpired];

	return 0;
}

Plant_SetExpired(index, time)
{
	if(Plant_IsExists(index))
		return PlantData[index][plantExpired] = time;

	return 0;
}

Plant_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Plants) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, PlantData[i][plantPos][0], PlantData[i][plantPos][1], PlantData[i][plantPos][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}

Plant_ResetPlayer(playerid)
{
    SetPlayerHarvestingTime(playerid, 0);
    SetPlayerHarvestingPlant(playerid, false);
    SetPlayerHarvestingType(playerid, e_PLANT_NONE);

	SetPlayerNearestPlant(playerid, INVALID_PLANT_ID);
    return 1;
}