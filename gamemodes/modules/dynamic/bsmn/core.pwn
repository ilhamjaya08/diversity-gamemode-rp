#define MAX_DYNAMIC_UNDERGROUND		20


enum E_UNDERGROUND_DATA
{
	underID,

	Float:underEnter[3],
	Float:underExitSpawn[4],

	enterCP,
	exitCP,

	Text3D:enterLabel,
	Text3D:exitLabel
};

new 
	Iterator:Underground<MAX_DYNAMIC_UNDERGROUND>,
	UndergroundData[MAX_DYNAMIC_UNDERGROUND][E_UNDERGROUND_DATA];