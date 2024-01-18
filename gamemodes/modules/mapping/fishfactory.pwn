/*	
	Script name 		: fishfactory.pwn
	Date of creations	: 31 May 2018 - 15:09
	Last Edited 	 	: 31 May 2018 - 16:14
	Mapping by 			: Agus Syahputra.
	Release by 			: Agus Syahputra.

	NOTE:
	- 	Point (1353.6514,1326.0586,10.8862,260.6331)
	-	Tempat pembelian alat pancing dan penjualan ikan

*/

#include <YSI\y_hooks>

#define 	FISHFAC_INTERIOR_MAP		6

hook OnGameModeInit()
{
	new fishfactory;

	CreateDynamicPickup(1239, 23, 1359.2423,1340.3364,10.8862, -1, FISHFAC_INTERIOR_MAP);
    CreateDynamic3DTextLabel("[Buy Point]\n"WHITE"Type "YELLOW"/buybait "WHITE"and "YELLOW"/buyrod"WHITE" here", COLOR_CLIENT, 1359.2423,1340.3364,11.3862, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, FISHFAC_INTERIOR_MAP);

    CreateDynamicPickup(1239, 23, 1357.1354,1340.3186,10.8862, -1, FISHFAC_INTERIOR_MAP);
    CreateDynamic3DTextLabel("[Sell Point]\n"WHITE"Type "YELLOW"/sellfish "WHITE"to sell all fish", COLOR_CLIENT, 1357.1354,1340.3186,11.3862, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, FISHFAC_INTERIOR_MAP);
 
	fishfactory = CreateDynamicObject(2241, 1353.165039, 1327.275634, 10.356256, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 2, 4830, "airport2", "kbplanter_plants1", 0x00000000);
	fishfactory = CreateDynamicObject(2641, 1353.879394, 1332.470092, 12.276256, 0.000000, 270.000000, 360.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 1, 14570, "traidaqua", "ab_aqua_starfish", 0x00000000);
	fishfactory = CreateDynamicObject(2241, 1353.136108, 1324.786254, 10.356256, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 2, 4830, "airport2", "kbplanter_plants1", 0x00000000);
	fishfactory = CreateDynamicObject(2641, 1353.879394, 1332.500244, 12.276256, 0.000000, 270.000000, 360.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 1, 18901, "matclothes", "bandanazigzag", 0x00000000);
	fishfactory = CreateDynamicObject(9527, 1359.104492, 1344.148315, 12.536252, 0.000000, 0.000000, 360.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterialText(fishfactory, 0, "Fish Factory", 130, "Ariel", 70, 0, 0xFFFFFFFF, 0xFF000000, 1);
	fishfactory = CreateDynamicObject(19922, 1352.022216, 1335.350708, 12.176268, 90.000000, 360.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 0, 18835, "mickytextures", "whiteforletters", 0xFFFFFFFF);
	SetDynamicObjectMaterial(fishfactory, 2, 18835, "mickytextures", "whiteforletters", 0x00000000);
	fishfactory = CreateDynamicObject(19922, 1352.022216, 1340.431640, 12.176268, 90.000000, 360.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 0, 18835, "mickytextures", "whiteforletters", 0xFFFFFFFF);
	fishfactory = CreateDynamicObject(19377, 1357.577392, 1339.989379, 13.320299, 0.000000, 90.000000, 270.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	SetDynamicObjectMaterial(fishfactory, 1, 19853, "mihouse1", "bluewall1_64", 0x00000000);
	fishfactory = CreateDynamicObject(19377, 1357.577392, 1329.499023, 13.320299, 0.000000, 90.000000, 270.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 0, 18835, "mickytextures", "whiteforletters", 0x00000000);
	fishfactory = CreateDynamicObject(2641, 1362.238159, 1327.275268, 12.276256, 0.000007, 270.000000, -90.000022, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 0, 1599, "fish1", "fish2", 0x00000000);
	SetDynamicObjectMaterial(fishfactory, 1, 1599, "fish1", "fish2", 0x00000000);
	SetDynamicObjectMaterial(fishfactory, 2, 1599, "fish1", "fish2", 0x00000000);
	fishfactory = CreateDynamicObject(2641, 1362.268310, 1327.275268, 12.276256, 0.000007, 270.000000, -90.000022, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 0, 4020, "fighot", "sl_lavicdtcnr", 0x00000000);
	SetDynamicObjectMaterial(fishfactory, 1, 8498, "excalibur", "excaliburwall03_128", 0x00000000);
	fishfactory = CreateDynamicObject(2641, 1362.238159, 1333.036743, 12.276256, 0.000000, 270.000000, -90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 1, 1600, "fish2", "fish3", 0x00000000);
	fishfactory = CreateDynamicObject(2641, 1362.268310, 1333.036743, 12.276256, 0.000000, 270.000000, -90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 1, 8498, "excalibur", "excaliburwall03_128", 0x00000000);
	fishfactory = CreateDynamicObject(2641, 1362.238159, 1339.277343, 12.276256, -0.000007, 270.000000, -89.999977, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 1, 1601, "fish3", "fish1", 0x00000000);
	fishfactory = CreateDynamicObject(2641, 1362.268310, 1339.277343, 12.276256, -0.000007, 270.000000, -89.999977, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	SetDynamicObjectMaterial(fishfactory, 1, 8498, "excalibur", "excaliburwall03_128", 0x00000000);
	
	CreateDynamicObject(19445, 1352.709350, 1329.031738, 11.562982, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(19445, 1352.709350, 1338.661254, 11.562982, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(19445, 1357.579467, 1343.452514, 11.562982, 0.000000, 0.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(19445, 1362.429199, 1338.661254, 11.562982, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(19445, 1362.429199, 1329.021484, 11.562982, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(19445, 1357.587280, 1324.191894, 11.562982, 0.000000, 0.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(19379, 1357.577392, 1329.519897, 9.800312, 0.000000, 90.000000, 270.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(19379, 1357.577392, 1339.989379, 9.800312, 0.000000, 90.000000, 270.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(1533, 1352.828125, 1325.231079, 9.886249, 0.000000, 0.000000, 450.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(3850, 1354.807495, 1326.019653, 10.396255, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(3850, 1354.807495, 1329.450683, 10.396255, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(19353, 1353.285034, 1332.625854, 11.576251, 0.000000, 0.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2714, 1352.816772, 1326.029541, 12.796260, 0.000000, 0.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(3041, 1358.009399, 1328.110839, 9.886249, 0.000000, 0.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(3041, 1359.600830, 1331.913452, 9.886249, 0.000000, 0.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(3041, 1358.009399, 1331.881347, 9.886249, 0.000000, 0.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(3041, 1359.600830, 1328.110839, 9.886249, 0.000000, 0.000000, 90.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(18632, 1352.857299, 1334.921752, 12.656263, 90.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(18632, 1352.857299, 1334.921752, 12.236263, 90.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(18632, 1352.857299, 1334.921752, 11.806255, 90.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(18632, 1352.857299, 1339.393554, 11.806255, 90.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(18632, 1352.857299, 1339.903808, 12.236260, 90.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(18632, 1352.857299, 1340.554321, 12.616269, 90.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(1514, 1357.142089, 1341.224243, 11.236263, 0.000000, 0.000000, 360.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(1235, 1353.169921, 1333.228759, 10.396256, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(1223, 1352.357177, 1335.508666, 8.776268, 360.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(1223, 1352.357177, 1340.307861, 8.776268, 360.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(912, 1355.348632, 1343.076660, 10.426256, 0.000000, 0.000000, 450.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2060, 1361.977172, 1324.806884, 10.016242, 0.000000, 180.000000, 85.899940, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(912, 1355.348632, 1341.656127, 10.426256, 0.000000, 0.000000, 450.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(912, 1356.338378, 1341.345825, 10.426256, 0.000000, 0.000000, 180.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(1448, 1361.598999, 1324.827026, 9.886249, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2060, 1361.378417, 1324.850708, 10.016242, 0.000000, 180.000000, 85.899940, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2060, 1361.717895, 1324.825927, 10.136240, 0.000000, 180.000000, 85.899940, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2060, 1362.118164, 1324.797241, 10.200259, 39.799983, 180.000000, 85.899940, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(912, 1357.759765, 1341.345825, 10.426256, 0.000000, 0.000000, 180.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(912, 1359.180786, 1341.345825, 10.426256, 0.000000, 0.000000, 180.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(912, 1360.591430, 1341.345825, 10.426256, 0.000000, 0.000000, 180.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(1491, 1361.260131, 1340.994995, 8.506237, 0.000000, 0.000000, 0.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(1514, 1359.343505, 1341.274291, 11.266262, 0.000000, 0.000000, 360.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2824, 1355.374267, 1342.596557, 11.046252, 0.000000, 0.000000, 51.299995, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2471, 1355.438110, 1341.294311, 11.166247, 0.000000, 0.000000, -20.400001, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2309, 1356.946777, 1342.850341, 9.886249, 0.000000, 0.000000, -158.600021, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(2309, 1359.027954, 1343.099975, 9.886249, 0.000000, 0.000000, -178.400146, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(3041, 1358.379760, 1335.431518, 9.886249, 0.000000, 0.000000, 180.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
	CreateDynamicObject(3041, 1358.379760, 1337.162475, 9.886249, 0.000000, 0.000000, 180.000000, -1, FISHFAC_INTERIOR_MAP, -1, 200.00, 200.00); 
}