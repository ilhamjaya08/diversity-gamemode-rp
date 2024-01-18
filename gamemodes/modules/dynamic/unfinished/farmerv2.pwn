/*
	Farm system made by agus syahputra.
*/

#if defined _inc_farmer
	#undef _inc_farmer
#endif

#if defined _farmer_included
	#endinput
#endif
#define _farmer_included

/*
	Include packages
*/

#include <a_samp>

#include <YSI\y_timers>
#include <YSI\y_hooks>
#include <YSI\y_iterate>

/*
	Definitions
*/
#if !defined MAX_PLANT_SERVER
	#define MAX_PLANT_SERVER 100
#endif

#if !defined TIME_TO_HARVEST
	#define TIME_TO_HARVEST 30
#endif

#define PLANT_TYPE_COUNT sizeof(plantInformation)

/*
	Enums
*/

enum E_PLANT_DATA
{
	//Saved variable.
	plantType,
	plantTime,
	Float:plantPos[3],

	//Temporary variable.
	plantObject,
	plantCP
	// Text3D:plantLabel
};

enum _:E_PLANT_TYPE
{
	PLANT_TYPE_NONE = 0,
	PLANT_TYPE_PUMPKIN,
	PLANT_TYPE_MUSHROOM,
	PLANT_TYPE_CUCUMBER,
	PLANT_TYPE_ORANGE,
	PLANT_TYPE_EGGPLANT
};

enum E_PLANT_INFORMATION
{
	plantName[15],
	plantObject,
	Float:plantZ_Pos
};

new plantInformation[][E_PLANT_INFORMATION] = {
	{"none", 753, 0.0},
	{"Pumpkin", 753, 1.07},
	{"Mushroom", 857, 0.8},
	{"Cucumber", 19473, 1.14},
	{"Orange Fruits", 804, 0.0},
	{"Eggplant", 801, 1.12}
};


new plantVariable[MAX_PLANT_SERVER][E_PLANT_DATA];
new Iterator:Plant<MAX_PLANT_SERVER>;



/*
	Callback
*/

stock IsPlayerStandInPlant(playerid, range) 
{
	if(!IsPlayerConnected(playerid))
		return 0;

	foreach(new plantid : Plant) if(IsPlayerInRangeOfPoint(playerid, range, plantVariable[plantid][plantPos][0], plantVariable[plantid][plantPos][1], plantVariable[plantid][plantPos][2])) 
	{
		return plantid;
	}
	return -1;
}

stock GetPlantName(plantid, name[])
{
	if(!Iter_Contains(Plant, plantid))
		return 0;

	static
		type;

	GetPlantType(plantid, type);
	format(name, 15, plantInformation[type][plantName]);
	return 1;
}

stock GetPlantType(plantid, &type) 
{
	if(!Iter_Contains(Plant, plantid))
		return 0;

	type = plantVariable[plantid][plantType];
	return 1;
}

stock GetPlantTime(plantid, &time)
{
	if(!Iter_Contains(Plant, plantid))
		return 0;

	time = plantVariable[plantid][plantTime];
	return 1;
}

stock AddNewPlant(playerid, type) 
{
	new
		Float:x,
		Float:y,
		Float:z,
		plantid = Iter_Free(Plant);

	Iter_Add(Plant, plantid);

	GetPlayerPos(playerid, x, y, z);

	plantVariable[plantid][plantType] = type;
	plantVariable[plantid][plantTime] = TIME_TO_HARVEST;

	plantVariable[plantid][plantPos][0] = x;
	plantVariable[plantid][plantPos][1] = y;
	plantVariable[plantid][plantPos][2] = z;

	RefreshPlant(plantid);
	return plantid;
}

stock RefreshPlant(plantid) 
{
	if(Iter_Contains(Plant, plantid))
	{
		static
			type;

		GetPlantType(plantid, type);

		if(IsValidDynamicObject(plantVariable[plantid][plantObject])) DestroyDynamicObject(plantVariable[plantid][plantObject]);
		// if(IsValidDynamic3DTextLabel(plantVariable[plantid][plantLabel])) DestroyDynamic3DTextLabel(plantVariable[plantid][plantLabel]);
		if(IsValidDynamicCP(plantVariable[plantid][plantCP])) DestroyDynamicCP(plantVariable[plantid][plantCP]);

		plantVariable[plantid][plantObject] = CreateDynamicObject(plantInformation[type][plantObject], 
			plantVariable[plantid][plantPos][0], plantVariable[plantid][plantPos][1], (plantVariable[plantid][plantPos][2]-plantInformation[type][plantZ_Pos]), 
			0.0, 0.0, 0.0
		);

/*		plantVariable[plantid][plantLabel] = CreateDynamic3DTextLabel("Initializing ...", 0xC0C0C0FF, 
			plantVariable[plantid][plantPos][0], plantVariable[plantid][plantPos][1], plantVariable[plantid][plantPos][2], 
			7
		);*/

		if(!plantVariable[plantid][plantTime]) {
			plantVariable[plantid][plantCP] = CreateDynamicCP(plantVariable[plantid][plantPos][0], 
				plantVariable[plantid][plantPos][1], plantVariable[plantid][plantPos][2], 2, 0, 0, _, 5
			);
		}
		// UpdatePlantLabel(plantid);
	}
	else printf("*** [Refresh Plant] Could't refresh plant id: %d (plantid does't exists).", plantid);
	return 1;
}

/*stock UpdatePlantLabel(plantid) 
{
	if(!Iter_Contains(Plant, plantid))
		return 0;

	new
		label_text[50],
		type;

	GetPlantType(plantid, type);

	if(plantVariable[plantid][plantTime]) format(label_text, sizeof(label_text), "Plant Name: %s\nHarvest time: %d", plantInformation[type][plantName], plantVariable[plantid][plantTime]);
	else format(label_text, sizeof(label_text), "Plant Name: %s\n{FFFFFF}Ready to harvest", plantInformation[type][plantName]);

	UpdateDynamic3DTextLabelText(plantVariable[plantid][plantLabel], 0xC0C0C0FF, label_text);
	return 1;
}*/

/*
	Function
*/

/*hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
	if(IsPlayerStandInPlant(playerid, 2) != -1 && IsPlayerInDynamicCP(playerid, plantVariable[IsPlayerStandInPlant(playerid, 2)][plantCP]))
	{
		static
			name[15],
			time;

		GetPlantName(IsPlayerStandInPlant(playerid, 2), name);
		GetPlantTime(IsPlayerStandInPlant(playerid, 2), time);

		GameTextForPlayer(playerid, sprintf("Plant Name: ~g~~h~%s~n~%s", name, time ? (sprintf("Harvest time: ~y~~h~%d", time)) : "~b~~h~Ready to harvest!"), 2000, 5);
	} 
	return 1;	
}*/

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(newkeys & KEY_NO && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK && IsPlayerStandInPlant(playerid, 2) != -1)
		{
			static
		        plantid;

		    if((plantid = IsPlayerStandInPlant(playerid, 2)) != -1)
		    {
		        static
		        	hours, minutes, seconds,
		            name[15],
		            time;

		        GetPlantName(plantid, name);
		        GetPlantTime(plantid, time);
		        GetElapsedTime(time, hours, minutes, seconds);

		        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Check Plant", "{FFFFFF}Plant Name: {FFFF00}%s\n%s", "Close", "", name, time ? (sprintf("{FFFFFF}Harvest time: {37DB45}%02d:%02d:%02d", hours, minutes, seconds)) : "{37DB45}Ready to harvest!");
		    }
		}
	}
	return 1;
}

/*
	Timer
*/
task PlantTimerUpdate[1000]() 
{
	foreach(new plantid : Plant) if(plantVariable[plantid][plantTime]) 
	{	
		if(--plantVariable[plantid][plantTime] == 0) 
		{
			RefreshPlant(plantid);
			return 1;		
		}

		// UpdatePlantLabel(plantid);
	}
	return 1;
}

ptask PlantTimerCheck[1000](playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(IsPlayerStandInPlant(playerid, 2) != -1)
	{
		static
        	hours, minutes, seconds,
			plantid,
            name[15],
            display[128],
            time;

        plantid = IsPlayerStandInPlant(playerid, 2);

        GetPlantName(plantid, name);
        GetPlantTime(plantid, time);
        GetElapsedTime(time, hours, minutes, seconds);

		if(time) format(display, sizeof(display), "~n~~n~~n~~n~~n~~n~~y~Plant Name: ~w~%s~n~~y~Harvest time: ~w~%02d:%02d:%02d", name, hours, minutes, seconds);
		else format(display, sizeof(display), "~n~~n~~n~~n~~n~~n~~y~Plant Name: ~w~%s~n~~y~Harvest time: ~g~Now", name);

		GameTextForPlayer(playerid, display, 2000, 5);
	}
	return 1;
}