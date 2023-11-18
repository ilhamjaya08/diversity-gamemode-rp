
Lookup_HouseOwner(sqlid, houseid)
{
    if(HouseData[houseid][houseOwner] == sqlid)
        return 1;

    return 0;
}

Lookup_BusinessOwner(sqlid, bizid)
{
    if(BusinessData[bizid][bizOwner] == sqlid)
        return 1;

    return 0;
}

Lookup_ApartmentRoomOwner(sqlid, apartid)
{
    if(ApartmentRoomData[apartid][apartmentRoomOwner] == sqlid)
        return 1;

    return 0;
}

Lookup_WorkshopOwner(sqlid, workshopid)
{
    if(WorkshopData[workshopid][wOwner] == sqlid)
        return 1;

    return 0;
}

ShowAvailableHouse(playerid)
{
    new 
        string[4096]
    ;
    strcat(string, "House ID\tHouse Name\tPrice\n");
    for(new i = 0; i<MAX_HOUSES; i++)
    {
        if(HouseData[i][houseExists] && HouseData[i][houseOwner] == 0)
        {
            strcat(string, sprintf("%d\t%s\t%s\n", i, HouseData[i][houseAddress], FormatNumber(HouseData[i][housePrice])));
        }
    }
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "House Database", string, "Close", "");
    return 1;
}

ShowBusinessList(playerid)
{
    new 
        string[4098]
    ;
    strcat(string, "Business ID\tBusiness Name\tBusiness Type\n");
    for(new i = 0; i<MAX_BUSINESSES; i++)
    {
        if(BusinessData[i][bizExists] && BusinessData[i][bizOwner] != 0)
        {
            strcat(string, sprintf("%d\t%s\t%s\n", i, BusinessData[i][bizName], Business_Type(i)));
        }
    }
    Dialog_Show(playerid, BIZ_DATABASE, DIALOG_STYLE_TABLIST_HEADERS, "Business Database", string, "Select", "Close");    
}