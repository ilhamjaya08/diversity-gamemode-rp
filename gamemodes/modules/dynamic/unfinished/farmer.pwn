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


/*
	Enums
*/

enum _:E_PLANT_TYPE
{
	PLANT_TYPE_NONE = 0,
	PLANT_TYPE_PUMPKIN,
	PLANT_TYPE_MUSHROOM,
	PLANT_TYPE_CUCUMBER,
	PLANT_TYPE_ORANGE,
	PLANT_TYPE_EGGPLANT
}

enum E_PLANT_DATA
{
	//Saved variable.
	plantType,
	plantTime
	Float:plantPos[3],

	//Temporary variable.
	plantObject,
	Text3D:plantLabel,
}


/*
	Variable
*/

new plantData[MAX_PLANT_SERVER][E_PLANT_DATA];
new Iterator:Plant<MAX_PLANT_SERVER>;

/*
	Callback
*/

AddNewPlant(playerid, type)
{
	new
		Float:x,
		Float:y,
		Float:z,
		plantid = Iter_Free(Plant);

	GetPlayerPos(playerid, x, y, z);

	plantData[plantid][plantType] = type;
	plantData[plantid][plantTime] = TIME_TO_HARVEST;

	plantData[plantid][plantPos][0] = x;
	plantData[plantid][plantPos][1] = y;
	plantData[plantid][plantPos][2] = z;

	//RefreshPlant(plantid);
	Iter_Add(Plant, plantid);
	return plantid;
}

/*
	Function
*/





