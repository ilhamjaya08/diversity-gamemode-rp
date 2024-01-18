IsAtApartmentParking(playerid)
{
    foreach(new i : Apartment)
    {
        if(Apartment_IsExists(i) && IsPlayerInRangeOfPoint(playerid, 5.0, ApartmentData[i][apartmentParkingPosX], ApartmentData[i][apartmentParkingPosY], ApartmentData[i][apartmentParkingPosZ]))
        {
            foreach(new id : ApartmentRoom)
            { 
                if(ApartmentRoomData[id][apartmentID] == ApartmentData[i][apartmentID] && ApartmentRoomData[id][apartmentRoomOwner] == GetPlayerSQLID(playerid))
                {
                    return i;
                }
            }
        }
    }
    return -1;
}