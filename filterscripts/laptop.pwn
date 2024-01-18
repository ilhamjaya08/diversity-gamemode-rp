//Laptop textdraw system by willbedie.

/* CREDITS:

willbedie - Textdraws & filterscript
maddinat0r - sscanf
SAMP TEAM - creating SA-MP
kar - foreach*/

#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <foreach>

#if defined FILTERSCRIPT
#define DIALOG_FEATURES 0
#define DIALOG_REPORT 1

new Text:TDEditor_TD[16];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("willbedie's Laptop System");
	print("--------------------------------------\n");
	
	TDEditor_TD[0] = TextDrawCreate(69.326614, 59.233386, "box");
	TextDrawLetterSize(TDEditor_TD[0], 0.000000, 36.090507);
	TextDrawTextSize(TDEditor_TD[0], 563.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[0], 1);
	TextDrawColor(TDEditor_TD[0], -1);
	TextDrawUseBox(TDEditor_TD[0], 1);
	TextDrawBoxColor(TDEditor_TD[0], 255);
	TextDrawSetShadow(TDEditor_TD[0], 0);
	TextDrawBackgroundColor(TDEditor_TD[0], 255);
	TextDrawFont(TDEditor_TD[0], 1);
	TextDrawSetProportional(TDEditor_TD[0], 1);

	TDEditor_TD[1] = TextDrawCreate(73.074707, 68.083351, "box");
	TextDrawLetterSize(TDEditor_TD[1], 0.000000, 33.988281);
	TextDrawTextSize(TDEditor_TD[1], 559.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[1], 1);
	TextDrawColor(TDEditor_TD[1], -13303809);
	TextDrawUseBox(TDEditor_TD[1], 1);
	TextDrawBoxColor(TDEditor_TD[1], -1061109505);
	TextDrawSetShadow(TDEditor_TD[1], 0);
	TextDrawBackgroundColor(TDEditor_TD[1], 255);
	TextDrawFont(TDEditor_TD[1], 1);
	TextDrawSetProportional(TDEditor_TD[1], 1);

	TDEditor_TD[2] = TextDrawCreate(76.822875, 93.966316, "box");
	TextDrawLetterSize(TDEditor_TD[2], 0.000000, 30.613441);
	TextDrawTextSize(TDEditor_TD[2], 555.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[2], 1);
	TextDrawColor(TDEditor_TD[2], -1);
	TextDrawUseBox(TDEditor_TD[2], 1);
	TextDrawBoxColor(TDEditor_TD[2], 255);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawBackgroundColor(TDEditor_TD[2], 255);
	TextDrawFont(TDEditor_TD[2], 1);
	TextDrawSetProportional(TDEditor_TD[2], 1);

	TDEditor_TD[3] = TextDrawCreate(77.228454, 94.716323, "box");
	TextDrawLetterSize(TDEditor_TD[3], 0.000000, 30.465255);
	TextDrawTextSize(TDEditor_TD[3], 554.689697, 0.000000);
	TextDrawAlignment(TDEditor_TD[3], 1);
	TextDrawColor(TDEditor_TD[3], -1);
	TextDrawUseBox(TDEditor_TD[3], 1);
	TextDrawBoxColor(TDEditor_TD[3], -1);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawBackgroundColor(TDEditor_TD[3], 255);
	TextDrawFont(TDEditor_TD[3], 1);
	TextDrawSetProportional(TDEditor_TD[3], 1);

	TDEditor_TD[4] = TextDrawCreate(285.711944, 374.983398, "SAMSUNG");
	TextDrawLetterSize(TDEditor_TD[4], 0.320001, 1.360000);
	TextDrawAlignment(TDEditor_TD[4], 1);
	TextDrawColor(TDEditor_TD[4], -1);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawBackgroundColor(TDEditor_TD[4], 255);
	TextDrawFont(TDEditor_TD[4], 1);
	TextDrawSetProportional(TDEditor_TD[4], 1);

	TDEditor_TD[5] = TextDrawCreate(76.791419, 73.700019, "box");
	TextDrawLetterSize(TDEditor_TD[5], 0.000000, 1.498764);
	TextDrawTextSize(TDEditor_TD[5], 270.540985, 0.000000);
	TextDrawAlignment(TDEditor_TD[5], 1);
	TextDrawColor(TDEditor_TD[5], -1);
	TextDrawUseBox(TDEditor_TD[5], 1);
	TextDrawBoxColor(TDEditor_TD[5], 255);
	TextDrawSetShadow(TDEditor_TD[5], 0);
	TextDrawBackgroundColor(TDEditor_TD[5], 255);
	TextDrawFont(TDEditor_TD[5], 1);
	TextDrawSetProportional(TDEditor_TD[5], 1);

	TDEditor_TD[6] = TextDrawCreate(77.291412, 74.500007, "box");
	TextDrawLetterSize(TDEditor_TD[6], 0.000000, 1.332358);
	TextDrawTextSize(TDEditor_TD[6], 270.000000, 0.000000);
	TextDrawAlignment(TDEditor_TD[6], 1);
	TextDrawColor(TDEditor_TD[6], -1);
	TextDrawUseBox(TDEditor_TD[6], 1);
	TextDrawBoxColor(TDEditor_TD[6], -1);
	TextDrawSetShadow(TDEditor_TD[6], 0);
	TextDrawBackgroundColor(TDEditor_TD[6], 255);
	TextDrawFont(TDEditor_TD[6], 1);
	TextDrawSetProportional(TDEditor_TD[6], 1);

	TDEditor_TD[7] = TextDrawCreate(285.036773, 54.666641, "MY_DESKTOP");
	TextDrawLetterSize(TDEditor_TD[7], 0.316000, 1.299998);
	TextDrawAlignment(TDEditor_TD[7], 1);
	TextDrawColor(TDEditor_TD[7], -1);
	TextDrawSetShadow(TDEditor_TD[7], 0);
	TextDrawBackgroundColor(TDEditor_TD[7], 255);
	TextDrawFont(TDEditor_TD[7], 1);
	TextDrawSetProportional(TDEditor_TD[7], 1);

	TDEditor_TD[8] = TextDrawCreate(81.039550, 72.166679, "www.yourname.com");
	TextDrawLetterSize(TDEditor_TD[8], 0.456999, 1.600000);
	TextDrawAlignment(TDEditor_TD[8], 1);
	TextDrawColor(TDEditor_TD[8], 255);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawBackgroundColor(TDEditor_TD[8], 255);
	TextDrawFont(TDEditor_TD[8], 1);
	TextDrawSetProportional(TDEditor_TD[8], 1);

	TDEditor_TD[9] = TextDrawCreate(541.327575, 71.000007, "X");
	TextDrawLetterSize(TDEditor_TD[9], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[9], 1);
	TextDrawColor(TDEditor_TD[9], -16776961);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetOutline(TDEditor_TD[9], 1);
	TextDrawBackgroundColor(TDEditor_TD[9], 255);
	TextDrawFont(TDEditor_TD[9], 1);
	TextDrawSetProportional(TDEditor_TD[9], 1);
 	TextDrawSetSelectable(TDEditor_TD[9], 1);

	TDEditor_TD[10] = TextDrawCreate(76.185974, 94.333320, "loadsc8:loadsc8");
	TextDrawTextSize(TDEditor_TD[10], 479.000000, 275.000000);
	TextDrawAlignment(TDEditor_TD[10], 1);
	TextDrawColor(TDEditor_TD[10], -1);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawBackgroundColor(TDEditor_TD[10], 255);
	TextDrawFont(TDEditor_TD[10], 4);
	TextDrawSetProportional(TDEditor_TD[10], 0);

	TDEditor_TD[11] = TextDrawCreate(83.850677, 109.500045, "New_Server_Features");
	TextDrawLetterSize(TDEditor_TD[11], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[11], 1);
	TextDrawColor(TDEditor_TD[11], -1);
	TextDrawSetShadow(TDEditor_TD[11], -14);
	TextDrawSetOutline(TDEditor_TD[11], 1);
	TextDrawBackgroundColor(TDEditor_TD[11], 255);
	TextDrawFont(TDEditor_TD[11], 1);
	TextDrawSetProportional(TDEditor_TD[11], 1);
	TextDrawSetSelectable(TDEditor_TD[11], 1);

	TDEditor_TD[12] = TextDrawCreate(83.850677, 128.499786, "Report_Someone");
	TextDrawLetterSize(TDEditor_TD[12], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[12], 1);
	TextDrawColor(TDEditor_TD[12], -1);
	TextDrawSetShadow(TDEditor_TD[12], -14);
	TextDrawSetOutline(TDEditor_TD[12], 1);
	TextDrawBackgroundColor(TDEditor_TD[12], 255);
	TextDrawFont(TDEditor_TD[12], 1);
	TextDrawSetProportional(TDEditor_TD[12], 1);
	TextDrawSetSelectable(TDEditor_TD[12], 1);

	TDEditor_TD[13] = TextDrawCreate(83.850677, 147.000915, "Request_an_administrator");
	TextDrawLetterSize(TDEditor_TD[13], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[13], 1);
	TextDrawColor(TDEditor_TD[13], -1);
	TextDrawSetShadow(TDEditor_TD[13], -14);
	TextDrawSetOutline(TDEditor_TD[13], 1);
	TextDrawBackgroundColor(TDEditor_TD[13], 255);
	TextDrawFont(TDEditor_TD[13], 1);
	TextDrawSetProportional(TDEditor_TD[13], 1);
	TextDrawSetSelectable(TDEditor_TD[13], 1);

	TDEditor_TD[14] = TextDrawCreate(83.850677, 166.202087, "Shut_down_the_computer");
	TextDrawLetterSize(TDEditor_TD[14], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[14], 1);
	TextDrawColor(TDEditor_TD[14], -1);
	TextDrawSetShadow(TDEditor_TD[14], -14);
	TextDrawSetOutline(TDEditor_TD[14], 1);
	TextDrawBackgroundColor(TDEditor_TD[14], 255);
	TextDrawFont(TDEditor_TD[14], 1);
	TextDrawSetProportional(TDEditor_TD[14], 1);
	TextDrawSetSelectable(TDEditor_TD[14], true);

	TDEditor_TD[15] = TextDrawCreate(83.850677, 184.603210, "(You_can_write_over_things_here_if_you_want)");
	TextDrawLetterSize(TDEditor_TD[15], 0.400000, 1.600000);
	TextDrawAlignment(TDEditor_TD[15], 1);
	TextDrawColor(TDEditor_TD[15], -1);
	TextDrawSetShadow(TDEditor_TD[15], -14);
	TextDrawSetOutline(TDEditor_TD[15], 1);
	TextDrawBackgroundColor(TDEditor_TD[15], 255);
	TextDrawFont(TDEditor_TD[15], 1);
	TextDrawSetProportional(TDEditor_TD[15], 1);
	TextDrawSetSelectable(TDEditor_TD[15], 1);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#endif

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_SUBMISSION)
    {
        TextDrawShowForPlayer(playerid, TDEditor_TD[0]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[1]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[2]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[3]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[4]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[5]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[6]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[7]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[8]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[9]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[10]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[11]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[12]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[13]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[14]);
        TextDrawShowForPlayer(playerid, TDEditor_TD[15]);
        SelectTextDraw(playerid, 0xFFFFFFAA);
    }
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_REPORT)
	{
	    if(response)
	    {
			new string[256], name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, sizeof(name));
			format(string, sizeof(string), "%s: %s", name, inputtext);
			SendClientMessage(playerid, -1, "{33CCFF}[REPORT]: {FFFFFF}Your report was successfully sent to all online administrators.");
			SendAdminMessage(-1, string);
		}
		return 1;
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == TDEditor_TD[9])
    {
		 HideLaptop(playerid);
         CancelSelectTextDraw(playerid);
         return 1;
    }
    if(clickedid == TDEditor_TD[11])
    {
        new features[4000];
        strcat(features, "Feature #1: Type something here\n");
        strcat(features, "Feature #2: Type something here\n");
        strcat(features, "Feature #3: Type something here\n");
        strcat(features, "Feature #4: Type something here\n");
        strcat(features, "Feature #5: Type something here\n");
        strcat(features, "Feature #6: Type something here\n");
        strcat(features, "Feature #7: Type something here\n");
        strcat(features, "Feature #8: Type something here\n");
        strcat(features, "Feature #9: Type something here\n");
        strcat(features, "Feature #10: Type something here\n");
        ShowPlayerDialog(playerid, DIALOG_FEATURES, DIALOG_STYLE_MSGBOX, "Server Features", features, "Close", "");
		return 1;
	}
	if(clickedid == TDEditor_TD[12])
	{
		ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Report Player", "Write your report here.", "Report", "Cancel");
		return 1;
	}
	if(clickedid == TDEditor_TD[13])
	{
	    new string[256];
		new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
	    format(string, sizeof(string), "ADMIN: %s is requesting an administrator.", name);
	    SendAdminMessage(-1, string);
	    SendClientMessage(playerid, -1, "SERVER: Your request was successfully sent to all online administrators.");
		return 1;
	}
	if(clickedid == TDEditor_TD[14])
	{
	    HideLaptop(playerid);
	    CancelSelectTextDraw(playerid);
	    return 1;
	}
    return 0;
}

CMD:laptop(playerid, params[])
{
	ShowLaptop(playerid);
	SendClientMessage(playerid, -1, "[!] You have turned on your laptop.");
	return 1;
}

CMD:laptopoff(playerid, params[])
{
	HideLaptop(playerid);
	SendClientMessage(playerid, -1, "[!] You have shut your laptop down.");
	return 1;
}

stock ShowLaptop(playerid)
{
	TextDrawShowForPlayer(playerid, TDEditor_TD[0]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[1]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[2]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[3]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[4]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[5]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[6]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[7]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[8]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[9]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[10]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[11]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[12]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[13]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[14]);
	TextDrawShowForPlayer(playerid, TDEditor_TD[15]);
	SelectTextDraw(playerid, 0xFFFFFFAA);
	return 1;
}

stock HideLaptop(playerid)
{
	TextDrawHideForPlayer(playerid, TDEditor_TD[0]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[1]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[2]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[3]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[4]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[5]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[6]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[7]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[8]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[9]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[10]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[11]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[12]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[13]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[14]);
	TextDrawHideForPlayer(playerid, TDEditor_TD[15]);
	CancelSelectTextDraw(playerid);
	return 1;
}

forward SendAdminMessage(color, string[]);
public SendAdminMessage(color, string[])
{
	foreach(Player, i)
	{
	    if(IsPlayerAdmin(i))
	    {
	        SendClientMessage(i, color, string);
	    }
	}
}
