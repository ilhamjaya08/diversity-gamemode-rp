CMD:govlookup(playerid, params[])
{
    if(GetFactionType(playerid) != FACTION_GOV)
        return SendErrorMessage(playerid, "You dont have access to government lookup");

    if(IsNearDropItemModel(playerid, 19893))
    {
        Dialog_Show(playerid, GOV_LOOKUP_MENU, DIALOG_STYLE_LIST, "Government Lookup", "Civilian Properties Database\nBusiness Details Database\nProperties For Sell Database", "Lookup", "Close");
    }
    else SendErrorMessage(playerid, "You are not near any laptop to use this command!");
    return 1;
}