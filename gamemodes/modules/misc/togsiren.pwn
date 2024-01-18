#include <YSI\y_hooks>

new 
	gELMTimer[MAX_VEHICLES],
	gELMCount[MAX_VEHICLES] = {0, ...},
	bool:gToggleELM[MAX_VEHICLES] = {false, ...};

new
	gSirenObject[MAX_VEHICLES] = {INVALID_STREAMER_ID, ...},
	bool:gToggleSiren[MAX_VEHICLES] = {false, ...};


forward ToggleELM(vehicleid);
public ToggleELM(vehicleid)
{
	if(gToggleELM[vehicleid])
	{
		static panels, doors, lights, tires;
	    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);

	    switch(gELMCount[vehicleid])
	    {
	        case 0: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);
	        case 1: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
	        case 2: UpdateVehicleDamageStatus(vehicleid, panels, doors, 2, tires);
	        case 3: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);
	        case 4: UpdateVehicleDamageStatus(vehicleid, panels, doors, 5, tires);
	        case 5: UpdateVehicleDamageStatus(vehicleid, panels, doors, 4, tires);
	    }

	    if(gELMCount[vehicleid] >= 5) gELMCount[vehicleid] = 0;
	    gELMCount[vehicleid]++;
	}
    return 1;
}

hook OnVehicleDestroyed(vehicleid)
{
	if(gToggleELM[vehicleid])
	{
		gToggleELM[vehicleid] = false;
		KillTimer(gELMTimer[vehicleid]);
	}

	if(gToggleSiren[vehicleid])
	{
		gToggleSiren[vehicleid] = false;

		if(IsValidDynamicObject(gSirenObject[vehicleid]))
			DestroyDynamicObject(gSirenObject[vehicleid]);

		gSirenObject[vehicleid] = INVALID_STREAMER_ID;
	}
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
    if(newstate)
    {

    }
    else
    {

    }
    return 1;
}



SSCANF:VehicleSiren(string[]) 
{
	if(!strcmp(string,"roof",true)) return 1;
	else if(!strcmp(string,"dashboard",true)) return 2;
	else if(!strcmp(string,"mid",true)) return 3;
	else if(!strcmp(string,"off",true)) return 4;
	return 0;
}

CMD:elm(playerid, params[])
{
    new
        vehicle_index,
        vehicleid = GetPlayerVehicleID(playerid)
	;

    if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
        return SendErrorMessage(playerid, "Tidak diizinkan menggunakan perintah ini!.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendErrorMessage(playerid, "Harus diposisi kemudi untuk menggunakan perintah ini!.");

    if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
    {
        if(Vehicle_GetType(vehicle_index) != VEHICLE_TYPE_FACTION)
            return SendErrorMessage(playerid, "Bukan kendaraan faction!");

        if(Vehicle_GetExtraID(vehicle_index) != GetPlayerFactionID(playerid))
            return SendErrorMessage(playerid, "Ini bukan kendaraan factionmu!");
    }

	if(!gToggleELM[vehicleid])
	{
		gToggleELM[vehicleid] = true;
		gELMTimer[vehicleid] = SetTimerEx("ToggleELM", 200, true, "d", vehicleid);
		SendCustomMessage(playerid, "ELM", "Emergency Light Mode status : "GREEN"Enabled");
	}
	else
	{
        static panels, doors, lights, tires;

    	gToggleELM[vehicleid] = false;
		KillTimer(gELMTimer[vehicleid]);

        GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
        UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
		SendCustomMessage(playerid, "ELM", "Emergency Light Mode status : "RED"Disabled");
	}
	return 1;
}

CMD:togsiren(playerid, params[])
{
    new
        vehicle_index,
        vehicleid = GetPlayerVehicleID(playerid),
		action,
		nextParams[128]
	;

    if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
        return SendErrorMessage(playerid, "Tidak diizinkan menggunakan perintah ini!.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendErrorMessage(playerid, "Harus diposisi kemudi untuk menggunakan perintah ini!.");

    if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
    {
        if(Vehicle_GetType(vehicle_index) != VEHICLE_TYPE_FACTION)
            return SendErrorMessage(playerid, "Bukan kendaraan faction!");

        if(Vehicle_GetExtraID(vehicle_index) != GetPlayerFactionID(playerid))
            return SendErrorMessage(playerid, "Ini bukan kendaraan factionmu!");
    }

	if(sscanf(params, "k<VehicleSiren>S()[128]", action, nextParams))
	{
		SendSyntaxMessage(playerid, "/togsiren [entity]");
		SendSyntaxMessage(playerid, "Entity : roof/dashboard/mid/off");
		return 1;
	}	
	switch(action) 
	{
		case 1: // roof
		{
			if(!gToggleSiren[vehicleid])
			{
				static
					Float:fSize[3],
					Float:fSeat[3];

				GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]);
				GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]);

				gSirenObject[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(gSirenObject[vehicleid], vehicleid, -fSeat[0], fSeat[1], fSize[2] / 2.0, 0.0, 0.0, 0.0);
				gToggleSiren[vehicleid] = true;
				SendCustomMessage(playerid, "SIREN", "Portable siren "GREEN"Enabled");
			}
			else SendErrorMessage(playerid, "Turn off siren first!");
		}
		case 2: // dashboard
		{
			if(!gToggleSiren[vehicleid])
			{
				static
					Float:fSize[3],
					Float:fSeat[3];

				GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]);
				GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]);

				gSirenObject[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(gSirenObject[vehicleid], vehicleid, -fSeat[0] / 10.0, fSeat[1] + 0.7, fSize[2] / 4.0, 0.0, 0.0, 0.0);
				gToggleSiren[vehicleid] = true;
				SendCustomMessage(playerid, "SIREN", "Portable siren "GREEN"Enabled");
			}
			else SendErrorMessage(playerid, "Turn off siren first!");
		}
		case 3: // mid
		{
			if(!gToggleSiren[vehicleid])
			{
				static
					Float:fSize[3],
					Float:fSeat[3];

				GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]);
				GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]);

				gSirenObject[vehicleid] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(gSirenObject[vehicleid], vehicleid, -fSeat[0] / 10.0, fSeat[1] / 7.0, fSize[2] / 2.0, 0.0, 0.0, 0.0);
				gToggleSiren[vehicleid] = true;
				SendCustomMessage(playerid, "SIREN", "Portable siren "GREEN"Enabled");
			}
			else SendErrorMessage(playerid, "Turn off siren first!");
		}
		case 4:
		{
			if(IsValidDynamicObject(gSirenObject[vehicleid]))
				DestroyDynamicObject(gSirenObject[vehicleid]);

			gSirenObject[vehicleid] = INVALID_STREAMER_ID;
			gToggleSiren[vehicleid] = false;
			SendCustomMessage(playerid, "SIREN", "Portable siren "RED"Disabled");
		}
	}
    return 1;
}