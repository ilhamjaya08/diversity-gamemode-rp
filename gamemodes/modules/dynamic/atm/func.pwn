#include <YSI\y_hooks>


// Callback
forward OnATMCreated(index);
public OnATMCreated(index)
{
	AtmData[index][atmID] = cache_insert_id();

	ATM_Sync(index);
	ATM_Save(index);
	return 1;
}

forward ATM_Load();
public ATM_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Atms, i);

			AtmData[i][atmID] = cache_get_field_int(i, "atmID");
			AtmData[i][atmInterior] = cache_get_field_int(i, "atmInterior");

            AtmData[i][atmPos][0] = cache_get_field_float(i, "atmX");
            AtmData[i][atmPos][1] = cache_get_field_float(i, "atmY");
            AtmData[i][atmPos][2] = cache_get_field_float(i, "atmZ");
            AtmData[i][atmPos][3] = cache_get_field_float(i, "atmA");
			AtmData[i][atmCapacity] = cache_get_field_int(i, "atmCap");

			ATM_Sync(i);
		}
		printf("*** Loaded %d ATM's", cache_num_rows());
	}
	return 1;
}


// Event
hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, "SELECT * FROM `atm` ORDER BY `atmID` ASC LIMIT "#MAX_DYNAMIC_ATM";", "ATM_Load", "");
}

hook OnPlayerConnect(playerid)
{
	ATM_SetInside(playerid, INVALID_ATM_ID);
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	new streamer_info[2];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, streamer_info);

    if(streamer_info[0] == ATM_AREA_INDEX)
    {
        new index = streamer_info[1];

        if(ATM_IsExists(index)) {
    		//ShowPlayerFooter(playerid, "~g~~h~Automatic Teller Machine~n~~w~Gunakan perintah '~y~/atm~w~' untuk menggunakannya!", 3000, 1);
			GameTextForPlayer(playerid, "~g~~h~ATM Machine~n~~w~use '~r~/atm~w~' to use!", 3000, 4);
        	ATM_SetInside(playerid, index);
        }
    }
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	new streamer_info[1];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, streamer_info);

    if(streamer_info[0] == ATM_AREA_INDEX) {
    	HidePlayerFooter(playerid);
    	ATM_SetInside(playerid, INVALID_PLANT_ID);
    }
}

// Function
ATM_IsExists(index)
{
	if(Iter_Contains(Atms, index))
		return 1;
	
	return 0;
}

ATM_Create(playerid)
{
	static
		index;

	if((index = Iter_Free(Atms)) != cellmin)
	{
		Iter_Add(Atms, index);

		GetPlayerPos(playerid, AtmData[index][atmPos][0], AtmData[index][atmPos][1], AtmData[index][atmPos][2]);
		GetPlayerFacingAngle(playerid, AtmData[index][atmPos][3]);

		AtmData[index][atmInterior] = GetPlayerInterior(playerid);

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `atm`(`atmInterior`) VALUES('%d');", AtmData[index][atmInterior]), "OnATMCreated", "d", index);
		return index;
	}
	return -1;
}

ATM_Delete(index)
{
	if(ATM_IsExists(index))
	{
		Iter_Remove(Atms, index);

		mysql_tquery(g_iHandle, sprintf("DELETE FROM `atm` WHERE `atmID`='%d';", AtmData[index][atmID]));

		if(IsValidDynamicArea(AtmData[index][atmArea]))
			DestroyDynamicArea(AtmData[index][atmArea]);

		if(IsValidDynamicObject(AtmData[index][atmObject]))
			DestroyDynamicObject(AtmData[index][atmObject]);

		new tmp_AtmData[E_ATM_DATA];
		AtmData[index] = tmp_AtmData;

		AtmData[index][atmArea] = INVALID_STREAMER_ID;
		AtmData[index][atmObject] = INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

ATM_Sync(index)
{
	if(ATM_IsExists(index))
	{
		if(IsValidDynamicObject(AtmData[index][atmObject]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, AtmData[index][atmObject], E_STREAMER_X, AtmData[index][atmPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, AtmData[index][atmObject], E_STREAMER_Y, AtmData[index][atmPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, AtmData[index][atmObject], E_STREAMER_Z, AtmData[index][atmPos][2] - 0.4);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, AtmData[index][atmObject], E_STREAMER_R_Z, AtmData[index][atmPos][3] - 180);

			Streamer_SetIntData(STREAMER_TYPE_OBJECT, AtmData[index][atmObject], E_STREAMER_INTERIOR_ID, AtmData[index][atmInterior]);
		}
		else AtmData[index][atmObject] = CreateDynamicObject(2942, AtmData[index][atmPos][0], AtmData[index][atmPos][1], AtmData[index][atmPos][2] - 0.4, 0.0, 0.0, (AtmData[index][atmPos][3] - 180), -1, AtmData[index][atmInterior], -1, 20);

		if(IsValidDynamicArea(AtmData[index][atmArea]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_AREA, AtmData[index][atmArea], E_STREAMER_X, AtmData[index][atmPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, AtmData[index][atmArea], E_STREAMER_Y, AtmData[index][atmPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, AtmData[index][atmArea], E_STREAMER_MIN_Z, AtmData[index][atmPos][2] - 1.0);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, AtmData[index][atmArea], E_STREAMER_MAX_Z, AtmData[index][atmPos][2] + 3.0);

			Streamer_SetIntData(STREAMER_TYPE_AREA, AtmData[index][atmArea], E_STREAMER_INTERIOR_ID, AtmData[index][atmInterior]);
		}
		else
		{			
			AtmData[index][atmArea] = CreateDynamicCylinder(AtmData[index][atmPos][0], AtmData[index][atmPos][1], AtmData[index][atmPos][2] - 1.0, AtmData[index][atmPos][2] + 3.0, 1.0, -1, AtmData[index][atmInterior]);

			new streamer_info[2];

			streamer_info[0] = ATM_AREA_INDEX;
			streamer_info[1] = index;
			Streamer_SetArrayData(STREAMER_TYPE_AREA, AtmData[index][atmArea], E_STREAMER_EXTRA_ID, streamer_info);
		}
	}
	return 1;
}

ATM_Save(index)
{
	if(ATM_IsExists(index))
	{
		mysql_tquery(g_iHandle, sprintf("UPDATE atm SET atmX='%.3f',atmY='%.3f',atmZ='%.3f',atmA='%.3f',atmInterior='%d',atmCap='%d' WHERE atmID='%d';", 
			AtmData[index][atmPos][0],
			AtmData[index][atmPos][1],
			AtmData[index][atmPos][2],
			AtmData[index][atmPos][3],
			AtmData[index][atmInterior],
			AtmData[index][atmCapacity],
			AtmData[index][atmID]
		));
		return 1;
	}
	return 0;
}

ATM_Nearest(playerid)
{
	foreach(new i : Atms) if(IsPlayerInRangeOfPoint(playerid, 3.0, AtmData[i][atmPos][0], AtmData[i][atmPos][1], AtmData[i][atmPos][2]))
	{
		if(GetPlayerInterior(playerid) == AtmData[i][atmInterior])
			return i;
	}
	return -1;
}