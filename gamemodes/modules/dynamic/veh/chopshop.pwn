#define SetChoppingTime(%0,%1)				SetPVarInt(%0, "ChoppingTime", %1)
#define GetChoppingTime(%0)					GetPVarInt(%0, "ChoppingTime")

#define IsChoppingVehicle(%0)		    	GetPVarInt(%0, "ChoppingStart")
#define SetChoppingVehicle(%0,%1)	    	SetPVarInt(%0, "ChoppingStart", %1)

#define SetLockpickTime(%0,%1)				SetPVarInt(%0, "LockpickTime", %1)
#define GetLockpickTime(%0)					GetPVarInt(%0, "LockpickTime")

#define IsLockpickingVehicle(%0)		    GetPVarInt(%0, "LockpickingStart")
#define SetLockpickingVehicle(%0,%1)	    SetPVarInt(%0, "Lockpickingstart", %1)

#define MAX_RAND_LOCATION 4
#define MAX_CHOPSHOP 1


new Timer:vehicleAlarmTimer[MAX_DYNAMIC_VEHICLES];


enum e_Chopshop{
	chopShopPickup,
	Text3D:chopShopText,
	Float:chopShopPosX,
	Float:chopShopPosY,
	Float:chopShopPosZ,
};
new	ChopshopData[MAX_CHOPSHOP][e_Chopshop];

enum e_Coord {
    Float:e_PosX,
    Float:e_PosY,
	Float:e_PosZ
};

new randCoord[MAX_RAND_LOCATION][e_Coord] =
{
	{2488.7637,-1460.4315,24.0184}, 
	{2446.1292,-1761.6219,13.5859},
	{1687.5428,-2024.3988,14.1289},
	{2031.8624,-1290.8844,20.9403}
};

//  2488.7637,-1460.4315,24.0184 
// 	2446.1292,-1761.6219,13.5859
// 	1687.5428,-2024.3988,14.1289
// 	2031.8624,-1290.8844,20.9403

task ChopShopUpdate[3600000]() // 2400000
{
	new index;
	index = Random(sizeof(randCoord));
	DestroyDynamicPickup(ChopshopData[0][chopShopPickup]);
	DestroyDynamic3DTextLabel(ChopshopData[0][chopShopText]);
    ChopshopData[0][chopShopPosX] = randCoord[index][e_PosX]; 
    ChopshopData[0][chopShopPosY] = randCoord[index][e_PosY];
    ChopshopData[0][chopShopPosZ] = randCoord[index][e_PosZ];
	ChopshopData[0][chopShopPickup] = CreateDynamicPickup(1239, 23, ChopshopData[0][chopShopPosX], ChopshopData[0][chopShopPosY], ChopshopData[0][chopShopPosZ], 0, 0);
	ChopshopData[0][chopShopText] = CreateDynamic3DTextLabel("[Chopshop]\n"WHITE"Gunakan "YELLOW"/chopshop"WHITE" untuk menghancurkan kendaraan", COLOR_CLIENT, ChopshopData[0][chopShopPosX], ChopshopData[0][chopShopPosY], ChopshopData[0][chopShopPosZ]+0.5, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(IsChoppingVehicle(playerid))
    {
        Chopping_Reset(playerid);
    }

	if(IsLockpickingVehicle(playerid))
    {
        Lockpick_Reset(playerid);
    }
}

IsPlayerInChopArea(playerid)
{
	// if(IsPlayerInRangeOfPoint(playerid, 10.0, 2488.7637,-1460.4315,24.0184) || IsPlayerInRangeOfPoint(playerid, 10.0, 2446.1292,-1761.6219,13.5859) || IsPlayerInRangeOfPoint(playerid, 10.0, 1687.5428,-2024.3988,14.1289) || IsPlayerInRangeOfPoint(playerid, 10.0, 2031.8624,-1290.8844,20.9403))
	// {
	// 	return 1;
	// }
	if(IsPlayerInRangeOfPoint(playerid, 10.0, ChopshopData[0][chopShopPosX], ChopshopData[0][chopShopPosY], ChopshopData[0][chopShopPosZ]))
	{
		return 1;
	}
	return 0;
}

Chopping_Reset(playerid)
{
	SetChoppingVehicle(playerid, 0);
	SetChoppingTime(playerid, 0);
    return 1;
}

Lockpick_Reset(playerid, bool:anim = true)
{
	SetLockpickingVehicle(playerid, 0);
	SetLockpickTime(playerid, 0);
	if(anim) ClearAnimations(playerid);
    return 1;
}


IsVehicle_Chopped(playerid, vehicleid)
{
	CallRemoteFunction("OnVehicleDeath", "dd", vehicleid, playerid);
	if (IsValidVehicle(vehicleid))
    {
        SetVehicleToRespawn(vehicleid);
    }
	return 1;
}

IsVehicle_Picked(vehicleid)
{
	new index = Vehicle_ReturnID(vehicleid);

	if(index == -1)
		return 0;

	SetDoorStatus(vehicleid, false);
	SetEngineStatus(vehicleid, true);
	SetAlarmStatus(vehicleid, true);
	Vehicle_StopHandbrake(index);
	vehicleAlarmTimer[vehicleid] = defer AlarmOff(vehicleid);
	return 1;
}

GiveLockpickInformation(vehicleid)
{
	new index = Vehicle_ReturnID(vehicleid);

	if(index == -1)
		return 0;

	foreach(new i : Player) if(GetPlayerSQLID(i) == Vehicle_GetExtraID(index))
	{
		SendServerMessage(i, "Kendaraan "CYAN"%s "WHITE"milikmu sedang di"RED" lockpick!", GetVehicleNameByModel(VehicleData[index][vehModel]));
	}
	return 1;
}
timer AlarmOff[20000](vehicleid) //Default 30000
{
    SetAlarmStatus(vehicleid, false);
    stop vehicleAlarmTimer[vehicleid];
    return 1;
}
ptask Player_Chopshop[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	if(IsChoppingVehicle(playerid))
	{
		if(GetChoppingTime(playerid))
		{
			SetChoppingTime(playerid, GetChoppingTime(playerid) - 1);
			if(GetChoppingTime(playerid))
			{
				new 
					playerState = GetPlayerState(playerid),
					vehid = GetPlayerVehicleID(playerid)
				;
				if(playerState != PLAYER_STATE_DRIVER)
					return ShowPlayerFooter(playerid, "Gagal menghancurkan kendaraan, kamu tidak di posisi pengemudi!", 3000, 1), Chopping_Reset(playerid);

				if(GetDoorStatus(vehid))
					return ShowPlayerFooter(playerid, "Gagal menghancurkan kendaraan, mobil terkunci!", 3000, 1), Chopping_Reset(playerid);

				if(!IsPlayerInChopArea(playerid))
					return ShowPlayerFooter(playerid, "Gagal menghancurkan kendaraan, mobil bergerak ketika sedang di hancurkan!", 3000, 1), Chopping_Reset(playerid);

				if(!IsPlayerInRangeOfPoint(playerid, 5.0, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]))
					return ShowPlayerFooter(playerid, "Gagal menghancurkan kendaraan, mobil bergerak ketika sedang di hancurkan!", 3000, 1), Chopping_Reset(playerid);

				ShowPlayerFooter(playerid, sprintf("Menghancurkan kendaraan ~y~%s ~g~%d detik ~w~lagi... (Bergerak untuk membatalkan chopshop)",GetVehicleNameByVehicle(vehid), GetChoppingTime(playerid)), 1000);
			}
			else
			{
				new 
					price,
					totalprice,
					vehid = GetPlayerVehicleID(playerid)	
				;

				if(IsABike(vehid)) price = 2000;
				else if(IsSportCar(vehid)) price = 2500;
				else price = 2750;

				totalprice = price + Random(100, 500); 

				GameTextForPlayer(playerid, "~w~Chopshop ~g~Finished!", 3000, 6);
				SendServerMessage(playerid, "Sukses menghancurkan kendaraan, kamu mendapatkan "GREEN"%s", FormatNumber(totalprice));
				
				GiveMoney(playerid, totalprice, ECONOMY_TAKE_SUPPLY, "chopped a vehicle");
				IsVehicle_Chopped(playerid, vehid);
				Chopping_Reset(playerid);
			}
		}
	}
	return 1;
}
ptask Player_Lockpicking[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

	if(IsLockpickingVehicle(playerid))
	{
		if(GetLockpickTime(playerid))
		{
			SetLockpickTime(playerid, GetLockpickTime(playerid) - 1);
			if(GetLockpickTime(playerid))
			{
				new 
					playerState = GetPlayerState(playerid),
					vehicleid = Vehicle_Nearest(playerid, 5)
				;

				if(vehicleid < 1)
					return SendServerMessage(playerid, "Gagal lockpicking kendaraan"), Lockpick_Reset(playerid);

				if(playerState != PLAYER_STATE_ONFOOT)
					return ShowPlayerFooter(playerid, "Gagal lockpick kendaraan, posisi karakter kamu berubah!", 3000, 1), Lockpick_Reset(playerid);

				if(!IsPlayerInRangeOfPoint(playerid, 1.0, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]))
					return ShowPlayerFooter(playerid, "Gagal lockpick kendaraan, karakter bergerak ketika sedang lockpick!", 3000, 1), Lockpick_Reset(playerid);

				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
				ShowPlayerFooter(playerid, sprintf("Lockpick kendaraan ~y~%s ~g~%d detik ~w~lagi... (/stoplockpick untuk stop lockpicking)",GetVehicleNameByVehicle(vehicleid), GetLockpickTime(playerid)), 1000);
			}
			else
			{
				new 
					chance,
					vehicleid = Vehicle_Nearest(playerid, 5)	
				;

				if(vehicleid == INVALID_VEHICLE_ID)
					return SendServerMessage(playerid, "Gagal lockpicking kendaraan"), Lockpick_Reset(playerid);

				Inventory_Remove(playerid, "Bobby Pin", 1);
				GiveLockpickInformation(vehicleid);

				chance = random(20);
				if(chance <= 3)
				{
					GameTextForPlayer(playerid, "~w~Lockpick ~g~Sukses!", 3000, 6);
					SendServerMessage(playerid, "Sukses lockpicking kendaraan");
					
					IsVehicle_Picked(vehicleid);
					Lockpick_Reset(playerid);
				}
				else
				{
					GameTextForPlayer(playerid, "~w~Lockpick ~r~Gagal!", 3000, 6);
					SendServerMessage(playerid, "Gagal lockpicking kendaraan");
					vehicleAlarmTimer[vehicleid] = defer AlarmOff(vehicleid);
					SetAlarmStatus(vehicleid, true);
					Lockpick_Reset(playerid);
				}
			}
		}
	}
    return 1;
}

CMD:stoplockpick(playerid, params[])
{
    if(IsLockpickingVehicle(playerid))
    {
        Lockpick_Reset(playerid);
    }
    else
    {
        SendErrorMessage(playerid, "You're not lockpicking any vehicle!");
    }
    return 1;
}

CMD:lockpick(playerid, params[])
{
    new 
		playerState = GetPlayerState(playerid),
		vehicleid = Vehicle_Nearest(playerid, 5)
	;

	if(IsPlayerInDynamicArea(playerid, insurance_zone) || IsPlayerInDynamicArea(playerid, smb_zone) || IsPlayerInDynamicArea(playerid, parking_zone) || IsPlayerInDynamicArea(playerid, ls_zone) || IsPlayerInDynamicArea(playerid, hospital_zone) || IsPlayerInDynamicArea(playerid, lsbs_zone) || IsPlayerInDynamicArea(playerid, lsbank_zone))
		return SendErrorMessage(playerid, "You're in safezone!.");

	if(PlayerData[playerid][pScore] < 4)
        return SendErrorMessage(playerid, "You need to be level 4 to use this command.");
		
	if(!Inventory_HasItem(playerid, "Bobby Pin"))
		return SendErrorMessage(playerid, "You don't have a bobby pin.");

    if(playerState != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "You need to be on foot to use this command");

	// if(GetDoorStatus(vehicleid) != 1)
	// 	return SendErrorMessage(playerid, "This vehicle is not locked!");

	if (vehicleid < 1) // Harus ada kendaraan dalam radius 5 meter di sekitar player.
		return ShowPlayerFooter(playerid, "Tidak ada kendaraan di dekatmu (radius ~g~5 meter~w~).");

	if(IsLockpickingVehicle(playerid)) 
	{
		Lockpick_Reset(playerid);
	}
	new time = 30;
	SetLockpickTime(playerid, time);

	GiveLockpickInformation(vehicleid);

	SetLockpickingVehicle(playerid, 1);
	SendServerMessage(playerid, "Mulai Lockpick kendaraan %s", GetVehicleNameByVehicle(vehicleid));

	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
	ShowPlayerFooter(playerid, sprintf("Lockpick kendaraan ~y~%s ~g~%d detik ~w~lagi... (Bergerak untuk membatalkan chopshop)",GetVehicleNameByVehicle(vehicleid), GetLockpickTime(playerid)), 1000);
	GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);

    return 1;
}

CMD:chopshop(playerid, params[])
{
    new 
		playerState = GetPlayerState(playerid),
		vehicleid = GetPlayerVehicleID(playerid),
		index = Vehicle_ReturnID(vehicleid)
	;
	
	if(PlayerData[playerid][pScore] < 2) 
		return SendErrorMessage(playerid, "you must be level 2 to use chopshop.");

    if(playerState != PLAYER_STATE_DRIVER)
        return SendErrorMessage(playerid, "You need to be inside vehicle as driver to use this command");

	if(index == -1)
		return 0;

	if(PlayerData[playerid][pScore] < 4)
        return SendErrorMessage(playerid, "You need to be level 4 to use this command.");

	if(IsABicycle(vehicleid))
		return SendErrorMessage(playerid, "You cannot chop a Bicycle!");

	if(Vehicle_IsOwned(playerid, index))
		return SendErrorMessage(playerid, "You cannot chop your own vehicle!");

	if(GetDoorStatus(vehicleid))
		return SendErrorMessage(playerid, "You cannot chop this vehicle while its locked!");

	if(Vehicle_GetType(index) != VEHICLE_TYPE_PLAYER)
		return SendErrorMessage(playerid, "You cannot chop this vehicle!");

    if(IsPlayerInChopArea(playerid))
    { 
        if(IsChoppingVehicle(playerid)) 
        {
            Chopping_Reset(playerid);
        }
		new time = 300; //Default 600
		SetChoppingTime(playerid, time);

		SetChoppingVehicle(playerid, 1);
		SendServerMessage(playerid, "Mulai Chopshop kendaraan %s", GetVehicleNameByVehicle(vehicleid));
		ShowPlayerFooter(playerid, sprintf("Menghancurkan kendaraan ~y~%s ~g~%d detik ~w~lagi... (Bergerak untuk membatalkan chopshop)",GetVehicleNameByVehicle(vehicleid), GetChoppingTime(playerid)), 1000);
		GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
    }
	else SendErrorMessage(playerid, "You're not at chopshop location!");
    return 1;
}