#include <YSI\y_hooks>

hook OnPlayerClickTD(playerid, Text:clickedid)
{
	#if defined DEBUG_MODE
	    printf("[debug] OnPlayerClickTextDraw(PID : %d)", playerid);
	#endif

    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        if(PlayerTemp[playerid][temp_selecttextdraw])
        {
            new targetid = CardData[playerid][cardGame];
            if(targetid != INVALID_PLAYER_ID)
            {
                if(CardData[playerid][cardScore] >= CardData[targetid][cardScore] && CardData[playerid][cardScore] <= 21)
                {
                    GiveMoney(targetid, CardData[playerid][cardGamePrize], ECONOMY_TAKE_SUPPLY, "won blackjack");
                    Blackjack_End(playerid, CardData[playerid][cardGame]);
                }
                else if(CardData[playerid][cardScore] < CardData[targetid][cardScore])
                {
                    Blackjack_FinishGame(playerid, CardData[playerid][cardGame]);
                    Blackjack_End(playerid, CardData[playerid][cardGame]);
                }
            }
        }
    }
}

hook OnPlayerConnect(playerid)
{
    Blackjack_ResetStats(playerid, false);
    CardData[playerid][cardPlayerType] = 0;
    CardData[playerid][cardGame] = INVALID_PLAYER_ID;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(CardData[playerid][cardGame] != INVALID_PLAYER_ID)
    {
        Blackjack_FinishGame(playerid, CardData[playerid][cardGame]);
        Blackjack_End(playerid, CardData[playerid][cardGame]);
    }
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
    new targetid = CardData[playerid][cardGame];
    if(playertextid == Hit_Button[playerid])
    {        
        if(targetid != INVALID_PLAYER_ID)
        {
            if(CardData[playerid][cardGamePrize] > 0)
            {
                if(CardData[playerid][cardPlayerTurn])
                {
                    if(!CardData[playerid][cardPlayerStand])
                    {
                        if(CardData[playerid][cardTurn] < 5)
                        {
                            ++CardData[playerid][cardTurn];
                            
                            CardData[playerid][cardValue] = RandomEx(1, 10);
                            CardData[playerid][cardValueType] = RandomEx(0, 3);
                            if(CardData[playerid][cardValue] == 10) 
                                CardData[playerid][cardValueTen] = RandomEx(0, 15);
                            
                            if(CardData[playerid][cardTurn] == 1 && CardData[playerid][cardValue] == 1)
                                CardData[playerid][cardScore] += 10;
                                
                            if(CardData[playerid][cardPlayerType] == CARD_DEALER)
                            {
                                Blackjack_Hit(playerid, CardData[playerid][cardTurn], true, CardData[playerid][cardValue], CardData[playerid][cardValueType], CardData[playerid][cardValueTen]);
                                Blackjack_Hit(targetid, CardData[playerid][cardTurn], true, CardData[playerid][cardValue], CardData[playerid][cardValueType], CardData[playerid][cardValueTen]);
                            }
                            else if(CardData[playerid][cardPlayerType] == CARD_PLAYER)
                            {
                                Blackjack_Hit(playerid, CardData[playerid][cardTurn], false, CardData[playerid][cardValue], CardData[playerid][cardValueType], CardData[playerid][cardValueTen]);
                                Blackjack_Hit(targetid, CardData[playerid][cardTurn], false, CardData[playerid][cardValue], CardData[playerid][cardValueType], CardData[playerid][cardValueTen]);
                            }
                            Blackjack_OnHit(playerid, targetid);
                        }
                        else SendErrorMessage(playerid, "You're only allowed to hit 5 times at one game!");
                    }
                    else SendErrorMessage(playerid, "You already stand your card position!");
                }
                else SendErrorMessage(playerid, "This is not your turn yet!");
            }
            else SendErrorMessage(playerid, "You need to set the bet price first !");
        }
        else SendErrorMessage(playerid, "You dont have opponents to play!");
    }
    else if(playertextid == Bet_Button[playerid])
    {
        if(CardData[playerid][cardGamePrize] == 0)
        {
            if(CardData[playerid][cardPlayerType] == CARD_PLAYER)
            {
                Dialog_Show(playerid, BlackJack_Bet, DIALOG_STYLE_INPUT, "Blackjack Bet", "Input bet amount that you want to place:\n", "Place Bet", "Close");
            }
            else SendErrorMessage(playerid, "Dealer are not allowed to set bet price!");
        }
    }
    else if(playertextid == Stand_Button[playerid])
    {
        if(CardData[playerid][cardPlayerTurn])
        {
            if(!CardData[playerid][cardPlayerStand])
            {
                CardData[playerid][cardPlayerStand] = true;
                CardData[targetid][cardPlayerTurn] = true;
                SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s stands their card on blackjack table with score "RED"%d", ReturnName(playerid), CardData[playerid][cardScore]);
                if(CardData[playerid][cardPlayerStand] && CardData[targetid][cardPlayerStand])
                {
                    Blackjack_FinishGame(playerid, targetid);
                }
            }
            else SendErrorMessage(playerid, "You already on stand position!");
        }
        else SendErrorMessage(playerid, "This is not your turn yet!");
    }
}
