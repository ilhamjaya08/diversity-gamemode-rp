#include <YSI\y_hooks>

// Function
Body_IsExists(index)
{
	if(Iter_Contains(Body, index))
		return 1;
	
	return 0;
}

timer RemoveBody[1000](index)
{
	BodyData[index][bodyRemoveTime]--;
	if(BodyData[index][bodyRemoveTime] <= 0)
	{
		Body_Delete(index);
		stop BodyData[index][bodyTimer];
	}
}
Body_PrepareCreate(playerid)
{
	new Float:x, Float:y, Float:z, Float:a, skin, vw, int;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	skin = GetPlayerSkin(playerid);
	vw = GetPlayerVirtualWorld(playerid);
	int = GetPlayerInterior(playerid);
	Body_Create(playerid, x, y, z, a, skin, vw, int);
	return 1;
}
Body_Create(playerid, Float:x, Float:y, Float:z, Float:a, skin, vw, int)
{
	static
		index;
	new string[255];
	if((index = Iter_Free(Body)) != cellmin)
	{
		Iter_Add(Body, index);

		BodyData[index][bodyPos][0] = x;
		BodyData[index][bodyPos][1] = y;
		BodyData[index][bodyPos][2] = z;
		BodyData[index][bodyPos][3] = a;
		BodyData[index][bodyVirtualWorld] = vw;
		BodyData[index][bodyInterior] = int;
		BodyData[index][bodyModel] = skin;

		format(BodyData[index][bodyName], MAX_PLAYER_NAME+1, ReturnName(playerid));

		BodyData[index][bodyObject] = CreateDynamicActor(BodyData[index][bodyModel], BodyData[index][bodyPos][0], BodyData[index][bodyPos][1], BodyData[index][bodyPos][2], BodyData[index][bodyPos][3], true, 100, BodyData[index][bodyVirtualWorld], BodyData[index][bodyInterior]);
		ApplyDynamicActorAnimation(BodyData[index][bodyObject], "WUZI", "CS_DEAD_GUY", 4.0, 0, 1, 1, 1, 0);

		format(string, sizeof(string), "[ID:%d]\n"RED"%s's "YELLOW"dead body", index, BodyData[index][bodyName]);
		BodyData[index][bodyText] = CreateDynamic3DTextLabel(string, COLOR_CLIENT, BodyData[index][bodyPos][0], BodyData[index][bodyPos][1], BodyData[index][bodyPos][2]-1, 30, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BodyData[index][bodyVirtualWorld], BodyData[index][bodyInterior]);
		BodyData[index][bodyRemoveTime] = 1800; //Testing
		BodyData[index][bodyTimer] = repeat RemoveBody(index);
		return index;
	}
	return -1;
}


Body_Delete(index, bool:removebyplayer = false)
{
	if(Body_IsExists(index))
	{
		Iter_Remove(Body, index);
		if(IsValidDynamicActor(BodyData[index][bodyObject]))
		{
			DestroyDynamicActor(BodyData[index][bodyObject]);
		}
		DestroyDynamic3DTextLabel(BodyData[index][bodyText]);
	
		new tmp_BodyData[E_BODY_DATA];
		BodyData[index] = tmp_BodyData;

		BodyData[index][bodyText] = Text3D:INVALID_STREAMER_ID;
		BodyData[index][bodyObject] = INVALID_STREAMER_ID;
		if(removebyplayer)
		{
			stop BodyData[index][bodyTimer];
			BodyData[index][bodyRemoveTime] = 0;
		}
		return 1;
	}
	return 0;
}

stock Body_Sync(index)
{
	if(Body_IsExists(index))
	{
		if(IsValidDynamicActor(BodyData[index][bodyObject]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_ACTOR, BodyData[index][bodyObject], E_STREAMER_X, BodyData[index][bodyPos][0]);
			Streamer_SetFloatData(STREAMER_TYPE_ACTOR, BodyData[index][bodyObject], E_STREAMER_Y, BodyData[index][bodyPos][1]);
			Streamer_SetFloatData(STREAMER_TYPE_ACTOR, BodyData[index][bodyObject], E_STREAMER_Z, BodyData[index][bodyPos][2]);
			Streamer_SetFloatData(STREAMER_TYPE_ACTOR, BodyData[index][bodyObject], E_STREAMER_R_Z, BodyData[index][bodyPos][3]);

			Streamer_SetIntData(STREAMER_TYPE_ACTOR, BodyData[index][bodyInterior], E_STREAMER_INTERIOR_ID, BodyData[index][bodyInterior]);
			Streamer_SetIntData(STREAMER_TYPE_ACTOR, BodyData[index][bodyVirtualWorld], E_STREAMER_WORLD_ID, BodyData[index][bodyVirtualWorld]);
		}
		else BodyData[index][bodyObject] = CreateDynamicActor(BodyData[index][bodyModel], BodyData[index][bodyPos][0], BodyData[index][bodyPos][1], BodyData[index][bodyPos][2], BodyData[index][bodyPos][3], true, 100, BodyData[index][bodyVirtualWorld], BodyData[index][bodyInterior]);
	}
	return 1;
}