#include <YSI\y_hooks>


// Callback
forward OnFireCreated(index);
public OnFireCreated(index)
{
	FireData[index][fireID] = cache_insert_id();

	Fire_Sync(index);
	// Fire_Save(index);
	return 1;
}

forward Fire_Load();
public Fire_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Fire, i);

			FireData[i][fireID] = cache_get_field_int(i, "fireID");
			FireData[i][fireModel] = cache_get_field_int(i, "fireModel");

            FireData[i][fireInterior] = cache_get_field_int(i, "fireInt");
            FireData[i][fireVirtualWorld] = cache_get_field_int(i, "fireWorld");
            FireData[i][fireHealth] = cache_get_field_float(i, "fireHealth");

            FireData[i][firePosX] = cache_get_field_float(i, "fireX");
            FireData[i][firePosY] = cache_get_field_float(i, "fireY");
            FireData[i][firePosZ] = cache_get_field_float(i, "fireZ");

			Fire_Sync(i);
		}
		printf("*** Loaded %d Active Fire's", cache_num_rows());
	}
	return 1;
}

// hook OnGameModeInitEx()
// {
// 	mysql_pquery(g_iHandle, "SELECT * FROM `fire` ORDER BY `fireID` ASC LIMIT "#MAX_DYNAMIC_FIRE";", "Fire_Load", "");
// }

hook OnPlayerConnect(playerid)
{
	Fire_SetInside(playerid, INVALID_FIRE_ID);
}


hook OnPlayerEnterDynArea(playerid, areaid)
{
	new Fire_Streamer_Info[2];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, Fire_Streamer_Info);

    if(Fire_Streamer_Info[0] == FIRE_AREA_INDEX)
    {
        new index = Fire_Streamer_Info[1];

        if(Fire_IsExists(index)) {
        	Fire_SetInside(playerid, index);
            PlayerPlaySound(playerid, 3401, 0.0, 0.0, 0.0);
        }
    }
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	new Fire_Streamer_Info[1];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, Fire_Streamer_Info);

    if(Fire_Streamer_Info[0] == FIRE_AREA_INDEX) {
    	Fire_SetInside(playerid, INVALID_FIRE_ID);
        PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
    }
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(HOLDING (KEY_FIRE))
    {
        new fireid = Fire_GetInside(playerid);
        if(fireid != INVALID_FIRE_ID)
        {
            if(GetPlayerWeapon(playerid) == 42 && IsPlayerInFirePoint(playerid, fireid, 5.0))
            {
                if(FireData[fireid][fireHealth] > 0) 
                {
                    FireData[fireid][fireHealth] -= 10.0;
                }
                else if(FireData[fireid][fireHealth] <= 0)
                {
                    FireData[fireid][fireHealth] = 0;
                    Fire_Delete(fireid);
                }
            }
            else if(IsPlayerInFireTruck(playerid) && IsPlayerInFirePoint(playerid, fireid, 15.0))
            {
                if(FireData[fireid][fireHealth] > 0) 
                {
                    FireData[fireid][fireHealth] -= 10.0;
                }
                else if(FireData[fireid][fireHealth] <= 0)
                {
                    FireData[fireid][fireHealth] = 0;
                    Fire_Delete(fireid);
                }
            }
        }
    }
}

hook OnVehicleDeath(vehicleid, killerid)
{
    new 
        index,
        Float:vx,
        Float:vy,
        Float:vz,
        vw,
        int,
        Float:health
    ;
    if((index = Vehicle_ReturnID(vehicleid)) != -1)
    {
        GetVehicleHealth(VehicleData[index][vehVehicleID], health);
        if(health <= 300 && IsValidFireVehicle(VehicleData[index][vehVehicleID]))
        {
            if(FactionMember_GetTypeCount(FACTION_MEDIC, true) > 3)
            { 
                GetVehiclePos(VehicleData[index][vehVehicleID], vx, vy, vz);
                vw = GetVehicleVirtualWorld(VehicleData[index][vehVehicleID]);
                int = GetVehicleInterior(VehicleData[index][vehVehicleID]);
                Fire_Create(18690, vx, vy, vz, int, vw);
            }
        }
    }
}