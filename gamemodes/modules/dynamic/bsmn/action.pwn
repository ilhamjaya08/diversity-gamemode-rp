#include <YSI\y_hooks>


hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, "SELECT * FROM `underground` ORDER BY `id` ASC LIMIT "#MAX_DYNAMIC_UNDERGROUND"", "Underground_Load", "");
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CROUCH && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		static index;
		if((index = Underground_Nearest(playerid)) != -1 && IsPlayerInDynamicCP(playerid, UndergroundData[index][enterCP]))
		{
			if(UndergroundData[index][underExitSpawn][0] == 0.0)
				return SendErrorMessage(playerid, "Basement ini belum dapat digunakan, silahkan kontak admin dengan perintah '/atalk'");

			SetCameraBehindPlayer(playerid);
			SetVehiclePos(GetPlayerVehicleID(playerid), -1745.0087, 982.0278, 17.5662);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), 270.7731);

			SetPlayerVirtualWorld(playerid, (index + 2));
    		SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), (index + 2));

    		foreach(new i : Player) if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && GetPlayerState(i) != PLAYER_STATE_DRIVER)
    		{
		        SetPlayerVirtualWorld(i, (index + 2));
		        SetCameraBehindPlayer(i);
		    }
		}
		else
		{
			//index = (GetPlayerVirtualWorld(playerid) - 2);
			index = Underground_Nearest(playerid);
			if(IsPlayerInDynamicCP(playerid, UndergroundData[index][exitCP]) && IsPlayerInRangeOfPoint(playerid, 3.0, -1745.4021,987.9285,17.6099))
			{
				SetCameraBehindPlayer(playerid);

				SetVehiclePos(GetPlayerVehicleID(playerid), UndergroundData[index][underExitSpawn][0], UndergroundData[index][underExitSpawn][1], UndergroundData[index][underExitSpawn][2]);
				SetVehicleZAngle(GetPlayerVehicleID(playerid), UndergroundData[index][underExitSpawn][3]);

				SetPlayerVirtualWorld(playerid, 0);
	    		SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);

	    		foreach(new i : Player) if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && GetPlayerState(i) != PLAYER_STATE_DRIVER)
	    		{
			        SetPlayerVirtualWorld(i, 0);
			        SetCameraBehindPlayer(i);
			    }
			}
		}
	}

	if(newkeys & KEY_CTRL_BACK && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		static index;
		if((index = Underground_Nearest(playerid)) != -1 && IsPlayerInDynamicCP(playerid, UndergroundData[index][enterCP]))
		{
			if(UndergroundData[index][underExitSpawn][0] == 0.0)
				return SendErrorMessage(playerid, "Basement ini belum dapat digunakan, silahkan kontak admin dengan perintah '/atalk'");

			SetCameraBehindPlayer(playerid);
			SetPlayerVirtualWorld(playerid, (index + 2));

			SetPlayerPos(playerid, -1745.0087, 982.0278, 17.5662);
			SetPlayerFacingAngle(playerid, 270.7731);
		}
		else
		{
			//index = (GetPlayerVirtualWorld(playerid) -2) < 0 ? 0 : (GetPlayerVirtualWorld(playerid) -2);
			index = Underground_NearestExit(playerid);
			if(index>=0)
			{
				if(IsPlayerInDynamicCP(playerid, UndergroundData[index][exitCP]) && IsPlayerInRangeOfPoint(playerid, 3.0, -1745.4021,987.9285,17.6099))
				{
					SetCameraBehindPlayer(playerid);
					SetPlayerVirtualWorld(playerid, 0);

					SetPlayerPos(playerid, UndergroundData[index][underExitSpawn][0], UndergroundData[index][underExitSpawn][1], UndergroundData[index][underExitSpawn][2]);
					SetPlayerFacingAngle(playerid, UndergroundData[index][underExitSpawn][3]);
				}		
			}	
		}
	}
	return 1;
}