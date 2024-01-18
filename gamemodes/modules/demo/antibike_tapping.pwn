forward OnVehicleUpdate(playerid, vehicleid);

new Timer:onvehicle_timer[MAX_PLAYERS] = {Timer:-1, ...};

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER && GetPlayerVehicleID(playerid) != INVALID_VEHICLE_ID)
	{
		static vehicleid;

		vehicleid = GetPlayerVehicleID(playerid);
		onvehicle_timer[playerid] = repeat OnVehicleUpdate(playerid, vehicleid);
	}
	else if(oldstate == PLAYER_STATE_DRIVER) {
		stop onvehicle_timer[playerid];
		onvehicle_timer[playerid] = Timer:-1;
	}
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(onvehicle_timer[playerid] != Timer:-1) {
		stop onvehicle_timer[playerid];
		onvehicle_timer[playerid] = Timer:-1;
	}
}


timer OnVehicleUpdate[100](playerid, vehicleid) 
{
	static keys, updown, leftright;
	GetPlayerKeys(playerid, keys, updown, leftright);

	if(updown && IsABike(vehicleid) && GetVehicleSpeed(vehicleid) > 70) {
		SetVehicleSpeed(vehicleid, GetVehicleSpeed(vehicleid)-10);
	}

	CallLocalFunction("OnVehicleUpdate", "dd", playerid, vehicleid);
}