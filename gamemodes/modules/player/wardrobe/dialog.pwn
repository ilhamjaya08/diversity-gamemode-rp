Dialog:WARDROBEMENU(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            houseid = GetPVarInt(playerid, "WardrobeHouseID")
        ;
        switch(listitem)
        {
            case 0:
            {
                ShowClothesWardrobe(playerid, houseid);
            }
            case 1:
            {
                ShowAccesoriesWardrobe(playerid, houseid);
            }
        }
    }
    return 1;
}

Dialog:WARDROBE_ACCESORIES(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            slot = listitem,
            houseid = GetPVarInt(playerid, "WardrobeHouseID")
        ;
        SetPVarInt(playerid, "WardrobeAccSlot", slot);
        if(AccesoriesData[houseid][slot][accExists])
        {
            Dialog_Show(playerid, WARDROBE_ACC_STORE, DIALOG_STYLE_LIST, "Accesories Wardrobe Menu", "Take Accesories\nRemove Accesories", "Select", "Close");
        }
        else
        {
            Dialog_Show(playerid, WARDROBE_ACC_STORE, DIALOG_STYLE_LIST, "Accesories Wardrobe Menu", "Store Accesories", "Select", "Close");
        }
    }
    return 1;
}

Dialog:WARDROBE_ACC_STORE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new
            houseid = GetPVarInt(playerid, "WardrobeHouseID"),
            slot = GetPVarInt(playerid, "WardrobeAccSlot")
        ;

        switch(listitem)
        {
            case 0:
            {
                if(AccesoriesData[houseid][slot][accExists])
                {
                    WithdrawAccesories(playerid, houseid, slot);
                }
                else
                {
                    OpenPlayerAccesories(playerid);
                }
            }
            case 1:
            {
                RemoveAccesories(houseid, slot);
            }
        }
    }
    return 1;
}
Dialog:WARDROBE_ACC_STORE2(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            accid = ListedAcc[playerid][listitem],
            houseid = GetPVarInt(playerid, "WardrobeHouseID"),
            slot = GetPVarInt(playerid, "WardrobeAccSlot")
        ;
        DepositAccesories(playerid, houseid, slot, accid);
    }
    return 1;
}
Dialog:WARDROBE_CLOTHES(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            slot = listitem,
            houseid = GetPVarInt(playerid, "WardrobeHouseID")
        ;
        SetPVarInt(playerid, "WardrobeClothesSlot", slot);
        if(ClothesData[houseid][slot][clothesExists])
        {
            Dialog_Show(playerid, WARDROBE_CLOTHES_STORE, DIALOG_STYLE_LIST, "Wardrobe Clothes Menu", "Use Clothes\nRemove Clothes", "Select", "Close");
        }
        else
        {
            Dialog_Show(playerid, WARDROBE_CLOTHES_STORE, DIALOG_STYLE_LIST, "Wardrobe Clothes Menu", "Store Clothes", "Select", "Close");
        }
    }
    return 1;
}

Dialog:WARDROBE_CLOTHES_STORE(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new
            houseid = GetPVarInt(playerid, "WardrobeHouseID"),
            slot = GetPVarInt(playerid, "WardrobeClothesSlot")
        ;

        switch(listitem)
        {
            case 0:
            {
                if(ClothesData[houseid][slot][clothesExists])
                {
                    WithdrawClothes(playerid, houseid, slot);
                }
                else
                {
                    Dialog_Show(playerid, WARDROBE_CLOTHES_NAME, DIALOG_STYLE_INPUT, "Clothes Name", "Write down your own clothes name", "Ok", "Cancel");
                    //Note : Foward ke dialog selanjutnya untuk pengisian nama.
                    //Note : Kalau male set skin ke naked male, kalau female set skin ke naked female.
                    //Note : Buat variable untuk ngecheck kalau dia naked atau enggak.
                }
            }
            case 1:
            {
                RemoveClothes(houseid, slot);
            }
        }
    }
    return 1;
}

Dialog:WARDROBE_CLOTHES_NAME(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new
            houseid = GetPVarInt(playerid, "WardrobeHouseID"),
            slot = GetPVarInt(playerid, "WardrobeClothesSlot")
        ;

        if(isnull(inputtext))
            return Dialog_Show(playerid, WARDROBE_CLOTHES_NAME, DIALOG_STYLE_INPUT, "Clothes Name", "ERROR : You need to fill the name!\n\nWrite down your own clothes name", "Ok", "Cancel");

        if(strlen(inputtext) > 32)
            return Dialog_Show(playerid, WARDROBE_CLOTHES_NAME, DIALOG_STYLE_INPUT, "Clothes Name", "ERROR : Name only contains 32 characters!\n\nWrite down your own clothes name", "Ok", "Cancel");

        if(IsNumeric(inputtext)) 
            return Dialog_Show(playerid, WARDROBE_CLOTHES_NAME, DIALOG_STYLE_INPUT, "Clothes Name", "ERROR : Numeric are not allowed!\n\nWrite down your own clothes name", "Ok", "Cancel");

        DepositClothes(playerid, houseid, slot, inputtext);
    }
    return 1;
}