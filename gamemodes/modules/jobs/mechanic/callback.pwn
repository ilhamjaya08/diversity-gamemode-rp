
#include <YSI\y_hooks>


// ========================[ EVENTS ]========================
hook OnPlayerConnect(playerid)
{
	Mechanic_Reset(playerid, false);
}

hook OnPlayerDisconnect(playerid, reason)
{
	Mechanic_Reset(playerid, false);
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (newstate != PLAYER_STATE_DRIVER && newstate != PLAYER_STATE_PASSENGER)
	{
		return 1;
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	new ownerid = Vehicle_PlayerID(vehicleid);

	if (!IsValidVehicle(vehicleid))
	{
		return 1;
	}

	new
		previewsectionid = VehicleData[vehicleid][vehModSectionPreview],
		previewcomponentid = VehicleData[vehicleid][vehModCompPreview]
	;

	if (previewsectionid < 0 || previewsectionid > MAX_VEHICLE_MOD_SECTIONS)
	{
		return 1;
	}

	if (previewcomponentid < 1000)
	{
		return 1;
	}

	new currentcomponentid = VehicleData[vehicleid][vehMod][previewsectionid];

	RemoveVehicleComponent(vehicleid, previewcomponentid);

	if (currentcomponentid < 1000 || currentcomponentid > MAX_VEHICLE_MOD_ID)
	{
		return 1;
	}

	AddVehicleComponent(vehicleid, currentcomponentid);
	ShowPlayerFooter(ownerid, "Pratinjau (preview) ~y~component ~w~di kendaraan Anda telah dibatalkan.", 3000, 1);

	VehicleData[vehicleid][vehModSectionPreview] = 0;
	VehicleData[vehicleid][vehModCompPreview] = 0;
	return 1;
}

// ========================[ SELECTION RESPONSE ]========================
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_SELECT_WHEELS)
	{
		if(response)
		{
			new vehicleid = GetPVarInt(playerid, "MechanicVehicle");
			SetPVarInt(playerid, "MechanicWheels", strval(inputtext));
			if(!IsModValid(vehicleid, strval(inputtext))) return SendErrorMessage(playerid, "Komponen kendaraan tidak valid, coba komponen yang lain!");
			SetRepairingVehicle(playerid, 1);
			SetRepairType(playerid, REPAIR_WHEELS);

			if(Vehicle_PlayerID(vehicleid) != INVALID_PLAYER_ID)
				SendServerMessage(Vehicle_PlayerID(vehicleid), ""YELLOW"%s "WHITE"menggantikan "LIGHTBLUE"ban "WHITE"kendaraan "CYAN"%s "WHITE"milikmu!.", ReturnName(playerid, 1), GetVehicleNameByVehicle(vehicleid));

			SendServerMessage(playerid, "Mulai mengganti "YELLOW"ban "WHITE"kendaraan "CYAN"%s.", GetVehicleNameByVehicle(vehicleid));
		}
	}
	else if (dialogid == DIALOG_MOD_SELECT_WHEELS)
	{
		dialog_MechTune_ChooseComponent(playerid, response, listitem, inputtext);
	}
	return 1;
}