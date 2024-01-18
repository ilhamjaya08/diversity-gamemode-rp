#define INVALID_CALLER_CP			-1

enum CALLER_CP
{
	callerID,
	callerExists,
	callerName[50],
	callerType,
	bool:accepted,
	Float:callerPos[4],
	callerPosName[32],
	callerPhoneNumber
};


new
	Iterator:CallerCP<MAX_PLAYERS>,
	callerData[MAX_PLAYERS][CALLER_CP],
	selectedCaller[MAX_PLAYERS] = { INVALID_CALLER_CP, ... }
;
