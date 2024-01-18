#include <YSI\y_hooks>

// Defined
#define IsBoxvilleWorking(%0)		boxville_working[%0]
#define SetBoxvilleWorking(%0,%1)	boxville_working[%0] = %1


// Variables
new 
	HouseDelivered[MAX_PLAYERS] = {0, ...},
	bool:boxville_working[MAX_PLAYERS] = {false, ...},
	Timer:BoxvilleRespawn[MAX_PLAYERS],
	BoxvilleVehicleID[MAX_PLAYERS] = {RETURN_INVALID_VEHICLE_ID, ...},
	BoxvilleRespawnCounter[MAX_PLAYERS] = {0, ...},
	BoxvilleCarryPacket[MAX_PLAYERS] = {0, ...}
;


// Events
hook OnPlayerConnect(playerid)
{
	HouseDelivered[playerid] = 0;
	BoxvilleVehicleID[playerid] = RETURN_INVALID_VEHICLE_ID;
	BoxvilleRespawnCounter[playerid] = 0;
	BoxvilleCarryPacket[playerid] = 0;
	SetBoxvilleWorking(playerid, false);
}

hook OnPlayerDisconnectEx(playerid, reason)
{
	if(IsBoxvilleWorking(playerid))
	{
		new
			delivered_houses = HouseDelivered[playerid],
			earn_per_house = JobConfig_GetEarnPerHouse(),
			reward_delivered_houses = delivered_houses * earn_per_house
		;

		AddPlayerSalary(playerid, (reward_delivered_houses), "Boxville Sidejob");
		SetBoxvilleDelay(playerid, JobConfig_GetExitDelay(SIDEJOB_BOXVILLE));
		DisablePlayerCheckpoint(playerid);
		stop BoxvilleRespawn[playerid];

		BoxvilleRespawnCounter[playerid] = 0;
		SetVehicleToRespawn(BoxvilleVehicleID[playerid]);
		BoxvilleVehicleID[playerid] = RETURN_INVALID_VEHICLE_ID;
	}

	if(GetBoxvilleDelay(playerid)) {
		UpdateCharacterInt(playerid, "BoxvilleDelay", GetBoxvilleDelay(playerid));
	}
}

hook OnScriptInit()
{
	CreateDynamicMapIcon(1613.1182,-1891.2689,13.5469, 56, -1, 0, 0, -1, _, MAPICON_GLOBAL);
	CreateDynamicPickup(1239, 23, 1613.1182,-1891.2689,13.5469);
	CreateDynamic3DTextLabel("[Box Ville]\n"WHITE"Gunakan "YELLOW"/stopboxville"WHITE" untuk mendapatkan upah", COLOR_CLIENT, 1613.1182,-1891.2689,13.5469+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0);
}

hook EnterBoxvilleVehicle(playerid, vehicleid)
{
	if(!IsAdminOnDuty(playerid) && !IsBoxvilleWorking(playerid))
	{
		if (!JobConfig_IsJobEnabled(SIDEJOB_BOXVILLE))
		{
			SendCustomMessage(playerid, "BOXVILLE", "Sidejob ini di-nonaktifkan oleh server.");
			RemovePlayerFromVehicle(playerid);
			SetCameraBehindPlayer(playerid);
			return 1;
		}

		if(!GetBoxvilleDelay(playerid) || GetPlayerVIPLevel(playerid) >= 2) // Kalau lagi tidak delay atau VIP levelnya 2
		{
			SetCameraBehindPlayer(playerid);
			Dialog_Show(playerid, StartBoxville, DIALOG_STYLE_MSGBOX, "Boxville Sidejob", ""WHITE"Pekerjaan ini bertujuan untuk mengantarkan paket ke setiap rumah di Los Santos.\nAnda bisa temukan rumah rumah yang ada di setiap kota "YELLOW"Los Santos "WHITE"ini. Ikuti petunjuk "RED"radar "WHITE"yang di sediakan.\n Itu merupahan lokasi yang harus anda tuju.\n\
				\n\n"RED"WARNING: "WHITE"Turun dari kendaraan untuk mengambil box packet dan menaruhnya ke depan rumah.", "Mulai", "Turun"
			);
		}
		else 
		{
			SendServerMessage(playerid, "Anda masih menunggu waktu "YELLOW"%d menit "WHITE"untuk melakukan pekerjaan ini lagi.", GetBoxvilleDelay(playerid)/60, RemovePlayerFromVehicle(playerid));
		}
	}
	if(IsBoxvilleWorking(playerid))
	{
		BoxvilleVehicleID[playerid] = vehicleid;
		stop BoxvilleRespawn[playerid];
		BoxvilleRespawnCounter[playerid] = 0;
		RemovePlayerAttachedObject(playerid, JOB_SLOT);
	}

	return 1;
}
stock BoxvillePickup(playerid)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, JOB_SLOT))
		RemovePlayerAttachedObject(playerid, JOB_SLOT);

	SetPlayerAttachedObject(playerid, JOB_SLOT, 1271, 1,0.237980,0.473312,-0.066999, 1.099999,88.000007,-177.400085, 0.716000,0.572999,0.734000);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	BoxvilleCarryPacket[playerid] = 1;
	return 1;
}

stock BoxvilleDrop(playerid)
{
	ClearAnimations(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, JOB_SLOT);
	BoxvilleCarryPacket[playerid] = 0;
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CTRL_BACK && IsBoxvilleWorking(playerid) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new vehicle_nearest, vehicleid;
		if((vehicle_nearest = Vehicle_Nearest(playerid)) != -1 && (vehicleid = Vehicle_ReturnID(vehicle_nearest)) != -1 && VehicleData[vehicleid][vehModel] == 498)
		{
			if(!BoxvilleCarryPacket[playerid])
			{
				BoxvillePickup(playerid);
			}
			else
			{
				BoxvilleDrop(playerid);
			}
		}
	}
}

// hook OnVehicleDeath(vehicleid, killerid)
// {
// 	if(killerid != INVALID_PLAYER_ID && IsBoxvilleWorking(killerid))
// 	{
// 		new vehicleindex;
// 		if((vehicleindex = Vehicle_ReturnID(vehicleid)) != -1 && Vehicle_GetType(vehicleindex) == VEHICLE_TYPE_SIDEJOB)
// 		{
// 			CancelBoxville(killerid, vehicleid);
// 		}
// 	}
// }

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && IsBoxvilleWorking(playerid))
	{
		SendServerMessage(playerid, "Tekan "RED"'H'"WHITE" di dekat mobil kamu dan antarkan packet ke depan rumah "YELLOW"'/deliverpacket'");
		SendServerMessage(playerid, "Tekan "RED"'H'"WHITE" di dekat mobil kamu untuk menaruh kembali packetnya jika rumah tidak menerima paket!");
		SendServerMessage(playerid, "Jika kamu tidak kembali ke mobil dalam 5 menit, kamu akan gagal dan mobil akan di respawn");
		BoxvilleRespawn[playerid] = repeat RespawnBoxvilleVehicle(playerid, BoxvilleVehicleID[playerid]);
	}
	return 1;
}

// Function
CancelBoxville(playerid, vehicleid, bool:finished = true)
{
	if(IsBoxvilleWorking(playerid))
	{
		BoxvilleDrop(playerid);
		BoxvilleVehicleID[playerid] = RETURN_INVALID_VEHICLE_ID;
		HouseDelivered[playerid] = 0;
		SetBoxvilleWorking(playerid, false);
		SetBoxvilleDelay(playerid, (finished ? JobConfig_GetSuccessDelay(SIDEJOB_BOXVILLE) : JobConfig_GetFailDelay(SIDEJOB_BOXVILLE)));
		DisablePlayerCheckpoint(playerid);

		UpdateCharacterInt(playerid, "BoxvilleDelay", GetBoxvilleDelay(playerid));
		SetVehicleToRespawn(vehicleid);
		stop BoxvilleRespawn[playerid];
		BoxvilleRespawnCounter[playerid] = 0;

		// Hide mapicon
		for(new i = 0; i < MAX_HOUSES; i++) if(HouseData[i][houseExists]) {
			RemovePlayerMapIcon(playerid, (i+20));
		}
	}
	return 1;
}


// Timer
task Server_ResetHousePacket[1800000]()
{
	for(new i = 0; i < MAX_HOUSES; i++)
	{
		if(HouseData[i][houseExists] && HouseData[i][housePacket] != 0)
		{
			HouseData[i][housePacket] = 0;
		}
	}
	return 1;
}

timer RespawnBoxvilleVehicle[1000](playerid, vehicleid)
{
	if(IsPlayerSpawned(playerid) && IsBoxvilleWorking(playerid))
	{
		BoxvilleRespawnCounter[playerid]++;
		if(BoxvilleRespawnCounter[playerid] >= 300)
		{
			CancelBoxville(playerid, vehicleid);
			SendServerMessage(playerid, "Kamu gagal menjalankan pekerjaan box ville, mobil telah di respawn!");
		}
	}
	return 1;
}
ptask Player_BoxvilleUpdate[1000](playerid)
{
	if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
		return 0;
		
	if(GetBoxvilleDelay(playerid))
	{
		SetBoxvilleDelay(playerid, (GetBoxvilleDelay(playerid)-1));

		if(!GetBoxvilleDelay(playerid)) {
			UpdateCharacterInt(playerid, "BoxvilleDelay", 0);
			SendCustomMessage(playerid, "BOX VILLE SIDEJOB", "Kamu bisa bekerja "CYAN"Box ville "WHITE"kembali!.");
		}
	}
	return 1;
}

// Dialog Response
Dialog:StartBoxville(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		// Vehicle Properties
		BoxvilleVehicleID[playerid] = GetPlayerVehicleID(playerid);
		SetEngineStatus(GetPlayerVehicleID(playerid), true);
		SetDoorStatus(GetPlayerVehicleID(playerid), false);

		// Message
		SendCustomMessage(playerid, "HINT", "Ikuti tanda di radar Map, itu merupakan lokasi untuk menemukan rumah.");
		SendCustomMessage(playerid, "HINT", "Tekan huruf "YELLOW"'H' "WHITE"di dekan truck boxville anda dan bawa paket ke checkpoint rumah.");
		SendCustomMessage(playerid, "HINT", "Perintah '"YELLOW"/deliverpacket"WHITE"' untuk menaruh packet di checkpoint rumah "YELLOW"/stopboxville"WHITE"' untuk ...");
		SendClientMessage(playerid, X11_WHITE, ".. mendapatkan upah setelah mengantar packet ke setiap rumah. Kembali ke tempat awal untuk meletakan mobil boxville.");
		SendCustomMessage(playerid, "PACKET", "Jumlah packet yang kamu antarkan "GREEN"%d "WHITE"packet di dalam boxville "GREEN"%d", HouseDelivered[playerid], JobConfig_GetMaxHousesDelivered());

		for(new i = 0; i < MAX_HOUSES; i++) if(HouseData[i][houseExists] && HouseData[i][housePacket] == 0) {
			SetPlayerMapIcon(playerid, (i+20), HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2], 31, 0, MAPICON_GLOBAL);
		}
		SetBoxvilleWorking(playerid, true);
	}
	else SendErrorMessage(playerid, "Kamu menolak pekerjaan sebagai Boxville deliver."), RemovePlayerFromVehicle(playerid);
	return 1;
}

// Commands
CMD:deliverpacket(playerid, params[])
{
	new id;

	if(!IsBoxvilleWorking(playerid))
		return SendErrorMessage(playerid, "Kamu tidak bekerja sebagai Box Ville!");

	if((id = House_Nearest(playerid)) == -1)
		return SendErrorMessage(playerid, "Kamu tidak berada di dekat rumah!");

	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		return SendErrorMessage(playerid, "Turun dari kendaraan untuk menggunakan perintah ini!");

	if(HouseData[id][housePacket] > 0)
		return SendErrorMessage(playerid, "Rumah ini tidak menerima packet, coba ke alamat rumah yang lain!");

	if(!BoxvilleCarryPacket[playerid])
		return SendErrorMessage(playerid, "Ambil dahulu paket yang ada di dalam truck!");

	if(HouseDelivered[playerid] >= JobConfig_GetMaxHousesDelivered())
	{
		SetPlayerWaypoint(playerid, "Boxville HQ", 1363.1598,-1648.3190,13.3828);
		return SendServerMessage(playerid, "Jumlah packet di dalam boxville habis, silahkan kembalikan mobil!");
	}

	new max_houses_delivered = JobConfig_GetMaxHousesDelivered();

	if(HouseDelivered[playerid] <= max_houses_delivered) 
	{
		HouseData[id][housePacket] = 1;
		HouseDelivered[playerid] += 1;
		SendServerMessage(playerid, "Kamu mengantarkan packet ke rumah ini"WHITE", lanjut ke lokasi lain dan terus mengirimnya!");
		SendCustomMessage(playerid, "PACKET", "Jumlah yang kamu kirim sekarang: "GREEN"%d "WHITE". Packet yang tersisa di truck: "GREEN"%d", HouseDelivered[playerid], (max_houses_delivered - HouseDelivered[playerid]));
	}
	else
	{
		HouseData[id][housePacket] = 1;
		HouseDelivered[playerid] = max_houses_delivered;
		SetPlayerWaypoint(playerid, "Boxville HQ", 1363.1598,-1648.3190,13.3828);
		SendServerMessage(playerid, "Packet di dalam boxville sudah habis, kembalikan truck!");
		SendCustomMessage(playerid, "PACKET", "Jumlah yang kamu kirim sekarang: "GREEN"%d "WHITE". Packet yang tersisa di truck: "GREEN"%d", HouseDelivered[playerid], (max_houses_delivered - HouseDelivered[playerid]));
	}

	BoxvilleDrop(playerid);
	return 1;
}

CMD:stopboxville(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return SendErrorMessage(playerid, "Kemudikan kendaraan untuk menggunakan perintah ini!");
    
	if(!IsPlayerInRangeOfPoint(playerid, 4, 1613.1182,-1891.2689,13.5469)) 
		return SendErrorMessage(playerid, "Pergi ke lokasi untuk mengembalikan boxville dan mengambil upah!");

	if(!IsBoxvilleWorking(playerid))
		return SendErrorMessage(playerid, "You are not working as boxville deliver!");

	new
		bonus,
		salary = JobConfig_GetBaseSalary(SIDEJOB_BOXVILLE),
		delivered_houses = HouseDelivered[playerid],
		earn_per_house = JobConfig_GetEarnPerHouse(),
		reward_delivered_houses = delivered_houses * earn_per_house
	;

	JobConfig_GetBonus(SIDEJOB_BOXVILLE, bonus);

	// Message & salary
	SendServerMessage(playerid, "Kamu mendapatkan "GREEN"%s (+ bonus: %s) (+ reward per house: %s) "WHITE"dari total "YELLOW"%d rumah "WHITE"yang kamu antar!", FormatNumber(salary), FormatNumber(bonus), FormatNumber(reward_delivered_houses), delivered_houses);
	AddPlayerSalary(playerid, salary + bonus + reward_delivered_houses, "Boxville Sidejob");

	CancelBoxville(playerid, GetPlayerVehicleID(playerid));
	return 1;
}