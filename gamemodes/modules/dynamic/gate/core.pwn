/////////////////////////////////////
//
//
//
////////////////////////////////////
#include <YSI\y_hooks>
#include <YSI\y_timers>

#define KEY_OPEN_GATE_TOLL 	(KEY_CROUCH)
#define MAX_GATE_TOLL_PRICE (500)
#define MAX_DYNAMIC_GATE 		(400)

#define Gate_Faction(%0)	GateData[%0][gateFaction]
#define Gate_ObjectID(%0)	GateData[%0][gateObject]

enum
{
	GATE_FLAG_NONE = 0,
	GATE_FLAG_DISABLED
}

enum
{
	GATE_CLOSE = 0,
	GATE_OPEN
}

enum
{
	EDIT_GATE_NONE = 0,
	EDIT_GATE_POS,
	EDIT_GATE_MOVE
}

enum
{
	SAVE_GATE_ALL = 0,
	SAVE_GATE_POS,
	SAVE_GATE_MOVE,
	SAVE_GATE_RADIUS,
	SAVE_GATE_FACTION,
	SAVE_GATE_PASSWORD,
	SAVE_GATE_LINKID
}

enum E_GATE_DATA
{
	gateID,
	gateModel,
	gateLinkID,
	gateRadius,
	gateFaction,
	gatePassword[10],

	Float:gatePosition[3],
	Float:gateRotation[3],

	Float:gateMovePosition[3],
	Float:gateMoveRotation[3],

	gateWorld,
	gateInt,

	gateStatus,
	gateObject,
	gateTollPrice,
	gateFlag
}


// Variables list
new GateData[MAX_DYNAMIC_GATE][E_GATE_DATA];
new Iterator:Gates<MAX_DYNAMIC_GATE>;


// Event list
hook OnGameModeInitEx()
{
    mysql_pquery(g_iHandle, sprintf("SELECT * FROM `gates` ORDER BY `gateID` ASC LIMIT %d;", MAX_DYNAMIC_GATE), "Gate_Load", "");
}


forward Gate_Load();
public Gate_Load()
{
	if(cache_num_rows())
	{
		for (new i = 0; i < cache_num_rows(); i ++)
		{
			Iter_Add(Gates, i);

			GateData[i][gateStatus] = GATE_CLOSE;
			GateData[i][gateObject] = INVALID_STREAMER_ID;
			
			cache_get_field_content(i, "gatePass", GateData[i][gatePassword], 10);

			GateData[i][gateID] 			 = cache_get_field_int(i, "gateID");
			GateData[i][gateModel] 		 = cache_get_field_int(i, "gateModel");
			GateData[i][gateRadius] 	 = cache_get_field_int(i, "gateRadius");
			GateData[i][gateFaction] 	 = cache_get_field_int(i, "gateFaction");
			GateData[i][gateLinkID] 	 = cache_get_field_int(i, "gateLinkID");
			GateData[i][gateTollPrice] = cache_get_field_int(i, "gateTollPrice");
			GateData[i][gateFlag] 		 = cache_get_field_int(i, "gateFlag");

			GateData[i][gatePosition][0] 	= cache_get_field_float(i, "gateX");
			GateData[i][gatePosition][1] 	= cache_get_field_float(i, "gateY");
			GateData[i][gatePosition][2] 	= cache_get_field_float(i, "gateZ");
			GateData[i][gateRotation][0] 	= cache_get_field_float(i, "gateRX");
			GateData[i][gateRotation][1] 	= cache_get_field_float(i, "gateRY");
			GateData[i][gateRotation][2] 	= cache_get_field_float(i, "gateRZ");

			GateData[i][gateMovePosition][0] 	= cache_get_field_float(i, "gateMoveX");
			GateData[i][gateMovePosition][1] 	= cache_get_field_float(i, "gateMoveY");
			GateData[i][gateMovePosition][2] 	= cache_get_field_float(i, "gateMoveZ");
			GateData[i][gateMoveRotation][0] 	= cache_get_field_float(i, "gateMoveRX");
			GateData[i][gateMoveRotation][1] 	= cache_get_field_float(i, "gateMoveRY");
			GateData[i][gateMoveRotation][2] 	= cache_get_field_float(i, "gateMoveRZ");

			GateData[i][gateWorld] 	= cache_get_field_int(i, "gateWorld");
			GateData[i][gateInt] 	= cache_get_field_int(i, "gateInterior");

			if(GateData[i][gateRadius] < 5 || GateData[i][gateRadius] > 10)
				GateData[i][gateRadius] = 5;

			Gate_Sync(i);
		}
		printf("*** Loaded %d gates.", cache_num_rows());
	}
	return 1;
}

forward OnGateCreated(gate_id);
public OnGateCreated(gate_id)
{
	if(Gate_Exists(gate_id))
	{
        GateData[gate_id][gateID] = cache_insert_id();

		Gate_Sync(gate_id);
		Gate_Save(gate_id);
		return 1;
	}
	return 0;
}

// Function List
Gate_Create(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, virtualworld, interior)
{
	new gate_id = INVALID_ITERATOR_SLOT;

	if((gate_id = Iter_Free(Gates)) != INVALID_ITERATOR_SLOT) {
		Iter_Add(Gates, gate_id);

		format(GateData[gate_id][gatePassword], 10, "none");

		GateData[gate_id][gateModel] = modelid;
		GateData[gate_id][gateRadius] = 5;
		GateData[gate_id][gateFaction] = -1;
		GateData[gate_id][gateLinkID] = -1;
		GateData[gate_id][gateTollPrice] 	= 0;
		GateData[gate_id][gateFlag]	= GATE_FLAG_NONE;

		GateData[gate_id][gatePosition][0] = x;
		GateData[gate_id][gatePosition][1] = y;
		GateData[gate_id][gatePosition][2] = z;

		GateData[gate_id][gateRotation][0] = rx;
		GateData[gate_id][gateRotation][1] = ry;
		GateData[gate_id][gateRotation][2] = rz;

		GateData[gate_id][gateMovePosition][0] = x;
		GateData[gate_id][gateMovePosition][1] = y;
		GateData[gate_id][gateMovePosition][2] = z;

		GateData[gate_id][gateMoveRotation][0] = rx;
		GateData[gate_id][gateMoveRotation][1] = ry;
		GateData[gate_id][gateMoveRotation][2] = rz;

		GateData[gate_id][gateWorld] = virtualworld;
		GateData[gate_id][gateInt] = interior;

        mysql_tquery(g_iHandle, sprintf("INSERT INTO `gates` (`gateModel`) VALUES(%d);", modelid), "OnGateCreated", "d", gate_id);
		return gate_id;
	}
	return INVALID_ITERATOR_SLOT;
}

Gate_Delete(gate_id)
{
	if(Gate_Exists(gate_id)) 
	{
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `gates` WHERE `gateID` = '%d';", GateData[gate_id][gateID]));

		if(IsValidDynamicObject(GateData[gate_id][gateObject]))
			DestroyDynamicObject(GateData[gate_id][gateObject]);

		new tmp_GateData[E_GATE_DATA];
		GateData[gate_id] = tmp_GateData;

		GateData[gate_id][gateObject] = INVALID_STREAMER_ID;

		Iter_Remove(Gates, gate_id);
	}
	return 1;
}

Gate_Sync(gate_id)
{
	if(Gate_Exists(gate_id))
	{
		new objectid = GateData[gate_id][gateObject];

		GateData[gate_id][gateStatus] = GATE_CLOSE;

		if(IsValidDynamicObject(objectid)) {
			Gate_UpdateObjectPos(gate_id);
		}
		else { 
			GateData[gate_id][gateObject] = CreateDynamicObject(GateData[gate_id][gateModel], GateData[gate_id][gatePosition][0], 
				GateData[gate_id][gatePosition][1], GateData[gate_id][gatePosition][2], 
				GateData[gate_id][gateRotation][0], GateData[gate_id][gateRotation][1], 
				GateData[gate_id][gateRotation][2], GateData[gate_id][gateWorld], GateData[gate_id][gateInt], -1, 300, 300);
		}
		return 1;
	}
	return 0;
}

Gate_Save(gate_id, action = SAVE_GATE_ALL)
{
	if(Gate_Exists(gate_id))
	{
		new query[768];
		switch(action)
		{
			case SAVE_GATE_ALL: {
				format(query, sizeof(query), "UPDATE `gates` SET `gateFlag` = '%d', `gateTollPrice` = '%d', `gateModel` = '%d', `gateRadius` = '%d', `gateX` = '%.4f', `gateY` = '%.4f', `gateZ` = '%.4f', `gateRX` = '%.4f', `gateRY` = '%.4f', `gateRZ` = '%.4f', `gateMoveX` = '%.4f', `gateMoveY` = '%.4f', `gateMoveZ` = '%.4f', `gateMoveRX` = '%.4f', `gateMoveRY` = '%.4f', `gateMoveRZ` = '%.4f', `gateLinkID` = '%d', `gateFaction` = '%d', `gatePass` = '%s', `gateWorld` = '%d', `gateInterior` = '%d' WHERE `gateID` = '%d';", GateData[gate_id][gateFlag], GateData[gate_id][gateTollPrice], GateData[gate_id][gateModel], GateData[gate_id][gateRadius], GateData[gate_id][gatePosition][0], GateData[gate_id][gatePosition][1], GateData[gate_id][gatePosition][2], GateData[gate_id][gateRotation][0], GateData[gate_id][gateRotation][1], GateData[gate_id][gateRotation][2], GateData[gate_id][gateMovePosition][0], GateData[gate_id][gateMovePosition][1], GateData[gate_id][gateMovePosition][2], GateData[gate_id][gateMoveRotation][0], GateData[gate_id][gateMoveRotation][1], GateData[gate_id][gateMoveRotation][2], GateData[gate_id][gateLinkID], GateData[gate_id][gateFaction], SQL_ReturnEscaped(GateData[gate_id][gatePassword]), GateData[gate_id][gateWorld], GateData[gate_id][gateInt], GateData[gate_id][gateID]);
			}
			case SAVE_GATE_POS: {
				format(query, sizeof(query), "UPDATE `gates` SET `gateX` = '%.4f', `gateY` = '%.4f', `gateZ` = '%.4f', `gateRX` = '%.4f', `gateRY` = '%.4f', `gateRZ` = '%.4f', `gateWorld` = '%d', `gateInterior` = '%d' WHERE `gateID` = '%d';", GateData[gate_id][gatePosition][0], GateData[gate_id][gatePosition][1], GateData[gate_id][gatePosition][2], GateData[gate_id][gateRotation][0], GateData[gate_id][gateRotation][1], GateData[gate_id][gateRotation][2], GateData[gate_id][gateWorld], GateData[gate_id][gateInt], GateData[gate_id][gateID]);
			}
			case SAVE_GATE_MOVE: {
				format(query, sizeof(query), "UPDATE `gates` SET `gateMoveX` = '%.4f', `gateMoveY` = '%.4f', `gateMoveZ` = '%.4f', `gateMoveRX` = '%.4f', `gateMoveRY` = '%.4f', `gateMoveRZ` = '%.4f' WHERE `gateID` = '%d';", GateData[gate_id][gateMovePosition][0], GateData[gate_id][gateMovePosition][1], GateData[gate_id][gateMovePosition][2], GateData[gate_id][gateMoveRotation][0], GateData[gate_id][gateMoveRotation][1], GateData[gate_id][gateMoveRotation][2], GateData[gate_id][gateID]);
			}
			case SAVE_GATE_RADIUS: {
				format(query, sizeof(query), "UPDATE `gates` SET `gateRadius` = '%d' WHERE `gateID` = '%d';", GateData[gate_id][gateRadius], GateData[gate_id][gateID]);
			}
			case SAVE_GATE_FACTION: {
				format(query, sizeof(query), "UPDATE `gates` SET `gateFaction` = '%d' WHERE `gateID` = '%d';", GateData[gate_id][gateFaction], GateData[gate_id][gateID]);
			}
			case SAVE_GATE_PASSWORD: {
				format(query, sizeof(query), "UPDATE `gates` SET `gatePass` = '%s' WHERE `gateID` = '%d';", SQL_ReturnEscaped(GateData[gate_id][gatePassword]), GateData[gate_id][gateID]);
			}
			case SAVE_GATE_LINKID: {
				format(query, sizeof(query), "UPDATE `gates` SET `gateLinkID` = '%d' WHERE `gateID` = '%d';", GateData[gate_id][gateLinkID], GateData[gate_id][gateID]);
			}
		}
	    return mysql_tquery(g_iHandle, query);
	}
	return 1;
}

Gate_Exists(gate_id)
{
	if(Iter_Contains(Gates, gate_id))
		return 1;

	return 0;
}

Gate_Nearest(playerid)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	foreach(new i : Gates) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, GateData[i][gatePosition][0], GateData[i][gatePosition][1], GateData[i][gatePosition][2]);
        if(playerdist > GateData[i][gateRadius]) continue;
	    
	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}	
	return id;
}

bool:Gate_IsOpened(gate_id)
{
	if(!Gate_Exists(gate_id))
	{
		return false;
	}

	return (GateData[gate_id][gateStatus] == GATE_OPEN);
}

bool:Gate_IsDisabled(gate_id)
{
	if(!Gate_Exists(gate_id))
	{
		return true;
	}

	return (GateData[gate_id][gateFlag] == GATE_FLAG_NONE ? false : ((GateData[gate_id][gateFlag] & GATE_FLAG_DISABLED) == GATE_FLAG_DISABLED));
}

Gate_GetTollPrice(gate_id)
{
	if(!Gate_Exists(gate_id))
	{
		return 0;
	}

	return (GateData[gate_id][gateTollPrice]);
}

Gate_UpdateObjectPos(gate_id)
{
	if(Gate_Exists(gate_id)) {
		new objectid = GateData[gate_id][gateObject];

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_X, GateData[gate_id][gatePosition][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_Y, GateData[gate_id][gatePosition][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_Z, GateData[gate_id][gatePosition][2]);

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_R_X, GateData[gate_id][gateRotation][0]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_R_Y, GateData[gate_id][gateRotation][1]);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_R_Z, GateData[gate_id][gateRotation][2]);

		Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_WORLD_ID, GateData[gate_id][gateWorld]);
		Streamer_SetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_INTERIOR_ID, GateData[gate_id][gateInt]);

		return 1;
	}
	return 0;
}

Gate_SetFlag(gate_id, flag)
{
	if (!Gate_Exists(gate_id))
	{
		return 0;
	}

	GateData[gate_id][gateFlag] = GateData[gate_id][gateFlag] | flag;
	return 1;
}

Gate_RemoveFlag(gate_id, flag)
{
	if (!Gate_Exists(gate_id))
	{
		return 0;
	}

	GateData[gate_id][gateFlag] = GateData[gate_id][gateFlag] & ~flag;
	return 1;
}

timer Gate_Operate[3000](gate_id)
{
    if(Gate_Exists(gate_id))
    {
    	new id = -1;

        if(GateData[gate_id][gateStatus] == GATE_CLOSE)
        {
            GateData[gate_id][gateStatus] = GATE_OPEN;
            MoveDynamicObject(Gate_ObjectID(gate_id), GateData[gate_id][gateMovePosition][0], GateData[gate_id][gateMovePosition][1], GateData[gate_id][gateMovePosition][2], 3, GateData[gate_id][gateMoveRotation][0], GateData[gate_id][gateMoveRotation][1], GateData[gate_id][gateMoveRotation][2]);

            if(GateData[gate_id][gateLinkID] != -1 && (id = Gate_GetByID(GateData[gate_id][gateLinkID])) != -1)
            {
                GateData[id][gateStatus] = GATE_OPEN;
            	MoveDynamicObject(Gate_ObjectID(id), GateData[id][gateMovePosition][0], GateData[id][gateMovePosition][1], GateData[id][gateMovePosition][2], 3, GateData[id][gateMoveRotation][0], GateData[id][gateMoveRotation][1], GateData[id][gateMoveRotation][2]);
            }
        }
        else
        {
            GateData[gate_id][gateStatus] = GATE_CLOSE;
            MoveDynamicObject(Gate_ObjectID(gate_id), GateData[gate_id][gatePosition][0], GateData[gate_id][gatePosition][1], GateData[gate_id][gatePosition][2], 3, GateData[gate_id][gateRotation][0], GateData[gate_id][gateRotation][1], GateData[gate_id][gateRotation][2]);

            if(GateData[gate_id][gateLinkID] != -1 && (id = Gate_GetByID(GateData[gate_id][gateLinkID])) != -1)
            {
                GateData[id][gateStatus] = GATE_CLOSE;
	            MoveDynamicObject(Gate_ObjectID(id), GateData[id][gatePosition][0], GateData[id][gatePosition][1], GateData[id][gatePosition][2], 3, GateData[id][gateRotation][0], GateData[id][gateRotation][1], GateData[id][gateRotation][2]);
            }
        }
    }
    return 1;
}

Gate_GetByID(sqlid)
{
    foreach(new i : Gates) if(GateData[i][gateID] == sqlid) {
        return i;
    }
    return -1;
}

Gate_SetObjectPos(gate_id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(Gate_Exists(gate_id)) {
		GateData[gate_id][gatePosition][0] = x;
		GateData[gate_id][gatePosition][1] = y;
		GateData[gate_id][gatePosition][2] = z;

		GateData[gate_id][gateRotation][0] = rx;
		GateData[gate_id][gateRotation][1] = ry;
		GateData[gate_id][gateRotation][2] = rz;

		return 1;
	}
	return 0;
}

Gate_SetObjectMove(gate_id, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(Gate_Exists(gate_id)) {
		GateData[gate_id][gateMovePosition][0] = x;
		GateData[gate_id][gateMovePosition][1] = y;
		GateData[gate_id][gateMovePosition][2] = z;

		GateData[gate_id][gateMoveRotation][0] = rx;
		GateData[gate_id][gateMoveRotation][1] = ry;
		GateData[gate_id][gateMoveRotation][2] = rz;

		return 1;
	}
	return 0;
}