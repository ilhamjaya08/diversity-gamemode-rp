CMD:blackjack(playerid, params[])
{
    new targetid, amount, bizid = Business_Inside(playerid), string[1024];
    if(sscanf(params, "ud", targetid, amount))
        return SendSyntaxMessage(playerid, "/blackjack [playerid] [maximum bet]");

    if(targetid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "Invalid playerid!");

    if(!IsPlayerNearPlayer(playerid, targetid, 5.0))
        return SendErrorMessage(playerid, "The player is not near you!");

    if(GetMoney(playerid) < amount)
        return SendErrorMessage(playerid, "You dont have enough money to start that maximum bet!");

    if(amount < 1 || amount > 1000000)
        return SendErrorMessage(playerid, "Amount must greater than $1 and less than $1,000,000!");

    if(Blackjack_GameExists(targetid))
        return SendErrorMessage(playerid, "This player is on blackjack game currently!");

    if(bizid == -1)
        return SendErrorMessage(playerid, "You need to play blackjack inside the business!");

    if(BusinessData[bizid][bizType] != 9)
        return SendErrorMessage(playerid, "You need to play blackjack inside bar business!");

    // if(PlayerData[playerid][pBizJobDuty] == -1)
    //     return SendErrorMessage(playerid, "You need to start your business shift before become a blackjack dealer!");

    // if(!Business_IsEmployee(playerid, bizid))
    //     return SendErrorMessage(playerid, "You're not working for this business!");

    SetPVarInt(targetid, "BlackjackTarget", playerid);
    SetPVarInt(targetid, "BlackjackAmount", amount);

    format(string, sizeof(string), "%s Offers you to play "RED"Blackjack "WHITE"with maximum bet "GREEN"%s\n"WHITE"Do you want to play blackjack against "YELLOW"%s "WHITE"?\n\n", ReturnName(playerid), FormatNumber(amount), ReturnName(playerid));
    Dialog_Show(targetid, BlackjackOffer, DIALOG_STYLE_MSGBOX, "Blackjack Game Offer", string, "Yes", "No");

    SendServerMessage(playerid, "You offers a blackjack game against %s with maximum bet %s", ReturnName(targetid), FormatNumber(amount));
    SendServerMessage(targetid, "%s offers a blackjack game against you with maximum bet %s", ReturnName(playerid), FormatNumber(amount));

    return 1;
}

Dialog:BlackjackOffer(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new 
            targetid = GetPVarInt(playerid, "BlackjackTarget"),
            amount = GetPVarInt(playerid, "BlackjackAmount")
        ;


        CardData[playerid][cardMaxBet] = amount;

        CardData[targetid][cardPlayerType] = CARD_DEALER;
        CardData[playerid][cardPlayerType] = CARD_PLAYER;

        CardData[playerid][cardPlayerTurn] = true;
        CardData[targetid][cardPlayerTurn] = false;

        Blackjack_SetGame(playerid, targetid);
        Blackjack_Start(playerid);
        Blackjack_Start(targetid);

        SendServerMessage(playerid, "Blackjack game against %s started, its your turn, you need to bet first before hitting!", ReturnName(targetid));
        SendServerMessage(targetid, "Blackjack game against %s started, its player's turn, let the player bet first!", ReturnName(playerid));
    }
    return 1;
}