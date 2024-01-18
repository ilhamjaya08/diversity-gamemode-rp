#define MAX_DYNAMIC_SPEED	100

#define IsPlayerToggleSpeedTrap(%0)			GetPVarInt(%0, "ToggleSpeedLog")
#define SetPlayerToggleSpeedTrap(%0,%1)		SetPVarInt(%0, "ToggleSpeedLog",%1)

enum E_SPEED_DATA
{
	speedID,
	speedMax,

	speedDetail[128],
	Float:speedPos[4],

	speedArea,
	speedObject,
	Text3D:speedLabel
};


new
	Iterator:Speed<MAX_DYNAMIC_SPEED>,
	SpeedData[MAX_DYNAMIC_SPEED][E_SPEED_DATA];