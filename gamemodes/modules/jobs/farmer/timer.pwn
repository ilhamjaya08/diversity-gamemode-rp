
ptask Player_FarmingJob[1000](playerid)
{
    if(GetPlayerJob(playerid) == JOB_FARMER)
    {
        Plant_TimerCount[playerid]++;
        if(Plant_TimerCount[playerid] >= 1800)
        {
            Plant_TimerCount[playerid] = 0;
            Plant_Destroy(playerid);
        }
    }
    return 1;
}

task FarmPlant_Update[1000]()
{
    foreach(new i : FarmPlant)
    {
        if(Plant_Exists(i))
        {
            if(FarmerData[i][plantTime] > 0)
            {
                FarmerData[i][plantTime]--;
                if(FarmerData[i][plantTime] <= 0)
                {
                    FarmerData[i][plantTime] = 0;
                    UpdatePlayerPlant(i);
                }
            }
        }
    }
}