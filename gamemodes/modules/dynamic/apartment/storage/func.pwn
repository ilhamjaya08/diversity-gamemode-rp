Function:OnApartmentStorageAdd(index, itemid)
{
    ApartmentStorage[index][itemid][apartmentItemID] = cache_insert_id();
    return 1;
}


Function:LoadApartmentStorage(index)
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
            cache_get_field_content(i, "itemName", ApartmentStorage[index][i][apartmentItemName]);
            ApartmentStorage[index][i][apartmentItemID] = cache_get_field_int(i, "itemID");
            ApartmentStorage[index][i][apartmentItemModel] = cache_get_field_int(i, "itemModel");
            ApartmentStorage[index][i][apartmentItemQuantity] = cache_get_field_int(i, "itemQuantity");
            ApartmentStorage[index][i][apartmentItemExists] = true;
 		}
	}
    return 1;
}

static Apartment_GetItemID(index, item[])
{
    if(ApartmentRoom_IsExists(index))
    {
        for (new i = 0; i < MAX_APARTMENT_STORAGE; i ++)
        {
            if(!ApartmentStorage[index][i][apartmentItemExists])
                continue;

            if(!strcmp(ApartmentStorage[index][i][apartmentItemName], item)) return i;
        }
    }
    return -1;
}

static Apartment_GetFreeID(index)
{
    if(ApartmentRoom_IsExists(index))
    {
        for (new i = 0; i < MAX_APARTMENT_STORAGE; i ++)
        {
            if(!ApartmentStorage[index][i][apartmentItemExists])
            return i;
        }
    }
    return -1;
}

Apartment_ShowItem(playerid, index)
{
    if(ApartmentRoom_IsExists(index))
    {
        static
            string[MAX_APARTMENT_STORAGE * 32],
            name[32];

        string[0] = 0;

        for (new i = 0; i != MAX_APARTMENT_STORAGE; i ++)
        {
            if(!ApartmentStorage[index][i][apartmentItemExists])
                format(string, sizeof(string), "%sEmpty Slot\n", string);

            else {
                strunpack(name, ApartmentStorage[index][i][apartmentItemName]);

                if(ApartmentStorage[index][i][apartmentItemQuantity] == 1) {
                    format(string, sizeof(string), "%s%s\n", string, name);
                }
                else format(string, sizeof(string), "%s%s (%d)\n", string, name, ApartmentStorage[index][i][apartmentItemQuantity]);
            }
        }
        Dialog_Show(playerid, ApartmentItems, DIALOG_STYLE_LIST, "Item Storage", string, "Select", "Cancel");
        return 1;
    }
    return -1;
}

Apartment_AddItem(index, item[], model, quantity = 1, slotid = -1)
{
    if(ApartmentRoom_IsExists(index))
    {
        new
            itemid = Apartment_GetItemID(index, item),
            string[255];

        if(itemid == -1)
        {
            itemid = Apartment_GetFreeID(index);

            if(itemid != -1)
            {
                if(slotid != -1)
                    itemid = slotid;

                ApartmentStorage[index][itemid][apartmentItemExists] = true;
                ApartmentStorage[index][itemid][apartmentItemModel] = model;
                ApartmentStorage[index][itemid][apartmentItemQuantity] = quantity;

                strpack(ApartmentStorage[index][itemid][apartmentItemName], item, 32 char);

                format(string, sizeof(string), "INSERT INTO `apartment_storage` (`apartmentRoomID`, `itemName`, `itemModel`, `itemQuantity`) VALUES('%d', '%s', '%d', '%d')", ApartmentRoomData[index][apartmentRoomID], item, model, quantity);
                mysql_tquery(g_iHandle, string, "OnApartmentStorageAdd", "dd", index, itemid);

                return itemid;
            }
            return -1;
        }
        else
        {
            format(string, sizeof(string), "UPDATE `apartment_storage` SET `itemQuantity` = `itemQuantity` + %d WHERE `apartmentRoomID` = '%d' AND `itemID` = '%d'", quantity, ApartmentRoomData[index][apartmentRoomID], ApartmentStorage[index][itemid][apartmentItemID]);
            mysql_tquery(g_iHandle, string);

            ApartmentStorage[index][itemid][apartmentItemQuantity] += quantity;
        }
        return itemid;
    }
    return -1;
}

Apartment_RemoveItem(index, item[], quantity = 1)
{
    if(ApartmentRoom_IsExists(index))
    {
        new
            itemid = Apartment_GetItemID(index, item),
            string[128];

        if(itemid != -1)
        {
            if(ApartmentStorage[index][itemid][apartmentItemQuantity] > 0)
            {
                ApartmentStorage[index][itemid][apartmentItemQuantity] -= quantity;
            }
            if(quantity == -1 || ApartmentStorage[index][itemid][apartmentItemQuantity] < 1)
            {
                ApartmentStorage[index][itemid][apartmentItemExists] = false;
                ApartmentStorage[index][itemid][apartmentItemModel] = 0;
                ApartmentStorage[index][itemid][apartmentItemQuantity] = 0;

                format(string, sizeof(string), "DELETE FROM `apartment_storage` WHERE `apartmentRoomID` = '%d' AND `itemID` = '%d'", ApartmentRoomData[index][apartmentRoomID], ApartmentStorage[index][itemid][apartmentItemID]);
                mysql_tquery(g_iHandle, string);
            }
            else if(quantity != -1 && ApartmentStorage[index][itemid][apartmentItemQuantity] > 0)
            {
                format(string, sizeof(string), "UPDATE `apartment_storage` SET `itemQuantity` = `itemQuantity` - %d WHERE `apartmentRoomID` = '%d' AND `itemID` = '%d'", quantity, ApartmentRoomData[index][apartmentRoomID], ApartmentStorage[index][itemid][apartmentItemID]);
                mysql_tquery(g_iHandle, string);
            }
            return 1;
        }
        return 0;
    }
    return -1;
}

Apartment_RemoveAllItems(index)
{
    for (new i = 0; i != MAX_APARTMENT_STORAGE; i ++) {
        ApartmentStorage[index][i][apartmentItemExists] = false;
        ApartmentStorage[index][i][apartmentItemModel] = 0;
        ApartmentStorage[index][i][apartmentItemQuantity] = 0;
    }
    mysql_tquery(g_iHandle, sprintf("DELETE FROM `apartment_storage` WHERE `apartmentRoomID` = '%d'", ApartmentRoomData[index][apartmentRoomID]));

    for (new i = 0; i < MAX_APARTMENT_WEAPON_STORAGE; i ++) {
        ApartmentWeaponData[index][i][apartmentWeapon] = 0;
        ApartmentWeaponData[index][i][apartmentWeaponAmmo] = 0;
        ApartmentWeaponData[index][i][apartmentWeaponDurability] = 0;
        ApartmentWeaponData[index][i][apartmentWeaponSlot] = -1;
        ApartmentWeaponData[index][i][apartmentWeaponSerial] = 0;
    }
    mysql_tquery(g_iHandle, sprintf("DELETE FROM `weapon_apartment` WHERE `apartmentRoomID` = '%d'", ApartmentRoomData[index][apartmentRoomID]));
    return 1;
}