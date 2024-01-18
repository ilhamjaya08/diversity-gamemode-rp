#include <YSI\y_hooks>

new 
    PlayerText:Background_3[MAX_PLAYERS],
    PlayerText:Background_2[MAX_PLAYERS],
    PlayerText:Dealer_Score[MAX_PLAYERS],
    PlayerText:Blackjack_Text[MAX_PLAYERS],
    PlayerText:Player_Score[MAX_PLAYERS],
    PlayerText:Hit_Button[MAX_PLAYERS],
    PlayerText:Stand_Button[MAX_PLAYERS],
    PlayerText:Bet_Button[MAX_PLAYERS],
    PlayerText:Bet_Deal[MAX_PLAYERS],
    PlayerText:Pocket_Money_Text[MAX_PLAYERS],
    PlayerText:Bet_Amount[MAX_PLAYERS],
    PlayerText:Pocket_Money_Amount[MAX_PLAYERS],
    PlayerText:Dealer_Card_1[MAX_PLAYERS],
    PlayerText:Dealer_Card_2[MAX_PLAYERS],
    PlayerText:Dealer_Card_3[MAX_PLAYERS],
    PlayerText:Dealer_Card_4[MAX_PLAYERS],
    PlayerText:Dealer_Card_5[MAX_PLAYERS],
    PlayerText:Player_Card_1[MAX_PLAYERS],
    PlayerText:Player_Card_2[MAX_PLAYERS],
    PlayerText:Player_Card_3[MAX_PLAYERS],
    PlayerText:Player_Card_4[MAX_PLAYERS],
    PlayerText:Player_Card_5[MAX_PLAYERS]
;

Blackjack_Start(playerid)
{
    PlayerTextDrawShow(playerid, Background_3[playerid]);
    PlayerTextDrawShow(playerid, Background_2[playerid]);
    PlayerTextDrawShow(playerid, Dealer_Score[playerid]);
    PlayerTextDrawShow(playerid, Blackjack_Text[playerid]);
    PlayerTextDrawShow(playerid, Player_Score[playerid]);
    PlayerTextDrawShow(playerid, Hit_Button[playerid]);
    PlayerTextDrawShow(playerid, Stand_Button[playerid]);
    PlayerTextDrawShow(playerid, Bet_Button[playerid]);
    PlayerTextDrawShow(playerid, Bet_Deal[playerid]);
    PlayerTextDrawShow(playerid, Pocket_Money_Text[playerid]);
    PlayerTextDrawShow(playerid, Bet_Amount[playerid]);
    PlayerTextDrawShow(playerid, Pocket_Money_Amount[playerid]);
    PlayerTextDrawShow(playerid, Dealer_Card_1[playerid]);
    PlayerTextDrawShow(playerid, Dealer_Card_2[playerid]);
    PlayerTextDrawShow(playerid, Dealer_Card_3[playerid]);
    PlayerTextDrawShow(playerid, Dealer_Card_4[playerid]);
    PlayerTextDrawShow(playerid, Dealer_Card_5[playerid]);
    PlayerTextDrawShow(playerid, Player_Card_1[playerid]);
    PlayerTextDrawShow(playerid, Player_Card_2[playerid]);
    PlayerTextDrawShow(playerid, Player_Card_3[playerid]);
    PlayerTextDrawShow(playerid, Player_Card_4[playerid]);
    PlayerTextDrawShow(playerid, Player_Card_5[playerid]);
	Blackjack_Update(playerid);
    SelectTextDrawEx(playerid, 0xFF0000FF);
    return 1;
}
Blackjack_Hide(playerid)
{
    PlayerTextDrawHide(playerid, Background_3[playerid]);
    PlayerTextDrawHide(playerid, Background_2[playerid]);
    PlayerTextDrawHide(playerid, Dealer_Score[playerid]);
    PlayerTextDrawHide(playerid, Blackjack_Text[playerid]);
    PlayerTextDrawHide(playerid, Player_Score[playerid]);
    PlayerTextDrawHide(playerid, Hit_Button[playerid]);
    PlayerTextDrawHide(playerid, Stand_Button[playerid]);
    PlayerTextDrawHide(playerid, Bet_Button[playerid]);
    PlayerTextDrawHide(playerid, Bet_Deal[playerid]);
    PlayerTextDrawHide(playerid, Pocket_Money_Text[playerid]);
    PlayerTextDrawHide(playerid, Bet_Amount[playerid]);
    PlayerTextDrawHide(playerid, Pocket_Money_Amount[playerid]);
    PlayerTextDrawHide(playerid, Dealer_Card_1[playerid]);
    PlayerTextDrawHide(playerid, Dealer_Card_2[playerid]);
    PlayerTextDrawHide(playerid, Dealer_Card_3[playerid]);
    PlayerTextDrawHide(playerid, Dealer_Card_4[playerid]);
    PlayerTextDrawHide(playerid, Dealer_Card_5[playerid]);
    PlayerTextDrawHide(playerid, Player_Card_1[playerid]);
    PlayerTextDrawHide(playerid, Player_Card_2[playerid]);
    PlayerTextDrawHide(playerid, Player_Card_3[playerid]);
    PlayerTextDrawHide(playerid, Player_Card_4[playerid]);
    PlayerTextDrawHide(playerid, Player_Card_5[playerid]);
	CancelSelectTextDrawEx(playerid);
	return 1;
}

Blackjack_End(playerid, targetid)
{
	Blackjack_Hide(playerid);
	Blackjack_Hide(targetid);
	Blackjack_EndGame(playerid, targetid);
    return 1;
}

Blackjack_Initialize(playerid)
{
	Background_3[playerid] = CreatePlayerTextDraw(playerid, 405.000000, 197.000000, "_");
	PlayerTextDrawFont(playerid, Background_3[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Background_3[playerid], 0.600000, 19.450019);
	PlayerTextDrawTextSize(playerid, Background_3[playerid], 298.500000, 301.000000);
	PlayerTextDrawSetOutline(playerid, Background_3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Background_3[playerid], 0);
	PlayerTextDrawAlignment(playerid, Background_3[playerid], 2);
	PlayerTextDrawColor(playerid, Background_3[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Background_3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Background_3[playerid], 135);
	PlayerTextDrawUseBox(playerid, Background_3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Background_3[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Background_3[playerid], 0);

	Background_2[playerid] = CreatePlayerTextDraw(playerid, 204.000000, 215.000000, "_");
	PlayerTextDrawFont(playerid, Background_2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Background_2[playerid], 0.600000, 14.850021);
	PlayerTextDrawTextSize(playerid, Background_2[playerid], 298.500000, 91.000000);
	PlayerTextDrawSetOutline(playerid, Background_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Background_2[playerid], 0);
	PlayerTextDrawAlignment(playerid, Background_2[playerid], 2);
	PlayerTextDrawColor(playerid, Background_2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Background_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Background_2[playerid], 135);
	PlayerTextDrawUseBox(playerid, Background_2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Background_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Background_2[playerid], 0);

	Dealer_Score[playerid] = CreatePlayerTextDraw(playerid, 259.000000, 200.000000, "Dealer's Card - Score : 0");
	PlayerTextDrawFont(playerid, Dealer_Score[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Dealer_Score[playerid], 0.316666, 1.250000);
	PlayerTextDrawTextSize(playerid, Dealer_Score[playerid], 452.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Dealer_Score[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Dealer_Score[playerid], 0);
	PlayerTextDrawAlignment(playerid, Dealer_Score[playerid], 1);
	PlayerTextDrawColor(playerid, Dealer_Score[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Dealer_Score[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Dealer_Score[playerid], 50);
	PlayerTextDrawUseBox(playerid, Dealer_Score[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Dealer_Score[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Dealer_Score[playerid], 0);

	Blackjack_Text[playerid] = CreatePlayerTextDraw(playerid, 204.000000, 216.000000, "Blackjack");
	PlayerTextDrawFont(playerid, Blackjack_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Blackjack_Text[playerid], 0.316666, 1.250000);
	PlayerTextDrawTextSize(playerid, Blackjack_Text[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Blackjack_Text[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Blackjack_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, Blackjack_Text[playerid], 2);
	PlayerTextDrawColor(playerid, Blackjack_Text[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Blackjack_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Blackjack_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, Blackjack_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Blackjack_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Blackjack_Text[playerid], 0);

	Player_Score[playerid] = CreatePlayerTextDraw(playerid, 259.000000, 288.000000, "Your Card - Score : 0");
	PlayerTextDrawFont(playerid, Player_Score[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Player_Score[playerid], 0.316666, 1.250000);
	PlayerTextDrawTextSize(playerid, Player_Score[playerid], 505.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Player_Score[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Player_Score[playerid], 0);
	PlayerTextDrawAlignment(playerid, Player_Score[playerid], 1);
	PlayerTextDrawColor(playerid, Player_Score[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Score[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Player_Score[playerid], 50);
	PlayerTextDrawUseBox(playerid, Player_Score[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Player_Score[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Score[playerid], 0);

	Hit_Button[playerid] = CreatePlayerTextDraw(playerid, 205.000000, 286.000000, "Hit");
	PlayerTextDrawFont(playerid, Hit_Button[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Hit_Button[playerid], 0.258332, 1.200000);
	PlayerTextDrawTextSize(playerid, Hit_Button[playerid], 16.500000, 40.500000);
	PlayerTextDrawSetOutline(playerid, Hit_Button[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Hit_Button[playerid], 0);
	PlayerTextDrawAlignment(playerid, Hit_Button[playerid], 2);
	PlayerTextDrawColor(playerid, Hit_Button[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Hit_Button[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Hit_Button[playerid], 200);
	PlayerTextDrawUseBox(playerid, Hit_Button[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Hit_Button[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Hit_Button[playerid], 1);

	Stand_Button[playerid] = CreatePlayerTextDraw(playerid, 205.000000, 310.000000, "Stand");
	PlayerTextDrawFont(playerid, Stand_Button[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Stand_Button[playerid], 0.199999, 1.200000);
	PlayerTextDrawTextSize(playerid, Stand_Button[playerid], 16.500000, 40.500000);
	PlayerTextDrawSetOutline(playerid, Stand_Button[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Stand_Button[playerid], 0);
	PlayerTextDrawAlignment(playerid, Stand_Button[playerid], 2);
	PlayerTextDrawColor(playerid, Stand_Button[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Stand_Button[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Stand_Button[playerid], 200);
	PlayerTextDrawUseBox(playerid, Stand_Button[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Stand_Button[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Stand_Button[playerid], 1);

	Bet_Button[playerid] = CreatePlayerTextDraw(playerid, 205.000000, 334.000000, "BET");
	PlayerTextDrawFont(playerid, Bet_Button[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Bet_Button[playerid], 0.199999, 1.200000);
	PlayerTextDrawTextSize(playerid, Bet_Button[playerid], 16.500000, 40.500000);
	PlayerTextDrawSetOutline(playerid, Bet_Button[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Bet_Button[playerid], 0);
	PlayerTextDrawAlignment(playerid, Bet_Button[playerid], 2);
	PlayerTextDrawColor(playerid, Bet_Button[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Bet_Button[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Bet_Button[playerid], 200);
	PlayerTextDrawUseBox(playerid, Bet_Button[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Bet_Button[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Bet_Button[playerid], 1);

	Bet_Deal[playerid] = CreatePlayerTextDraw(playerid, 161.000000, 232.000000, "Deal:");
	PlayerTextDrawFont(playerid, Bet_Deal[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Bet_Deal[playerid], 0.229166, 1.000000);
	PlayerTextDrawTextSize(playerid, Bet_Deal[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Bet_Deal[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Bet_Deal[playerid], 0);
	PlayerTextDrawAlignment(playerid, Bet_Deal[playerid], 1);
	PlayerTextDrawColor(playerid, Bet_Deal[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Bet_Deal[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Bet_Deal[playerid], 50);
	PlayerTextDrawUseBox(playerid, Bet_Deal[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Bet_Deal[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Bet_Deal[playerid], 0);

	Pocket_Money_Text[playerid] = CreatePlayerTextDraw(playerid, 161.000000, 256.000000, "Pocket Money:");
	PlayerTextDrawFont(playerid, Pocket_Money_Text[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Pocket_Money_Text[playerid], 0.229166, 1.000000);
	PlayerTextDrawTextSize(playerid, Pocket_Money_Text[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Pocket_Money_Text[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Pocket_Money_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, Pocket_Money_Text[playerid], 1);
	PlayerTextDrawColor(playerid, Pocket_Money_Text[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Pocket_Money_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Pocket_Money_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, Pocket_Money_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Pocket_Money_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Pocket_Money_Text[playerid], 0);

	Bet_Amount[playerid] = CreatePlayerTextDraw(playerid, 161.000000, 244.000000, "$0");
	PlayerTextDrawFont(playerid, Bet_Amount[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Bet_Amount[playerid], 0.183331, 0.800000);
	PlayerTextDrawTextSize(playerid, Bet_Amount[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Bet_Amount[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Bet_Amount[playerid], 0);
	PlayerTextDrawAlignment(playerid, Bet_Amount[playerid], 1);
	PlayerTextDrawColor(playerid, Bet_Amount[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Bet_Amount[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Bet_Amount[playerid], 50);
	PlayerTextDrawUseBox(playerid, Bet_Amount[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Bet_Amount[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Bet_Amount[playerid], 0);

	Pocket_Money_Amount[playerid] = CreatePlayerTextDraw(playerid, 161.000000, 270.000000, "$100,000,000");
	PlayerTextDrawFont(playerid, Pocket_Money_Amount[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Pocket_Money_Amount[playerid], 0.183331, 0.800000);
	PlayerTextDrawTextSize(playerid, Pocket_Money_Amount[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Pocket_Money_Amount[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Pocket_Money_Amount[playerid], 0);
	PlayerTextDrawAlignment(playerid, Pocket_Money_Amount[playerid], 1);
	PlayerTextDrawColor(playerid, Pocket_Money_Amount[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Pocket_Money_Amount[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Pocket_Money_Amount[playerid], 50);
	PlayerTextDrawUseBox(playerid, Pocket_Money_Amount[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Pocket_Money_Amount[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Pocket_Money_Amount[playerid], 0);

	Dealer_Card_1[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 220.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Dealer_Card_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Dealer_Card_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Dealer_Card_1[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Dealer_Card_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Dealer_Card_1[playerid], 0);
	PlayerTextDrawAlignment(playerid, Dealer_Card_1[playerid], 1);
	PlayerTextDrawColor(playerid, Dealer_Card_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Dealer_Card_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Dealer_Card_1[playerid], 50);
	PlayerTextDrawUseBox(playerid, Dealer_Card_1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Dealer_Card_1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Dealer_Card_1[playerid], 0);

	Dealer_Card_2[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 220.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Dealer_Card_2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Dealer_Card_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Dealer_Card_2[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Dealer_Card_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Dealer_Card_2[playerid], 0);
	PlayerTextDrawAlignment(playerid, Dealer_Card_2[playerid], 1);
	PlayerTextDrawColor(playerid, Dealer_Card_2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Dealer_Card_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Dealer_Card_2[playerid], 50);
	PlayerTextDrawUseBox(playerid, Dealer_Card_2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Dealer_Card_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Dealer_Card_2[playerid], 0);

	Dealer_Card_3[playerid] = CreatePlayerTextDraw(playerid, 380.000000, 220.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Dealer_Card_3[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Dealer_Card_3[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Dealer_Card_3[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Dealer_Card_3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Dealer_Card_3[playerid], 0);
	PlayerTextDrawAlignment(playerid, Dealer_Card_3[playerid], 1);
	PlayerTextDrawColor(playerid, Dealer_Card_3[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Dealer_Card_3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Dealer_Card_3[playerid], 50);
	PlayerTextDrawUseBox(playerid, Dealer_Card_3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Dealer_Card_3[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Dealer_Card_3[playerid], 0);

	Dealer_Card_4[playerid] = CreatePlayerTextDraw(playerid, 444.000000, 220.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Dealer_Card_4[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Dealer_Card_4[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Dealer_Card_4[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Dealer_Card_4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Dealer_Card_4[playerid], 0);
	PlayerTextDrawAlignment(playerid, Dealer_Card_4[playerid], 1);
	PlayerTextDrawColor(playerid, Dealer_Card_4[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Dealer_Card_4[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Dealer_Card_4[playerid], 50);
	PlayerTextDrawUseBox(playerid, Dealer_Card_4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Dealer_Card_4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Dealer_Card_4[playerid], 0);

	Dealer_Card_5[playerid] = CreatePlayerTextDraw(playerid, 505.000000, 221.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Dealer_Card_5[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Dealer_Card_5[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Dealer_Card_5[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Dealer_Card_5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Dealer_Card_5[playerid], 0);
	PlayerTextDrawAlignment(playerid, Dealer_Card_5[playerid], 1);
	PlayerTextDrawColor(playerid, Dealer_Card_5[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Dealer_Card_5[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Dealer_Card_5[playerid], 50);
	PlayerTextDrawUseBox(playerid, Dealer_Card_5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Dealer_Card_5[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Dealer_Card_5[playerid], 0);

	Player_Card_1[playerid] = CreatePlayerTextDraw(playerid, 257.000000, 309.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Player_Card_1[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Player_Card_1[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Player_Card_1[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Player_Card_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Player_Card_1[playerid], 0);
	PlayerTextDrawAlignment(playerid, Player_Card_1[playerid], 1);
	PlayerTextDrawColor(playerid, Player_Card_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Card_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Player_Card_1[playerid], 50);
	PlayerTextDrawUseBox(playerid, Player_Card_1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Player_Card_1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Card_1[playerid], 0);

	Player_Card_2[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 309.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Player_Card_2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Player_Card_2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Player_Card_2[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Player_Card_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Player_Card_2[playerid], 0);
	PlayerTextDrawAlignment(playerid, Player_Card_2[playerid], 1);
	PlayerTextDrawColor(playerid, Player_Card_2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Card_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Player_Card_2[playerid], 50);
	PlayerTextDrawUseBox(playerid, Player_Card_2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Player_Card_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Card_2[playerid], 0);

	Player_Card_3[playerid] = CreatePlayerTextDraw(playerid, 380.000000, 309.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Player_Card_3[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Player_Card_3[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Player_Card_3[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Player_Card_3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Player_Card_3[playerid], 0);
	PlayerTextDrawAlignment(playerid, Player_Card_3[playerid], 1);
	PlayerTextDrawColor(playerid, Player_Card_3[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Card_3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Player_Card_3[playerid], 50);
	PlayerTextDrawUseBox(playerid, Player_Card_3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Player_Card_3[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Card_3[playerid], 0);

	Player_Card_4[playerid] = CreatePlayerTextDraw(playerid, 444.000000, 309.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Player_Card_4[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Player_Card_4[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Player_Card_4[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Player_Card_4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Player_Card_4[playerid], 0);
	PlayerTextDrawAlignment(playerid, Player_Card_4[playerid], 1);
	PlayerTextDrawColor(playerid, Player_Card_4[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Card_4[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Player_Card_4[playerid], 50);
	PlayerTextDrawUseBox(playerid, Player_Card_4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Player_Card_4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Card_4[playerid], 0);

	Player_Card_5[playerid] = CreatePlayerTextDraw(playerid, 505.000000, 309.000000, "ld_card:cdback");
	PlayerTextDrawFont(playerid, Player_Card_5[playerid], 4);
	PlayerTextDrawLetterSize(playerid, Player_Card_5[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Player_Card_5[playerid], 46.500000, 59.500000);
	PlayerTextDrawSetOutline(playerid, Player_Card_5[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Player_Card_5[playerid], 0);
	PlayerTextDrawAlignment(playerid, Player_Card_5[playerid], 1);
	PlayerTextDrawColor(playerid, Player_Card_5[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Card_5[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Player_Card_5[playerid], 50);
	PlayerTextDrawUseBox(playerid, Player_Card_5[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Player_Card_5[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Card_5[playerid], 0);
    return 1;
}
