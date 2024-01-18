#define INVALID_HOUSE_KEY_ID (-1)
#define PLAYER_MAX_HOUSE_SHARE_KEYS	(100)

enum E_P_HOUSE_KEYS
{
	playerID, //Untuk menampung ID SQL Player
	houseOwnerID, // Untuk menampung ID SQL House Owner 
	houseID, //Untuk menampung ID SQL House
	houseKeyExists // Untuk menampung kosong atau tidak

};

new HouseKeyData[MAX_PLAYERS][PLAYER_MAX_HOUSE_SHARE_KEYS][E_P_HOUSE_KEYS];

CMD:sharehousekey(playerid, params[])
{
	new 
		userid, //Nyimpen taget id nya
		houseid = House_Nearest(playerid), // Nyimpen house id
		count
	;
	if(sscanf(params, "u", userid)) 
		return SendSyntaxMessage(playerid, "/sharehousekey [playerid/PartOfName]");

	if(userid == playerid)  // Ketika target id nya adalah player id dia , output error
		return SendErrorMessage(playerid, "You can't give or share your own house to yourself!");

    if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) // Ketika target tidak deket atau invalid, output error
		return SendErrorMessage(playerid, "The player is disconnected or not near you.");

	if(houseid == -1) // Ketika player tidak di dekat cp rumah, output error.
		return SendErrorMessage(playerid, "You're not near any house!");

	if(House_IsOwner(playerid, houseid, false)) // rumah harus di miliki, jika tidak akan error.
	{
		for(new i = 0; i < PLAYER_MAX_HOUSE_SHARE_KEYS; i++) // looping untuk mencari slot kunci yang tersedia dari si target
		{	
			if(HouseKeyData[userid][i][houseID] == HouseData[houseid][houseID]) // Kalau si target udah punya SQL id rumah udah gak boleh.
				return SendErrorMessage(playerid, "This player already have the key to this house!");
			
			if(HouseKeyData[userid][i][houseKeyExists])
			{
				count++;
			}

			if(count >= PLAYER_MAX_HOUSE_SHARE_KEYS-1)
				return SendErrorMessage(playerid, "This player's house key slot already full!");

			if(!HouseKeyData[userid][i][houseKeyExists]) // kalau slotnya kosong, di jalanin
			{
				HouseKeyData[userid][i][houseKeyExists] = 1; // isi slotnya dengan kondisi kalau slot ini sudah terisi.
				HouseKeyData[userid][i][playerID] = PlayerData[userid][pID]; 
				HouseKeyData[userid][i][houseID] = HouseData[houseid][houseID]; 
				HouseKeyData[userid][i][houseOwnerID] = PlayerData[playerid][pID];
				CreateHouseKey(userid, i); // Function untuk jalaninnya untuk ngeinsert ke database (query)
				SendServerMessage(playerid, "You shared your house's key to %s", ReturnName(userid));
				SendServerMessage(userid, "%s shared their house's key to You", ReturnName(playerid));
				break; // Ketika udah ketemu slotnya dan kosong brarti di stop.
			}
		}
	}
	return 1;
}

CMD:removehousekey(playerid, params[])
{
	new 
		houseid = House_Nearest(playerid),
		Cache:execute,
		playerSQLID,
		playerName[32],
		output[255]
	;

	if(houseid == -1)
		return SendErrorMessage(playerid, "You're not near any houses!");

	if(House_IsOwner(playerid, houseid, false))
	{
		execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `housekeys` LEFT JOIN `characters` ON housekeys.playerID=characters.ID WHERE houseID = '%d'", HouseData[houseid][houseID]));

		if(cache_num_rows())
		{
			strcat(output, sprintf("Database ID\tName\n"));
			for(new i = 0; i != cache_num_rows(); i++)
			{
				playerSQLID = cache_get_field_int(i, "playerID");
				cache_get_field_content(i, "Character", playerName);

				strcat(output, sprintf("%d\t%s\n", playerSQLID, playerName));
			}
			Dialog_Show(playerid, HouseRemoveKey, DIALOG_STYLE_TABLIST_HEADERS, "Shared House Key", output, "Remove", "Close");
		}
		else SendErrorMessage(playerid, "Tidak ada data yang dimuat");
		cache_delete(execute);		
	}
	return 1;
}

Dialog:HouseRemoveKey(playerid, response, listitem, inputtext[])
{
    if(response)
    {
		new playersqlid = strval(inputtext);
		new 
			query[255],
			houseid = House_Nearest(playerid)
		;
		if(houseid == -1)
			return SendErrorMessage(playerid, "You're not near any house!");

		for(new i; i < PLAYER_MAX_HOUSE_SHARE_KEYS; i++)
		{
			foreach(new x : Player)
			{
				if(HouseKeyData[x][i][playerID] == playersqlid)
				{
					HouseKeyData[x][i][houseID] = INVALID_HOUSE_KEY_ID;
					HouseKeyData[x][i][playerID] = INVALID_HOUSE_KEY_ID;
					HouseKeyData[x][i][houseOwnerID] = INVALID_HOUSE_KEY_ID;
					HouseKeyData[x][i][houseKeyExists] = 0;
						
					format(query, sizeof(query), "DELETE FROM `housekeys` WHERE playerID = '%d' AND houseID = '%d'", playersqlid, HouseData[houseid][houseID]);
					mysql_tquery(g_iHandle, query);
					break;
				}
				else
				{			
					format(query, sizeof(query), "DELETE FROM `housekeys` WHERE playerID = '%d' AND houseID = '%d'", playersqlid, HouseData[houseid][houseID]);
					mysql_tquery(g_iHandle, query);
				}
			}
		}
		SendServerMessage(playerid, "You remove house key from player id : %d", playersqlid);
	}
	return 1;
}
CreateHouseKey(playerid, slot)
{
	new query[255];
	format(query, sizeof(query), "INSERT INTO `housekeys` (`playerID`, `houseID`, `houseOwnerID`, `houseKeyExists`) VALUES('%d', '%d', '%d', '1')", HouseKeyData[playerid][slot][playerID], HouseKeyData[playerid][slot][houseID], HouseKeyData[playerid][slot][houseOwnerID]);
	mysql_tquery(g_iHandle, query);
	return 1;
}
RemoveAllHouseKey(houseid)
{
	new query[255];
	for(new i; i < PLAYER_MAX_HOUSE_SHARE_KEYS; i++)
	{
		foreach(new x : Player)
		{
			if(HouseKeyData[x][i][houseID] == houseid)
			{
				HouseKeyData[x][i][houseID] = INVALID_HOUSE_KEY_ID;
				HouseKeyData[x][i][playerID] = INVALID_HOUSE_KEY_ID;
				HouseKeyData[x][i][houseOwnerID] = INVALID_HOUSE_KEY_ID;
				HouseKeyData[x][i][houseKeyExists] = 0;
			}
		}
	}
	format(query, sizeof(query), "DELETE FROM `housekeys` WHERE houseID = '%d'", HouseData[houseid][houseID]);
	mysql_tquery(g_iHandle, query);
	return 1;
}
forward LoadHouseKey(playerid);
public LoadHouseKey(playerid)
{
	static
		rows,
		fields
	;

	cache_get_data(rows, fields);

	for (new i = 0; i != rows; i ++) 
	{
		HouseKeyData[playerid][i][houseKeyExists] = cache_get_field_int(i, "houseKeyExists");
		HouseKeyData[playerid][i][playerID] = cache_get_field_int(i, "playerID");
		HouseKeyData[playerid][i][houseID] = cache_get_field_int(i, "houseID");
		HouseKeyData[playerid][i][houseOwnerID] = cache_get_field_int(i, "houseOwnerID");
	}
	return 1;
}
