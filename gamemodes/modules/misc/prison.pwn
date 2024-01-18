/*	Prison Script Module	*/
#include <YSI\y_hooks>

stock const Float:prisonArrays[][4] = {
    {167.0171,1417.6963,10.6102,358.4891}, 
    {161.1312,1417.5852,10.6102,200.3503}, 
    {156.0356,1417.8282,10.6302,194.7572}, 
    {151.2082,1417.8682,10.6302,199.5278}, 
    {168.3658,1439.2357,10.6202,317.0349}, 
    {161.0134,1439.2079,10.6202,20.3680},
    {155.3184,1439.1868,10.6202,24.9741},
    {150.9462,1440.6174,10.6202,3.7534},
    {150.7801,1414.4752,14.8020,182.8955}, 
    {156.0584,1414.4886,14.8020,182.8955}, 
    {161.7040,1414.8428,14.7920,182.8955}, 
    {167.3182,1414.3363,14.7920,198.1942}, 
    {167.4730,1442.4028,14.7020,332.0047}, 
    {161.5685,1442.6934,14.7020,328.8615}, 
    {155.4728,1443.1433,14.6920,13.8615},
    {151.1392,1442.3845,14.6920,328.8615} 
};

CMD:arrest(playerid, params[])
{
    static
        userid,
        times,
        fine;

    if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_SADOC) return SendErrorMessage(playerid, "You must be a police officer.");
    if(!PlayerData[playerid][pOnDuty]) return SendErrorMessage(playerid, "You must duty first.");
    if(sscanf(params, "udd", userid, times, fine)) return SendSyntaxMessage(playerid, "/arrest [playerid/PartOfName] [minutes] [fine]");
    if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) return SendErrorMessage(playerid, "The player is disconnected or not near you.");
    if(times < 1) return SendErrorMessage(playerid, "The specified time can't be below 1.");
    if(!PlayerData[userid][pCuffed]) return SendErrorMessage(playerid, "The player must be cuffed before an arrest is made.");
    if(!IsPlayerNearArrest(playerid)) return SendErrorMessage(playerid, "You must be near an arrest point.");
    if(fine < 1 || fine > 50000) return SendErrorMessage(playerid, "Fine must be between 0 -  50,000$");

    PlayerData[userid][pPrisoned] = 1;
    PlayerData[userid][pJailTime] = times * 60;
    format(PlayerData[userid][pJailReason], 32, "Arrest");
    GiveMoney(userid, -fine, ECONOMY_ADD_SUPPLY, "fine arrest");

    FactionData[PlayerData[playerid][pFaction]][factionMoney] += fine;
    Faction_Save(PlayerData[playerid][pFaction]);

    StopDragging(userid);
    SetPlayerInPrison(userid);

    ResetPlayer(userid);
    ResetNameTag(playerid, true);
    PlayerData[userid][pWarrants] = 0;
    PlayerData[userid][pCuffed] = 0;

    PlayerData[userid][pJob] = JOB_NONE;
    PlayerData[userid][pJobLeave] = 0;

    PlayerTextDrawShow(userid, PlayerTextdraws[userid][textdraw_prison]);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);

    SendCustomMessage(userid, "ARREST", "You have been prisoned by "YELLOW"%s "WHITE"for "RED"%d days "WHITE"at San Andreas Prison.", ReturnName(userid, 0), times);
    SendCustomMessage(userid, "ARREST", "You have fined for "COL_RED"%s.", FormatNumber(fine));
    SendCustomMessage(userid, "ARREST", "You got arrested, the owner of your job kicked you from the job!");

    if(Inventory_Add(userid, "Stamps", 2059, 100) != -1)
    {
        SendCustomMessage(userid, "ARREST", "You have 100 stamps for living in prison");
    }
    return 1;
}