Dialog:APARTMENT_SHOW(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            index = strval(inputtext),
            apartmentid = GetPVarInt(playerid, "ApartmentID")
        ;
        Apartment_SetPlayerInside(playerid, apartmentid, index);
    }
    return 1;
}