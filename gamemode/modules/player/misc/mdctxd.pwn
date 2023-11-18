new PlayerText:BlackBackground[MAX_PLAYERS];
new PlayerText:WhiteBackground[MAX_PLAYERS];

new PlayerText:WarrantsButton[MAX_PLAYERS];
new PlayerText:MDCCloseButton[MAX_PLAYERS];
new PlayerText:MainscreenButton[MAX_PLAYERS];
new PlayerText:LookupButton[MAX_PLAYERS];
new PlayerText:PlaceChargeButton[MAX_PLAYERS];
new PlayerText:CallSignButton[MAX_PLAYERS];
new PlayerText:PhoneTraceButton[MAX_PLAYERS];
new PlayerText:CCTVButton[MAX_PLAYERS];


new PlayerText:MDCIcon[MAX_PLAYERS];
new PlayerText:MDCTittle[MAX_PLAYERS];
new PlayerText:PlayerSkin[MAX_PLAYERS];
new PlayerText:MiddleBar[MAX_PLAYERS];
new PlayerText:ScreenLayer[MAX_PLAYERS];
new PlayerText:FactionRankName[MAX_PLAYERS];
new PlayerText:PlayerName[MAX_PLAYERS];

CreateMDCDraw(playerid)
{
	BlackBackground[playerid] = CreatePlayerTextDraw(playerid, 326.000000, 95.000000, "_");
	PlayerTextDrawFont(playerid, BlackBackground[playerid], 1);
	PlayerTextDrawLetterSize(playerid, BlackBackground[playerid], 0.600000, 30.699966);
	PlayerTextDrawTextSize(playerid, BlackBackground[playerid], 298.500000, 343.500000);
	PlayerTextDrawSetOutline(playerid, BlackBackground[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BlackBackground[playerid], 0);
	PlayerTextDrawAlignment(playerid, BlackBackground[playerid], 2);
	PlayerTextDrawColor(playerid, BlackBackground[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, BlackBackground[playerid], 255);
	PlayerTextDrawBoxColor(playerid, BlackBackground[playerid], 255);
	PlayerTextDrawUseBox(playerid, BlackBackground[playerid], 1);
	PlayerTextDrawSetProportional(playerid, BlackBackground[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, BlackBackground[playerid], 0);

	WhiteBackground[playerid] = CreatePlayerTextDraw(playerid, 326.000000, 113.000000, "_");
	PlayerTextDrawFont(playerid, WhiteBackground[playerid], 1);
	PlayerTextDrawLetterSize(playerid, WhiteBackground[playerid], 0.600000, 28.300003);
	PlayerTextDrawTextSize(playerid, WhiteBackground[playerid], 298.500000, 335.000000);
	PlayerTextDrawSetOutline(playerid, WhiteBackground[playerid], 1);
	PlayerTextDrawSetShadow(playerid, WhiteBackground[playerid], 0);
	PlayerTextDrawAlignment(playerid, WhiteBackground[playerid], 2);
	PlayerTextDrawColor(playerid, WhiteBackground[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, WhiteBackground[playerid], 255);
	PlayerTextDrawBoxColor(playerid, WhiteBackground[playerid], -1);
	PlayerTextDrawUseBox(playerid, WhiteBackground[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WhiteBackground[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, WhiteBackground[playerid], 0);

	WarrantsButton[playerid] = CreatePlayerTextDraw(playerid, 188.000000, 178.000000, "WARRANTS");
	PlayerTextDrawFont(playerid, WarrantsButton[playerid], 1);
	PlayerTextDrawLetterSize(playerid, WarrantsButton[playerid], 0.237498, 1.199996);
	PlayerTextDrawTextSize(playerid, WarrantsButton[playerid], 16.500000, 55.500000);
	PlayerTextDrawSetOutline(playerid, WarrantsButton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, WarrantsButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, WarrantsButton[playerid], 2);
	PlayerTextDrawColor(playerid, WarrantsButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, WarrantsButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, WarrantsButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, WarrantsButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, WarrantsButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, WarrantsButton[playerid], 1);

	MDCIcon[playerid] = CreatePlayerTextDraw(playerid, 256.000000, 95.000000, "HUD:radar_gangn");
	PlayerTextDrawFont(playerid, MDCIcon[playerid], 4);
	PlayerTextDrawLetterSize(playerid, MDCIcon[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDCIcon[playerid], 13.500000, 13.000000);
	PlayerTextDrawSetOutline(playerid, MDCIcon[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCIcon[playerid], 0);
	PlayerTextDrawAlignment(playerid, MDCIcon[playerid], 1);
	PlayerTextDrawColor(playerid, MDCIcon[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, MDCIcon[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MDCIcon[playerid], 50);
	PlayerTextDrawUseBox(playerid, MDCIcon[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCIcon[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, MDCIcon[playerid], 0);

	MDCTittle[playerid] = CreatePlayerTextDraw(playerid, 271.000000, 97.000000, "Mobile Digital Computer");
	PlayerTextDrawFont(playerid, MDCTittle[playerid], 1);
	PlayerTextDrawLetterSize(playerid, MDCTittle[playerid], 0.262499, 1.049998);
	PlayerTextDrawTextSize(playerid, MDCTittle[playerid], 475.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDCTittle[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCTittle[playerid], 0);
	PlayerTextDrawAlignment(playerid, MDCTittle[playerid], 1);
	PlayerTextDrawColor(playerid, MDCTittle[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, MDCTittle[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MDCTittle[playerid], 50);
	PlayerTextDrawUseBox(playerid, MDCTittle[playerid], 0);
	PlayerTextDrawSetProportional(playerid, MDCTittle[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, MDCTittle[playerid], 0);

	MDCCloseButton[playerid] = CreatePlayerTextDraw(playerid, 489.000000, 97.000000, "X");
	PlayerTextDrawFont(playerid, MDCCloseButton[playerid], 2);
	PlayerTextDrawLetterSize(playerid, MDCCloseButton[playerid], 0.258332, 1.149999);
	PlayerTextDrawTextSize(playerid, MDCCloseButton[playerid], 16.500000, 9.000000);
	PlayerTextDrawSetOutline(playerid, MDCCloseButton[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MDCCloseButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, MDCCloseButton[playerid], 2);
	PlayerTextDrawColor(playerid, MDCCloseButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, MDCCloseButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MDCCloseButton[playerid], -16776961);
	PlayerTextDrawUseBox(playerid, MDCCloseButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MDCCloseButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, MDCCloseButton[playerid], 1);

	MainscreenButton[playerid] = CreatePlayerTextDraw(playerid, 188.000000, 116.000000, "MAIN SCREEN");
	PlayerTextDrawFont(playerid, MainscreenButton[playerid], 1);
	PlayerTextDrawLetterSize(playerid, MainscreenButton[playerid], 0.191666, 1.200000);
	PlayerTextDrawTextSize(playerid, MainscreenButton[playerid], 16.500000, 55.500000);
	PlayerTextDrawSetOutline(playerid, MainscreenButton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, MainscreenButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, MainscreenButton[playerid], 2);
	PlayerTextDrawColor(playerid, MainscreenButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, MainscreenButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MainscreenButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, MainscreenButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MainscreenButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, MainscreenButton[playerid], 1);

	LookupButton[playerid] = CreatePlayerTextDraw(playerid, 188.000000, 135.000000, "LOOK UP");
	PlayerTextDrawFont(playerid, LookupButton[playerid], 1);
	PlayerTextDrawLetterSize(playerid, LookupButton[playerid], 0.191666, 1.200000);
	PlayerTextDrawTextSize(playerid, LookupButton[playerid], 16.500000, 55.500000);
	PlayerTextDrawSetOutline(playerid, LookupButton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, LookupButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, LookupButton[playerid], 2);
	PlayerTextDrawColor(playerid, LookupButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, LookupButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, LookupButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, LookupButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, LookupButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, LookupButton[playerid], 1);

	PlaceChargeButton[playerid] = CreatePlayerTextDraw(playerid, 188.000000, 198.000000, "PLACE CHARGES");
	PlayerTextDrawFont(playerid, PlaceChargeButton[playerid], 1);
	PlayerTextDrawLetterSize(playerid, PlaceChargeButton[playerid], 0.187497, 1.250000);
	PlayerTextDrawTextSize(playerid, PlaceChargeButton[playerid], 16.500000, 55.500000);
	PlayerTextDrawSetOutline(playerid, PlaceChargeButton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, PlaceChargeButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, PlaceChargeButton[playerid], 2);
	PlayerTextDrawColor(playerid, PlaceChargeButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PlaceChargeButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, PlaceChargeButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, PlaceChargeButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PlaceChargeButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlaceChargeButton[playerid], 1);

	CallSignButton[playerid] = CreatePlayerTextDraw(playerid, 188.000000, 241.000000, "CALL SIGN");
	PlayerTextDrawFont(playerid, CallSignButton[playerid], 1);
	PlayerTextDrawLetterSize(playerid, CallSignButton[playerid], 0.274998, 1.250000);
	PlayerTextDrawTextSize(playerid, CallSignButton[playerid], 16.500000, 55.500000);
	PlayerTextDrawSetOutline(playerid, CallSignButton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, CallSignButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, CallSignButton[playerid], 2);
	PlayerTextDrawColor(playerid, CallSignButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, CallSignButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, CallSignButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, CallSignButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, CallSignButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CallSignButton[playerid], 1);

	PhoneTraceButton[playerid] = CreatePlayerTextDraw(playerid, 188.000000, 220.000000, "PHONE TRACE");
	PlayerTextDrawFont(playerid, PhoneTraceButton[playerid], 1);
	PlayerTextDrawLetterSize(playerid, PhoneTraceButton[playerid], 0.204162, 1.250000);
	PlayerTextDrawTextSize(playerid, PhoneTraceButton[playerid], 16.500000, 55.500000);
	PlayerTextDrawSetOutline(playerid, PhoneTraceButton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, PhoneTraceButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, PhoneTraceButton[playerid], 2);
	PlayerTextDrawColor(playerid, PhoneTraceButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PhoneTraceButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, PhoneTraceButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, PhoneTraceButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PhoneTraceButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PhoneTraceButton[playerid], 1);

	PlayerSkin[playerid] = CreatePlayerTextDraw(playerid, 227.000000, 117.000000, " ");
	PlayerTextDrawFont(playerid, PlayerSkin[playerid], 5);
	PlayerTextDrawLetterSize(playerid, PlayerSkin[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, PlayerSkin[playerid], 256.000000, 208.000000);
	PlayerTextDrawSetOutline(playerid, PlayerSkin[playerid], 0);
	PlayerTextDrawSetShadow(playerid, PlayerSkin[playerid], 0);
	PlayerTextDrawAlignment(playerid, PlayerSkin[playerid], 1);
	PlayerTextDrawColor(playerid, PlayerSkin[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerSkin[playerid], 0);
	PlayerTextDrawBoxColor(playerid, PlayerSkin[playerid], 255);
	PlayerTextDrawUseBox(playerid, PlayerSkin[playerid], 0);
	PlayerTextDrawSetProportional(playerid, PlayerSkin[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerSkin[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, PlayerSkin[playerid], 280);
	PlayerTextDrawSetPreviewRot(playerid, PlayerSkin[playerid], -10.000000, 0.000000, -3.000000, 0.899999);
	PlayerTextDrawSetPreviewVehCol(playerid, PlayerSkin[playerid], 1, 1);

	MiddleBar[playerid] = CreatePlayerTextDraw(playerid, 220.000000, 117.000000, "_");
	PlayerTextDrawFont(playerid, MiddleBar[playerid], 1);
	PlayerTextDrawLetterSize(playerid, MiddleBar[playerid], 0.600000, 27.700016);
	PlayerTextDrawTextSize(playerid, MiddleBar[playerid], 298.500000, -0.500000);
	PlayerTextDrawSetOutline(playerid, MiddleBar[playerid], 1);
	PlayerTextDrawSetShadow(playerid, MiddleBar[playerid], 0);
	PlayerTextDrawAlignment(playerid, MiddleBar[playerid], 2);
	PlayerTextDrawColor(playerid, MiddleBar[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, MiddleBar[playerid], 255);
	PlayerTextDrawBoxColor(playerid, MiddleBar[playerid], 1296911871);
	PlayerTextDrawUseBox(playerid, MiddleBar[playerid], 1);
	PlayerTextDrawSetProportional(playerid, MiddleBar[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, MiddleBar[playerid], 0);

	ScreenLayer[playerid] = CreatePlayerTextDraw(playerid, 359.000000, 169.000000, "_");
	PlayerTextDrawFont(playerid, ScreenLayer[playerid], 1);
	PlayerTextDrawLetterSize(playerid, ScreenLayer[playerid], 0.600000, 21.350002);
	PlayerTextDrawTextSize(playerid, ScreenLayer[playerid], 298.500000, 249.500000);
	PlayerTextDrawSetOutline(playerid, ScreenLayer[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ScreenLayer[playerid], 0);
	PlayerTextDrawAlignment(playerid, ScreenLayer[playerid], 2);
	PlayerTextDrawColor(playerid, ScreenLayer[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, ScreenLayer[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ScreenLayer[playerid], -1);
	PlayerTextDrawUseBox(playerid, ScreenLayer[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ScreenLayer[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ScreenLayer[playerid], 0);

	FactionRankName[playerid] = CreatePlayerTextDraw(playerid, 360.000000, 190.000000, " ");
	PlayerTextDrawFont(playerid, FactionRankName[playerid], 1);
	PlayerTextDrawLetterSize(playerid, FactionRankName[playerid], 0.341666, 1.149999);
	PlayerTextDrawTextSize(playerid, FactionRankName[playerid], 400.000000, 227.500000);
	PlayerTextDrawSetOutline(playerid, FactionRankName[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FactionRankName[playerid], 0);
	PlayerTextDrawAlignment(playerid, FactionRankName[playerid], 2);
	PlayerTextDrawColor(playerid, FactionRankName[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, FactionRankName[playerid], 255);
	PlayerTextDrawBoxColor(playerid, FactionRankName[playerid], 50);
	PlayerTextDrawUseBox(playerid, FactionRankName[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FactionRankName[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FactionRankName[playerid], 0);

	PlayerName[playerid] = CreatePlayerTextDraw(playerid, 360.000000, 173.000000, " ");
	PlayerTextDrawFont(playerid, PlayerName[playerid], 1);
	PlayerTextDrawLetterSize(playerid, PlayerName[playerid], 0.341666, 1.149999);
	PlayerTextDrawTextSize(playerid, PlayerName[playerid], 400.000000, 179.500000);
	PlayerTextDrawSetOutline(playerid, PlayerName[playerid], 1);
	PlayerTextDrawSetShadow(playerid, PlayerName[playerid], 0);
	PlayerTextDrawAlignment(playerid, PlayerName[playerid], 2);
	PlayerTextDrawColor(playerid, PlayerName[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, PlayerName[playerid], 255);
	PlayerTextDrawBoxColor(playerid, PlayerName[playerid], 50);
	PlayerTextDrawUseBox(playerid, PlayerName[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PlayerName[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerName[playerid], 0);

	CCTVButton[playerid] = CreatePlayerTextDraw(playerid, 188.000000, 262.000000, "CCTV");
	PlayerTextDrawFont(playerid, CCTVButton[playerid], 1);
	PlayerTextDrawLetterSize(playerid, CCTVButton[playerid], 0.274998, 1.250000);
	PlayerTextDrawTextSize(playerid, CCTVButton[playerid], 16.500000, 55.500000);
	PlayerTextDrawSetOutline(playerid, CCTVButton[playerid], 0);
	PlayerTextDrawSetShadow(playerid, CCTVButton[playerid], 0);
	PlayerTextDrawAlignment(playerid, CCTVButton[playerid], 2);
	PlayerTextDrawColor(playerid, CCTVButton[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, CCTVButton[playerid], 255);
	PlayerTextDrawBoxColor(playerid, CCTVButton[playerid], 200);
	PlayerTextDrawUseBox(playerid, CCTVButton[playerid], 1);
	PlayerTextDrawSetProportional(playerid, CCTVButton[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CCTVButton[playerid], 1);
	return 1;
}

DestroyMDCDraw(playerid)
{
	PlayerTextDrawDestroy(playerid, BlackBackground[playerid]);
	PlayerTextDrawDestroy(playerid, WhiteBackground[playerid]);
	PlayerTextDrawDestroy(playerid, WarrantsButton[playerid]);
	PlayerTextDrawDestroy(playerid, MDCIcon[playerid]);
	PlayerTextDrawDestroy(playerid, MDCTittle[playerid]);
	PlayerTextDrawDestroy(playerid, MDCCloseButton[playerid]);
	PlayerTextDrawDestroy(playerid, MainscreenButton[playerid]);
	PlayerTextDrawDestroy(playerid, LookupButton[playerid]);
	PlayerTextDrawDestroy(playerid, PlaceChargeButton[playerid]);
	PlayerTextDrawDestroy(playerid, CallSignButton[playerid]);
	PlayerTextDrawDestroy(playerid, PhoneTraceButton[playerid]);
	PlayerTextDrawDestroy(playerid, PlayerSkin[playerid]);
	PlayerTextDrawDestroy(playerid, MiddleBar[playerid]);
	PlayerTextDrawDestroy(playerid, ScreenLayer[playerid]);
	PlayerTextDrawDestroy(playerid, FactionRankName[playerid]);
	PlayerTextDrawDestroy(playerid, PlayerName[playerid]);
	PlayerTextDrawDestroy(playerid, CCTVButton[playerid]);
	return 1;
}

OpenMDC(playerid)
{
	PlayerTextDrawShow(playerid, BlackBackground[playerid]);
	PlayerTextDrawShow(playerid, WhiteBackground[playerid]);
	PlayerTextDrawShow(playerid, WarrantsButton[playerid]);
	PlayerTextDrawShow(playerid, MDCIcon[playerid]);
	PlayerTextDrawShow(playerid, MDCTittle[playerid]);
	PlayerTextDrawShow(playerid, MDCCloseButton[playerid]);
	PlayerTextDrawShow(playerid, MainscreenButton[playerid]);
	PlayerTextDrawShow(playerid, LookupButton[playerid]);
	PlayerTextDrawShow(playerid, PlaceChargeButton[playerid]);
	PlayerTextDrawShow(playerid, CallSignButton[playerid]);
	PlayerTextDrawShow(playerid, PhoneTraceButton[playerid]);
	PlayerTextDrawShow(playerid, PlayerSkin[playerid]);
	PlayerTextDrawShow(playerid, MiddleBar[playerid]);
	PlayerTextDrawShow(playerid, ScreenLayer[playerid]);
	PlayerTextDrawShow(playerid, FactionRankName[playerid]);
	PlayerTextDrawShow(playerid, PlayerName[playerid]);
	PlayerTextDrawShow(playerid, CCTVButton[playerid]);

	PlayerTextDrawSetPreviewModel(playerid, PlayerSkin[playerid], GetPlayerSkin(playerid));
	PlayerTextDrawHide(playerid, PlayerSkin[playerid]);
	PlayerTextDrawShow(playerid, PlayerSkin[playerid]);
	PlayerTextDrawSetString(playerid, PlayerName[playerid], sprintf("%s",ReturnName(playerid)));
	PlayerTextDrawSetString(playerid, FactionRankName[playerid], sprintf("%s - %03d",Faction_GetRank(playerid), PlayerData[playerid][pBadge]));

	SelectTextDrawEx(playerid, 0xFF0000FF);
	return 1;
}

CloseMDC(playerid)
{
	PlayerTextDrawHide(playerid, BlackBackground[playerid]);
	PlayerTextDrawHide(playerid, WhiteBackground[playerid]);
	PlayerTextDrawHide(playerid, WarrantsButton[playerid]);
	PlayerTextDrawHide(playerid, MDCIcon[playerid]);
	PlayerTextDrawHide(playerid, MDCTittle[playerid]);
	PlayerTextDrawHide(playerid, MDCCloseButton[playerid]);
	PlayerTextDrawHide(playerid, MainscreenButton[playerid]);
	PlayerTextDrawHide(playerid, LookupButton[playerid]);
	PlayerTextDrawHide(playerid, PlaceChargeButton[playerid]);
	PlayerTextDrawHide(playerid, CallSignButton[playerid]);
	PlayerTextDrawHide(playerid, PhoneTraceButton[playerid]);
	PlayerTextDrawHide(playerid, PlayerSkin[playerid]);
	PlayerTextDrawHide(playerid, MiddleBar[playerid]);
	PlayerTextDrawHide(playerid, ScreenLayer[playerid]);
	PlayerTextDrawHide(playerid, FactionRankName[playerid]);
	PlayerTextDrawHide(playerid, PlayerName[playerid]);
	PlayerTextDrawHide(playerid, CCTVButton[playerid]);
	CancelSelectTextDrawEx(playerid);
	return 1;
}