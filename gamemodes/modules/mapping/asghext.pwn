#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	//ASGH
	RemoveBuildingForPlayer(playerid, 5935, 1120.1563, -1303.4531, 18.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 5737, 1120.1563, -1303.4531, 18.5703, 0.25);
	//MAPPING ASGH
	RemoveBuildingForPlayer(playerid, 617, 1178.6016, -1332.0703, 12.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.0078, -1353.5000, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.0078, -1343.2656, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 618, 1177.7344, -1315.6641, 13.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.8125, -1292.9141, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1184.8125, -1303.1484, 12.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1190.7734, -1350.4141, 15.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1190.7734, -1320.8594, 15.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1210.8047, -1337.8359, 15.7734, 0.25);
	return 1;
}
hook OnGameModeInit()
{
    ///MAPPING_ASGH
	new DROP1 = CreateObject(19355, 1194.57434, -1329.84375, 12.31130,   0.00000, 90.00000, 90.00000);
	SetObjectMaterialText(DROP1, "{FF9800}DROPZONE", 0, 120, "Arial", 40, 1, -1250582, 0, 1);

	new DROP2 = CreateObject(19355, 1194.57434, -1319.66516, 12.31130,   0.00000, 90.00000, 90.00000);
	SetObjectMaterialText(DROP2, "{FF9800}DROP ZONE", 0, 120, "Arial", 40, 1, -1250582, 0, 1);

	new KEEP1 = CreateObject(19355, 1193.94263, -1361.89319, 12.31130,   0.00000, 90.00000, 90.00000);
	SetObjectMaterialText(KEEP1, "{FF9800}KEEP CLEAR", 0, 120, "Arial", 40, 1, -1250582, 0, 1);

	new KEEP2 = CreateObject(19355, 1195.00439, -1298.97424, 12.31130,   0.00000, 90.00000, 90.00000);
	SetObjectMaterialText(KEEP2, "{FF9800}KEEP CLEAR", 0, 120, "Arial", 40, 1, -1250582, 0, 1);

	new EMERGENCY = CreateObject(19353, 1172.90417, -1361.48865, 17.37500,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(EMERGENCY, "{FF0000}EMERGENCY", 0, 90, "Arial", 47, 1, -1250582, 0, 1);

	new STAFFONLY = CreateObject(19354, 1182.07703, -1348.27478, 15.71140,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(STAFFONLY, "{FF9800}STAFF ONLY", 0, 130, "Arial", 40, 1, -1250582, 0, 1);

	new pintukaca1[2];
	pintukaca1[0] = CreateDynamicObject(19456, 1172.01331, -1361.18347, 13.94802,   0.00000, 0.00000, 0.00000);
	pintukaca1[1] = CreateDynamicObject(19456, 1171.79700, -1323.65515, 11.97900,   90.00000, 0.00000, 0.00000);
	for(new i = 0; i < sizeof(pintukaca1); i++)
	{
	    SetDynamicObjectMaterial(pintukaca1[i], 0, 3255, "refinery", "ws_greymetal", 0xFFFFFFFF);
	}

	new jendelakaca1[1];
	jendelakaca1[0] = CreateDynamicObject(19458, 1171.70679, -1323.65247, 15.20983,   0.00000, 0.00000, 0.00000);
	for(new i = 0; i < sizeof(jendelakaca1); i++)
	{
	SetDynamicObjectMaterial(jendelakaca1[i], 0, 4010, "lanblokb2", "bluewhitewindow", 0xFFFFFFFF);
	}

	new textureparking[1];
	textureparking[0] = CreateDynamicObject(19378, 1195.43713, -1352.35559, 12.33510,   0.00000, 90.00000, 90.00000);
	for(new i = 0; i < sizeof(textureparking); i++)
	{
	    SetDynamicObjectMaterial(textureparking[i],  0, 5174, "warehus_las2", "ws_carparkwall2", 0xFFFFFFFF);
	}

	new textureorange[16];
	textureorange[0] = CreateDynamicObject(19355, 1194.54211, -1321.32104, 10.66760,   0.00000, 0.00000, 90.00000);
	textureorange[1] = CreateDynamicObject(19355, 1193.94702, -1360.19153, 10.66760,   0.00000, 0.00000, 90.00000);
	textureorange[2] = CreateDynamicObject(19355, 1193.02942, -1319.64185, 10.66760,   0.00000, 0.00000, 0.00000);
	textureorange[3] = CreateDynamicObject(19355, 1195.46985, -1361.88574, 10.66760,   0.00000, 0.00000, 0.00000);
	textureorange[4] = CreateDynamicObject(19355, 1194.58411, -1328.18250, 10.66760,   0.00000, 0.00000, 90.00000);
	textureorange[5] = CreateDynamicObject(19355, 1196.09094, -1329.88513, 10.66760,   0.00000, 0.00000, 0.00000);
	textureorange[6] = CreateDynamicObject(19355, 1194.99585, -1297.29834, 10.66760,   0.00000, 0.00000, 90.00000);
	textureorange[7] = CreateDynamicObject(19355, 1193.45740, -1299.01575, 10.66760,   0.00000, 0.00000, 0.00000);
	textureorange[8] = CreateDynamicObject(19355, 1194.57690, -1331.52869, 10.66760,   0.00000, 0.00000, 90.00000);
	textureorange[9] = CreateDynamicObject(19355, 1193.06091, -1329.88306, 10.66760,   0.00000, 0.00000, 0.00000);
	textureorange[10] = CreateDynamicObject(19355, 1192.42700, -1361.87646, 10.66760,   0.00000, 0.00000, 0.00000);
	textureorange[11] = CreateDynamicObject(19355, 1193.93494, -1363.57678, 10.66760,   0.00000, 0.00000, 90.00000);
	textureorange[12] = CreateDynamicObject(19355, 1194.54333, -1317.99939, 10.66760,   0.00000, 0.00000, 90.00000);
	textureorange[13] = CreateDynamicObject(19355, 1196.06677, -1319.69092, 10.66760,   0.00000, 0.00000, 0.00000);
	textureorange[14] = CreateDynamicObject(19355, 1196.52405, -1298.99634, 10.66760,   0.00000, 0.00000, 0.00000);
	textureorange[15] = CreateDynamicObject(19355, 1194.99866, -1300.68188, 10.66760,   0.00000, 0.00000, 90.00000);
	for(new i = 0; i < sizeof(textureorange); i++)
	{
	    SetDynamicObjectMaterial(textureorange[i], 0, 2361, "shopping_freezers", "white", 0xFFFF9800);
	}

	new texturehitam1[15];
	texturehitam1[0] = CreateDynamicObject(19459, 1170.10327, -1323.65247, 16.87220,   0.00000, 90.00000, 0.00000);
	texturehitam1[1] = CreateDynamicObject(19459, 1167.04724, -1328.36841, 15.19580,   0.00000, 0.00000, 90.00000);
	texturehitam1[2] = CreateDynamicObject(19459, 1167.11206, -1325.30322, 15.19580,   0.00000, 0.00000, 90.00000);
	texturehitam1[3] = CreateDynamicObject(19459, 1167.03906, -1318.90955, 15.19580,   0.00000, 0.00000, 90.00000);
	texturehitam1[4] = CreateDynamicObject(19459, 1167.13379, -1321.99011, 15.19580,   0.00000, 0.00000, 90.00000);
	texturehitam1[5] = CreateDynamicObject(19089, 1171.88733, -1323.63293, 16.81750,   0.00000, 0.00000, 0.00000);
	texturehitam1[6] = CreateDynamicObject(19459, 1170.42444, -1361.34875, 15.61020,   0.00000, 90.00000, 0.00000);
	texturehitam1[7] = CreateDynamicObject(19459, 1167.36694, -1358.43701, 14.10660,   0.00000, 0.00000, 90.00000);
	texturehitam1[8] = CreateDynamicObject(19459, 1167.36694, -1364.60974, 14.10660,   0.00000, 0.00000, 90.00000);
	texturehitam1[9] = CreateDynamicObject(19089, 1172.11389, -1361.50391, 15.53620,   0.00000, 0.00000, 0.00000);
	texturehitam1[10] = CreateDynamicObject(19089, 1172.11389, -1361.46399, 15.53620,   0.00000, 0.00000, 0.00000);


	for(new i = 0; i < sizeof(texturehitam1); i++)
	{
	    SetDynamicObjectMaterial(texturehitam1[i], 0, 2361, "shopping_freezers", "white", 0xFF0A0A0A);
	}


	new textureabuabu[13];
	textureabuabu[0] = CreateDynamicObject(18981, 1179.26150, -1342.69710, 19.04670,   0.00000, 90.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[1] = CreateDynamicObject(18981, 1204.22140, -1317.68530, 19.04670,   0.00000, 90.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[2] = CreateDynamicObject(18981, 1204.22140, -1342.69710, 19.04670,   0.00000, 90.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[4] = CreateDynamicObject(18981, 1179.26150, -1317.68530, 19.04670,   0.00000, 90.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[5] = CreateDynamicObject(18765, 1170.81885, -1359.40796, 10.76250,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[6] = CreateDynamicObject(18765, 1170.81445, -1369.40869, 10.76250,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[7] = CreateDynamicObject(18765, 1180.81921, -1359.38342, 10.76250,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[8] = CreateDynamicObject(18765, 1180.81921, -1369.36133, 10.76250,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[9] = CreateDynamicObject(19463, 1187.50964, -1362.62549, 12.77230,   0.00000, 103.50000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[10] = CreateDynamicObject(19463, 1187.51672, -1359.17102, 12.77230,   0.00000, 103.50000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[11] = CreateDynamicObject(19444, 1187.36353, -1354.44690, 11.99930,   105.00000, 0.00000, 90.00000, 0, 0, -1, 200.00, 200.00); 
	textureabuabu[12] = CreateDynamicObject(19444, 1187.28735, -1367.38342, 12.01930,   105.00000, 0.00000, 90.00000, 0, 0, -1, 200.00, 200.00); 
	for(new i = 0; i < sizeof(textureabuabu); i++)
	{
	    SetDynamicObjectMaterial(textureabuabu[i], 0, 2361, "shopping_freezers", "white", 0xFFECEAEA);
	}

	new texturebiru[16];
	texturebiru[0] = CreateDynamicObject(18762, 1200.94714, -1308.37268, 16.18310,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[1] = CreateDynamicObject(18762, 1200.94714, -1308.37268, 11.20230,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[2] = CreateDynamicObject(18762, 1200.94714, -1354.63086, 11.20230,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[3] = CreateDynamicObject(18762, 1200.94714, -1354.63086, 16.18310,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[4] = CreateDynamicObject(18762, 1200.94714, -1349.81555, 11.20230,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[5] = CreateDynamicObject(18762, 1200.94714, -1349.81555, 16.18310,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[6] = CreateDynamicObject(18762, 1200.94714, -1347.51196, 11.20230,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[7] = CreateDynamicObject(18762, 1200.94714, -1347.51196, 16.18310,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[8] = CreateDynamicObject(18762, 1200.92712, -1305.79321, 11.20230,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[9] = CreateDynamicObject(18762, 1200.94714, -1305.78894, 16.18310,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[10] = CreateDynamicObject(18981, 1216.25854, -1317.68921, 7.00180,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[11] = CreateDynamicObject(18981, 1216.26794, -1342.66748, 7.00180,   0.00000, 0.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[12] = CreateDynamicObject(18981, 1204.26050, -1317.66530, 20.02561,   0.00000, 90.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[13] = CreateDynamicObject(18981, 1204.22140, -1342.69710, 20.02560,   0.00000, 90.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[14] = CreateDynamicObject(18981, 1179.24140, -1342.69810, 20.02560,   0.00000, 90.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	texturebiru[15] = CreateDynamicObject(18981, 1179.26150, -1317.68530, 20.02560,   0.00000, 90.00000, 0.00000, 0, 0, -1, 200.00, 200.00); 
	//texturebiru[16] = CreateDynamicObject(19453, 1194.87805, -1344.45422, 11.88616,   0.00000, 0.00000, 67.37630);
//	texturebiru[17] = CreateDynamicObject(19453, 1195.24255, -1310.07581, 11.88620,   0.00000, 0.00000, 294.44611);
//	texturebiru[18] = CreateDynamicObject(19453, 1190.25696, -1330.67139, 11.88620,   0.00000, 0.00000, 0.00000);
//	texturebiru[19] = CreateDynamicObject(19453, 1190.25696, -1317.37500, 11.88620,   0.00000, 0.00000, 0.00000);
	for(new i = 0; i < sizeof(texturebiru); i++)
	{
	    SetDynamicObjectMaterial(texturebiru[i], 0, 3167, "trailers", "trail_wall4", 0xFFFFFFFF);
	}
		//NOTEXTURE
	CreateDynamicObject(1569, 1182.10925, -1346.76624, 13.00290,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1569, 1182.11182, -1349.73975, 13.00289,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(869, 1182.07153, -1293.21436, 13.73715,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1182.03772, -1302.03870, 13.73715,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1181.94885, -1298.79468, 13.73715,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1182.01013, -1295.99268, 13.73715,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1183.68323, -1344.25623, 13.73929,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 1183.57751, -1352.23120, 13.73929,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19121, 1185.56677, -1354.16809, 13.65840,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19121, 1182.56543, -1354.16809, 13.65842,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19121, 1184.03369, -1354.16809, 13.65840,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1171.85010, -1326.22229, 13.57153,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1171.82825, -1320.88135, 13.57150,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1172.10388, -1361.28320, 13.54779,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1233, 1190.26624, -1329.92285, 13.99630,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1233, 1190.26624, -1317.86646, 13.99630,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1997, 1178.61743, -1366.85522, 13.26650,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1997, 1174.08777, -1366.85522, 13.26650,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1997, 1176.36609, -1366.85522, 13.26650,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1185.72913, -1356.04529, 13.17900,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1185.72913, -1365.79065, 13.17900,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1185.72913, -1362.55017, 13.17900,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, 1185.72913, -1359.30554, 13.17900,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1214, 1199.94092, -1346.67395, 12.39746,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1214, 1200.11072, -1307.27417, 12.40850,   0.00000, 0.00000, 0.00000);

	
	//
	
	CreateDynamicMapIcon(1752.7167,-1893.8838,13.5574, 56, 0, 0, 0, -1, 250.0);
	CreateDynamicMapIcon(1930.8431,-1860.4442,13.1294, 56, 0, 0, 0, -1, 250.0);
	CreateDynamicMapIcon(1620.7040,-1890.7914,13.1163, 56, 0, 0, 0, -1, 250.0);
	CreateDynamicMapIcon(1297.7758,-1870.4969,13.1144, 56, 0, 0, 0, -1, 250.0);
	CreateDynamicMapIcon(-50.6214,-270.2908,6.2011, 56, 0, 0, 0, -1, 250.0);
	CreateDynamicMapIcon(825.8422,859.6031,12.2405, 56, 0, 0, 0, -1, 250.0);
	CreateDynamicMapIcon(2048.2568,-1244.7019,23.4659, 56, 0, 0, 0, -1, 250.0);
	CreateDynamicMapIcon(2396.0933,-2113.8303,13.5469, 56, 0, 0, 0, -1, 250.0);
	CreateDynamicObject(982, 1873.972656, -1834.551879, 13.488530, 0.000000, 0.000000, 73.426933); //1 (Emmilia_Claresta)
	CreateDynamicObject(982, 1889.096679, -1838.935424, 13.474967, 0.000000, 0.000000, 74.246902); //1 (Emmilia_Claresta)
}