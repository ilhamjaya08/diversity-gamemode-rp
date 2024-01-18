Dialog:ApartmentDeposit(playerid, response, listitem, inputtext[])
{
    new
        index,
        string[32];

    if((index = ApartmentRoom_Inside(playerid)) != -1)
    {
        if(!ApartmentRoom_IsOwned(playerid, index))
            return SendErrorMessage(playerid, "Hanya pemilik rumah yang dapat menyimpan barang!");

        strunpack(string, InventoryData[playerid][PlayerData[playerid][pInventoryItem]][invItem]);

        if(response)
        {
            new amount = strval(inputtext);

            if(amount < 1 || amount > InventoryData[playerid][PlayerData[playerid][pInventoryItem]][invQuantity])
                return Dialog_Show(playerid, ApartmentDeposit, DIALOG_STYLE_INPUT, "Apartment Deposit", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to store for this item:", "Store", "Back", string, InventoryData[playerid][PlayerData[playerid][pInventoryItem]][invQuantity]);

            Apartment_AddItem(index, string, InventoryData[playerid][PlayerData[playerid][pInventoryItem]][invModel], amount);
            Inventory_Remove(playerid, string, amount);

            Apartment_ShowItem(playerid, index);
            SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has stored a \"%s\" into their apartement storage.", ReturnName(playerid, 0), string);
            Log_Save(E_LOG_APARTMENT_ITEMS, sprintf("[%s] %s has stored a %s into their apartment.", ReturnDate(), ReturnName(playerid, 0), string));

        }
    }
    return 1;
}

Dialog:ApartmentTake(playerid, response, listitem, inputtext[])
{
    new
        index,
        string[32];

    if((index = ApartmentRoom_Inside(playerid)) != -1 && (ApartmentRoom_IsOwned(playerid, index) || GetAdminLevel(playerid) >= 5))
    {
        strunpack(string, ApartmentStorage[index][PlayerData[playerid][pStorageItem]][apartmentItemName]);

        if(response)
        {
            new amount = strval(inputtext);

            if(amount < 1 || amount > ApartmentStorage[index][PlayerData[playerid][pStorageItem]][apartmentItemQuantity])
                return Dialog_Show(playerid, ApartmentTake, DIALOG_STYLE_INPUT, "Apartment Take", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to take for this item:", "Take", "Back", string, ApartmentStorage[index][PlayerData[playerid][pInventoryItem]][apartmentItemQuantity]);

            for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if(!strcmp(g_aInventoryItems[i][e_InventoryItem], string, true)) {
                if((Inventory_Count(playerid, g_aInventoryItems[i][e_InventoryItem])+amount) > g_aInventoryItems[i][e_InventoryMax])
                    return Dialog_Show(playerid, ApartmentTake, DIALOG_STYLE_INPUT, "Apartment Take", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to take for this item:\n(You can take %d %s now!)", "Take", "Back", string, ApartmentStorage[index][PlayerData[playerid][pInventoryItem]][apartmentItemQuantity], (g_aInventoryItems[i][e_InventoryMax]-Inventory_Count(playerid, g_aInventoryItems[i][e_InventoryItem])), string);
            }

            if(Inventory_Add(playerid, string, ApartmentStorage[index][PlayerData[playerid][pStorageItem]][apartmentItemModel], amount) != -1)
            {
                Apartment_RemoveItem(index, string, amount);
                SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has taken a \"%s\" from their apartment storage.", ReturnName(playerid, 0), string);
                Log_Save(E_LOG_APARTMENT_ITEMS, sprintf("[%s] %s has taken a %s from their apartment.", ReturnDate(), ReturnName(playerid, 0), string));
                Apartment_ShowItem(playerid, index);
            }
        }
    }
    return 1;
}

Dialog:ApartmentItems(playerid, response, listitem, inputtext[])
{
    new
        index,
        string[64];

    if((index = ApartmentRoom_Inside(playerid)) != -1 && (ApartmentRoom_IsOwned(playerid, index) || GetAdminLevel(playerid) >= 5))
    {
        if(response)
        {
            if(ApartmentStorage[index][listitem][apartmentItemExists])
            {
                PlayerData[playerid][pStorageItem] = listitem;
                PlayerData[playerid][pInventoryItem] = listitem;

                strunpack(string, ApartmentStorage[index][listitem][apartmentItemName]);

                format(string, sizeof(string), "%s (Quantity: %d)", string, ApartmentStorage[index][listitem][apartmentItemQuantity]);
                Dialog_Show(playerid, ApartmentStorageOptions, DIALOG_STYLE_LIST, string, "Take Item\nStore Item", "Select", "Back");
            }
            else
            {
                if(!ApartmentRoom_IsOwned(playerid, index))
                    return SendErrorMessage(playerid, "Hanya pemilik rumah yang dapat meletakkan item!");

                OpenInventory(playerid);
                PlayerData[playerid][pStorageSelect] = 2;
            }
        }
    }
    return 1;
}

Dialog:ApartmentStorageOptions(playerid, response, listitem, inputtext[])
{
    new
        index = -1,
        itemid = -1,
//        backpack = -1,
        string[32];

    if((index = ApartmentRoom_Inside(playerid)) != -1 && (ApartmentRoom_IsOwned(playerid, index) || GetAdminLevel(playerid) >= 5))
    {
        itemid = PlayerData[playerid][pStorageItem];

        strunpack(string, ApartmentStorage[index][itemid][apartmentItemName]);

        if(response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if(ApartmentStorage[index][itemid][apartmentItemQuantity] == 1)
                    {
                        if(!strcmp(string, "Backpack") && Inventory_HasItem(playerid, "Backpack"))
                            return SendErrorMessage(playerid, "You already have a backpack in your inventory.");

                        for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if(!strcmp(g_aInventoryItems[i][e_InventoryItem], string, true)) {
                            if((Inventory_Count(playerid, g_aInventoryItems[i][e_InventoryItem])+1) > g_aInventoryItems[i][e_InventoryMax])
                                return SendErrorMessage(playerid, "You're limited %d for %s.", g_aInventoryItems[i][e_InventoryMax], string);
                        }

                        if(Inventory_Add(playerid, string, ApartmentStorage[index][itemid][apartmentItemModel], 1) != -1)
                        {
                            Apartment_RemoveItem(index, string);
                            SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has taken a \"%s\" from their apartment storage.", ReturnName(playerid, 0), string);
                            Log_Save(E_LOG_APARTMENT_ITEMS, sprintf("[%s] %s has taken a %s from their apartment.", ReturnDate(), ReturnName(playerid, 0), string));
                            Apartment_ShowItem(playerid, index);
                        }
                    }
                    else
                    {
                        Dialog_Show(playerid, ApartmentTake, DIALOG_STYLE_INPUT, "Apartment Take", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to take for this item:", "Take", "Back", string, ApartmentStorage[index][itemid][apartmentItemQuantity]);
                    }
                }
                case 1:
                {
                    if(!ApartmentRoom_IsOwned(playerid, index))
                        return SendErrorMessage(playerid, "Hanya pemilik apartemen yang dapat meletakkan item!");

                    new id = Inventory_GetItemID(playerid, string);

                    if(id == -1) {
                        Apartment_ShowItem(playerid, index);

                        return SendErrorMessage(playerid, "You don't have anymore of this item to store!");
                    }
                    else if(InventoryData[playerid][id][invQuantity] == 1)
                    {
                        Apartment_AddItem(index, string, InventoryData[playerid][id][invModel]);
                        Inventory_Remove(playerid, string);

                        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has stored a \"%s\" into their apartment storage.", ReturnName(playerid, 0), string);
                        Log_Save(E_LOG_APARTMENT_ITEMS, sprintf("[%s] %s has stored a %s into their apartment.", ReturnDate(), ReturnName(playerid, 0), string));

                        Apartment_ShowItem(playerid, index);
                    }
                    else if(InventoryData[playerid][id][invQuantity] > 1) {
                        PlayerData[playerid][pInventoryItem] = id;

                        Dialog_Show(playerid, ApartmentDeposit, DIALOG_STYLE_INPUT, "Apartment Deposit", "Item: %s (Quantity: %d)\n\nPlease enter the quantity that you wish to store for this item:", "Store", "Back", string, InventoryData[playerid][id][invQuantity]);
                    }
                }
            }
        }
        else
        {
            Apartment_ShowItem(playerid, index);
        }
    }
    return 1;
}