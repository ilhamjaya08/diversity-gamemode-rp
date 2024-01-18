#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	HUD_TEXTDRAW[0] = TextDrawCreate(561.000000, 426.000000, "ld_dual:white");
	TextDrawFont(HUD_TEXTDRAW[0], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[0], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[0], 72.500000, 17.000000);
	TextDrawSetOutline(HUD_TEXTDRAW[0], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[0], 0);
	TextDrawAlignment(HUD_TEXTDRAW[0], 1);
	TextDrawColor(HUD_TEXTDRAW[0], 255);
	TextDrawBackgroundColor(HUD_TEXTDRAW[0], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[0], 50);
	TextDrawUseBox(HUD_TEXTDRAW[0], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[0], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[0], 0);

	HUD_TEXTDRAW[1] = TextDrawCreate(562.000000, 427.000000, "ld_dual:white");
	TextDrawFont(HUD_TEXTDRAW[1], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[1], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[1], 70.500000, 15.000000);
	TextDrawSetOutline(HUD_TEXTDRAW[1], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[1], 0);
	TextDrawAlignment(HUD_TEXTDRAW[1], 1);
	TextDrawColor(HUD_TEXTDRAW[1], 1296911871);
	TextDrawBackgroundColor(HUD_TEXTDRAW[1], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[1], 50);
	TextDrawUseBox(HUD_TEXTDRAW[1], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[1], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[1], 0);

	HUD_TEXTDRAW[2] = TextDrawCreate(580.000000, 429.000000, "ld_dual:white");
	TextDrawFont(HUD_TEXTDRAW[2], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[2], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[2], 1.000000, 11.500000);
	TextDrawSetOutline(HUD_TEXTDRAW[2], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[2], 0);
	TextDrawAlignment(HUD_TEXTDRAW[2], 1);
	TextDrawColor(HUD_TEXTDRAW[2], 255);
	TextDrawBackgroundColor(HUD_TEXTDRAW[2], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[2], 50);
	TextDrawUseBox(HUD_TEXTDRAW[2], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[2], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[2], 0);

	HUD_TEXTDRAW[3] = TextDrawCreate(561.000000, 404.000000, "ld_dual:white");
	TextDrawFont(HUD_TEXTDRAW[3], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[3], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[3], 72.500000, 17.000000);
	TextDrawSetOutline(HUD_TEXTDRAW[3], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[3], 0);
	TextDrawAlignment(HUD_TEXTDRAW[3], 1);
	TextDrawColor(HUD_TEXTDRAW[3], 255);
	TextDrawBackgroundColor(HUD_TEXTDRAW[3], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[3], 50);
	TextDrawUseBox(HUD_TEXTDRAW[3], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[3], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[3], 0);

	HUD_TEXTDRAW[4] = TextDrawCreate(562.000000, 405.000000, "ld_dual:white");
	TextDrawFont(HUD_TEXTDRAW[4], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[4], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[4], 70.500000, 15.000000);
	TextDrawSetOutline(HUD_TEXTDRAW[4], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[4], 0);
	TextDrawAlignment(HUD_TEXTDRAW[4], 1);
	TextDrawColor(HUD_TEXTDRAW[4], 1296911871);
	TextDrawBackgroundColor(HUD_TEXTDRAW[4], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[4], 50);
	TextDrawUseBox(HUD_TEXTDRAW[4], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[4], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[4], 0);

	HUD_TEXTDRAW[5] = TextDrawCreate(580.000000, 407.000000, "ld_dual:white");
	TextDrawFont(HUD_TEXTDRAW[5], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[5], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[5], 1.000000, 11.500000);
	TextDrawSetOutline(HUD_TEXTDRAW[5], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[5], 0);
	TextDrawAlignment(HUD_TEXTDRAW[5], 1);
	TextDrawColor(HUD_TEXTDRAW[5], 255);
	TextDrawBackgroundColor(HUD_TEXTDRAW[5], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[5], 50);
	TextDrawUseBox(HUD_TEXTDRAW[5], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[5], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[5], 0);

	HUD_TEXTDRAW[6] = TextDrawCreate(566.000000, 407.000000, "HUD:radar_pizza");
	TextDrawFont(HUD_TEXTDRAW[6], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[6], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[6], 11.000000, 11.000000);
	TextDrawSetOutline(HUD_TEXTDRAW[6], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[6], 0);
	TextDrawAlignment(HUD_TEXTDRAW[6], 1);
	TextDrawColor(HUD_TEXTDRAW[6], -1);
	TextDrawBackgroundColor(HUD_TEXTDRAW[6], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[6], 50);
	TextDrawUseBox(HUD_TEXTDRAW[6], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[6], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[6], 0);

	HUD_TEXTDRAW[7] = TextDrawCreate(566.000000, 429.000000, "HUD:radar_diner");
	TextDrawFont(HUD_TEXTDRAW[7], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[7], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[7], 11.000000, 11.000000);
	TextDrawSetOutline(HUD_TEXTDRAW[7], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[7], 0);
	TextDrawAlignment(HUD_TEXTDRAW[7], 1);
	TextDrawColor(HUD_TEXTDRAW[7], -1);
	TextDrawBackgroundColor(HUD_TEXTDRAW[7], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[7], 50);
	TextDrawUseBox(HUD_TEXTDRAW[7], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[7], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[7], 0);

	HUD_TEXTDRAW[8] = TextDrawCreate(519.000000, 392.000000, "ld_dual:white");
	TextDrawFont(HUD_TEXTDRAW[8], 4);
	TextDrawLetterSize(HUD_TEXTDRAW[8], 0.600000, 2.000000);
	TextDrawTextSize(HUD_TEXTDRAW[8], 38.500000, 51.000000);
	TextDrawSetOutline(HUD_TEXTDRAW[8], 1);
	TextDrawSetShadow(HUD_TEXTDRAW[8], 0);
	TextDrawAlignment(HUD_TEXTDRAW[8], 1);
	TextDrawColor(HUD_TEXTDRAW[8], 255);
	TextDrawBackgroundColor(HUD_TEXTDRAW[8], 255);
	TextDrawBoxColor(HUD_TEXTDRAW[8], 50);
	TextDrawUseBox(HUD_TEXTDRAW[8], 1);
	TextDrawSetProportional(HUD_TEXTDRAW[8], 1);
	TextDrawSetSelectable(HUD_TEXTDRAW[8], 0);
	return 1;
}
HUD_Init(playerid)
{
	HUDTextdraws[playerid][0] = CreatePlayerTextDraw(playerid, 523.000000, 414.000000, "5");
    PlayerTextDrawFont(playerid, HUDTextdraws[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid, HUDTextdraws[playerid][0], 0.162497, 0.899999);
    PlayerTextDrawTextSize(playerid, HUDTextdraws[playerid][0], 342.000000, 7.500000);
    PlayerTextDrawSetOutline(playerid, HUDTextdraws[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, HUDTextdraws[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, HUDTextdraws[playerid][0], 2);
    PlayerTextDrawColor(playerid, HUDTextdraws[playerid][0], 255);
    PlayerTextDrawBackgroundColor(playerid, HUDTextdraws[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, HUDTextdraws[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, HUDTextdraws[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, HUDTextdraws[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, HUDTextdraws[playerid][0], 0);
    
    HUDTextdraws[playerid][1] = CreatePlayerTextDraw(playerid, 540.000000, 412.000000, "Ananta_Wiguna");
    PlayerTextDrawFont(playerid, HUDTextdraws[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid, HUDTextdraws[playerid][1], 0.141663, 1.250000);
    PlayerTextDrawTextSize(playerid, HUDTextdraws[playerid][1], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, HUDTextdraws[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, HUDTextdraws[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, HUDTextdraws[playerid][1], 1);
    PlayerTextDrawColor(playerid, HUDTextdraws[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, HUDTextdraws[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, HUDTextdraws[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, HUDTextdraws[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid, HUDTextdraws[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, HUDTextdraws[playerid][1], 0);
    
    HUDTextdraws[playerid][2] = CreatePlayerTextDraw(playerid, 517.000000, 427.000000, "Unemployed");
    PlayerTextDrawFont(playerid, HUDTextdraws[playerid][2], 1);
    PlayerTextDrawLetterSize(playerid, HUDTextdraws[playerid][2], 0.141663, 1.000000);
    PlayerTextDrawTextSize(playerid, HUDTextdraws[playerid][2], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, HUDTextdraws[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, HUDTextdraws[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, HUDTextdraws[playerid][2], 1);
    PlayerTextDrawColor(playerid, HUDTextdraws[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, HUDTextdraws[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, HUDTextdraws[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, HUDTextdraws[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid, HUDTextdraws[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, HUDTextdraws[playerid][2], 0);
    
    HUDTextdraws[playerid][3] = CreatePlayerTextDraw(playerid, 591.000000, 410.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, HUDTextdraws[playerid][3], 5);
    PlayerTextDrawLetterSize(playerid, HUDTextdraws[playerid][3], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, HUDTextdraws[playerid][3], 68.000000, 83.500000);
    PlayerTextDrawSetOutline(playerid, HUDTextdraws[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, HUDTextdraws[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, HUDTextdraws[playerid][3], 1);
    PlayerTextDrawColor(playerid, HUDTextdraws[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, HUDTextdraws[playerid][3], 0);
    PlayerTextDrawBoxColor(playerid, HUDTextdraws[playerid][3], 255);
    PlayerTextDrawUseBox(playerid, HUDTextdraws[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid, HUDTextdraws[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, HUDTextdraws[playerid][3], 0);
    PlayerTextDrawSetPreviewModel(playerid, HUDTextdraws[playerid][3], 2);
    PlayerTextDrawSetPreviewRot(playerid, HUDTextdraws[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, HUDTextdraws[playerid][3], 1, 1);

	HungryBar[playerid] = CreatePlayerProgressBar(playerid, 556.000000, 438.000000, 26.000000, 8.500000, 2094792959, 100.000000, 0);
    SetPlayerProgressBarValue(playerid, HungryBar[playerid], 50.000000);

    EnergyBar[playerid] = CreatePlayerProgressBar(playerid, 580.000000, 438.000000, 26.000000, 8.500000, 1097458175, 100.000000, 0);
    SetPlayerProgressBarValue(playerid, EnergyBar[playerid], 50.000000);
	return 1;
}

HUD1_Init(playerid)
{
	//Player Textdraws
	HUNGER_BAR[playerid] = CreatePlayerTextDraw(playerid, 584.000000, 407.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, HUNGER_BAR[playerid], 4);
	PlayerTextDrawLetterSize(playerid, HUNGER_BAR[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HUNGER_BAR[playerid], 46.500000, 11.500000);
	PlayerTextDrawSetOutline(playerid, HUNGER_BAR[playerid], 1);
	PlayerTextDrawSetShadow(playerid, HUNGER_BAR[playerid], 0);
	PlayerTextDrawAlignment(playerid, HUNGER_BAR[playerid], 1);
	PlayerTextDrawColor(playerid, HUNGER_BAR[playerid], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, HUNGER_BAR[playerid], 255);
	PlayerTextDrawBoxColor(playerid, HUNGER_BAR[playerid], 50);
	PlayerTextDrawUseBox(playerid, HUNGER_BAR[playerid], 1);
	PlayerTextDrawSetProportional(playerid, HUNGER_BAR[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HUNGER_BAR[playerid], 0);

	THIRST_BAR[playerid] = CreatePlayerTextDraw(playerid, 584.000000, 429.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, THIRST_BAR[playerid], 4);
	PlayerTextDrawLetterSize(playerid, THIRST_BAR[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, THIRST_BAR[playerid], 47.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, THIRST_BAR[playerid], 1);
	PlayerTextDrawSetShadow(playerid, THIRST_BAR[playerid], 0);
	PlayerTextDrawAlignment(playerid, THIRST_BAR[playerid], 1);
	PlayerTextDrawColor(playerid, THIRST_BAR[playerid], 1097458175);
	PlayerTextDrawBackgroundColor(playerid, THIRST_BAR[playerid], 255);
	PlayerTextDrawBoxColor(playerid, THIRST_BAR[playerid], 50);
	PlayerTextDrawUseBox(playerid, THIRST_BAR[playerid], 1);
	PlayerTextDrawSetProportional(playerid, THIRST_BAR[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, THIRST_BAR[playerid], 0);

	HUNGER_PERC[playerid] = CreatePlayerTextDraw(playerid, 606.000000, 406.000000, "99");
	PlayerTextDrawFont(playerid, HUNGER_PERC[playerid], 1);
	PlayerTextDrawLetterSize(playerid, HUNGER_PERC[playerid], 0.170833, 1.350000);
	PlayerTextDrawTextSize(playerid, HUNGER_PERC[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HUNGER_PERC[playerid], 0);
	PlayerTextDrawSetShadow(playerid, HUNGER_PERC[playerid], 0);
	PlayerTextDrawAlignment(playerid, HUNGER_PERC[playerid], 2);
	PlayerTextDrawColor(playerid, HUNGER_PERC[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, HUNGER_PERC[playerid], 255);
	PlayerTextDrawBoxColor(playerid, HUNGER_PERC[playerid], 50);
	PlayerTextDrawUseBox(playerid, HUNGER_PERC[playerid], 0);
	PlayerTextDrawSetProportional(playerid, HUNGER_PERC[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, HUNGER_PERC[playerid], 0);

	THIRST_PERC[playerid] = CreatePlayerTextDraw(playerid, 607.000000, 428.000000, "99");
	PlayerTextDrawFont(playerid, THIRST_PERC[playerid], 1);
	PlayerTextDrawLetterSize(playerid, THIRST_PERC[playerid], 0.170833, 1.350000);
	PlayerTextDrawTextSize(playerid, THIRST_PERC[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, THIRST_PERC[playerid], 0);
	PlayerTextDrawSetShadow(playerid, THIRST_PERC[playerid], 0);
	PlayerTextDrawAlignment(playerid, THIRST_PERC[playerid], 2);
	PlayerTextDrawColor(playerid, THIRST_PERC[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, THIRST_PERC[playerid], 255);
	PlayerTextDrawBoxColor(playerid, THIRST_PERC[playerid], 50);
	PlayerTextDrawUseBox(playerid, THIRST_PERC[playerid], 0);
	PlayerTextDrawSetProportional(playerid, THIRST_PERC[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, THIRST_PERC[playerid], 0);

	PlayerSkinTD[playerid] = CreatePlayerTextDraw(playerid, 520.000000, 393.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, PlayerSkinTD[playerid], 5);
	PlayerTextDrawLetterSize(playerid, PlayerSkinTD[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerSkinTD[playerid], 37.000000, 49.000000);
	PlayerTextDrawSetOutline(playerid, PlayerSkinTD[playerid], 0);
	PlayerTextDrawSetShadow(playerid, PlayerSkinTD[playerid], 0);
	PlayerTextDrawAlignment(playerid, PlayerSkinTD[playerid], 1);
	PlayerTextDrawColor(playerid, PlayerSkinTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerSkinTD[playerid], 1296911871);
	PlayerTextDrawBoxColor(playerid, PlayerSkinTD[playerid], 255);
	PlayerTextDrawUseBox(playerid, PlayerSkinTD[playerid], 0);
	PlayerTextDrawSetProportional(playerid, PlayerSkinTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSkinTD[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, PlayerSkinTD[playerid], 3);
	PlayerTextDrawSetPreviewRot(playerid, PlayerSkinTD[playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerSkinTD[playerid], 1, 1);

	PlayerNameTD[playerid] = CreatePlayerTextDraw(playerid, 597.000000, 390.000000, "Ananta_Wiguna");
	PlayerTextDrawFont(playerid, PlayerNameTD[playerid], 3);
	PlayerTextDrawLetterSize(playerid, PlayerNameTD[playerid], 0.245829, 1.299998);
	PlayerTextDrawTextSize(playerid, PlayerNameTD[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, PlayerNameTD[playerid], 0);
	PlayerTextDrawSetShadow(playerid, PlayerNameTD[playerid], 0);
	PlayerTextDrawAlignment(playerid, PlayerNameTD[playerid], 2);
	PlayerTextDrawColor(playerid, PlayerNameTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerNameTD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, PlayerNameTD[playerid], 50);
	PlayerTextDrawUseBox(playerid, PlayerNameTD[playerid], 0);
	PlayerTextDrawSetProportional(playerid, PlayerNameTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerNameTD[playerid], 0);

	VehiclesTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, 519.000000, 323.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][0], 85.000000, 51.000000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][0], 1);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][0], 255);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][0], 0);

	VehiclesTextdraw[playerid][1] = CreatePlayerTextDraw(playerid, 520.000000, 324.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][1], 81.000000, 48.500000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][1], 1);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][1], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][1], 0);

	VehiclesTextdraw[playerid][2] = CreatePlayerTextDraw(playerid, 584.000000, 310.000000, "ld_pool:ball");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][2], 54.000000, 66.500000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][2], 1);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][2], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][2], 0);

	VehiclesTextdraw[playerid][3] = CreatePlayerTextDraw(playerid, 584.000000, 292.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][3], 65.500000, 92.500000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][3], 1);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][3], 255);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, VehiclesTextdraw[playerid][3], 560);
	PlayerTextDrawSetPreviewRot(playerid, VehiclesTextdraw[playerid][3], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, VehiclesTextdraw[playerid][3], 1, 1);

	VehiclesTextdraw[playerid][4] = CreatePlayerTextDraw(playerid, 524.000000, 326.000000, "Heath:");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][4], 0.162496, 1.200000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][4], 1);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][4], 0);

	VehiclesTextdraw[playerid][5] = CreatePlayerTextDraw(playerid, 524.000000, 337.000000, "Speed:");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][5], 0.170833, 1.200000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][5], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][5], 1);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][5], 0);

	VehiclesTextdraw[playerid][6] = CreatePlayerTextDraw(playerid, 524.000000, 349.000000, "Fuel:");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][6], 0.170833, 1.200000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][6], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][6], 1);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][6], 0);

	VehiclesTextdraw[playerid][7] = CreatePlayerTextDraw(playerid, 547.000000, 326.000000, "100.0%");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][7], 0.162496, 1.200000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][7], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][7], 1);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][7], 1433087999);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][7], 0);

	VehiclesTextdraw[playerid][8] = CreatePlayerTextDraw(playerid, 553.000000, 337.000000, "100");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][8], 0.170833, 1.200000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][8], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][8], 2);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][8], 1433087999);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][8], 0);

	VehiclesTextdraw[playerid][9] = CreatePlayerTextDraw(playerid, 568.000000, 337.000000, "Mph");
	PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][9], 0.170833, 1.200000);
	PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][9], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][9], 2);
	PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][9], 0);

	FuellBar[playerid] = CreatePlayerProgressBar(playerid, 526.000000, 363.000000, 62.000000, 4.000000, -1, 100.000000, 0);
	SetPlayerProgressBarValue(playerid, FuellBar[playerid], 50.000000);
	return 1;
}

HUD2_Init(playerid)
{
	BOX_HUD2[playerid] = CreatePlayerTextDraw(playerid, 590.000000, 427.000000, "_");
	PlayerTextDrawFont(playerid, BOX_HUD2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, BOX_HUD2[playerid], 0.600000, 1.899997);
	PlayerTextDrawTextSize(playerid, BOX_HUD2[playerid], 298.500000, 94.500000);
	PlayerTextDrawSetOutline(playerid, BOX_HUD2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BOX_HUD2[playerid], 0);
	PlayerTextDrawAlignment(playerid, BOX_HUD2[playerid], 2);
	PlayerTextDrawColor(playerid, BOX_HUD2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, BOX_HUD2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BOX_HUD2[playerid], 135);
	PlayerTextDrawUseBox(playerid, BOX_HUD2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BOX_HUD2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BOX_HUD2[playerid], 0);

	BURGERICON_HUD2[playerid] = CreatePlayerTextDraw(playerid, 548.000000, 430.000000, "HUD:radar_burgershot");
	PlayerTextDrawFont(playerid, BURGERICON_HUD2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, BURGERICON_HUD2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BURGERICON_HUD2[playerid], 12.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, BURGERICON_HUD2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BURGERICON_HUD2[playerid], 0);
	PlayerTextDrawAlignment(playerid, BURGERICON_HUD2[playerid], 1);
	PlayerTextDrawColor(playerid, BURGERICON_HUD2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, BURGERICON_HUD2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BURGERICON_HUD2[playerid], 50);
	PlayerTextDrawUseBox(playerid, BURGERICON_HUD2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BURGERICON_HUD2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BURGERICON_HUD2[playerid], 0);

	BURGERVALUE_HUD2[playerid] = CreatePlayerTextDraw(playerid, 565.000000, 430.000000, "100");
	PlayerTextDrawFont(playerid, BURGERVALUE_HUD2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, BURGERVALUE_HUD2[playerid], 0.308333, 1.150000);
	PlayerTextDrawTextSize(playerid, BURGERVALUE_HUD2[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, BURGERVALUE_HUD2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BURGERVALUE_HUD2[playerid], 0);
	PlayerTextDrawAlignment(playerid, BURGERVALUE_HUD2[playerid], 1);
	PlayerTextDrawColor(playerid, BURGERVALUE_HUD2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, BURGERVALUE_HUD2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BURGERVALUE_HUD2[playerid], 50);
	PlayerTextDrawUseBox(playerid, BURGERVALUE_HUD2[playerid], 0);
	PlayerTextDrawSetProportional(playerid, BURGERVALUE_HUD2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BURGERVALUE_HUD2[playerid], 0);

	DRINKICON_HUD2[playerid] = CreatePlayerTextDraw(playerid, 593.000000, 430.000000, "HUD:radar_diner");
	PlayerTextDrawFont(playerid, DRINKICON_HUD2[playerid], 4);
	PlayerTextDrawLetterSize(playerid, DRINKICON_HUD2[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DRINKICON_HUD2[playerid], 12.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, DRINKICON_HUD2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DRINKICON_HUD2[playerid], 0);
	PlayerTextDrawAlignment(playerid, DRINKICON_HUD2[playerid], 1);
	PlayerTextDrawColor(playerid, DRINKICON_HUD2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, DRINKICON_HUD2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DRINKICON_HUD2[playerid], 50);
	PlayerTextDrawUseBox(playerid, DRINKICON_HUD2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DRINKICON_HUD2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DRINKICON_HUD2[playerid], 0);

	DRINKVALUE_HUD2[playerid] = CreatePlayerTextDraw(playerid, 609.000000, 430.000000, "100");
	PlayerTextDrawFont(playerid, DRINKVALUE_HUD2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, DRINKVALUE_HUD2[playerid], 0.308333, 1.150000);
	PlayerTextDrawTextSize(playerid, DRINKVALUE_HUD2[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DRINKVALUE_HUD2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DRINKVALUE_HUD2[playerid], 0);
	PlayerTextDrawAlignment(playerid, DRINKVALUE_HUD2[playerid], 1);
	PlayerTextDrawColor(playerid, DRINKVALUE_HUD2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, DRINKVALUE_HUD2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DRINKVALUE_HUD2[playerid], 50);
	PlayerTextDrawUseBox(playerid, DRINKVALUE_HUD2[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DRINKVALUE_HUD2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DRINKVALUE_HUD2[playerid], 0);
	return 1;
}


ShowHud_1(playerid)
{
	TextDrawShowForPlayer(playerid, HUD_1);
	TextDrawShowForPlayer(playerid, HUD_2);
	TextDrawShowForPlayer(playerid, HUD_3);
	TextDrawShowForPlayer(playerid, HUD_4);
	for(new i = 0; i < 4; i++ )
	{
		PlayerTextDrawShow(playerid, HUDTextdraws[playerid][i]);
	}
	ShowPlayerProgressBar(playerid, HungryBar[playerid]);
	ShowPlayerProgressBar(playerid, EnergyBar[playerid]);
    return 1;
}


ShowHud_0(playerid)
{
    for(new txd = 0; txd < 9; txd++)
	{
		TextDrawShowForPlayer(playerid, HUD_TEXTDRAW[txd]);
	}
	PlayerTextDrawShow(playerid, HUNGER_BAR[playerid]);
	PlayerTextDrawShow(playerid, THIRST_BAR[playerid]);
	PlayerTextDrawShow(playerid, HUNGER_PERC[playerid]);
	PlayerTextDrawShow(playerid, THIRST_PERC[playerid]);
	PlayerTextDrawShow(playerid, PlayerNameTD[playerid]);
	PlayerTextDrawShow(playerid, PlayerSkinTD[playerid]);
    return 1;
}

ShowHud_2(playerid)
{
    PlayerTextDrawShow(playerid, BOX_HUD2[playerid]);
    PlayerTextDrawShow(playerid, BURGERICON_HUD2[playerid]);
    PlayerTextDrawShow(playerid, BURGERVALUE_HUD2[playerid]);
    PlayerTextDrawShow(playerid, DRINKICON_HUD2[playerid]);
    PlayerTextDrawShow(playerid, DRINKVALUE_HUD2[playerid]);
    return 1;
}


//Hide
HideHud_1(playerid)
{
	TextDrawHideForPlayer(playerid, HUD_1);
	TextDrawHideForPlayer(playerid, HUD_2);
	TextDrawHideForPlayer(playerid, HUD_3);
	TextDrawHideForPlayer(playerid, HUD_4);
	for(new i = 0; i < 4; i++ )
	{
		PlayerTextDrawHide(playerid, HUDTextdraws[playerid][i]);
	}
	HidePlayerProgressBar(playerid, HungryBar[playerid]);
	HidePlayerProgressBar(playerid, EnergyBar[playerid]);
    return 1;
}


HideHud_0(playerid)
{
	for(new txd = 0; txd < 9; txd++)
	{
		TextDrawHideForPlayer(playerid, HUD_TEXTDRAW[txd]);
	}
	PlayerTextDrawHide(playerid, HUNGER_BAR[playerid]);
	PlayerTextDrawHide(playerid, THIRST_BAR[playerid]);
	PlayerTextDrawHide(playerid, HUNGER_PERC[playerid]);
	PlayerTextDrawHide(playerid, THIRST_PERC[playerid]);
	PlayerTextDrawHide(playerid, PlayerNameTD[playerid]);
	PlayerTextDrawHide(playerid, PlayerSkinTD[playerid]);
    return 1;
}

HideHud_2(playerid)
{
    PlayerTextDrawHide(playerid, BOX_HUD2[playerid]);
    PlayerTextDrawHide(playerid, BURGERICON_HUD2[playerid]);
    PlayerTextDrawHide(playerid, BURGERVALUE_HUD2[playerid]);
    PlayerTextDrawHide(playerid, DRINKICON_HUD2[playerid]);
    PlayerTextDrawHide(playerid, DRINKVALUE_HUD2[playerid]);
    return 1;
}

CMD:hudstyle(playerid, params[])
{
	Dialog_Show(playerid, HUDSTYLE, DIALOG_STYLE_LIST, "Hud Style", "Future\nFormula", "Select", "Close");
	return 1;
}

ptask Player_HUDUpdate[1000](playerid)
{
    if(PlayerData[playerid][pHudStyle] == 0)
	{
		PlayerTextDrawSetString(playerid, PlayerNameTD[playerid], sprintf("%s", ReturnPlayerName(playerid)));
	}
	else {
		PlayerTextDrawSetString(playerid, HUDTextdraws[playerid][0], sprintf("%d", playerid));
		PlayerTextDrawSetString(playerid, HUDTextdraws[playerid][1], sprintf("%s", ReturnPlayerName(playerid)));
		PlayerTextDrawSetString(playerid, HUDTextdraws[playerid][2], sprintf("%s", (PlayerData[playerid][pJob] == JOB_NONE) ? ("Unemployed") : (Job_GetName(PlayerData[playerid][pJob]))));
	}
    return 1;
}

Dialog:HUDSTYLE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(listitem == 0)
			{
				SpeedometerNew_Hide(playerid);
				Speedometer_Show(playerid);
			}
			else
			{
				Speedometer_Hide(playerid);
				SpeedometerNew_Show(playerid);
			}
		}

		switch(listitem)
		{
			case 0:
			{
				ShowHud_0(playerid);
				HideHud_1(playerid);
				HideHud_2(playerid);
				SendServerMessage(playerid, "You change your hud style to "LIGHTBLUE"Future mode");
			}
			case 1:
			{
				ShowHud_1(playerid);
				HideHud_0(playerid);
				HideHud_2(playerid);
				SendServerMessage(playerid, "You change your hud style to "LIGHTBLUE"Simple mode");
			}
			case 2:
			{
				ShowHud_2(playerid);
				HideHud_1(playerid);
				HideHud_0(playerid);
				SendServerMessage(playerid, "You change your hud style to "LIGHTBLUE"Classic mode");
			}
		}
		PlayerData[playerid][pHudStyle] = listitem;
	}
	return 1;
}