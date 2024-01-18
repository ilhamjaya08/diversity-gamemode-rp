//include needs
#include <YSI\y_hooks>

//defined
#define SWEEPER_SALARY			150

#define IsPlayerWorkInSweeper(%0)		hasSweeper[%0]
#define SetPlayerWorkInSweeper(%0)		hasSweeper[%0] = true
#define StopPlayerWorkInSweeper(%0)		hasSweeper[%0] = false

// player variable
static
	bool:hasSweeper[MAX_PLAYERS] = {false, ...},
	sweeperRoute[MAX_PLAYERS] = {0, ...},
	currentSRoute[MAX_PLAYERS] = {0, ...};

// vehicle arrays
stock const Float:arr_sweeperRoute1[][] = {
	{1693.4064,-1479.7631,13.1080}, // sweeper start
	{1667.0480,-1478.0283,13.1079}, // sweeper 1-1
	{1660.5111,-1454.3849,13.1118}, // sweeper 1-2
	{1675.1539,-1444.2231,13.1079}, // sweeper 1-3
	{1730.6088,-1443.7028,13.0932}, // sweeper 1-4
	{1831.2880,-1462.9678,13.0951}, // sweeper 1-5
	{1843.8918,-1490.5854,13.0835}, // sweeper 1-6
	{1819.9841,-1595.3390,13.0839}, // sweeper 1-7
	{1822.2323,-1748.8264,13.1079}, // sweeper 1-8
	{1919.6168,-1755.3073,13.1079}, // sweeper 1-9
	{1959.4321,-1773.0394,13.1079}, // sweeper 1-10
	{1980.9254,-1814.1456,13.1079}, // sweeper 1-11
	{2079.9800,-1811.7034,13.1079}, // sweeper 1-12
	{2103.6841,-1755.4708,13.1227}, // sweeper 1-13
	{2186.0652,-1743.4493,13.1002}, // sweeper 1-14
	{2219.5972,-1735.0492,13.1300}, // sweeper 1-15
	{2327.5242,-1735.2003,13.1080}, // sweeper 1-16
	{2345.4016,-1645.8412,13.8436}, // sweeper 1-17
	{2344.8926,-1562.6310,23.5770}, // sweeper 1-18
	{2344.5139,-1501.1890,23.5608}, // sweeper 1-19
	{2320.1448,-1481.7450,23.2868}, // sweeper 1-20
	{2216.4883,-1477.4038,23.5533}, // sweeper 1-21
	{2206.5964,-1383.1036,23.5532}, // sweeper 1-22
	{2113.1155,-1388.9183,23.5533}, // sweeper 1-23
	{2105.8428,-1457.7885,23.5531}, // sweeper 1-24
	{1981.0509,-1458.9120,13.1216}, // sweeper 1-25
	{1845.6899,-1459.0912,13.1236}, // sweeper 1-26
	{1708.7760,-1438.3777,13.1157}, // sweeper 1-27
	{1659.3315,-1444.6982,13.1079}, // sweeper 1-28
	{1658.6056,-1543.7228,13.1080}, // sweeper 1-29
	{1688.8785,-1549.1486,13.1079} // sweeper stop
};

stock const Float:arr_sweeperRoute2[][] = {
	{1693.4064,-1479.7631,13.1080}, // sweeper start
	{1667.2151,-1477.5811,13.1079}, // sweeper 2-1
	{1656.2704,-1493.5122,13.1079}, // sweeper 2-2
	{1653.0756,-1587.7576,13.1090}, // sweeper 2-3
	{1542.3401,-1589.3818,13.1079}, // sweeper 2-4
	{1527.1006,-1631.8176,13.1079}, // sweeper 2-5
	{1522.4803,-1728.9530,13.1142}, // sweeper 2-6
	{1390.4149,-1736.6090,13.1138}, // sweeper 2-7
	{1385.7681,-1864.5575,13.1079}, // sweeper 2-8
	{1333.1085,-1851.9119,13.1114}, // sweeper 2-9
	{1314.7802,-1824.4611,13.1079}, // sweeper 2-10
	{1315.0604,-1707.5585,13.1079}, // sweeper 2-11
	{1314.7913,-1579.1759,13.1079}, // sweeper 2-12
	{1360.9597,-1413.3629,13.0946}, // sweeper 2-13
	{1415.6628,-1442.6869,13.1118}, // sweeper 2-14
	{1457.0045,-1406.8025,13.1079}, // sweeper 2-15
	{1465.7574,-1305.8304,13.1266}, // sweeper 2-16
	{1601.8905,-1305.5990,17.0064}, // sweeper 2-17
	{1715.5476,-1289.1658,13.1080}, // sweeper 2-18
	{1709.2932,-1160.6331,23.3816}, // sweeper 2-19
	{1588.9694,-1158.6211,23.6314}, // sweeper 2-20
	{1457.3066,-1162.0902,23.3834}, // sweeper 2-21
	{1452.6573,-1277.0215,13.1079}, // sweeper 2-22
	{1460.8993,-1442.2510,13.1075}, // sweeper 2-23
	{1606.8601,-1442.7699,13.1079}, // sweeper 2-24
	{1655.1173,-1469.7567,13.1095}, // sweeper 2-25
	{1664.8800,-1548.1460,13.1079}, // sweeper 2-26
	{1688.8785,-1549.1486,13.1079} // sweeper stop

};

stock const Float:arr_sweeperRoute3[][] = {
	{1693.4064,-1479.7631,13.1080}, // sweeper start
	{1660.6008,-1470.5343,13.1079}, // sweeper 3-1
	{1645.7667,-1438.5579,13.1080}, // sweeper 3-2
	{1481.3563,-1438.9153,13.1079}, // sweeper 3-3
	{1423.6927,-1432.6178,13.1080}, // sweeper 3-4
	{1352.2726,-1393.6688,13.1213}, // sweeper 3-5
	{1262.7516,-1378.9508,12.9256}, // sweeper 3-6
	{1248.6277,-1279.2891,13.0983}, // sweeper 3-7
	{1219.0867,-1259.2012,13.9008}, // sweeper 3-8
	{1228.9484,-1152.1438,23.0737}, // sweeper 3-9
	{1264.1534,-1119.0024,23.9954}, // sweeper 3-10
	{1241.1952,-1037.1432,31.4899}, // sweeper 3-11
	{1131.6104,-1037.1265,31.4271}, // sweeper 3-12
	{1000.6624,-1037.6707,30.6858}, // sweeper 3-13
	{960.9890,-1084.3650,24.3272 }, // sweeper 3-14
	{936.4205,-1138.6014,23.3970 }, // sweeper 3-15
	{796.1860,-1151.0474,23.6818 }, // sweeper 3-16
	{789.6367,-1316.4990,13.1079 }, // sweeper 3-17
	{666.1234,-1317.5170,13.1689 }, // sweeper 3-18
	{625.0825,-1354.9442,13.1191 }, // sweeper 3-19
	{681.1774,-1407.0273,13.1309 }, // sweeper 3-20
	{793.8995,-1421.1677,13.1079 }, // sweeper 3-21
	{771.8353,-1565.2166,13.1091 }, // sweeper 3-22
	{815.6641,-1599.2319,13.1079 }, // sweeper 3-23
	{862.7750,-1590.8809,13.1079 }, // sweeper 3-24
	{950.2061,-1574.3185,13.1080 }, // sweeper 3-25
	{1119.7479,-1574.2167,13.1240}, // sweeper 3-26
	{1291.9247,-1578.6278,13.1079}, // sweeper 3-27
	{1294.2993,-1721.1489,13.1152}, // sweeper 3-28
	{1317.1959,-1853.5016,13.1079}, // sweeper 3-29
	{1452.7085,-1875.2911,13.1157}, // sweeper 3-30
	{1580.1136,-1874.8521,13.1079}, // sweeper 3-31
	{1691.5570,-1832.3088,13.1079}, // sweeper 3-32
	{1692.1498,-1710.9954,13.1079}, // sweeper 3-33
	{1684.8314,-1590.8845,13.1074}, // sweeper 3-34
	{1661.8778,-1552.8276,13.1079}, // sweeper 3-35
	{1688.8785,-1549.1486,13.1079} // sweeper stop
};


// SAMP callback
hook OnGameModeInit()
{
	CreateDynamicMapIcon(1700.1438,-1543.4144,13.3828, 56, -1, -1, 0, -1, _, MAPICON_GLOBAL); //Map Icon
}

hook OnPlayerConnect(playerid)
{
	StopPlayerWorkInSweeper(playerid);
	sweeperRoute[playerid] = 0;
	currentSRoute[playerid] = 0;
}

hook OnPlayerDisconnectEx(playerid, reason)
{
	if(IsPlayerWorkInSweeper(playerid))
	{
		SetSweeperDelay(playerid, JobConfig_GetExitDelay(SIDEJOB_SWEEPER));
		DisablePlayerRaceCheckpoint(playerid);

		SetVehicleToRespawn(GetPlayerLastVehicle(playerid));
	}

	if(GetSweeperDelay(playerid)) {
		UpdateCharacterInt(playerid, "SweeperDelay", GetSweeperDelay(playerid));
	}
}

hook EnterSweeperVehicle(playerid, vehicleid)
{
	if(!IsAdminOnDuty(playerid) && !IsPlayerWorkInSweeper(playerid))
	{
		if (!JobConfig_IsJobEnabled(SIDEJOB_SWEEPER))
		{
			SendCustomMessage(playerid, "SWEEPER", "Sidejob ini di-nonaktifkan oleh server.");
			RemovePlayerFromVehicle(playerid);
			SetCameraBehindPlayer(playerid);
			return 1;
		}

		if(GetSweeperDelay(playerid) && GetPlayerVIPLevel(playerid) < 2)
		{
			SendCustomMessage(playerid, "SWEEPER", "Kamu tidak dapat bekerja sweeper sekarang, tunggu "YELLOW"%d menit "WHITE"untuk memulai kembali.", (GetSweeperDelay(playerid)/60));
			RemovePlayerFromVehicle(playerid);
			SetCameraBehindPlayer(playerid);
			return 1;
		}
		SetCameraBehindPlayer(playerid);
		Dialog_Show(playerid, SweeperJob, DIALOG_STYLE_MSGBOX, "Sweeper Sidejob", ""WHITE"Kamu menaiki kendaraan "YELLOW"Sweeper. "WHITE"Apakah kamu ingin memulai pekerjaan ini?.\nKamu akan di tugaskan untuk membersihkan jalan di kota "YELLOW"Los Santos.\n\n"WHITE"Pilik opsi "GREEN"\"Mulai\" "WHITE"untuk melakukan pekerjaan.", "Mulai", "Turun");
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && IsPlayerWorkInSweeper(playerid))
	{
		Dialog_Show(playerid, SweeperSidejobLeave, DIALOG_STYLE_MSGBOX, "Sweeper Sidejob", ""WHITE"Apakah kamu ingin turun dan menggagalkan pekerjaan ini?\nNantinya kamu harus menunggu selama "RED"10 menit "WHITE"untuk kembali bekerja!", "Lanjut", "Gagalkan");
	}
	return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
	if(hasSweeper[playerid])
	{
		if (IsPlayerWaypointRecentlyShow(playerid))
		{
			ResetRecentWaypoint(playerid);
			SetSweeperCheckpoin(playerid, 0);
			return 1;
		}

		currentSRoute[playerid] ++;

		if((sweeperRoute[playerid] == 1 && currentSRoute[playerid] == sizeof(arr_sweeperRoute1)) ||
			(sweeperRoute[playerid] == 2 && currentSRoute[playerid] == sizeof(arr_sweeperRoute2)) ||
			(sweeperRoute[playerid] == 3 && currentSRoute[playerid] == sizeof(arr_sweeperRoute3))
		)
		{
			StopPlayerWorkInSweeper(playerid);
			sweeperRoute[playerid] = 0;
			currentSRoute[playerid] = 0;

			DisablePlayerRaceCheckpoint(playerid);
			SetVehicleToRespawn(GetPlayerLastVehicle(playerid));

			new
				bonus,
				salary = JobConfig_GetBaseSalary(SIDEJOB_SWEEPER)
			;
			JobConfig_GetBonus(SIDEJOB_SWEEPER, bonus);

			SendCustomMessage(playerid, "SWEEPER","Kamu telah menyelesaikan pekerjaan, dan kamu mendapat upah "COL_GREEN"%s (+ bonus: %s) "WHITE"dari pekerjaan ini.", FormatNumber(salary), FormatNumber(bonus));
			AddPlayerSalary(playerid, salary + bonus, "Sweeper Sidejob");
			SetSweeperDelay(playerid, JobConfig_GetSuccessDelay(SIDEJOB_SWEEPER));
		}
		else if((sweeperRoute[playerid] == 1 && currentSRoute[playerid] == sizeof(arr_sweeperRoute1) - 1) ||
			(sweeperRoute[playerid] == 2 && currentSRoute[playerid] == sizeof(arr_sweeperRoute2) - 1) ||
			(sweeperRoute[playerid] == 3 && currentSRoute[playerid] == sizeof(arr_sweeperRoute3) - 1)
		)
		{
			SetSweeperCheckpoin(playerid, 1);
		}
		else SetSweeperCheckpoin(playerid, 0);
	}

	return 1;
}

// New Function
SetSweeperCheckpoin(playerid, mode)
{
	if(hasSweeper[playerid])
	{
		switch(sweeperRoute[playerid])
		{
			case 1: SetPlayerRaceCheckpoint(playerid, mode, arr_sweeperRoute1[currentSRoute[playerid]][0], 
				arr_sweeperRoute1[currentSRoute[playerid]][1], arr_sweeperRoute1[currentSRoute[playerid]][2], 
				mode ? (-1.00) : (arr_sweeperRoute1[currentSRoute[playerid] + 1][0]), mode ? (-1.00) : (arr_sweeperRoute1[currentSRoute[playerid] + 1][1]), 
				mode ? (-1.00) : (arr_sweeperRoute1[currentSRoute[playerid] + 1][2]), 3);

			case 2: SetPlayerRaceCheckpoint(playerid, mode, arr_sweeperRoute2[currentSRoute[playerid]][0], 
				arr_sweeperRoute2[currentSRoute[playerid]][1], arr_sweeperRoute2[currentSRoute[playerid]][2], 
				mode ? (-1.00) : (arr_sweeperRoute2[currentSRoute[playerid] + 1][0]), mode ? (-1.00) : (arr_sweeperRoute2[currentSRoute[playerid] + 1][1]), 
				mode ? (-1.00) : (arr_sweeperRoute2[currentSRoute[playerid] + 1][2]), 3);

			case 3: SetPlayerRaceCheckpoint(playerid, mode, arr_sweeperRoute3[currentSRoute[playerid]][0], 
				arr_sweeperRoute3[currentSRoute[playerid]][1], arr_sweeperRoute3[currentSRoute[playerid]][2], 
				mode ? (-1.00) : (arr_sweeperRoute3[currentSRoute[playerid] + 1][0]), mode ? (-1.00) : (arr_sweeperRoute3[currentSRoute[playerid] + 1][1]), 
				mode ? (-1.00) : (arr_sweeperRoute3[currentSRoute[playerid] + 1][2]), 3);
		}
	}
	return 1;
}

CancelSweeperProgress(playerid)
{
	if(IsPlayerWorkInSweeper(playerid))
	{
		StopPlayerWorkInSweeper(playerid);
		currentSRoute[playerid] = sweeperRoute[playerid] = 0;
		SetVehicleToRespawn(GetPlayerLastVehicle(playerid));
		DisablePlayerRaceCheckpoint(playerid);

		SetSweeperDelay(playerid, JobConfig_GetFailDelay(SIDEJOB_SWEEPER));
		SendCustomMessage(playerid, "SWEEPER","Kamu gagal dan tidak tuntas menyelesaikan pekerjaan ini.");
	}
	return 1;
}

// dialog respons
Dialog:SweeperJob(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Dialog_Show(playerid, SweeperJobRoute, DIALOG_STYLE_LIST, "Sweeper Route", "Route A\nRoute B\nRoute C", "Select", "Close");
	}
	else SendCustomMessage(playerid, "SWEEPER SIDEJOB", "Kamu menolak pekerjaan ini dan turun dari kendaraan."), RemovePlayerFromVehicle(playerid);
	return 1;
}
Dialog:SweeperJobRoute(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SetPlayerWorkInSweeper(playerid);

		currentSRoute[playerid] = 0;
		sweeperRoute[playerid] = listitem+1;

		SetEngineStatus(GetPlayerVehicleID(playerid), true);
		SetDoorStatus(GetPlayerVehicleID(playerid), true);

		SetSweeperCheckpoin(playerid, 0);
		SendCustomMessage(playerid, "SWEEPER SIDEJOB", "Ikuti checkpoint yang ada dimap, itu merupakan rute tujuan yang akan dilalui.");
	}
	else SendCustomMessage(playerid, "SWEEPER SIDEJOB", "Kamu menolak pekerjaan ini dan turun dari kendaraan."), RemovePlayerFromVehicle(playerid);
	return 1;
}	
Dialog:SweeperSidejobLeave(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		PutPlayerInVehicle(playerid, GetPlayerLastVehicle(playerid), 0);
		return SendCustomMessage(playerid, "SWEEPER SIDEJOB","Lanjutkan kembali pekerjaanmu, ikuti rute yang telah diberikan.");
	}
	else CancelSweeperProgress(playerid);
	return 1;
}


ptask Player_SweeperUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	if(GetSweeperDelay(playerid))
	{
		SetSweeperDelay(playerid, (GetSweeperDelay(playerid)-1));

		if(!GetSweeperDelay(playerid)) {
			UpdateCharacterInt(playerid, "SweeperDelay", 0);
			SendCustomMessage(playerid, "SWEEPER SIDEJOB", "Kamu bisa bekerja sweeper kembali!.");
		}
	}
	return 1;
}


CMD:resetsweeper(playerid, params[])
{
	new userid;

	if(CheckAdmin(playerid, 5))
		return PermissionError(playerid);
	
	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/resetsweeper [targetid]");

	SetSweeperDelay(userid, 0);
	SendServerMessage(playerid, "Kamu menghapus delay sweeper "RED"%s.", ReturnName(userid, 0));
	return 1;
}