//Function to get data
Float:GetFishingSkill(playerid)
{
    return PlayerSkill[playerid][pFishingSkill];
}

Float:GetHuntingSkill(playerid)
{
    return PlayerSkill[playerid][pHuntingSkill];
}

Float:GetLumberSkill(playerid)
{
    return PlayerSkill[playerid][pLumberSkill];
}

Float:GetTruckerSkill(playerid)
{
    return PlayerSkill[playerid][pTruckerSkill];
}

Float:GetFarmerSkill(playerid)
{
    return PlayerSkill[playerid][pFarmerSkill];
}

//Function to set data
SetFishingSkill(playerid, Float:amount)
{
    PlayerSkill[playerid][pFishingSkill] += amount;
    if(PlayerSkill[playerid][pFishingSkill] >= 500)
    {
        PlayerSkill[playerid][pFishingSkill] = 500;
    }
    return 1;
}

SetHuntingSkill(playerid, Float:amount)
{
    PlayerSkill[playerid][pHuntingSkill] += amount;
    if(PlayerSkill[playerid][pHuntingSkill] >= 500)
    {
        PlayerSkill[playerid][pHuntingSkill] = 500;
    }
    return 1;
}

SetLumberSkill(playerid, Float:amount)
{
    PlayerSkill[playerid][pLumberSkill] += amount;
    if(PlayerSkill[playerid][pLumberSkill] >= 500)
    {
        PlayerSkill[playerid][pLumberSkill] = 500;
    }
    return 1;
}

SetTruckerSkill(playerid, Float:amount)
{
    PlayerSkill[playerid][pTruckerSkill] += amount;
    if(PlayerSkill[playerid][pTruckerSkill] >= 500)
    {
        PlayerSkill[playerid][pTruckerSkill] = 500;
    }
    return 1;
}


SetFarmerSkill(playerid, Float:amount)
{
    PlayerSkill[playerid][pFarmerSkill] += amount;
    if(PlayerSkill[playerid][pFarmerSkill] >= 500)
    {
        PlayerSkill[playerid][pFarmerSkill] = 500;
    }
    return 1;
}

//Function to get level
GetFishingLevel(playerid)
{
    new 
        Float:count = (GetFishingSkill(playerid)/100),
        level = floatround(count, floatround_floor)
    ;
    if(level == 0) level = 1;
    return level;
}

GetHuntingLevel(playerid)
{
    new 
        Float:count = (GetHuntingSkill(playerid)/100),
        level = floatround(count, floatround_floor)
    ;
    if(level == 0) level = 1;
    return level;
}

GetLumberLevel(playerid)
{
    new 
        Float:count = (GetLumberSkill(playerid)/100),
        level = floatround(count, floatround_floor)
    ;
    if(level == 0) level = 1;
    return level;
}

GetTruckerLevel(playerid)
{
    new 
        Float:count = (GetTruckerSkill(playerid)/100),
        level = floatround(count, floatround_floor)
    ;
    if(level == 0) level = 1;
    return level;
}

GetFarmerLevel(playerid)
{
    new 
        Float:count = (GetFarmerSkill(playerid)/100),
        level = floatround(count, floatround_floor)
    ;
    if(level == 0) level = 1;
    return level;
}


Save_PlayerSkill(playerid)
{
    if(!PlayerData[playerid][pLogged])
        return 0;

    new
        query[4086]
    ;
    
    format(query, sizeof(query), "UPDATE `characters` SET `pFishingSkill` = '%.2f', `pHuntingSkill` = '%.2f', `pLumberSkill` = '%.2f', `pTruckerSkill` = '%.2f', `pFarmerSkill` = '%.2f' WHERE `ID` = %d", 
        GetFishingSkill(playerid),
        GetHuntingSkill(playerid),
        GetLumberSkill(playerid),
        GetTruckerSkill(playerid),
        GetFarmerSkill(playerid),
        GetPlayerSQLID(playerid)
    );
    return mysql_tquery(g_iHandle, query);
}

GetLevelName(level)
{
    new string[255];
    switch(level)
    {
        case 1: string = "Newbie";
        case 2: string = "Beginner";
        case 3: string = "Hard Worker";
        default: string = "Expert";
    }
    return string;
}