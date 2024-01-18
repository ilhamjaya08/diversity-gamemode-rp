Dialog:SellPlant(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        Dialog_Show(playerid, SellWheatConfirm, DIALOG_STYLE_INPUT, "Farm Warehouse", "Berapa jumlah padi yang ingin kamu jual ? ", "Sell", "Close");
    }
    return 1;
}


Dialog:SellWheatConfirm(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new price;
        price = ServerData[wheat_price];

        if(strval(inputtext) < 0 || strval(inputtext) > 100000) return Dialog_Show(playerid, SellWheatConfirm, DIALOG_STYLE_INPUT, "Farm Warehouse", "Berapa jumlah padi yang ingin kamu jual ? ", "Sell", "Close");
        if(Inventory_Count(playerid, "Wheat Plant") < strval(inputtext))
            return SendErrorMessage(playerid, "Anda tidak mempunyai Wheat sebanyak itu !"); 

        Inventory_Remove(playerid, "Wheat Plant", strval(inputtext));
        SendClientMessageEx(playerid, COLOR_WHITE, "Kamu telah menjual Wheat sebanyak %d dengan harga total "GREEN"%s", strval(inputtext), FormatNumber(price*strval(inputtext)));
        GiveMoney(playerid, price*strval(inputtext), ECONOMY_TAKE_SUPPLY, "sell wheat");
    }
    return 1;
}