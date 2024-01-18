
CMD:startfarming(playerid, params[])
{
    new count = 0;
    if(GetPlayerJob(playerid) != JOB_FARMER)
    	return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak bekerja sebagai farmer.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return SendErrorMessage(playerid, "Kamu harus mengendarai tractor!");

    new vehicleid = GetPlayerVehicleID(playerid);

    if(GetVehicleModel(vehicleid) != 531)
        return SendErrorMessage(playerid, "Ini bukan kendaraan traktor!");

    Player_IsFarming[playerid] = true;

    foreach(new i : FarmPlant)
    {
        if(Plant_Exists(i))
        {
            if(FarmerData[i][plantOwner] == GetPlayerSQLID(playerid))
            {            
                count++;
                if(FarmerData[i][plantTime] == 0)
                {
                    SetPlayerCheckpoint(playerid, FarmerData[i][plantPosX], FarmerData[i][plantPosY], FarmerData[i][plantPosZ], 5.0);
                    SendServerMessage(playerid, "Jalankan traktor mu kearah checkpoint untuk menyuburkan tanaman");
                    break;
                }
            }
        }
    } 
    if(!count) return SendErrorMessage(playerid, "Kamu tidak menanam apapun!");  
    return 1;
}

CMD:plantwheat(playerid, params[])
{
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "Kamu harus berdiri di atas tanah!");

    if(GetPlayerJob(playerid) != JOB_FARMER)
    	return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak bekerja sebagai farmer.");

    if(IsPlayerNearPlant(playerid))
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu terlalu dekat dengan tanaman yang lainnya");

    if(PlayerData[playerid][pHunger] <= 5.0 || PlayerData[playerid][pEnergy] <= 5.0)
        return SendErrorMessage(playerid, "Kamu terlalu lelah untuk melanjutkan menanam!");

    new maximum_plant, level = GetFarmerLevel(playerid);
    switch(level)
    {
        case 1: maximum_plant = 5;
        case 2: maximum_plant = 10;
        case 3: maximum_plant = 15;
        default: maximum_plant = 20;
    }
    if(Plant_Count(playerid) >= maximum_plant)
        return SendErrorMessage(playerid, "Kamu hanya bisa menanam %d plants!", maximum_plant);

    if(IsPlayerInDynamicArea(playerid, farm_zone[0]) || IsPlayerInDynamicArea(playerid, farm_zone[1]))
    {
        if(CreatePlayerPlant(playerid) != -1) {

            SetPlayerHunger(playerid, PlayerData[playerid][pHunger]-5.0);
            SetPlayerEnergy(playerid, PlayerData[playerid][pEnergy]-5.0);

            SendServerMessage(playerid, "Kamu menanam padi pada ladang ini, lanjut menanam atau mulai pekerjaan /startfarming");
            SendServerMessage(playerid, "Apa bia kamu tidak melakukan pekerjaan selama 10 menit, padi akan di hilangkan!");
            cmd_bomb(playerid, "\0");
        }
        else SendErrorMessage(playerid, "Kamu sudah menanam 5 padi, tunggu lagi sampai semua kelar di proses!");
    }
    else SendErrorMessage(playerid, "You are not in farm area!");

    return 1;
}

CMD:harvestwheat(playerid, params[])
{
    new i;
    if(GetPlayerJob(playerid) != JOB_FARMER)
    	return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak bekerja sebagai farmer.");

    i = FarmPlant_Nearest(playerid);

    if(i != INVALID_FARM_PLANT)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, FarmerData[i][plantPosX], FarmerData[i][plantPosY], FarmerData[i][plantPosZ]))
        {
            if(FarmerData[i][plantPercentage] >= 100 && FarmerData[i][plantOwner] == GetPlayerSQLID(playerid))
            {
                SetPlayerHunger(playerid, PlayerData[playerid][pHunger]-5.0);
                SetPlayerEnergy(playerid, PlayerData[playerid][pEnergy]-5.0);
                SetFarmerSkill(playerid, 1.0);
                HarvestPlayerPlant(playerid, i);
                SendServerMessage(playerid, "Kamu telah meng-harvest plant ini, plant tersebut ada di tanah, ambil dengan "YELLOW"'tekan C lalu tekan N'");
                cmd_bomb(playerid, "\0");
            }
        }
    }
    return 1;
}


CMD:sellplant(playerid, params[])
{
    new 
        string[128],
        npc_wheat_price
    ;
    npc_wheat_price = ServerData[wheat_price];
    
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "You need to be on foot to sell your plant!");

    if(!IsPlayerInRangeOfPoint(playerid, 5.0, -64.8065,-1120.8037,1.0781))
        return SendErrorMessage(playerid, "You are not at farm warehouse!");

    strcat(string, "Plant Name\tSell Price\n");
    strcat(string, sprintf("Wheat\t$%d\n", npc_wheat_price));
    
    Dialog_Show(playerid, SellPlant, DIALOG_STYLE_TABLIST_HEADERS, "Farm Warehouse", string, "Sell", "Close");
    return 1;
}