#include <YSI\y_hooks>


forward Plant_Load();
public Plant_Load()
{
    if(cache_num_rows())
    {
        for(new i = 0; i != cache_num_rows(); i++)
        {
            Iter_Add(Plants, i);

            PlantData[i][plantID] = cache_get_field_int(i, "plantID");
            PlantData[i][plantType] = cache_get_field_int(i, "plantType");
            PlantData[i][plantTime] = cache_get_field_int(i, "plantTime");

            PlantData[i][plantExpired] = 0;
            PlantData[i][plantHarvest] = INVALID_PLANT_ID;

            PlantData[i][plantPos][0] = cache_get_field_float(i, "plantX");
            PlantData[i][plantPos][1] = cache_get_field_float(i, "plantY");
            PlantData[i][plantPos][2] = cache_get_field_float(i, "plantZ");
            PlantData[i][plantPos][3] = cache_get_field_float(i, "plantA");

            Plant_Sync(i);
        }
        printf("*** Loaded %d plants", cache_num_rows());
    }
    return 1;
}

forward OnPlantCreated(index);
public OnPlantCreated(index)
{
    PlantData[index][plantID] = cache_insert_id();

    Plant_Save(index);
    Plant_Sync(index);
    return 1;
}


hook OnGameModeInitEx()
{
    mysql_pquery(g_iHandle, "SELECT * FROM `plants` ORDER BY `plantID` ASC LIMIT "#MAX_DYNAMIC_PLANTS";", "Plant_Load", "");
}

task Plants_Update[60000]()
{
    foreach(new i : Plants)
    {
        if(Plant_GetTime(i) > 0)
        {
            Plant_SetTime(i, Plant_GetTime(i) - 1);
            Plant_Save(i);
        }
        else
        {
            Plant_SetExpired(i, Plant_GetExpired(i) + 1);

            if(Plant_GetExpired(i) >= PLANT_HARVEST_TIME)
            {
                Plant_Delete(i, true);

                new next;
                Iter_SafeRemove(Plants, i, next);
                i = next;
            }
        }
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    Plant_ResetPlayer(playerid);
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(GetPlayerHarvestingPlant(playerid))
    {
        new index = GetPlayerNearestPlant(playerid);
        
        if(Plant_IsExists(index)) {
            PlantData[index][plantHarvest] = INVALID_PLANT_ID;
        }

        Plant_ResetPlayer(playerid);
    }
}

ptask Player_PlantingUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
        
    static
        plantid;

    if((plantid = GetPlayerNearestPlant(playerid)) != INVALID_PLANT_ID)
    {
        if(!Plant_IsExists(plantid))
            Plant_ResetPlayer(playerid);

        if(GetPlayerHarvestingPlant(playerid))
        {
            SetPlayerHarvestingTime(playerid, (GetPlayerHarvestingTime(playerid) - 1));

            if(GetPlayerHarvestingTime(playerid))
            {
                ShowPlayerFooter(playerid, sprintf("Memanen tanaman ~g~~h~%s ~w~(waktu: ~y~%d/"#PLANT_HARVEST_WAITING" ~w~) ...", Plant_GetName(plantid), (PLANT_HARVEST_WAITING - GetPlayerHarvestingTime(playerid))));
            }
            else
            {
                Plant_ResetPlayer(playerid);
                PlantData[plantid][plantHarvest] = INVALID_PLANT_ID;

                switch(Plant_GetType(plantid))
                {
                    case e_PLANT_WEED:
                    {
                        if(Inventory_Add(playerid, "Marijuana", 1578, PLANT_HARVEST_AMOUNT) == -1)
                            return 1;

                        SendServerMessage(playerid, "Kamu telah memanen "YELLOW"%d marijuana", 5);
                    }
                    case e_PLANT_COCAINE:
                    {
                        if(Inventory_Add(playerid, "Cocaine", 1575, PLANT_HARVEST_AMOUNT) == -1)
                            return 1;

                        SendServerMessage(playerid, "Kamu telah memanen "YELLOW"%d cocaine", 5);
                    }
                    case e_PLANT_HEROIN:
                    {
                        if(Inventory_Add(playerid, "Heroin", 1577, PLANT_HARVEST_AMOUNT) == -1)
                            return 1;

                        SendServerMessage(playerid, "Kamu telah memanen "YELLOW"%d heroin", 5);
                    }
                }

                Plant_Delete(plantid);
                HidePlayerFooter(playerid);
                SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s finished harvesting the drug plant.", ReturnName(playerid, 0, 1));
            }
        }
        else
        {
            if(Plant_GetTime(plantid)) GameTextForPlayer(playerid, sprintf("~y~~h~%s~n~~g~~h~%d menit~w~ tersisa", Plant_GetName(plantid), Plant_GetTime(plantid)), 1000, 4);
            else GameTextForPlayer(playerid, sprintf("~y~~h~%s~n~~w~Waktunya panen!", Plant_GetName(plantid)), 1000, 4);
        }
    }
    return 1;
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	new streamer_info[2];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, streamer_info);

    if(streamer_info[0] == PLANT_AREA_INDEX)
    {
        new index = streamer_info[1];

        if(Plant_IsExists(index)) {
        	SetPlayerNearestPlant(playerid, index);
        }
    }
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	new streamer_info[2];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, streamer_info);

    if(streamer_info[0] == PLANT_AREA_INDEX)
    {
        if(GetPlayerHarvestingPlant(playerid))
        {
            Plant_ResetPlayer(playerid);

            new index = streamer_info[1];
            if(Plant_IsExists(index))
                PlantData[index][plantHarvest] = INVALID_PLANT_ID;

            ShowPlayerFooter(playerid, "~r~[ERROR] ~w~Gagal memanen, terlalu jauh dari posisi tanaman!");
        }

    	SetPlayerNearestPlant(playerid, INVALID_PLANT_ID);
    }
}