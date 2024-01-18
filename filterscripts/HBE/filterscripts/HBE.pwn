#include <a_samp>
#include <streamer>
#include <progress>
#include <YSI/y_ini>
#include <zcmd>

#define DIALOG_BELI 1001

#define COLOR_GREY        (0x888888C8)
#define COLOR_LIGHTBLUE   (0x3AB3EDFF)

#define PATH "/savingHE/%s.ini"

enum pInfo
{
	Float:Hunger,
	Float:Energy,
	Float:Bladder,
}
new PlayerInfo[MAX_PLAYERS][pInfo];

/* TEXTDRAW & PROGRESS*/
new Text:BSText[10];
new Text:MenuMakanan[18];
new Bar:hungbar[MAX_PLAYERS] = INVALID_BAR_ID;
new Bar:nerbar[MAX_PLAYERS] = INVALID_BAR_ID;
new Bar:bladbar[MAX_PLAYERS] = INVALID_BAR_ID;

/*timer*/
new HungerTimer[MAX_PLAYERS];
new EnergyTimer[MAX_PLAYERS];
new BladderTimer[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" TERIMA JASA PEMBUATAN SCRIPT SAMP : brianrestup");
	print("--------------------------------------\n");

	CreateDynamicPickup(1274, 2, 1294.6138, -1877.9868, 14.3036, 0);
	CreateDynamic3DTextLabel("Kasir\n{FFFFFF}Pembelian Makanan\n{00FF00}ketikan /beli", COLOR_LIGHTBLUE, 1294.6138, -1877.9868, 14.3036, 5.0, .interiorid = 0, .worldid = 0);

	CreateDynamicPickup(1274, 2, 375.9172, -118.8171, 1001.4995, 0);
	CreateDynamic3DTextLabel("Kasir\n{FFFFFF}Pembelian Makanan\n{00FF00}ketikan /beli", COLOR_LIGHTBLUE, 375.9172, -118.8171, 1001.4995, 5.0, .interiorid = 5);

	BSText[0] = TextDrawCreate(66.000000, 253.000000, "_");
	TextDrawFont(BSText[0], 1);
	TextDrawLetterSize(BSText[0], 0.600000, 0.949998);
	TextDrawTextSize(BSText[0], 268.500000, 110.000000);
	TextDrawSetOutline(BSText[0], 1);
	TextDrawSetShadow(BSText[0], 0);
	TextDrawAlignment(BSText[0], 2);
	TextDrawColor(BSText[0], -1);
	TextDrawBackgroundColor(BSText[0], 255);
	TextDrawBoxColor(BSText[0], -16777081);
	TextDrawUseBox(BSText[0], 1);
	TextDrawSetProportional(BSText[0], 1);
	TextDrawSetSelectable(BSText[0], 0);

	BSText[1] = TextDrawCreate(66.000000, 267.000000, "_");
	TextDrawFont(BSText[1], 1);
	TextDrawLetterSize(BSText[1], 0.570833, 6.250002);
	TextDrawTextSize(BSText[1], 268.500000, 110.000000);
	TextDrawSetOutline(BSText[1], 1);
	TextDrawSetShadow(BSText[1], 0);
	TextDrawAlignment(BSText[1], 2);
	TextDrawColor(BSText[1], -1);
	TextDrawBackgroundColor(BSText[1], 255);
	TextDrawBoxColor(BSText[1], -1094795641);
	TextDrawUseBox(BSText[1], 1);
	TextDrawSetProportional(BSText[1], 1);
	TextDrawSetSelectable(BSText[1], 0);

	BSText[3] = TextDrawCreate(55.000000, 268.000000, "HUD:radar_pizza");
	TextDrawFont(BSText[3], 4);
	TextDrawLetterSize(BSText[3], 0.600000, 2.000000);
	TextDrawTextSize(BSText[3], 15.500000, 14.500000);
	TextDrawSetOutline(BSText[3], 0);
	TextDrawSetShadow(BSText[3], 0);
	TextDrawAlignment(BSText[3], 1);
	TextDrawColor(BSText[3], -1);
	TextDrawBackgroundColor(BSText[3], 255);
	TextDrawBoxColor(BSText[3], 50);
	TextDrawUseBox(BSText[3], 1);
	TextDrawSetProportional(BSText[3], 1);
	TextDrawSetSelectable(BSText[3], 0);

	BSText[4] = TextDrawCreate(55.000000, 287.000000, "HUD:radar_diner");
	TextDrawFont(BSText[4], 4);
	TextDrawLetterSize(BSText[4], 0.600000, 2.000000);
	TextDrawTextSize(BSText[4], 15.500000, 14.500000);
	TextDrawSetOutline(BSText[4], 0);
	TextDrawSetShadow(BSText[4], 0);
	TextDrawAlignment(BSText[4], 1);
	TextDrawColor(BSText[4], -1);
	TextDrawBackgroundColor(BSText[4], 255);
	TextDrawBoxColor(BSText[4], 50);
	TextDrawUseBox(BSText[4], 1);
	TextDrawSetProportional(BSText[4], 1);
	TextDrawSetSelectable(BSText[4], 0);

	BSText[5] = TextDrawCreate(55.000000, 305.000000, "HUD:radar_centre");
	TextDrawFont(BSText[5], 4);
	TextDrawLetterSize(BSText[5], 0.600000, 2.000000);
	TextDrawTextSize(BSText[5], 15.500000, 14.500000);
	TextDrawSetOutline(BSText[5], 0);
	TextDrawSetShadow(BSText[5], 0);
	TextDrawAlignment(BSText[5], 1);
	TextDrawColor(BSText[5], -1);
	TextDrawBackgroundColor(BSText[5], 255);
	TextDrawBoxColor(BSText[5], 50);
	TextDrawUseBox(BSText[5], 1);
	TextDrawSetProportional(BSText[5], 1);
	TextDrawSetSelectable(BSText[5], 0);
	
	MenuMakanan[0] = TextDrawCreate(317.000000, 147.000000, "_");
	TextDrawFont(MenuMakanan[0], 1);
	TextDrawLetterSize(MenuMakanan[0], 0.600000, 17.749998);
	TextDrawTextSize(MenuMakanan[0], 298.500000, 360.000000);
	TextDrawSetOutline(MenuMakanan[0], 1);
	TextDrawSetShadow(MenuMakanan[0], 0);
	TextDrawAlignment(MenuMakanan[0], 2);
	TextDrawColor(MenuMakanan[0], -1);
	TextDrawBackgroundColor(MenuMakanan[0], 255);
	TextDrawBoxColor(MenuMakanan[0], 135);
	TextDrawUseBox(MenuMakanan[0], 1);
	TextDrawSetProportional(MenuMakanan[0], 1);
	TextDrawSetSelectable(MenuMakanan[0], 0);

	MenuMakanan[1] = TextDrawCreate(148.000000, 156.000000, "Preview_Model");
	TextDrawFont(MenuMakanan[1], 5);
	TextDrawLetterSize(MenuMakanan[1], 0.600000, 2.000000);
	TextDrawTextSize(MenuMakanan[1], 101.000000, 86.500000);
	TextDrawSetOutline(MenuMakanan[1], 0);
	TextDrawSetShadow(MenuMakanan[1], 0);
	TextDrawAlignment(MenuMakanan[1], 1);
	TextDrawColor(MenuMakanan[1], -1);
	TextDrawBackgroundColor(MenuMakanan[1], 125);
	TextDrawBoxColor(MenuMakanan[1], 255);
	TextDrawUseBox(MenuMakanan[1], 0);
	TextDrawSetProportional(MenuMakanan[1], 1);
	TextDrawSetSelectable(MenuMakanan[1], 0);
	TextDrawSetPreviewModel(MenuMakanan[1], 19580);
	TextDrawSetPreviewRot(MenuMakanan[1], -28.000000, 0.000000, -24.000000, 0.779999);
	TextDrawSetPreviewVehCol(MenuMakanan[1], 1, 1);

	MenuMakanan[2] = TextDrawCreate(265.000000, 156.000000, "Preview_Model");
	TextDrawFont(MenuMakanan[2], 5);
	TextDrawLetterSize(MenuMakanan[2], 0.600000, 2.000000);
	TextDrawTextSize(MenuMakanan[2], 101.000000, 86.500000);
	TextDrawSetOutline(MenuMakanan[2], 0);
	TextDrawSetShadow(MenuMakanan[2], 0);
	TextDrawAlignment(MenuMakanan[2], 1);
	TextDrawColor(MenuMakanan[2], -1);
	TextDrawBackgroundColor(MenuMakanan[2], 125);
	TextDrawBoxColor(MenuMakanan[2], 255);
	TextDrawUseBox(MenuMakanan[2], 0);
	TextDrawSetProportional(MenuMakanan[2], 1);
	TextDrawSetSelectable(MenuMakanan[2], 0);
	TextDrawSetPreviewModel(MenuMakanan[2], 2768);
	TextDrawSetPreviewRot(MenuMakanan[2], -62.000000, 0.000000, 153.000000, 0.779999);
	TextDrawSetPreviewVehCol(MenuMakanan[2], 1, 1);

	MenuMakanan[3] = TextDrawCreate(385.000000, 156.000000, "Preview_Model");
	TextDrawFont(MenuMakanan[3], 5);
	TextDrawLetterSize(MenuMakanan[3], 0.600000, 2.000000);
	TextDrawTextSize(MenuMakanan[3], 101.000000, 86.500000);
	TextDrawSetOutline(MenuMakanan[3], 0);
	TextDrawSetShadow(MenuMakanan[3], 0);
	TextDrawAlignment(MenuMakanan[3], 1);
	TextDrawColor(MenuMakanan[3], -1);
	TextDrawBackgroundColor(MenuMakanan[3], 125);
	TextDrawBoxColor(MenuMakanan[3], 255);
	TextDrawUseBox(MenuMakanan[3], 0);
	TextDrawSetProportional(MenuMakanan[3], 1);
	TextDrawSetSelectable(MenuMakanan[3], 0);
	TextDrawSetPreviewModel(MenuMakanan[3], 19569);
	TextDrawSetPreviewRot(MenuMakanan[3], -28.000000, 0.000000, -24.000000, 1.069998);
	TextDrawSetPreviewVehCol(MenuMakanan[3], 1, 1);

	MenuMakanan[4] = TextDrawCreate(150.000000, 242.000000, "Mini Pizza");
	TextDrawFont(MenuMakanan[4], 1);
	TextDrawLetterSize(MenuMakanan[4], 0.329165, 1.299999);
	TextDrawTextSize(MenuMakanan[4], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[4], 1);
	TextDrawSetShadow(MenuMakanan[4], 0);
	TextDrawAlignment(MenuMakanan[4], 1);
	TextDrawColor(MenuMakanan[4], -1);
	TextDrawBackgroundColor(MenuMakanan[4], 255);
	TextDrawBoxColor(MenuMakanan[4], 50);
	TextDrawUseBox(MenuMakanan[4], 0);
	TextDrawSetProportional(MenuMakanan[4], 1);
	TextDrawSetSelectable(MenuMakanan[4], 0);

	MenuMakanan[5] = TextDrawCreate(150.000000, 254.000000, "- Harga : $15");
	TextDrawFont(MenuMakanan[5], 1);
	TextDrawLetterSize(MenuMakanan[5], 0.241667, 1.100000);
	TextDrawTextSize(MenuMakanan[5], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[5], 1);
	TextDrawSetShadow(MenuMakanan[5], 0);
	TextDrawAlignment(MenuMakanan[5], 1);
	TextDrawColor(MenuMakanan[5], -1);
	TextDrawBackgroundColor(MenuMakanan[5], 255);
	TextDrawBoxColor(MenuMakanan[5], 50);
	TextDrawUseBox(MenuMakanan[5], 0);
	TextDrawSetProportional(MenuMakanan[5], 1);
	TextDrawSetSelectable(MenuMakanan[5], 0);

	MenuMakanan[6] = TextDrawCreate(150.000000, 265.000000, "- Hunger : +45");
	TextDrawFont(MenuMakanan[6], 1);
	TextDrawLetterSize(MenuMakanan[6], 0.241667, 1.100000);
	TextDrawTextSize(MenuMakanan[6], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[6], 1);
	TextDrawSetShadow(MenuMakanan[6], 0);
	TextDrawAlignment(MenuMakanan[6], 1);
	TextDrawColor(MenuMakanan[6], -1);
	TextDrawBackgroundColor(MenuMakanan[6], 255);
	TextDrawBoxColor(MenuMakanan[6], 50);
	TextDrawUseBox(MenuMakanan[6], 0);
	TextDrawSetProportional(MenuMakanan[6], 1);
	TextDrawSetSelectable(MenuMakanan[6], 0);

	MenuMakanan[7] = TextDrawCreate(270.000000, 242.000000, "Fillet Burger");
	TextDrawFont(MenuMakanan[7], 1);
	TextDrawLetterSize(MenuMakanan[7], 0.329165, 1.299999);
	TextDrawTextSize(MenuMakanan[7], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[7], 1);
	TextDrawSetShadow(MenuMakanan[7], 0);
	TextDrawAlignment(MenuMakanan[7], 1);
	TextDrawColor(MenuMakanan[7], -1);
	TextDrawBackgroundColor(MenuMakanan[7], 255);
	TextDrawBoxColor(MenuMakanan[7], 50);
	TextDrawUseBox(MenuMakanan[7], 0);
	TextDrawSetProportional(MenuMakanan[7], 1);
	TextDrawSetSelectable(MenuMakanan[7], 0);

	MenuMakanan[8] = TextDrawCreate(271.000000, 254.000000, "- Harga : $25");
	TextDrawFont(MenuMakanan[8], 1);
	TextDrawLetterSize(MenuMakanan[8], 0.241667, 1.100000);
	TextDrawTextSize(MenuMakanan[8], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[8], 1);
	TextDrawSetShadow(MenuMakanan[8], 0);
	TextDrawAlignment(MenuMakanan[8], 1);
	TextDrawColor(MenuMakanan[8], -1);
	TextDrawBackgroundColor(MenuMakanan[8], 255);
	TextDrawBoxColor(MenuMakanan[8], 50);
	TextDrawUseBox(MenuMakanan[8], 0);
	TextDrawSetProportional(MenuMakanan[8], 1);
	TextDrawSetSelectable(MenuMakanan[8], 0);

	MenuMakanan[9] = TextDrawCreate(271.000000, 265.000000, "- Hunger : +90");
	TextDrawFont(MenuMakanan[9], 1);
	TextDrawLetterSize(MenuMakanan[9], 0.241667, 1.100000);
	TextDrawTextSize(MenuMakanan[9], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[9], 1);
	TextDrawSetShadow(MenuMakanan[9], 0);
	TextDrawAlignment(MenuMakanan[9], 1);
	TextDrawColor(MenuMakanan[9], -1);
	TextDrawBackgroundColor(MenuMakanan[9], 255);
	TextDrawBoxColor(MenuMakanan[9], 50);
	TextDrawUseBox(MenuMakanan[9], 0);
	TextDrawSetProportional(MenuMakanan[9], 1);
	TextDrawSetSelectable(MenuMakanan[9], 0);

	MenuMakanan[10] = TextDrawCreate(459.000000, 242.000000, "Fresh Milk");
	TextDrawFont(MenuMakanan[10], 1);
	TextDrawLetterSize(MenuMakanan[10], 0.329165, 1.299999);
	TextDrawTextSize(MenuMakanan[10], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[10], 1);
	TextDrawSetShadow(MenuMakanan[10], 0);
	TextDrawAlignment(MenuMakanan[10], 3);
	TextDrawColor(MenuMakanan[10], -1);
	TextDrawBackgroundColor(MenuMakanan[10], 255);
	TextDrawBoxColor(MenuMakanan[10], 50);
	TextDrawUseBox(MenuMakanan[10], 0);
	TextDrawSetProportional(MenuMakanan[10], 1);
	TextDrawSetSelectable(MenuMakanan[10], 0);

	MenuMakanan[11] = TextDrawCreate(444.000000, 254.000000, "- Harga : $5");
	TextDrawFont(MenuMakanan[11], 1);
	TextDrawLetterSize(MenuMakanan[11], 0.241667, 1.100000);
	TextDrawTextSize(MenuMakanan[11], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[11], 1);
	TextDrawSetShadow(MenuMakanan[11], 0);
	TextDrawAlignment(MenuMakanan[11], 3);
	TextDrawColor(MenuMakanan[11], -1);
	TextDrawBackgroundColor(MenuMakanan[11], 255);
	TextDrawBoxColor(MenuMakanan[11], 50);
	TextDrawUseBox(MenuMakanan[11], 0);
	TextDrawSetProportional(MenuMakanan[11], 1);
	TextDrawSetSelectable(MenuMakanan[11], 0);

	MenuMakanan[12] = TextDrawCreate(454.000000, 265.000000, "- Energy : +50");
	TextDrawFont(MenuMakanan[12], 1);
	TextDrawLetterSize(MenuMakanan[12], 0.241667, 1.100000);
	TextDrawTextSize(MenuMakanan[12], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[12], 1);
	TextDrawSetShadow(MenuMakanan[12], 0);
	TextDrawAlignment(MenuMakanan[12], 3);
	TextDrawColor(MenuMakanan[12], -1);
	TextDrawBackgroundColor(MenuMakanan[12], 255);
	TextDrawBoxColor(MenuMakanan[12], 50);
	TextDrawUseBox(MenuMakanan[12], 0);
	TextDrawSetProportional(MenuMakanan[12], 1);
	TextDrawSetSelectable(MenuMakanan[12], 0);

	MenuMakanan[13] = TextDrawCreate(457.000000, 276.000000, "- Bladder : -30");
	TextDrawFont(MenuMakanan[13], 1);
	TextDrawLetterSize(MenuMakanan[13], 0.241667, 1.100000);
	TextDrawTextSize(MenuMakanan[13], 400.000000, 17.000000);
	TextDrawSetOutline(MenuMakanan[13], 1);
	TextDrawSetShadow(MenuMakanan[13], 0);
	TextDrawAlignment(MenuMakanan[13], 3);
	TextDrawColor(MenuMakanan[13], -1);
	TextDrawBackgroundColor(MenuMakanan[13], 255);
	TextDrawBoxColor(MenuMakanan[13], 50);
	TextDrawUseBox(MenuMakanan[13], 0);
	TextDrawSetProportional(MenuMakanan[13], 1);
	TextDrawSetSelectable(MenuMakanan[13], 0);

	MenuMakanan[14] = TextDrawCreate(199.000000, 293.000000, "Beli");
	TextDrawFont(MenuMakanan[14], 1);
	TextDrawLetterSize(MenuMakanan[14], 0.600000, 1.000002);
	TextDrawTextSize(MenuMakanan[14], 298.500000, 75.000000);
	TextDrawSetOutline(MenuMakanan[14], 0);
	TextDrawSetShadow(MenuMakanan[14], 0);
	TextDrawAlignment(MenuMakanan[14], 2);
	TextDrawColor(MenuMakanan[14], -1);
	TextDrawBackgroundColor(MenuMakanan[14], -16776961);
	TextDrawBoxColor(MenuMakanan[14], -16777081);
	TextDrawUseBox(MenuMakanan[14], 1);
	TextDrawSetProportional(MenuMakanan[14], 1);
	TextDrawSetSelectable(MenuMakanan[14], 1);

	MenuMakanan[15] = TextDrawCreate(320.000000, 293.000000, "Beli");
	TextDrawFont(MenuMakanan[15], 1);
	TextDrawLetterSize(MenuMakanan[15], 0.600000, 1.000002);
	TextDrawTextSize(MenuMakanan[15], 298.500000, 75.000000);
	TextDrawSetOutline(MenuMakanan[15], 0);
	TextDrawSetShadow(MenuMakanan[15], 0);
	TextDrawAlignment(MenuMakanan[15], 2);
	TextDrawColor(MenuMakanan[15], -1);
	TextDrawBackgroundColor(MenuMakanan[15], -16776961);
	TextDrawBoxColor(MenuMakanan[15], -16777081);
	TextDrawUseBox(MenuMakanan[15], 1);
	TextDrawSetProportional(MenuMakanan[15], 1);
	TextDrawSetSelectable(MenuMakanan[15], 1);

	MenuMakanan[16] = TextDrawCreate(440.000000, 293.000000, "Beli");
	TextDrawFont(MenuMakanan[16], 1);
	TextDrawLetterSize(MenuMakanan[16], 0.600000, 1.000002);
	TextDrawTextSize(MenuMakanan[16], 298.500000, 75.000000);
	TextDrawSetOutline(MenuMakanan[16], 0);
	TextDrawSetShadow(MenuMakanan[16], 0);
	TextDrawAlignment(MenuMakanan[16], 2);
	TextDrawColor(MenuMakanan[16], -1);
	TextDrawBackgroundColor(MenuMakanan[16], -16776961);
	TextDrawBoxColor(MenuMakanan[16], -16777081);
	TextDrawUseBox(MenuMakanan[16], 1);
	TextDrawSetProportional(MenuMakanan[16], 1);
	TextDrawSetSelectable(MenuMakanan[16], 1);

	MenuMakanan[17] = TextDrawCreate(492.000000, 147.000000, "X");
	TextDrawFont(MenuMakanan[17], 1);
	TextDrawLetterSize(MenuMakanan[17], 0.600000, 0.500002);
	TextDrawTextSize(MenuMakanan[17], 230.500000, 11.500000);
	TextDrawSetOutline(MenuMakanan[17], 0);
	TextDrawSetShadow(MenuMakanan[17], 0);
	TextDrawAlignment(MenuMakanan[17], 2);
	TextDrawColor(MenuMakanan[17], -1);
	TextDrawBackgroundColor(MenuMakanan[17], -16776961);
	TextDrawBoxColor(MenuMakanan[17], -16777081);
	TextDrawUseBox(MenuMakanan[17], 1);
	TextDrawSetProportional(MenuMakanan[17], 1);
	TextDrawSetSelectable(MenuMakanan[17], 1);

	CreateDynamicObject(18980,1281.72802734,-1863.48999023,12.89700031,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (4)
	CreateDynamicObject(18980,1311.03503418,-1863.48999023,12.89700031,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (5)
	CreateDynamicObject(18980,1311.03405762,-1863.48901367,13.67199993,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (6)
	CreateDynamicObject(18980,1281.72802734,-1863.48901367,13.57199955,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (7)
	CreateDynamicObject(18980,1298.53417969,-1863.49804688,5.49700022,0.00000000,0.00000000,0.00000000); //object(concrete1mx1mx25m) (8)
	CreateDynamicObject(18980,1294.00781250,-1863.47656250,5.49700022,0.00000000,0.00000000,0.00000000); //object(concrete1mx1mx25m) (10)
	CreateDynamicObject(19325,1302.26599121,-1863.57800293,15.21000004,0.00000000,0.00000000,270.00000000); //object(lsmall_window01) (2)
	CreateDynamicObject(19325,1290.41601562,-1863.45117188,15.21000004,0.00000000,0.00000000,270.00000000); //object(lsmall_window01) (3)
	CreateDynamicObject(18014,1302.60705566,-1862.63305664,12.97900009,0.00000000,0.00000000,269.75000000); //object(int_rest_veg03) (1)
	CreateDynamicObject(18014,1300.45495605,-1862.61401367,12.97900009,0.00000000,0.00000000,269.74731445); //object(int_rest_veg03) (2)
	CreateDynamicObject(18014,1292.10400391,-1862.50500488,12.97900009,0.00000000,0.00000000,269.74731445); //object(int_rest_veg03) (3)
	CreateDynamicObject(18014,1289.27905273,-1862.45996094,12.97900009,0.00000000,0.00000000,269.74731445); //object(int_rest_veg03) (4)
	CreateDynamicObject(19448,1303.29785156,-1868.38867188,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (1)
	CreateDynamicObject(19448,1299.92297363,-1868.40197754,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (2)
	CreateDynamicObject(19448,1296.54895020,-1868.41394043,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (3)
	CreateDynamicObject(19448,1293.12304688,-1868.42700195,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (4)
	CreateDynamicObject(19448,1289.69628906,-1868.44042969,12.49699974,0.00000000,89.79156494,0.00000000); //object(wall088) (5)
	CreateDynamicObject(19448,1286.34594727,-1868.45397949,12.49699974,0.00000000,89.79675293,0.00000000); //object(wall088) (6)
	CreateDynamicObject(19448,1303.38195801,-1877.99096680,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (7)
	CreateDynamicObject(19448,1300.02099609,-1878.06396484,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (8)
	CreateDynamicObject(19448,1296.64404297,-1878.03796387,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (9)
	CreateDynamicObject(19448,1293.19104004,-1878.09704590,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (10)
	CreateDynamicObject(19448,1289.76403809,-1878.10705566,12.49699974,0.00000000,89.79632568,0.00000000); //object(wall088) (11)
	CreateDynamicObject(19448,1286.31201172,-1878.11694336,12.49699974,0.00000000,89.79675293,0.00000000); //object(wall088) (12)
	CreateDynamicObject(9339,1304.96093750,-1877.10253906,13.28800011,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (1)
	CreateDynamicObject(9339,1304.93994141,-1876.64099121,16.08799934,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (3)
	CreateDynamicObject(9339,1311.09399414,-1863.89501953,13.28800011,0.00000000,0.00000000,90.00000000); //object(sfnvilla001_cm) (6)
	CreateDynamicObject(9339,1281.46801758,-1863.88500977,13.28800011,0.00000000,0.00000000,90.00000000); //object(sfnvilla001_cm) (7)
	CreateDynamicObject(9339,1295.04589844,-1880.66894531,13.23799992,0.00000000,0.00000000,90.24719238); //object(sfnvilla001_cm) (13)
	CreateDynamicObject(9339,1295.04602051,-1880.66894531,16.08799934,0.00000000,0.00000000,90.24719238); //object(sfnvilla001_cm) (14)
	CreateDynamicObject(19445,1300.18005371,-1880.61999512,15.67899990,0.00000000,0.00000000,270.25003052); //object(wall085) (1)
	CreateDynamicObject(19445,1291.19995117,-1880.64001465,15.67899990,0.00000000,0.00000000,270.24719238); //object(wall085) (2)
	CreateDynamicObject(9339,1287.37304688,-1876.50305176,16.08799934,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (16)
	CreateDynamicObject(19446,1287.37097168,-1868.25000000,14.33899975,0.00000000,0.00000000,0.00000000); //object(wall086) (2)
	CreateDynamicObject(19445,1304.92004395,-1875.97497559,15.67899990,0.00000000,0.00000000,359.99719238); //object(wall085) (3)
	CreateDynamicObject(19445,1304.97705078,-1868.42297363,15.67899990,0.00000000,0.00000000,359.99450684); //object(wall085) (4)
	CreateDynamicObject(9339,1287.37304688,-1876.50292969,13.23799992,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (17)
	CreateDynamicObject(19445,1287.37402344,-1875.90039062,15.67899990,0.00000000,0.00000000,359.98901367); //object(wall085) (5)
	CreateDynamicObject(19445,1287.42297363,-1868.30102539,15.67899990,0.00000000,0.00000000,359.99450684); //object(wall085) (6)
	CreateDynamicObject(1545,1296.08203125,-1879.83801270,13.92000008,0.00000000,0.00000000,179.25000000); //object(cj_b_optic1) (1)
	CreateDynamicObject(16152,1303.48706055,-1876.80200195,13.23499966,0.00000000,0.00000000,178.24768066); //object(ufo_booths) (4)
	CreateDynamicObject(16152,1288.60998535,-1869.85095215,13.31000042,0.00000000,0.00000000,0.24719238); //object(ufo_booths) (6)
	CreateDynamicObject(1432,1293.23706055,-1873.90002441,12.58699989,0.00000000,0.00000000,0.00000000); //object(dyn_table_2) (1)
	CreateDynamicObject(1432,1293.23632812,-1873.89941406,12.58699989,0.00000000,0.00000000,305.75000000); //object(dyn_table_2) (2)
	CreateDynamicObject(1432,1299.03002930,-1873.65600586,12.58699989,0.00000000,0.00000000,305.74951172); //object(dyn_table_2) (3)
	CreateDynamicObject(1432,1296.11999512,-1871.64501953,12.58699989,0.00000000,0.00000000,305.74951172); //object(dyn_table_2) (4)
	CreateDynamicObject(1432,1298.93798828,-1869.43896484,12.58699989,0.00000000,0.00000000,305.74951172); //object(dyn_table_2) (5)
	CreateDynamicObject(1432,1293.05395508,-1868.82299805,12.58699989,0.00000000,0.00000000,305.74951172); //object(dyn_table_2) (6)
	CreateDynamicObject(1665,1293.37695312,-1873.79394531,13.21300030,0.00000000,0.00000000,0.00000000); //object(propashtray1) (1)
	CreateDynamicObject(1665,1296.07604980,-1871.71105957,13.21300030,0.00000000,0.00000000,0.00000000); //object(propashtray1) (2)
	CreateDynamicObject(1665,1298.96594238,-1873.59204102,13.21300030,0.00000000,0.00000000,0.00000000); //object(propashtray1) (3)
	CreateDynamicObject(1665,1298.98999023,-1869.46203613,13.21300030,0.00000000,0.00000000,0.00000000); //object(propashtray1) (4)
	CreateDynamicObject(1665,1293.08801270,-1868.76501465,13.21300030,0.00000000,0.00000000,0.00000000); //object(propashtray1) (5)
	CreateDynamicObject(1551,1293.25805664,-1874.38500977,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (1)
	CreateDynamicObject(1551,1292.84399414,-1874.04797363,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (2)
	CreateDynamicObject(1551,1293.58703613,-1873.88000488,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (3)
	CreateDynamicObject(1551,1298.66796875,-1873.41796875,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (4)
	CreateDynamicObject(1551,1298.97900391,-1873.91003418,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (5)
	CreateDynamicObject(1551,1295.74804688,-1871.67797852,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (6)
	CreateDynamicObject(1551,1296.31994629,-1871.41101074,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (7)
	CreateDynamicObject(1551,1296.11804199,-1871.92199707,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (8)
	CreateDynamicObject(1551,1298.58496094,-1869.67199707,13.44299984,0.00000000,0.00000000,0.00000000); //object(dyn_wine_big) (9)
	CreateDynamicObject(19454,1303.23303223,-1868.23400879,16.13299942,0.00000000,89.80020142,0.00000000); //object(wall094) (1)
	CreateDynamicObject(18980,1311.03198242,-1863.48706055,16.52199936,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (14)
	CreateDynamicObject(19454,1299.78295898,-1868.21496582,16.13299942,0.00000000,89.79632568,0.00000000); //object(wall094) (2)
	CreateDynamicObject(19454,1296.38305664,-1868.24096680,16.20800018,0.00000000,89.79632568,0.00000000); //object(wall094) (3)
	CreateDynamicObject(19454,1292.93261719,-1868.26660156,16.13299942,0.00000000,89.79125977,0.00000000); //object(wall094) (4)
	CreateDynamicObject(19454,1289.43261719,-1868.29199219,16.13299942,0.00000000,89.79156494,0.00000000); //object(wall094) (5)
	CreateDynamicObject(19454,1285.95703125,-1868.31604004,16.13299942,0.00000000,89.79675293,0.00000000); //object(wall094) (6)
	CreateDynamicObject(18980,1303.18200684,-1863.57702637,16.67200089,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (15)
	CreateDynamicObject(18980,1281.99304199,-1863.48706055,16.72200012,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (16)
	CreateDynamicObject(19454,1294.15698242,-1877.94104004,16.13299942,0.00000000,89.79125977,0.00000000); //object(wall094) (7)
	CreateDynamicObject(19454,1300.25805664,-1878.01501465,16.13299942,0.00000000,89.79632568,0.00000000); //object(wall094) (8)
	CreateDynamicObject(19454,1295.97802734,-1877.86401367,16.13299942,0.00000000,89.79632568,0.00000000); //object(wall094) (9)
	CreateDynamicObject(19454,1300.76599121,-1874.74096680,16.15800095,0.00000000,89.79632568,270.00000000); //object(wall094) (10)
	CreateDynamicObject(19454,1306.02404785,-1877.79504395,16.13299942,0.00000000,89.79675293,0.00000000); //object(wall094) (12)
	CreateDynamicObject(18980,1306.93994141,-1863.52795410,16.47200012,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (18)
	CreateDynamicObject(18980,1298.68164062,-1863.48730469,16.47200012,0.00000000,90.00000000,0.00000000); //object(concrete1mx1mx25m) (19)
	CreateDynamicObject(19454,1303.64904785,-1877.64294434,16.13299942,0.00000000,89.79632568,0.00000000); //object(wall094) (13)
	CreateDynamicObject(19454,1298.12902832,-1877.82202148,16.13299942,0.00000000,89.79632568,0.00000000); //object(wall094) (15)
	CreateDynamicObject(16152,1303.76098633,-1867.51196289,13.21000004,0.00000000,0.00000000,178.24768066); //object(ufo_booths) (8)
	CreateDynamicObject(19448,1303.29785156,-1868.38867188,13.17199993,0.00000000,89.79156494,0.00000000); //object(wall088) (1)
	CreateDynamicObject(9339,1301.57897949,-1876.75695801,12.56299973,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (1)
	CreateDynamicObject(19448,1303.29199219,-1877.79199219,13.17199993,0.00000000,89.79156494,0.00000000); //object(wall088) (1)
	CreateDynamicObject(9339,1301.30297852,-1876.75402832,12.33800030,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (1)
	CreateDynamicObject(9339,1301.00292969,-1876.75390625,12.21300030,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (1)
	CreateDynamicObject(19448,1297.44299316,-1879.18896484,13.22200012,0.00000000,89.79156494,270.00000000); //object(wall088) (1)
	CreateDynamicObject(9339,1295.16394043,-1877.34802246,12.53800011,0.00000000,0.00000000,89.99719238); //object(sfnvilla001_cm) (13)
	CreateDynamicObject(9339,1295.15795898,-1877.07202148,12.31299973,0.00000000,0.00000000,89.99450684); //object(sfnvilla001_cm) (13)
	CreateDynamicObject(9339,1295.15197754,-1876.82104492,12.18799973,0.00000000,0.00000000,89.99450684); //object(sfnvilla001_cm) (13)
	CreateDynamicObject(19448,1290.33203125,-1879.18298340,13.17199993,0.00000000,89.78576660,270.00000000); //object(wall088) (1)
	CreateDynamicObject(19448,1288.97497559,-1868.24597168,13.17199993,0.00000000,89.79156494,0.00000000); //object(wall088) (1)
	CreateDynamicObject(9339,1290.59301758,-1876.68896484,12.53800011,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (17)
	CreateDynamicObject(9339,1290.84301758,-1876.70104980,12.31299973,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (17)
	CreateDynamicObject(9339,1291.11804199,-1876.71398926,12.18799973,0.00000000,0.00000000,0.00000000); //object(sfnvilla001_cm) (17)
	CreateDynamicObject(19448,1288.87500000,-1872.54504395,13.17199993,0.00000000,89.79125977,0.00000000); //object(wall088) (1)
	CreateDynamicObject(16151,1295.33203125,-1879.65502930,13.56200027,0.00000000,0.00000000,270.00000000); //object(ufo_bar) (1)
	CreateDynamicObject(19454,1289.34704590,-1875.61999512,16.13299942,0.00000000,89.79156494,0.00000000); //object(wall094) (5)
	CreateDynamicObject(19454,1291.52502441,-1875.81103516,16.13299942,0.00000000,89.79125977,0.00000000); //object(wall094) (5)
	CreateDynamicObject(1502,1294.78405762,-1863.37597656,12.24699974,0.00000000,0.00000000,0.00000000); //object(gen_doorint04) (1)
	CreateDynamicObject(1502,1297.81201172,-1863.32495117,12.24699974,0.00000000,0.00000000,180.00000000); //object(gen_doorint04) (2)
	CreateDynamicObject(18980,1294.35803223,-1863.48999023,5.49700022,0.00000000,0.00000000,0.00000000); //object(concrete1mx1mx25m) (10)
	CreateDynamicObject(18980,1298.20898438,-1863.49304199,5.49700022,0.00000000,0.00000000,0.00000000); //object(concrete1mx1mx25m) (8)
	CreateDynamicObject(1649,1296.09594727,-1863.46105957,16.33799934,0.00000000,0.00000000,180.00000000); //object(wglasssmash) (1)
	CreateDynamicObject(1649,1296.09570312,-1863.46093750,16.33799934,0.00000000,0.00000000,0.00000000); //object(wglasssmash) (2)

	return 1;
}

public OnFilterScriptExit()
{
    TextDrawDestroy(MenuMakanan[0]);
    TextDrawDestroy(MenuMakanan[1]);
    TextDrawDestroy(MenuMakanan[2]);
    TextDrawDestroy(MenuMakanan[3]);
    TextDrawDestroy(MenuMakanan[4]);
    TextDrawDestroy(MenuMakanan[5]);
    TextDrawDestroy(MenuMakanan[6]);
    TextDrawDestroy(MenuMakanan[7]);
    TextDrawDestroy(MenuMakanan[8]);
    TextDrawDestroy(MenuMakanan[9]);
    TextDrawDestroy(MenuMakanan[10]);
    TextDrawDestroy(MenuMakanan[11]);
    TextDrawDestroy(MenuMakanan[12]);
    TextDrawDestroy(MenuMakanan[13]);
    TextDrawDestroy(MenuMakanan[14]);
    TextDrawDestroy(MenuMakanan[15]);
    TextDrawDestroy(MenuMakanan[16]);
    TextDrawDestroy(MenuMakanan[17]);
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(fexist(UserPath(playerid)))
	{
		INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
	}
	else
	{
	    new INI:File = INI_Open(UserPath(playerid));
		INI_SetTag(File,"data");
		INI_WriteFloat(File, "Hunger", 0);
		INI_WriteFloat(File, "Energy", 0);
		INI_WriteFloat(File, "Bladder", 0);
	    PlayerInfo[playerid][Hunger] = 100.0;
		PlayerInfo[playerid][Energy] = 100.0;
		PlayerInfo[playerid][Bladder] = 100.0;
	}
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	
	BSText[6] = TextDrawCreate(16.000000, 249.000000, "Firstname_Lastname");
	TextDrawFont(BSText[6], 1);
	TextDrawLetterSize(BSText[6], 0.291666, 1.550000);
	TextDrawTextSize(BSText[6], 400.000000, 17.000000);
	TextDrawSetOutline(BSText[6], 1);
	TextDrawSetShadow(BSText[6], 0);
	TextDrawAlignment(BSText[6], 1);
	TextDrawColor(BSText[6], -1);
	TextDrawBackgroundColor(BSText[6], 255);
	TextDrawBoxColor(BSText[6], 50);
	TextDrawUseBox(BSText[6], 0);
	TextDrawSetProportional(BSText[6], 1);
	TextDrawSetSelectable(BSText[6], 0);
	TextDrawSetString(BSText[6], PlayerName);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    PlayerInfo[playerid][Hunger] = GetProgressBarValue(hungbar[playerid]);
	PlayerInfo[playerid][Energy] = GetProgressBarValue(nerbar[playerid]);
	PlayerInfo[playerid][Bladder] = GetProgressBarValue(bladbar[playerid]);
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteFloat(File, "Hunger", PlayerInfo[playerid][Hunger]);
	INI_WriteFloat(File, "Energy", PlayerInfo[playerid][Energy]);
	INI_WriteFloat(File, "Bladder", PlayerInfo[playerid][Bladder]);
	INI_Close(File);

    DestroyProgressBar(hungbar[playerid]);
    DestroyProgressBar(nerbar[playerid]);
    DestroyProgressBar(bladbar[playerid]);

    TextDrawHideForPlayer(playerid, BSText[0]);
	TextDrawHideForPlayer(playerid, BSText[1]);
	TextDrawHideForPlayer(playerid, BSText[2]);
	TextDrawHideForPlayer(playerid, BSText[3]);
	TextDrawHideForPlayer(playerid, BSText[4]);
	TextDrawHideForPlayer(playerid, BSText[5]);
	TextDrawHideForPlayer(playerid, BSText[6]);

	KillTimer(HungerTimer[playerid]);
	KillTimer(EnergyTimer[playerid]);
	KillTimer(BladderTimer[playerid]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	new skinid;
	skinid = GetPlayerSkin(playerid);
	
    BSText[2] = TextDrawCreate(8.000000, 263.000000, "Preview_Model");
	TextDrawFont(BSText[2], 5);
	TextDrawLetterSize(BSText[2], 0.600000, 2.000000);
	TextDrawTextSize(BSText[2], 43.500000, 63.000000);
	TextDrawSetOutline(BSText[2], 0);
	TextDrawSetShadow(BSText[2], 0);
	TextDrawAlignment(BSText[2], 1);
	TextDrawColor(BSText[2], -1);
	TextDrawBackgroundColor(BSText[2], -1094795651);
	TextDrawBoxColor(BSText[2], -1094795521);
	TextDrawUseBox(BSText[2], 0);
	TextDrawSetProportional(BSText[2], 1);
	TextDrawSetSelectable(BSText[2], 0);
	TextDrawSetPreviewModel(BSText[2], skinid);
	TextDrawSetPreviewRot(BSText[2], -10.000000, 0.000000, -20.000000, 1.000000);
	TextDrawSetPreviewVehCol(BSText[2], 1, 1);
	
    TextDrawShowForPlayer(playerid, BSText[0]);
	TextDrawShowForPlayer(playerid, BSText[1]);
	TextDrawShowForPlayer(playerid, BSText[2]);
	TextDrawShowForPlayer(playerid, BSText[3]);
	TextDrawShowForPlayer(playerid, BSText[4]);
	TextDrawShowForPlayer(playerid, BSText[5]);
	TextDrawShowForPlayer(playerid, BSText[6]);

    hungbar[playerid] = CreateProgressBar(76.000000, 273.000000, 45.500000, 4.000000, 16711935, 100.0);
	ShowProgressBarForPlayer(playerid, hungbar[playerid]);
	SetProgressBarValue(hungbar[playerid], PlayerInfo[playerid][Hunger]);

	nerbar[playerid] = CreateProgressBar(76.000000, 292.000000, 45.500000, 4.000000, 16711935, 100.0);
	ShowProgressBarForPlayer(playerid, nerbar[playerid]);
	SetProgressBarValue(nerbar[playerid], PlayerInfo[playerid][Energy]);

	bladbar[playerid] = CreateProgressBar(76.000000, 311.000000, 45.500000, 4.000000, 16711935, 100.0);
	ShowProgressBarForPlayer(playerid, bladbar[playerid]);
	SetProgressBarValue(bladbar[playerid], PlayerInfo[playerid][Bladder]);

	UpdateProgressBar(hungbar[playerid], playerid);
	UpdateProgressBar(nerbar[playerid], playerid);
	UpdateProgressBar(bladbar[playerid], playerid);

	HungerTimer[playerid] = SetTimerEx("HungerTime", 420000, true, "i", playerid);
	EnergyTimer[playerid] = SetTimerEx("EnergyTime", 300000, true, "i", playerid);
	BladderTimer[playerid] = SetTimerEx("BladderTime", 300000, true, "i", playerid);
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
	return 1;
}

CMD:beli(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 10, 1294.6138, -1877.9868, 14.3036)) return 0;
    TextDrawShowForPlayer(playerid, MenuMakanan[0]);
	TextDrawShowForPlayer(playerid, MenuMakanan[1]);
	TextDrawShowForPlayer(playerid, MenuMakanan[2]);
	TextDrawShowForPlayer(playerid, MenuMakanan[3]);
	TextDrawShowForPlayer(playerid, MenuMakanan[4]);
	TextDrawShowForPlayer(playerid, MenuMakanan[5]);
	TextDrawShowForPlayer(playerid, MenuMakanan[6]);
	TextDrawShowForPlayer(playerid, MenuMakanan[7]);
	TextDrawShowForPlayer(playerid, MenuMakanan[8]);
	TextDrawShowForPlayer(playerid, MenuMakanan[9]);
	TextDrawShowForPlayer(playerid, MenuMakanan[10]);
	TextDrawShowForPlayer(playerid, MenuMakanan[11]);
	TextDrawShowForPlayer(playerid, MenuMakanan[12]);
	TextDrawShowForPlayer(playerid, MenuMakanan[13]);
	TextDrawShowForPlayer(playerid, MenuMakanan[14]);
	TextDrawShowForPlayer(playerid, MenuMakanan[15]);
	TextDrawShowForPlayer(playerid, MenuMakanan[16]);
	TextDrawShowForPlayer(playerid, MenuMakanan[17]);
	SelectTextDraw(playerid, 0xFF0000FF);
	return 1;
}

CMD:piss(playerid, params[])
{
	ApplyAnimation(playerid, "PAULNMAC","Piss_loop",3.0,1,1,0,0,0);
	SetPlayerAttachedObject(playerid, 0, 18676, 1, -1.900000, 0.300000, 0.000000, 148.199584, 90.099914, -55.199981, 1.000000, -9.899993, 1.000000);
	SetTimerEx("TimePiss", 30000, false, "i", playerid);
	return 1;
}

CMD:tele(playerid, params[])
{
	SetPlayerPos(playerid, 1296.3524,-1857.7312,13.5469);
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
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == MenuMakanan[14])
	{
	    new money;
     	money = GetPlayerMoney(playerid);
     	if(money < 5) return SendClientMessage(playerid, COLOR_GREY, "[RESTO]{FFFFFF}: Uang kamu tidak cukup");
     	SetProgressBarValue(hungbar[playerid], GetProgressBarValue(hungbar[playerid])+45);
     	UpdateProgressBar(hungbar[playerid], playerid);
     	GivePlayerMoney(playerid, -15);
	}
	if(clickedid == MenuMakanan[15])
	{
	    new money;
     	money = GetPlayerMoney(playerid);
     	if(money < 5) return SendClientMessage(playerid, COLOR_GREY, "[RESTO]{FFFFFF}: Uang kamu tidak cukup");
     	SetProgressBarValue(hungbar[playerid], GetProgressBarValue(hungbar[playerid])+90);
     	UpdateProgressBar(hungbar[playerid], playerid);
     	GivePlayerMoney(playerid, -25);
	}
	if(clickedid == MenuMakanan[16])
	{
	    new money;
     	money = GetPlayerMoney(playerid);
     	if(money < 5) return SendClientMessage(playerid, COLOR_GREY, "[RESTO]{FFFFFF}: Uang kamu tidak cukup");
     	SetProgressBarValue(nerbar[playerid], GetProgressBarValue(nerbar[playerid])+50);
     	UpdateProgressBar(nerbar[playerid], playerid);
     	SetProgressBarValue(bladbar[playerid], GetProgressBarValue(bladbar[playerid])-30);
		UpdateProgressBar(bladbar[playerid], playerid);
 		GivePlayerMoney(playerid, -5);
	}
	if(clickedid == MenuMakanan[17])
	{
        TextDrawHideForPlayer(playerid, MenuMakanan[0]);
		TextDrawHideForPlayer(playerid, MenuMakanan[1]);
		TextDrawHideForPlayer(playerid, MenuMakanan[2]);
		TextDrawHideForPlayer(playerid, MenuMakanan[3]);
		TextDrawHideForPlayer(playerid, MenuMakanan[4]);
		TextDrawHideForPlayer(playerid, MenuMakanan[5]);
		TextDrawHideForPlayer(playerid, MenuMakanan[6]);
		TextDrawHideForPlayer(playerid, MenuMakanan[7]);
		TextDrawHideForPlayer(playerid, MenuMakanan[8]);
		TextDrawHideForPlayer(playerid, MenuMakanan[9]);
		TextDrawHideForPlayer(playerid, MenuMakanan[10]);
		TextDrawHideForPlayer(playerid, MenuMakanan[11]);
		TextDrawHideForPlayer(playerid, MenuMakanan[12]);
		TextDrawHideForPlayer(playerid, MenuMakanan[13]);
		TextDrawHideForPlayer(playerid, MenuMakanan[14]);
		TextDrawHideForPlayer(playerid, MenuMakanan[15]);
		TextDrawHideForPlayer(playerid, MenuMakanan[16]);
		TextDrawHideForPlayer(playerid, MenuMakanan[17]);
		CancelSelectTextDraw(playerid);
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

stock UserPath(playerid)
{
	new string[128], playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	format(string, sizeof(string), PATH, playername);
	return string;
}

forward SaveStats(playerid);
public SaveStats(playerid)
{
    PlayerInfo[playerid][Hunger] = GetProgressBarValue(hungbar[playerid]);
	PlayerInfo[playerid][Energy] = GetProgressBarValue(nerbar[playerid]);
	PlayerInfo[playerid][Bladder] = GetProgressBarValue(bladbar[playerid]);
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteFloat(File, "Hunger", PlayerInfo[playerid][Hunger]);
	INI_WriteFloat(File, "Energy", PlayerInfo[playerid][Energy]);
	INI_WriteFloat(File, "Bladder", PlayerInfo[playerid][Bladder]);
	INI_Close(File);
	return 1;
}

forward LoadUser_data(playerid, name[], value[]);
public LoadUser_data(playerid, name[], value[])
{
	INI_Float("Hunger", PlayerInfo[playerid][Hunger]);
	INI_Float("Energy", PlayerInfo[playerid][Energy]);
	INI_Float("Bladder", PlayerInfo[playerid][Bladder]);
	return 1;
}

forward HungerTime(playerid);
public HungerTime(playerid)
{
	if(GetProgressBarValue(hungbar[playerid]) < 0)
	{
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "[LAPAR]{FFFFFF}: Kamu mulai lapar, heal kamu -5");
	    SetPlayerHealth(playerid, -5);
	}
	else
	{
	   	SetProgressBarValue(hungbar[playerid], GetProgressBarValue(hungbar[playerid])-2);
	   	UpdateProgressBar(hungbar[playerid], playerid);
	}
	return 1;
}

forward EnergyTime(playerid);
public EnergyTime(playerid)
{
	SetProgressBarValue(nerbar[playerid], GetProgressBarValue(nerbar[playerid])-2);
	UpdateProgressBar(nerbar[playerid], playerid);
	return 1;
}

forward BladderTime(playerid);
public BladderTime(playerid)
{
    SetProgressBarValue(bladbar[playerid], GetProgressBarValue(bladbar[playerid])-1);
	UpdateProgressBar(bladbar[playerid], playerid);
	return 1;
}

forward TimePiss(playerid);
public TimePiss(playerid)
{
    SetProgressBarValue(bladbar[playerid], 100);
	UpdateProgressBar(bladbar[playerid], playerid);
	RemovePlayerAttachedObject(playerid,0);
	ClearAnimations(playerid);
	return 1;
}

stock PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid, animlib,"null",0.0,0,0,0,0,0);
	return 1;
}
