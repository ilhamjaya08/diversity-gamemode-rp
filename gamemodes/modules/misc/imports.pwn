#define MAX_DROP (1)
#define MAX_DROPOBJECT (MAX_DROP)
#define MAX_DRUG_NAME 64
#define RANDOM_SPAWN 
#define IMPORT_CREATE_Z_OFFSET (0.5)
#define MAX_VEHICLE_IMPORT (10)

//GUN PRICE
#define MICRO_PRICE 60000
#define M4_PRICE 80000
#define COMBAT_PRICE 125000
#define SNIPER_PRICE 450000
#define ARMOUR_PRICE 2000

#include <YSI\y_timers>

enum importEnums {
	importID,
	importOrdered,
	importJumlah,
	importType,
	importTypeName[64],
	importUsername[MAX_PLAYER_NAME],
    importDrop,
	importTime,
	importRemovetime,
	importFactionName[64],
    importNotification,
	importLocName[64],
	importModel,
	Float:importPos[4],
	// Timer untuk meng-handle hitung mundur drop crate.
	Timer:ImportDropTimer,
	// Timer untuk meng-handle hitung mundur remove create setelah create belum terambil.
	Timer:ImportRemoveTimer
};
new	importData[MAX_DROP][importEnums];

// enum vehImportEnums {
// 	vimportID,
// 	vimportModel,
// 	vimportPrice,
// 	vimportStock,
// 	vimportLimit,
// 	vimportCooldown
// };
// new vehImportData[MAX_VEHICLE_IMPORT][vehImportEnums];

enum e_Drop {
    e_LocName[64],
	e_Model,
    Float:e_PosX,
    Float:e_PosY,
	Float:e_PosZ
};

new i_objectData[MAX_DROPOBJECT];
new Text3D:i_objectText[MAX_DROPOBJECT];

new RandomSpawn[RANDOM_SPAWN][e_Drop] = 
{
	{"Ocean Docks Ship", 3577,2808.8318,-2431.0972,13.6285}, // Ocean docks
	{"Red County Highway Beach", 3577,2878.1738,-238.9265,3.8864}, // Red County
	{"Fisher Lagoon", 3577,2102.3696,-103.6647,2.3208}, // Fisher Lagoon
	{"Blueberry River", 3577,334.6393,-308.4941,2.1648}, // Blueberry river
	{"Del Diablo Water", 3577,-480.8196, 2178.6851, 41.8599},
	{"Valle Ocultado Docks", 3577,-932.1772, 2651.0833, 42.1488},
	{"Easter Bay Ship", 3577,-1478.6365,143.9240,18.7734},
	{"Easter Basin Docks", 3577,-1411.0332,289.5231,1.1774},
	{"Esplanade Island", 3577,-1507.8712,1374.7776,3.6804},
	{"Tierra Robada Docks", 3577,-1376.6595,2111.4663,42.2000}
};

importRemove(importid)
{
	stop importData[importid][ImportRemoveTimer];
	DestroyDynamicObject(i_objectData[importid]);
	DestroyDynamic3DTextLabel(i_objectText[importid]);
	importData[importid][importOrdered] = false;
	importData[importid][importJumlah] = 0;
	importData[importid][importTime] = 0;
	importData[importid][importRemovetime] = 0;
	importData[importid][importNotification] = 0;
	importData[importid][importPos][0] = 0;
	importData[importid][importPos][1] = 0;
	importData[importid][importPos][2] = 0;
	importData[importid][importModel] = 0;
	format(importData[importid][importLocName], 64, " ");
	format(importData[importid][importUsername], 64, " ");
	format(importData[importid][importFactionName], 64, " ");
	return 1;
}

importAnnounceDropCrate(importid)
{
	if(!importData[importid][importOrdered])
	{
		return 0;
	}
	new string[350];
	format(string, sizeof(string), ""YELLOW"[CARTEL ACCESS] "WHITE"Pesanan "RED"%s "WHITE"telah drop di "YELLOW"%s", importData[importid][importFactionName],importData[importid][importLocName]);
	SendFactionMessageEx(FACTION_GANG, COLOR_WHITE, string);
	format(string, sizeof(string), ""WHITE"["YELLOW"%s"WHITE"] - ["YELLOW"%d"WHITE"]",  importData[importid][importTypeName],importData[importid][importJumlah]);
	SendFactionMessageEx(FACTION_GANG, COLOR_WHITE, string);
	if(importData[importid][importNotification] == 1)
	{
		format(string, sizeof(string), ""YELLOW"[CITY ALERT] "WHITE"Pesanan cartel telah drop di lokasi "YELLOW"[%s]", importData[importid][importLocName]);
		SendFactionMessageEx(FACTION_POLICE, COLOR_WHITE, string);				
	}		
	return 1;
}

importDropCrate(importid)
{
	new string[128];
	if(importData[importid][importOrdered] && importData[importid][importTime] <= 0)
	{
		if(IsValidDynamicObject(i_objectData[importid]) && IsValidDynamic3DTextLabel(i_objectText[importid]))
		{
			DestroyDynamicObject(i_objectData[importid]);
			DestroyDynamic3DTextLabel(i_objectText[importid]);
		}

		i_objectData[importid] = CreateDynamicObject(importData[importid][importModel], importData[importid][importPos][0], importData[importid][importPos][1], importData[importid][importPos][2], 0.0, 0.0, 0, 0, 0);
		format(string, sizeof(string), "[Import Drop]\n"YELLOW"[%s %d]\n\n"WHITE"/getitem to take your order from inside the crate.", importData[importid][importTypeName], importData[importid][importJumlah]);
		i_objectText[importid] = CreateDynamic3DTextLabel(string, COLOR_CLIENT, importData[importid][importPos][0], importData[importid][importPos][1], importData[importid][importPos][2], 20.0);

		importData[importid][importRemovetime] = 1800; //5 menit

		importAnnounceDropCrate(importid);

		// Memulai timer untuk menghapus crate.
		importData[importid][ImportRemoveTimer] = repeat ReduceImportRemoveItem(importid);
		return 1;
	}
	return 0;
}

timer ReduceImportDropCrateTime[1000](importid) 
{
	// Kurangi 1 detik.
	importData[importid][importTime]--;

	// Jika waktunya sudah habis, maka stop timer-nya.
	if (importData[importid][importTime] <= 0)
	{
		stop importData[importid][ImportDropTimer];
		// Jalankan fungsi untuk drop crate.
		importDropCrate(importid);
	}
}

timer ReduceImportRemoveItem[1000](importid)
{
	// Kurangi 1 detik.
	importData[importid][importRemovetime]--;

	// Jika waktunya sudah habis, maka stop timer-nya.
	if (importData[importid][importRemovetime] <= 0)
	{
		stop importData[importid][ImportRemoveTimer];
		// Jalankan fungsi untuk remove crate.
		importRemove(importid);
	}
}

importCreate(playerid, jumlah)
{
	for (new id = 0; id != MAX_DROP; id ++)
	{ 
		if(!importData[id][importOrdered])
		{
			if(importData[id][importType] == 1)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Materials");
			}
			else if(importData[id][importType] == 2)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Marijuana");
			}
			else if(importData[id][importType] == 3)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Heroin");
			}
			else if(importData[id][importType] == 4)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Cocaine");
			}
			else if(importData[id][importType] == 5)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Micro SMG");
			}
			else if(importData[id][importType] == 6)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Carbine Rifle");
			}
			else if(importData[id][importType] == 7)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Combat Shotgun");
			}
			else if(importData[id][importType] == 8)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Sniper Rifle");
			}
			else if(importData[id][importType] == 9)
			{
				format(importData[id][importTypeName], MAX_DRUG_NAME, "Kevlar Vest");
			}
			new factionid = PlayerData[playerid][pFaction];
			new rand = random(sizeof(RandomSpawn));
			new luck = random(4);

			importData[id][importOrdered] = true;
			importData[id][importJumlah] = jumlah;
			importData[id][importTime] = 1800; //30 Menit
			GetPlayerName(playerid, importData[id][importUsername], MAX_PLAYER_NAME + 1);

			format(importData[id][importFactionName], 68, "%s", FactionData[factionid][factionName]);
			format(importData[id][importLocName], 32, "%s", RandomSpawn[rand][e_LocName]);
			importData[id][importNotification] = luck;
			importData[id][importPos][0] = RandomSpawn[rand][e_PosX];
			importData[id][importPos][1] = RandomSpawn[rand][e_PosY];
			importData[id][importPos][2] = RandomSpawn[rand][e_PosZ] - IMPORT_CREATE_Z_OFFSET;
			importData[id][importModel] = RandomSpawn[rand][e_Model];

			SendFactionMessageEx(FACTION_GANG, COLOR_WHITE, ""YELLOW"[CARTEL ACCESS] "RED"%s "WHITE"telah membuat pesanan import! "YELLOW"[%d %s]", importData[id][importFactionName],importData[id][importJumlah], importData[id][importTypeName]);			
			if(importData[id][importNotification] == 1) 
			{
				SendFactionMessageEx(FACTION_POLICE, COLOR_WHITE, ""YELLOW"[CITY ALERT] "WHITE"Seseorang telah menghubungi cartel dan membuat pesanan import! "YELLOW"[%d %s]", importData[id][importJumlah], importData[id][importTypeName]);					
			}
			// Menjalankan timer-nya untuk drop crate.
			importData[id][ImportDropTimer] = repeat ReduceImportDropCrateTime(id);
			return id;
		}
	}
	return 1;
}

importNearest(playerid)
{
    for(new id=0; id < MAX_DROP; id++)
	{
		if(importData[id][importTime] <= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, importData[id][importPos][0], importData[id][importPos][1], importData[id][importPos][2]))
		{
			return id;
		}
	}
    return -1;
}

// Tinggal bikin timer 30 menit untuk manggil function importDrop
// Lalu di bikin timer 5 menit setelah drop untuk ngeremove dropnya
CMD:getitem(playerid, params[])
{
    new importid = importNearest(playerid);
    if(importid != -1 && bool:importData[importid][importOrdered] && !IsPlayerInjured(playerid))
    {    
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
        new amount = importData[importid][importJumlah];       
        if(importData[importid][importType] == 1){ //Materials
            if(Inventory_Add(playerid, "Materials", 11746, amount) == -1)
                return 1;
        }
        if(importData[importid][importType] == 2){//Marijuana
            if(Inventory_Add(playerid, "Marijuana", 1578, amount) == -1)
                return 1;
        }
        if(importData[importid][importType] == 3){//Heroin
            if(Inventory_Add(playerid, "Heroin", 1577, amount) == -1)
                return 1;
        }
        if(importData[importid][importType] == 4){///Cocaine
            if(Inventory_Add(playerid, "Cocaine", 1575, amount) == -1)
            return 1;
        }
        if(importData[importid][importType] == 5){///UZI
			if(PlayerHasWeaponInSlot(playerid, 28))
			return SendErrorMessage(playerid, "Kamu memiliki senjata dislot yang sama, simpan terlebih dahulu.");

			GivePlayerWeaponEx(playerid, 28, 700, 700);
        }
        if(importData[importid][importType] == 6){///M4
			if(PlayerHasWeaponInSlot(playerid, 31))
			return SendErrorMessage(playerid, "Kamu memiliki senjata dislot yang sama, simpan terlebih dahulu.");

			GivePlayerWeaponEx(playerid, 31, 1000, 1000);
        }
        if(importData[importid][importType] == 7){///Combat
			if(PlayerHasWeaponInSlot(playerid, 27))
			return SendErrorMessage(playerid, "Kamu memiliki senjata dislot yang sama, simpan terlebih dahulu.");

			GivePlayerWeaponEx(playerid, 27, 500, 500);
        }
        if(importData[importid][importType] == 8){///Sniper
			if(PlayerHasWeaponInSlot(playerid, 34))
			return SendErrorMessage(playerid, "Kamu memiliki senjata dislot yang sama, simpan terlebih dahulu.");

			GivePlayerWeaponEx(playerid, 34, 100, 100);
        }
        if(importData[importid][importType] == 9){ //Materials
            if(Inventory_Add(playerid, "Kevlar Vest", 373, amount) == -1)
                return 1;
        }
        PlayerData[playerid][pOnAnim] = 0;
        TakeCrates[playerid] = INVALID_TAKE_CRATES;
        SendClientMessageEx(playerid, COLOR_WHITE, "Kamu telah mengambil %s dengan jumlah %d dari dalam Crate", importData[importid][importTypeName], importData[importid][importJumlah]);
        importRemove(importid);
    }
    return 1;
}
CMD:forcedropcrate(playerid, params[])
{
	if (CheckAdmin(playerid, 4))
		return PermissionError(playerid);

	importData[0][importTime] = 1;
	SendServerMessage(playerid, "Drop create changed to 1. It will dropped shortly.");
	return 1;
}

CMD:forceremovecrate(playerid, params[])
{
	if (CheckAdmin(playerid, 4))
		return PermissionError(playerid);

	importData[0][importRemovetime] = 1;
	SendServerMessage(playerid, "Remove create changed to 1. It will removed shortly.");
	return 1;
}

CMD:gotodropcrate(playerid, params[])
{
	if (CheckAdmin(playerid, 4))
		return PermissionError(playerid);

	SetPlayerPos(playerid, importData[0][importPos][0], importData[0][importPos][1], importData[0][importPos][2] + 5.0);
	SendServerMessage(playerid, "Teleported to drop crate location");
	return 1;
}
