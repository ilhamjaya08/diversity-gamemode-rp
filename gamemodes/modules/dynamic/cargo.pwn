/*	
	Script name: cargo.pwn
	Modify date: 21 June 2018 - 16:35.
	Release by: Agus Syahputra

	NOTE:
	-	

*/

#include <YSI\y_hooks>

// --
// Definition list
// --

#define MAX_CARGO			(200)
#define MAX_CARGO_LOADED	(3)

//Variable list
new ListedCargo[MAX_PLAYERS][MAX_CARGO_LOADED];

//Enum list

enum E_CARGO {
	//saved
	cargoID,
	cargoType,
	cargoVehicle,
	cargoExpired,

	Float:cargoX,
	Float:cargoY,
	Float:cargoZ,
	Float:cargoA,

	//temp
	cargoExists,
	cargoPickup,
	cargoObject,
	Text3D:cargoLabel
};

enum    _:E_CARGO_TYPE {
	CARGO_NONE = 0,
	CARGO_MART,
	CARGO_GUN,
	CARGO_CLOTHES,
	CARGO_MEAL,
	CARGO_DEALER,
	CARGO_FUEL,
	CARGO_FURNITURE,
	CARGO_ELECTRONICS
}

new CargoData[MAX_CARGO][E_CARGO];

hook OnPlayerDisconnect(playerid, reason)
{
	for(new i = 0; i != MAX_CARGO; i++) if (CargoData[i][cargoExists] && CargoData[i][cargoPickup] == PlayerData[playerid][pID]) {
		GetPlayerPos(playerid, CargoData[i][cargoX], CargoData[i][cargoY], CargoData[i][cargoZ]);
		GetPlayerFacingAngle(playerid, CargoData[i][cargoA]);

		CargoData[i][cargoPickup] = 0;
		Cargo_Sync(i);
	}
}

//Load list
Function:Cargo_Load()
{
	new
        rows,
        fields;

    cache_get_row_count(rows);
	cache_get_field_count(fields);

    for (new i = 0; i < rows; i ++) if(i < MAX_CARGO)
    {
        cache_get_field_content(i, "ID", CargoData[i][cargoID]);
        cache_get_field_content(i, "Type", CargoData[i][cargoType]);
        cache_get_field_content(i, "Vehicle", CargoData[i][cargoVehicle]);
        cache_get_field_content(i, "time", CargoData[i][cargoExpired]);

        CargoData[i][cargoPickup] = 0;

        CargoData[i][cargoX] = cache_get_field_float(i, "X");
        CargoData[i][cargoY] = cache_get_field_float(i, "Y");
        CargoData[i][cargoZ] = cache_get_field_float(i, "Z");
  		CargoData[i][cargoA] = cache_get_field_float(i, "A");

    	CargoData[i][cargoExists] = true;

        Cargo_Sync(i);
    }
    return 1;
}

//Save List
Function:Cargo_Save(i)
{
	if (!CargoData[i][cargoExists])
		return printf("[Cargo System] Can't save crate id %d", i), 0;

	new string[128];

	format(string, sizeof(string), "UPDATE cargo SET Type='%d', Vehicle='%d', X='%.2f', Y='%.2f', Z='%.2f', A='%.2f', time=%d WHERE ID='%d'", 
		CargoData[i][cargoType],
		CargoData[i][cargoVehicle],
		CargoData[i][cargoX],
		CargoData[i][cargoY],
		CargoData[i][cargoZ],
		CargoData[i][cargoA],
		CargoData[i][cargoExpired],
		CargoData[i][cargoID]
	);
	return mysql_tquery(g_iHandle, string);
}

//Sync function
stock Cargo_Sync(i)
{
	if (!CargoData[i][cargoExists])
		return printf("[Cargo System] Can't desync crate id %d", i), 0;

	if (IsValidDynamicObject(CargoData[i][cargoObject]))
		DestroyDynamicObject(CargoData[i][cargoObject]);

	if (IsValidDynamic3DTextLabel(CargoData[i][cargoLabel]))
		DestroyDynamic3DTextLabel(CargoData[i][cargoLabel]);

	if (!CargoData[i][cargoPickup] && !CargoData[i][cargoVehicle])
	{
		CargoData[i][cargoLabel] = CreateDynamic3DTextLabel(sprintf("%s", Cargo_TypeName(i)), 0xC0C0C0EE, CargoData[i][cargoX], CargoData[i][cargoY], CargoData[i][cargoZ], 3);
		CargoData[i][cargoObject] = CreateDynamicObject(1271, CargoData[i][cargoX], CargoData[i][cargoY], CargoData[i][cargoZ]-0.6, 0, 0, CargoData[i][cargoA], _, _, _, 40);
	}
	Cargo_Save(i);
	return 1;
}

//other function
stock Cargo_TypeName(id)
{
	new name[16];
	switch(CargoData[id][cargoType])
	{
		case CARGO_FUEL: name="fuel";
		case CARGO_MART: name="retail";
		case CARGO_CLOTHES: name="clothes";
		case CARGO_MEAL: name="food";
		case CARGO_FURNITURE: name="furniture";
		case CARGO_ELECTRONICS: name="electronics";
	}
	return name;
}

stock Cargo_TypeAmount(id, type=0, types=0)
{
	new amount, price;

//	#define C_TYPE types
	if(!types) {
		switch(CargoData[id][cargoType])
		{
			case CARGO_FUEL: amount=15, price=75;
			case CARGO_MART: amount=10, price=40;
			case CARGO_CLOTHES: amount=10, price=40;
			case CARGO_MEAL: amount=15, price=60;
			case CARGO_FURNITURE: amount=10, price=40;
			case CARGO_ELECTRONICS: amount=10, price=40;
		}
	}
	else {
		switch(types)
		{
			case CARGO_FUEL: amount=15, price=100;
			case CARGO_MART: amount=10, price=40;
			case CARGO_CLOTHES: amount=10, price=40;
			case CARGO_MEAL: amount=15, price=60;
			case CARGO_FURNITURE: amount=10, price=40;
			case CARGO_ELECTRONICS: amount=10, price=40;
		}
	}
	if (!type)
		return amount;
	else
		return price;
}

stock Cargo_Nearest(playerid, Float:range = 2.0)
{
    for(new i = 0; i != MAX_CARGO; i++) if(IsPlayerInRangeOfPoint(playerid, range, CargoData[i][cargoX], CargoData[i][cargoY], CargoData[i][cargoZ]) && !CargoData[i][cargoPickup] && !CargoData[i][cargoVehicle]) {
        return i;
    }
    return -1;
}

/*stock Cargo_GetCount(id)
{
    new count;

    for(new i = 0; i != MAX_CARGO; i++) if(CargoData[i][cargoVehicle] == VehicleData[id][cID]) {
        count++;
    }
    return count;
}*/

stock Cargo_Destroy(id)
{
	if (IsValidDynamicObject(CargoData[id][cargoObject])) DestroyDynamicObject(CargoData[id][cargoObject]);
	if (IsValidDynamic3DTextLabel(CargoData[id][cargoLabel])) DestroyDynamic3DTextLabel(CargoData[id][cargoLabel]);

	CargoData[id][cargoExists] = false;
	CargoData[id][cargoType] = CARGO_NONE;
	CargoData[id][cargoVehicle] = 0;
	CargoData[id][cargoPickup] = 0;

	CargoData[id][cargoObject] = INVALID_STREAMER_ID;
	CargoData[id][cargoLabel] = Text3D:INVALID_STREAMER_ID;


	mysql_tquery(g_iHandle, sprintf("DELETE FROM cargo WHERE ID='%d'", CargoData[id][cargoID]));
	CargoData[id][cargoID] = 0;
	return 1;
}

stock Cargo_FreeID()
{
	for(new i = 0; i != MAX_CARGO; i++) if (!CargoData[i][cargoExists]) {
		return i;
	}
	return -1;
}

stock Cargo_Create(playerid, type)
{
	new 
		id = Cargo_FreeID();

	if (id != -1) 
	{
		CargoData[id][cargoExists] = true;

		CargoData[id][cargoType] = type;
		CargoData[id][cargoVehicle] = 0;
		CargoData[id][cargoExpired] = gettime();
		CargoData[id][cargoPickup] = 0;

		static 
			Float:x, Float:y, Float:z, Float:angle;
				
		GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, angle);

	    x += 0.7 * floatsin(-angle, degrees);
	    y += 0.7 * floatcos(-angle, degrees);

		CargoData[id][cargoX] = x;
		CargoData[id][cargoY] = y;
		CargoData[id][cargoZ] = z;
		CargoData[id][cargoA] = angle;

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `cargo` (`Type`) VALUES(%d)", CargoData[id][cargoType]), "Cargo_Created", "d", id);
	}
	return id;
}

Function:Cargo_Created(id)
{
	CargoData[id][cargoID] = cache_insert_id();

	Cargo_Sync(id);
	return 1;
}

stock Cargo_Hold(playerid)
{
	for(new i = 0; i != MAX_CARGO; i++) if (CargoData[i][cargoPickup] == PlayerData[playerid][pID]) {
		return i;
	}	
	return -1;
}

stock Cargo_AnimPlay(playerid)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, JOB_SLOT))
		RemovePlayerAttachedObject(playerid, JOB_SLOT);

	SetPlayerAttachedObject(playerid, JOB_SLOT, 1271, 1,0.237980,0.473312,-0.066999, 1.099999,88.000007,-177.400085, 0.716000,0.572999,0.734000);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

stock Cargo_AnimStop(playerid)
{
	ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, JOB_SLOT);
	return 1;
}
//=============================================================================================================================================================

Dialog:CargoList(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = ListedCargo[playerid][listitem];
		CargoData[id][cargoVehicle] = 0;
		CargoData[id][cargoPickup] = PlayerData[playerid][pID];

		GetPlayerPos(playerid, CargoData[id][cargoX], CargoData[id][cargoY], CargoData[id][cargoZ]);
		GetPlayerFacingAngle(playerid, CargoData[id][cargoA]);

		Cargo_AnimPlay(playerid);

		SendServerMessage(playerid, "You've pick up cargo "YELLOW"%s "WHITE"from this vehicle.", Cargo_TypeName(id));
	}
	return 1;
}

CMD:cargo(playerid, params[])
{
	static
		opsi[16],
		string[128],
		id;

	if (PlayerData[playerid][pJob] != JOB_COURIER) return SendErrorMessage(playerid, "You're not a trucker.");
	if (sscanf(params, "s[16]S()[128]", opsi, string)) return SendSyntaxMessage(playerid, "/cargo [buy/sell/list/place/putdown/pickup]");

	if(!strcmp(opsi, "buy")) {
		new crate = CARGO_NONE;

		if (Cargo_Hold(playerid) != -1) return SendErrorMessage(playerid, "You're holding a cargo, putdown it first.");
		if (GetMoney(playerid) < Cargo_TypeAmount(crate)) return SendErrorMessage(playerid, "You don't have enough money.");

		if(IsPlayerInRangeOfPoint(playerid, 2.5, 2354.2861,-2288.2808,17.4219))	crate = 1;
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2255.6082,-2387.6851,17.4219)) crate = 3;
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2508.3826,-2205.7415,13.5469)) crate = 6;
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2615.5457,-2382.3250,13.6250)) crate = 4;
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2490.9121,-2468.5664,17.8828)) crate = 7;
		else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2445.1274,-2548.2874,17.9107)) crate = 8;
		else return SendErrorMessage(playerid, "You're not in any cargo factory.");



		id = Cargo_Create(playerid, crate);
		GiveMoney(playerid, -Cargo_TypeAmount(id, 1), ECONOMY_ADD_SUPPLY, "bought cargo");
		SendServerMessage(playerid, "You've buy "YELLOW"%s "WHITE"cargo for "COL_GREEN"%s.", Cargo_TypeName(id), FormatNumber(Cargo_TypeAmount(id, 1)));
		CargoData[id][cargoVehicle] = 0;
		CargoData[id][cargoPickup] = PlayerData[playerid][pID];
		Cargo_AnimPlay(playerid);
	}
	else if(!strcmp(opsi, "list")) {
		if((id = Vehicle_Nearest(playerid, 5.5)) != -1)
        {
            if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You must exit the vehicle first.");
            //if(!IsPlayerNearBoot(playerid, VehicleData[id][cVehicle])) return SendErrorMessage(playerid, "You're not near vehicle trunk.");
            //if(!IsLoadableVehicle(VehicleData[id][cVehicle])) return SendErrorMessage(playerid, "This is not loaded able vehicle.");
            if (Cargo_Hold(playerid) != -1) return SendErrorMessage(playerid, "You're holding a cargo, putdown it first.");

            new str[128], count = 0;

            format(str, sizeof(str), "#\tProduct\tpcs\n");
            /*for(new i = 0; i != MAX_CARGO; i++) if (CargoData[i][cargoVehicle] == VehicleData[id][cID]) {
            	format(str, sizeof(str), "%s{000000}%d\t"COL_LIGHTGREEN"%s\t%d\n", str, i, Cargo_TypeName(i), Cargo_TypeAmount(i));
            	ListedCargo[playerid][count++] = i;
            }*/
            if(!count) SendErrorMessage(playerid, "This vehicle not loaded any cargo.");
            else Dialog_Show(playerid, CargoList, DIALOG_STYLE_TABLIST_HEADERS, "Cargo List", str, "Pick Up", "Close");
            return 1;
        }
        SendErrorMessage(playerid, "You are not in range of any vehicle.");
	}
	else if(!strcmp(opsi, "place")) {
		if((id = Vehicle_Nearest(playerid, 5.5)) != -1)
        {
            if(IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You must exit the vehicle first.");
            if(!IsPlayerNearBoot(playerid, VehicleData[id][cVehicle])) return SendErrorMessage(playerid, "You're not near vehicle trunk.");
            if(!IsLoadableVehicle(VehicleData[id][cVehicle])) return SendErrorMessage(playerid, "This is not loaded able vehicle.");
            if(VehicleData[id][cLocked]) return SendErrorMessage(playerid, "The vehicle's is locked.");

            static 
            	i = -1;

            if ((i = Cargo_Hold(playerid)) != -1)
            {
            	if(Cargo_GetCount(id) >= MAX_CARGO_LOADED) return SendErrorMessage(playerid, "This vehicle reached limit to save a cargo (max %d).", MAX_CARGO_LOADED);

            	CargoData[i][cargoPickup] = 0;
            	CargoData[i][cargoVehicle] = VehicleData[id][cID];
            	CargoData[i][cargoExpired] = gettime();

            	Cargo_Sync(i);

            	Cargo_AnimStop(playerid);
            	SendServerMessage(playerid, "You have loaded "YELLOW"%s "WHITE"to this vehicle.", Cargo_TypeName(i));
            }
            else SendErrorMessage(playerid, "You are not holding a cargo.");
        }
        else SendErrorMessage(playerid, "This is static vehicle, can't put on this vehicle.");
	}
	else if(!strcmp(opsi, "putdown")) {
		if ((id = Cargo_Hold(playerid)) != -1) {
			if(Cargo_Nearest(playerid, 1.5) != -1) return SendErrorMessage(playerid, "Can't putdown in nearest other cargo."); 

			static 
				Float:x, Float:y, Float:z, Float:angle;

			GetPlayerPos(playerid, x, y, z);
	        GetPlayerFacingAngle(playerid, angle);

            x += 0.7 * floatsin(-angle, degrees);
            y += 0.7 * floatcos(-angle, degrees);

			CargoData[id][cargoPickup] = 0;
			CargoData[id][cargoX] = x;
			CargoData[id][cargoY] = y;
			CargoData[id][cargoZ] = z;
			CargoData[id][cargoA] = angle;

			CargoData[id][cargoExpired] = gettime();

			Cargo_Sync(id);

			Cargo_AnimStop(playerid);
			return 1;
		}
		SendErrorMessage(playerid, "You are not holding a cargo.");	
	}
	else if(!strcmp(opsi, "pickup")) {
		if((id = Cargo_Nearest(playerid)) != -1) {
			if (Cargo_Hold(playerid) != -1) return SendErrorMessage(playerid, "You're holding a cargo.");
			CargoData[id][cargoPickup] = PlayerData[playerid][pID];
			CargoData[id][cargoExpired] = gettime();
			
			SendServerMessage(playerid, "You've pick up "YELLOW"%s "WHITE"cargo.", Cargo_TypeName(id));
			Cargo_AnimPlay(playerid);
			Cargo_Sync(id);
			return 1;
		}
		SendErrorMessage(playerid, "You're not nearest with any cargo.");
	}
	else if(!strcmp(opsi, "sell")) {

		new 
			confirm[8], i = Cargo_Hold(playerid);

		if((id = Business_NearestDeliver(playerid)) != -1) {
			if (i == -1) return SendErrorMessage(playerid, "You're not holding a cargo.");
			if(sscanf(string, "s[8]", confirm)) return SendSyntaxMessage(playerid, "/cargo sell [confirm]"), SendCustomMessage(playerid, "NOTICE","This business only pay you "COL_GREEN"%s "WHITE"for one cargo!.", FormatNumber(BusinessData[id][bizCargo]));

			if(!strcmp(confirm, "confirm", false))
			{
				if (BusinessData[id][bizType] != CargoData[i][cargoType]) return SendErrorMessage(playerid, "This cargo not for this business.");
				if (BusinessData[id][bizVault] < BusinessData[id][bizCargo]) return SendErrorMessage(playerid, "This business don't have money.");
				if ((BusinessData[id][bizProducts]+Cargo_TypeAmount(i)) > 100) return SendErrorMessage(playerid, "This business full of products.");

				GiveMoney(playerid, BusinessData[id][bizCargo], ECONOMY_TAKE_SUPPLY, "sell cargo");
				BusinessData[id][bizVault] -= BusinessData[id][bizCargo];
				BusinessData[id][bizProducts] += Cargo_TypeAmount(i);

				if (CargoData[i][cargoType] == CARGO_FUEL)
				{
					for (new pump = 0; pump < MAX_GAS_PUMPS; pump ++) if(PumpData[pump][pumpExists] && PumpData[pump][pumpBusiness] == id) {
                        
                        PumpData[pump][pumpFuel] += 100;

                        if(PumpData[pump][pumpFuel] > 1000)
                            PumpData[pump][pumpFuel] = 1000;

                        Pump_Save(pump, false);
                        Pump_Sync(pump);
                    }
				}

				Dialog_Show(playerid, ShowOnlu, DIALOG_STYLE_MSGBOX, "Information", ""WHITE"You've selling one cargo: "COL_GREEN"$%d\n\
					"WHITE"Cargo package: "YELLOW"%d pcs\n\
					\n"WHITE"NOTE: Thanks for sell to this business", "Close", "", 
					BusinessData[id][bizCargo], 
					Cargo_TypeAmount(i)
				);
				Cargo_Destroy(Cargo_Hold(playerid));
				Cargo_AnimStop(playerid);
				return 1;
			}
			return 1;
		}
		SendErrorMessage(playerid, "You're not in near business delivery.");
	}
	else if(!strcmp(opsi, "create")) {
		static 
			type;

   		if(CheckAdmin(playerid, 6))
        	return PermissionError(playerid);

		if (sscanf(string, "d", type)) return SendSyntaxMessage(playerid, "/cargo create [type 1-8 (line business on /createbiz)]");
		if (type < 1 || type > 8) return SendErrorMessage(playerid, "Invalid cargo type.");

		new cargo = Cargo_Create(playerid, type);

		if(cargo == -1)
        	return SendErrorMessage(playerid, "The server has reached the limit for cargo.");

    	SendServerMessage(playerid, "You have successfully created cargo ID: %d.", cargo);
	}
	else if(!strcmp(opsi, "destroy")) {

   		if(CheckAdmin(playerid, 6))
        	return PermissionError(playerid);


		if((id = Cargo_Nearest(playerid)) != -1) {
			Cargo_Destroy(id);
			return 1;
		}
		SendErrorMessage(playerid, "You're not near with any cargo.");
	}
	else SendSyntaxMessage(playerid, "/cargo [buy/list/place/putdown/pickup/sell/create]");
	return 1;
}

task cargoExpiredUpdate[900000]()
{
	for(new i = 0; i != MAX_CARGO; i++) if (CargoData[i][cargoExists] && (gettime()-CargoData[i][cargoExpired]) > (86400*3))
	{
		Cargo_Destroy(i);
	}
	return 1;
}