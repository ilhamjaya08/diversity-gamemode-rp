#include <YSI\y_hooks>

hook OnPlayerEnterCP(playerid)
{
    if(GetPlayerJob(playerid) == JOB_FARMER && Player_IsFarming[playerid])
    {
        DisablePlayerCheckpoint(playerid);

        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            new vehicleid = GetPlayerVehicleID(playerid);

            if(GetVehicleModel(vehicleid) == 531)
            {
                foreach(new i : FarmPlant)
                {
                    if(Plant_Exists(i))
                    {
                        if(FarmerData[i][plantOwner] == GetPlayerSQLID(playerid))
                        {
                            if(FarmerData[i][plantTime] <= 0 && FarmerData[i][plantPercentage] < 100)
                            {
                                UpdatePlayerFarming(playerid, i);
                                break;
                            }
                        }
                    }
                }
            }
            else SendErrorMessage(playerid, "Ini bukan kendaraan traktor!");
        }
        else SendErrorMessage(playerid, "Kamu harus mengendarai kendaraan untuk membajak!");
    }
}

hook OnPlayerConnect(playerid)
{
    Player_IsFarming[playerid] = false;
    Plant_TimerCount[playerid] = 0;
    Player_PlantCount[playerid] = 0;
}

hook OnPlayerDisconnectEx(playerid, reason)
{
    Plant_TimerCount[playerid] = 0;
    Player_PlantCount[playerid] = 0;
    Player_IsFarming[playerid] = false;
    Plant_Destroy(playerid);
}