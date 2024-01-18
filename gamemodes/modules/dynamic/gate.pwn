/*
	Dynamic gate module
*/

#include <YSI\y_hooks>

enum {
    EDIT_GATE_NONE = 0,
    EDIT_GATE_POS,
    EDIT_GATE_MOVE,
}


static
	gate_Id[MAX_PLAYERS] 	= {-1, ...},
	gate_Type[MAX_PLAYERS] 	= {EDIT_GATE_NONE, ...};


enum E_GATE_DATA {
    gateID,
    gateOpened,
    gateModel,
    Float:gateSpeed,
    Float:gateRadius,
    gateTime,
    Float:gatePos[6],
    gateInterior,
    gateWorld,
    Float:gateMove[6],
    gateLinkID,
    gateWorkshop,
    gateFaction,
    gatePass[32],
    gateTimer,
    gateObject,
    gateMakeBy[MAX_PLAYER_NAME],
    gateLastEdit[MAX_PLAYER_NAME]
};

new GateData[MAX_GATES][E_GATE_DATA],
	Iterator:Gates<MAX_GATES>;

// ========================== Function ==========================

hook OnPlayerDisconnect(playerid, reason)
{
	if(gate_Id[playerid] != -1 && gate_Type[playerid] != EDIT_GATE_NONE) {
		Gate_Refresh(gate_Id[playerid]);
	}

	ResetGateVariable(playerid);
}

//hook OnPlayerEditDynObj(playerid, STREAMER_TAG_OBJECT objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) -< sebelum update streamer

hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(response == EDIT_RESPONSE_CANCEL)
    {
        if(gate_Id[playerid] != -1 && gate_Type[playerid] != EDIT_GATE_NONE) 
        {
            new id = gate_Id[playerid];

            Gate_Refresh(id);
            ResetGateVariable(playerid);
            SendServerMessage(playerid, "You have cancelled editing position of gate ID: %d.", id);
        }
    }
    if(response == EDIT_RESPONSE_FINAL)
    {
    	if(gate_Id[playerid] != -1 && gate_Type[playerid] != EDIT_GATE_NONE) 
        {
            new id = gate_Id[playerid];

	        if(Iter_Contains(Gates, id))
	        {
	            switch (gate_Type[playerid])
	            {
	                case EDIT_GATE_POS:
	                {
	                    GateData[id][gatePos][0] = x;
	                    GateData[id][gatePos][1] = y;
	                    GateData[id][gatePos][2] = z;
	                    GateData[id][gatePos][3] = rx;
	                    GateData[id][gatePos][4] = ry;
	                    GateData[id][gatePos][5] = rz;

	                    Gate_Save(id);
	                    Gate_Refresh(id);
	                    SendServerMessage(playerid, "You have edited the position of gate ID: %d.", id);
	                }
	                case EDIT_GATE_MOVE:
	                {
	                    GateData[id][gateMove][0] = x;
	                    GateData[id][gateMove][1] = y;
	                    GateData[id][gateMove][2] = z;
	                    GateData[id][gateMove][3] = rx;
	                    GateData[id][gateMove][4] = ry;
	                    GateData[id][gateMove][5] = rz;

	                    Gate_Save(id);
	                    Gate_Refresh(id);
	                    SendServerMessage(playerid, "You have edited the moving position of gate ID: %d.", id);
	                }
	            }
	            ResetGateVariable(playerid);
	        }
	    }
    }
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (newkeys & KEY_CROUCH))
    {
    	Open_Gate(playerid);
	}
	else if((GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) && (newkeys & KEY_CTRL_BACK))
    {
    	Open_Gate(playerid);
	}
	return 1;
}

// ========================== Function ==========================

Function:Gate_Load()
{
    static
        rows,
        fields;

    cache_get_data(rows, fields, g_iHandle);

    for (new i = 0; i < rows; i ++) if(i < MAX_GATES)
    {
    	Iter_Add(Gates, i);

        GateData[i][gateOpened] 	= false;
        GateData[i][gateID] 		= cache_get_field_int(i, "gateID");
        GateData[i][gateTime] 		= cache_get_field_int(i, "gateTime");
        GateData[i][gateModel] 		= cache_get_field_int(i, "gateModel");
        GateData[i][gateSpeed] 		= cache_get_field_float(i, "gateSpeed");
        GateData[i][gateRadius] 	= cache_get_field_float(i, "gateRadius");
        GateData[i][gateInterior] 	= cache_get_field_int(i, "gateInterior");
        GateData[i][gateWorld] 		= cache_get_field_int(i, "gateWorld");
        GateData[i][gateLinkID] 	= cache_get_field_int(i, "gateLinkID");
        GateData[i][gateFaction] 	= cache_get_field_int(i, "gateFaction");
        GateData[i][gateWorkshop] 	= cache_get_field_int(i, "gateWorkshop");
        GateData[i][gateTollPrice] 	= cache_get_field_int(i, "gateToll");

        GateData[i][gatePos][0] 	= cache_get_field_float(i, "gateX");
        GateData[i][gatePos][1] 	= cache_get_field_float(i, "gateY");
        GateData[i][gatePos][2] 	= cache_get_field_float(i, "gateZ");
        GateData[i][gatePos][3] 	= cache_get_field_float(i, "gateRX");
        GateData[i][gatePos][4] 	= cache_get_field_float(i, "gateRY");
        GateData[i][gatePos][5] 	= cache_get_field_float(i, "gateRZ");

        GateData[i][gateMove][0] 	= cache_get_field_float(i, "gateMoveX");
        GateData[i][gateMove][1] 	= cache_get_field_float(i, "gateMoveY");
        GateData[i][gateMove][2] 	= cache_get_field_float(i, "gateMoveZ");
        GateData[i][gateMove][3] 	= cache_get_field_float(i, "gateMoveRX");
        GateData[i][gateMove][4] 	= cache_get_field_float(i, "gateMoveRY");
        GateData[i][gateMove][5] 	= cache_get_field_float(i, "gateMoveRZ");

        cache_get_field_content(i, "gatePass", GateData[i][gatePass], 32);
        cache_get_field_content(i, "gateMakeBy", GateData[i][gateMakeBy], 32);
        cache_get_field_content(i, "gateLastEdit", GateData[i][gateLastEdit], 32);

        Gate_Refresh(i);
    }
    printf("*** [load] gate data (%d count).", rows);
    return 1;
}

Function:OnGateCreated(gateid)
{
    if(!Iter_Contains(Gates, gateid))
        return 0;

    GateData[gateid][gateID] = cache_insert_id(g_iHandle);

    Gate_Refresh(gateid);
    Gate_Save(gateid);
    return 1;
}

Function:CloseGate(gateid, linkid, Float:fX, Float:fY, Float:fZ, Float:speed, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    new id = -1;

    if(Iter_Contains(Gates, gateid) && GateData[gateid][gateOpened])
    {
        MoveDynamicObject(GateData[gateid][gateObject], fX, fY, fZ, speed, fRotX, fRotY, fRotZ);

        if((id = GetGateByID(linkid)) != -1)
        {
            MoveDynamicObject(GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], speed, GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);
            GateData[id][gateOpened] = 0;
        }
        return 1;
    }
    return 0;
}

// ========================== Callback ==========================

ResetGateVariable(playerid) {
	gate_Id[playerid] 	= -1;
	gate_Type[playerid] = EDIT_GATE_NONE;

	return 1;
}

Gate_Refresh(gateid)
{
	if(Iter_Contains(Gates, gateid))
	{
		if(IsValidDynamicObject(GateData[gateid][gateObject])) {
			DestroyDynamicObject(GateData[gateid][gateObject]);
		}

		GateData[gateid][gateObject] = CreateDynamicObject(GateData[gateid][gateModel], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5], GateData[gateid][gateWorld], GateData[gateid][gateInterior]);
	}
	return 0;
}

Gate_Save(gateid)
{
    new query[768];

    format(query, sizeof(query), "UPDATE `gates` SET `gateToll` = '%d', `gateModel` = '%d', `gateSpeed` = '%.4f', `gateRadius` = '%.4f', `gateTime` = '%d', `gateX` = '%.4f', `gateY` = '%.4f', `gateZ` = '%.4f', `gateRX` = '%.4f', `gateRY` = '%.4f', `gateRZ` = '%.4f', `gateInterior` = '%d', `gateWorld` = '%d', `gateMoveX` = '%.4f', `gateMoveY` = '%.4f', `gateMoveZ` = '%.4f', `gateMoveRX` = '%.4f', `gateMoveRY` = '%.4f', `gateMoveRZ` = '%.4f', `gateLinkID` = '%d', `gateFaction` = '%d', `gatePass` = '%s', `gateLastEdit`='%s', `gateMakeBy`='%s', `gateWorkshop`='%d' WHERE `gateID` = '%d'",
        GateData[gateid][gateTollPrice], GateData[gateid][gateModel], GateData[gateid][gateSpeed], GateData[gateid][gateRadius], GateData[gateid][gateTime],
        GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4],
        GateData[gateid][gatePos][5], GateData[gateid][gateInterior], GateData[gateid][gateWorld], GateData[gateid][gateMove][0], GateData[gateid][gateMove][1],
        GateData[gateid][gateMove][2], GateData[gateid][gateMove][3], GateData[gateid][gateMove][4], GateData[gateid][gateMove][5], GateData[gateid][gateLinkID],
        GateData[gateid][gateFaction], SQL_ReturnEscaped(GateData[gateid][gatePass]), GateData[gateid][gateLastEdit], GateData[gateid][gateMakeBy], GateData[gateid][gateWorkshop], GateData[gateid][gateID]
    );
    return mysql_tquery(g_iHandle, query);
}

Gate_Create(playerid, model, Float:x, Float:y, Float:z, Float:angle)
{
    for (new i; i < MAX_GATES; i ++) if (!Iter_Contains(Gates, i))
    {
    	Iter_Add(Gates, i);

        format(GateData[i][gateMakeBy], MAX_PLAYER_NAME, ReturnName2(playerid, 0));
        format(GateData[i][gateLastEdit], MAX_PLAYER_NAME, ReturnName2(playerid, 0));

        GateData[i][gateModel] 		= model;
        GateData[i][gateSpeed] 		= 3.0;
        GateData[i][gateRadius] 	= 0.0;
        GateData[i][gateOpened] 	= 0;
        GateData[i][gateTime] 		= 0;
        GateData[i][gateTollPrice] 	= 0;

        GateData[i][gatePos][0] 	= x;
        GateData[i][gatePos][1] 	= y;
        GateData[i][gatePos][2] 	= z;
        GateData[i][gatePos][3] 	= 0.0;
        GateData[i][gatePos][4] 	= 0.0;
        GateData[i][gatePos][5] 	= angle;

        GateData[i][gateMove][0] 	= x + (3.0 * floatsin(-angle, degrees));
        GateData[i][gateMove][1] 	= y + (3.0 * floatcos(-angle, degrees));
        GateData[i][gateMove][2] 	= z - 10.0;
        GateData[i][gateMove][3] 	= -1000.0;
        GateData[i][gateMove][4] 	= -1000.0;
        GateData[i][gateMove][5] 	= -1000.0;

        GateData[i][gateInterior] 	= GetPlayerInterior(playerid);
        GateData[i][gateWorld] 		= GetPlayerVirtualWorld(playerid);

        GateData[i][gateLinkID] 	= -1;
        GateData[i][gateFaction] 	= -1;
        GateData[i][gateWorkshop] 	= -1;

        GateData[i][gatePass][0] 	= '\0';
        GateData[i][gateObject] 	= CreateDynamicObject(GateData[i][gateModel], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2], GateData[i][gatePos][3], GateData[i][gatePos][4], GateData[i][gatePos][5], GateData[i][gateWorld], GateData[i][gateInterior]);

        mysql_tquery(g_iHandle, "INSERT INTO `gates` (`gateModel`) VALUES(980)", "OnGateCreated", "d", i);
        return i;
    }
    return -1;
}

Gate_Delete(gateid)
{
    if(Iter_Contains(Gates, gateid))
    {
        if(IsValidDynamicObject(GateData[gateid][gateObject])) {
            DestroyDynamicObject(GateData[gateid][gateObject]);
        }

        foreach(new i : Gates) if(GateData[i][gateLinkID] == GateData[gateid][gateID]) {
            GateData[i][gateLinkID] = -1;
            Gate_Save(i);
        }

        if(GateData[gateid][gateOpened] && GateData[gateid][gateTime]) {
            KillTimer(GateData[gateid][gateTimer]);
        }
        
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `gates` WHERE `gateID` = '%d'", GateData[gateid][gateID]));
        
        GateData[gateid][gateID] = 0;
        Iter_Remove(Gates, gateid);
    }
    return 1;
}

Gate_Nearest(playerid, radius = 0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	foreach(new i : Gates)
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2]);
        if(playerdist > ((radius) ? (3.5) : (GateData[i][gateRadius]))) continue;
	    if(playerdist <= tempdist)
	    {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	
	return id;
}

GetGateByID(sqlid)
{
    foreach(new i : Gates) if(GateData[i][gateID] == sqlid) {
        return i;
    }
    return -1;
}

Open_Gate(playerid)
{
	static
		id;

	if((id = Gate_Nearest(playerid)) != -1) 
    {
        if(!isnull(GateData[id][gatePass])) {
            Dialog_Show(playerid, GatePass, DIALOG_STYLE_PASSWORD, "Enter Password", "Please enter the password for this gate below:", "Submit", "Cancel");
        }
        else {
            if(GateData[id][gateWorkshop] != -1)
                return 1;

            if(GateData[id][gateFaction] != -1 && GetPlayerFaction(playerid) != GetFactionByID(GateData[id][gateFaction]))
                return 1;

            Gate_Operate(id);
            ShowPlayerFooter(playerid, sprintf("You have %s~w~ the gate!", GateData[id][gateOpened] ? ("~g~opened") : ("~r~closed")));
        }
    }
	return 1;
}

Gate_Operate(gateid, bool:manage = false, toggle = 0)
{
    if(Iter_Contains(Gates, gateid))
    {
        new id = -1;

        if(manage)
        {
            if(toggle) GateData[gateid][gateOpened] = false;
            else GateData[gateid][gateOpened] = true;
        }

        if(GateData[gateid][gateOpened])
        {
            GateData[gateid][gateOpened] = false;
            MoveDynamicObject(GateData[gateid][gateObject], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gateSpeed], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5]);

            if(GateData[gateid][gateTime] > 0) {
                KillTimer(GateData[gateid][gateTimer]);
            }
            
            if(GateData[gateid][gateLinkID] != -1 && (id = GetGateByID(GateData[gateid][gateLinkID])) != -1)
            {
                GateData[id][gateOpened] = false;
                MoveDynamicObject(GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gateSpeed], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);
            }
        }
        else
        {
            GateData[gateid][gateOpened] = true;
            MoveDynamicObject(GateData[gateid][gateObject], GateData[gateid][gateMove][0], GateData[gateid][gateMove][1], GateData[gateid][gateMove][2], GateData[gateid][gateSpeed], GateData[gateid][gateMove][3], GateData[gateid][gateMove][4], GateData[gateid][gateMove][5]);

            if(GateData[gateid][gateTime] > 0) {
                GateData[gateid][gateTimer] = SetTimerEx("CloseGate", GateData[gateid][gateTime], false, "ddfffffff", gateid, GateData[gateid][gateLinkID], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gateSpeed], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5]);
            }
            if(GateData[gateid][gateLinkID] != -1 && (id = GetGateByID(GateData[gateid][gateLinkID])) != -1)
            {
                GateData[id][gateOpened] = true;
                MoveDynamicObject(GateData[id][gateObject], GateData[id][gateMove][0], GateData[id][gateMove][1], GateData[id][gateMove][2], GateData[id][gateSpeed], GateData[id][gateMove][3], GateData[id][gateMove][4], GateData[id][gateMove][5]);
            }
        }
    }
    return 1;
}
// =========================== Dialog ===========================

Dialog:GatePass(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new id = Gate_Nearest(playerid);

        if(id == -1)
            return 0;

        if(isnull(inputtext))
            return Dialog_Show(playerid, GatePass, DIALOG_STYLE_PASSWORD, "Enter Password", "Please enter the password for this gate below:", "Submit", "Cancel");

        if(strcmp(inputtext, GateData[id][gatePass]) != 0)
            return Dialog_Show(playerid, GatePass, DIALOG_STYLE_PASSWORD, "Enter Password", "Error: Incorrect password specified.\n\nPlease enter the password for this gate below:", "Submit", "Cancel");

        Gate_Operate(id);
    }
    return 1;
}

// ========================== Commands ==========================


CMD:creategate(playerid, params[])
{
    if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    static
        id = -1,
        modelid,
        Float:x,
        Float:y,
        Float:z,
        Float:angle;

    if(sscanf(params,"d", modelid))
        return SendSyntaxMessage(playerid, "/creategate [model]");

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, angle);

    id = Gate_Create(playerid, modelid, x + (3.0 * floatsin(-angle, degrees)), y + (3.0 * floatsin(-angle, degrees)), z, angle);

    if(id == -1)
        return SendErrorMessage(playerid, "The server has reached the limit for gates.");

    SendServerMessage(playerid, "You have successfully created gate ID: %d.", id);
    return 1;
}

CMD:destroygate(playerid, params[])
{
    if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    static
        id;

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/destroygate [gate id]");

    if(!Iter_Contains(Gates, id))
        return SendErrorMessage(playerid, "You have specified an invalid gate ID.");

    Gate_Delete(id);
    SendServerMessage(playerid, "You have successfully destroyed gate ID: %d.", id);
    return 1;
}

CMD:gateid(playerid, params[])
{
    if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    static
        id;

    if((id = Gate_Nearest(playerid, 1)) != -1) {
        SendServerMessage(playerid, "You are standing near gate ID: %d.", id);
    }
    return 1;
}

CMD:gotogate(playerid, params[])
{
    if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

	static 
		id;

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/gotogate [gate ID]");

    if(!Iter_Contains(Gates, id))
        return SendErrorMessage(playerid, "You have specified an invalid gate ID.");

    SetPlayerPos(playerid, GateData[id][gatePos][0] - (2.5 * floatsin(-GateData[id][gatePos][3], degrees)), GateData[id][gatePos][1] - (2.5 * floatcos(-GateData[id][gatePos][3], degrees)), GateData[id][gatePos][2]);
    SetPlayerInterior(playerid, GateData[id][gateInterior]);
    SetPlayerVirtualWorld(playerid, GateData[id][gateWorld]);

    SendServerMessage(id, "You have teleported to gate ID: %d.", id);
    return 1;
}

CMD:editgate(playerid, params[])
{
    if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    static
        id,
        type[24],
        string[128];

    if(sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        SendSyntaxMessage(playerid, "/editgate [id] [name]");
        SendClientMessage(playerid, X11_YELLOW_2, "[NAMES]:"WHITE" location, speed, radius, time, model, pos, move, pass, linkid, faction, duplicate, info, workshop.");
        return 1;
    }

    if(!Iter_Contains(Gates, id))
        return SendErrorMessage(playerid, "You have specified an invalid gate ID.");

    if(!strcmp(type, "location", true))
    {
        static
            Float:x,
            Float:y,
            Float:z,
            Float:angle;

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);

        x += 3.0 * floatsin(-angle, degrees);
        y += 3.0 * floatcos(-angle, degrees);

        if(GateData[id][gateOpened] && GateData[id][gateTime]) {
        	KillTimer(GateData[id][gateTimer]);
        }

        GateData[id][gateOpened] = false;

        GateData[id][gatePos][0] = x;
        GateData[id][gatePos][1] = y;
        GateData[id][gatePos][2] = z;
        GateData[id][gatePos][3] = 0.0;
        GateData[id][gatePos][4] = 0.0;
        GateData[id][gatePos][5] = angle;

        SetDynamicObjectPos(GateData[id][gateObject], x, y, z);
        SetDynamicObjectRot(GateData[id][gateObject], 0.0, 0.0, angle);

        Gate_Save(id);
        Gate_Refresh(id);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the position of gate ID: %d.", ReturnName(playerid, 0), id);
    }
    else if(!strcmp(type, "speed", true))
    {
        static
            Float:speed;

        if(sscanf(string, "f", speed))
            return SendSyntaxMessage(playerid, "/editgate [id] [speed] [move speed]");

        if(speed < 0.0 || speed > 20.0)
            return SendErrorMessage(playerid, "The specified speed can't be below 0 or above 20.");

        GateData[id][gateSpeed] = speed;

        Gate_Save(id);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the speed of gate ID: %d to %.2f.", ReturnName(playerid, 0), id, speed);
    }
    else if(!strcmp(type, "radius", true))
    {
        static
            Float:radius;

        if(sscanf(string, "f", radius))
            return SendSyntaxMessage(playerid, "/editgate [id] [radius] [open radius]");

        if(radius < 0.0 || radius > 20.0)
            return SendErrorMessage(playerid, "The specified radius can't be below 0 or above 20.");

        GateData[id][gateRadius] = radius;

        Gate_Save(id);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the radius of gate ID: %d to %.2f.", ReturnName(playerid, 0), id, radius);
    }
    else if(!strcmp(type, "time", true))
    {
        static
            times;

        if(sscanf(string, "d", times))
            return SendSyntaxMessage(playerid, "/editgate [id] [time] [close time] (0 to disable)");

        if(times < 0 || times > 60000)
            return SendErrorMessage(playerid, "The specified time can't be 0 or above 60,000 ms.");

        GateData[id][gateTime] = times;

        Gate_Save(id);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the close time of gate ID: %d to %d.", ReturnName(playerid, 0), id, times);
    }
    else if(!strcmp(type, "model", true))
    {
        static
            model;

        if(sscanf(string, "d", model))
            return SendSyntaxMessage(playerid, "/editgate [id] [model] [gate model]");

        if(!IsValidObjectModel(model))
            return SendErrorMessage(playerid, "Invalid object model.");

        GateData[id][gateModel] = model;

        Gate_Save(id);
        Gate_Refresh(id);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the model of gate ID: %d to %d.", ReturnName(playerid, 0), id, model);
    }
    else if(!strcmp(type, "pos", true))
    {	
        gate_Id[playerid] 		= id;
        gate_Type[playerid] 	= EDIT_GATE_POS;

    	EditDynamicObject(playerid, GateData[id][gateObject]);
        SendServerMessage(playerid, "You are now adjusting the position of gate ID: %d.", id);
    }
    else if(!strcmp(type, "move", true))
    {
        gate_Id[playerid] 		= id;
        gate_Type[playerid] 	= EDIT_GATE_MOVE;

        EditDynamicObject(playerid, GateData[id][gateObject]);
        SendServerMessage(playerid, "You are now adjusting the moving position of gate ID: %d.", id);
    }
    else if(!strcmp(type, "linkid", true))
    {
        static
            linkid = -1;

        if(sscanf(string, "d", linkid))
            return SendSyntaxMessage(playerid, "/editgate [id] [linkid] [gate link] (-1 for none)");

        if((linkid < -1 || linkid >= MAX_GATES) || (linkid != -1 && !Iter_Contains(Gates, linkid)))
            return SendErrorMessage(playerid, "You have specified an invalid gate ID.");

        GateData[id][gateLinkID] = (linkid == -1) ? (-1) : (GateData[linkid][gateID]);
        Gate_Save(id);

        if(id == -1) SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the faction of gate ID: %d to no gate.", ReturnName(playerid, 0), id);
        else SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the faction of gate ID: %d to ID: %d.", ReturnName(playerid, 0), id, linkid);
    }
    else if(!strcmp(type, "faction", true))
    {
        static
            factionid;

        if(sscanf(string, "d", factionid))
            return SendSyntaxMessage(playerid, "/editgate [id] [faction] [gate faction] (-1 for none)");

        if((factionid < -1 || factionid >= MAX_FACTIONS) || (factionid != -1 && !FactionData[factionid][factionExists]))
            return SendErrorMessage(playerid, "You have specified an invalid faction ID.");

        GateData[id][gateFaction] = (factionid == -1) ? (-1) : (FactionData[factionid][factionID]);
        Gate_Save(id);

        if(factionid == -1) SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the faction of gate ID: %d to no faction.", ReturnName(playerid, 0), id);
        else SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the faction of gate ID: %d to \"%s\".", ReturnName(playerid, 0), id, FactionData[factionid][factionName]);
    }
    else if(!strcmp(type, "workshop", true))
    {
        static
            index = -1;

        if(sscanf(string, "d", index))
            return SendSyntaxMessage(playerid, "/editgate [id] [workshop] [workshop id]");

        if((index < -1 || index >= MAX_WORKSHOP) || (index != -1 && !Iter_Contains(Workshop, index)))
            return SendErrorMessage(playerid, "You have specified an invalid workshop ID.");

        GateData[id][gateWorkshop] = (index == -1) ? (-1) : (WorkshopData[index][wID]);

        Gate_Save(id);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the gate ID: %d to workshop ID: %d.", ReturnName(playerid, 0), id, index);
    }
    else if(!strcmp(type, "pass", true))
    {
        static
            pass[32];

        if(sscanf(string, "s[32]", pass))
            return SendSyntaxMessage(playerid, "/editgate [id] [pass] [gate password] (Use 'none' to disable)");

        if(!strcmp(pass, "none", true)) GateData[id][gatePass][0] = '\0', print("Deteksi");
        else format(GateData[id][gatePass], 32, pass);

        Gate_Save(id);
        SendAdminMessage(X11_TOMATO_1, "AdmCmd: %s has adjusted the password of gate ID: %d to %s.", ReturnName(playerid, 0), id, pass);
    }
    else if(!strcmp(type, "duplicate", true))
    {
        static
            gateid;
                
        gateid = Gate_Create(playerid, GateData[id][gateModel], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gatePos][5]);
        
        if(gateid == -1)
        	return SendErrorMessage(playerid, "The server has reached the limit for gates.");

	    SendServerMessage(playerid, "You have successfully created gate ID: %d.", gateid);
        SendAdminMessage(X11_TOMATO_1,"AdmCmd: %s now is duplicate gate id %d", ReturnName2(playerid, 0), gateid);
    }
    else if(!strcmp(type, "info", true))
    {
        Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Gate info: %d", id), "Type\tValue\n\
            "WHITE"ID\t%d\nDatabase ID\t%d\nGate model\t%d\nPassword\t%s\nFor faction id\t%d\nFor faction index\t%d\n\
            Make by\t%s\nLast edited by\t%s\nSpeed\t%f\nRadius\t%f\n"WHITE"Moving time\t%d sec","Close", "", 
            id, GateData[id][gateID], GateData[id][gateModel], GateData[id][gatePass],GateData[id][gateFaction],GetFactionByID(GateData[id][gateFaction]),
            GateData[id][gateMakeBy], GateData[id][gateLastEdit], GateData[id][gateSpeed], GateData[id][gateRadius], GateData[id][gateTime]
        );
        return 1;
    }
    format(GateData[id][gateLastEdit], 24, ReturnName2(playerid, 0));
    return 1;
}