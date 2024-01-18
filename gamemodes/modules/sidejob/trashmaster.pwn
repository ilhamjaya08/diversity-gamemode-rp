#include <YSI\y_hooks>


// Defined
#define TRASHMASTER_SALARY							5
#define MAX_TRASH_COLLECTED             (50)

#define IsTrashmasterWorking(%0)		trash_working[%0]
#define SetTrashmasterWorking(%0,%1)	trash_working[%0] = %1

#define GetPlayerTrash(%0)				trash_collected{%0}
#define SetPlayerTrash(%0,%1)			trash_collected{%0} = %1
#define AddPlayerTrash(%0,%1)			trash_collected{%0} += %1


// Variables
new 
	trash_collected[MAX_PLAYERS] = {0, ...},
	bool:trash_working[MAX_PLAYERS] = {false, ...},
	PlayerBar:trash_progressbar[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID, ...};


// Events
hook OnPlayerConnect(playerid)
{
	SetPlayerTrash(playerid, 0);
	SetTrashmasterWorking(playerid, false);

	//Trashmaster job
    RemoveBuildingForPlayer(playerid, 3574, 2226.320, -2168.989, 15.101, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2226.320, -2168.989, 15.101, 0.250);
    RemoveBuildingForPlayer(playerid, 3574, 2241.300, -2183.979, 15.101, 0.250);
    RemoveBuildingForPlayer(playerid, 3744, 2241.300, -2183.979, 15.101, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2239.000, -2199.810, 16.351, 0.250);
    RemoveBuildingForPlayer(playerid, 1226, 2224.780, -2185.739, 16.351, 0.250);
    RemoveBuildingForPlayer(playerid, 1315, 2208.870, -2171.320, 15.812, 0.250);
}

hook OnPlayerDisconnectEx(playerid, reason)
{
	if(IsTrashmasterWorking(playerid))
	{
		SetTrashmasterDelay(playerid, JobConfig_GetExitDelay(SIDEJOB_BUS_DRIVER));
		DisablePlayerCheckpoint(playerid);

		SetVehicleToRespawn(GetPlayerLastVehicle(playerid));
	}
	if(GetTrashmasterDelay(playerid)) {
		UpdateCharacterInt(playerid, "Work", GetTrashmasterDelay(playerid));
	}
}

hook OnScriptInit()
{
	CreateDynamicMapIcon(2286.7566,-1981.7808,13.5699, 56, -1, 0, 0, -1, _, MAPICON_GLOBAL);

	CreateDynamicPickup(1239, 23, 2286.7566,-1981.7808,13.5699);
	CreateDynamic3DTextLabel("[Garbage Collector]\n"WHITE"Gunakan "YELLOW"/droptrash"WHITE" untuk mendapatkan upah", COLOR_CLIENT, 2286.7566,-1981.7808,13.5699+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
}

hook EnterTrashmasterVehicle(playerid, vehicleid)
{
	if(!IsAdminOnDuty(playerid) && !IsTrashmasterWorking(playerid))
	{
		if (!JobConfig_IsJobEnabled(SIDEJOB_BUS_DRIVER))
		{
			SendServerMessage(playerid, "Sidejob ini di-nonaktifkan oleh server.");
			RemovePlayerFromVehicle(playerid);
			SetCameraBehindPlayer(playerid);
			return 1;
		}

		if(!GetTrashmasterDelay(playerid) || GetPlayerVIPLevel(playerid) >= 2) // Kalau lagi tidak delay atau VIP levelnya 2
		{
			SetCameraBehindPlayer(playerid);
			Dialog_Show(playerid, StartTrashmaster, DIALOG_STYLE_MSGBOX, "Trashmaster Sidejob", ""WHITE"Pekerjaan ini bertujuan untuk membersihkan seluruh kota Los Santos.\nAnda bisa temukan tong sampah yang tersebar di kota "YELLOW"Los Santos "WHITE"ini. Ikuti petunjuk "RED"radar "WHITE"yang di sediakan.\n Itu merupahan lokasi yang harus anda tuju.\n\
				\n\n"RED"WARNING: "WHITE"Jangan turun dari kendaraan saat bekerja, atau anda akan gagal dalam pekerjaan ini.", "Mulai", "Turun"
			);
		}
		else
		{
			SendServerMessage(playerid, "Anda masih menunggu waktu "YELLOW"%d menit "WHITE"untuk melakukan pekerjaan ini lagi.", GetTrashmasterDelay(playerid)/60);
			RemovePlayerFromVehicle(playerid);
			SetCameraBehindPlayer(playerid);
		}
	}

	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && IsTrashmasterWorking(playerid))
	{
		Dialog_Show(playerid, TrashSidejobLeave, DIALOG_STYLE_MSGBOX, "Trashmaster Sidejob", ""WHITE"Apakah kamu ingin turun dan menggagalkan pekerjaan ini?\nNantinya kamu harus menunggu selama "RED"10 menit "WHITE"untuk kembali bekerja!", "Lanjut", "Gagalkan");
	}
	return 1;
}


// Function
CancelTrashmasterProgress(playerid, vehicleid, bool:finished = true)
{
	if(IsTrashmasterWorking(playerid))
	{
		SetPlayerTrash(playerid, 0);
		SetTrashmasterWorking(playerid, false);
		SetTrashmasterDelay(playerid, (finished ? JobConfig_GetSuccessDelay(SIDEJOB_BUS_DRIVER) : JobConfig_GetFailDelay(SIDEJOB_BUS_DRIVER)));

		DisablePlayerCheckpoint(playerid);
	
		UpdateCharacterInt(playerid, "Work", GetTrashmasterDelay(playerid));
		SetVehicleToRespawn(vehicleid);
		// Hide mapicon
		for(new i = 0; i < MAX_GARBAGE_BINS; i++) if(GarbageData[i][garbageExists]) {
			RemovePlayerMapIcon(playerid, (i+20));
		}

		// Textdraw & Progressbar hide
		HidePlayerProgressBar(playerid, trash_progressbar[playerid]);
		PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][textdraw_trash][0]);
		PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][textdraw_trash][1]);
	}
	return 1;
}


// Timer
ptask Player_TrashUpdate[1000](playerid)
{
	if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
		return 0;
		
	if(GetTrashmasterDelay(playerid))
	{
		SetTrashmasterDelay(playerid, (GetTrashmasterDelay(playerid)-1));

		if(!GetTrashmasterDelay(playerid)) {
			UpdateCharacterInt(playerid, "Work", 0);
			SendCustomMessage(playerid, "TRASHMASTER SIDEJOB", "Kamu bisa bekerja "CYAN"Trashmaster "WHITE"kembali!.");
		}
	}
	return 1;
}

// Dialog Response
Dialog:StartTrashmaster(playerid, response, listitem, inputtext[])
{
    if(response)
    {
    	// Progress bar properties
			if(trash_progressbar[playerid] != INVALID_PLAYER_BAR_ID)
			{
				DestroyPlayerProgressBar(playerid, trash_progressbar[playerid]);
			}

			new
				max_trashes_collected = JobConfig_GetMaxTrashes()
			;

			trash_progressbar[playerid] = CreatePlayerProgressBar(playerid, 37.000000, 319.000000, 102.500000, 7.199999, -1429936641, 100.0000, 0);
			SetPlayerProgressBarMaxValue(playerid, trash_progressbar[playerid], max_trashes_collected);
			SetPlayerProgressBarValue(playerid, trash_progressbar[playerid], GetPlayerTrash(playerid));
			ShowPlayerProgressBar(playerid, trash_progressbar[playerid]);            
			
			// Textdraw properties        
			PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_trash][1], sprintf("%02d/%d", GetPlayerTrash(playerid), max_trashes_collected));
			
			PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][textdraw_trash][0]);
			PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][textdraw_trash][1]);

			// Vehicle Properties
			SetEngineStatus(GetPlayerVehicleID(playerid), true);
			SetDoorStatus(GetPlayerVehicleID(playerid), true);

			// Message
			SendCustomMessage(playerid, "HINT", "Ikuti tanda di radar Map, itu merupakan lokasi untuk menemukan tempat sampah.");
			SendCustomMessage(playerid, "HINT", "Perintah '"YELLOW"/collecttrash"WHITE"' untuk mengambil sampah dan '"YELLOW"/droptrash"WHITE"' untuk ...");
			SendClientMessage(playerid, X11_WHITE, ".. mendapatkan upah setelah sampah terkumpul. Kembali ke tempat awal untuk menjual garbage.");

			for(new i = 0; i < MAX_GARBAGE_BINS; i++) if(GarbageData[i][garbageExists]) {
				SetPlayerMapIcon(playerid, (i+20), GarbageData[i][garbagePos][0], GarbageData[i][garbagePos][1], GarbageData[i][garbagePos][2], 42, 0, MAPICON_GLOBAL);
			}
			SetTrashmasterWorking(playerid, true);
    }
    else SendErrorMessage(playerid, "Kamu menolak bekerjaan sebagai Trashmaster."), RemovePlayerFromVehicle(playerid);
    return 1;
}

Dialog:TrashSidejobLeave(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		PutPlayerInVehicle(playerid, GetPlayerLastVehicle(playerid), 0);
		return SendCustomMessage(playerid, "TRASHMASTER SIDEJOB","Lanjutkan kembali pekerjaanmu, ikuti rute yang telah diberikan.");
	}
	else {
		CancelTrashmasterProgress(playerid, GetPlayerLastVehicle(playerid), false);
		SendErrorMessage(playerid, "Kamu menggagalkan pekerjaan Trashmaster!");		
	}
	return 1;
}

// Commands
CMD:collecttrash(playerid, params[])
{
	new id;

	if(!IsTrashmasterWorking(playerid))
		return SendErrorMessage(playerid, "Kamu tidak bekerja sebagai Trashmaster!");

	if((id = Garbage_Nearest(playerid)) == -1)
		return SendErrorMessage(playerid, "Kamu tidak berada didekat tong sampah!");

	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "Kemudikan kendaraan untuk menggunakan perintah ini!");

	if(GarbageData[id][garbageCapacity] < 1)
		return SendErrorMessage(playerid, "Tidak ada sampah disini, silahkan cari ke tempat lain!");

	new
		max_trashes_collected = JobConfig_GetMaxTrashes()
	;

	if(GetPlayerTrash(playerid) > max_trashes_collected)
	{
		SetPlayerWaypoint(playerid, "Dump Garbage", 2286.7566,-1981.7808,13.5699);
		return SendServerMessage(playerid, "Jumlah sampah sudah mencapai batas maksimal, silahkan pergi ke pengepul sampah untuk mendapat upah!");
	}

	if((GarbageData[id][garbageCapacity] + GetPlayerTrash(playerid)) <= max_trashes_collected) 
	{
		AddPlayerTrash(playerid, GarbageData[id][garbageCapacity]);
		SendServerMessage(playerid, "Kamu mendapat "YELLOW"%d kantong sampah"WHITE", cari kelokasi lain untuk mendapatkan lebih banyak!", GarbageData[id][garbageCapacity]);

		GarbageData[id][garbageCapacity] = 0;
	}
	else
	{
		GarbageData[id][garbageCapacity] -= (max_trashes_collected - GetPlayerTrash(playerid));
		SetPlayerTrash(playerid, max_trashes_collected);

		SetPlayerWaypoint(playerid, "Dump Garbage", 2286.7566,-1981.7808,13.5699);
		SendServerMessage(playerid, "Jumlah sampah sudah mencapai batas maksimal, silahkan pergi ke pengepul sampah untuk mendapat upah!");
	}

	PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_trash][1], sprintf("%02d/%d", GetPlayerTrash(playerid), max_trashes_collected));
	SetPlayerProgressBarValue(playerid, trash_progressbar[playerid], GetPlayerTrash(playerid));

	Garbage_Save(id, false);
	return 1;
}

CMD:droptrash(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "Kemudikan kendaraan untuk menggunakan perintah ini!");

	if(!IsPlayerInRangeOfPoint(playerid, 4, 2286.7566,-1981.7808,13.5699)) 
		return SendErrorMessage(playerid, "Pergi ke lokasi penampungan sampah untuk mendapatkan upah!");

	if(!GetPlayerTrash(playerid)) 
		return SendErrorMessage(playerid, "Tidak ada sampah dimobil ini!");

	new
		bonus,
		salary = JobConfig_GetBaseSalary(SIDEJOB_BUS_DRIVER),
		trash = GetPlayerTrash(playerid),
		earn_per_trash = JobConfig_GetEarnPerTrash(),
		reward_collected_trashes = trash * earn_per_trash
	;

	JobConfig_GetBonus(SIDEJOB_BUS_DRIVER, bonus);

	// Message & salary
	SendServerMessage(playerid, "Kamu mendapatkan "GREEN"%s (+ bonus: %s) (+ reward per trash: %s) "WHITE"dari total "YELLOW"%d sampah "WHITE"yang terkumpul!", FormatNumber(salary), FormatNumber(bonus), FormatNumber(reward_collected_trashes), GetPlayerTrash(playerid));
	AddPlayerSalary(playerid, salary + bonus + reward_collected_trashes, "Trashmaster Sidejob");

	CancelTrashmasterProgress(playerid, GetPlayerVehicleID(playerid));
	return 1;
}