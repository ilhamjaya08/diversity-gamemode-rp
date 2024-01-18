Plant_Exists(index)
{
    if(Iter_Contains(FarmPlant, index))
        return 1;

    return 0;
}

IsPlayerNearPlant(playerid)
{
    new index;
    index = FarmPlant_Nearest(playerid);

    if(index != INVALID_FARM_PLANT)
        return 1;

    return 0;
}

FarmPlant_Nearest(playerid)
{
    foreach(new i : FarmPlant)
    {
        if(Plant_Exists(i))
        {
            new 
                Float:prev_x = FarmerData[i][plantPosX],
                Float:prev_y = FarmerData[i][plantPosY],  
                Float:prev_z = FarmerData[i][plantPosZ]
            ;

            if(IsPlayerInRangeOfPoint(playerid, 5.0, prev_x, prev_y, prev_z))
                return i;
        }              
    }
    return INVALID_FARM_PLANT;
}

Plant_Count(playerid)
{
    new count = 0;
    foreach(new i : FarmPlant)
    {
        if(Plant_Exists(i))
        {
            if(FarmerData[i][plantOwner] == GetPlayerSQLID(playerid))
            {
                count++;
            }
        }
    }
    return count;
}

CreatePlayerPlant(playerid)
{
    static index;
    if((index = Iter_Free(FarmPlant)) != cellmin)
    {
        Iter_Add(FarmPlant, index);

        new Float:x, Float:y, Float:z, string[1024];
        GetPlayerPos(playerid, x, y, z);

        FarmerData[index][plantOwner] = GetPlayerSQLID(playerid);

        format(FarmerData[index][plantOwnerName], 128, "%s", ReturnName(playerid));

        FarmerData[index][plantPosX] = x;
        FarmerData[index][plantPosY] = y;
        FarmerData[index][plantPosZ] = z;

        FarmerData[index][plantTime] = 0;

        FarmerData[index][plantPercentage] = 0.0;

        FarmerData[index][plantObject] = CreateDynamicObject(855, x, y, z - 3, 0.0, 0.0, 0, 0, 0, -1, 100, 100);
        
        format(string, sizeof(string), ""GREEN"Ready\n"YELLOW"%s's wheat plant\n"RED"Status: %.2f%%\n"GREEN"Growing", ReturnName(playerid), FarmerData[index][plantPercentage]);
        FarmerData[index][plantText] = CreateDynamic3DTextLabel(string, COLOR_WHITE, x, y, z, 10);
        return index;   
    }
    return INVALID_FARM_PLANT;
}

Plant_Destroy(playerid)
{
    foreach(new index : FarmPlant)
    {
        if(Plant_Exists(index))
        {
            if(FarmerData[index][plantOwner] == GetPlayerSQLID(playerid))
            {
                if(IsValidDynamicObject(FarmerData[index][plantObject]))
                    DestroyDynamicObject(FarmerData[index][plantObject]);
                
                if(IsValidDynamic3DTextLabel(FarmerData[index][plantText]))
                    DestroyDynamic3DTextLabel(FarmerData[index][plantText]);

                new tmp_FarmerData[E_FARMER_DATA];
                FarmerData[index] = tmp_FarmerData;

                FarmerData[index][plantObject] = INVALID_STREAMER_ID;
                FarmerData[index][plantText] = Text3D:INVALID_STREAMER_ID;

                new current = index;
                Iter_SafeRemove(FarmPlant, current, index);
            }
        }
    }
    return 1;
}

HarvestPlayerPlant(playerid, index)
{
    if(Plant_Exists(index))
    {
        Iter_Remove(FarmPlant, index);

        Plant_TimerCount[playerid] = 0;
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);

        if(IsValidDynamicObject(FarmerData[index][plantObject]))
            DestroyDynamicObject(FarmerData[index][plantObject]);
        
        if(IsValidDynamic3DTextLabel(FarmerData[index][plantText]))
            DestroyDynamic3DTextLabel(FarmerData[index][plantText]);

        DropItem("Wheat Plant", "Farmer", 743, 1, x, y, z - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));

        new tmp_FarmerData[E_FARMER_DATA];
        FarmerData[index] = tmp_FarmerData;

        FarmerData[index][plantObject] = INVALID_STREAMER_ID;
        FarmerData[index][plantText] = Text3D:INVALID_STREAMER_ID;
    }
    return INVALID_FARM_PLANT;
}

UpdatePlayerPlant(index)
{
    if(Plant_Exists(index))
    {
        new string[1024];
        if(IsValidDynamic3DTextLabel(FarmerData[index][plantText]))
        {
            Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, FarmerData[index][plantText], E_STREAMER_X, FarmerData[index][plantPosX]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, FarmerData[index][plantText], E_STREAMER_Y, FarmerData[index][plantPosY]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, FarmerData[index][plantText], E_STREAMER_Z, FarmerData[index][plantPosZ]);
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, FarmerData[index][plantText], E_STREAMER_INTERIOR_ID, 0);
			Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, FarmerData[index][plantText], E_STREAMER_WORLD_ID, 0);

            if(FarmerData[index][plantPercentage] < 100)
            {
                if(FarmerData[index][plantTime] <= 0)
                {
                    format(string, sizeof(string), ""GREEN"Ready\n"YELLOW"%s's wheat plant\n"RED"Status: %.2f%%\n"GREEN"Growing", FarmerData[index][plantOwnerName], FarmerData[index][plantPercentage]);
                }
                else if(FarmerData[index][plantTime] > 0)
                {
                format(string, sizeof(string), ""RED"Not Ready\n"YELLOW"%s's wheat plant\n"RED"Status: %.2f%%\n"GREEN"Growing", FarmerData[index][plantOwnerName], FarmerData[index][plantPercentage]);
                }
            }
            else if(FarmerData[index][plantPercentage] >= 100)
            {
                format(string, sizeof(string), ""YELLOW"%s's wheat plant\n"RED"Status: %.2f%%\n"GREEN"Ready to harvest", FarmerData[index][plantOwnerName], FarmerData[index][plantPercentage]);
            }
            UpdateDynamic3DTextLabelText(FarmerData[index][plantText], COLOR_WHITE, string);
        }
        else
        {
            if(FarmerData[index][plantPercentage] < 100)
            {
                if(FarmerData[index][plantTime] <= 0)
                {
                    format(string, sizeof(string), ""GREEN"Ready\n"YELLOW"%s's wheat plant\n"RED"Status: %.2f%%\n"GREEN"Growing", FarmerData[index][plantOwnerName], FarmerData[index][plantPercentage]);
                }
                else if(FarmerData[index][plantTime] > 0)
                {
                format(string, sizeof(string), ""RED"Not Ready\n"YELLOW"%s's wheat plant\n"RED"Status: %.2f%%\n"GREEN"Growing", FarmerData[index][plantOwnerName], FarmerData[index][plantPercentage]);
                }
            }
            else if(FarmerData[index][plantPercentage] >= 100)
            {
                format(string, sizeof(string), ""YELLOW"%s's wheat plant\n"RED"Status: %.2f%%\n"GREEN"Ready to harvest", FarmerData[index][plantOwnerName], FarmerData[index][plantPercentage]);
            }
            FarmerData[index][plantText] = CreateDynamic3DTextLabel(string, COLOR_WHITE, FarmerData[index][plantPosX], FarmerData[index][plantPosY], FarmerData[index][plantPosZ], 10);
        }

        if(IsValidDynamicObject(FarmerData[index][plantObject]))
        {
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FarmerData[index][plantObject], E_STREAMER_X, FarmerData[index][plantPosX]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FarmerData[index][plantObject], E_STREAMER_Y, FarmerData[index][plantPosY]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FarmerData[index][plantObject], E_STREAMER_Z, FarmerData[index][plantPosZ] - 3);
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, FarmerData[index][plantObject], E_STREAMER_INTERIOR_ID, 0);
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, FarmerData[index][plantObject], E_STREAMER_WORLD_ID, 0);
        }
        else
        {
            FarmerData[index][plantObject] = CreateDynamicObject(855, FarmerData[index][plantPosX], FarmerData[index][plantPosY], FarmerData[index][plantPosZ] - 3, 0.0, 0.0, 0, 0, 0, -1, 100, 100);
        }
        return 1;
    }
    return INVALID_FARM_PLANT;
}

UpdatePlayerFarming(playerid, index)
{
    Plant_TimerCount[playerid] = 0;

    new plant_time, level = GetFarmerLevel(playerid);
    switch(level)
    {
        case 1: plant_time = 120;
        case 2: plant_time = 100;
        case 3: plant_time = 80;
        default: plant_time = 60;
    }

    FarmerData[index][plantTime] = plant_time;
    FarmerData[index][plantPercentage] += 25.0;
    UpdatePlayerPlant(index);

    if(++Player_PlantCount[playerid] >= Plant_Count(playerid))
    {
        SendServerMessage(playerid, "Penyuburan selesai, dalam %d detik tanaman siap untuk dilakukan penyuburan lagi!", plant_time);
        Player_PlantCount[playerid] = 0;
        Player_IsFarming[playerid] = false;
    }

    foreach(new i : FarmPlant)
    {
        if(Plant_Exists(i))
        {
            if(FarmerData[i][plantOwner] == GetPlayerSQLID(playerid))
            {
                if(FarmerData[i][plantTime] <= 0 && FarmerData[i][plantPercentage] < 100)
                {
                    SetPlayerCheckpoint(playerid, FarmerData[i][plantPosX], FarmerData[i][plantPosY], FarmerData[i][plantPosZ], 5.0);
                    break;
                }
            }
        }
    }
    return 1;
}

