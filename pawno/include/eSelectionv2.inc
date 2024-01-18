/*
	Custom Selection made by Agus Syahputra
	Created Date: 14:09 -  29/10/2016
*/

#if defined _inc_eSelectionv2
	#undef _inc_eSelectionv2
#endif

#if defined _eSelectionv2_included
	#endinput
#endif
#define _eSelectionv2_included

#if !defined MAX_CUSTOM_MODEL
	#define MAX_CUSTOM_MODEL	(400)
#endif

#define CUSTOM_RESPONSE_CANCEL	(0)
#define CUSTOM_RESPONSE_FINAL	(1)

enum g_SelectionMenuEnum {
	PlayerText:CustomSelection[11],
	Float:CustomRot[4],
	CustomModel[MAX_CUSTOM_MODEL],
	CustomShown,
	CustomExtra,
	CustomIgnore,
	CustomTime,
	CustomPage,
	CustomPages
};

static stock
	RotationData[MAX_PLAYERS][g_SelectionMenuEnum]
;

stock HideCustomSelection(playerid)
{
	if (!IsPlayerConnected(playerid) || !RotationData[playerid][CustomShown])
	    return 0;

	for(new i = 0; i != MAX_CUSTOM_MODEL; i++) {
		if (i < 11) {
			PlayerTextDrawDestroy(playerid, RotationData[playerid][CustomSelection][i]);
		}
		RotationData[playerid][CustomModel][i] = -1;
	}
	RotationData[playerid][CustomShown] = 0;
	RotationData[playerid][CustomExtra] = 0;
	RotationData[playerid][CustomPage] = 0;
	RotationData[playerid][CustomPages] = 0;
	RotationData[playerid][CustomIgnore] = 1;

	RotationData[playerid][CustomRot][0] = 0.0;
	RotationData[playerid][CustomRot][1] = 0.0;
	RotationData[playerid][CustomRot][2] = 0.0;
	RotationData[playerid][CustomRot][3] = 1.0;

	CancelSelectTextDraw(playerid);
	return 1;
}

stock ShowCustomSelection(playerid, header[], extraid, items[], size = sizeof(items), Float:fRotX = 0.0, Float:fRotY = 0.0,  Float:fRotZ = 0.0, Float:fZoom = 1.0)
{
	if (!IsPlayerConnected(playerid))
	    return 0;

	if (size > MAX_CUSTOM_MODEL)
	    return printf("** Warning: Please increase \"MAX_CUSTOM_MODEL\" if you want to create more items.");

	if (RotationData[playerid][CustomShown]) {
	    HideCustomSelection(playerid);
	}

	for(new i = 0; i < MAX_CUSTOM_MODEL; i++) {
		if (i >= size) {
			RotationData[playerid][CustomModel][i] = -1;	
		}
		else
		{
			if (items[i] != -1) {
				RotationData[playerid][CustomModel][i] = items[i];
			}
			else {
				RotationData[playerid][CustomModel][i] = -1;
			}
		}
	}


	RotationData[playerid][CustomShown] = 1;
	RotationData[playerid][CustomExtra] = extraid;
	RotationData[playerid][CustomTime] = GetTickCount();
	RotationData[playerid][CustomPage] = 0;
	RotationData[playerid][CustomPages] = size;

	RotationData[playerid][CustomRot][0] = fRotX;
	RotationData[playerid][CustomRot][1] = fRotY;
	RotationData[playerid][CustomRot][2] = fRotZ;
	RotationData[playerid][CustomRot][3] = fZoom;

	
	RotationData[playerid][CustomSelection][0] = CreatePlayerTextDraw(playerid, 319.199676, 108.224952, "box");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][0], 0.000000, 20.576959);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][0], 0.000000, 276.000000);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][0], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][0], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][0], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][0], 206);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][0], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][0], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][0], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][0], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][0], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][0], 0);

	RotationData[playerid][CustomSelection][1] = CreatePlayerTextDraw(playerid, 319.199676, 89.625236, "box");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][1], 0.000000, 1.700001);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][1], 0.000000, 276.000000);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][1], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][1], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][1], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][1], 41718783);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][1], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][1], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][1], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][1], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][1], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][1], 0);

	RotationData[playerid][CustomSelection][2] = CreatePlayerTextDraw(playerid, 322.299987, 90.050003, header);
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][2], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][2], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][2], -15);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][2], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][2], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][2], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][2], 0);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][2], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][2], 0);

	RotationData[playerid][CustomSelection][3] = CreatePlayerTextDraw(playerid, 204.000061, 118.174880, "");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][3], 229.000000, 147.000000);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][3], 1);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][3], -1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][3], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][3], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][3], -2139062272);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][3], 5);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][3], 0);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, RotationData[playerid][CustomSelection][3], RotationData[playerid][CustomModel][RotationData[playerid][CustomPage]]);
	PlayerTextDrawSetPreviewRot(playerid, RotationData[playerid][CustomSelection][3], fRotX, fRotY, fRotZ, fZoom);

	RotationData[playerid][CustomSelection][4] = CreatePlayerTextDraw(playerid, 264.597930, 280.787750, "DONE");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][4], 0.261500, 1.066251);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][4], 10.199999, 156.000000);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][4], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][4], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][4], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][4], -1936945921);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][4], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][4], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][4], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][4], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][4], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][4], 0);
	PlayerTextDrawSetSelectable(playerid, RotationData[playerid][CustomSelection][4], true);

	RotationData[playerid][CustomSelection][5] = CreatePlayerTextDraw(playerid, 370.498474, 280.787750, "BACK");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][5], 0.261500, 1.066251);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][5], 10.220000, 50.520000);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][5], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][5], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][5], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][5], -1936945921);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][5], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][5], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][5], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][5], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][5], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][5], 0);
	PlayerTextDrawSetSelectable(playerid, RotationData[playerid][CustomSelection][5], true);

	RotationData[playerid][CustomSelection][6] = CreatePlayerTextDraw(playerid, 424.349761, 280.862762, "NEXT");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][6], 0.261500, 1.066251);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][6], 10.199999, 50.520000);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][6], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][6], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][6], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][6], -1936945921);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][6], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][6], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][6], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][6], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][6], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][6], 0);
	PlayerTextDrawSetSelectable(playerid, RotationData[playerid][CustomSelection][6], true);

	RotationData[playerid][CustomSelection][7] = CreatePlayerTextDraw(playerid, 205.300872, 109.952499, "RX");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][7], 0.261500, 1.066251);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][7], 10.199999, 47.209999);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][7], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][7], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][7], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][7], -1936945921);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][7], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][7], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][7], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][7], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][7], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][7], 0);
	PlayerTextDrawSetSelectable(playerid, RotationData[playerid][CustomSelection][7], true);

	RotationData[playerid][CustomSelection][8] = CreatePlayerTextDraw(playerid, 262.500000, 109.952499, "RY");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][8], 0.261500, 1.066251);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][8], 10.199999, 47.209999);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][8], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][8], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][8], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][8], -1936945921);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][8], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][8], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][8], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][8], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][8], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][8], 0);
	PlayerTextDrawSetSelectable(playerid, RotationData[playerid][CustomSelection][8], true);

	RotationData[playerid][CustomSelection][9] = CreatePlayerTextDraw(playerid, 318.899139, 109.952499, "RZ");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][9], 0.261500, 1.066251);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][9], 10.199999, 47.209999);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][9], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][9], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][9], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][9], -1936945921);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][9], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][9], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][9], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][9], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][9], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][9], 0);
	PlayerTextDrawSetSelectable(playerid, RotationData[playerid][CustomSelection][9], true);

	RotationData[playerid][CustomSelection][10] = CreatePlayerTextDraw(playerid, 432.497406, 109.952499, "ZOOM-");
	PlayerTextDrawLetterSize(playerid, RotationData[playerid][CustomSelection][10], 0.261500, 1.066251);
	PlayerTextDrawTextSize(playerid, RotationData[playerid][CustomSelection][10], 10.199999, 47.209999);
	PlayerTextDrawAlignment(playerid, RotationData[playerid][CustomSelection][10], 2);
	PlayerTextDrawColor(playerid, RotationData[playerid][CustomSelection][10], -1);
	PlayerTextDrawUseBox(playerid, RotationData[playerid][CustomSelection][10], 1);
	PlayerTextDrawBoxColor(playerid, RotationData[playerid][CustomSelection][10], -1936945921);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][10], 0);
	PlayerTextDrawSetOutline(playerid, RotationData[playerid][CustomSelection][10], 0);
	PlayerTextDrawBackgroundColor(playerid, RotationData[playerid][CustomSelection][10], 255);
	PlayerTextDrawFont(playerid, RotationData[playerid][CustomSelection][10], 1);
	PlayerTextDrawSetProportional(playerid, RotationData[playerid][CustomSelection][10], 1);
	PlayerTextDrawSetShadow(playerid, RotationData[playerid][CustomSelection][10], 0);
	PlayerTextDrawSetSelectable(playerid, RotationData[playerid][CustomSelection][10], true);

	for(new i = 0; i < 11; i++) {
		PlayerTextDrawShow(playerid, RotationData[playerid][CustomSelection][i]);
	}
	SelectTextDraw(playerid, 0xC0C0C0FF);
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if (RotationData[playerid][CustomIgnore] || (GetTickCount() - RotationData[playerid][CustomTime]) < 200)
	{
	    RotationData[playerid][CustomIgnore] = false;
	    return CallLocalFunction("cs_OnPlayerClickTextDraw", "dd", playerid, _:clickedid);
	}
	else if ((clickedid == Text:INVALID_TEXT_DRAW && RotationData[playerid][CustomShown]))
	{
	    CallLocalFunction("CustomSelectionResponse", "dddd", playerid, RotationData[playerid][CustomExtra], 0, CUSTOM_RESPONSE_CANCEL);
	    HideCustomSelection(playerid);
	}
	return CallLocalFunction("cs_OnPlayerClickTextDraw", "dd", playerid, _:clickedid);
}

stock Select_Page(playerid, page)
{
	if (RotationData[playerid][CustomShown])
	{
	    if (page < 0 || page == RotationData[playerid][CustomPages])
		    return 0;

	    RotationData[playerid][CustomPage] = page;
		PlayerTextDrawSetPreviewModel(playerid, RotationData[playerid][CustomSelection][3], RotationData[playerid][CustomModel][RotationData[playerid][CustomPage]]);
		ShowingUpdate(playerid, true);
	}
	return 1;
}

stock ShowingUpdate(playerid, bool:update) {
	PlayerTextDrawHide(playerid, RotationData[playerid][CustomSelection][3]);
    PlayerTextDrawShow(playerid, RotationData[playerid][CustomSelection][3]);

    if(update) {
    	PlayerTextDrawSetPreviewRot(playerid, RotationData[playerid][CustomSelection][3], RotationData[playerid][CustomRot][0], RotationData[playerid][CustomRot][1], RotationData[playerid][CustomRot][2], RotationData[playerid][CustomRot][3]);
    }
    return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if (!RotationData[playerid][CustomShown] || (GetTickCount() - RotationData[playerid][CustomTime]) < 600)
	{
		return CallLocalFunction("cs_OnPlayerClickPlayerTextDraw", "ii", playerid, _:playertextid);
	}

	//Next
	if (playertextid == RotationData[playerid][CustomSelection][6]) {
		if (RotationData[playerid][CustomPage] >= RotationData[playerid][CustomPages]) {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		    return 0;
		}
		else {
			Select_Page(playerid, RotationData[playerid][CustomPage] + 1);
			PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
		}
	}
	//Back
	else if (playertextid == RotationData[playerid][CustomSelection][5]) {
		if (RotationData[playerid][CustomPage] < 0) {
		    PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		    return 0;
		}
        else {
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
			Select_Page(playerid, RotationData[playerid][CustomPage] - 1);
		}
	}
	//Done
	else if (playertextid == RotationData[playerid][CustomSelection][4])
	{
		new model = RotationData[playerid][CustomModel][RotationData[playerid][CustomPage]],
			extraid = RotationData[playerid][CustomExtra];

		HideCustomSelection(playerid);
        CallLocalFunction("CustomSelectionResponse", "dddd", playerid, extraid, model, CUSTOM_RESPONSE_FINAL);	
	}
	//Rot Kiri
	else if (playertextid == RotationData[playerid][CustomSelection][7]) {
		RotationData[playerid][CustomRot][0] += 2.0;
		ShowingUpdate(playerid, true);
	}
	//Rot Kanan
	else if (playertextid == RotationData[playerid][CustomSelection][8]) {
		RotationData[playerid][CustomRot][1] += 2.0;
		ShowingUpdate(playerid, true);
	}
	//Rot Kanan
	else if (playertextid == RotationData[playerid][CustomSelection][9]) {
		RotationData[playerid][CustomRot][2] += 2.0;
		ShowingUpdate(playerid, true);
	}
	//Zoom in
	else if (playertextid == RotationData[playerid][CustomSelection][10]) {
		RotationData[playerid][CustomRot][3] += 0.3;
		ShowingUpdate(playerid, true);
	}
	return CallLocalFunction("cs_OnPlayerClickPlayerTextDraw", "dd", playerid, _:playertextid);
}

#if defined _ALS_OnPlayerClickTextDraw
	#undef OnPlayerClickTextDraw
#else
	#define _ALS_OnPlayerClickTextDraw
#endif

#if defined _ALS_OnPlayerClickPlayerTD
	#undef OnPlayerClickPlayerTextDraw
#else
	#define _ALS_OnPlayerClickPlayerTD
#endif

#define OnPlayerClickTextDraw cs_OnPlayerClickTextDraw
#define OnPlayerClickPlayerTextDraw cs_OnPlayerClickPlayerTextDraw

forward cs_OnPlayerClickTextDraw(playerid, Text:clickedid);
forward cs_OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid);

forward CustomSelectionResponse(playerid, extraid, modelid, response);
