
Dialog:BlackJack_Bet(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            amount = strval(inputtext),
            targetid = CardData[playerid][cardGame]
        ;

        if(amount < 1)
            return Dialog_Show(playerid, BlackJack_Bet, DIALOG_STYLE_INPUT, "Blackjack Bet", "ERROR: You need to bet more than $1\n\nInput bet amount that you want to place:\n", "Place Bet", "Close");

        if(GetMoney(playerid) < amount)
            return Dialog_Show(playerid, BlackJack_Bet, DIALOG_STYLE_INPUT, "Blackjack Bet", "ERROR: You don't have enough money\n\nInput bet amount that you want to place:\n", "Place Bet", "Close");

        if(GetMoney(targetid) < amount)
            return Dialog_Show(playerid, BlackJack_Bet, DIALOG_STYLE_INPUT, "Blackjack Bet", "ERROR: Dealer don't have enough money\n\nInput bet amount that you want to place:\n", "Place Bet", "Close");

        if(amount > CardData[playerid][cardMaxBet])
            return Dialog_Show(playerid, BlackJack_Bet, DIALOG_STYLE_INPUT, "Blackjack Bet", "ERROR: Amount can not greater than maximum bet\n\nInput bet amount that you want to place:\n", "Place Bet", "Close");

        if(CardData[playerid][cardGamePrize] > GetMoney(targetid))
            return Dialog_Show(playerid, BlackJack_Bet, DIALOG_STYLE_INPUT, "Blackjack Bet", "ERROR: Dealer don't have enough money for prize pool\n\nInput bet amount that you want to place:\n", "Place Bet", "Close");

        Blackjack_SetPrize(playerid, amount);
        Blackjack_SetPrize(targetid, amount);
        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s throws %s money on table for a blackjack game", ReturnName(playerid), FormatNumber(amount));
    }
    return 1;
}