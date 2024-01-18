/*

												******************************************
												*	Dropped system by: Agus Syahputra	 *
												*	Date creation: 21/07/2017 - 17:37    *
												*	Script name: droppedweapon.pwn       *
												******************************************

*/
#define MAX_DROP_WEAPON			200

enum dropEnums {
	dropID,

	dropBy[MAX_PLAYER_NAME],

	Float: dropX,
	Float: dropY,
	Float: dropZ,

	dropInt,
	dropVW,
	dropWeaponId,
	dropDurability,
	dropAmmo,
	dropExpired,

	dropObject,
	Text3D:dropLabel
};

new droppedWeapon[MAX_DROP_WEAPON][dropEnums],
	Iterator:DropIter<MAX_DROP_WEAPON>;

//Function:List ---------------------------------------------
Function:OnDroppedLoad()
{
	for (new i = 0; i < cache_num_rows(); i ++) if(i < MAX_DROP_WEAPON) {
		Iter_Add(DropIter, i);

		droppedWeapon[i][dropID] = cache_get_field_int(i, "ID");

		cache_get_field_content(i, "dropby", droppedWeapon[i][dropBy]);

		droppedWeapon[i][dropX] = cache_get_field_float(i, "x");
		droppedWeapon[i][dropY] = cache_get_field_float(i, "y");
		droppedWeapon[i][dropZ] = cache_get_field_float(i, "z");

		droppedWeapon[i][dropInt] = cache_get_field_int(i, "interior");
		droppedWeapon[i][dropVW] = cache_get_field_int(i, "vw");
		droppedWeapon[i][dropDurability] = cache_get_field_int(i, "durability");
		droppedWeapon[i][dropWeaponId] = cache_get_field_int(i, "weapon");
		droppedWeapon[i][dropAmmo] = cache_get_field_int(i, "ammo");
		droppedWeapon[i][dropExpired] = cache_get_field_int(i, "expired");

		Drop_Refresh(i);
	}
	printf("Loaded %d dropped weapon's", Iter_Count(DropIter));
	return 1;
}

Function:InsertDropIndex(index)
{
	droppedWeapon[index][dropID] = cache_insert_id();

	Drop_Save(index);
	return 1;
}

//Callback List ---------------------------------------------
Drop_Save(index)
{
	if(Iter_Contains(DropIter, index))
	{
		new query[400];

		strcat(query, sprintf("UPDATE droppedweapon SET x=%.2f, y=%.2f, z=%.2f, interior=%d, vw=%d, dropby='%s'",
			droppedWeapon[index][dropX],
			droppedWeapon[index][dropY],
			droppedWeapon[index][dropZ],
			droppedWeapon[index][dropInt],
			droppedWeapon[index][dropVW],
			droppedWeapon[index][dropBy]
		));
		strcat(query, sprintf(", durability=%d, weapon=%d, ammo=%d, expired=%d WHERE ID=%d",
			droppedWeapon[index][dropDurability],
			droppedWeapon[index][dropWeaponId],
			droppedWeapon[index][dropAmmo],
			droppedWeapon[index][dropExpired],
			droppedWeapon[index][dropID]
		));
		mysql_tquery(g_iHandle, query);
	}
	return 1;
}

Drop_Nearest(playerid)
{
    foreach(new i : DropIter) if(Iter_Contains(DropIter, i) && IsPlayerInRangeOfPoint(playerid, 2.5, droppedWeapon[i][dropX], droppedWeapon[i][dropY], droppedWeapon[i][dropZ]))
    {
        if(GetPlayerInterior(playerid) == droppedWeapon[i][dropInt] && GetPlayerVirtualWorld(playerid) == droppedWeapon[i][dropVW])
        return i;
    }
    return -1;
}

DropWeapon(playerid, weaponid, durability, Float:x, Float:y, Float:z)
{
	new index = Iter_Free(DropIter);

	Iter_Add(DropIter, index);

	format(droppedWeapon[index][dropBy], MAX_PLAYER_NAME, ReturnName(playerid, 0));

	droppedWeapon[index][dropX] = x;
	droppedWeapon[index][dropY] = y;
	droppedWeapon[index][dropZ] = z;

	droppedWeapon[index][dropWeaponId] = weaponid;
	droppedWeapon[index][dropDurability] = durability;
	droppedWeapon[index][dropExpired] = gettime();//(gettime()+((3600*24)*7));

	droppedWeapon[index][dropInt] = GetPlayerInterior(playerid);
	droppedWeapon[index][dropVW] = GetPlayerVirtualWorld(playerid);

	if(GetPlayerAmmoIndex(playerid)) {
		droppedWeapon[index][dropAmmo] = ammoData[playerid][GetPlayerAmmoIndex(playerid)][ammoAmount];
		RemoveAmmoItem(playerid, GetPlayerAmmoIndex(playerid));
	}
	else droppedWeapon[index][dropAmmo] = 0;

	RemoveWeaponInSlot(playerid, g_aWeaponSlots[weaponid]);
	RemoveWeaponItem(playerid, GetPlayerWeaponIndex(playerid));

	SelectWeapon[playerid] = 0;
	SelectAmmo[playerid] = 0;
	AmmoReload[playerid] = false;

	UpdateAmmo(playerid, "_");

	mysql_tquery(g_iHandle, sprintf("INSERT INTO droppedweapon SET durability=%d", durability), "InsertDropIndex", "d", index);

	Drop_Refresh(index);
	return index;
}

Drop_Refresh(index)
{
	if(Iter_Contains(DropIter, index))
	{
		if(IsValidDynamic3DTextLabel(droppedWeapon[index][dropLabel]))
			DestroyDynamic3DTextLabel(droppedWeapon[index][dropLabel]);

		if(IsValidDynamicObject(droppedWeapon[index][dropObject]))
			DestroyDynamicObject(droppedWeapon[index][dropObject]);

		droppedWeapon[index][dropObject] = CreateDynamicObject(GetWeaponModel(droppedWeapon[index][dropWeaponId]), droppedWeapon[index][dropX], droppedWeapon[index][dropY], droppedWeapon[index][dropZ], 93.7, 120.0, 120.0, droppedWeapon[index][dropVW], droppedWeapon[index][dropInt]);
		droppedWeapon[index][dropLabel] = CreateDynamic3DTextLabel(ReturnWeaponName(droppedWeapon[index][dropWeaponId]), 0xFFFFFFAA, droppedWeapon[index][dropX], droppedWeapon[index][dropY], droppedWeapon[index][dropZ], 2.5, _, _, _, droppedWeapon[index][dropVW], droppedWeapon[index][dropInt]);
	}
	return 1;
}

Drop_Remove(index)
{
	if(Iter_Contains(DropIter, index))
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `droppedweapon` WHERE ID=%d", droppedWeapon[index][dropID]));

		droppedWeapon[index][dropID] = droppedWeapon[index][dropVW] = droppedWeapon[index][dropInt] = 0;
		droppedWeapon[index][dropWeaponId] = droppedWeapon[index][dropAmmo] = droppedWeapon[index][dropDurability] = 0;

		droppedWeapon[index][dropBy] = EOS;

		DestroyDynamicObject(droppedWeapon[index][dropObject]);
		DestroyDynamic3DTextLabel(droppedWeapon[index][dropLabel]);

		Iter_Remove(DropIter, index);
	}
	return 1;
}

//Command List ---------------------------------------------

CMD:drop(playerid, params[])
{
    if(PlayerData[playerid][pInjured] || PlayerData[playerid][pHospital] != -1 || PlayerData[playerid][pCuffed] || !IsPlayerSpawned(playerid) || PlayerData[playerid][pJailTime] || IsPlayerInEvent(playerid) || PlayerData[playerid][pScore] < 2 || IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "You can't use this command now.");

    if(!GetPlayerWeaponIndex(playerid)) 
    	return SendErrorMessage(playerid, "Kamu tidak menggunakan senjata apapun.");
    
    static
        Float:x,
        Float:y,
        Float:z,
        Float:angle;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);

    x += 1 * floatsin(-angle, degrees);
    y += 1 * floatcos(-angle, degrees);


    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
    SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s takes out a %s and drops it on the floor.", ReturnName(playerid, 0, 1), ReturnWeaponName(weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]));
    Log_Save(E_LOG_DROP_WEAPON, sprintf("[%s] %s has dropped a %s.", ReturnDate(), ReturnName(playerid, 0), ReturnWeaponName(weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel])));

    DropWeapon(playerid, weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel], weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponDurability], x, y, z - 1);
    return 1;
}

CMD:pickup(playerid, params[])
{
	if(PlayerData[playerid][pInjured] || PlayerData[playerid][pHospital] != -1 || PlayerData[playerid][pCuffed] || !IsPlayerSpawned(playerid) || PlayerData[playerid][pJailTime] || IsPlayerInEvent(playerid) || PlayerData[playerid][pScore] < 2 || IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "You can't use this command now.");

	static
		index = -1;

	if((index = Drop_Nearest(playerid)) != -1)
	{
		AddWeaponItem(playerid, droppedWeapon[index][dropWeaponId], droppedWeapon[index][dropDurability]);
		SendCustomMessage(playerid, "WEAPON", "Kamu menemukan %s dengan %d durability.", ReturnWeaponName(droppedWeapon[index][dropWeaponId]), droppedWeapon[index][dropDurability]);

		if(droppedWeapon[index][dropAmmo]){
			AddAmmoItem(playerid, droppedWeapon[index][dropWeaponId], droppedWeapon[index][dropAmmo]);
			SendCustomMessage(playerid, "WEAPON", "Kamu juga mendapatkan Magazine %s dengan %d amunisi.", ReturnWeaponName(droppedWeapon[index][dropWeaponId]), droppedWeapon[index][dropAmmo]);
		}
		SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has picked up a %s.", ReturnName(playerid, 0, 1), ReturnWeaponName(droppedWeapon[index][dropWeaponId]));
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);

		Drop_Remove(index);
		return 1;
	}
	SendErrorMessage(playerid, "You're not in nearest dropped weapon.");
	return 1;
}

CMD:givegun(playerid, params[])
{
	if(!GetPlayerWeaponIndex(playerid)) 
    	return SendErrorMessage(playerid, "Kamu tidak menggunakan senjata apapun.");

    if(PlayerData[playerid][pInjured] || PlayerData[playerid][pHospital] != -1 || PlayerData[playerid][pCuffed] || !IsPlayerSpawned(playerid) || PlayerData[playerid][pJailTime] || IsPlayerInEvent(playerid) || PlayerData[playerid][pScore] < 2)
        return SendErrorMessage(playerid, "You can't use this command now.");

    new
        userid;

    if(sscanf(params, "u", userid)) 
    	return SendSyntaxMessage(playerid, "/givegun [playerid/PartOfName]");
    
    if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) 
    	return SendErrorMessage(playerid, "That player is disconnected or not near you.");
    
    if(userid == playerid) 
    	return SendErrorMessage(playerid, "You can't give yourself a weapon.");
    
    if(PlayerData[userid][pScore] < 2) 
    	return SendErrorMessage(playerid, "That player must be level 2 to hold a weapon.");

    AddWeaponItem(userid, weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel], weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponDurability]);

    if(SelectAmmo[playerid]) {
	    AddAmmoItem(userid, ammoData[playerid][GetPlayerAmmoIndex(playerid)][ammoWeapon], ammoData[playerid][GetPlayerAmmoIndex(playerid)][ammoAmount]);
	    RemoveAmmoItem(playerid, GetPlayerAmmoIndex(playerid));
    }

    ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
    ApplyAnimation(userid, "DEALER", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);

    SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has passed their %s to %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]), ReturnName(userid, 0));
    SendAdminMessage(X11_TOMATO_1, "AdmInfo: %s has passed their %s to %s.", ReturnName(playerid, 0), ReturnWeaponName(weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]), ReturnName(userid, 0));
    Log_Save(E_LOG_GIVE, sprintf("[%s] %s (%s) has given a %s to %s (%s).", ReturnDate(), ReturnName(playerid, 0), PlayerData[playerid][pIP], ReturnWeaponName(weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]), ReturnName(userid, 0), PlayerData[userid][pIP]));
    
    RemoveWeaponInSlot(playerid, g_aWeaponSlots[weaponData[playerid][GetPlayerWeaponIndex(playerid)][weaponModel]]);
    RemoveWeaponItem(playerid, GetPlayerWeaponIndex(playerid));

    SelectAmmo[playerid] = 0;
    SelectWeapon[playerid] = 0;

	Discord_Log(GIVEWEAPON_LOG, sprintf("[%s] %s give %s a %s with %d ammo.", ReturnDate(), ReturnName(playerid, 0), ReturnName(userid, 0), ReturnWeaponName(weaponid), ammo));
    return 1;
}

task dropWeaponUpdate[900000]()
{
	foreach(new index : DropIter) 
	{
		if((gettime()-droppedWeapon[index][dropExpired]) > (86400*3)) 
		{
			printf("Index: %d (%s) removed by system. dropped by %s", droppedWeapon[index][dropID], ReturnWeaponName(droppedWeapon[index][dropWeaponId]), droppedWeapon[index][dropBy]);

			Drop_Remove(index);
		}
	}
	return 1;
}