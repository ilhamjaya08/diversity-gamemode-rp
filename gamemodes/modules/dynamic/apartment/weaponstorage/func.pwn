Function:LoadApartmentWeapon(index)
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
            ApartmentWeaponData[index][i][apartmentWeapon] = cache_get_field_int(i, "Weapon");
            ApartmentWeaponData[index][i][apartmentWeaponAmmo] = cache_get_field_int(i, "WeaponAmmo");
            ApartmentWeaponData[index][i][apartmentWeaponDurability] = cache_get_field_int(i, "WeaponDurability");
            ApartmentWeaponData[index][i][apartmentWeaponSlot] = cache_get_field_int(i, "WeaponSlot");
            ApartmentWeaponData[index][i][apartmentWeaponSerial] = cache_get_field_int(i, "WeaponSerial");
 		}
	}
    return 1;
}

Apartment_ShowStorage(playerid, index)
{
    if(ApartmentRoom_IsExists(index))
    {
        new headers[38], string[128];
        format(headers, sizeof(headers), "Apartment Storage");
        format(string, sizeof(string), "Weapon Storage\nItem Storage");
        Dialog_Show(playerid, APARTMENTSTORAGE, DIALOG_STYLE_LIST, headers, string, "Choose", "Close");
        return 1;
    }
    return -1;
}
Apartment_ShowWeapon(playerid, index)
{
    if(ApartmentRoom_IsExists(index))
    {
        new headers[38], string[1024];
        format(headers, sizeof(headers), "Apartment Weapon Storage");
        strcat(string, "Weapon Name\tAmmo\tDurability\n");
        for(new i = 0; i<MAX_APARTMENT_WEAPON_STORAGE; i++)
        {
            new
                weaponid = ApartmentWeaponData[index][i][apartmentWeapon],
                ammo = ApartmentWeaponData[index][i][apartmentWeaponAmmo],
                durability = ApartmentWeaponData[index][i][apartmentWeaponDurability]
            ;
            if(weaponid > 0)
            { 
                strcat(string, sprintf(""RED"%s\t"GREEN"%d\t"YELLOW"%d\n", ReturnWeaponName(weaponid), ammo, durability));
            }
            else
            {
                strcat(string, "None\n");
            }
        }
        Dialog_Show(playerid, APARTMENTSTORAGEWEAPON, DIALOG_STYLE_TABLIST_HEADERS, headers, string, "Choose", "Close");
        return 1;
    }
    return -1;
}

Apartment_DepositWeapon(playerid, index, slot)
{
    if(ApartmentRoom_IsExists(index))
    {
        new
            weaponid = GetWeapon(playerid),
            ammo = ReturnWeaponAmmo(playerid, weaponid),
            durability = ReturnWeaponDurability(playerid, weaponid),
            serialnumber = ReturnWeaponSerial(playerid, weaponid)
        ;

        if(!ApartmentRoom_IsOwned(playerid, index))
            return SendErrorMessage(playerid, "Hanya pemilik apartment yang dapat meletakkan senjata!");

        if(IsPlayerDuty(playerid))
            return SendErrorMessage(playerid, "Duty faction tidak dapat menyimpan senjata.");

        if(!weaponid)
            return SendErrorMessage(playerid, "You are not holding any weapon!");

        ApartmentWeaponData[index][slot][apartmentWeapon] = weaponid;
        ApartmentWeaponData[index][slot][apartmentWeaponAmmo] = ammo;
        ApartmentWeaponData[index][slot][apartmentWeaponDurability] = durability;
        ApartmentWeaponData[index][slot][apartmentWeaponSlot] = slot;
        ApartmentWeaponData[index][slot][apartmentWeaponSerial] = serialnumber;

        mysql_tquery(g_iHandle, sprintf("INSERT INTO `weapon_apartment`(`apartmentRoomID`, `Weapon`, `WeaponAmmo`, `WeaponDurability`, `WeaponSlot`, `WeaponSerial`) VALUES ('%d','%d','%d','%d','%d', '%d');", ApartmentRoomData[index][apartmentRoomID], weaponid, ammo, durability, slot, serialnumber));

        ResetWeaponID(playerid, weaponid);
        Apartment_ShowWeapon(playerid, index);

        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has stored a \"%s\" into their weapon storage.", ReturnName(playerid, 0), ReturnWeaponName(weaponid));

        Log_Save(E_LOG_APARTMENT_SAFE, sprintf("[%s] %s has stored a %s from their weapon storage.", ReturnDate(), ReturnName(playerid, 0), ReturnWeaponName(weaponid)));
        return 1;
    }
    return -1;    
}

Apartment_WithdrawWeapon(playerid, index, slot)
{
    if(ApartmentRoom_IsExists(index))
    {
        if(IsPlayerDuty(playerid))
            return SendErrorMessage(playerid, "Duty faction tidak dapat mengambil senjata.");

        if(PlayerHasWeapon(playerid, ApartmentWeaponData[index][slot][apartmentWeapon]))
            return SendErrorMessage(playerid, "Kamu sudah memiliki senjata yang sama.");

        if(PlayerHasWeaponInSlot(playerid, ApartmentWeaponData[index][slot][apartmentWeapon]))
            return SendErrorMessage(playerid, "Senjata ini berada satu slot dengan senjata yang kamu punya.");

        new
            weaponid    = ApartmentWeaponData[index][slot][apartmentWeapon],
            ammo        = ApartmentWeaponData[index][slot][apartmentWeaponAmmo],
            durability  = ApartmentWeaponData[index][slot][apartmentWeaponDurability],
            weaponslot  = ApartmentWeaponData[index][slot][apartmentWeaponSlot],
            serialnumber = ApartmentWeaponData[index][slot][apartmentWeaponSerial]
        ;

        new serial[64];
        valstr(serial, serialnumber);

        GivePlayerWeaponEx(playerid, weaponid, ammo, durability, serial);
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `weapon_apartment` WHERE `apartmentRoomID` = '%d' AND `WeaponAmmo`='%d' AND `Weapon`='%d' AND `WeaponDurability`='%d' AND `WeaponSlot` = '%d';", 
        ApartmentRoomData[index][apartmentRoomID], 
        ammo, 
        weaponid, 
        durability,
        weaponslot));

        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has taken a \"%s\" from their weapon storage.", ReturnName(playerid, 0), ReturnWeaponName(weaponid));
        Log_Save(E_LOG_APARTMENT_SAFE, sprintf("[%s] %s has taken a %s from their weapon storage.", ReturnDate(), ReturnName(playerid, 0), ReturnWeaponName(weaponid)));

        ApartmentWeaponData[index][slot][apartmentWeapon]               = 0;
        ApartmentWeaponData[index][slot][apartmentWeaponAmmo]           = 0;
        ApartmentWeaponData[index][slot][apartmentWeaponDurability]     = 0;
        ApartmentWeaponData[index][slot][apartmentWeaponSlot]           = -1;
        ApartmentWeaponData[index][slot][apartmentWeaponSerial]         = 0;
        return 1;
    }
    return -1;
}

