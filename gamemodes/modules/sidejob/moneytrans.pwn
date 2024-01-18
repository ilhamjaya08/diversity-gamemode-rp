#include <YSI\y_hooks>


// Defined
#define IsMoneytransWorking(%0)		moneytrans_working[%0]
#define SetMoneytransWorking(%0,%1)	moneytrans_working[%0] = %1


// Variables
new 
	MoneyDeposited[MAX_PLAYERS] = {0, ...},
	bool:moneytrans_working[MAX_PLAYERS] = {false, ...},
	Timer:MoneytransRespawn[MAX_PLAYERS],
	MoneytransVehicleID[MAX_PLAYERS] = {RETURN_INVALID_VEHICLE_ID, ...},
	MoneytransRespawnCounter[MAX_PLAYERS] = {0, ...}
;


// Events
hook OnPlayerConnect(playerid)
{
	MoneyDeposited[playerid] = 0;
	MoneytransVehicleID[playerid] = RETURN_INVALID_VEHICLE_ID;
	MoneytransRespawnCounter[playerid] = 0;
	SetMoneytransWorking(playerid, false);

}

hook OnPlayerDisconnectEx(playerid, reason)
{
	if(IsMoneytransWorking(playerid))
	{
		new
			bonus,
			reward_deposited_cash,
			Float:deposit_cash_rate,
			salary = JobConfig_GetBaseSalary(SIDEJOB_MONEY_TRANSPORTER),
			deposited_cash = MoneyDeposited[playerid]
		;

		JobConfig_GetBonus(SIDEJOB_MONEY_TRANSPORTER, bonus);
		JobConfig_GetDepositCashRate(deposit_cash_rate);
		reward_deposited_cash = floatround(floatmul(deposited_cash, floatdiv(deposit_cash_rate, 100.0)));

		AddPlayerSalary(playerid, salary + bonus + reward_deposited_cash, "Money Transporter Sidejob");

		SetMoneytransDelay(playerid, JobConfig_GetExitDelay(SIDEJOB_MONEY_TRANSPORTER));
		DisablePlayerCheckpoint(playerid);
		stop MoneytransRespawn[playerid];
		MoneytransRespawnCounter[playerid] = 0;
		SetVehicleToRespawn(MoneytransVehicleID[playerid]);		
		MoneytransVehicleID[playerid] = RETURN_INVALID_VEHICLE_ID;
	}

	if(GetMoneytransDelay(playerid)) {
		UpdateCharacterInt(playerid, "MoneyTransDelay", GetMoneytransDelay(playerid));
	}
}

hook OnScriptInit()
{
	CreateDynamicMapIcon(901.1875,-1207.2128,16.9832, 56, -1, 0, 0, -1, _, MAPICON_GLOBAL);
	CreateDynamicPickup(1239, 23, 901.1875,-1207.2128,16.9832);
	CreateDynamic3DTextLabel("[Money Transporter]\n"WHITE"Gunakan "YELLOW"/stopmoneytrans"WHITE" untuk mendapatkan upah", COLOR_CLIENT, 901.1875,-1207.2128,16.9832+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
}

hook EnterMoneytransVehicle(playerid, vehicleid)
{
	if(!IsAdminOnDuty(playerid) && !IsMoneytransWorking(playerid))
	{
		if (!JobConfig_IsJobEnabled(SIDEJOB_MONEY_TRANSPORTER))
		{
			SendCustomMessage(playerid, "MONEY TRANSPORTER", "Sidejob ini di-nonaktifkan oleh server.");
			RemovePlayerFromVehicle(playerid);
			SetCameraBehindPlayer(playerid);
			return 1;
		}

		if(!GetMoneytransDelay(playerid) || GetPlayerVIPLevel(playerid) >= 2) // Kalau lagi tidak delay atau VIP levelnya 2
		{
			SetCameraBehindPlayer(playerid);
			Dialog_Show(playerid, StartMoneyTrans, DIALOG_STYLE_MSGBOX, "Money Transporter Sidejob", ""WHITE"Pekerjaan ini bertujuan untuk mengisi ATM kota los santos.\nAnda bisa temukan ATM yang ada di setiap kota "YELLOW"Los Santos "WHITE"ini. Ikuti petunjuk "RED"radar "WHITE"yang di sediakan.\n Itu merupahan lokasi yang harus anda tuju.\n\
				\n\n"RED"WARNING: "WHITE"Turun dari kendaraan untuk mengambil money bag dan memasukannya ke dalam ATM.", "Mulai", "Turun"
			);
		}
		else 
		{
			SendServerMessage(playerid, "Anda masih menunggu waktu "YELLOW"%d menit "WHITE"untuk melakukan pekerjaan ini lagi.", GetMoneytransDelay(playerid)/60, RemovePlayerFromVehicle(playerid));
		}
	}

	if(IsMoneytransWorking(playerid))
	{
		MoneytransVehicleID[playerid] = vehicleid;
		stop MoneytransRespawn[playerid];
		MoneytransRespawnCounter[playerid] = 0;
		RemovePlayerAttachedObject(playerid, JOB_SLOT);
	}

	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && IsMoneytransWorking(playerid))
	{
		SetPlayerAttachedObject(playerid, JOB_SLOT, 1550, 1, 0.1379,-0.1370,-0.1460, 0.0000,80.3000,-176.6000, 0.5710,0.5590,0.7500);
		SendServerMessage(playerid, "Deposit uang yang kamu bawa di belakang badan ke dalam ATM!");
		SendServerMessage(playerid, "Jika kamu tidak kembali ke mobil dalam 5 menit, kamu akan gagal dan mobil akan di respawn");
		MoneytransRespawn[playerid] = repeat RespawnMoneyTransVehicle(playerid, MoneytransVehicleID[playerid]);
	}
	return 1;
}

// Function
CancelMoneyTransporter(playerid, vehicleid, bool:finished = true)
{
	if(IsMoneytransWorking(playerid))
	{
		MoneytransVehicleID[playerid] = RETURN_INVALID_VEHICLE_ID;
		MoneyDeposited[playerid] = 0;
		SetMoneytransWorking(playerid, false);
		SetMoneytransDelay(playerid, (finished ? JobConfig_GetSuccessDelay(SIDEJOB_MONEY_TRANSPORTER) : JobConfig_GetFailDelay(SIDEJOB_MONEY_TRANSPORTER)));

		DisablePlayerCheckpoint(playerid);
		RemovePlayerAttachedObject(playerid, JOB_SLOT);
	
		UpdateCharacterInt(playerid, "MoneyTransDelay", GetMoneytransDelay(playerid));
		SetVehicleToRespawn(vehicleid);
		stop MoneytransRespawn[playerid];
		MoneytransRespawnCounter[playerid] = 0;

		// Hide mapicon
		for(new i = 0; i < MAX_DYNAMIC_ATM; i++) if(ATM_IsExists(i)) {
			RemovePlayerMapIcon(playerid, (i+20));
		}
	}
	return 1;
}


// Timer
task Server_ResetATMMoney[7_200_000]()
{
	foreach(new i : Atms)
	{
		if(ATM_IsExists(i) && AtmData[i][atmCapacity] >= 15_000)
		{
			AtmData[i][atmCapacity] = 0;
		}
	}
	return 1;
}

timer RespawnMoneyTransVehicle[1000](playerid, vehicleid)
{
	if(IsPlayerSpawned(playerid) && IsMoneytransWorking(playerid))
	{
		MoneytransRespawnCounter[playerid]++;
		if(MoneytransRespawnCounter[playerid] >= 300)
		{
			CancelMoneyTransporter(playerid, vehicleid);
			SendServerMessage(playerid, "Kamu gagal menjalankan pekerjaan money transporter, mobil telah di respawn!");
		}
	}
	return 1;
}
ptask Player_MoneyTransUpdate[1000](playerid)
{
	if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
		return 0;
		
	if(GetMoneytransDelay(playerid))
	{
		SetMoneytransDelay(playerid, (GetMoneytransDelay(playerid)-1));

		if(!GetMoneytransDelay(playerid)) {
			UpdateCharacterInt(playerid, "MoneyTransDelay", 0);
			SendCustomMessage(playerid, "MONEY TRANSPORTER SIDEJOB", "Kamu bisa bekerja "CYAN"Money Transporter "WHITE"kembali!.");
		}
	}
	return 1;
}

// Dialog Response
Dialog:StartMoneyTrans(playerid, response, listitem, inputtext[])
{
    if(response)
    {
			// Vehicle Properties
			MoneytransVehicleID[playerid] = GetPlayerVehicleID(playerid);
			SetEngineStatus(GetPlayerVehicleID(playerid), true);
			SetDoorStatus(GetPlayerVehicleID(playerid), false);

			new
				max_atm_money = JobConfig_GetMaxATMCash(),
				max_van_money = JobConfig_GetMaxVanCash()
			;

			// Message
			SendCustomMessage(playerid, "HINT", "Ikuti tanda di radar Map, itu merupakan lokasi untuk menemukan ATM.");
			SendCustomMessage(playerid, "HINT", "Perintah '"YELLOW"/depositmoney"WHITE"' untuk mengisi ATM "YELLOW"/stopmoneytrans"WHITE"' untuk ...");
			SendClientMessage(playerid, X11_WHITE, ".. mendapatkan upah setelah mengisi semua ATM. Kembali ke tempat awal untuk meletakan mobil ATM.");
			SendCustomMessage(playerid, "MONEY", "Jumlah yang kamu deposit "GREEN"%s "WHITE"uang di dalam truck "GREEN"%s", FormatNumber(MoneyDeposited[playerid]), FormatNumber(max_van_money));

			foreach(new i : Atms) 
			{
				if(ATM_IsExists(i) && AtmData[i][atmCapacity] <= max_atm_money) 
				{
					SetPlayerMapIcon(playerid, (i+20), AtmData[i][atmPos][0], AtmData[i][atmPos][1], AtmData[i][atmPos][2], 52, 0, MAPICON_GLOBAL);
				}
			}
			SetMoneytransWorking(playerid, true);
    }
    else SendErrorMessage(playerid, "Kamu menolak pekerjaan sebagai Money Transporter."), RemovePlayerFromVehicle(playerid);
    return 1;
}

// Commands
CMD:depositmoney(playerid, params[])
{
	new id;

	if(!IsMoneytransWorking(playerid))
		return SendErrorMessage(playerid, "Kamu tidak bekerja sebagai Money Transporter!");

	if((id = ATM_Nearest(playerid)) == -1)
		return SendErrorMessage(playerid, "Kamu tidak berada didekat ATM!");

	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendErrorMessage(playerid, "Turun dari kendaraan untuk menggunakan perintah ini!");

	new
		max_atm_money = JobConfig_GetMaxATMCash(),
		max_money_deposited = JobConfig_GetMaxVanCash()
	;

	if(AtmData[id][atmCapacity] >= max_atm_money)
		return SendErrorMessage(playerid, "ATM Tempat ini penuh, coba cari ke tempat lain !");

	if(MoneyDeposited[playerid] >= max_money_deposited)
	{
		SetPlayerWaypoint(playerid, "Money Transporter HQ", 901.1875,-1207.2128,16.9832);
		return SendServerMessage(playerid, "Jumlah uang di dalam money transporter habis, silahkan kembalikan mobil!");
	}

	new
		sisa = max_atm_money - AtmData[id][atmCapacity],
		// Mendapatkan nilai stok sesungguhnya yang akan ditambahkan ke warehouse.
		// Mendapatkan jumlah stok yang akan ditambahkan ke warehouse.
		to_be_added = AtmData[id][atmCapacity] + max_atm_money
	;

	AtmData[id][atmCapacity] += (to_be_added > max_atm_money) ? sisa : max_atm_money;
	MoneyDeposited[playerid] += (to_be_added > max_atm_money) ? sisa : max_atm_money;
	
	if(MoneyDeposited[playerid] >= max_money_deposited) 
	{
		AtmData[id][atmCapacity] = max_atm_money;
		MoneyDeposited[playerid] = max_money_deposited;

		SetPlayerWaypoint(playerid, "Money Transporter HQ", 901.1875,-1207.2128,16.9832);
		SendServerMessage(playerid, "Uang di dalam money transporter sudah habis, kembalikan truck!!");
		SendCustomMessage(playerid, "MONEY", "Jumlah yang kamu deposit "GREEN"%s "WHITE"uang di dalam truck "GREEN"%s", FormatNumber(max_atm_money), FormatNumber(max_money_deposited - MoneyDeposited[playerid]));
	}
	else
	{
		SendServerMessage(playerid, "Kamu mengisi "YELLOW"%s ke dalam ATM"WHITE", cari kelokasi lain untuk deposit lebih banyak!", FormatNumber(max_atm_money));
		SendCustomMessage(playerid, "MONEY", "Jumlah yang kamu deposit "GREEN"%s "WHITE"uang di dalam truck "GREEN"%s", (to_be_added > max_atm_money) ? FormatNumber(sisa) : FormatNumber(max_atm_money), FormatNumber(max_money_deposited - MoneyDeposited[playerid]));
	}

	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);

	ATM_Save(id);
	return 1;
}

CMD:stopmoneytrans(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "Kemudikan kendaraan untuk menggunakan perintah ini!");

	if(!IsPlayerInRangeOfPoint(playerid, 4, 901.1875,-1207.2128,16.9832)) 
		return SendErrorMessage(playerid, "Pergi ke lokasi pengembalikan money truck untuk mengambil upah!");

	if(!IsMoneytransWorking(playerid))
		return SendErrorMessage(playerid, "You are not working as money transporter!");

	new
		bonus,
		reward_deposited_cash,
		Float:deposit_cash_rate,
		salary = JobConfig_GetBaseSalary(SIDEJOB_MONEY_TRANSPORTER),
		deposited_cash = MoneyDeposited[playerid]
	;

	JobConfig_GetBonus(SIDEJOB_MONEY_TRANSPORTER, bonus);
	JobConfig_GetDepositCashRate(deposit_cash_rate);
	reward_deposited_cash = floatround(floatmul(deposited_cash, floatdiv(deposit_cash_rate, 100.0)));

	// Message & salary
	SendServerMessage(playerid, "Kamu mendapatkan "GREEN"%s (+ bonus: %s) (+ reward deposited cash: %s) "WHITE"dari uang yang telah di-deposit ke ATM!", FormatNumber(salary), FormatNumber(bonus), FormatNumber(reward_deposited_cash));
	AddPlayerSalary(playerid, salary + bonus + reward_deposited_cash, "Money Transporter Sidejob");

	CancelMoneyTransporter(playerid, GetPlayerVehicleID(playerid));
	return 1;
}