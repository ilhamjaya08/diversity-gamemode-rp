#include <YSI\y_hooks>

#define MAX_DYNAMIC_ANIMAL              (1000)
#define ANIMAL_COW                      (19833)
#define ANIMAL_DEER                     (19315)


enum
{
    SAVE_HUNTING_ALL = 0,
    SAVE_HUNTING_POS,
    SAVE_HUNTING_TIME,
    SAVE_HUNTING_GUTTING
}

enum E_HUNTING_DATA {
    animalID,
    animalTime,

    animalGut,

    Float:animalPos[3],
    Float:animalRot[3],

    animalModel,
    animalObject,
    animalHealth
};

// Variable List
new AnimalData[MAX_DYNAMIC_ANIMAL][E_HUNTING_DATA];
new Iterator:Animals<MAX_DYNAMIC_ANIMAL>;

// Event List
// hook OnGameModeInitEx()
// {
//     mysql_pquery(g_iHandle, sprintf("SELECT * FROM `animals` ORDER BY `ID` ASC LIMIT %d;", MAX_DYNAMIC_ANIMAL), "Animal_Load", "");
// }

forward Animal_Load();
public Animal_Load()
{
    if(cache_num_rows())
    {
        for (new id = 0; id < cache_num_rows(); id ++)
        {
            new destinasi[64];

            Iter_Add(Animals, id);

            AnimalData[id][animalID]   = cache_get_field_int(id,"ID");
            AnimalData[id][animalGut]  = cache_get_field_int(id,"Potong");
            AnimalData[id][animalHealth]  = cache_get_field_int(id,"Health");
            AnimalData[id][animalTime] = cache_get_field_int(id,"Time");
            AnimalData[id][animalModel] = cache_get_field_int(id,"Model");

            cache_get_field_content(id, "Pos", destinasi, sizeof(destinasi));
            sscanf(destinasi, "p<|>fff", AnimalData[id][animalPos][0], AnimalData[id][animalPos][1], AnimalData[id][animalPos][2]);

            cache_get_field_content(id, "Rot", destinasi, sizeof(destinasi));
            sscanf(destinasi, "p<|>fff", AnimalData[id][animalRot][0], AnimalData[id][animalRot][1], AnimalData[id][animalRot][2]);

            Animal_Sync(id);
        }
        printf("*** Loaded %d Animals.", cache_num_rows());
    }
    return 1;
}

forward OnAnimalCreated(animal_id);
public OnAnimalCreated(animal_id)
{
    if(Animal_Exists(animal_id))
    {
        AnimalData[animal_id][animalID] = cache_insert_id();

        Animal_Sync(animal_id);
        Animal_Save(animal_id);
        return 1;
    }
    return 0;
}

// Function List
Animal_Create(modelid, Float:x, Float:y, Float:z) 
{
    new index;

    if((index = Iter_Free(Animals)) != INVALID_ITERATOR_SLOT)
    {
        Iter_Add(Animals, index);

        AnimalData[index][animalGut] = false;
        AnimalData[index][animalTime] = 3600;

        AnimalData[index][animalModel] = modelid;
        AnimalData[index][animalPos][0] = x;
        AnimalData[index][animalPos][1] = y;
        AnimalData[index][animalPos][2] = (modelid == 19315) ? z+0.5 : z;
        AnimalData[index][animalHealth] = 100;

        AnimalData[index][animalRot][0] = AnimalData[index][animalRot][1] = AnimalData[index][animalRot][2] = 0.0;

        mysql_tquery(g_iHandle, sprintf("INSERT INTO `animals` (`Time`) VALUES(%d);", AnimalData[index][animalTime]), "OnAnimalCreated", "d", index);
        return index;
    }
    return INVALID_ITERATOR_SLOT;
}

Animal_Delete(animal_id)
{
    if(Animal_Exists(animal_id))
    {
        Iter_Remove(Animals, animal_id);
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `animals` WHERE `ID` = '%d';", AnimalData[animal_id][animalID]));

        if(IsValidDynamicObject(AnimalData[animal_id][animalObject]))
            DestroyDynamicObject(AnimalData[animal_id][animalObject]);

        new tmp_AnimalData[E_HUNTING_DATA];
        AnimalData[animal_id] = tmp_AnimalData;

        AnimalData[animal_id][animalObject] = INVALID_STREAMER_ID;
        return 1;
    }
    return 0;
}

Animal_Nearest(playerid, Float:radius = 3.0)
{
    new id = -1, Float: playerdist, Float: tempdist = 9999.0;
    
    foreach(new i : Animals)
    {
        playerdist = GetPlayerDistanceFromPoint(playerid, AnimalData[i][animalPos][0], AnimalData[i][animalPos][1], AnimalData[i][animalPos][2]);
        
        if(playerdist > radius) continue;
        
        if(playerdist <= tempdist) {
            tempdist = playerdist;
            id = i;
        }
    }
    
    return id;
}

Animal_Save(animal_id, type = SAVE_HUNTING_ALL)
{
    if(Lumber_Exists(animal_id)) {
        new query[500];

        switch(type)
        {
            case SAVE_HUNTING_ALL: {
                mysql_format(g_iHandle, query, sizeof(query), "UPDATE `animals` SET `Model`='%d', `Health` ='%d', `Potong`='%d', `Time`='%d', `Pos`='%.4f|%.4f|%.4f', `Rot`='%.4f|%.4f|%.4f' WHERE `ID`='%d'", AnimalData[animal_id][animalModel], AnimalData[animal_id][animalHealth], AnimalData[animal_id][animalGut], AnimalData[animal_id][animalTime], AnimalData[animal_id][animalPos][0], AnimalData[animal_id][animalPos][1], AnimalData[animal_id][animalPos][2], AnimalData[animal_id][animalRot][0],AnimalData[animal_id][animalRot][1], AnimalData[animal_id][animalRot][2], AnimalData[animal_id][animalID]);
            }
            case SAVE_HUNTING_POS: {
                mysql_format(g_iHandle, query, sizeof(query), "UPDATE `animals` SET `Pos`='%.4f|%.4f|%.4f', `Rot`='%.4f|%.4f|%.4f' WHERE `ID`='%d'", AnimalData[animal_id][animalPos][0], AnimalData[animal_id][animalPos][1], AnimalData[animal_id][animalPos][2], AnimalData[animal_id][animalRot][0], AnimalData[animal_id][animalRot][1], AnimalData[animal_id][animalRot][2], AnimalData[animal_id][animalID]);
            }
            case SAVE_HUNTING_TIME: {
                mysql_format(g_iHandle, query, sizeof(query), "UPDATE `animals` SET `Time`='%d' WHERE `ID`='%d'", AnimalData[animal_id][animalTime], AnimalData[animal_id][animalID]);
            }
            case SAVE_HUNTING_GUTTING: {
                mysql_format(g_iHandle, query, sizeof(query), "UPDATE `animals` SET `Potong`='%d' WHERE `ID`='%d'", AnimalData[animal_id][animalGut], AnimalData[animal_id][animalID]);
            }
        }
        return mysql_tquery(g_iHandle, query);
    }
    return 0;
}

Animal_Sync(animal_id)
{
   if(Animal_Exists(animal_id))
   {
        if(AnimalData[animal_id][animalTime]) 
        {
            if(IsValidDynamicObject(AnimalData[animal_id][animalObject]))
                DestroyDynamicObject(AnimalData[animal_id][animalObject]);

            AnimalData[animal_id][animalObject] = INVALID_STREAMER_ID;
        }
        else 
        {
            if(IsValidDynamicObject(AnimalData[animal_id][animalObject])) 
            {
                Animal_UpdatePos(animal_id);
            }
            else 
            {
                if(AnimalData[animal_id][animalGut]) AnimalData[animal_id][animalObject] = CreateDynamicObject(AnimalData[animal_id][animalModel], AnimalData[animal_id][animalPos][0], AnimalData[animal_id][animalPos][1], AnimalData[animal_id][animalPos][2] - 1.0, AnimalData[animal_id][animalRot][0], AnimalData[animal_id][animalRot][1] - 80.0, RandomFloat(0.0,360.0)+AnimalData[animal_id][animalRot][2], 0, 0, -1);
                else AnimalData[animal_id][animalObject] = CreateDynamicObject(AnimalData[animal_id][animalModel], AnimalData[animal_id][animalPos][0], AnimalData[animal_id][animalPos][1], AnimalData[animal_id][animalPos][2] - 1.0, AnimalData[animal_id][animalRot][0], AnimalData[animal_id][animalRot][1], AnimalData[animal_id][animalRot][2], 0, 0, -1);
                Streamer_SetIntData(STREAMER_TYPE_OBJECT, AnimalData[animal_id][animalObject], E_STREAMER_EXTRA_ID, animal_id);
            }
        }
        return 1;
   } 
   return 0;
}

Animal_UpdatePos(animal_id)
{
    if(Animal_Exists(animal_id)) 
    {
        new object = AnimalData[animal_id][animalObject],
            cutting = AnimalData[animal_id][animalGut];

        Streamer_SetIntData(STREAMER_TYPE_OBJECT, object, E_STREAMER_MODEL_ID, AnimalData[animal_id][animalModel]);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_X, AnimalData[animal_id][animalPos][0]);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_Y, AnimalData[animal_id][animalPos][1]);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_Z, (AnimalData[animal_id][animalPos][2] - 1.0));

        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_R_X, AnimalData[animal_id][animalRot][0]);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_R_Y, (cutting) ? (AnimalData[animal_id][animalRot][1] - 80.0) : AnimalData[animal_id][animalRot][1]);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, object, E_STREAMER_R_Z, (cutting) ? (AnimalData[animal_id][animalRot][2] + RandomFloat(0.0,360.0)) : AnimalData[animal_id][animalRot][2]);
        Streamer_SetIntData(STREAMER_TYPE_OBJECT, object, E_STREAMER_EXTRA_ID, animal_id);
        return 1;
    }
    return 0;
}

Animal_SetPosition(animal_id, Float:x, Float:y, Float:z)
{
    if(Animal_Exists(animal_id)) {
        AnimalData[animal_id][animalPos][0] = x;
        AnimalData[animal_id][animalPos][1] = y;
        AnimalData[animal_id][animalPos][2] = z;
        return 1;
    }
    return 0;
}

Animal_SetTime(animal_id, time)
{
    if(Animal_Exists(animal_id)) {
        AnimalData[animal_id][animalTime] = time;
        return 1;
    }
    return 0;
}

// Animal_SetGutting(animal_id, bool:gutting)
// {
//     if(Animal_Exists(animal_id)) {
//         AnimalData[animal_id][animalGut] = gutting;
//         return 1;
//     }
//     return 0;
// }

Animal_Exists(animal_id)
{
    if(Iter_Contains(Animals, animal_id))
        return 1;

    return 0;
}