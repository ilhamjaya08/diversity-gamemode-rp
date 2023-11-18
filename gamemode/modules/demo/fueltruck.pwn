new bool:fuel_reffiling[MAX_PLAYERS] = {false, ...},
	fuel_refilled[MAX_PLAYERS] = {-1, ...},
	fuel_vehicleholding[MAX_VEHICLES] = {0, ...},
	Timer:fuel_timer[MAX_PLAYERS],
	PlayerBar:fuel_bar[MAX_PLAYERS];

CMD:refillpump(playerid, params[])
{
	static
		id = -1;

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Kamu tidak berada di dalam kendaraan.");

	if((id = Pump_Nearest(playerid)) != -1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);

		if(!GetVehicleTrailer(vehicleid))
			return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Tidak ada trailer yang tersambung di road train ini.");

		if(!fuel_vehicleholding[GetVehicleTrailer(vehicleid)])
			return ShowPlayerFooter(playerid, "~y~[INFO]~n~~w~Trailer tidak memuat apapun di dalamnya.");

		if(PumpData[id][pumpFuel] > 300)
			return ShowPlayerFooter(playerid, "~y~[INFO]~n~~w~Gas Pump masih menampung lebih dari 300 liter~n~tidak dapat melakukan refill sekarang.");

		if(PumpData[id][pumpRefilled])
			return ShowPlayerFooter(playerid, "~y~[INFO]~n~~w~Gas Pump sedang melakukan pengisian.");

		PumpData[id][pumpRefilled] = true;
		fuel_refilled[playerid] = id;

		fuel_timer[playerid] = repeat refillTrailer(playerid, id);
		fuel_bar[playerid] = CreatePlayerProgressBar(playerid, 26.000000, 421.000000, 10.000000, 76.199996, 0x15a014FF, 100.0000, 2);
		ShowPlayerProgressBar(playerid, fuel_bar[playerid]);

		Pump_Refresh(id);
	}
	else ShowPlayerFooter(playerid, "~y~[SERVER]~n~~w~Kamu tidak berada di dekat gas pump.");
	
	return 1;
}

CMD:checktrailer(playerid, params[])
{
	#pragma unused params

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Kamu tidak berada di dalam kendaraan.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(!GetVehicleTrailer(vehicleid))
		return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Tidak ada trailer yang tersambung di road train ini.");

	if(!fuel_vehicleholding[GetVehicleTrailer(vehicleid)])
		return ShowPlayerFooter(playerid, "~y~[INFO]~n~~w~Isi trailer ini kosong.");

	SendServerMessage(playerid, "Trailer ini memuat "YELLOW"%d "WHITE"pengisian penuh pada masing-masing gas pump.", fuel_vehicleholding[GetVehicleTrailer(vehicleid)]);
	return 1;
}

CMD:refilltrailer(playerid, params[])
{
	#pragma unused params

	if(!IsPlayerInRangeOfPoint(playerid, 5, 263.9153,1410.7195,10.4925))
		return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Kamu tidak berada pada ~b~penambangan minyak.");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Kamu tidak berada di dalam kendaraan.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(!GetVehicleTrailer(vehicleid))
		return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Tidak ada trailer yang tersambung di road train ini.");

	if(fuel_vehicleholding[GetVehicleTrailer(vehicleid)] >= 2)
		return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Trailer sudah ~r~penuh~w~, silahkan untuk melakukan pengisian ke ~b~gas station ~w~yang ingin kamu isi, -~n~gunakan perintah ~r~/refillpump", 4000);

	if(fuel_reffiling[playerid])
		return ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Sedang mengisi trailer ...");

	if(GetEngineStatus(vehicleid)) {
        cmd_v(playerid, "engine");
        ShowPlayerFooter(playerid, "Mesin kendaraan ~r~dimatikan ~w~secara otomatis ketika pengisian.");
    }
	
	fuel_reffiling[playerid] = true;
	fuel_timer[playerid] = repeat refillTrailer(playerid, GetVehicleTrailer(vehicleid));

	fuel_bar[playerid] = CreatePlayerProgressBar(playerid, 26.000000, 421.000000, 10.000000, 76.199996, 0x15a014FF, 100.0000, 2);
	ShowPlayerProgressBar(playerid, fuel_bar[playerid]);
	return 1;
}

timer refillTrailer[1000](playerid, id)
{
	if(fuel_reffiling[playerid])
	{
		if(!IsPlayerInRangeOfPoint(playerid, 5, 263.9153,1410.7195,10.4925))
		{
			ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Pengisian belum selesai, tetapi kamu menjauh dari area dan otomatis gagal dalam pengisian.", 4000);
			DestroyPlayerProgressBar(playerid, fuel_bar[playerid]);
			fuel_reffiling[playerid] = false;
			stop fuel_timer[playerid];
		}

		if(GetPlayerProgressBarValue(playerid, fuel_bar[playerid]) < 100)
		{
			SetPlayerProgressBarValue(playerid, fuel_bar[playerid], (GetPlayerProgressBarValue(playerid, fuel_bar[playerid])+10));
		}
		else {
			DestroyPlayerProgressBar(playerid, fuel_bar[playerid]);

			if(++fuel_vehicleholding[id] >= 2)
				ShowPlayerFooter(playerid, "~y~~h~[SERVER]~n~~w~Trailer sudah penuh, silahkan untuk melakukan pengisian ke ~b~gas station ~w~yang ingin kamu isi, -~n~gunakan perintah ~r~/refillpump", 4000);

			GameTextForPlayer(playerid, "~b~~h~Refilling Trailer ~w~Done!", 2500, 4);
			fuel_reffiling[playerid] = false;
			stop fuel_timer[playerid];
		}
	}

	if(fuel_refilled[playerid] != -1)
	{
		if(!GetVehicleTrailer(GetPlayerVehicleID(playerid)))
		{
			PumpData[id][pumpRefilled] = false;
			fuel_refilled[playerid] = 0;

			ShowPlayerFooter(playerid, "~r~[ERROR]~n~~w~Gagal melakukan refill, trailer kamu tidak ada di kendaraan mu atau -~n~kamu tidak berada dalam kendaraan.");
			stop fuel_timer[playerid];
		}


		if(GetPlayerProgressBarValue(playerid, fuel_bar[playerid]) < 100)
		{
			new rand = RandomEx(2, 5);
			SetPlayerProgressBarValue(playerid, fuel_bar[playerid], (GetPlayerProgressBarValue(playerid, fuel_bar[playerid])+rand));
		}
		else {
			stop fuel_timer[playerid];

			PumpData[id][pumpRefilled] = false;
			PumpData[id][pumpFuel] = 1000;
			fuel_refilled[playerid] = 0;
			fuel_vehicleholding[GetVehicleTrailer(GetPlayerVehicleID(playerid))] --;

			Pump_Refresh(id);

			DestroyPlayerProgressBar(playerid, fuel_bar[playerid]);
			GameTextForPlayer(playerid, "~b~~h~Refilling Gas Pump Done!", 2500, 4);
		}
	}
	return 1;
}