#include <YSI\y_hooks>


// Events
hook OnPlayerEnterDynArea(playerid, areaid)
{
	new streamer_info[2];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, streamer_info);

    if(streamer_info[0] == BARRICADE_AREA_INDEX)
    {
        new index = streamer_info[1];

        if(Barricade_IsExists(index) && BarricadeData[index][cadeType] == 1)
        {
        	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsABicycle(GetPlayerVehicleID(playerid)))
        	{
	        	static tires[4];
	            GetVehicleDamageStatus(GetPlayerVehicleID(playerid), tires[0], tires[1], tires[2], tires[3]);

	            if(tires[3] != 1111)
	            {
	            	ShowPlayerFooter(playerid, "Ban bocor akibat jebakan ~r~~h~paku!", 3000, 1);
	                UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), tires[0], tires[1], tires[2], 1111);
	            }
        	}
        }
    }
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_BARRICADE)
	{
		if(response)
		{
			static
				Float:fX,Float:fY,Float:fZ;
			
			new index;
			if((index = Barricade_Create(playerid, 2, strval(inputtext), "-")) != -1) 
			{
				SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "RADIO: %s has dropped a roadblock at %s. (( ID %d ))", ReturnName(playerid, 0), GetLocation(fX, fY, fZ), index);
				PlayerData[playerid][pEditingMode] = ROADBLOCK;
				PlayerData[playerid][pEditRoadblock] = index;
				EditDynamicObject(playerid, BarricadeData[index][cadeObject]);
			}
			else 
			{
				SendErrorMessage(playerid, "Roadblock sudah mencapai batas maksimal ("#MAX_DYNAMIC_ROADBLOCK" roadblock).");
			}
		}
	}
}

// Function
Barricade_IsExists(index)
{
	if(Iter_Contains(Barricade, index))
		return 1;

	return 0;
}

Barricade_Create(playerid, type, model, text[])
{
	static
		index;

	if((index = Iter_Free(Barricade)) != cellmin)
	{
		Iter_Add(Barricade, index);

		BarricadeData[index][cadeType] = type;
		BarricadeData[index][cadeModel] = model;

		FixText(text);    
        format(BarricadeData[index][cadeText], 225, text);

		GetPlayerPos(playerid, BarricadeData[index][cadePos][0], BarricadeData[index][cadePos][1], BarricadeData[index][cadePos][2]);
		BarricadeData[index][cadePos][4] = 0.0;
		BarricadeData[index][cadePos][3] = 0.0;
		GetPlayerFacingAngle(playerid, BarricadeData[index][cadePos][5]);

		new Float:x, Float:y;
		GetXYInFrontOfPlayer(playerid, x, y, 1.5);
		SetPlayerPos(playerid, x, y, BarricadeData[index][cadePos][2]);
		Barricade_Sync(index);
		return index;
	}
	return -1;
}

Barricade_Delete(index, bool:remove_all = false)
{
	if(Barricade_IsExists(index))
	{
		if(!remove_all)
			Iter_Remove(Barricade, index);

		if(IsValidDynamicObject(BarricadeData[index][cadeObject]))
			DestroyDynamicObject(BarricadeData[index][cadeObject]);

		if(IsValidDynamicArea(BarricadeData[index][cadeArea]))
			DestroyDynamicArea(BarricadeData[index][cadeArea]);

		new tmp_BarricadeData[E_BARRICADE_DATA];
		BarricadeData[index] = tmp_BarricadeData;

		BarricadeData[index][cadeObject] = INVALID_STREAMER_ID;
		BarricadeData[index][cadeArea] = INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

Barricade_Sync(index)
{
	if(Barricade_IsExists(index))
	{
		new Float:z_min;

		switch(BarricadeData[index][cadeModel])
		{
			case 981, 978: z_min = 0.2;
			case 1423: z_min = 0.3;
			case 3091, 1459, 983: z_min = 0.5;
			case 1238, 1422, 1425: z_min = 0.7;
			case 19834: z_min = -0.3;
			case 2899: z_min = 0.9;
			default: z_min = 1.0;
		}

		if(IsValidDynamicObject(BarricadeData[index][cadeObject]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_X, BarricadeData[index][cadePos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_Y, BarricadeData[index][cadePos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_Z, BarricadeData[index][cadePos][2]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_R_X, BarricadeData[index][cadePos][3]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_R_Y, BarricadeData[index][cadePos][4]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, BarricadeData[index][cadeObject], E_STREAMER_R_Z, BarricadeData[index][cadePos][5]);
		}
		else
		{
			BarricadeData[index][cadeObject] = CreateDynamicObject(BarricadeData[index][cadeModel], BarricadeData[index][cadePos][0], BarricadeData[index][cadePos][1], BarricadeData[index][cadePos][2] - z_min, BarricadeData[index][cadePos][3], BarricadeData[index][cadePos][4], BarricadeData[index][cadePos][5], 0, 0);
			if(BarricadeData[index][cadeModel] == 981)
            	SetDynamicObjectMaterialText(BarricadeData[index][cadeObject], 2, BarricadeData[index][cadeText], 100, "Arial", 30, 1, -1, 0xFF000000, 1);
		}

		if(IsValidDynamicArea(BarricadeData[index][cadeArea]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_X, BarricadeData[index][cadePos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_Y, BarricadeData[index][cadePos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_MIN_Z, BarricadeData[index][cadePos][2] - 1.0);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_MAX_Z, BarricadeData[index][cadePos][2] + 3.0);
		}
		else
		{
			BarricadeData[index][cadeArea] = CreateDynamicCylinder(BarricadeData[index][cadePos][0], BarricadeData[index][cadePos][1], BarricadeData[index][cadePos][2] - 1.0, BarricadeData[index][cadePos][2] + 3.0, 2.5, 0, 0);

			new streamer_info[2];

			streamer_info[0] = BARRICADE_AREA_INDEX;
			streamer_info[1] = index;
			Streamer_SetArrayData(STREAMER_TYPE_AREA, BarricadeData[index][cadeArea], E_STREAMER_EXTRA_ID, streamer_info);
		}
	}
	return 1;
}

Barricade_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Barricade) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, BarricadeData[i][cadePos][0], BarricadeData[i][cadePos][1], BarricadeData[i][cadePos][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}