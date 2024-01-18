new
	PlayerText:Background_Box_1[MAX_PLAYERS],
	PlayerText:Background_Box_2[MAX_PLAYERS],
	PlayerText:Background_Box_3[MAX_PLAYERS],
	PlayerText:ID_Card_Picture[MAX_PLAYERS],
	PlayerText:Background_Box_4[MAX_PLAYERS],
	PlayerText:SanAndreas_Text[MAX_PLAYERS],
	PlayerText:IdentificationCard_Text[MAX_PLAYERS],
	PlayerText:Line_Separator_1[MAX_PLAYERS],
	PlayerText:ID_Text[MAX_PLAYERS],
	PlayerText:Name_Text[MAX_PLAYERS],
	PlayerText:DOB_Text[MAX_PLAYERS],
	PlayerText:Gender_Text[MAX_PLAYERS],
	PlayerText:Origin_Text[MAX_PLAYERS],
	PlayerText:Separator_1[MAX_PLAYERS],
	PlayerText:Separator_2[MAX_PLAYERS],
	PlayerText:Separator_3[MAX_PLAYERS],
	PlayerText:Separator_4[MAX_PLAYERS],
	PlayerText:Name_Value[MAX_PLAYERS],
	PlayerText:DOB_Value[MAX_PLAYERS],
	PlayerText:Origin_Value[MAX_PLAYERS],
	PlayerText:Gender_Value[MAX_PLAYERS],
	PlayerText:Expired_Text[MAX_PLAYERS],
	PlayerText:Expired_Value[MAX_PLAYERS],
	PlayerText:Separator_5[MAX_PLAYERS],
	PlayerText:ID_Value[MAX_PLAYERS],
	PlayerText:Line_Separator_2[MAX_PLAYERS]
;

IDCard_Init(playerid)
{
	Background_Box_1[playerid] = CreatePlayerTextDraw(playerid, 546.000000, 110.000000, "_");
	PlayerTextDrawFont(playerid, Background_Box_1[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Background_Box_1[playerid], 0.600000, 12.050008);
	PlayerTextDrawTextSize(playerid, Background_Box_1[playerid], 298.500000, 121.500000);
	PlayerTextDrawSetOutline(playerid, Background_Box_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Background_Box_1[playerid], 0);
	PlayerTextDrawAlignment(playerid, Background_Box_1[playerid], 2);
	PlayerTextDrawColor(playerid, Background_Box_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Background_Box_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Background_Box_1[playerid], 255);
	PlayerTextDrawUseBox(playerid, Background_Box_1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Background_Box_1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Background_Box_1[playerid], 0);

	Background_Box_2[playerid] = CreatePlayerTextDraw(playerid, 546.000000, 113.000000, "_");
	PlayerTextDrawFont(playerid, Background_Box_2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Background_Box_2[playerid], 0.600000, 11.250005);
	PlayerTextDrawTextSize(playerid, Background_Box_2[playerid], 298.500000, 116.500000);
	PlayerTextDrawSetOutline(playerid, Background_Box_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Background_Box_2[playerid], 0);
	PlayerTextDrawAlignment(playerid, Background_Box_2[playerid], 2);
	PlayerTextDrawColor(playerid, Background_Box_2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Background_Box_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Background_Box_2[playerid], -1);
	PlayerTextDrawUseBox(playerid, Background_Box_2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Background_Box_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Background_Box_2[playerid], 0);

	Background_Box_3[playerid] = CreatePlayerTextDraw(playerid, 508.000000, 116.000000, "_");
	PlayerTextDrawFont(playerid, Background_Box_3[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Background_Box_3[playerid], 0.600000, 5.149982);
	PlayerTextDrawTextSize(playerid, Background_Box_3[playerid], 298.500000, 30.500000);
	PlayerTextDrawSetOutline(playerid, Background_Box_3[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Background_Box_3[playerid], 0);
	PlayerTextDrawAlignment(playerid, Background_Box_3[playerid], 2);
	PlayerTextDrawColor(playerid, Background_Box_3[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Background_Box_3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Background_Box_3[playerid], 255);
	PlayerTextDrawUseBox(playerid, Background_Box_3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Background_Box_3[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Background_Box_3[playerid], 0);

	ID_Card_Picture[playerid] = CreatePlayerTextDraw(playerid, 457.000000, 109.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, ID_Card_Picture[playerid], 5);
	PlayerTextDrawLetterSize(playerid, ID_Card_Picture[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ID_Card_Picture[playerid], 101.500000, 89.000000);
	PlayerTextDrawSetOutline(playerid, ID_Card_Picture[playerid], 0);
	PlayerTextDrawSetShadow(playerid, ID_Card_Picture[playerid], 0);
	PlayerTextDrawAlignment(playerid, ID_Card_Picture[playerid], 1);
	PlayerTextDrawColor(playerid, ID_Card_Picture[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, ID_Card_Picture[playerid], 0);
	PlayerTextDrawBoxColor(playerid, ID_Card_Picture[playerid], 255);
	PlayerTextDrawUseBox(playerid, ID_Card_Picture[playerid], 0);
	PlayerTextDrawSetProportional(playerid, ID_Card_Picture[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ID_Card_Picture[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, ID_Card_Picture[playerid], 299);
	PlayerTextDrawSetPreviewRot(playerid, ID_Card_Picture[playerid], -16.000000, 0.000000, -2.000000, 1.199998);
	PlayerTextDrawSetPreviewVehCol(playerid, ID_Card_Picture[playerid], 1, 1);

	Background_Box_4[playerid] = CreatePlayerTextDraw(playerid, 546.000000, 151.000000, "_");
	PlayerTextDrawFont(playerid, Background_Box_4[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Background_Box_4[playerid], 0.600000, 5.199983);
	PlayerTextDrawTextSize(playerid, Background_Box_4[playerid], 298.500000, 116.500000);
	PlayerTextDrawSetOutline(playerid, Background_Box_4[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Background_Box_4[playerid], 0);
	PlayerTextDrawAlignment(playerid, Background_Box_4[playerid], 2);
	PlayerTextDrawColor(playerid, Background_Box_4[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Background_Box_4[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Background_Box_4[playerid], -1);
	PlayerTextDrawUseBox(playerid, Background_Box_4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Background_Box_4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Background_Box_4[playerid], 0);

	SanAndreas_Text[playerid] = CreatePlayerTextDraw(playerid, 539.000000, 112.000000, "San Andreas");
	PlayerTextDrawFont(playerid, SanAndreas_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SanAndreas_Text[playerid], 0.174999, 1.149999);
	PlayerTextDrawTextSize(playerid, SanAndreas_Text[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, SanAndreas_Text[playerid], 0);
	PlayerTextDrawSetShadow(playerid, SanAndreas_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, SanAndreas_Text[playerid], 1);
	PlayerTextDrawColor(playerid, SanAndreas_Text[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, SanAndreas_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SanAndreas_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, SanAndreas_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, SanAndreas_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SanAndreas_Text[playerid], 0);

	IdentificationCard_Text[playerid] = CreatePlayerTextDraw(playerid, 529.000000, 124.000000, "Identification Card");
	PlayerTextDrawFont(playerid, IdentificationCard_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, IdentificationCard_Text[playerid], 0.162499, 0.949999);
	PlayerTextDrawTextSize(playerid, IdentificationCard_Text[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, IdentificationCard_Text[playerid], 0);
	PlayerTextDrawSetShadow(playerid, IdentificationCard_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, IdentificationCard_Text[playerid], 1);
	PlayerTextDrawColor(playerid, IdentificationCard_Text[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, IdentificationCard_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, IdentificationCard_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, IdentificationCard_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, IdentificationCard_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, IdentificationCard_Text[playerid], 0);

	Line_Separator_1[playerid] = CreatePlayerTextDraw(playerid, 565.000000, 138.000000, "_");
	PlayerTextDrawFont(playerid, Line_Separator_1[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Line_Separator_1[playerid], 0.600000, -0.250016);
	PlayerTextDrawTextSize(playerid, Line_Separator_1[playerid], 298.500000, 72.000000);
	PlayerTextDrawSetOutline(playerid, Line_Separator_1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Line_Separator_1[playerid], 0);
	PlayerTextDrawAlignment(playerid, Line_Separator_1[playerid], 2);
	PlayerTextDrawColor(playerid, Line_Separator_1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Line_Separator_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Line_Separator_1[playerid], 255);
	PlayerTextDrawUseBox(playerid, Line_Separator_1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Line_Separator_1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Line_Separator_1[playerid], 0);

	ID_Text[playerid] = CreatePlayerTextDraw(playerid, 527.000000, 140.000000, "ID");
	PlayerTextDrawFont(playerid, ID_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, ID_Text[playerid], 0.162499, 0.949999);
	PlayerTextDrawTextSize(playerid, ID_Text[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ID_Text[playerid], 0);
	PlayerTextDrawSetShadow(playerid, ID_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, ID_Text[playerid], 1);
	PlayerTextDrawColor(playerid, ID_Text[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, ID_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ID_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, ID_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, ID_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ID_Text[playerid], 0);

	Name_Text[playerid] = CreatePlayerTextDraw(playerid, 491.000000, 156.000000, "NAME");
	PlayerTextDrawFont(playerid, Name_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Name_Text[playerid], 0.162499, 0.949999);
	PlayerTextDrawTextSize(playerid, Name_Text[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Name_Text[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Name_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, Name_Text[playerid], 1);
	PlayerTextDrawColor(playerid, Name_Text[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Name_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Name_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, Name_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Name_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Name_Text[playerid], 0);

	DOB_Text[playerid] = CreatePlayerTextDraw(playerid, 491.000000, 166.000000, "DOB");
	PlayerTextDrawFont(playerid, DOB_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, DOB_Text[playerid], 0.162499, 0.949999);
	PlayerTextDrawTextSize(playerid, DOB_Text[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DOB_Text[playerid], 0);
	PlayerTextDrawSetShadow(playerid, DOB_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, DOB_Text[playerid], 1);
	PlayerTextDrawColor(playerid, DOB_Text[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, DOB_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DOB_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, DOB_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DOB_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DOB_Text[playerid], 0);

	Gender_Text[playerid] = CreatePlayerTextDraw(playerid, 491.000000, 189.000000, "GENDER");
	PlayerTextDrawFont(playerid, Gender_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Gender_Text[playerid], 0.162499, 0.949999);
	PlayerTextDrawTextSize(playerid, Gender_Text[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Gender_Text[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Gender_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, Gender_Text[playerid], 1);
	PlayerTextDrawColor(playerid, Gender_Text[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Gender_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Gender_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, Gender_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Gender_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Gender_Text[playerid], 0);

	Origin_Text[playerid] = CreatePlayerTextDraw(playerid, 491.000000, 177.000000, "ORIGIN");
	PlayerTextDrawFont(playerid, Origin_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Origin_Text[playerid], 0.162499, 0.949999);
	PlayerTextDrawTextSize(playerid, Origin_Text[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Origin_Text[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Origin_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, Origin_Text[playerid], 1);
	PlayerTextDrawColor(playerid, Origin_Text[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Origin_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Origin_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, Origin_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Origin_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Origin_Text[playerid], 0);

	Separator_1[playerid] = CreatePlayerTextDraw(playerid, 521.000000, 188.000000, ":");
	PlayerTextDrawFont(playerid, Separator_1[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Separator_1[playerid], 0.162499, 1.049999);
	PlayerTextDrawTextSize(playerid, Separator_1[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Separator_1[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Separator_1[playerid], 0);
	PlayerTextDrawAlignment(playerid, Separator_1[playerid], 1);
	PlayerTextDrawColor(playerid, Separator_1[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Separator_1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Separator_1[playerid], 50);
	PlayerTextDrawUseBox(playerid, Separator_1[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Separator_1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Separator_1[playerid], 0);

	Separator_2[playerid] = CreatePlayerTextDraw(playerid, 521.000000, 176.000000, ":");
	PlayerTextDrawFont(playerid, Separator_2[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Separator_2[playerid], 0.162499, 1.049999);
	PlayerTextDrawTextSize(playerid, Separator_2[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Separator_2[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Separator_2[playerid], 0);
	PlayerTextDrawAlignment(playerid, Separator_2[playerid], 1);
	PlayerTextDrawColor(playerid, Separator_2[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Separator_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Separator_2[playerid], 50);
	PlayerTextDrawUseBox(playerid, Separator_2[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Separator_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Separator_2[playerid], 0);

	Separator_3[playerid] = CreatePlayerTextDraw(playerid, 521.000000, 165.000000, ":");
	PlayerTextDrawFont(playerid, Separator_3[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Separator_3[playerid], 0.162499, 1.049999);
	PlayerTextDrawTextSize(playerid, Separator_3[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Separator_3[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Separator_3[playerid], 0);
	PlayerTextDrawAlignment(playerid, Separator_3[playerid], 1);
	PlayerTextDrawColor(playerid, Separator_3[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Separator_3[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Separator_3[playerid], 50);
	PlayerTextDrawUseBox(playerid, Separator_3[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Separator_3[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Separator_3[playerid], 0);

	Separator_4[playerid] = CreatePlayerTextDraw(playerid, 521.000000, 155.000000, ":");
	PlayerTextDrawFont(playerid, Separator_4[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Separator_4[playerid], 0.162499, 1.049999);
	PlayerTextDrawTextSize(playerid, Separator_4[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Separator_4[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Separator_4[playerid], 0);
	PlayerTextDrawAlignment(playerid, Separator_4[playerid], 1);
	PlayerTextDrawColor(playerid, Separator_4[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Separator_4[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Separator_4[playerid], 50);
	PlayerTextDrawUseBox(playerid, Separator_4[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Separator_4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Separator_4[playerid], 0);

	Name_Value[playerid] = CreatePlayerTextDraw(playerid, 526.000000, 155.000000, "Revelt DeOrtiz");
	PlayerTextDrawFont(playerid, Name_Value[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Name_Value[playerid], 0.162499, 1.049999);
	PlayerTextDrawTextSize(playerid, Name_Value[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Name_Value[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Name_Value[playerid], 0);
	PlayerTextDrawAlignment(playerid, Name_Value[playerid], 1);
	PlayerTextDrawColor(playerid, Name_Value[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Name_Value[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Name_Value[playerid], 50);
	PlayerTextDrawUseBox(playerid, Name_Value[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Name_Value[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Name_Value[playerid], 0);

	DOB_Value[playerid] = CreatePlayerTextDraw(playerid, 526.000000, 165.000000, "01/09/1997");
	PlayerTextDrawFont(playerid, DOB_Value[playerid], 2);
	PlayerTextDrawLetterSize(playerid, DOB_Value[playerid], 0.162499, 1.049999);
	PlayerTextDrawTextSize(playerid, DOB_Value[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DOB_Value[playerid], 0);
	PlayerTextDrawSetShadow(playerid, DOB_Value[playerid], 0);
	PlayerTextDrawAlignment(playerid, DOB_Value[playerid], 1);
	PlayerTextDrawColor(playerid, DOB_Value[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, DOB_Value[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DOB_Value[playerid], 50);
	PlayerTextDrawUseBox(playerid, DOB_Value[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DOB_Value[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DOB_Value[playerid], 0);

	Origin_Value[playerid] = CreatePlayerTextDraw(playerid, 526.000000, 176.000000, "Mexico");
	PlayerTextDrawFont(playerid, Origin_Value[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Origin_Value[playerid], 0.162499, 1.049999);
	PlayerTextDrawTextSize(playerid, Origin_Value[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Origin_Value[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Origin_Value[playerid], 0);
	PlayerTextDrawAlignment(playerid, Origin_Value[playerid], 1);
	PlayerTextDrawColor(playerid, Origin_Value[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Origin_Value[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Origin_Value[playerid], 50);
	PlayerTextDrawUseBox(playerid, Origin_Value[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Origin_Value[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Origin_Value[playerid], 0);

	Gender_Value[playerid] = CreatePlayerTextDraw(playerid, 526.000000, 188.000000, "Male");
	PlayerTextDrawFont(playerid, Gender_Value[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Gender_Value[playerid], 0.162499, 1.049999);
	PlayerTextDrawTextSize(playerid, Gender_Value[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Gender_Value[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Gender_Value[playerid], 0);
	PlayerTextDrawAlignment(playerid, Gender_Value[playerid], 1);
	PlayerTextDrawColor(playerid, Gender_Value[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Gender_Value[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Gender_Value[playerid], 50);
	PlayerTextDrawUseBox(playerid, Gender_Value[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Gender_Value[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Gender_Value[playerid], 0);

	Expired_Text[playerid] = CreatePlayerTextDraw(playerid, 491.000000, 204.000000, "EXP:");
	PlayerTextDrawFont(playerid, Expired_Text[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Expired_Text[playerid], 0.162499, 0.949999);
	PlayerTextDrawTextSize(playerid, Expired_Text[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Expired_Text[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Expired_Text[playerid], 0);
	PlayerTextDrawAlignment(playerid, Expired_Text[playerid], 1);
	PlayerTextDrawColor(playerid, Expired_Text[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Expired_Text[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Expired_Text[playerid], 50);
	PlayerTextDrawUseBox(playerid, Expired_Text[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Expired_Text[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Expired_Text[playerid], 0);

	Expired_Value[playerid] = CreatePlayerTextDraw(playerid, 509.000000, 203.000000, "09/12/2099");
	PlayerTextDrawFont(playerid, Expired_Value[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Expired_Value[playerid], 0.137499, 1.149999);
	PlayerTextDrawTextSize(playerid, Expired_Value[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Expired_Value[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Expired_Value[playerid], 0);
	PlayerTextDrawAlignment(playerid, Expired_Value[playerid], 1);
	PlayerTextDrawColor(playerid, Expired_Value[playerid], 9109759);
	PlayerTextDrawBackgroundColor(playerid, Expired_Value[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Expired_Value[playerid], 50);
	PlayerTextDrawUseBox(playerid, Expired_Value[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Expired_Value[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Expired_Value[playerid], 0);

	Separator_5[playerid] = CreatePlayerTextDraw(playerid, 536.000000, 139.000000, ":");
	PlayerTextDrawFont(playerid, Separator_5[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Separator_5[playerid], 0.162499, 1.100000);
	PlayerTextDrawTextSize(playerid, Separator_5[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Separator_5[playerid], 0);
	PlayerTextDrawSetShadow(playerid, Separator_5[playerid], 0);
	PlayerTextDrawAlignment(playerid, Separator_5[playerid], 1);
	PlayerTextDrawColor(playerid, Separator_5[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, Separator_5[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Separator_5[playerid], 50);
	PlayerTextDrawUseBox(playerid, Separator_5[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Separator_5[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Separator_5[playerid], 0);

	ID_Value[playerid] = CreatePlayerTextDraw(playerid, 540.000000, 139.000000, "000000016798");
	PlayerTextDrawFont(playerid, ID_Value[playerid], 2);
	PlayerTextDrawLetterSize(playerid, ID_Value[playerid], 0.162499, 1.100000);
	PlayerTextDrawTextSize(playerid, ID_Value[playerid], 616.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ID_Value[playerid], 0);
	PlayerTextDrawSetShadow(playerid, ID_Value[playerid], 0);
	PlayerTextDrawAlignment(playerid, ID_Value[playerid], 1);
	PlayerTextDrawColor(playerid, ID_Value[playerid], 255);
	PlayerTextDrawBackgroundColor(playerid, ID_Value[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ID_Value[playerid], 50);
	PlayerTextDrawUseBox(playerid, ID_Value[playerid], 0);
	PlayerTextDrawSetProportional(playerid, ID_Value[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ID_Value[playerid], 0);

	Line_Separator_2[playerid] = CreatePlayerTextDraw(playerid, 546.000000, 154.000000, "_");
	PlayerTextDrawFont(playerid, Line_Separator_2[playerid], 1);
	PlayerTextDrawLetterSize(playerid, Line_Separator_2[playerid], 0.600000, -0.250016);
	PlayerTextDrawTextSize(playerid, Line_Separator_2[playerid], 298.500000, 102.000000);
	PlayerTextDrawSetOutline(playerid, Line_Separator_2[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Line_Separator_2[playerid], 0);
	PlayerTextDrawAlignment(playerid, Line_Separator_2[playerid], 2);
	PlayerTextDrawColor(playerid, Line_Separator_2[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, Line_Separator_2[playerid], 255);
	PlayerTextDrawBoxColor(playerid, Line_Separator_2[playerid], 255);
	PlayerTextDrawUseBox(playerid, Line_Separator_2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Line_Separator_2[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Line_Separator_2[playerid], 0);
	return 1;
}

IDCard_Hide(playerid)
{
	PlayerTextDrawHide(playerid, Background_Box_1[playerid]);
	PlayerTextDrawHide(playerid, Background_Box_2[playerid]);
	PlayerTextDrawHide(playerid, Background_Box_3[playerid]);
	PlayerTextDrawHide(playerid, ID_Card_Picture[playerid]);
	PlayerTextDrawHide(playerid, Background_Box_4[playerid]);
	PlayerTextDrawHide(playerid, SanAndreas_Text[playerid]);
	PlayerTextDrawHide(playerid, IdentificationCard_Text[playerid]);
	PlayerTextDrawHide(playerid, Line_Separator_1[playerid]);
	PlayerTextDrawHide(playerid, ID_Text[playerid]);
	PlayerTextDrawHide(playerid, Name_Text[playerid]);
	PlayerTextDrawHide(playerid, DOB_Text[playerid]);
	PlayerTextDrawHide(playerid, Gender_Text[playerid]);
	PlayerTextDrawHide(playerid, Origin_Text[playerid]);

	PlayerTextDrawHide(playerid, Separator_1[playerid]);
	PlayerTextDrawHide(playerid, Separator_2[playerid]);
	PlayerTextDrawHide(playerid, Separator_3[playerid]);
	PlayerTextDrawHide(playerid, Separator_4[playerid]);

	PlayerTextDrawHide(playerid, Name_Value[playerid]);
	PlayerTextDrawHide(playerid, DOB_Value[playerid]);
	PlayerTextDrawHide(playerid, Origin_Value[playerid]);
	PlayerTextDrawHide(playerid, Gender_Value[playerid]);

	PlayerTextDrawHide(playerid, Expired_Text[playerid]);
	PlayerTextDrawHide(playerid, Expired_Value[playerid]);
	PlayerTextDrawHide(playerid, Separator_5[playerid]);
	PlayerTextDrawHide(playerid, ID_Value[playerid]);
	PlayerTextDrawHide(playerid, Line_Separator_2[playerid]);
	return 1;
}

IDCard_Show(playerid, userid)
{
	PlayerTextDrawShow(userid, Background_Box_1[userid]);
	PlayerTextDrawShow(userid, Background_Box_2[userid]);
	PlayerTextDrawShow(userid, Background_Box_3[userid]);
	PlayerTextDrawShow(userid, ID_Card_Picture[userid]);
	PlayerTextDrawShow(userid, Background_Box_4[userid]);
	PlayerTextDrawShow(userid, SanAndreas_Text[userid]);
	PlayerTextDrawShow(userid, IdentificationCard_Text[userid]);
	PlayerTextDrawShow(userid, Line_Separator_1[userid]);
	PlayerTextDrawShow(userid, ID_Text[userid]);
	PlayerTextDrawShow(userid, Name_Text[userid]);
	PlayerTextDrawShow(userid, DOB_Text[userid]);
	PlayerTextDrawShow(userid, Gender_Text[userid]);
	PlayerTextDrawShow(userid, Origin_Text[userid]);

	PlayerTextDrawShow(userid, Separator_1[userid]);
	PlayerTextDrawShow(userid, Separator_2[userid]);
	PlayerTextDrawShow(userid, Separator_3[userid]);
	PlayerTextDrawShow(userid, Separator_4[userid]);

	PlayerTextDrawShow(userid, Name_Value[userid]);
	PlayerTextDrawShow(userid, DOB_Value[userid]);
	PlayerTextDrawShow(userid, Origin_Value[userid]);
	PlayerTextDrawShow(userid, Gender_Value[userid]);

	PlayerTextDrawShow(userid, Expired_Text[userid]);
	PlayerTextDrawShow(userid, Expired_Value[userid]);
	PlayerTextDrawShow(userid, Separator_5[userid]);
	PlayerTextDrawShow(userid, ID_Value[userid]);
	PlayerTextDrawShow(userid, Line_Separator_2[userid]);

	IDCard_Update(playerid, userid);
	return 1;
}

IDCard_Update(playerid, userid)
{
	PlayerTextDrawSetString(userid, ID_Value[userid], sprintf("%SA%06d", PlayerData[playerid][pID]));
	PlayerTextDrawSetString(userid, Name_Value[userid], sprintf("%s", ReturnName(playerid)));
	PlayerTextDrawSetString(userid, DOB_Value[userid], sprintf("%s", PlayerData[playerid][pBirthdate]));
	PlayerTextDrawSetString(userid, Gender_Value[userid], sprintf("%s", (PlayerData[playerid][pGender] == 2) ? ("Female") : ("Male")));
	PlayerTextDrawSetString(userid, Origin_Value[userid], sprintf("%s", PlayerData[playerid][pOrigin]));
	
	if(PlayerData[playerid][pIDCardExpired] != 0) PlayerTextDrawSetString(userid, Expired_Value[userid], sprintf("~g~%s", ConvertTimestamp(Timestamp:PlayerData[playerid][pIDCardExpired])));
	else PlayerTextDrawSetString(userid, Expired_Value[userid], "~r~Expired");

	PlayerTextDrawSetPreviewModel(userid, ID_Card_Picture[userid], PlayerData[playerid][pSkin]);
	PlayerTextDrawHide(userid, ID_Card_Picture[userid]);
	PlayerTextDrawShow(userid, ID_Card_Picture[userid]);

	return 1;
}

//PlayerData[playerid][pDrivingLicenseExpired] = (gettime()+2629746);
CMD:showidcard(playerid, params[])
{
    static
        userid;

    if(sscanf(params, "u", userid)) return SendSyntaxMessage(playerid, "/showidcard [playerid/PartOfName]");
    if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) return SendErrorMessage(playerid, "That player is disconnected or not near you.");
    SendClientMessageEx(playerid, COLOR_WHITE, "You show your id card to %s", ReturnName(userid));
	SendClientMessageEx(userid, COLOR_WHITE, "%s show their id card to you, "YELLOW"'/hideidcard'"WHITE" to hide textdraw", ReturnName(playerid));
    
    SendClientMessageEx(userid, X11_TURQUOISE_1, "=========== San Andreas Identification Card ===========");
    SendCustomMessage(userid, "Registered number","SA%07d", PlayerData[playerid][pID]);
    SendCustomMessage(userid, "Name","%s", ReturnName(playerid));
    SendCustomMessage(userid, "Birdthdate","%s", PlayerData[playerid][pBirthdate]);
    SendCustomMessage(userid, "Gender","%s", (PlayerData[playerid][pGender] == 2) ? ("Female") : ("Male"));
    SendCustomMessage(userid, "Residence","Los Santos");
    SendCustomMessage(userid, "Origin","%s", PlayerData[playerid][pOrigin]);
	if(PlayerData[playerid][pIDCardExpired] != 0) SendCustomMessage(userid, "Valid", ""GREEN"%s", ConvertTimestamp(Timestamp:PlayerData[playerid][pIDCardExpired]));
	else SendCustomMessage(userid, "Valid", ""RED"Expired");
	
	IDCard_Show(playerid, userid);
    return 1;
}

CMD:hideidcard(playerid, params[])
{
	IDCard_Hide(playerid);
	return 1;
}

CMD:extendidcard(playerid, params[])
{
	new userid;
	if(sscanf(params, "u", userid)) 
		return SendSyntaxMessage(playerid, "/extendidcard [playerid/PartOfName]");

	if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) 
		return SendErrorMessage(playerid, "That player is disconnected or not near you.");

	if(GetFactionType(playerid) == FACTION_GOV)
	{
		PlayerData[userid][pIDCardExpired] = (gettime()+((24*3600)*30));
		SendServerMessage(playerid, "You extend %s identification card valid date until %s", ReturnName(userid), ConvertTimestamp(Timestamp:PlayerData[userid][pIDCardExpired]));
		SendServerMessage(userid, "Your id card has been extended by %s until %s", ReturnName(playerid), ConvertTimestamp(Timestamp:PlayerData[userid][pIDCardExpired]));
	}
	else SendErrorMessage(playerid, "You are not part of government!");
	return 1;
}