#include <YSI\y_hooks>

new Text:LOGINTD[5];

hook OnGameModeInit()
{
	LOGINTD[0] = TextDrawCreate(321.000000, 148.000000, "_");
	TextDrawFont(LOGINTD[0], 1);
	TextDrawLetterSize(LOGINTD[0], 0.891665, 17.600006);
	TextDrawTextSize(LOGINTD[0], 298.500000, 200.500000);
	TextDrawSetOutline(LOGINTD[0], 1);
	TextDrawSetShadow(LOGINTD[0], 0);
	TextDrawAlignment(LOGINTD[0], 2);
	TextDrawColor(LOGINTD[0], -1);
	TextDrawBackgroundColor(LOGINTD[0], 255);
	TextDrawBoxColor(LOGINTD[0], 135);
	TextDrawUseBox(LOGINTD[0], 1);
	TextDrawSetProportional(LOGINTD[0], 1);
	TextDrawSetSelectable(LOGINTD[0], 0);

	LOGINTD[1] = TextDrawCreate(371.000000, 121.000000, "Diversity World");
	TextDrawFont(LOGINTD[1], 1);
	TextDrawLetterSize(LOGINTD[1], 0.333332, 2.000000);
	TextDrawTextSize(LOGINTD[1], 400.000000, 17.000000);
	TextDrawSetOutline(LOGINTD[1], 1);
	TextDrawSetShadow(LOGINTD[1], 0);
	TextDrawAlignment(LOGINTD[1], 3);
	TextDrawColor(LOGINTD[1], -1);
	TextDrawBackgroundColor(LOGINTD[1], 255);
	TextDrawBoxColor(LOGINTD[1], 50);
	TextDrawUseBox(LOGINTD[1], 0);
	TextDrawSetProportional(LOGINTD[1], 1);
	TextDrawSetSelectable(LOGINTD[1], 0);

	LOGINTD[2] = TextDrawCreate(421.000000, 295.000000, "Diversity 1.3 Deluxe");
	TextDrawFont(LOGINTD[2], 1);
	TextDrawLetterSize(LOGINTD[2], 0.179166, 1.149999);
	TextDrawTextSize(LOGINTD[2], 400.000000, 17.000000);
	TextDrawSetOutline(LOGINTD[2], 1);
	TextDrawSetShadow(LOGINTD[2], 0);
	TextDrawAlignment(LOGINTD[2], 3);
	TextDrawColor(LOGINTD[2], -1);
	TextDrawBackgroundColor(LOGINTD[2], 255);
	TextDrawBoxColor(LOGINTD[2], 50);
	TextDrawUseBox(LOGINTD[2], 0);
	TextDrawSetProportional(LOGINTD[2], 1);
	TextDrawSetSelectable(LOGINTD[2], 0);

	LOGINTD[3] = TextDrawCreate(352.000000, 137.000000, "MODE:ROLEPLAY");
	TextDrawFont(LOGINTD[3], 1);
	TextDrawLetterSize(LOGINTD[3], 0.441666, 1.700000);
	TextDrawTextSize(LOGINTD[3], 400.000000, 17.000000);
	TextDrawSetOutline(LOGINTD[3], 0);
	TextDrawSetShadow(LOGINTD[3], 1);
	TextDrawAlignment(LOGINTD[3], 3);
	TextDrawColor(LOGINTD[3], -1);
	TextDrawBackgroundColor(LOGINTD[3], 255);
	TextDrawBoxColor(LOGINTD[3], 50);
	TextDrawUseBox(LOGINTD[3], 0);
	TextDrawSetProportional(LOGINTD[3], 1);
	TextDrawSetSelectable(LOGINTD[3], 0);

	LOGINTD[4] = TextDrawCreate(371.000000, 121.000000, "Diversity World");
	TextDrawFont(LOGINTD[4], 1);
	TextDrawLetterSize(LOGINTD[4], 0.333332, 1.750000);
	TextDrawTextSize(LOGINTD[4], 400.000000, 17.000000);
	TextDrawSetOutline(LOGINTD[4], 1);
	TextDrawSetShadow(LOGINTD[4], 0);
	TextDrawAlignment(LOGINTD[4], 3);
	TextDrawColor(LOGINTD[4], -16776961);
	TextDrawBackgroundColor(LOGINTD[4], 255);
	TextDrawBoxColor(LOGINTD[4], 50);
	TextDrawUseBox(LOGINTD[4], 0);
	TextDrawSetProportional(LOGINTD[4], 1);
	TextDrawSetSelectable(LOGINTD[4], 0);
	return 1;
}

stock ShowLoginTextdraw(playerid)
{
    for(new txd = 0; txd < 5; txd++)
    {
        TextDrawShowForPlayer(playerid, LOGINTD[txd]);
    }
    return 1;
}

stock HideLoginTextdraw(playerid)
{
    for(new txd = 0; txd < 5; txd++)
    {
        TextDrawHideForPlayer(playerid, LOGINTD[txd]);
    }
    return 1;
}