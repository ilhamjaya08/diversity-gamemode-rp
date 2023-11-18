#include <YSI\y_hooks>

#define MIN_SPEED_LIMIT 10
#define MAX_SPEED_LIMIT 250

new vehicle_limit[MAX_PLAYERS];


hook OnVehicleUpdate(playerid, vehicleid)
{
	if(!IsVehicleDrivingBackwards(vehicleid) && (MIN_SPEED_LIMIT <= vehicle_limit{playerid} <= MAX_SPEED_LIMIT))
	{
		if(GetVehicleSpeed(vehicleid) > vehicle_limit{playerid}) {
			SetVehicleSpeed(vehicleid, (vehicle_limit{playerid} - 5));
		}
	}
}

hook OnPlayerDisconnect(playerid, reason)
	vehicle_limit{playerid} = 0;

CMD:limitspeed(playerid, params[])
{
	new speed;

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Harus berada dalam kendaraan untuk menggunakan perintah ini.");

    if(sscanf(params, "i", speed)) {
    	if(vehicle_limit{playerid} >= MIN_SPEED_LIMIT) {
    		SendServerMessage(playerid, "Batasan kecepatan kendaraan telah di "RED"nonaktifkan.");
    		vehicle_limit{playerid} = 0;
    	}
    	else SendSyntaxMessage(playerid, "/limitspeed [speed ("#MIN_SPEED_LIMIT"-"#MAX_SPEED_LIMIT")]");

    	return 1;
    }

    if(!(MIN_SPEED_LIMIT <= speed <= MAX_SPEED_LIMIT))
    	return SendErrorMessage(playerid, "Kecepatan dibatasi dengan jarak ("#MIN_SPEED_LIMIT"-"#MAX_SPEED_LIMIT")");

    vehicle_limit{playerid} = speed;
    SendServerMessage(playerid, "Kecepatan kendaraan telah dibatasi menjadi "LIGHTBLUE"%d km/h", speed);
	return 1;
}