/*	Vehicle hand break module */

#include <YSI\y_hooks>


timer Vehicle_HandbrakeUpdate[1000](vehicleid)
{
	if(Vehicle_GetType(vehicleid) == VEHICLE_TYPE_PLAYER || Vehicle_GetType(vehicleid) == VEHICLE_TYPE_RENTAL)
	{
		if(IsFourWheelVehicle(vehicleid) && VehicleData[vehicleid][vehHandBrake])
		{
			if(!IsVehicleInRangeOfPoint(VehicleData[vehicleid][vehVehicleID], 2.0, VehicleData[vehicleid][vehPosX], VehicleData[vehicleid][vehPosY], VehicleData[vehicleid][vehPosZ]))
			{
				SetVehicleZAngle(VehicleData[vehicleid][vehVehicleID], VehicleData[vehicleid][vehPosRZ]);
				SetVehiclePos(VehicleData[vehicleid][vehVehicleID], VehicleData[vehicleid][vehPosX], VehicleData[vehicleid][vehPosY], VehicleData[vehicleid][vehPosZ]);
			}
		}
	}
	return 1;
}

timer Vehicle_LockTireUpdate[1000](vehicleid)
{
	if(Vehicle_GetType(vehicleid) == VEHICLE_TYPE_PLAYER || Vehicle_GetType(vehicleid) == VEHICLE_TYPE_RENTAL)
	{
		if(!IsVehicleInRangeOfPoint(VehicleData[vehicleid][vehVehicleID], 2.0, VehicleData[vehicleid][vehPosX], VehicleData[vehicleid][vehPosY], VehicleData[vehicleid][vehPosZ]))
		{
			if(VehicleData[vehicleid][vehLockTire])
			{
				SetVehicleZAngle(VehicleData[vehicleid][vehVehicleID], VehicleData[vehicleid][vehPosRZ]);
				SetVehiclePos(VehicleData[vehicleid][vehVehicleID], VehicleData[vehicleid][vehPosX], VehicleData[vehicleid][vehPosY], VehicleData[vehicleid][vehPosZ]);
			}
		}
	}
	return 1;
}

Vehicle_StopLockTire(vehicleid)
{
	if(Iter_Contains(Vehicle, vehicleid))
	{
		if(VehicleData[vehicleid][vehLockTire])
		{
			stop VehicleData[vehicleid][vehLockTireTimer];
		}
		return 1;
	}
	return 0;
}
Vehicle_StartLockTire(vehicleid)
{
	if(Iter_Contains(Vehicle, vehicleid))
	{
		VehicleData[vehicleid][vehLockTire] = 1;
		VehicleData[vehicleid][vehLockTireTimer] = repeat Vehicle_LockTireUpdate(vehicleid);
		return 1;
	}
	return 0;
}
Vehicle_StopHandbrake(vehicleid)
{
	if(Iter_Contains(Vehicle, vehicleid))
	{
		if(VehicleData[vehicleid][vehHandBrake])
		{
			stop VehicleData[vehicleid][vehHandbrakeTimer];
		}
		return 1;
	}
	return 0;
}
Vehicle_StartHandbrake(vehicleid)
{
	if(Iter_Contains(Vehicle, vehicleid))
	{
		VehicleData[vehicleid][vehHandBrake] = 1;
		VehicleData[vehicleid][vehHandbrakeTimer] = repeat Vehicle_HandbrakeUpdate(vehicleid);
		return 1;
	}
	return 0;
}
CMD:handbrake(playerid, params[])
{
	static
        id = -1,
		index = -1	
	;

	// if(IsABike(GetPlayerVehicleID(playerid)))
	// 	return SendErrorMessage(playerid, "Tidak bisa digunakan pada kendaraan ini.");

	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 
		return SendErrorMessage(playerid, "Kamu sedang tidak berada dalam kendaraan sebagai driver.");
		
    if((id = Vehicle_Nearest(playerid)) != -1)
    {
		index = Vehicle_ReturnID(id);

		if(index == -1)
			return 0;

		if(IsFourWheelVehicle(id))
		{
			if(Vehicle_IsOwned(playerid, index) || Vehicle_IsSharedToPlayer(playerid, index) || Vehicle_IsRented(playerid, index))
			{
				if(!VehicleData[index][vehHandBrake])
				{
					GetVehiclePos(id, VehicleData[index][vehPosX], VehicleData[index][vehPosY], VehicleData[index][vehPosZ]);
					GetVehicleZAngle(id, VehicleData[index][vehPosRZ]);
					Vehicle_StartHandbrake(index);
					SendServerMessage(playerid, "Rem tangan kendaraan telah "GREEN"diaktifkan");
					Vehicle_Save(index);
				}
				else
				{
					VehicleData[index][vehHandBrake] = 0;
					Vehicle_StopHandbrake(index);
					SendServerMessage(playerid, "Rem tangan kendaraan telah "RED"dinon-aktifkan");
					Vehicle_Save(index);
				}
			}
			else SendErrorMessage(playerid, "Kamu tidak dapat melakukan ini pada kendaraan yang kamu naiki.");
		}
		else SendErrorMessage(playerid, "Kendaraan ini tidak punya rem tangan!");
    }
	return 1;
}

CMD:locktire(playerid, params[])
{
	static
        id = -1,
		index = -1	
	;

    if(GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "You must be a police officer.");

    if(!IsPlayerDuty(playerid))
        return SendErrorMessage(playerid, "You must on duty to lock this vehicle's tire!.");
		
    if((id = Vehicle_Nearest(playerid)) != -1)
    {
		index = Vehicle_ReturnID(id);

		if(index == -1)
			return 0;

		if(!VehicleData[index][vehLockTire])
		{
			GetVehiclePos(id, VehicleData[index][vehPosX], VehicleData[index][vehPosY], VehicleData[index][vehPosZ]);
			GetVehicleZAngle(id, VehicleData[index][vehPosRZ]);

			if(!IsValidDynamic3DTextLabel(VehicleData[index][vehLockTireText]))
				VehicleData[index][vehLockTireText] = CreateDynamic3DTextLabel("** Vehicle Tire locked **", X11_PLUM, VehicleData[index][vehPosX], VehicleData[index][vehPosY], VehicleData[index][vehPosZ], 15, INVALID_PLAYER_ID, VehicleData[index][vehVehicleID], 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			
			Vehicle_StartLockTire(index);
			SendServerMessage(playerid, "Roda kendaraan %s telah di kunci", GetVehicleNameByVehicle(id));
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
			Vehicle_Save(index);
		}
		else
		{
			if(IsValidDynamic3DTextLabel(VehicleData[index][vehLockTireText]))
            	DestroyDynamic3DTextLabel(VehicleData[index][vehLockTireText]);

			VehicleData[index][vehLockTire] = 0;
        	VehicleData[index][vehLockTireText] = Text3D:INVALID_STREAMER_ID;
			Vehicle_StopLockTire(index);
			SendServerMessage(playerid, "Roda kendaraan %s telah di buka", GetVehicleNameByVehicle(id));
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
			Vehicle_Save(index);			
		}
	}
	else SendErrorMessage(playerid, "Tidak ada kendaraan di dekat mu!");
	return 1;
}
