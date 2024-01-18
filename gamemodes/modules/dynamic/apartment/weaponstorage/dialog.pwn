Dialog:APARTMENTSTORAGE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new index = PlayerData[playerid][pApartment];
        if(index != -1)
        {
            switch(listitem)
            {
                case 0: Apartment_ShowWeapon(playerid, index);
                case 1: Apartment_ShowItem(playerid, index); 
            }
        }
    }
    return 1;
}

Dialog:APARTMENTSTORAGEWEAPON(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            index = PlayerData[playerid][pApartment],
            slot = listitem,
            weaponid = ApartmentWeaponData[index][slot][apartmentWeapon]
        ;
        if(weaponid > 0)
        {
            Apartment_WithdrawWeapon(playerid, index, slot);
        }
        else
        {
            Apartment_DepositWeapon(playerid, index, slot);
        }
    }
    return 1;
}