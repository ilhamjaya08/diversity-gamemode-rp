//Public Garage  by Triton. Credits to him for creating the public garage.
//Credits to Stewart(Me) for making the public garage a dynamic system without putting it to the sql.
//---------------------------------------------------------------------------------------------------------------------------------//
//STEWART'S WORK

#define MAX_PG                      30

//GARAGE
enum pgInfo
{
	Float:pgPosX,
 	Float:pgPosY,
 	Float:pgPosZ,
 	pgPickupID,
 	Text3D: pgTextID,
};
new PublicGarageInfo[MAX_PG][pgInfo];

stock SavePublicGarages()
{
 	new
	pgFileStr[1024],
 	File: fHandle = fopen("PublicGarages.cfg", io_write);
	for(new iIndex; iIndex < MAX_PG; iIndex++)
	{
  		format(pgFileStr, sizeof(pgFileStr), "%f|%f|%f|%d\r\n",
  		PublicGarageInfo[iIndex][pgPosX],
  		PublicGarageInfo[iIndex][pgPosY],
  		PublicGarageInfo[iIndex][pgPosZ],
  		PublicGarageInfo[iIndex][pgPickupID]);
  		fwrite(fHandle, pgFileStr);
	}
	return fclose(fHandle);
}

stock LoadPublicGarages()
{
	if(!fexist("PublicGarages.cfg")) return 1;

	new string[128],
	pgFileStr[128],
	File: iFileHandle = fopen("PublicGarages.cfg", io_read),
	iIndex;

	while(iIndex < sizeof(PublicGarageInfo) && fread(iFileHandle, pgFileStr))
	{
		sscanf(pgFileStr, "p<|>fffii",
		PublicGarageInfo[iIndex][pgPosX],
		PublicGarageInfo[iIndex][pgPosY],
		PublicGarageInfo[iIndex][pgPosZ],
		PublicGarageInfo[iIndex][pgSize],
		PublicGarageInfo[iIndex][pgPickupID]
	);
		format(string, sizeof(string), "Public Garage\n{7CC200}ID"WHITE": %d\n"YELLOW"Usage: /vst or /despawncar\n\n"WHITE"Press Y to interact.", iIndex);
		if(PublicGarageInfo[iIndex][pgPosX] != 0.0)
		{
			PublicGarageInfo[iIndex][pgPickupID] = CreateDynamicPickup(1277, 23, PublicGarageInfo[iIndex][pgPosX], PublicGarageInfo[iIndex][pgPosY], PublicGarageInfo[iIndex][pgPosZ]);
			PublicGarageInfo[iIndex][pgTextID] = CreateDynamic3DTextLabel(string, COLOR_SYNTAX, PublicGarageInfo[iIndex][pgPosX], PublicGarageInfo[iIndex][pgPosY], PublicGarageInfo[iIndex][pgPosZ]+0.5,30.0);
		}
		++iIndex;
	}
	return fclose(iFileHandle);
}



CMD:vstorage(playerid, params[])
{
	for(new i = 0; i < MAX_PG; i ++)
	{
	    //if(IsPlayerInRangeOfPoint(playerid, 4.0, publicgarage[i][pgX], publicgarage[i][pgY], publicgarage[i][pgZ]))
	    if(IsPlayerInRangeOfPoint(playerid, 4.0, PublicGarageInfo[i][pgPosX],PublicGarageInfo[i][pgPosY], PublicGarageInfo[i][pgPosZ]))
	    {
			mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "SELECT id, modelid, pos_x, pos_y, pos_z, world FROM vehicles WHERE ownerid = %i", PlayerInfo[playerid][pID]);
			mysql_tquery(connectionID, queryBuffer, "OnQueryFinished", "ii", THREAD_CAR_STORAGE2, playerid);
			return 1;
		}
	}
	SCM(playerid, COLOR_SYNTAX, "You are not in range of any Public Garage.");
	return 1;
}

CMD:despawncar(playerid, params[])
{	
	new vehicleid = GetPlayerVehicleID(playerid);

	if(!vehicleid || GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	    return SCM(playerid, COLOR_SYNTAX, "You are not driving any vehicle of yours.");
	}
	if(!IsVehicleOwner(playerid, vehicleid) && PlayerInfo[playerid][pVehicleKeys] != vehicleid)
	{
	    return SCM(playerid, COLOR_SYNTAX, "You can't despawned this vehicle as it doesn't belong to you.");
	}

	for(new i = 0; i < MAX_PG; i ++)
	{
	    //if(IsPlayerInRangeOfPoint(playerid, 8.0, publicgarage[i][pgX], publicgarage[i][pgY], publicgarage[i][pgZ]))
		if(IsPlayerInRangeOfPoint(playerid, 4.0, PublicGarageInfo[i][pgPosX],PublicGarageInfo[i][pgPosY], PublicGarageInfo[i][pgPosZ]))
	    {
			DespawnVehicle(vehicleid);
			return 1;
		}
	}
	SCM(playerid, COLOR_SYNTAX, "You are not in range of any Public Garage.");
	return 1;
}



LoadPublicGarages();

if(IsPlayerInRangeOfPoint(playerid, 4.0, PublicGarageInfo[i][pgPosX], PublicGarageInfo[i][pgPosY], PublicGarageInfo[i][pgPosZ]))


SCM(playerid, SERVER_COLOR, "Public Garage:"WHITE" /gotopg, /pgedit, /pgdelete.");


CMD:gotopg(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new housenum;
		if(sscanf(params, "d", housenum)) return SendClientMessage(playerid, COLOR_SYNTAX, "USAGE: /gotopg [ID Public Garage]");
	
		SetPlayerPos(playerid,PublicGarageInfo[housenum][pgPosX],PublicGarageInfo[housenum][pgPosY],PublicGarageInfo[housenum][pgPosZ]);
		SetPlayerInterior(playerid, 0);
	}
	return 1;
}

CMD:pgedit(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] <= 4)
	{
		return SCM(playerid, COLOR_SYNTAX, "You are not authorized to use this command.");
	}

	new string[128], choice[32], pgid, amount;
	if(sscanf(params, "s[32]dd", choice, pgid, amount))
	{
		SendClientMessage(playerid, COLOR_SYNTAX, "USAGE: /pgedit [name] [Public Garage ID] [Amount(Put 1)]");
		SendClientMessage(playerid, COLOR_SYNTAX, "Name: location");
		return 1;
	}
	if(strcmp(choice, "location", true) == 0)
	{
		GetPlayerPos(playerid, PublicGarageInfo[pgid][pgPosX], PublicGarageInfo[pgid][pgPosY], PublicGarageInfo[pgid][pgPosZ]);
		SendClientMessage( playerid, COLOR_SYNTAX, "You have edit location Public Garage!" );
		DestroyPickup(PublicGarageInfo[pgid][pgPickupID]);
		SavePublicGarages();


		DestroyPickup(PublicGarageInfo[pgid][pgPickupID]);
		DestroyDynamic3DTextLabel(PublicGarageInfo[pgid][pgTextID]);
		format(string, sizeof(string), "Public Garage\n{7CC200}ID"WHITE": %d\n"YELLOW"Usage: /vst or /despawncar\n\n"WHITE"Press Y to interact.", pgid);
		PublicGarageInfo[pgid][pgTextID] = CreateDynamic3DTextLabel( string, COLOR_SYNTAX, PublicGarageInfo[pgid][pgPosX], PublicGarageInfo[pgid][pgPosY], PublicGarageInfo[pgid][pgPosZ]+0.5,10.0, .testlos = 1, .streamdistance = 10.0);
		PublicGarageInfo[pgid][pgPickupID] = CreatePickup(19134, 23, PublicGarageInfo[pgid][pgPosX], PublicGarageInfo[pgid][pgPosY], PublicGarageInfo[pgid][pgPosZ]);
	}
	/*else if(strcmp(choice, "size", true) == 0)
	{
		PublicGarageInfo[pgid][pgSize] = amount;
		SendClientMessage( playerid, COLOR_SYNTAX, "You have edit size Public Garage!" );
		SavePublicGarages();

		DestroyDynamic3DTextLabel(PublicGarageInfo[pgid][pgTextID]);
		format(string, sizeof(string), "(ID: %d) (Size: %d)\n{37CA00}Public Garage\nYou are not allowed to\n{FF0000}Damage{FFFFFF} Around here.", pgid, PublicGarageInfo[pgid][pgSize]);
  		PublicGarageInfo[pgid][pgTextID] = CreateDynamic3DTextLabel( string, COLOR_SYNTAX, PublicGarageInfo[pgid][pgPosX], PublicGarageInfo[pgid][pgPosY], PublicGarageInfo[pgid][pgPosZ]+0.5,10.0, .testlos = 1, .streamdistance = 10.0);
 	}*/
	SavePublicGarages();
	return 1;
}

CMD:pgdelete(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] <= 4)
 	{
  		return SCM(playerid, COLOR_SYNTAX, "You are not authorized to use this command.");
 	}
 	new h, string[128];
 	if(sscanf(params,"d",h)) return SendClientMessage(playerid, COLOR_SYNTAX,"USAGE: /pgdelete [Public Garage ID]");
 	if(!IsValidDynamicPickup(PublicGarageInfo[h][pgPickupID])) return SendClientMessage(playerid, COLOR_SYNTAX,"Wrong ID Public Garage.");
	PublicGarageInfo[h][pgPosX] = 0;
	PublicGarageInfo[h][pgPosY] = 0;
	PublicGarageInfo[h][pgPosZ] = 0;
	DestroyDynamicPickup(PublicGarageInfo[h][pgPickupID]);
	DestroyDynamic3DTextLabel(PublicGarageInfo[h][pgTextID]);
	SavePublicGarages();
	format(string, sizeof(string), "You have delete Public Garage (ID %d).", h);
	SendClientMessage(playerid, COLOR_SYNTAX, string);
	return 1;
}

//---------------------------------------------------------------------------------------------------------------------------------//
//TRITON'S WORK

//Thread Car Storage Section
//Search for THREAD_CAR_STORAGE
#define THREAD_CAR_STORAGE2          55

case THREAD_CAR_STORAGE2:
		{
		    if(!rows)
		    {
		        SCM(extraid, COLOR_SYNTAX, "You own no vehicles which you can spawn.");
		    }
		    else
		    {
		        new string[1024], vehicleid;

		        string = "#\tModel\tStatus\tLocation";

		        for(new i = 0; i < rows; i ++)
		        {
		            if((vehicleid = GetVehicleLinkedID(cache_get_field_content_int(i, "id"))) != INVALID_VEHICLE_ID)
		                format(string, sizeof(string), "%s\n%i\t%s\t"GREEN"Spawned"WHITE"\t%s", string, i + 1, vehicleNames[GetVehicleModel(vehicleid) - 400], GetVehicleZoneName(vehicleid));
					else
						format(string, sizeof(string), "%s\n%i\t%s\t"RED"Despawned"WHITE"\t%s", string, i + 1, vehicleNames[cache_get_field_content_int(i, "modelid") - 400], (cache_get_field_content_int(i, "world")) ? ("Garage") : (GetZoneName(cache_get_field_content_float(i, "pos_x"), cache_get_field_content_float(i, "pos_y"), cache_get_field_content_float(i, "pos_z"))));
				}

				ShowPlayerDialog(extraid, DIALOG_CARSTORAGE2, DIALOG_STYLE_TABLIST_HEADERS, "Choose a vehicle to spawn.", string, "Select", "Cancel");
		    }
		}

//Spawning car section
//Search for OnPlayerUseCarStorage and put this above

forward OnPlayerUseCarStorage2(playerid);
public OnPlayerUseCarStorage2(playerid)
{
    mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "SELECT * FROM vehicles WHERE id = %i AND ownerid = %i", cache_get_field_content_int(0, "id"), PlayerInfo[playerid][pID]);
	mysql_tquery(connectionID, queryBuffer, "OnPlayerSpawnVehicle2", "ii", playerid, false);
}

forward OnPlayerSpawnVehicle2(playerid, parked);
public OnPlayerSpawnVehicle2(playerid, parked)
{
	if(!cache_get_row_count(connectionID))
	{
	    SCM(playerid, COLOR_SYNTAX, "The slot specified contains no valid vehicle which you can spawn.");
	}
	else
	{
        for(new i = 0; i < MAX_VEHICLES; i ++)
	    {
	        if(IsValidVehicle(i) && VehicleInfo[i][vID] == cache_get_field_content_int(0, "id"))
	        {
	            return SCM(playerid, COLOR_SYNTAX, "This vehicle is spawned already. /findcar to track it.");
	    	}
	    }

	    new
		modelid = cache_get_field_content_int(0, "modelid"),
		color1 = cache_get_field_content_int(0, "color1"),
		color2 = cache_get_field_content_int(0, "color2"),
		Float:x, Float:y, Float:z, Float:a, vehicleid;
		
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
	
		vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, -1);

		if(vehicleid != INVALID_VEHICLE_ID)
		{
		    ResetVehicle(vehicleid);

		    cache_get_field_content(0, "owner", VehicleInfo[vehicleid][vOwner], connectionID, MAX_PLAYER_NAME);
		    cache_get_field_content(0, "plate", VehicleInfo[vehicleid][vPlate], connectionID, 32);

		    VehicleInfo[vehicleid][vID] = cache_get_field_content_int(0, "id");
		    VehicleInfo[vehicleid][vOwnerID] = cache_get_field_content_int(0, "ownerid");
		    VehicleInfo[vehicleid][vPrice] = cache_get_field_content_int(0, "price");
		    VehicleInfo[vehicleid][vTickets] = cache_get_field_content_int(0, "tickets");
		    VehicleInfo[vehicleid][vLocked] = cache_get_field_content_int(0, "locked");
		    VehicleInfo[vehicleid][vHealth] = cache_get_field_content_float(0, "health");
		    VehicleInfo[vehicleid][vPaintjob] = cache_get_field_content_int(0, "paintjob");
		    VehicleInfo[vehicleid][vInterior] = cache_get_field_content_int(0, "interior");
	        VehicleInfo[vehicleid][vWorld] = cache_get_field_content_int(0, "world");
	        VehicleInfo[vehicleid][vNeon] = cache_get_field_content_int(0, "neon");
	        VehicleInfo[vehicleid][vNeonEnabled] = cache_get_field_content_int(0, "neonenabled");
	        VehicleInfo[vehicleid][vTrunk] = cache_get_field_content_int(0, "trunk");
	        VehicleInfo[vehicleid][vMods][0] = cache_get_field_content_int(0, "mod_1");
	        VehicleInfo[vehicleid][vMods][1] = cache_get_field_content_int(0, "mod_2");
	        VehicleInfo[vehicleid][vMods][2] = cache_get_field_content_int(0, "mod_3");
	        VehicleInfo[vehicleid][vMods][3] = cache_get_field_content_int(0, "mod_4");
	        VehicleInfo[vehicleid][vMods][4] = cache_get_field_content_int(0, "mod_5");
	        VehicleInfo[vehicleid][vMods][5] = cache_get_field_content_int(0, "mod_6");
	        VehicleInfo[vehicleid][vMods][6] = cache_get_field_content_int(0, "mod_7");
	        VehicleInfo[vehicleid][vMods][7] = cache_get_field_content_int(0, "mod_8");
	        VehicleInfo[vehicleid][vMods][8] = cache_get_field_content_int(0, "mod_9");
	        VehicleInfo[vehicleid][vMods][9] = cache_get_field_content_int(0, "mod_10");
	        VehicleInfo[vehicleid][vMods][10] = cache_get_field_content_int(0, "mod_11");
	        VehicleInfo[vehicleid][vMods][11] = cache_get_field_content_int(0, "mod_12");
	        VehicleInfo[vehicleid][vMods][12] = cache_get_field_content_int(0, "mod_13");
	        VehicleInfo[vehicleid][vMods][13] = cache_get_field_content_int(0, "mod_14");
	        VehicleInfo[vehicleid][vCash] = cache_get_field_content_int(0, "cash");
	        VehicleInfo[vehicleid][vMaterials] = cache_get_field_content_int(0, "materials");
	        VehicleInfo[vehicleid][vPot] = cache_get_field_content_int(0, "pot");
	        VehicleInfo[vehicleid][vCrack] = cache_get_field_content_int(0, "crack");
	        VehicleInfo[vehicleid][vMeth] = cache_get_field_content_int(0, "meth");
	        VehicleInfo[vehicleid][vPainkillers] = cache_get_field_content_int(0, "painkillers");
	        VehicleInfo[vehicleid][vWeapons][0] = cache_get_field_content_int(0, "weapon_1");
	        VehicleInfo[vehicleid][vWeapons][1] = cache_get_field_content_int(0, "weapon_2");
	        VehicleInfo[vehicleid][vWeapons][2] = cache_get_field_content_int(0, "weapon_3");
            VehicleInfo[vehicleid][vHPAmmo] = cache_get_field_content_int(0, "hpammo");
            VehicleInfo[vehicleid][vPoisonAmmo] = cache_get_field_content_int(0, "poisonammo");
            VehicleInfo[vehicleid][vFMJAmmo] = cache_get_field_content_int(0, "fmjammo");
	        VehicleInfo[vehicleid][vGang] = -1;
	        VehicleInfo[vehicleid][vFactionType] = FACTION_NONE;
	        VehicleInfo[vehicleid][vJob] = JOB_NONE;
	        VehicleInfo[vehicleid][vRespawnDelay] = -1;
	        VehicleInfo[vehicleid][vModel] = modelid;
		    VehicleInfo[vehicleid][vPosX] = x;
		    VehicleInfo[vehicleid][vPosY] = y;
		    VehicleInfo[vehicleid][vPosZ] = z;
		    VehicleInfo[vehicleid][vPosA] = a;
		    VehicleInfo[vehicleid][vColor1] = color1;
		    VehicleInfo[vehicleid][vColor2] = color2;
		    VehicleInfo[vehicleid][vObjects][0] = INVALID_OBJECT_ID;
		    VehicleInfo[vehicleid][vObjects][1] = INVALID_OBJECT_ID;
		    VehicleInfo[vehicleid][vTimer] = -1;
		    VehicleInfo[vehicleid][vRegistered] = cache_get_field_content_int(0, "registered");

			vehicleFuel[vehicleid] = cache_get_field_content_int(0, "fuel");
			adminVehicle{vehicleid} = false;

			ReloadVehicle(vehicleid);
			SM(playerid, COLOR_AQUA, "You have spawned your %s{CCFFFF} in our public garage system {F7A763}", GetVehicleName(vehicleid));
			SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
			LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
			PutPlayerInVehicle(playerid, vehicleid, 0);
			SCM(playerid, COLOR_YELLOW, "Thank you for using the garage system");
	    }
	}

	return 1;
}

//DIALOGS
DIALOG_CARSTORAGE2,

case DIALOG_CARSTORAGE2:
		{
		    if(response)
		    {
		        mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "SELECT id FROM vehicles WHERE ownerid = %i LIMIT %i, 1", PlayerInfo[playerid][pID], listitem);
		        mysql_tquery(connectionID, queryBuffer, "OnPlayerUseCarStorage2", "i", playerid);
			}
		}

//---------------------------------------------------------------------------------------------------------------------------------//
//STEWART'S WORK
//Insert Pressing Y dialog
DIALOG_PUBLICGARAGE,

		case DIALOG_PUBLICGARAGE:
		{
		    ShowPlayerDialog(playerid, DIALOG_PUBLICGARAGE, DIALOG_STYLE_LIST, ""WHITE"Public Garage", "Spawning Car\nDespawning Car", "Select", "");
		}

	if(newkeys & KEY_YES)
	{
        for(new i = 0; i < MAX_PG; i ++)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 8.0, PublicGarageInfo[i][pgPosX], PublicGarageInfo[i][pgPosY], PublicGarageInfo[i][pgPosZ]))
		    {
		        ShowDialogToPlayer(playerid, DIALOG_PUBLICGARAGE);
			}
		}
	}

		case DIALOG_PUBLICGARAGE:
	    {
	        if(response)
	        {
	            if(listitem == 0)
	            {
	                return callcmd::vstorage(playerid, "\1");
				}
				if(listitem == 1)
				{
	                return callcmd::despawncar(playerid, "\1");
				}
			}
	    }

//endif