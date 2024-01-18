#define INVALID_ATM_ID			-1
#define MAX_DYNAMIC_ATM			200

#define ATM_GetInside(%0)		playerInsideATM[%0]
#define ATM_SetInside(%0,%1)	playerInsideATM[%0]=%1


enum E_ATM_DATA
{
	atmID,

	atmInterior,
	Float:atmPos[4],

	atmArea,
	atmObject,
	atmCapacity
};


new
	Iterator:Atms<MAX_DYNAMIC_ATM>,
	AtmData[MAX_DYNAMIC_ATM][E_ATM_DATA];

new
	playerInsideATM[MAX_PLAYERS] = {INVALID_ATM_ID, ...};