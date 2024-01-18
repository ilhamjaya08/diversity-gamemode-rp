#include <YSI\y_hooks>

// Defined variable
#define IsPlayerVIP(%0)					!!donation_level{%0}
#define GetPlayerVIPExpired(%0)			donation_expired[%0]
#define GetPlayerVIPLevel(%0) 			donation_level{%0}
#define ReturnVIPName(%0) 				donation_name[%0]
#define ReturnVIPCoin(%0) 				donation_coin[%0]

#define IsToggleVIPMessage(%0)			donation_togglemsg{%0}
#define SetToggleVIPMessage(%0,%1)		donation_togglemsg{%0} = %1

#define ReturnVIPChangeName(%0) 		changename_value[%0]
#define ReturnVIPMask(%0) 				changemask_value[%0]
#define ReturnVIPPhone(%0) 				changephone_value[%0]

#define ReturnVIPCNSlot(%0) 			changename_slot{%0}
#define ReturnVIPPhoneSlot(%0) 			changephone_slot{%0}
#define ReturnVIPMaskSlot(%0) 			changemask_slot{%0}


// Constant variable
new donation_name[5][20] = {"None", "Diamond Donater", "Ruby Donater", "Sapphire Donater", "Emerald Donater"};
new donation_coin[5] = {0, 250, 500, 1000, 2500};

new changemask_value[5] = {0, 1, 2, 3, 3};
new changename_value[5] = {0, 0, 1, 2, 3};
new changephone_value[5] = {0, 1, 2, 3, 3};


// Player variable
new 
	donation_expired[MAX_PLAYERS] = {0, ...},
	donation_level[MAX_PLAYERS] = {0, ...},
	bool:donation_togglemsg[MAX_PLAYERS] = {true, ...};

new 
	changename_slot[MAX_PLAYERS] = {0, ...},
	changephone_slot[MAX_PLAYERS] = {0, ...},
	changemask_slot[MAX_PLAYERS] = {0, ...};


// Event
hook OnPlayerLogin(playerid)
{
	new Cache:execute, expired, type;
	execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `donation_characters` WHERE `pid`='%d';", GetPlayerSQLID(playerid)));

	if(cache_num_rows())
	{
		expired = cache_get_field_int(0, "expired");
		type = cache_get_field_int(0, "type");

		changename_slot{playerid} = cache_get_field_int(0, "changename");
		changephone_slot{playerid} = cache_get_field_int(0, "changephone");
		changemask_slot{playerid} = cache_get_field_int(0, "changemask");

		if(expired < gettime()) 
		{
			RemovePlayerVIP(playerid);
			SendServerMessage(playerid, "Masa aktif VIP telah habis, terima kasih telah berkontribusi kepada server!");
		}
		else 
		{
			SetPlayerVIP(playerid, type, expired);
			SendServerMessage(playerid, "Member VIP "GREEN"%s"WHITE", masa aktif sampai "LIGHTBLUE"%s.", ReturnVIPName(type), ConvertTimestamp(Timestamp:expired));
		}
	}
	cache_delete(execute);
}

hook OnPlayerDisconnect(playerid, reason)
{
	donation_level{playerid} = 0;
	donation_expired[playerid] = 0;

	changename_slot{playerid} = 0;
	changephone_slot{playerid} = 0;
	changemask_slot{playerid} = 0;

	donation_togglemsg{playerid} = true;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_VIPCAR)
    {
        if(response)
        {
            new Cache:execute,
            	modelid = strval(inputtext);
			
            execute = mysql_query(g_iHandle, sprintf("SELECT `coin` FROM `donation_vehicles` WHERE `model`='%d';", modelid));

            if(cache_num_rows())
            {
				new coin = cache_get_field_int(0, "coin");

				SetPVarInt(playerid, "VIPVehModel", modelid);
				SetPVarInt(playerid, "VIPVehCoin", coin);

				Dialog_Show(playerid, BuyVipCar, DIALOG_STYLE_MSGBOX, "Kendaraan VIP", WHITE"Apa kamu yakin ingin membeli kendaraan "LIGHTBLUE"%s "WHITE"dengan mengurangi "RED"%d UGcoin"WHITE"?", "Ya", "Gagalkan", GetVehicleNameByModel(modelid), coin);
            }
            else SendErrorMessage(playerid, "Terjadi kesalahan, silahkan mencoba dilain waktu!");

            cache_delete(execute);
        }
    }
    else if(dialogid == DIALOG_DELETE_VIPCAR)
    {
        if(response)
        {
        	if (CheckAdmin(playerid, 8))
        		return 1;

        	mysql_tquery(g_iHandle, sprintf("DELETE FROM `donation_vehicles` WHERE `model`='%d';", strval(inputtext)));
        	SendServerMessage(playerid, "Kamu telah menghapus "YELLOW"%s "WHITE"dari kendaraan vip.", GetVehicleNameByModel(strval(inputtext)));
        }
    }
    return 1;
}

// Function
SetPlayerVIP(playerid, level, expired)
{
	donation_level{playerid} = level;
	donation_expired[playerid] = expired;
	return 1;
}

RemovePlayerVIP(playerid)
{
	donation_level{playerid} = 0;
	donation_expired[playerid] = 0;

	return mysql_tquery(g_iHandle, sprintf("DELETE FROM `donation_characters` WHERE `pid`='%d';", GetPlayerSQLID(playerid)));
}


// VIP Items
SetVIPChangeName(playerid, value)
{
	if(!IsPlayerVIP(playerid))
		return 0;

	changename_slot{playerid} = value;
	return mysql_tquery(g_iHandle, sprintf("INSERT INTO `donation_characters` (`pid`, `changename`) VALUES ('%d','%d') ON DUPLICATE KEY UPDATE `changename`='%d';", GetPlayerSQLID(playerid), value, value));
}

SetVIPChangeMask(playerid, value)
{
	if(!IsPlayerVIP(playerid))
		return 0;

	changemask_slot{playerid} = value;
	return mysql_tquery(g_iHandle, sprintf("INSERT INTO `donation_characters` (`pid`, `changemask`) VALUES ('%d','%d') ON DUPLICATE KEY UPDATE `changemask`='%d';", GetPlayerSQLID(playerid), value, value));
}

SetVIPChangePhone(playerid, value)
{
	if(!IsPlayerVIP(playerid))
		return 0;

	changephone_slot{playerid} = value;
	return mysql_tquery(g_iHandle, sprintf("INSERT INTO `donation_characters` (`pid`, `changephone`) VALUES ('%d','%d') ON DUPLICATE KEY UPDATE `changephone`='%d';", GetPlayerSQLID(playerid), value, value));
}

IsVIPVehicle(modelid)
{
	new Cache:execute;

	execute = mysql_query(g_iHandle, sprintf("SELECT `model` FROM `donation_vehicles` WHERE `model`='%d' LIMIT 1;", modelid));

	if(cache_num_rows()) {
		cache_delete(execute);
		return 1;
	}

	cache_delete(execute);
	return 0;
}


// Timer
ptask Player_VIPUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	if(IsPlayerVIP(playerid) && GetPlayerVIPExpired(playerid) < gettime())
	{
		RemovePlayerVIP(playerid);
		SendServerMessage(playerid, "Masa aktif VIP telah habis, terima kasih telah berkontribusi kepada server!");
	}
	return 1;
}


// Dialog
Dialog:BuyVipCar(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			index, Float:x, Float:y, Float:z, Float:a,
			modelid = GetPVarInt(playerid, "VIPVehModel"),
			coin = GetPVarInt(playerid, "VIPVehCoin"),
			housevehicleslot = House_CountVehicleSlot(playerid);

		if(GetPlayerCoin(playerid) < coin)
			return SendErrorMessage(playerid, "UCoin tidak mencukupi!");

		if(GetPlayerVIPLevel(playerid) > 2)
        {
            if(Vehicle_PlayerTotalCount(playerid) >= MAX_VIP_VEHICLES+housevehicleslot)
                return SendErrorMessage(playerid, "Kendaraanmu sudah mencapai batas maksimal.");
        }
        else
        {
            if(Vehicle_PlayerTotalCount(playerid) >= MAX_PLAYER_VEHICLES+housevehicleslot)
                return SendErrorMessage(playerid, "Kendaraanmu sudah mencapai batas maksimal.");
        }

		switch(Model_GetCategory(modelid))
		{
			case CATEGORY_AIRPLANE, CATEGORY_HELICOPTER:
			{
				//1946.1017,-2360.9963,14.2701,179.1299
				x = 1946.1017;
				y = -2360.9963;
				z = 14.2701;
				a = 179.1299;
			}
			case CATEGORY_BOAT:
			{
				//725.0905,-1935.0524,-0.1206,179.0585
				x = 725.0905;
				y = -1935.0524;
				z = -0.1206;
				a = 179.0585;
			}
			default:
			{
				//488.5002,-1499.8226,20.0901,176.8953
				x = 488.5002;
				y = -1499.8226;
				z = 20.0901;
				a = 176.8953;
			}
		}

        if((index = Vehicle_Create(modelid, x, y, z, a, 1, 1)) != RETURN_INVALID_VEHICLE_ID)
        {
        	GivePlayerCoin(playerid, -coin);
			Vehicle_SetOwner(playerid, index);
            SetPlayerWaypoint(playerid, "Vehicle Spawn", x, y, z);
        	SendServerMessage(playerid, "Berhasil membeli "LIGHTBLUE"%s "WHITE"dengan "RED"%d UCoin.", GetVehicleNameByModel(modelid), coin);
		}
		else SendErrorMessage(playerid, "Slot kendaraan server sudah mencapai batas maksimal!");
	}

	DeletePVar(playerid, "VIPVehModel");
	DeletePVar(playerid, "VIPVehCoin");
	return 1;
}
