// built-in include guard removal
// just in case the user has a local dependency with the same file name
#if defined _inc_balloon
	#undef _inc_balloon
#endif
// custom include-guard to ensure we don't duplicate
#if defined _balloon_included
	#endinput
#endif
#define _balloon_included

#include <a_samp>
#include <logger>
#include <YSI\y_iterate>
#include <button>

#include <YSI\y_hooks>


// Redefine any of these before inclusion to override

#if !defined MAX_BALLOON
	#define MAX_BALLOON 		(5)
#endif

#if !defined BLN_MOVE_SPEED
	#define BLN_MOVE_SPEED		(10.0)
#endif

#if !defined BLN_SLOW_SPEED
	#define BLN_SLOW_SPEED		(1.0)
#endif

#if !defined BLN_LIFT_HEIGHT
	#define BLN_LIFT_HEIGHT		(10.0)
#endif

#if !defined BLN_BASKET_OFFSET
	#define BLN_BASKET_OFFSET	(1.14)
#endif

#define INVALID_BALLOON_ID	(-1)
#define BLN_STATE_IDLE		(0)
#define BLN_STATE_LIFTOFF	(2)
#define BLN_STATE_MOVE		(3)
#define BLN_STATE_LANDING	(4)

enum E_BALLOON_DATA {
	bln_object,
	bln_button[2],
	Float:bln_posX[2],
	Float:bln_posY[2],
	Float:bln_posZ[2],
	Float:bln_rotZ[2]
}

static
	bln_Data[MAX_BALLOON][E_BALLOON_DATA],
	bln_State[MAX_BALLOON],
	bln_Base[MAX_BALLOON];

new
	Iterator:bln_Index<MAX_BALLOON>;


stock CreateBalloon(
	Float:x1, Float:y1, Float:z1, Float:r1,
	Float:x2, Float:y2, Float:z2, Float:r2
) {
	new id = Iter_Free(bln_Index);

	if(id == ITER_NONE) {
		err("MAX_BALLOON limit reached.");
		return INVALID_BALLOON_ID;
	}

	bln_Data[id][bln_object] = CreateDynamicObject(19335, x1, y1, z1, r1, 0.0, 0.0, 0);
	bln_Data[id][bln_button][0] = CreateButton(x1, y1, (z1+BLN_BASKET_OFFSET), "Press F to activate Balloon", 0);
	bln_Data[id][bln_button][1] = CreateButton(x2, y2, (z2+BLN_BASKET_OFFSET), "Press F to activate Balloon", 0);

	bln_Data[id][bln_posX][0] = x1;
	bln_Data[id][bln_posY][0] = y1;
	bln_Data[id][bln_posZ][0] = z1;
	bln_Data[id][bln_rotZ][0] = r1;

	bln_Data[id][bln_posX][1] = x2;
	bln_Data[id][bln_posY][1] = y2;
	bln_Data[id][bln_posZ][1] = z2;
	bln_Data[id][bln_rotZ][1] = r2;

	bln_State[id] = BLN_STATE_IDLE;

	Iter_Add(bln_Index, id);

	return id;
}

stock DestroyBalloon(balloonid)
{
	if(!Iter_Contains(bln_Index, balloonid))
		return 0;

	Iter_Remove(bln_Index, balloonid);
	DestroyDynamicObject(bln_Data[balloonid][bln_object]);
	DestroyButton(bln_Data[balloonid][bln_button][0]);
	DestroyButton(bln_Data[balloonid][bln_button][1]);

	return 1;
}


stock bool:IsValidBalloon(balloonid) {
	if(!Iter_Contains(bln_Index, balloonid)) {
		return false;
	}

	return true;
}

// bln_object
stock GetBalloonObjectID(balloonid) {
	if(!Iter_Contains(bln_Index, balloonid)) {
		return INVALID_OBJECT_ID;
	}

	return bln_Data[balloonid][bln_object];
}

// bln_button
stock GetBalloonStartButtonID(balloonid) {
	if(!Iter_Contains(bln_Index, balloonid)) {
		return INVALID_BUTTON_ID;
	}

	return bln_Data[balloonid][bln_button][0];
}

stock GetBalloonEndButtonID(balloonid) {
	if(!Iter_Contains(bln_Index, balloonid)) {
		return -1;
	}

	return bln_Data[balloonid][bln_button][1];
}

// bln_posX
// bln_posY
// bln_posZ
// bln_rotZ
stock GetBalloonStartPos(balloonid, &Float:x, &Float:y, &Float:z, &Float:r) {
	if(!Iter_Contains(bln_Index, balloonid)) {
		return 0;
	}

	x = bln_Data[balloonid][bln_posX][0];
	y = bln_Data[balloonid][bln_posY][0];
	z = bln_Data[balloonid][bln_posZ][0];
	r = bln_Data[balloonid][bln_rotZ][0];

	return 1;
}

stock GetBalloonEndPos(balloonid, &Float:x, &Float:y, &Float:z, &Float:r) {
	if(!Iter_Contains(bln_Index, balloonid)) {
		return 0;
	}

	x = bln_Data[balloonid][bln_posX][1];
	y = bln_Data[balloonid][bln_posY][1];
	z = bln_Data[balloonid][bln_posZ][1];
	r = bln_Data[balloonid][bln_rotZ][1];

	return 1;
}

/*
	Internal
*/

_balloon_move(balloonid) {
	if(bln_State[balloonid] == BLN_STATE_LIFTOFF) {
		MoveDynamicObject(bln_Data[balloonid][bln_object],
			bln_Data[balloonid][bln_posX][bln_Base[balloonid]],
			bln_Data[balloonid][bln_posY][bln_Base[balloonid]],
			bln_Data[balloonid][bln_posZ][bln_Base[balloonid]] + BLN_LIFT_HEIGHT,
			BLN_SLOW_SPEED, 0.0, 0.0, bln_Data[balloonid][bln_rotZ][bln_Base[balloonid]]);
	} else if(bln_State[balloonid] == BLN_STATE_MOVE) {
		MoveDynamicObject(bln_Data[balloonid][bln_object],
			bln_Data[balloonid][bln_posX][bln_Base[balloonid]],
			bln_Data[balloonid][bln_posY][bln_Base[balloonid]],
			bln_Data[balloonid][bln_posZ][bln_Base[balloonid]] + BLN_LIFT_HEIGHT,
			BLN_MOVE_SPEED, 0.0, 0.0, bln_Data[balloonid][bln_rotZ][bln_Base[balloonid]]);
	} else if(bln_State[balloonid] == BLN_STATE_LANDING) {
		MoveDynamicObject(bln_Data[balloonid][bln_object],
			bln_Data[balloonid][bln_posX][bln_Base[balloonid]],
			bln_Data[balloonid][bln_posY][bln_Base[balloonid]],
			bln_Data[balloonid][bln_posZ][bln_Base[balloonid]],
			BLN_SLOW_SPEED, 0.0, 0.0, bln_Data[balloonid][bln_rotZ][bln_Base[balloonid]]);
	} else {
		bln_State[balloonid] = BLN_STATE_IDLE;
	}
}

hook OnButtonPress(playerid, buttonid) {
	new balloonid;

	foreach(new i : bln_Index) {
		if(buttonid == bln_Data[i][bln_button][bln_Base[i]] && bln_State[i] == BLN_STATE_IDLE) {
			balloonid = i;
			break;
		}
	}

	bln_State[balloonid] = BLN_STATE_LIFTOFF;
	_balloon_move(balloonid);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnDynamicObjectMoved(objectid) {
	new balloonid;

	foreach(new i : bln_Index) {
		if(objectid == bln_Data[i][bln_object]) {
			balloonid = i;
			break;
		}
	}

	if(bln_State[balloonid] == BLN_STATE_LIFTOFF) {
		bln_Base[balloonid] = !bln_Base[balloonid];
		bln_State[balloonid] = BLN_STATE_MOVE;
		_balloon_move(balloonid);
	} else if(bln_State[balloonid] == BLN_STATE_MOVE) {
		bln_State[balloonid] = BLN_STATE_LANDING;
		_balloon_move(balloonid);
	} else {
		bln_State[balloonid] = BLN_STATE_IDLE;
	}

	return Y_HOOKS_CONTINUE_RETURN_1;
}
