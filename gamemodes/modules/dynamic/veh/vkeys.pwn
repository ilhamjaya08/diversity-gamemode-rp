#define INVALID_VEHICLE_KEY_ID (-1)
#define PLAYER_MAX_VEHICLE_SHARE_KEYS	(100)

enum E_P_VEHICLE_KEYS
{
	playerID, //Untuk menampung ID SQL Player
	vehicleID, //Untuk menampung ID SQL Vehicle
	vehicleKeyExists, // Untuk menampung kosong atau tidak
	vehicleModel // untuk menampung model kendaraan
};

new VehicleKeyData[MAX_PLAYERS][PLAYER_MAX_VEHICLE_SHARE_KEYS][E_P_VEHICLE_KEYS];

CMD:sharekey(playerid, params[])
{
	new 
		userid, //Nyimpen taget id nya
		vehicleid = GetPlayerVehicleID(playerid), // Nyimpen vehicle id
		vehicle_index, //Buat nyimpen vehicle id aslinya
		count
	;
	if(sscanf(params, "u", userid)) 
		return SendSyntaxMessage(playerid, "/sharekey [playerid/PartOfName]");

	if(userid == playerid)  // Ketika target id nya adalah player id dia , output error
		return SendErrorMessage(playerid, "You can't give or share your own vehicle to yourself!");

    if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) // Ketika target tidak deket atau invalid, output error
		return SendErrorMessage(playerid, "The player is disconnected or not near you.");

	if(!IsPlayerInAnyVehicle(playerid)) // Ketika player tidak di dalam kendaraan, output error.
		return SendErrorMessage(playerid, "You're not inside any vehicle!");

	if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID) // vehicle_index harus valid, jika tidak valid akan error.
	{
		if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER && Vehicle_IsOwned(playerid, vehicle_index)) // Jika tipe kendaraannya di milikin player dan dia ownernya
		{
			for(new i = 0; i < PLAYER_MAX_VEHICLE_SHARE_KEYS; i++) // looping untuk mencari slot kunci yang tersedia dari si target
			{	
				if(VehicleKeyData[userid][i][vehicleID] == VehicleData[vehicle_index][vehIndex]) // Kalau si target udah punya SQL id di kendaraan udah gak boleh.
					return SendErrorMessage(playerid, "This player already have the key to this vehicle!");
				
				if(VehicleKeyData[userid][i][vehicleKeyExists])
				{
					count++;
				}

				if(count >= PLAYER_MAX_VEHICLE_SHARE_KEYS-1)
					return SendErrorMessage(playerid, "This player's vehicle key slot already full!");

				if(!VehicleKeyData[userid][i][vehicleKeyExists]) // kalau slotnya kosong, di jalanin
				{
					VehicleKeyData[userid][i][vehicleKeyExists] = 1; // isi slotnya dengan kondisi kalau slot ini sudah terisi.
					VehicleKeyData[userid][i][playerID] = PlayerData[userid][pID]; // mengisi variable VehicleKeyData target dengan SQL id si target
					VehicleKeyData[userid][i][vehicleID] = VehicleData[vehicle_index][vehIndex]; // mengisi variable VehicleKetDaya vehicleid dengan SQL ID kendaraan si owner
					VehicleKeyData[userid][i][vehicleModel] = VehicleData[vehicle_index][vehModel];
					CreateVehicleKey(userid, i); // Function untuk jalaninnya untuk ngeinsert ke database (query)
					SendServerMessage(playerid, "You shared your vehicle's key to %s", ReturnName(userid));
					SendServerMessage(userid, "%s shared their vehicle's key to You", ReturnName(playerid));
					break; // Ketika udah ketemu slotnya dan kosong brarti di stop.
				}
			}
		}
	}
	return 1;
}

CMD:removekey(playerid, params[])
{
	new 
		userid,
		vehicleid = GetPlayerVehicleID(playerid),
		vehicle_index,
		count
	;
	if(sscanf(params, "u", userid)) 
		return SendSyntaxMessage(playerid, "/removekey [playerid/PartOfName]");

	if(userid == playerid) 
		return SendErrorMessage(playerid, "You can't remove your own vehicle key from yourself!");

    if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) 
		return SendErrorMessage(playerid, "The player is disconnected or not near you.");

	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You're not inside any vehicle!");

	if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
	{
		if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER && Vehicle_IsOwned(playerid, vehicle_index))
		{
			for(new i = 0; i < PLAYER_MAX_VEHICLE_SHARE_KEYS; i++)
			{
				if(VehicleKeyData[userid][i][vehicleKeyExists] && VehicleKeyData[userid][i][vehicleID] == VehicleData[vehicle_index][vehIndex])
				{
					VehicleKeyData[userid][i][vehicleKeyExists] = 0;
					VehicleKeyData[userid][i][playerID] = INVALID_VEHICLE_KEY_ID;
					VehicleKeyData[userid][i][vehicleID] = INVALID_VEHICLE_KEY_ID;
					VehicleKeyData[userid][i][vehicleModel] = 0;
					RemoveVehicleKey(userid, vehicle_index);
					SendServerMessage(playerid, "You remove your vehicle's key from %s", ReturnName(userid));
					SendServerMessage(userid, "%s remove their vehicle's key from You", ReturnName(playerid));
					break;
				}
				else
				{
					count++;
				}
			}
			if(count >= PLAYER_MAX_VEHICLE_SHARE_KEYS) 
				return SendErrorMessage(playerid, "This player don't have a key to this vehicle!");
		}
	}
	return 1;
}

CMD:removeallkeys(playerid, params[])
{
	new 
		vehicleid = GetPlayerVehicleID(playerid),
		vehicle_index
	;
	if(!IsPlayerInAnyVehicle(playerid))
		return SendErrorMessage(playerid, "You're not inside any vehicle!");

	if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
	{
		if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_PLAYER && Vehicle_IsOwned(playerid, vehicle_index))
		{
			for(new i = 0; i < PLAYER_MAX_VEHICLE_SHARE_KEYS; i++)
			{
				foreach(new x : Player)
				{
					if(VehicleKeyData[x][i][vehicleKeyExists] && VehicleKeyData[x][i][vehicleID] == VehicleData[vehicle_index][vehIndex])
					{	//Ini akan di jalanin ketika ada player yang ingame dengan kunci dan variable yang sama dengan kendaraan , maka akan di reset variable player tsb dan di remove dari db
						VehicleKeyData[x][i][vehicleKeyExists] = 0;
						VehicleKeyData[x][i][playerID] = INVALID_VEHICLE_KEY_ID;
						VehicleKeyData[x][i][vehicleID] = INVALID_VEHICLE_KEY_ID;
						VehicleKeyData[x][i][vehicleModel] = 0;
						RemoveAllVehicleKey(vehicle_index);
					}
					else
					{
						// Ini akan di jalankan ketika tidak ada yang ingame
						RemoveAllVehicleKey(vehicle_index);
					}
				}
			}
			SendServerMessage(playerid, "You remove your vehicle's key from everyone");
		}
	}
	return 1;
}

CMD:dropkey(playerid, params[])
{

	new 
		Cache:execute,
		output[1500], 
		vehicleid,
		vehiclemodel
	;

	execute = mysql_query(g_iHandle, sprintf("SELECT `vehicleID`, `vehicleModel` FROM `vehiclekeys` WHERE playerID = '%d'", PlayerData[playerid][pID]));

	if(cache_num_rows())
	{
		strcat(output, sprintf("VehicleID\tModel\n"));
		for(new i = 0; i != cache_num_rows(); i++)
		{
        	vehicleid = cache_get_field_int(i, "vehicleID");
			vehiclemodel = cache_get_field_int(i, "vehicleModel");

			strcat(output, sprintf("%d\t%s\n", vehicleid, GetVehicleNameByModel(vehiclemodel)));
		}
		Dialog_Show(playerid, VehicleDropKey, DIALOG_STYLE_TABLIST_HEADERS, "Shared Vehicle Key", output, "Drop Key", "Close");
	}
	else SendErrorMessage(playerid, "Tidak ada data yang dimuat");
	cache_delete(execute);
    return 1;
}
Dialog:VehicleDropKey(playerid, response, listitem, inputtext[])
{
    if(response)
    {
		new vehicleid = strval(inputtext);
		new query[255];
		for(new i; i < PLAYER_MAX_VEHICLE_SHARE_KEYS; i++)
		{
			if(VehicleKeyData[playerid][i][vehicleID] == vehicleid)
			{
				VehicleKeyData[playerid][i][vehicleID] = INVALID_VEHICLE_KEY_ID;
				VehicleKeyData[playerid][i][playerID] = INVALID_VEHICLE_KEY_ID;
				VehicleKeyData[playerid][i][vehicleModel] = 0;
				VehicleKeyData[playerid][i][vehicleKeyExists] = 0;
				SendServerMessage(playerid, "You throw away vehicle key vehicle id : %d", vehicleid);
					
				format(query, sizeof(query), "DELETE FROM `vehiclekeys` WHERE playerid = '%d' AND vehicleID = '%d'", PlayerData[playerid][pID], vehicleid);
				mysql_tquery(g_iHandle, query);
				break;
			}
		}
	}
	return 1;
}
CreateVehicleKey(playerid, slot)
{
	new query[255];
	format(query, sizeof(query), "INSERT INTO `vehiclekeys` (`playerID`, `vehicleID`, `vehicleModel`, `vehicleKeyExists`) VALUES('%d', '%d', '%d', '1')", VehicleKeyData[playerid][slot][playerID], VehicleKeyData[playerid][slot][vehicleID], VehicleKeyData[playerid][slot][vehicleModel]);
	mysql_tquery(g_iHandle, query);
	return 1;
}

RemoveVehicleKey(playerid, vehicleid)
{   
	new query[255];
	format(query, sizeof(query), "DELETE FROM `vehiclekeys` WHERE playerID = '%d' AND vehicleID = '%d'", PlayerData[playerid][pID], VehicleData[vehicleid][vehIndex]);
	mysql_tquery(g_iHandle, query);
	return 1;	
}

RemoveAllVehicleKey(vehicleid)
{   
	new query[255];
	format(query, sizeof(query), "DELETE FROM `vehiclekeys` WHERE vehicleID = '%d'", VehicleData[vehicleid][vehIndex]);
	mysql_tquery(g_iHandle, query);
	return 1;	
}

forward LoadVehicleKey(playerid);
public LoadVehicleKey(playerid)
{
	static
		rows,
		fields
	;

	cache_get_data(rows, fields);

	for (new i = 0; i != rows; i ++) 
	{
		VehicleKeyData[playerid][i][vehicleKeyExists] = cache_get_field_int(i, "vehicleKeyExists");
		VehicleKeyData[playerid][i][playerID] = cache_get_field_int(i, "playerID");
		VehicleKeyData[playerid][i][vehicleID] = cache_get_field_int(i, "vehicleID");
		VehicleKeyData[playerid][i][vehicleModel] = cache_get_field_int(i, "vehicleModel");
	}
	return 1;
}
