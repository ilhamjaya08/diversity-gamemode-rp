CMD:checkskills(playerid, params[])
{
    new userid;
    if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
    	return SendSyntaxMessage(playerid, "/checkskills [playerid/PartOfName]");

    if(userid == INVALID_PLAYER_ID)
    	return SendErrorMessage(playerid, "You have specified an invalid player.");

    new 
        output[4098],
        mechanic_target[] = {500, 2500, 5000},
        Float:Fishing_Skill = GetFishingSkill(userid),
        Float:Hunting_Skill = GetHuntingSkill(userid),
        Float:Lumber_Skill = GetLumberSkill(userid),
        Float:Trucker_Skill = GetTruckerSkill(userid),
        Float:Farming_Skill = GetFarmerSkill(userid),
        Fishing_Level = GetFishingLevel(userid),
        Hunting_Level = GetHuntingLevel(userid),
        Lumber_Level = GetLumberLevel(userid),
        Trucker_Level = GetTruckerLevel(userid),
        Farming_Level = GetFarmerLevel(userid)
    ;

    new 
        m_level = GetMechanicLevel(userid)
    ;

    strcat(output, "Job Skill\tLevel\tEXP/EXP Target\tLevel Name\n");

    if(m_level < 3) strcat(output, sprintf(""WHITE"Mechanic Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", m_level+1, GetMechanicEXP(userid), mechanic_target[m_level], GetLevelName(m_level+1)));
    else if(m_level+1 > 3) strcat(output, sprintf(""WHITE"Mechanic Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", m_level+1, GetLevelName(m_level+1)));
    
    if(Fishing_Level >= 5) strcat(output, sprintf(""WHITE"Fishing Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Fishing_Level,  GetLevelName(Fishing_Level)));
    else strcat(output, sprintf(""WHITE"Fishing Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Fishing_Level, floatround(Fishing_Skill, floatround_ceil), (Fishing_Level*100)+100, GetLevelName(Fishing_Level)));
    
    if(Hunting_Level >= 5) strcat(output, sprintf(""WHITE"Hunting Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Hunting_Level,  GetLevelName(Hunting_Level)));
    else strcat(output, sprintf(""WHITE"Hunting Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Hunting_Level, floatround(Hunting_Skill, floatround_ceil), (Hunting_Level*100)+100, GetLevelName(Hunting_Level)));
    
    if(Lumber_Level >= 5) strcat(output, sprintf(""WHITE"Lumber Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Lumber_Level, GetLevelName(Lumber_Level)));
    else strcat(output, sprintf(""WHITE"Lumber Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Lumber_Level, floatround(Lumber_Skill, floatround_ceil), (Lumber_Level*100)+100, GetLevelName(Lumber_Level)));
    
    if(Trucker_Level >= 5) strcat(output, sprintf(""WHITE"Trucker Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Trucker_Level, GetLevelName(Trucker_Level)));
    else strcat(output, sprintf(""WHITE"Trucker Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Trucker_Level, floatround(Trucker_Skill, floatround_ceil), (Trucker_Level*100)+100, GetLevelName(Trucker_Level)));
    
    if(Farming_Level >= 5) strcat(output, sprintf(""WHITE"Farmer Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Farming_Level, GetLevelName(Farming_Level)));
    else strcat(output, sprintf(""WHITE"Farmer Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Farming_Level, floatround(Farming_Skill, floatround_ceil), (Farming_Level*100)+100, GetLevelName(Farming_Level)));
    
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Player Skills", output, "Close", "");
    return 1;
}

CMD:skills(playerid, params[])
{
    new 
        output[4098],
        mechanic_target[] = {500, 2500, 5000},
        Float:Fishing_Skill = GetFishingSkill(playerid),
        Float:Hunting_Skill = GetHuntingSkill(playerid),
        Float:Lumber_Skill = GetLumberSkill(playerid),
        Float:Trucker_Skill = GetTruckerSkill(playerid),
        Float:Farming_Skill = GetFarmerSkill(playerid),
        Fishing_Level = GetFishingLevel(playerid),
        Hunting_Level = GetHuntingLevel(playerid),
        Lumber_Level = GetLumberLevel(playerid),
        Trucker_Level = GetTruckerLevel(playerid),
        Farming_Level = GetFarmerLevel(playerid)
    ;

    new 
        m_level = GetMechanicLevel(playerid)
    ;

    strcat(output, "Job Skill\tLevel\tEXP/EXP Target\tLevel Name\n");
    if(m_level < 3) strcat(output, sprintf(""WHITE"Mechanic Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", m_level+1, GetMechanicEXP(playerid), mechanic_target[m_level], GetLevelName(m_level+1)));
    else if(m_level+1 > 3) strcat(output, sprintf(""WHITE"Mechanic Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", m_level+1, GetLevelName(m_level+1)));
    
    if(Fishing_Level >= 5) strcat(output, sprintf(""WHITE"Fishing Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Fishing_Level,  GetLevelName(Fishing_Level)));
    else strcat(output, sprintf(""WHITE"Fishing Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Fishing_Level, floatround(Fishing_Skill, floatround_ceil), (Fishing_Level*100)+100, GetLevelName(Fishing_Level)));
    
    if(Hunting_Level >= 5) strcat(output, sprintf(""WHITE"Hunting Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Hunting_Level,  GetLevelName(Hunting_Level)));
    else strcat(output, sprintf(""WHITE"Hunting Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Hunting_Level, floatround(Hunting_Skill, floatround_ceil), (Hunting_Level*100)+100, GetLevelName(Hunting_Level)));
    
    if(Lumber_Level >= 5) strcat(output, sprintf(""WHITE"Lumber Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Lumber_Level, GetLevelName(Lumber_Level)));
    else strcat(output, sprintf(""WHITE"Lumber Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Lumber_Level, floatround(Lumber_Skill, floatround_ceil), (Lumber_Level*100)+100, GetLevelName(Lumber_Level)));
    
    if(Trucker_Level >= 5) strcat(output, sprintf(""WHITE"Trucker Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Trucker_Level, GetLevelName(Trucker_Level)));
    else strcat(output, sprintf(""WHITE"Trucker Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Trucker_Level, floatround(Trucker_Skill, floatround_ceil), (Trucker_Level*100)+100, GetLevelName(Trucker_Level)));
    
    if(Farming_Level >= 5) strcat(output, sprintf(""WHITE"Farmer Skill\t%d\t"YELLOW"Maximum\t"GREEN"%s\n", Farming_Level, GetLevelName(Farming_Level)));
    else strcat(output, sprintf(""WHITE"Farmer Skill\t%d\t"YELLOW"%d/%d\t"GREEN"%s\n", Farming_Level, floatround(Farming_Skill, floatround_ceil), (Farming_Level*100)+100, GetLevelName(Farming_Level)));
    
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Player Skills", output, "Close", "");
    return 1;
}

CMD:setskill(playerid, params[])
{
    if (CheckAdmin(playerid, 2))
        return PermissionError(playerid);

    static
        userid,
        type[16],
        amount[32];


    if(sscanf(params, "us[16]S()[32]", userid, type, amount))
    {
        SendSyntaxMessage(playerid, "/setskill [playerid/PartOfName] [name]");
        SendClientMessage(playerid, X11_YELLOW_2, "[NAMES]:"WHITE" fishing, hunting, lumber, trucker, farmer");
        return 1;
    }
    if(userid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "You have specified an invalid player.");

    if(!strcmp(type, "fishing", true))
    {
        if(isnull(amount))
            return SendSyntaxMessage(playerid, "/setskill [playerid/PartOfName] [fishing] [1-100]");

        PlayerSkill[userid][pFishingSkill] = strval(amount);
        SendAdminMessage(X11_CYAN_1, "[setskill]: "RED"%s "WHITE"have set "YELLOW"%s's "WHITE"fishing to "LIGHTBLUE"%d", ReturnAdminName(playerid), ReturnName(userid, 0), strval(amount));
    }
    if(!strcmp(type, "hunting", true))
    {
        if(isnull(amount))
            return SendSyntaxMessage(playerid, "/setskill [playerid/PartOfName] [hunting] [1-100]");

        PlayerSkill[playerid][pHuntingSkill] = strval(amount);
        SendAdminMessage(X11_CYAN_1, "[setskill]: "RED"%s "WHITE"have set "YELLOW"%s's "WHITE"hunting to "LIGHTBLUE"%d", ReturnAdminName(playerid), ReturnName(userid, 0), strval(amount));
    }
    if(!strcmp(type, "trucker", true))
    {
        if(isnull(amount))
            return SendSyntaxMessage(playerid, "/setskill [playerid/PartOfName] [trucker] [1-100]");

        PlayerSkill[userid][pTruckerSkill] = strval(amount);
        SendAdminMessage(X11_CYAN_1, "[setskill]: "RED"%s "WHITE"have set "YELLOW"%s's "WHITE"trucker to "LIGHTBLUE"%d", ReturnAdminName(playerid), ReturnName(userid, 0), strval(amount));
    }
    if(!strcmp(type, "farmer", true))
    {
        if(isnull(amount))
            return SendSyntaxMessage(playerid, "/setskill [playerid/PartOfName] [farmer] [0-1]");

        PlayerSkill[userid][pFarmerSkill] = strval(amount);
        SendAdminMessage(X11_CYAN_1, "[setskill]: "RED"%s "WHITE"have set "YELLOW"%s's "WHITE"able to farmer to "LIGHTBLUE"%d", ReturnAdminName(playerid), ReturnName(userid, 0), strval(amount));
    }
    if(!strcmp(type, "lumber", true))
    {
        if(isnull(amount))
            return SendSyntaxMessage(playerid, "/setskill [playerid/PartOfName] [lumber] [1-100]");

        PlayerSkill[userid][pLumberSkill] = strval(amount);
        SendAdminMessage(X11_CYAN_1, "[setskill]: "RED"%s "WHITE"have set "YELLOW"%s's "WHITE"lumber to "LIGHTBLUE"%d", ReturnAdminName(playerid), ReturnName(userid, 0), strval(amount));
    }
    return 1;
}