/*		Dynamic Lumber by Agus Syahputra	*/

#include <YSI\y_hooks>
#include <YSI\y_timers>

#define LUMBER_PERMISSION   5
#define LUMBER_INITIAL      100

static
    Timer:timer_lumber[MAX_PLAYERS],
    editing_lumber[MAX_PLAYERS] = {-1, ...},
    cutting_lumber[MAX_PLAYERS] = {-1, ...},
    bool:add_lumber[MAX_PLAYERS] = {false, ...},
    object_lumber[MAX_PLAYERS] = {INVALID_OBJECT_ID, ...};

enum lumberData {
    lumber_id,
    lumber_time,
    Float:lumber_pos[3],
    Float:lumber_rot[3],
    lumber_cp,
    lumber_obj,
    lumber_cut,
    lumber_getcut
};


new LumberData[MAX_LUMBER][lumberData],
    Iterator:Lumber<MAX_LUMBER>;


// ========================== Function Hooks ==========================

hook OnGameModeExit() {
    foreach(new index : Lumber) {
        Lumber_Save(index);
    }
}

hook OnPlayerDisconnect(playerid, reason)
{
    Lumber_ResetPlayer(playerid);
}

hook OnPlayerDeath(playerid, reason)
{
    Lumber_ResetPlayer(playerid);
}
//hook OnPlayerEditDynObj(playerid, STREAMER_TAG_OBJECT objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) -< sebelum update streamer

hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(objectid == object_lumber[playerid]) {
        if(response == EDIT_RESPONSE_CANCEL)
        {
            if(add_lumber[playerid])  {
                Lumber_ResetPlayer(playerid);
                SendErrorMessage(playerid, "Gagal membuat pohon baru.");
            }
            else {
                Lumber_Refresh(editing_lumber[playerid]);

                Lumber_ResetPlayer(playerid);
                SendErrorMessage(playerid, "Gagal memposisikan pohon.");
            }
        }
        if(response == EDIT_RESPONSE_FINAL)
        {
            static
                id;

            if(add_lumber[playerid])  {
                id = Lumber_Create(x, y, z);

                if(id == -1)
                    return SendErrorMessage(playerid, "Pohon sudah mencapai batas maksimal, kontak scripter untuk menambahnya.");

                Lumber_ResetPlayer(playerid);
                SendServerMessage(playerid, "Sukses menambah pohon baru ("YELLOW"ID: %d"WHITE").");
            }
            else {

                id = editing_lumber[playerid];

                LumberData[id][lumber_pos][0] = x;
                LumberData[id][lumber_pos][1] = y;
                LumberData[id][lumber_pos][2] = z;

                LumberData[id][lumber_rot][0] = rx;
                LumberData[id][lumber_rot][1] = ry;
                LumberData[id][lumber_rot][2] = rz;

                Lumber_Save(id);
                Lumber_Refresh(id);

                Lumber_ResetPlayer(playerid);

                SendServerMessage(playerid, "Sukses memposisikan pohon ke posisi baru!.");
            }
        }
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_NO) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        if(GetPlayerJob(playerid) == JOB_LUMBERJACK && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerWeapon(playerid) == WEAPON_CHAINSAW)
        {
            static 
                id = -1;

            if((id = Lumber_Nearest(playerid)) != -1)
            {
                if(cutting_lumber[playerid] == -1 && !LumberData[id][lumber_cut] && !LumberData[id][lumber_getcut] && !LumberData[id][lumber_time])
                {
                    LumberData[id][lumber_getcut]   = true;
                    cutting_lumber[playerid]        = id;
                    timer_lumber[playerid]          = repeat Lumber_Player_Tim(playerid);

                    TogglePlayerControllable(playerid, 0);
                    SetPlayerArmedWeapon(playerid, WEAPON_CHAINSAW);
                    SetPlayerLookAt(playerid, LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1]);

                    SetPlayerProgressBarValue(playerid, PlayerData[playerid][pCuttingBar], 0.0);
                    ShowPlayerProgressBar(playerid, PlayerData[playerid][pCuttingBar]);

                    ApplyAnimation(playerid, "CRACK", "null", 4.0, 0, 0, 0, 1, 0, 1);
                    ApplyAnimation(playerid, "CHAINSAW", "WEAPON_csaw", 4.1, 1, 0, 0, 1, 0, 1);
                }
            }
        }
    }
}

// ========================== Local Function ==========================

Function:Lumber_Load()
{
    static
        rows,
        fields,
        destinasi[24];

    cache_get_data(rows, fields, g_iHandle);

    for(new id = 0; id != rows; id++) if(id < MAX_LUMBER)
    {
        Iter_Add(Lumber, id);

        LumberData[id][lumber_id] 	= cache_get_field_int(id,"ID");
        LumberData[id][lumber_cut] 	= cache_get_field_int(id,"Tebang");
        LumberData[id][lumber_time] = cache_get_field_int(id,"Time");

        cache_get_field_content(id, "Pos", destinasi, sizeof(destinasi));
        sscanf(destinasi, "p<|>fff", LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1], LumberData[id][lumber_pos][2]);

        cache_get_field_content(id, "Rot", destinasi, sizeof(destinasi));
        sscanf(destinasi, "p<|>fff", LumberData[id][lumber_rot][0], LumberData[id][lumber_rot][1], LumberData[id][lumber_rot][2]);

        Lumber_Refresh(id);
    }
    printf("*** Successfull loaded %d/%d lumber object from database.", rows, MAX_LUMBER);
    return 1;
}

Function:Lumber_Created(index)
{
    LumberData[index][lumber_id] = cache_insert_id(g_iHandle);

    Lumber_Save(index);
    Lumber_Refresh(index);
    return 1;
}

// ========================== Callback ==========================

Lumber_ResetPlayer(playerid) {
	if(IsValidDynamicObject(object_lumber[playerid])) {
		DestroyDynamicObject(object_lumber[playerid]);
	}
    editing_lumber[playerid]   = -1;
    add_lumber[playerid]       = false;
	object_lumber[playerid]    = INVALID_OBJECT_ID;

    foreach(new id : Lumber)
    {
        LumberData[id][lumber_getcut]   = 0;
    }

    Lumber_Stop(playerid);
}

Lumber_Create(Float:x, Float:y, Float:z) {
	static
		index;

	if((index = Iter_Free(Lumber)) != -1)
	{
		Iter_Add(Lumber, index);

	    LumberData[index][lumber_time] 		= 3600;
		LumberData[index][lumber_cut] 		= 0;
		LumberData[index][lumber_getcut] 	= 0;

		LumberData[index][lumber_pos][0] 	= x;
		LumberData[index][lumber_pos][1] 	= y;
		LumberData[index][lumber_pos][2] 	= z;
		LumberData[index][lumber_rot][0] 	= LumberData[index][lumber_rot][1] = LumberData[index][lumber_rot][2] = 0.0;

		mysql_tquery(g_iHandle, "INSERT INTO `lumber` SET `Time` = '0'", "Lumber_Created", "d", index);
		return index;
	}
	return -1;
}

Lumber_Save(id) {
    new 
        query[500];

    mysql_format(g_iHandle, query, sizeof(query), "UPDATE `lumber` SET `Tebang`='%d', `Time`='%d', `Pos`='%.2f|%.2f|%.2f', `Rot`='%.2f|%.2f|%.2f' WHERE `ID`='%d'", 
        LumberData[id][lumber_cut], LumberData[id][lumber_time], LumberData[id][lumber_pos][0], 
        LumberData[id][lumber_pos][1], LumberData[id][lumber_pos][2], LumberData[id][lumber_rot][0],
        LumberData[id][lumber_rot][1], LumberData[id][lumber_rot][2], LumberData[id][lumber_id]
    );
    mysql_tquery(g_iHandle, query);

    return 1;
}

Lumber_Refresh(id) {
    if(Iter_Contains(Lumber, id))
    {
        if(IsValidDynamicCP(LumberData[id][lumber_cp])){
            DestroyDynamicCP(LumberData[id][lumber_cp]);
        }

        if(IsValidDynamicObject(LumberData[id][lumber_obj])) {
            DestroyDynamicObject(LumberData[id][lumber_obj]);
        }

        LumberData[id][lumber_cp] = CreateDynamicCP(LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1], LumberData[id][lumber_pos][2], 2, _, _, _, 5);

        if(!LumberData[id][lumber_time]) {
            if(LumberData[id][lumber_cut]) {
            	LumberData[id][lumber_obj] = CreateDynamicObject(657, LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1], LumberData[id][lumber_pos][2] + 0.03, LumberData[id][lumber_rot][0], LumberData[id][lumber_rot][1] - 80.0, RandomFloat(0.0,360.0)+LumberData[id][lumber_rot][2], 0,0);
            }
            else {
            	LumberData[id][lumber_obj] = CreateDynamicObject(657, LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1], LumberData[id][lumber_pos][2], LumberData[id][lumber_rot][0], LumberData[id][lumber_rot][1], LumberData[id][lumber_rot][2],0,0);
            }
        }
    }
    return 1;
}

Lumber_Nearest(playerid, Float:radius = 3.0) {
    foreach(new i : Lumber) if(Iter_Contains(Lumber, i) && IsPlayerInRangeOfPoint(playerid, radius, LumberData[i][lumber_pos][0], LumberData[i][lumber_pos][1], LumberData[i][lumber_pos][2]))
    {
        if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0) {
            return i;
        }
    }
    return -1;
}

Lumber_Show(playerid) {
    if(GetPlayerJob(playerid) != JOB_LUMBERJACK) 
        return SendErrorMessage(playerid, "You're not a lumberjack!.");

    new
        tree_str[1024],
        hour, minute, second,
        count = 0;

    format(tree_str, sizeof(tree_str), "Index\tTime\tDistance ("GREEN"meters"COL_CLIENT")\n");
    foreach(new i : Lumber)
    {
        GetElapsedTime(LumberData[i][lumber_time], hour, minute, second);

        if(LumberData[i][lumber_time]) strcat(tree_str, sprintf(""BLACK"%d\t"RED"%02d:%02d:%02d\t%.2f\n", i, hour, minute, second, GetPlayerDistanceFromPoint(playerid, LumberData[i][lumber_pos][0], LumberData[i][lumber_pos][1], LumberData[i][lumber_pos][2])));
        else strcat(tree_str, sprintf(""BLACK"%d\t"GREEN"Now\t%.2f\n", i, GetPlayerDistanceFromPoint(playerid, LumberData[i][lumber_pos][0], LumberData[i][lumber_pos][1], LumberData[i][lumber_pos][2])));

        count++;
    }
    if(count) Dialog_Show(playerid, ListTree, DIALOG_STYLE_TABLIST_HEADERS, "Available Tree", tree_str, "Select", "Close");
    else SendErrorMessage(playerid, "There is no one tree spawned!.");
    return 1;
}

Lumber_Stop(playerid) {
    if(cutting_lumber[playerid] != -1)
    {
        cutting_lumber[playerid]        = -1;
        stop timer_lumber[playerid];

        ClearAnimations(playerid);
        SetPlayerArmedWeapon(playerid, 0);
        TogglePlayerControllable(playerid, 1);
        HidePlayerProgressBar(playerid, PlayerData[playerid][pCuttingBar]);
    }
    return 1;
}
// ==========================   CMD    ==========================

CMD:createtree(playerid, params[])
{
   	if(CheckAdmin(playerid, LUMBER_PERMISSION))
        return PermissionError(playerid);

    static 
    	Float: x, 
    	Float: y, 
    	Float: z, 
    	Float: a
    ;

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    x += (3.0 * floatsin(-a, degrees));
    y += (3.0 * floatcos(-a, degrees));
    z -= 1.0;

    if(add_lumber[playerid] && IsValidDynamicObject(object_lumber[playerid])) {
    	DestroyDynamicObject(object_lumber[playerid]);
    }
    
    add_lumber[playerid] = true;
    object_lumber[playerid] = CreateDynamicObject(657, x, y, z, 0.0, 0.0, 0.0, 0, 0);
    EditDynamicObject(playerid, object_lumber[playerid]);

    SendServerMessage(playerid, "Posisikan pohon ini ditempat yang pas.");
    return 1;
}

CMD:destroytree(playerid, params[])
{
    if(CheckAdmin(playerid, LUMBER_PERMISSION))
        return PermissionError(playerid);

    static
        id;

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/destroytree [id]");

    if(!Iter_Contains(Lumber, id))
        return SendErrorMessage(playerid, "You have specified an invalid tree ID.");

    if(IsValidDynamicCP(LumberData[id][lumber_cp]))
        DestroyDynamicCP(LumberData[id][lumber_cp]);

    if(IsValidDynamicObject(LumberData[id][lumber_obj]))
        DestroyDynamicObject(LumberData[id][lumber_obj]);

    SendServerMessage(playerid, "You have destroy tree id:"YELLOW"%d.", id);    
    mysql_tquery(g_iHandle, sprintf("DELETE FROM `lumber` WHERE `ID`='%d'", LumberData[id][lumber_id]));

    LumberData[id][lumber_obj]      = INVALID_OBJECT_ID;
    LumberData[id][lumber_cp]       = -1;

    LumberData[id][lumber_id]       = -1;
    LumberData[id][lumber_cut]      = 0;
    LumberData[id][lumber_getcut]   = 0;
    LumberData[id][lumber_time]     = 3600;

    LumberData[id][lumber_pos][0] = LumberData[id][lumber_pos][1] = LumberData[id][lumber_pos][2] = 0.0;
    LumberData[id][lumber_rot][0] = LumberData[id][lumber_rot][1] = LumberData[id][lumber_rot][2] = 0.0;

    Iter_Remove(Lumber, id);
    return 1;
}

CMD:edittree(playerid, params[])
{
    if(CheckAdmin(playerid, LUMBER_PERMISSION))
        return PermissionError(playerid);

    static 
        id,
        opsi[32],
        string[24];

    if(sscanf(params, "ds[32]S()[24]", id, opsi, string))
        return SendSyntaxMessage(playerid, "/edittree [id] [move/location/time]");

    if(!Iter_Contains(Lumber, id))
        return SendErrorMessage(playerid, "You have specified an invalid tree ID.");

    if(!strcmp(opsi, "move", true))
    {
        if(Lumber_Nearest(playerid) == -1)
            return SendErrorMessage(playerid, "You're not standing in near tree ID %d.", id);

        if(IsValidDynamicCP(LumberData[id][lumber_cp])) {
            DestroyDynamicCP(LumberData[id][lumber_cp]);
        }

        if(IsValidDynamicObject(LumberData[id][lumber_obj])) {
            DestroyDynamicObject(LumberData[id][lumber_obj]);
        }

        editing_lumber[playerid]    = id;
        add_lumber[playerid]        = false;
        object_lumber[playerid]     = CreateDynamicObject(657, LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1], LumberData[id][lumber_pos][2], LumberData[id][lumber_rot][0], LumberData[id][lumber_rot][1], LumberData[id][lumber_rot][2],0,0);

        EditDynamicObject(playerid, object_lumber[playerid]);

        SendServerMessage(playerid, "Now you're editing tree id: "YELLOW"%d", id);
    }
    else if(!strcmp(opsi, "location", true))
    {
        new Float:x, Float:y, Float:z, Float:a;

        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);

        x += (3.0 * floatsin(-a, degrees));
        y += (3.0 * floatcos(-a, degrees));
        z -= 1.0;

        LumberData[id][lumber_pos][0] = x;
        LumberData[id][lumber_pos][1] = y;
        LumberData[id][lumber_pos][2] = z;

        Lumber_Refresh(id);
    }
    else if(!strcmp(opsi, "time", true))
    {
        new interval;

        if(sscanf(string, "d", interval))
            return SendSyntaxMessage(playerid, "/edittree %d %s [time]", id, opsi);

        if(interval < 10 || interval > 3600)
            return SendErrorMessage(playerid, "Time must between 10 - 3600.");

        LumberData[id][lumber_time] = interval;
    }
    return 1;
}

CMD:treeid(playerid, params[])
{
    if(CheckAdmin(playerid, LUMBER_PERMISSION))
        return PermissionError(playerid);

    static
        id;

    if((id = Lumber_Nearest(playerid)) != -1) {
        SendServerMessage(playerid, "You are standing near tree ID: %d.", id);
    }
    return 1;
}

CMD:gototree(playerid, params[])
{
    if(CheckAdmin(playerid, LUMBER_PERMISSION))
        return PermissionError(playerid);

    static
        id;

    if(sscanf(params, "d", id))
        return SendSyntaxMessage(playerid, "/gototree [tree ID]");

    if(!Iter_Contains(Lumber, id))
        return SendErrorMessage(playerid, "You have specified an invalid tree ID.");

    SetPlayerPos(playerid, LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1]+1, LumberData[id][lumber_pos][2]);
    SendServerMessage(playerid, "You have teleported to tree ID: "YELLOW"%d.", id);
    return 1;
}

CMD:loadtree(playerid, params[])
{
    if(GetPlayerJob(playerid) != JOB_LUMBERJACK)
        return SendErrorMessage(playerid, "Kamu tidak seorang lumberjack.");

    static 
        i = -1, 
        id = -1, 
        kapasitas,
        Float: x, Float: y, Float: z;

    if((i = Lumber_Nearest(playerid)) != -1)
    {
        if(LumberData[i][lumber_cut])
        {
            if((id = Vehicle_Nearest(playerid, 4)) != -1)
            {
                GetVehicleBoot(VehicleData[id][cVehicle], x, y, z);

                if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))  
                    return SendErrorMessage(playerid, "Kamu tidak berada tepat di belakang pickup.");
                
                if(GetVehicleModel(VehicleData[id][cVehicle]) != 543 && GetVehicleModel(VehicleData[id][cVehicle]) != 554 && GetVehicleModel(VehicleData[id][cVehicle]) != 422)
                    return SendErrorMessage(playerid, "Ini bukan kendaraan pickup, seperti Bobcat, Sadler, atau Yosemite.");

                if(!GetTrunkStatus(VehicleData[id][cVehicle])) 
                    return SendErrorMessage(playerid, "Buka terlebih dahulu penutup belakang pickup.");

                switch(GetVehicleModel(VehicleData[id][cVehicle]))
                {
                    case 543: kapasitas = 8;
                    case 422: kapasitas = 10;
                    case 554: kapasitas = 12;
                }

                if(VehicleData[id][cLumber] >= kapasitas)
                    return SendErrorMessage(playerid, "Kapasitas penyimpanan untuk mobil %s hanya muat %d pohon.", GetVehicleNameByVehicle(VehicleData[id][cVehicle]), kapasitas);

                VehicleData[id][cLumber] ++;

                LumberData[i][lumber_cut]   = 0;
                LumberData[i][lumber_time]  = 3600;
                SetLumberSkill(playerid, 1.0);

                SendServerMessage(playerid, "Sukses meletakkan kayu ke bak mobil %s, bak mobil kini menampung "YELLOW"%d/%d.", GetVehicleNameByVehicle(VehicleData[id][cVehicle]), VehicleData[id][cLumber], kapasitas);
                ApplyAnimation(playerid, "CARRY", "putdwn105", 4.1, 0, 0, 0, 0, 0, 1);

                Lumber_Refresh(i);
            }
            else SendErrorMessage(playerid, "Tidak ada kendaraan di dekatmu.");
        }
        else SendErrorMessage(playerid, "Pohon di dekatmu belum di tebang.");
    }
    else SendErrorMessage(playerid, "Kamu tidak berada di dekat pohon.");
    return 1;
}
// ==========================  Dialog  ==========================

Dialog:ListTree(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new id = strval(inputtext);
        
        SetPlayerWaypoint(playerid, "Tree location", LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1], LumberData[id][lumber_pos][2]);
        SendServerMessage(playerid, "Waypoint set to tree id \"%d\" (marked on radar).", id);
    }
    return 1;
}

// ==========================  Timer  ==========================

task Lumber_Timer[1000]()
{
    foreach(new ids : Lumber) if(Iter_Contains(Lumber, ids) && LumberData[ids][lumber_time])
    {
        if(--LumberData[ids][lumber_time] == 0)
        {
            Lumber_Refresh(ids);
        }
    }
}

timer Lumber_Player_Tim[1000](playerid)
{
    if(cutting_lumber[playerid] != -1)
    {
        new id = cutting_lumber[playerid];
        
        if(GetPlayerWeapon(playerid) == 9 && IsPlayerInDynamicCP(playerid, LumberData[id][lumber_cp]))
        {
            new 
                Float: value = (GetPlayerProgressBarValue(playerid, PlayerData[playerid][pCuttingBar]) + 2.0);
            
            if(value >= 50.0)
            {
                MoveDynamicObject(LumberData[id][lumber_obj], LumberData[id][lumber_pos][0], LumberData[id][lumber_pos][1], LumberData[id][lumber_pos][2]+0.03, 0.025, LumberData[id][lumber_rot][0], LumberData[id][lumber_rot][1] - 80.0, RandomFloat(0.0,360.0)+LumberData[id][lumber_rot][2]);

                Lumber_Stop(playerid);

                LumberData[id][lumber_getcut]   = 0;
                LumberData[id][lumber_cut]      = 1;
                return 1;
            }
            SetPlayerProgressBarValue(playerid, PlayerData[playerid][pCuttingBar], value);
        }
        else
        {
            Lumber_Stop(playerid);
            LumberData[id][lumber_getcut]   = 0;
            SendServerMessage(playerid, "Kamu menggagalkan proses pemotongan pohon tersebut.");
        }
    }
    return 1;
}

ptask Lumber_Detail_Tim[1000](playerid) 
{
    static
        id = -1;

    if((id = Lumber_Nearest(playerid)) != -1)
    {
        if(IsPlayerInDynamicCP(playerid, LumberData[id][lumber_cp]) && GetPlayerJob(playerid) == JOB_LUMBERJACK && GetPlayerVirtualWorld(playerid) == 0)
        {
            if(!LumberData[id][lumber_cut])
            {
                if(LumberData[id][lumber_time])
                {
                    static
                        times[3];

                    GetElapsedTime(LumberData[id][lumber_time], times[0], times[1], times[2]);
                    GameTextForPlayer(playerid, sprintf("~g~~h~Harap Menunggu...~n~~y~~h~%02d:%02d:%02d", times[0], times[1], times[2]), 1000, 4);
                }
                else
                {
                    if(LumberData[id][lumber_getcut]) GameTextForPlayer(playerid, "~g~~h~Memotong pohon ..", 1000, 4);
                    else GameTextForPlayer(playerid, "~g~~h~Potong pohon~n~~y~~h~dengan chainsaw '~w~N~y~~h~'", 1000, 4);
                }
            }
            else GameTextForPlayer(playerid, "~g~~h~/loadtree~n~~y~~h~untuk_meletakkan~n~~y~~h~ke_mobil_pickup.", 1000, 4);   
        }
    }
}