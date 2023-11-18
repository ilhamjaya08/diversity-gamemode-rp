/*
This file was generated by Nickk's TextDraw editor script
Nickk888 is the author of the NTD script
*/
#include <a_samp>
#include <progress2>

//Variables
new Text:PublicTD[2];
new PlayerBar:PlayerProgressBar[MAX_PLAYERS][1];
new Text:background_energy;

//Textdraws
public OnFilterScriptInit()
{
    background_energy = TextDrawCreate(497.000000, 407.000000, "I");
    TextDrawFont(background_energy, 1);
    TextDrawLetterSize(background_energy, 14.779210, 5.349985);
    TextDrawTextSize(background_energy, 400.000000, 17.000000);
    TextDrawSetOutline(background_energy, 0);
    TextDrawSetShadow(background_energy, 0);
    TextDrawAlignment(background_energy, 1);
    TextDrawColor(background_energy, 213);
    TextDrawBackgroundColor(background_energy, 255);
    TextDrawBoxColor(background_energy, 50);
    TextDrawUseBox(background_energy, 0);
    TextDrawSetProportional(background_energy, 1);
    TextDrawSetSelectable(background_energy, 0);

    PublicTD[0] = TextDrawCreate(530.000000, 416.000000, "Preview_Model");
    TextDrawFont(PublicTD[0], 5);
    TextDrawLetterSize(PublicTD[0], 0.600000, 2.000000);
    TextDrawTextSize(PublicTD[0], 72.000000, 33.000000);
    TextDrawSetOutline(PublicTD[0], 0);
    TextDrawSetShadow(PublicTD[0], 0);
    TextDrawAlignment(PublicTD[0], 1);
    TextDrawColor(PublicTD[0], -1);
    TextDrawBackgroundColor(PublicTD[0], 0);
    TextDrawBoxColor(PublicTD[0], 255);
    TextDrawUseBox(PublicTD[0], 0);
    TextDrawSetProportional(PublicTD[0], 1);
    TextDrawSetSelectable(PublicTD[0], 0);
    TextDrawSetPreviewModel(PublicTD[0], 0);
    TextDrawSetPreviewRot(PublicTD[0], -10.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetPreviewVehCol(PublicTD[0], 1, 1);

    PublicTD[1] = TextDrawCreate(588.000000, 425.000000, "ENERGY");
    TextDrawFont(PublicTD[1], 2);
    TextDrawLetterSize(PublicTD[1], 0.170833, 0.949999);
    TextDrawTextSize(PublicTD[1], 400.000000, 17.000000);
    TextDrawSetOutline(PublicTD[1], 0);
    TextDrawSetShadow(PublicTD[1], 0);
    TextDrawAlignment(PublicTD[1], 1);
    TextDrawColor(PublicTD[1], -80);
    TextDrawBackgroundColor(PublicTD[1], 255);
    TextDrawBoxColor(PublicTD[1], 50);
    TextDrawUseBox(PublicTD[1], 0);
    TextDrawSetProportional(PublicTD[1], 1);
    TextDrawSetSelectable(PublicTD[1], 0);
    return 1;
}


public OnPlayerConnect(playerid)
{
    PlayerProgressBar[playerid][0] = CreatePlayerProgressBar(playerid, 581.000000, 438.000000, 45.500000, 3.500000, 16711935, 100.000000, 0);
    SetPlayerProgressBarValue(playerid, PlayerProgressBar[playerid][0], 50.000000);

    TextDrawShowForPlayer(playerid, background_energy);
    TextDrawShowForPlayer(playerid, PublicTD[0]);
    TextDrawShowForPlayer(playerid, PublicTD[1]);

    ShowPlayerProgressBar(playerid, PlayerProgressBar[playerid][0]);
    return 1;
}

