Fire_IsExists(index)
{
	if(Iter_Contains(Fire, index))
		return 1;
	
	return 0;
}

Fire_Create(model, Float:x, Float:y, Float:z, int, vw, Float:health = 1000.0)
{
	static
		index;

	if((index = Iter_Free(Fire)) != cellmin)
	{
		Iter_Add(Fire, index);

        FireData[index][fireModel] = model;
        FireData[index][fireInterior] = int;
        FireData[index][fireVirtualWorld] = vw;
        FireData[index][fireHealth] = health;
		FireData[index][firePosX] = x;
		FireData[index][firePosY] = y;
		FireData[index][firePosZ] = z-2;

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `fire`(`fireInt`, `fireWorld`) VALUES('%d', '%d');", FireData[index][fireInterior], FireData[index][fireVirtualWorld]), "OnFireCreated", "d", index);
		return index;
	}
	return -1;
}

Fire_Delete(index)
{
	if(Fire_IsExists(index))
	{
		Iter_Remove(Fire, index);

		mysql_tquery(g_iHandle, sprintf("DELETE FROM `fire` WHERE `fireID`='%d';", FireData[index][fireID]));

		if(IsValidDynamicArea(FireData[index][fireArea]))
			DestroyDynamicArea(FireData[index][fireArea]);

		if(IsValidDynamicObject(FireData[index][fireObject]))
			DestroyDynamicObject(FireData[index][fireObject]);

		new tmp_FireData[E_FIRE];
		FireData[index] = tmp_FireData;

		FireData[index][fireArea] = INVALID_STREAMER_ID;
		FireData[index][fireObject] = INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

Fire_Sync(index)
{
	if(Fire_IsExists(index))
	{
		if(IsValidDynamicObject(FireData[index][fireObject]))
		{
            Streamer_SetIntData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_MODEL_ID, FireData[index][fireModel]);

			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_X, FireData[index][firePosX]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_Y, FireData[index][firePosY]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_Z, FireData[index][firePosZ] - 0.4);

			Streamer_SetIntData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_INTERIOR_ID, FireData[index][fireInterior]);
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, FireData[index][fireObject], E_STREAMER_WORLD_ID, FireData[index][fireVirtualWorld]);

        }
		else 
        {
            FireData[index][fireObject] = CreateDynamicObject(FireData[index][fireModel], FireData[index][firePosX], FireData[index][firePosY], FireData[index][firePosZ] - 0.4, 0.0, 0.0, 0.0, FireData[index][fireVirtualWorld], FireData[index][fireInterior], -1, 50, 50);
        }

		if(IsValidDynamicArea(FireData[index][fireArea]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_X, FireData[index][firePosX]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_Y, FireData[index][firePosY]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_MIN_Z, FireData[index][firePosZ] - 1.0);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_MAX_Z, FireData[index][firePosZ] + 3.0);

			Streamer_SetIntData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_INTERIOR_ID, FireData[index][fireInterior]);
			Streamer_SetIntData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_WORLD_ID, FireData[index][fireVirtualWorld]);
		}
		else
		{			
			FireData[index][fireArea] = CreateDynamicCylinder(FireData[index][firePosX], FireData[index][firePosY], FireData[index][firePosZ] - 1.0, FireData[index][firePosZ] + 3.0, 20.0, FireData[index][fireVirtualWorld], FireData[index][fireInterior]);
			new Fire_Streamer_Info[2]; 

			Fire_Streamer_Info[0] = FIRE_AREA_INDEX;
			Fire_Streamer_Info[1] = index;
			Streamer_SetArrayData(STREAMER_TYPE_AREA, FireData[index][fireArea], E_STREAMER_EXTRA_ID, Fire_Streamer_Info);
		}
	}
	return 1;
}

CreateExplosionEx(Float:x, Float:y, Float:z)
{
    CreateExplosion(x, y, z, 13, 100.0);
    CreateExplosion(x, y, z, 13, 100.0);
    CreateExplosion(x, y, z+10.0, 13, 100.0);
    CreateExplosion(x+random(10)-5, y+random(10)-5, z+random(10)-5, 13, 100.0);
    return 1;
}

Fire_Nearest(playerid)
{
	foreach(new i : Fire) if(IsPlayerInRangeOfPoint(playerid, 10.0, FireData[i][firePosX], FireData[i][firePosY], FireData[i][firePosZ]))
	{
		if(GetPlayerInterior(playerid) == FireData[i][fireInterior] && GetPlayerVirtualWorld(playerid) == FireData[i][fireVirtualWorld])
			return i;
	}
	return -1;
}
Fire_Skin(skinid)
{
    if(skinid == 277 || skinid == 278 || skinid == 279)
        return 1;

    return 0;
}
SetBusinessOnFire(playerid, bizid)
{
    if(FactionMember_GetTypeCount(FACTION_MEDIC, true) > 3)
    { 
        new
            Float:x, Float:y, Float:z,
            int, vw
        ;
        GetPlayerPos(playerid, x, y, z);
        vw = GetPlayerVirtualWorld(playerid);
        int = GetPlayerInterior(playerid);
        CreateExplosionEx(x, y, z);
        CreateExplosionEx(BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2]);

        Fire_Create(18690, x, y, z, int, vw);
        Fire_Create(18690, BusinessData[bizid][bizPos][0], BusinessData[bizid][bizPos][1], BusinessData[bizid][bizPos][2], 0, 0);

        SendFactionMessageEx(FACTION_MEDIC, COLOR_HOSPITAL, ""COL_LIGHTBLUE"[ALARM] "WHITE"%s Business alarm is triggered, business is on fire", BusinessData[bizid][bizName]);
        SendFactionMessageEx(FACTION_POLICE, COLOR_HOSPITAL, ""COL_LIGHTBLUE"[ALARM] "WHITE"%s Business alarm is triggered, business is on fire", BusinessData[bizid][bizName]);
        SendServerMessage(playerid, "This business exploded and on fire while they cooking your food, alarm has been triggered!");
    }
    return 1;
}
IsValidFireVehicle(vehicleid)
{
    if(IsFourWheelVehicle(vehicleid) || IsABike(vehicleid) || IsSportBike(vehicleid))
        return 1;

    return 0;
}

IsPlayerInFirePoint(playerid, fireid, Float:range = 3.0)
{
    if(Fire_IsExists(fireid))
    {
        if(IsPlayerInRangeOfPoint(playerid, range, FireData[fireid][firePosX], FireData[fireid][firePosY], FireData[fireid][firePosZ]))
        {
            return 1;
        }
        return 0;
    }
    return 0;
}


SetHouseOnFire(playerid, houseid)
{
    if(FactionMember_GetTypeCount(FACTION_MEDIC, true) > 3)
    { 
        new Float:x, Float:y, Float:z,
            vw, int;

        GetPlayerPos(playerid, x, y, z);
        vw = GetPlayerVirtualWorld(playerid);
        int = GetPlayerInterior(playerid);
        CreateExplosionEx(x, y, z);
        CreateExplosionEx(HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2]);
        Fire_Create(18690, x, y, z, int, vw);
        Fire_Create(18690, HouseData[houseid][housePos][0], HouseData[houseid][housePos][1], HouseData[houseid][housePos][2], 0, 0);
    }
    return 1;
}



IsPlayerInFireTruck(playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(GetVehicleModel(vehicleid) == 407)
        {
            return 1;
        }
    }
    return 0;
}

ptask Player_FireExhausting[500](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if((keys & KEY_FIRE))
    { // if(IsPlayerInFirePoint(playerid, fireid, 3.0))
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
    return 1;
}
ptask Player_NearFire[1000](playerid)
{
    new fireid;
    if((fireid = Fire_GetInside(playerid)) != INVALID_FIRE_ID)
    {
        if(IsPlayerInFirePoint(playerid, fireid, 3.0))
        {
            new skinid = GetPlayerSkin(playerid);
            if(!Fire_Skin(skinid))
            {
                new Float:health = GetHealth(playerid);
                SetHealth(playerid, health-30);
            }
        }
    }
    return 1;
}