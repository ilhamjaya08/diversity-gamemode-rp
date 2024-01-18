#include <YSI\y_hooks>

new Vehicle_RadarObjectID[MAX_DYNAMIC_VEHICLES];
new bool:Player_RadarToggle[MAX_PLAYERS];
new bool:Vehicle_RadarToggle[MAX_DYNAMIC_VEHICLES];
new Timer:Vehicle_CheckingSpeed[MAX_DYNAMIC_VEHICLES];
new Player_OldVehicleID[MAX_PLAYERS];

CMD:speedradar(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid) && GetFactionType(playerid) == FACTION_POLICE)
	{
		new vehicleid = GetPlayerVehicleID(playerid),
			Float: x, Float: y, Float: z, Float: a;

		if(Vehicle_GetExtraID(vehicleid) != GetPlayerFactionID(playerid))
			return SendErrorMessage(playerid, "This is not your faction vehicle!");

		if(!IsFourWheelVehicle(vehicleid))
			return SendErrorMessage(playerid, "You need to be inside a car to use speed radar!");

		if(!Vehicle_RadarToggle[vehicleid]) 
		{
			Vehicle_RadarToggle[vehicleid] = true;
			Player_RadarToggle[playerid] = true;
			
			GetVehiclePos (vehicleid, x, y, z);
			GetVehicleZAngle (vehicleid, a);
			SendServerMessage(playerid, "Vehicle speed-radar has been turned on.");
			Vehicle_CheckingSpeed[vehicleid] = repeat Vehicle_CheckSpeed(vehicleid);
		
			if(!IsValidDynamicObject(Vehicle_RadarObjectID[vehicleid]))
			{
				Vehicle_RadarObjectID[vehicleid] = CreateDynamicObject (367, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle (Vehicle_RadarObjectID[vehicleid], vehicleid, 0.2, 0.50, 0.3, 0.0, 0.0, 90.0);
			}
			foreach(new i : Player) if (IsPlayerInVehicle (i, vehicleid))
			{
				EnableSpeedRadar(i);
			}
		}
		else
		{
			if(IsValidDynamicObject(Vehicle_RadarObjectID[vehicleid]))
				DestroyDynamicObject(Vehicle_RadarObjectID[vehicleid]);
			
			Vehicle_RadarObjectID[vehicleid] = INVALID_STREAMER_ID;
			Vehicle_RadarToggle[vehicleid] = false;
			Player_RadarToggle[playerid] = false;
			stop Vehicle_CheckingSpeed[vehicleid];

			SendServerMessage(playerid, "Vehicle speed-radar has been turned off.");
			foreach(new i : Player) if (IsPlayerInVehicle (i, vehicleid))
			{
				DisableSpeedRadar(i);
			}
			
		}
	}
	else SendErrorMessage(playerid, "You are not a police officer that inside a vehicle!");
	return 1;
}

Vehicle_GetFrontID(vehid)
{
    new Float: temp = 7.0;
	new j = 0;
	foreach(new i : Vehicle)
	{
	    new Float: a, Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2;
    	GetVehiclePos (vehid, x1, y1, z1);
    	GetVehicleZAngle (vehid, a);
 		if (i != vehid)
 		{
	 		if (GetVehiclePos (i, x2, y2, z2))
			{
				new Float: distance = floatsqroot (floatpower ((x1 - x2), 2) + floatpower ((y1 - y2), 2) + floatpower ((z1 - z2), 2));
				GetVehicleZAngle (vehid, a);
				
				if (distance < 300.0)
				{
    				x1 = x1 + (distance * floatsin(-a, degrees));
					y1 = y1 + (distance * floatcos(-a, degrees));

					distance = floatsqroot ((floatpower ((x1 - x2), 2)) + (floatpower ((y1 - y2), 2)));

					if (temp > distance)
					{
						temp = distance;
						j = i;
					}
				}
			}
		}
	}
	if (temp < 7.0) return j;
	return -1;
}

timer Vehicle_CheckSpeed[1000](vehicleid)
{
	if(Vehicle_RadarToggle[vehicleid])
	{
		new vehid = Vehicle_GetFrontID(vehicleid);
		if (vehid == -1)
		{
			foreach(new i : Player) if(IsPlayerInVehicle (i, vehicleid))
			{
				PlayerTextDrawSetString(i, ModelTD[i], "N/A");
				PlayerTextDrawSetString(i, SpeedTD[i], "N/A");
				PlayerTextDrawSetString(i, PlateTD[i], "N/A");
			}
		}
		else
		{
			foreach(new i : Player) if(IsPlayerInVehicle (i, vehicleid))
			{
				new speed = floatround(GetVehicleSpeed(vehid));
				PlayerTextDrawSetString(i, ModelTD[i], sprintf("%s", GetVehicleNameByVehicle(vehid)));
				PlayerTextDrawSetString(i, SpeedTD[i], sprintf("%d KMH", speed));
				PlayerTextDrawSetString(i, PlateTD[i], sprintf("%s", VehicleData[vehid][vehPlate]));
			}
		}
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if((oldstate == PLAYER_STATE_ONFOOT) && (newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_DRIVER))
	{
	    Player_OldVehicleID[playerid] = GetPlayerVehicleID(playerid);
		new vehicleid = Player_OldVehicleID[playerid];
		if(vehicleid != -1)
		{
			if(Vehicle_RadarToggle[vehicleid])
			{
				EnableSpeedRadar(playerid);
			}
		}
	}

	if((oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) && (newstate == PLAYER_STATE_ONFOOT))
	{
	    new vehicleid = Player_OldVehicleID[playerid];
		if(vehicleid != -1)
		{
			if(Vehicle_RadarToggle[vehicleid])
			{
				DisableSpeedRadar(playerid);
			}
		}
	}
}

hook OnVehicleDeath(vehicleid)
{
	if(IsValidDynamicObject(Vehicle_RadarObjectID[vehicleid]))
	{
		DestroyDynamicObject(Vehicle_RadarObjectID[vehicleid]);
		Vehicle_RadarObjectID[vehicleid] = INVALID_STREAMER_ID;
	}
	if(Vehicle_RadarToggle[vehicleid])
	{
		stop Vehicle_CheckingSpeed[vehicleid];
		Vehicle_RadarToggle[vehicleid] = false;
		foreach(new i : Player)
		{
			if (IsPlayerInVehicle (i, vehicleid))
			{
				DisableSpeedRadar(i);
			}
		}
	}
}