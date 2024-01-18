#define INVALID_BODY_ID			-1
#define MAX_DYNAMIC_BODY		300

enum E_BODY_DATA
{
	bodyVirtualWorld,
	bodyInterior,
	Float:bodyPos[4],

	bodyName[MAX_PLAYER_NAME+1],
	
	bodyModel,
	bodyRemoveTime,
	bodyObject,
	Timer:bodyTimer,
	Text3D:bodyText
};

new
	BodyData[MAX_DYNAMIC_BODY][E_BODY_DATA],
	Iterator:Body<MAX_DYNAMIC_BODY>;

// new
// 	playerInsideATM[MAX_PLAYERS] = {INVALID_ATM_ID, ...};