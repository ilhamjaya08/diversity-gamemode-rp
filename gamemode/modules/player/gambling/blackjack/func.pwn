Blackjack_OnHit(playerid, targetid)
{
    CardData[playerid][cardPlayerTurn] = false;
    CardData[targetid][cardPlayerTurn] = true;
    
    CardData[playerid][cardScore] += CardData[playerid][cardValue];
    CardData[playerid][cardValue] = 0;

    CardData[targetid][cardValue] = 0;

    if(CardData[targetid][cardPlayerStand])
    {
        CardData[playerid][cardPlayerTurn] = true;
    }
    
    Blackjack_Update(playerid);
    Blackjack_Update(targetid);
    return 1;
}

Blackjack_Hit(playerid, cardturn, bool:dealer = false, value, value_type, value_ten)
{
    switch(cardturn)
    {
        case 1:
        {
            if(!dealer) Blackjack_RandomCard(playerid, Player_Card_1[playerid], value, value_type, value_ten);
            else Blackjack_RandomCard(playerid, Dealer_Card_1[playerid], value, value_type, value_ten);
        }
        case 2:
        {
            if(!dealer) Blackjack_RandomCard(playerid, Player_Card_2[playerid], value, value_type, value_ten);
            else Blackjack_RandomCard(playerid, Dealer_Card_2[playerid], value, value_type, value_ten);
        }
        case 3:
        {
            if(!dealer) Blackjack_RandomCard(playerid, Player_Card_3[playerid], value, value_type, value_ten);
            else Blackjack_RandomCard(playerid, Dealer_Card_3[playerid], value, value_type, value_ten);
        }
        case 4:
        {
            if(!dealer) Blackjack_RandomCard(playerid, Player_Card_4[playerid], value, value_type, value_ten);
            else Blackjack_RandomCard(playerid, Dealer_Card_4[playerid], value, value_type, value_ten);
        }
        case 5:
        {
            if(!dealer) Blackjack_RandomCard(playerid, Player_Card_5[playerid], value, value_type, value_ten);
            else Blackjack_RandomCard(playerid, Dealer_Card_5[playerid], value, value_type, value_ten);
        }
    }
    Blackjack_Update(playerid);
    return 1;
}

Blackjack_SetPrize(playerid, amount)
{
    GiveMoney(playerid, -amount, ECONOMY_ADD_SUPPLY, "set blackjack prize");
    CardData[playerid][cardGamePrize] += amount;
    Blackjack_SetBet(playerid, amount);
    return 1;
}

Blackjack_SetBet(playerid, amount)
{
    PlayerTextDrawSetString(playerid, Bet_Amount[playerid], sprintf("%s", FormatNumber(amount)));
    return 1;
}

Blackjack_GameExists(playerid)
{
    if(CardData[playerid][cardGame] != INVALID_PLAYER_ID)
        return 1;

    return 0;
}

Blackjack_SetGame(playerid, targetid)
{
    CardData[playerid][cardGame] = targetid;
    CardData[targetid][cardGame] = playerid;
    return 1;
}

Blackjack_PlayerWin(playerid, targetid, prize)
{
    new prizepool = (CardData[playerid][cardGamePrize] + CardData[targetid][cardGamePrize]);
    SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has win %s from blackjack game with score "RED"%d", ReturnName(playerid), FormatNumber(prizepool), CardData[playerid][cardScore]);
    SendNearbyMessage(targetid, 15.0, X11_PLUM, "** %s has lose %s from blackjack game with score "RED"%d", ReturnName(targetid), FormatNumber(prize), CardData[targetid][cardScore]);
    GiveMoney(playerid, prizepool, ECONOMY_TAKE_SUPPLY, "won blackjack");

    Blackjack_ResetTextdraw(playerid);
    Blackjack_ResetTextdraw(targetid);

    Blackjack_ResetStats(playerid);
    Blackjack_ResetStats(targetid);
    return 1;
}


Blackjack_TargetWin(playerid, targetid, prize)
{
    new prizepool = (CardData[playerid][cardGamePrize] + CardData[targetid][cardGamePrize]);
    SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has lose %s from blackjack game with score "RED"%d", ReturnName(playerid), FormatNumber(prize), CardData[playerid][cardScore]);
    SendNearbyMessage(targetid, 15.0, X11_PLUM, "** %s has win %s from blackjack game with score "RED"%d", ReturnName(targetid), FormatNumber(prizepool), CardData[targetid][cardScore]);
    GiveMoney(targetid, prizepool);

    Blackjack_ResetTextdraw(playerid);
    Blackjack_ResetTextdraw(targetid);

    Blackjack_ResetStats(playerid);
    Blackjack_ResetStats(targetid);
    return 1;
}

Blackjack_DrawGame(playerid, targetid, prize)
{
    SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s has draw game %s from blackjack game with score "RED"%d", ReturnName(playerid), FormatNumber(prize), CardData[playerid][cardScore]);
    SendNearbyMessage(targetid, 15.0, X11_PLUM, "** %s has draw game %s from blackjack game with score "RED"%d", ReturnName(targetid), FormatNumber(prize), CardData[targetid][cardScore]);

    GiveMoney(playerid, prize);
    GiveMoney(targetid, prize);

    Blackjack_ResetTextdraw(playerid);
    Blackjack_ResetTextdraw(targetid);

    Blackjack_ResetStats(playerid);
    Blackjack_ResetStats(targetid);
    return 1;
}

Blackjack_FinishGame(playerid, targetid)
{
    new
        prize = CardData[playerid][cardGamePrize]
    ;
    if(CardData[playerid][cardScore] > CardData[targetid][cardScore] && CardData[playerid][cardScore] <= 21)
    {
        Blackjack_PlayerWin(playerid, targetid, prize);
    }
    else if(CardData[targetid][cardScore] > CardData[playerid][cardScore] && CardData[targetid][cardScore] <= 21)
    {
        Blackjack_TargetWin(playerid, targetid, prize);
    }
    else if(CardData[playerid][cardScore] > 21 && CardData[playerid][cardPlayerType] == CARD_PLAYER)
    {
        Blackjack_TargetWin(playerid, targetid, prize);
    }
    else if(CardData[targetid][cardScore] > 21 && CardData[targetid][cardPlayerType] == CARD_PLAYER)
    {
        Blackjack_PlayerWin(playerid, targetid, prize);
    }
    else if(CardData[playerid][cardScore] > 21 && CardData[playerid][cardPlayerType] == CARD_DEALER)
    {
        Blackjack_TargetWin(playerid, targetid, prize);
    }
    else if(CardData[targetid][cardScore] > 21 && CardData[targetid][cardPlayerType] == CARD_DEALER)
    {
        Blackjack_PlayerWin(playerid, targetid, prize);
    }
    else if(CardData[playerid][cardScore] == CardData[targetid][cardScore])
    {
        if(CardData[playerid][cardGamePrize] > 0)
        {
            Blackjack_DrawGame(playerid, targetid, prize);
        }
    }
    return 1;
}

Blackjack_ResetStats(playerid, bool:connected = true)
{
    if(CardData[playerid][cardPlayerType] == CARD_DEALER)
    {
        CardData[playerid][cardPlayerTurn] = false;
    }
    else
    {
        CardData[playerid][cardPlayerTurn] = true;
    }

    CardData[playerid][cardGamePrize] = 0;
    CardData[playerid][cardScore] = 0;
    CardData[playerid][cardTurn] = 0;
    CardData[playerid][cardPlayerStand] = false;
    CardData[playerid][cardValue] = 0;
    CardData[playerid][cardValueType] = 0;
    CardData[playerid][cardValueTen] = 0;
    if(connected) Blackjack_Update(playerid);
    return 1;
}

Blackjack_ResetTextdraw(playerid)
{
    PlayerTextDrawSetString(playerid, Dealer_Card_1[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Dealer_Card_2[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Dealer_Card_3[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Dealer_Card_4[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Dealer_Card_5[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Player_Card_1[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Player_Card_2[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Player_Card_3[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Player_Card_4[playerid], "ld_card:cdback");
    PlayerTextDrawSetString(playerid, Player_Card_5[playerid], "ld_card:cdback");
    return 1;
}

Blackjack_EndGame(playerid, targetid)
{
    Blackjack_ResetTextdraw(playerid);
    Blackjack_ResetTextdraw(targetid);

    Blackjack_ResetStats(playerid);
    Blackjack_ResetStats(targetid);

    CardData[playerid][cardGame] = INVALID_PLAYER_ID;
    CardData[targetid][cardGame] = INVALID_PLAYER_ID;
    return 1;
}

Blackjack_Update(playerid)
{
	new targetid = CardData[playerid][cardGame];
	// Scoreboard
    if(CardData[playerid][cardPlayerType] == CARD_DEALER)
    {
	    PlayerTextDrawSetString(playerid, Dealer_Score[playerid], sprintf("%s's Card - Score %d", ReturnName(playerid), CardData[playerid][cardScore]));
	    PlayerTextDrawSetString(playerid, Player_Score[playerid], sprintf("%s's Card - Score %d", ReturnName(targetid), CardData[targetid][cardScore]));
    }
    else
    {
	    PlayerTextDrawSetString(playerid, Dealer_Score[playerid], sprintf("%s's Card - Score %d", ReturnName(targetid), CardData[targetid][cardScore]));
	    PlayerTextDrawSetString(playerid, Player_Score[playerid], sprintf("%s's Card - Score %d", ReturnName(playerid), CardData[playerid][cardScore]));
    }

	// Cash
	PlayerTextDrawSetString(playerid, Pocket_Money_Amount[playerid], sprintf("%s", FormatNumber(GetMoney(playerid))));
	return 1;
}

Blackjack_RandomCard(playerid, PlayerText:card, value, value_type, value_ten)
{
    if(value == 1)
    {
        //Ace
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd1c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd1d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd1h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd1s");
        }
    }
    else if(value == 2)
    {
        //Two
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd2c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd2d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd2h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd2s");
        }
    }
    else if(value == 3)
    {
        //Three
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd3c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd3d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd3h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd3s");
        }
    }
    else if(value == 4)
    {
        //Four
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd4c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd4d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd4h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd4s");
        }
    }
    else if(value == 5)
    {
        //Five
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd5c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd5d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd5h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd5s");
        }
    }
    else if(value == 6)
    {
        //Six
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd6c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd6d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd6h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd6s");
        }
    }
    else if(value == 7)
    {
        //Seven
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd7c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd7d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd7h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd7s");
        }
    }
    else if(value == 8)
    {
        //Eight
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd8c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd8d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd8h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd8s");
        }
    }
    else if(value == 9)
    {
        //Nine
        switch(value_type)
        {
            case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd9c");
            case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd9d");
            case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd9h");
            case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd9s");
        }
    }
    else if(value == 10)
    {
        //Ten
		switch(value_ten)
		{
			case 0: PlayerTextDrawSetString(playerid, card, "ld_card:cd10c");
			case 1: PlayerTextDrawSetString(playerid, card, "ld_card:cd10d");
			case 2: PlayerTextDrawSetString(playerid, card, "ld_card:cd10h");
			case 3: PlayerTextDrawSetString(playerid, card, "ld_card:cd10s");

			case 4: PlayerTextDrawSetString(playerid, card, "ld_card:cd11c");
			case 5: PlayerTextDrawSetString(playerid, card, "ld_card:cd11d");
			case 6: PlayerTextDrawSetString(playerid, card, "ld_card:cd11h");
			case 7: PlayerTextDrawSetString(playerid, card, "ld_card:cd11s");

			case 8: PlayerTextDrawSetString(playerid, card, "ld_card:cd12c");
			case 9: PlayerTextDrawSetString(playerid, card, "ld_card:cd12d");
			case 10: PlayerTextDrawSetString(playerid, card, "ld_card:cd12h");
			case 11: PlayerTextDrawSetString(playerid, card, "ld_card:cd12s");

			case 12: PlayerTextDrawSetString(playerid, card, "ld_card:cd13c");
			case 13: PlayerTextDrawSetString(playerid, card, "ld_card:cd13d");
			case 14: PlayerTextDrawSetString(playerid, card, "ld_card:cd13h");
			case 15: PlayerTextDrawSetString(playerid, card, "ld_card:cd13s");
		}
    }
    return 1;
}