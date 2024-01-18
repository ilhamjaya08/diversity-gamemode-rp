#define INVALID_DYNAMIC_ACTOR_ID -1

#define ACTOR_TYPE_NONE  (0)
#define ACTOR_TYPE_STORE (1)

#define MAX_DYNAMIC_ACTOR	300

new
	GrabCash[MAX_PLAYERS],
	GrabCashCounter[MAX_PLAYERS],
	Timer:GrabCashTimer[MAX_PLAYERS]
;

enum E_ACTOR_DATA
{
	actorID,
	actorVirtualWorld,
	actorInterior,
	Float:actorPos[4],
	actorName[MAX_PLAYER_NAME+1],
	
	actorObject,
	actorModel,
	Text3D:actorText,
	actorStatus,
	actorType,
	actorAnimLib[128],
	actorAnimName[128],
	actorCash,
	actorNotification,
	actorCooldown
};

new
	ActorData[MAX_DYNAMIC_ACTOR][E_ACTOR_DATA],
	Iterator:ServerActor<MAX_DYNAMIC_ACTOR>;
