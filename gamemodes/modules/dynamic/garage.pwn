#define GARAGE_INTERIOR	4

/*Variable List*/
new const Float:garageInterior[][4] = {
	{1990.0426,-2640.0649,13.1878,358.4085}
};

/*Enums List*/


/*Function:List*/

Function:Garage_Load()
{
	if(!cache_num_rows()) return printf("[Dynamic Garage] There are no one garage loaded to the server.");

	for(new id = 0; id != cache_num_rows(); id++) if (id < MAX_GARAGE && !GarageData[id][garageExists])
	{
		new part[64];

		GarageData[id][garageExists] = true;

		cache_get_field_content(id, "Owner", GarageData[id][garageOwner], MAX_PLAYER_NAME);

		cache_get_field_content(id, "Location", part, sizeof(part));
		sscanf(part, "p<|>ffff", GarageData[id][garageLoc][0], GarageData[id][garageLoc][1], GarageData[id][garageLoc][2], GarageData[id][garageLoc][3]);

		cache_get_field_content(id, "LocationInt", part, sizeof(part));
		sscanf(part, "p<|>ffff", GarageData[id][garageLocInt][0], GarageData[id][garageLocInt][1], GarageData[id][garageLocInt][2], GarageData[id][garageLocInt][3]);

		GarageData[id][garageID] = cache_get_field_int(id, "ID");
		GarageData[id][garageOwnerId] = cache_get_field_int(id, "OwnerID");
		GarageData[id][garagePrice] = cache_get_field_int(id, "Price");
		GarageData[id][garageType] = cache_get_field_int(id, "Type");
		GarageData[id][garageLock] = cache_get_field_int(id, "Lock");
		GarageData[id][garageInside] = cache_get_field_int(id, "Inside");
		GarageData[id][garageHouseLink] = cache_get_field_int(id, "HouseLink");

		Garage_Sync(id);
	}
	return 1;
}

stock Garage_Save(id)
{
	new query[300];

	format(query, sizeof(query), "UPDATE `garage` SET `Owner`='%s', `Location`='%.02f|%.02f|%.02f|%.02f', `OwnerID`='%d', `Inside`='%d', `HouseLink`='%d'", 
		GarageData[id][garageOwner],
		GarageData[id][garageLoc][0],
		GarageData[id][garageLoc][1],
		GarageData[id][garageLoc][2],
		GarageData[id][garageLoc][3],
		GarageData[id][garageOwnerId],
		GarageData[id][garageInside],
		GarageData[id][garageHouseLink]
	);
	format(query, sizeof(query), "%s, `Price`='%d', `Type`='%d', `Lock`='%d', `LocationInt`='%.02f|%.02f|%.02f|%.02f' WHERE `ID` = '%d'", 
		query,
		GarageData[id][garagePrice],
		GarageData[id][garageType],
		GarageData[id][garageLock],
		GarageData[id][garageLocInt][0],
		GarageData[id][garageLocInt][1],
		GarageData[id][garageLocInt][2],
		GarageData[id][garageLocInt][3],
		GarageData[id][garageID]
	);
	return mysql_tquery(g_iHandle, query);
}

stock Garage_Sync(id)
{
	if (GarageData[id][garageExists]) 
	{
		new str[200];

		if(IsValidDynamicPickup(GarageData[id][garagePickup]))
			DestroyDynamicPickup(GarageData[id][garagePickup]);

		if(IsValidDynamic3DTextLabel(GarageData[id][garageLabel]))
			DestroyDynamic3DTextLabel(GarageData[id][garageLabel]);

		if(GarageData[id][garageOwnerId]) 
			if(GarageData[id][garageHouseLink]) format(str, sizeof(str), "%s's garage\n"WHITE"House Garage Id: "YELLOW"%d\n"WHITE"Vehicle Inside: {FFFF00}%d{FFFFFF}/{FFFF00}%d\n"WHITE"Type '{FFFF00}/garage"WHITE"' to use this.", GarageData[id][garageOwner], GetHouseByID(GarageData[id][garageHouseLink]), GarageData[id][garageInside], GarageData[id][garageType]);
			else format(str, sizeof(str), "%s's garage\n"WHITE"Vehicle Inside: {FFFF00}%d{FFFFFF}/{FFFF00}%d\n"WHITE"Type '{FFFF00}/garage"WHITE"' to use this.", GarageData[id][garageOwner], GarageData[id][garageInside], GarageData[id][garageType]);
		else {
			if(GarageData[id][garageHouseLink]) format(str, sizeof(str), "[Garage ID: %d]\n"WHITE"House Garage Id: "YELLOW"%d\n"WHITE"Vehicle Limit: {FFFF00}%d\n"WHITE"Type '{FFFF00}/garage"WHITE"' to use this.", id, GetHouseByID(GarageData[id][garageHouseLink]), GarageData[id][garageType]);
			else format(str, sizeof(str), "[Garage ID: %d]\n"WHITE"Garage Price: {00FF00}%s\n"WHITE"Vehicle Limit: {FFFF00}%d\n"WHITE"Type '{FFFF00}/garage"WHITE"' to use this.", id, FormatNumber(GarageData[id][garagePrice]), GarageData[id][garageType]);
		}
		GarageData[id][garageLabel] = CreateDynamic3DTextLabel(str, COLOR_CLIENT, GarageData[id][garageLoc][0], GarageData[id][garageLoc][1], GarageData[id][garageLoc][2]+0.5, 7);
		GarageData[id][garagePickup] = CreateDynamicPickup(1239, 23, GarageData[id][garageLoc][0], GarageData[id][garageLoc][1], GarageData[id][garageLoc][2], -1, -1, -1, 10);

		Garage_Save(id);
	}
	return 1;
}

stock Garage_FreeID()
{
	for(new id = 0; id != MAX_GARAGE; id++) if(!GarageData[id][garageExists]) {
		return id;
	}
	return -1;
}

stock Garage_Nearest(playerid)
{
	for(new id = 0; id != MAX_GARAGE; id++) if(GarageData[id][garageExists] && IsPlayerInRangeOfPoint(playerid, 4.0, GarageData[id][garageLoc][0], GarageData[id][garageLoc][1], GarageData[id][garageLoc][2])) {
		return id;
	}
	return -1;
}

stock Garage_Inside(playerid)
{
    if(PlayerData[playerid][pGarage] != -1)
    {
        for (new i = 0; i != MAX_GARAGE; i ++) if(GarageData[i][garageExists] && GarageData[i][garageID] == PlayerData[playerid][pGarage]) {
            return i;
        }
    }
    return -1;
}

stock Garage_IsOwner(playerid, id)
{
    if(!PlayerData[playerid][pLogged] || PlayerData[playerid][pID] == -1)
        return 0;

    if((GarageData[id][garageExists] && GarageData[id][garageOwnerId] != 0) && GarageData[id][garageOwnerId] == PlayerData[playerid][pID])
        return 1;

    return 0;
}

stock Garage_SQLID(id)
{
    for (new i = 0; i != MAX_GARAGE; i ++) if(GarageData[i][garageExists] && GarageData[i][garageID] == id) {
        return i;
    }

    return 0;
}


stock Garage_GetCount(playerid)
{
    new count = 0;
    for (new i = 0; i != MAX_GARAGE; i ++) if(GarageData[i][garageExists] && Garage_IsOwner(playerid, i)) {
        count++;
    }
    return count;
}

stock Garage_Destroy(id)
{
	mysql_tquery(g_iHandle, sprintf("DELETE FROM `garage` WHERE `ID`='%d'", GarageData[id][garageID]));
	mysql_tquery(g_iHandle, sprintf("UPDATE `player_vehicles` SET `Garage`= 0, Pos1 = '%.01f', Pos2 = '%.01f', Pos3 = '%.01f', Pos4 = '%.01f' WHERE Garage='%d'", 
		GarageData[id][garageLoc][0],  GarageData[id][garageLoc][1], GarageData[id][garageLoc][2], GarageData[id][garageLoc][3], 
		GarageData[id][garageID])
	);

	Garage_Reset(id);
	return 1;
}

stock Garage_Reset(id)
{
	if(!GarageData[id][garageExists])
		return 0;

	if(IsValidDynamicPickup(GarageData[id][garagePickup]))
		DestroyDynamicPickup(GarageData[id][garagePickup]);

	if(IsValidDynamic3DTextLabel(GarageData[id][garageLabel]))
		DestroyDynamic3DTextLabel(GarageData[id][garageLabel]);

	GarageData[id][garageOwner] = EOS;

	GarageData[id][garageExists] = false;
	GarageData[id][garageID] = 0;
	GarageData[id][garageType] = 0;
	GarageData[id][garagePrice] = 0;
	GarageData[id][garageInside] = 0;
	GarageData[id][garageOwnerId] = 0;
	GarageData[id][garageLock] = 1;
	GarageData[id][garageHouseLink] = 0;

	return 1;
}

stock Garage_Create(playerid, price, type)
{
	static
		id = -1;

	if((id = Garage_FreeID()) != -1) 
	{
		GetPlayerPos(playerid, GarageData[id][garageLoc][0], GarageData[id][garageLoc][1], GarageData[id][garageLoc][2]);
		GetPlayerFacingAngle(playerid, GarageData[id][garageLoc][3]);

		GarageData[id][garageLocInt][0] = garageInterior[0][0];
		GarageData[id][garageLocInt][1] = garageInterior[0][1];
		GarageData[id][garageLocInt][2] = garageInterior[0][2];
		GarageData[id][garageLocInt][3] = garageInterior[0][3];

		GarageData[id][garageExists] = true;
		GarageData[id][garageType] = type;
		GarageData[id][garagePrice] = price;
		GarageData[id][garageInside] = 0;
		GarageData[id][garageOwnerId] = 0;
		GarageData[id][garageOwner] = EOS;
		GarageData[id][garageLock] = 1;
		GarageData[id][garageHouseLink] = 0;

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `garage` (`Price`) VALUES (%d)", GarageData[id][garagePrice]), "Garage_Created", "d", id);

		return id;
	} 
	return 1;
}

/*Function:other List*/
Function:Garage_Created(id)
{
	GarageData[id][garageID] = cache_insert_id();

	Garage_Sync(id);
	Garage_Save(id);
	return 1;
}

/*Command List Admin*/
CMD:creategarage(playerid, params[])
{
   	if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

	static
		price, type, id;

	if(sscanf(params, "dd", price, type)) return SendSyntaxMessage(playerid, "/creategarage [price] [type 1-3]");
	if(type < 1 || type > 3) return SendErrorMessage(playerid, "Invalid type id.");
	if(price < 1) return SendErrorMessage(playerid, "Price minimum is zero.");

	id = Garage_Create(playerid, price, type);

	if(id == -1)
		return SendErrorMessage(playerid, "The server has reached the limit for garage.");

    SendServerMessage(playerid, "You have successfully created garage ID: %d.", id);
	return 1;
}

CMD:destroygarage(playerid, params[])
{
   	if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

	static
		id;

	if(sscanf(params, "d", id)) return SendErrorMessage(playerid, "/destroygarage [id]");
	if(!GarageData[id][garageExists]) return SendErrorMessage(playerid, "Invalid garage id.");

	SendServerMessage(playerid, "You have successfully destroy garage ID: %d.", id);
	Garage_Destroy(id);
	return 1;
}

CMD:editgarage(playerid, params[])
{
   	if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

	new 
		string[128],
		id,
		category[10];

	if(sscanf(params, "ds[10]S()[128]", id, category, string)) return SendSyntaxMessage(playerid, "/editgarage [id] [location/price/type/lock/sell/houselink]");
	if(!GarageData[id][garageExists]) return SendErrorMessage(playerid, "Invalid garage id.");

	if(!strcmp(category, "location"))
	{
		GetPlayerPos(playerid, GarageData[id][garageLoc][0], GarageData[id][garageLoc][1], GarageData[id][garageLoc][2]);
		GetPlayerFacingAngle(playerid, GarageData[id][garageLoc][3]);

		Garage_Sync(id);

		SendServerMessage(playerid, "You have successfully edit location of garage id %d", id);
	}
	else if(!strcmp(category, "price"))
	{
		new price;

		if(sscanf(string, "d", price)) return SendSyntaxMessage(playerid, "/editgarage id price [value]");
		if(price < 1) return SendErrorMessage(playerid, "Price minimum is zero.");

		GarageData[id][garagePrice] = price;
		Garage_Sync(id);

		SendServerMessage(playerid, "You have successfully edit price of garage id %d to %s", id, FormatNumber(price));
	}
	else if(!strcmp(category, "type"))
	{
		new type;

		if(sscanf(string, "d", type)) return SendSyntaxMessage(playerid, "/editgarage id type [1-3]");
		if(type < 1 || type > 3) return SendErrorMessage(playerid, "Invalid type id.");

		GarageData[id][garageType] = type;
		Garage_Sync(id);

		SendServerMessage(playerid, "You have successfully edit type of garage id %d to %d", id, type);
	}
	else if(!strcmp(category, "lock"))
	{
		new lock;

		if(sscanf(string, "d", lock)) return SendSyntaxMessage(playerid, "/editgarage id lock [0/1]");
		if(lock < 0 || lock > 1) return SendErrorMessage(playerid, "Only 0 (unlock) or 1 (lock).");

		GarageData[id][garageLock] = lock;
		Garage_Sync(id);

		SendServerMessage(playerid, "You have successfully %s of garage id %d.", GarageData[id][garageLock] ? ("Lock") : ("Unlock"), id);
	}
	else if(!strcmp(category, "houselink"))
	{
		new houseid;

		if(sscanf(string, "d", houseid)) return SendSyntaxMessage(playerid, "/editgarage id houselink [houseid]");
		if(!HouseData[houseid][houseExists]) return SendErrorMessage(playerid, "Invalid house id.");

		GarageData[id][garageHouseLink] = HouseData[houseid][houseID];
		if(HouseData[houseid][houseOwner]) {
			GarageData[id][garageOwnerId] = HouseData[houseid][houseOwner];
			format(GarageData[id][garageOwner], MAX_PLAYER_NAME, HouseData[houseid][houseOwnerName]);
		}

		Garage_Sync(id);

		SendServerMessage(playerid, "You have successfully linked this garage to house id %d.", houseid);
	}
	else if(!strcmp(category, "sell"))
	{
		if (!GarageData[id][garageOwnerId]) return SendErrorMessage(playerid, "This garage is for sale!.");
		if (GarageData[id][garageHouseLink]) return SendErrorMessage(playerid, "This garage linked to houseid!.");

		mysql_tquery(g_iHandle, sprintf("UPDATE `player_vehicles` SET `Garage`= 0, Pos1 = '%.01f', Pos2 = '%.01f', Pos3 = '%.01f', Pos4 = '%.01f' WHERE Garage='%d'", 
			GarageData[id][garageLoc][0],  GarageData[id][garageLoc][1], GarageData[id][garageLoc][2], GarageData[id][garageLoc][3], 
			GarageData[id][garageID])
		);

		GarageData[id][garageOwnerId] = 0;
		GarageData[id][garageOwner] = EOS;
		GarageData[id][garageLock] = 1;
		GarageData[id][garageInside] = 0;
		Garage_Sync(id);
	}
	Garage_Save(id);
	return 1;
}

/*Command List Player*/
CMD:garage(playerid, params[])
{
	static 
		string[128],
		id = -1,
		category[10];

	if(sscanf(params, "s[10]S()[128]", category, string)) return SendSyntaxMessage(playerid, "/garage [buy/enter/exit/lock/sell/approve/abandon]");

	if(!strcmp(category, "buy"))
	{
		if((id = Garage_Nearest(playerid)) == -1) return SendErrorMessage(playerid, "You're not in nearest any garage.");
		if(GarageData[id][garageOwnerId]) return SendErrorMessage(playerid, "This garage owned by someone.");
		if(Garage_GetCount(playerid) >= 2) return SendErrorMessage(playerid, "You have two garage now!.");
		if(GetMoney(playerid) < GarageData[id][garagePrice]) return SendErrorMessage(playerid, "You dont have enough money to buy this garage.");
		if(GarageData[id][garageHouseLink]) return SendErrorMessage(playerid, "This garage linked to the house, buy house near this garage to owned this garage.");

		GarageData[id][garageOwnerId] = PlayerData[playerid][pID];
		format(GarageData[id][garageOwner], MAX_PLAYER_NAME, "%s", ReturnName(playerid, 0));
		GiveMoney(playerid, -GarageData[id][garagePrice], ECONOMY_ADD_SUPPLY, "bought garage");

		SendServerMessage(playerid, "You've bough this garage.");

		Garage_Sync(id);
	}
	else if(!strcmp(category, "enter"))
	{
		if((id = Garage_Nearest(playerid)) == -1) return SendErrorMessage(playerid, "You're not in nearest any garage.");
		if(GarageData[id][garageLock]) return GameTextForPlayer(playerid, "~r~Locked", 1500, 1);
		if(IsPlayerInAnyVehicle(playerid))
		{
			static 
				vehicleid = -1;

			if((vehicleid = Vehicle_GetID(GetPlayerVehicleID(playerid))) != -1)
			{
				if(!Vehicle_IsOwner(playerid, vehicleid)) return SendErrorMessage(playerid, "This is not your vehicle.");
				if(!Garage_IsOwner(playerid, id)) return SendErrorMessage(playerid, "This garage isn't owned by you.");
				if(IsAPlane(GetPlayerVehicleID(playerid)) || IsAHelicopter(GetPlayerVehicleID(playerid)) || IsLoadableVehicle(GetPlayerVehicleID(playerid))) return SendErrorMessage(playerid, "Can't loaded this vehicle.");
				if(GarageData[id][garageInside] >= GarageData[id][garageType]) return SendErrorMessage(playerid, "Can't put more vehicle to this garage.");

				GarageData[id][garageInside] ++;

				VehicleData[vehicleid][cInt] = GARAGE_INTERIOR+GarageData[id][garageType];
				VehicleData[vehicleid][cVw] = GarageData[id][garageID]+1000;

				SetVehiclePos(VehicleData[vehicleid][cVehicle], GarageData[id][garageLocInt][0], GarageData[id][garageLocInt][1], GarageData[id][garageLocInt][2]);
				SetVehicleZAngle(VehicleData[vehicleid][cVehicle], GarageData[id][garageLocInt][3]);

				LinkVehicleToInterior(VehicleData[vehicleid][cVehicle], GARAGE_INTERIOR+GarageData[id][garageType]);
				SetVehicleVirtualWorld(VehicleData[vehicleid][cVehicle], VehicleData[vehicleid][cVw]);

				SetPlayerInterior(playerid, GARAGE_INTERIOR+GarageData[id][garageType]);
				SetPlayerVirtualWorld(playerid, GarageData[id][garageID]+1000);

				Vehicle_Save(vehicleid);
				Garage_Sync(id);

				PlayerData[playerid][pGarage] = GarageData[id][garageID];
				SetCameraBehindPlayer(playerid);

				SetPlayerWeather(playerid, 8);
				SetPlayerTime(playerid, 20, 0);
			}
			else SendErrorMessage(playerid, "This vehicle not owned by you, can't put to this garage.");
		}
		else 
		{
			SetPlayerPosEx(playerid, GarageData[id][garageLocInt][0], GarageData[id][garageLocInt][1], GarageData[id][garageLocInt][2]), SetPlayerFacingAngle(playerid, GarageData[id][garageLocInt][3]);
			SetPlayerInterior(playerid, GARAGE_INTERIOR+GarageData[id][garageType]);
			SetPlayerVirtualWorld(playerid, GarageData[id][garageID]+1000);
			PlayerData[playerid][pGarage] = GarageData[id][garageID];
			SetCameraBehindPlayer(playerid);
		}
	}
	else if(!strcmp(category, "sell"))
	{
		if((id = Garage_Nearest(playerid)) == -1) return SendErrorMessage(playerid, "You're not in nearest any garage.");
		if(!Garage_IsOwner(playerid, id)) return SendErrorMessage(playerid, "This garage isn't owned by you.");

		new 
			userid,
			price;

		if(GarageData[id][garageHouseLink]) 
			return SendErrorMessage(playerid, "This garage can't sell by yourself, sell your house to sell this garage too.");
		
		if(GarageData[id][garageInside]) 
			return SendErrorMessage(playerid, "Take out all vehicle from this garage.");
		
		if(sscanf(string, "dd", userid, price)) 
			return SendSyntaxMessage(playerid, "/garage sell [userid] [price]");
		
		if(userid == playerid) 
			return SendErrorMessage(playerid, "This garage owned by you!.");
		
		if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) 
			return SendErrorMessage(playerid, "That player is disconnected or not near you.");
		
		if(Garage_GetCount(userid) >= 2) 
			return SendErrorMessage(playerid, "That player have two garage now!.");
		
		if(price < 0) 
			return SendErrorMessage(playerid, "Price can't under 0.");

		PlayerData[userid][pGarageSeller] = playerid;
        PlayerData[userid][pGarageOffered] = id;
        PlayerData[userid][pGarageValue] = price;

        SendServerMessage(playerid, "You have requested %s to purchase your garage (%s).", ReturnName(userid, 0), FormatNumber(price));
        SendServerMessage(userid, "%s has offered you their garage for %s (type \"/garage approve\" to accept).", ReturnName(playerid, 0), FormatNumber(price));
	}
	else if(!strcmp(category, "abandon"))
	{
		if((id = Garage_Nearest(playerid)) == -1) return SendErrorMessage(playerid, "You're not in nearest any garage.");
		if(!Garage_IsOwner(playerid, id)) return SendErrorMessage(playerid, "This garage isn't owned by you.");
		if(GarageData[id][garageHouseLink]) return SendErrorMessage(playerid, "Can't abandon this garage, this garage linked to other house id.");

		new 
			confirm[8];

		if(GarageData[id][garageInside]) return SendErrorMessage(playerid, "Take out all vehicle from this garage.");
		if(sscanf(string, "s[8]", confirm)) return SendSyntaxMessage(playerid, "/garage abandon 'confirm'");

		GarageData[id][garageOwnerId] = 0;
		Garage_Sync(id);

		SendServerMessage(playerid, "You have abandoned your garage.");
        Log_Save(E_LOG_GARAGE, sprintf("[%s] %s has abandoned garage ID: %d.", ReturnDate(), ReturnName(playerid), id));
	}
	else if(!strcmp(category, "approve"))
	{
		if(PlayerData[playerid][pGarageSeller] == INVALID_PLAYER_ID) return SendErrorMessage(playerid, "No one sell garage for you.");

		new
            sellerid = PlayerData[playerid][pGarageSeller],
            garageid = PlayerData[playerid][pGarageOffered],
            price = PlayerData[playerid][pGarageValue];

        if(!IsPlayerNearPlayer(playerid, sellerid, 6.0)) return SendErrorMessage(playerid, "You are not near that player.");
        if(GetMoney(playerid) < price) return SendErrorMessage(playerid, "You have insufficient funds to purchase this garage.");
        if(Garage_Nearest(playerid) != garageid) return SendErrorMessage(playerid, "You must be near the garage to purchase it.");
        if(!Garage_IsOwner(sellerid, garageid)) return SendErrorMessage(playerid, "This garage offer is no longer valid.");

        SendServerMessage(playerid, "You have successfully purchased %s's garage for %s.", ReturnName(sellerid, 0), FormatNumber(price));
        SendServerMessage(sellerid, "%s has successfully purchased your garage for %s.", ReturnName(playerid, 0), FormatNumber(price));

        format(GarageData[garageid][garageOwner], MAX_PLAYER_NAME, ReturnName(playerid, 0));
        GarageData[garageid][garageOwnerId] = GetPlayerSQLID(playerid);

        Garage_Sync(garageid);

        GiveMoney(playerid, -price);
        GiveMoney(sellerid, price);

        Log_Save(E_LOG_OFFER, sprintf("[%s] %s (%s) has sold a garage to %s (%s) for %s.", ReturnDate(), ReturnName(playerid, 0), AccountData[playerid][pIP], ReturnName(sellerid, 0), AccountData[sellerid][pIP], FormatNumber(price)));

        PlayerData[playerid][pGarageSeller] = INVALID_PLAYER_ID;
        PlayerData[playerid][pGarageOffered] = -1;
        PlayerData[playerid][pGarageValue] = 0;
	}
	else if(!strcmp(category, "lock"))
	{
		if((id = (Garage_Inside(playerid) == -1) ? (Garage_Nearest(playerid)) : (Garage_Inside(playerid))) != -1 && Garage_IsOwner(playerid, id))
		{
			if(!GarageData[id][garageLock]) GarageData[id][garageLock] = true;
			else GarageData[id][garageLock] = false;

			SendServerMessage(playerid, "You have %s this garage.", GarageData[id][garageLock] ? ("Lock") : ("Unlock"));
			Garage_Sync(id);
			return 1;
		}
		SendErrorMessage(playerid, "You're not inside/outside your garage.");
	}
	else if(!strcmp(category, "exit"))
	{
		if((id = Garage_Inside(playerid)) != -1 && IsPlayerInRangeOfPoint(playerid, 4, GarageData[id][garageLocInt][0], GarageData[id][garageLocInt][1], GarageData[id][garageLocInt][2]))
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "You must in driver to enter this garage.");

				static 
					vehicleid = -1;

				if((vehicleid = Vehicle_GetID(GetPlayerVehicleID(playerid))) != -1)
				{
					if(!Vehicle_IsOwner(playerid, vehicleid)) return SendErrorMessage(playerid, "This is not your vehicle.");
					if(!Garage_IsOwner(playerid, id)) return SendErrorMessage(playerid, "This garage isn't owned by you.");

					VehicleData[vehicleid][cGarage] = 0;
					GarageData[id][garageInside] --;

					VehicleData[vehicleid][cInt] = 0;
					VehicleData[vehicleid][cVw] = 0;

					SetVehiclePos(VehicleData[vehicleid][cVehicle], GarageData[id][garageLoc][0], GarageData[id][garageLoc][1], GarageData[id][garageLoc][2]);
					SetVehicleZAngle(VehicleData[vehicleid][cVehicle], GarageData[id][garageLoc][3]);

					LinkVehicleToInterior(VehicleData[vehicleid][cVehicle], 0);
					SetVehicleVirtualWorld(VehicleData[vehicleid][cVehicle], 0);

					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);

					Garage_Sync(id);

					PlayerData[playerid][pGarage] = -1;
					SetCameraBehindPlayer(playerid);
				}
			}
			else 
			{
				SetPlayerPosEx(playerid, GarageData[id][garageLoc][0], GarageData[id][garageLoc][1], GarageData[id][garageLoc][2]), SetPlayerFacingAngle(playerid, GarageData[id][garageLoc][3]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				PlayerData[playerid][pGarage] = -1;
				SetCameraBehindPlayer(playerid);
			}
			return 1;
		}
		SendErrorMessage(playerid, "You're not in nearest any garage.");
	}
	return 1;
}