//Anti-teleport into vehicle by Nexius

new
	VehID[MAX_PLAYERS] = {0, ...},
	EnterVehID[MAX_PLAYERS],
	EnterVehTime[MAX_PLAYERS],
	PutInVehTime[MAX_PLAYERS];

forward OnPlayerTeleportVehicle(playerid, vehicleid);

stock my_PutPlayerInVehicle(playerid, vehicleid, seatid)
{
	if(PutPlayerInVehicle(playerid, vehicleid, seatid))
	{
		VehID[playerid] = vehicleid;
		PutInVehTime[playerid] = GetTickCount() + 800;
		EnterVehTime[playerid] = 0;
		return 1;
	}
	return 0;
}

public OnPlayerSpawn(playerid)
{
	VehID[playerid] = 0;

	#if defined vehtp_OnPlayerSpawn
		return vehtp_OnPlayerSpawn(playerid);
	#else
		return 1;
	#endif
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(EnterVehID[playerid] != vehicleid) EnterVehTime[playerid] = GetTickCount();
	EnterVehID[playerid] = vehicleid;

	#if defined vehtp_OnPlayerEnterVehicle
		return vehtp_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
	#else
		return 1;
	#endif
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == 1) EnterVehID[playerid] = 0;

	#if defined vehtp_OnPlayerStateChange
		return vehtp_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
		return 1;
	#endif
}

public OnPlayerUpdate(playerid)
{
	new
		vehid = GetPlayerVehicleID(playerid),
		gtc = GetTickCount();
	if(vehid && !VehID[playerid] && gtc > PutInVehTime[playerid])
	{
		if(EnterVehID[playerid] != vehid || gtc < EnterVehTime[playerid] + 600)
		{
			CallLocalFunction("OnPlayerTeleportVehicle", "dd", playerid, vehid);
			return 1;
		}
	}
	VehID[playerid] = vehid;

	#if defined vehtp_OnPlayerUpdate
		return vehtp_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}

// callback ALS
#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif

#define OnPlayerSpawn vehtp_OnPlayerSpawn
#if defined vehtp_OnPlayerSpawn
	forward vehtp_OnPlayerSpawn(playerid);
#endif

#if defined _ALS_OnPlayerEnterVehicle
	#undef OnPlayerEnterVehicle
#else
	#define _ALS_OnPlayerEnterVehicle
#endif

#define OnPlayerEnterVehicle vehtp_OnPlayerEnterVehicle
#if defined vehtp_OnPlayerEnterVehicle
	forward vehtp_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
#endif

#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif

#define OnPlayerStateChange vehtp_OnPlayerStateChange
#if defined vehtp_OnPlayerStateChange
	forward vehtp_OnPlayerStateChange(playerid, newstate, oldstate);
#endif

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate vehtp_OnPlayerUpdate
#if defined vehtp_OnPlayerUpdate
	forward vehtp_OnPlayerUpdate(playerid);
#endif

// function ALS

#if defined _ALS_PutPlayerInVehicle
	#undef PutPlayerInVehicle
#else
	#define _ALS_PutPlayerInVehicle
#endif
#define PutPlayerInVehicle my_PutPlayerInVehicle