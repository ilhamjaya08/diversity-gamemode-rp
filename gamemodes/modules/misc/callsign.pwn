// Variables

#define IsCallsignActive(%0)			gVehicleCallsign[%0]
#define ReturnCallsignLabelID(%0)		gVehicleCallsignLabel[%0]

new
	gVehicleCallsignText[MAX_VEHICLES][64],
	bool:gVehicleCallsign[MAX_VEHICLES] = {false, ...},
	Text3D:gVehicleCallsignLabel[MAX_VEHICLES] = {Text3D:INVALID_STREAMER_ID, ...};


// Events
public OnVehicleDestroyed(vehicleid)
{
	Callsign_Remove(vehicleid);
	return 1;
}


// Functions
Callsign_Remove(vehicleid)
{
	if(IsCallsignActive(vehicleid))
	{
		if(IsValidDynamic3DTextLabel(gVehicleCallsignLabel[vehicleid]))
			DestroyDynamic3DTextLabel(gVehicleCallsignLabel[vehicleid]);

		gVehicleCallsign[vehicleid] = false;
		gVehicleCallsignText[vehicleid][0] = EOS;
		gVehicleCallsignLabel[vehicleid] = Text3D:INVALID_STREAMER_ID;
	}
	return 1;
}

Callsign_Create(vehicleid, const text[])
{
	if(IsCallsignActive(vehicleid))
	{
		format(gVehicleCallsignText[vehicleid], 64, text);

		if(IsValidDynamic3DTextLabel(gVehicleCallsignLabel[vehicleid])) UpdateDynamic3DTextLabelText(gVehicleCallsignLabel[vehicleid], -1, text);
		else gVehicleCallsignLabel[vehicleid] = CreateDynamic3DTextLabel(text, -1, -0.7, -1.9, -0.3, 10, INVALID_PLAYER_ID, vehicleid, 1);
	}
	return 1;
}

Dialog:CallSignInput(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
			vehicle_index,
			vehicleid = GetPlayerVehicleID(playerid);

		if(!IsPlayerInAnyVehicle(playerid))
			return SendErrorMessage(playerid, "You're not in any vehicle!");

		if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
		{
			if(Vehicle_GetType(vehicle_index) != VEHICLE_TYPE_FACTION)
				return SendErrorMessage(playerid, "Bukan kendaraan faction!");

			if(Vehicle_GetExtraID(vehicle_index) != GetPlayerFactionID(playerid))
				return SendErrorMessage(playerid, "Ini bukan kendaraan factionmu!");
		}

		if(isnull(inputtext))
			return Dialog_Show(playerid, CallSignInput, DIALOG_STYLE_INPUT, "Call Sign", "Input your call sign:\nNote: input dengan off jika ingin menghapus!", "Place", "Close");


		if(strlen(inputtext) > 64)
			return Dialog_Show(playerid, CallSignInput, DIALOG_STYLE_INPUT, "Call Sign", "Input your call sign:\nNote: input dengan off jika ingin menghapus!\nError - Minimal 64 huruf!", "Place", "Close");

		if(!strcmp(inputtext, "off", true))
		{
			Callsign_Remove(vehicleid);
			Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Call Sign", "Call Sign Removed!", "Close", "");
			return 1;
		}

		gVehicleCallsign[vehicleid] = true;
		Callsign_Create(vehicleid, inputtext);

		SendCustomMessage(playerid, "CALLSIGN", "%s", inputtext);
	}
	return 1;
}
// Commands
CMD:callsign(playerid, params[])
{
	new
		vehicle_index,
		vehicleid = GetPlayerVehicleID(playerid);

	if(GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
		return SendErrorMessage(playerid, "Tidak diizinkan menggunakan perintah ini!.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "Kamu harus di dalam kendaraan!");

    if(!IsPlayerDuty(playerid)) 
    	return SendErrorMessage(playerid, "Duty terlebih dahulu!.");

	if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
	{
		if(Vehicle_GetType(vehicle_index) != VEHICLE_TYPE_FACTION)
			return SendErrorMessage(playerid, "Bukan kendaraan faction!");

		if(Vehicle_GetExtraID(vehicle_index) != GetPlayerFactionID(playerid))
			return SendErrorMessage(playerid, "Ini bukan kendaraan factionmu!");
	}

	if(isnull(params))
        return SendSyntaxMessage(playerid, "/callsign [text] 'off' untuk menghapus");

    if(strlen(params) > 64)
        return SendErrorMessage(playerid, "Maksimal 64 karakter yang diperbolehkan!.");

    if(!strcmp(params, "off", true))
    {
		Callsign_Remove(vehicleid);
        SendServerMessage(playerid, "Callsign pada kendaraan ini telah dihapus.");
        return 1;
    }

    gVehicleCallsign[vehicleid] = true;
	Callsign_Create(vehicleid, params);

    SendCustomMessage(playerid, "CALLSIGN", "%s", params);
    return 1;
}

CMD:acallsign(playerid, params[])
{
	static vehicleid, text[64];

	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "ds[64]", vehicleid, text))
    	return SendSyntaxMessage(playerid, "/acallsign [vehicleid] [text] 'off' untuk menghapus.");

    if(!IsValidVehicle(vehicleid))
    	return SendErrorMessage(playerid, "Kendaraan tidak valid!");

    if(strlen(text) > 64)
        return SendErrorMessage(playerid, "Maksimal 64 karakter yang diperbolehkan!.");

    if(!strcmp(text, "off", true))
    {
		Callsign_Remove(vehicleid);
        SendServerMessage(playerid, "Callsign pada kendaraan "YELLOW"id %d "WHITE"ini telah dihapus.", vehicleid);
        return 1;
    }

    gVehicleCallsign[vehicleid] = true;
	Callsign_Create(vehicleid, text);

    SendCustomMessage(playerid, "CALLSIGN", "%s", text);
    return 1;
}