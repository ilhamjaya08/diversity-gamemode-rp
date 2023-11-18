Dialog:GOV_LOOKUP_MENU(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: Dialog_Show(playerid, GOV_LOOKUP, DIALOG_STYLE_INPUT, "Government Lookup", "Input Player Identification Card Number:\n\nNB: Without First zero, example SA019702\nInput 19702", "Lookup", "Close");
            case 1: ShowBusinessList(playerid);
            case 2: ShowAvailableHouse(playerid);
        }
    }
    return 1;
}

Dialog:BIZ_DATABASE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            bizid = strval(inputtext),
            string[1024]
        ;
        strcat(string, "Type\tInformation\n");
        strcat(string, sprintf(""YELLOW"Owner Name:\t"RED"%s\n"YELLOW"Cargo Price:\t"RED"%s\n"YELLOW"Total Product:\t"RED"%d", BusinessData[bizid][bOwnerName], FormatNumber(BusinessData[bizid][bizCargo]), BusinessData[bizid][bizProducts]));
        Dialog_Show(playerid, BIZ_DATABASE_LU, DIALOG_STYLE_TABLIST_HEADERS, "Business Information", string, "Close", "");
    }
    return 1;
}

Dialog:BIZ_DATABASE_LU(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        ShowBusinessList(playerid);
    }
    else ShowBusinessList(playerid);
    return 1;
}

Dialog:GOV_LOOKUP(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            id = strval(inputtext),
            string[1024],
            count = 0
        ;
        for (new i = 0; i < MAX_HOUSES; i ++) if(Lookup_HouseOwner(id, i)) {
            format(string,sizeof(string),"%sHouse ID: %d | Address: %s | Location: %s\n", string, i, HouseData[i][houseAddress], GetLocation(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]));
            count++;
        }
        for (new i = 0; i < MAX_BUSINESSES; i ++) if(Lookup_BusinessOwner(id, i)) {
            format(string,sizeof(string),"%sBusiness ID: %d | Name: %s | Location: %s\n", string, i, BusinessData[i][bizName], GetLocation(BusinessData[i][bizPos][0], BusinessData[i][bizPos][1], BusinessData[i][bizPos][2]));
            count++;
        }
        for (new i = 0; i < MAX_WORKSHOP; i ++) if(Lookup_WorkshopOwner(id, i)) {
            format(string,sizeof(string),"%sWorkshop ID: %d | Name: %s | Location: %s\n", string, i, WorkshopData[i][wName], GetLocation(WorkshopData[i][wPos][0], WorkshopData[i][wPos][1], WorkshopData[i][wPos][2]));
            count++;
        }
        foreach(new i : ApartmentRoom) if(Lookup_ApartmentRoomOwner(id, i)){
                format(string,sizeof(string),"%sApartment Room ID: %d | Name: %s\n", string, i, ApartmentRoomData[i][apartmentRoomName]);            
        }
        if(!count) SendErrorMessage(playerid, "This player don't own any properties.");
        else Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_LIST, sprintf("Properties Database Civilian ID : %d Properties", id), string, "Close", "");
    }
    return 1;
}