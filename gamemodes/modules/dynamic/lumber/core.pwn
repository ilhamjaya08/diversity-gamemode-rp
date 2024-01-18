#include <YSI\y_hooks>

#define MAX_DYNAMIC_LUMBER              (50)

new Timer:lumber_timer[MAX_PLAYERS];

enum
{
    SAVE_LUMBER_ALL = 0,
    SAVE_LUMBER_POS,
    SAVE_LUMBER_TIME,
    SAVE_LUMBER_CUTTING
}

enum E_LUMBER_DATA {
    lumberID,
    lumberTime,

    lumberCut,
    bool:lumberGetCut,

    Float:lumberPos[3],
    Float:lumberRot[3],

    lumberCP,
    lumberObject
};

// Variable List
new LumberData[MAX_DYNAMIC_LUMBER][E_LUMBER_DATA];
new Iterator:Lumbers<MAX_DYNAMIC_LUMBER>;

// Event List
hook OnGameModeInitEx()
{
    mysql_pquery(g_iHandle, sprintf("SELECT * FROM `lumber` ORDER BY `ID` ASC LIMIT %d;", MAX_DYNAMIC_LUMBER), "Lumber_Load", "");
}

forward Lumber_Load();
public Lumber_Load()
{
    if(cache_num_rows())
    {
        for (new id = 0; id < cache_num_rows(); id ++)
        {
            new destinasi[64];

            Iter_Add(Lumbers, id);

            LumberData[id][lumberID]   = cache_get_field_int(id,"ID");
            LumberData[id][lumberCut]  = cache_get_field_int(id,"Tebang");
            LumberData[id][lumberTime] = cache_get_field_int(id,"Time");

            cache_get_field_content(id, "Pos", destinasi, sizeof(destinasi));
            sscanf(destinasi, "p<|>fff", LumberData[id][lumberPos][0], LumberData[id][lumberPos][1], LumberData[id][lumberPos][2]);

            cache_get_field_content(id, "Rot", destinasi, sizeof(destinasi));
            sscanf(destinasi, "p<|>fff", LumberData[id][lumberRot][0], LumberData[id][lumberRot][1], LumberData[id][lumberRot][2]);

            Lumber_Sync(id);
        }
        printf("*** Loaded %d lumber.", cache_num_rows());
    }
    return 1;
}

forward OnLumberCreated(lumber_id);
public OnLumberCreated(lumber_id)
{
    if(Lumber_Exists(lumber_id))
    {
        LumberData[lumber_id][lumberID] = cache_insert_id();

        Lumber_Sync(lumber_id);
        Lumber_Save(lumber_id);
        return 1;
    }
    return 0;
}

// Function List
Lumber_Create(Float:x, Float:y, Float:z) 
{
    new index;

    if((index = Iter_Free(Lumbers)) != INVALID_ITERATOR_SLOT)
    {
        Iter_Add(Lumbers, index);

        LumberData[index][lumberCut] = false;
        LumberData[index][lumberGetCut] = false;
        LumberData[index][lumberTime] = 3600;

        LumberData[index][lumberPos][0] = x;
        LumberData[index][lumberPos][1] = y;
        LumberData[index][lumberPos][2] = z;

        LumberData[index][lumberRot][0] = LumberData[index][lumberRot][1] = LumberData[index][lumberRot][2] = 0.0;

        mysql_tquery(g_iHandle, sprintf("INSERT INTO `lumber` (`Time`) VALUES(%d);", LumberData[index][lumberTime]), "OnLumberCreated", "d", index);
        return index;
    }
    return INVALID_ITERATOR_SLOT;
}

Lumber_Delete(lumber_id)
{
    if(Lumber_Exists(lumber_id))
    {
        Iter_Remove(Lumbers, lumber_id);
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `lumber` WHERE `ID` = '%d';", LumberData[lumber_id][lumberID]));

        if(IsValidDynamicObject(LumberData[lumber_id][lumberObject]))
            DestroyDynamicObject(LumberData[lumber_id][lumberObject]);

        if(IsValidDynamicCP(LumberData[lumber_id][lumberCP]))
            DestroyDynamicCP(LumberData[lumber_id][lumberCP]);

        new tmp_LumberData[E_LUMBER_DATA];
        LumberData[lumber_id] = tmp_LumberData;

        LumberData[lumber_id][lumberObject] = INVALID_STREAMER_ID;
        LumberData[lumber_id][lumberCP] = INVALID_STREAMER_ID;
        return 1;
    }
    return 0;
}

Lumber_Nearest(playerid, Float:radius = 3.0)
{
    new id = -1, Float: playerdist, Float: tempdist = 9999.0;
    
    foreach(new i : Lumbers)
    {
        playerdist = GetPlayerDistanceFromPoint(playerid, LumberData[i][lumberPos][0], LumberData[i][lumberPos][1], LumberData[i][lumberPos][2]);
        
        if(playerdist > radius) continue;
        
        if(playerdist <= tempdist) {
            tempdist = playerdist;
            id = i;
        }
    }
    
    return id;
}

Lumber_Save(lumber_id, type = SAVE_LUMBER_ALL)
{
    if(Lumber_Exists(lumber_id)) {
        new query[500];

        switch(type)
        {
            case SAVE_LUMBER_ALL: {
                mysql_format(g_iHandle, query, sizeof(query), "UPDATE `lumber` SET `Tebang`='%d', `Time`='%d', `Pos`='%.4f|%.4f|%.4f', `Rot`='%.4f|%.4f|%.4f' WHERE `ID`='%d'", LumberData[lumber_id][lumberCut], LumberData[lumber_id][lumberTime], LumberData[lumber_id][lumberPos][0], LumberData[lumber_id][lumberPos][1], LumberData[lumber_id][lumberPos][2], LumberData[lumber_id][lumberRot][0],LumberData[lumber_id][lumberRot][1], LumberData[lumber_id][lumberRot][2], LumberData[lumber_id][lumberID]);
            }
            case SAVE_LUMBER_POS: {
                mysql_format(g_iHandle, query, sizeof(query), "UPDATE `lumber` SET `Pos`='%.4f|%.4f|%.4f', `Rot`='%.4f|%.4f|%.4f' WHERE `ID`='%d'", LumberData[lumber_id][lumberPos][0], LumberData[lumber_id][lumberPos][1], LumberData[lumber_id][lumberPos][2], LumberData[lumber_id][lumberRot][0], LumberData[lumber_id][lumberRot][1], LumberData[lumber_id][lumberRot][2], LumberData[lumber_id][lumberID]);
            }
            case SAVE_LUMBER_TIME: {
                mysql_format(g_iHandle, query, sizeof(query), "UPDATE `lumber` SET `Time`='%d' WHERE `ID`='%d'", LumberData[lumber_id][lumberTime], LumberData[lumber_id][lumberID]);
            }
            case SAVE_LUMBER_CUTTING: {
                mysql_format(g_iHandle, query, sizeof(query), "UPDATE `lumber` SET `Tebang`='%d' WHERE `ID`='%d'", LumberData[lumber_id][lumberCut], LumberData[lumber_id][lumberID]);
            }
        }
        return mysql_tquery(g_iHandle, query);
    }
    return 0;
}

Lumber_Sync(lumber_id)
{
   if(Lumber_Exists(lumber_id))
   {
        if(IsValidDynamicCP(LumberData[lumber_id][lumberCP])) Lumber_UpdatePos(lumber_id, 1);
        else LumberData[lumber_id][lumberCP] = CreateDynamicCP(LumberData[lumber_id][lumberPos][0], LumberData[lumber_id][lumberPos][1], (LumberData[lumber_id][lumberPos][2] - 2.0), 2, 0, 0, -1, 5);

        if(LumberData[lumber_id][lumberTime]) {
            if(IsValidDynamicObject(LumberData[lumber_id][lumberObject]))
                DestroyDynamicObject(LumberData[lumber_id][lumberObject]);

            LumberData[lumber_id][lumberObject] = INVALID_STREAMER_ID;
        }
        else {
            if(IsValidDynamicObject(LumberData[lumber_id][lumberObject])) {
                Lumber_UpdatePos(lumber_id, 2);
            }
            else {
                if(LumberData[lumber_id][lumberCut]) LumberData[lumber_id][lumberObject] = CreateDynamicObject(657, LumberData[lumber_id][lumberPos][0], LumberData[lumber_id][lumberPos][1], LumberData[lumber_id][lumberPos][2] - 1.0, LumberData[lumber_id][lumberRot][0], LumberData[lumber_id][lumberRot][1] - 80.0, RandomFloat(0.0,360.0)+LumberData[lumber_id][lumberRot][2], 0, 0, -1);
                else LumberData[lumber_id][lumberObject] = CreateDynamicObject(657, LumberData[lumber_id][lumberPos][0], LumberData[lumber_id][lumberPos][1], LumberData[lumber_id][lumberPos][2] - 1.0, LumberData[lumber_id][lumberRot][0], LumberData[lumber_id][lumberRot][1], LumberData[lumber_id][lumberRot][2], 0, 0, -1);
            }
        }
        return 1;
   } 
   return 0;
}

Lumber_UpdatePos(lumber_id, type)
{
    if(Lumber_Exists(lumber_id)) {
        if(type == 1) {
            new cp = LumberData[lumber_id][lumberCP],
                time = LumberData[lumber_id][lumberTime];

            Streamer_SetFloatData(STREAMER_TYPE_CP, cp, E_STREAMER_X, LumberData[lumber_id][lumberPos][0]);
            Streamer_SetFloatData(STREAMER_TYPE_CP, cp, E_STREAMER_Y, LumberData[lumber_id][lumberPos][1]);
            Streamer_SetFloatData(STREAMER_TYPE_CP, cp, E_STREAMER_Z, (time) ? LumberData[lumber_id][lumberPos][2] : (LumberData[lumber_id][lumberPos][2] - 2));
        }
        else if(type == 2) {
            new object = LumberData[lumber_id][lumberObject],
                cutting = LumberData[lumber_id][lumberCut];

            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_X, LumberData[lumber_id][lumberPos][0]);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_Y, LumberData[lumber_id][lumberPos][1]);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_Z, (LumberData[lumber_id][lumberPos][2] - 1.0));

            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_R_X, LumberData[lumber_id][lumberRot][0]);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_R_Y, (cutting) ? (LumberData[lumber_id][lumberRot][1] - 80.0) : LumberData[lumber_id][lumberRot][1]);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_R_Z, (cutting) ? (LumberData[lumber_id][lumberRot][2] + RandomFloat(0.0,360.0)) : LumberData[lumber_id][lumberRot][2]);
        }
        return 1;
    }
    return 0;
}

Lumber_SetPosition(lumber_id, Float:x, Float:y, Float:z)
{
    if(Lumber_Exists(lumber_id)) {
        LumberData[lumber_id][lumberPos][0] = x;
        LumberData[lumber_id][lumberPos][1] = y;
        LumberData[lumber_id][lumberPos][2] = z;
        return 1;
    }
    return 0;
}

Lumber_SetTime(lumber_id, time)
{
    if(Lumber_Exists(lumber_id)) {
        LumberData[lumber_id][lumberTime] = time;
        return 1;
    }
    return 0;
}

stock Lumber_SetCutting(lumber_id, bool:cutting)
{
    if(Lumber_Exists(lumber_id)) {
        LumberData[lumber_id][lumberCut] = cutting;
        return 1;
    }
    return 0;
}

Lumber_Exists(lumber_id)
{
    if(Iter_Contains(Lumbers, lumber_id))
        return 1;

    return 0;
}

// Player function
Reset_Lumber(playerid)
{
    stop lumber_timer[playerid];
    SetPVarInt(playerid, "lumber_cutting", -1);

    ClearAnimations(playerid);
    TogglePlayerControllable(playerid, 1);
    HidePlayerProgressBar(playerid, PlayerData[playerid][pCuttingBar]);
}

Show_Lumber(playerid) 
{
    if(GetPlayerJob(playerid) != JOB_LUMBERJACK) 
        return SendErrorMessage(playerid, "Kamu bukan seorang pekerja lumberjack!.");

    new tree_str[2048], hour, minute, second, count;

    strcat(tree_str, "Time\tDistance ("GREEN"meters"COL_CLIENT")\n");
    foreach(new i : Lumbers)
    {
        GetElapsedTime(LumberData[i][lumberTime], hour, minute, second);

        if(LumberData[i][lumberTime]) strcat(tree_str, sprintf(""RED"%02d:%02d:%02d\t%.2f\n", hour, minute, second, GetPlayerDistanceFromPoint(playerid, LumberData[i][lumberPos][0], LumberData[i][lumberPos][1], LumberData[i][lumberPos][2])));
        else strcat(tree_str, sprintf(""GREEN"Now\t%.2f\n", GetPlayerDistanceFromPoint(playerid, LumberData[i][lumberPos][0], LumberData[i][lumberPos][1], LumberData[i][lumberPos][2])));

        count++;
    }

    if(count) Dialog_Show(playerid, ListTree, DIALOG_STYLE_TABLIST_HEADERS, "Available Tree", tree_str, "Select", "Close");
    else SendErrorMessage(playerid, "Tidak ada lumber yang dibuat diserver!.");
    return 1;
}

// Dialog respons
Dialog:ListTree(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new id = listitem;
        
        SetPlayerWaypoint(playerid, "Tree location", LumberData[id][lumberPos][0], LumberData[id][lumberPos][1], LumberData[id][lumberPos][2]);
        SendServerMessage(playerid, "Ikuti waypoint yang ada diradar map kamu.");
    }
    return 1;
}