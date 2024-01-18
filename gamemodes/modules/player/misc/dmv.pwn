#include <YSI\y_hooks>


// ================ [ DEFINED ] ================
#define DMV_SetTest(%0,%1)		dmv_test[%0]=%1

#define DMV_SetRoute(%0,%1)		dmv_route{%0}=%1
#define DMV_GetRoute(%0)		dmv_route{%0}


// ================ [ VARIABLES ] ================
new
	bool:dmv_test[MAX_PLAYERS] = {false, ...},
	dmv_route[MAX_PLAYERS] = {0, ...};


static const Float:DMV_Coordinate[][] = {
	{1142.0117,-1676.9792,13.6841}, 
	{1143.7555,-1709.1184,13.5170}, 
	{1065.9652,-1709.6593,13.1186}, 
	{1040.5461,-1704.0831,13.1235}, 
	{1039.8188,-1638.1232,13.1186}, 
	{1040.1050,-1569.8269,13.1218}, 
	{1065.1499,-1419.1586,13.1702}, 
	{1052.1555,-1322.2783,13.1184}, 
	{822.0837,-1318.9977,13.1765}, 
	{657.5653,-1316.6417,13.1426}, 
	{633.4929,-1249.5818,17.0570}, 
	{577.5402,-1226.1571,17.2999}, 
	{365.8348,-1368.2366,14.1330}, 
	{185.9884,-1500.9084,12.2462}, 
	{112.4876,-1624.5706,9.9423}, 
	{182.3329,-1737.8373,3.9295}, 
	{340.7973,-1753.8439,4.2749}, 
	{436.6214,-1775.4127,5.0283}, 
	{470.6350,-1725.9829,10.4374}, 
	{698.3499,-1766.9717,13.3775}, 
	{1044.1862,-1883.7677,12.8184}, 
	{1038.9327,-2285.6226,12.6808}, 
	{1355.9430,-2459.8623,7.3924}, 
	{1349.2047,-2325.1550,13.1187}, 
	{1426.9498,-2304.6165,13.1241}, 
	{1522.2389,-2271.8694,13.1187}, 
	{1476.5897,-2214.2866,13.1188}, 
	{1643.8970,-2197.0002,13.1109}, 
	{1776.6890,-2181.2539,13.3100}, 
	{1935.7046,-2169.1960,13.1187}, 
	{1964.1316,-2105.2598,13.1187}, 
	{1964.7518,-1979.5670,13.1227}, 
	{1963.6563,-1832.7150,13.1187}, 
	{1943.2583,-1749.7782,13.1186}, 
	{1807.9734,-1729.8053,13.1262}, 
	{1578.5804,-1729.6710,13.1185}, 
	{1439.3948,-1729.5431,13.1185}, 
	{1432.5405,-1633.7256,13.1185}, 
	{1411.3290,-1590.1372,13.0954}, 
	{1317.0244,-1550.3352,13.1263}, 
	{1355.0063,-1422.4025,13.1264}, 
	{1298.5055,-1397.7882,12.9391}, 
	{1193.6390,-1421.9626,12.9721}, 
	{1186.7512,-1569.5051,13.1125}, 
	{1147.9990,-1593.3301,13.3116}, 
	{1138.8018,-1676.4741,13.6392}
};


// ================ [ EVENTS ] ================
hook OnPlayerEnterRaceCP(playerid)
{
	if(DMV_GetTest(playerid))
	{
		DMV_SetRoute(playerid, DMV_GetRoute(playerid)+1);

		if(DMV_GetRoute(playerid) == sizeof(DMV_Coordinate))
		{
			DMV_SetTest(playerid, false);
			DMV_SetRoute(playerid, 0);

			GiveMoney(playerid, -75, ECONOMY_ADD_SUPPLY, "bought driver license");

            PlayerData[playerid][pDrivingLicense] = 1;
            PlayerData[playerid][pDrivingLicenseExpired] = (gettime()+2629746);

			DisablePlayerRaceCheckpoint(playerid);

			//SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			new index = RETURN_INVALID_VEHICLE_ID;
			if((index = Vehicle_ReturnID(GetPlayerVehicleID(playerid))) != RETURN_INVALID_VEHICLE_ID) {
				Vehicle_Respawn(index, false);
			}
            
            ShowPlayerFooter(playerid, "Kamu dibebankan pembayaran ~g~$75 ~w~untuk test!.", 3000, 1);
            SendServerMessage(playerid, "Sukses melakukan test, silahkan cek dengan perintah "YELLOW"(/licenses).");
		}
		else DMV_Checkpoint(playerid);
	}
}

hook OnPlayerDisconnectEx(playerid, reason)
{
	if(DMV_GetTest(playerid))
	{
		PlayerData[playerid][pDMVTime] = 900;

		//SetVehicleToRespawn(GetPlayerLastVehicle(playerid));
		new index = RETURN_INVALID_VEHICLE_ID;

		if((index = Vehicle_ReturnID(GetPlayerLastVehicle(playerid))) != RETURN_INVALID_VEHICLE_ID) {
			Vehicle_Respawn(index, false);
		}
	}
}

ptask Player_DMVTest[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

	if(DMV_GetTest(playerid))
	{
		if(GetVehicleSpeed(GetPlayerVehicleID(playerid)) > MAX_BUS_SPEED)    
		{
	        if(++PlayerData[playerid][pTestWarns] <= 3)
			{
				ShowPlayerFooter(playerid, sprintf("Hati-hati, batas kecapatan maksimal ~r~60 kmh ~w~(kesempatan ~y~%d/3~w~)", PlayerData[playerid][pTestWarns]), 3000, 1);
				SetVehicleSpeed(GetPlayerVehicleID(playerid), 20);
			}
	        else {
	        	//SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				new index = RETURN_INVALID_VEHICLE_ID;
	        	if((index = Vehicle_ReturnID(GetPlayerVehicleID(playerid))) != RETURN_INVALID_VEHICLE_ID) {
					Vehicle_Respawn(index, false);
				}
	        	DMV_Failed(playerid);
	        }
	    }
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(DMV_GetTest(playerid) && oldstate == PLAYER_STATE_DRIVER)
	{
		//SetVehicleToRespawn(GetPlayerLastVehicle(playerid));
		new index = RETURN_INVALID_VEHICLE_ID;

		if((index = Vehicle_ReturnID(GetPlayerLastVehicle(playerid))) != RETURN_INVALID_VEHICLE_ID) {
			Vehicle_Respawn(index, false);
		}
		DMV_Failed(playerid);
	}
}

hook OnPlayerVehicleDamage(playerid, vehicleid, Float:Damage)
{
	if(DMV_GetTest(playerid))
	{
		if(800 < ReturnVehicleHealth(vehicleid) < 1000) SendServerMessage(playerid, "Kendaraan terbentur, hati-hati gagal!");
		else
		{
			DMV_Failed(playerid);
			//SetVehicleToRespawn(GetPlayerVehicleID(playerid));

			new index = RETURN_INVALID_VEHICLE_ID;
			if((index = Vehicle_ReturnID(GetPlayerVehicleID(playerid))) != RETURN_INVALID_VEHICLE_ID) {
				Vehicle_Respawn(index, false);
			}
			SendServerMessage(playerid, "Gagal melakukan test, mobil dalam keadaan rusak parah (health kendaraan kurang dari 800)!");
		}
	}
}


// ================ [ FUNCTIONS ] ================
DMV_GetTest(playerid)
	return !!dmv_test[playerid];

DMV_Start(playerid)
{
	DMV_SetRoute(playerid, 0);
	DMV_Checkpoint(playerid);

	//1081.1647,-1719.6147,13.5469,359.2921
	PlayerData[playerid][pPos][0] = 1081.1647;
	PlayerData[playerid][pPos][1] = -1719.6147;
	PlayerData[playerid][pPos][2] = 13.5469;
	PlayerData[playerid][pPos][3] = 359.2921;

	ClearPlayerChat(playerid, 20);
	SendServerMessage(playerid, "Kerusakan kendaraan akan berakibat gagal pada test kali ini.");
	SendServerMessage(playerid, "Ikuti "RED"checkpoint merah "WHITE"digps, itu merupakan tujuan yang akan dijalani.");
	SendServerMessage(playerid, "(( Atur kecepatan kendaraan maksimal "RED"60 kmh "WHITE"atau gunakan perintah '"YELLOW"/limitspeed"WHITE"' ))");
	return 1;
}

DMV_Checkpoint(playerid)
{
	new id = DMV_GetRoute(playerid);

	if(id < (sizeof(DMV_Coordinate) - 1)) SetPlayerRaceCheckpoint(playerid, 0, DMV_Coordinate[id][0], DMV_Coordinate[id][1], DMV_Coordinate[id][2], DMV_Coordinate[id + 1][0], DMV_Coordinate[id + 1][1], DMV_Coordinate[id + 1][2], 6);
	else SetPlayerRaceCheckpoint(playerid, 1, DMV_Coordinate[id][0], DMV_Coordinate[id][1], DMV_Coordinate[id][2], 0, 0, 0, 6);
	return 1;
}

DMV_Failed(playerid)
{
	DMV_SetTest(playerid, false);
	DMV_SetRoute(playerid, 0);

	PlayerData[playerid][pTestWarns] = 0;

	DisablePlayerRaceCheckpoint(playerid);

	SetCameraBehindPlayer(playerid);
	SetPlayerPos(playerid, 1081.1647,-1719.6147,13.5469);
	SetPlayerFacingAngle(playerid, 359.2921);

	PlayerData[playerid][pDMVTime] = 900;
    ShowPlayerFooter(playerid, "Gagal melakukan test mengemudi, ulangi ~y~15 menit ~w~kemudian!.", 3000, 1);
    return 1;
}


// ================ [ COMMANDS ] ================
CMD:extendlicense(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2033.0439, -117.4885, 1035.1719))
        return SendErrorMessage(playerid, "Kamu tidak di DMV point.");

    if(!PlayerData[playerid][pDrivingLicense])
        return SendErrorMessage(playerid, "Kamu tidak memiliki surat izin mengemudi, buat terlebih dahulu (/drivingtest)!");

    if(PlayerData[playerid][pDrivingLicenseExpired])
        return SendErrorMessage(playerid, "Surat izin mengemudi masih berlaku!.");

    if(GetMoney(playerid) < 50)
        return SendErrorMessage(playerid, "Kamu butuh $50 untuk memperpanjang surat izin mengemudi.");

    GiveMoney(playerid, -50, ECONOMY_ADD_SUPPLY, "renew driver license");
    PlayerData[playerid][pDrivingLicenseExpired] = (gettime()+((24*3600)*30));
    SendCustomMessage(playerid, "LICENSE", "Sukses memperpanjang masa aktif "YELLOW"surat izin mengemudi "WHITE"hingga "GREEN"%s.", ConvertTimestamp(Timestamp:PlayerData[playerid][pDrivingLicenseExpired]));
    return 1;
}

CMD:drivingtest(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2033.0439, -117.4885, 1035.1719))
        return SendErrorMessage(playerid, "Kamu tidak di DMV point.");

    if(PlayerData[playerid][pDMVTime])
        return SendErrorMessage(playerid, "Tunggu %d menit untuk test ulang!.", (PlayerData[playerid][pDMVTime])/60);

    if(PlayerData[playerid][pDrivingLicense])
        return SendErrorMessage(playerid, "Kamu sudah memiliki surat izin mengemudi, perpanjang dengan perintah (/extendlicense)!");
    
    if(GetMoney(playerid) < 75)
        return SendErrorMessage(playerid, "Kamu butuh $50 untuk membuat surat izin mengemudi.");

    DMV_SetTest(playerid, true);
    SendServerMessage(playerid, "Silahkan kemudikan kendaraan diluar untuk memulai test!.");
    return 1;
}

CMD:forcedmv(playerid, params[])
{
    if(CheckAdmin(playerid, 2))
        return PermissionError(playerid);

    static userid;

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/forcedmv [playerid]");
    
    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "That player is disconnected.");

    PlayerData[userid][pDMVTime] = 0;

    SendServerMessage(userid, "Admin/Helper "RED"%s "WHITE"telah mereset delay untuk "YELLOW"test mengemudi "WHITE"anda.", ReturnAdminName(playerid));
    SendServerMessage(playerid, "Anda telah mereset delay untuk test mengemudi karakter "YELLOW"%s.", ReturnName(userid, 0));
    return 1;
}