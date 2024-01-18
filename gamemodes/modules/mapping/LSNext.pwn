#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 6516, 717.687, -1357.280, 18.045, 0.250);
	RemoveBuildingForPlayer(playerid, 1439, 732.726, -1341.770, 12.630, 0.250);
	RemoveBuildingForPlayer(playerid, 1415, 732.851, -1332.900, 12.687, 0.250);
}

hook OnGameModeInit()
{
	new tmpobjid;
	tmpobjid = CreateDynamicObject(18981, 774.764831, -1372.115234, 12.414125, 180.000000, 270.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14713, "lahss2aint2", "HS2_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 749.785705, -1372.070678, 12.414125, 180.000000, 270.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14713, "lahss2aint2", "HS2_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 749.797180, -1365.400146, 12.414125, 180.000000, 270.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14713, "lahss2aint2", "HS2_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 724.817504, -1365.356567, 12.414125, 180.000000, 270.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14713, "lahss2aint2", "HS2_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 750.127990, -1365.060302, 12.184115, 180.000000, 270.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14713, "lahss2aint2", "HS2_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 725.168273, -1365.016723, 12.184115, 180.000000, 270.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14713, "lahss2aint2", "HS2_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 774.764221, -1372.525634, 12.314123, 180.000000, 270.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14713, "lahss2aint2", "HS2_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 775.107360, -1371.793579, 12.184115, 180.000000, 270.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14713, "lahss2aint2", "HS2_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19359, 775.855895, -1372.888305, 12.914126, 0.000000, 270.000000, -179.999984, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	tmpobjid = CreateDynamicObject(19359, 775.856262, -1369.698852, 12.914126, 0.000000, 270.000000, -179.999984, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	tmpobjid = CreateDynamicObject(19359, 779.355895, -1372.888305, 12.914126, 0.000000, 270.000000, -179.999984, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	tmpobjid = CreateDynamicObject(19359, 779.355895, -1369.698120, 12.914126, 0.000000, 270.000000, -179.999984, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "desgreengrass", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 774.664306, -1342.448242, 12.054113, 180.000000, 270.000000, -1.299998, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 774.100097, -1367.311767, 12.054113, 180.000000, 270.000000, -1.299998, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 749.731262, -1342.304077, 12.054113, 180.000000, 270.000000, -1.299998, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 724.823059, -1341.939819, 12.054113, 180.000000, 270.000000, -1.299998, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 759.032531, -1361.646362, 19.376125, 0.000000, 0.000000, 65.000000, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 759.032531, -1361.646362, 8.896137, 0.000000, 0.000000, 65.000000, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 763.333435, -1368.420166, 8.876128, 0.000000, 0.000000, 179.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 763.333435, -1368.420166, 19.376129, 0.000000, 0.000000, 179.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 763.312500, -1380.170410, 19.376129, 0.000000, 0.000000, 179.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 763.322021, -1374.800415, 19.376129, 0.000000, 0.000000, 179.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 763.322021, -1374.800415, 8.856126, 0.000000, 0.000000, 179.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 763.312500, -1380.170410, 8.886135, 0.000000, 0.000000, 179.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 758.584045, -1384.892578, 19.376129, 0.000000, 0.000000, 269.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 758.583068, -1379.712646, 24.506111, 360.000000, 90.000000, 269.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 758.601379, -1369.242553, 24.506111, 360.000000, 90.000000, 269.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 756.782348, -1366.400268, 24.526128, 0.000000, 90.000000, 65.000000, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 754.606201, -1383.335693, 26.236131, 0.000000, 0.000000, 179.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 754.611755, -1380.236083, 26.236131, 0.000000, 0.000000, 179.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 756.134094, -1384.858764, 26.236131, 0.000000, 0.000000, 269.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 759.314147, -1384.864257, 26.236131, 0.000000, 0.000000, 269.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 761.784484, -1384.868164, 26.236131, 0.000000, 0.000000, 269.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 763.296386, -1383.335693, 26.236131, 0.000000, -0.000007, 179.899978, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 763.301940, -1380.236083, 26.236131, 0.000000, -0.000007, 179.899978, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 756.134094, -1378.718383, 26.236131, -0.000007, 0.000000, -90.099952, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 759.314147, -1378.723876, 26.236131, -0.000007, 0.000000, -90.099952, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 761.784484, -1378.727783, 26.236131, -0.000007, 0.000000, -90.099952, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19378, 758.583068, -1379.712646, 27.906108, 360.000000, 90.000000, 269.900024, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 763.307373, -1377.066040, 26.236131, 0.000000, -0.000007, 179.899978, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 754.617309, -1377.051269, 26.236131, 0.000000, -0.000007, 179.899978, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 8391, "ballys01", "ballywall02_128", 0x00000000);
	tmpobjid = CreateDynamicObject(967, 774.711669, -1331.210693, 12.526806, 0.000000, 0.000000, 88.600021, 0, 0, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "corugwall_sandy", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14534, "ab_wooziea", "walp72S", 0x00000000);
	
	tmpobjid = CreateDynamicObject(19481, 647.637634, -1357.684814, 17.654844, 0.000000, 0.000000, 179.700027, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19481, 647.637573, -1357.694824, 17.694845, 0.000000, 0.000000, 179.700027, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19481, 763.452636, -1369.269653, 20.273876, 0.000000, 0.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19481, 763.434997, -1379.319946, 20.293874, 0.000000, 0.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19481, 763.452636, -1369.269653, 20.273876, 0.000000, 0.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19481, 763.434997, -1379.319946, 20.293874, 0.000000, 0.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19480, 763.445495, -1373.755859, 17.512645, 0.000000, 0.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19480, 763.445495, -1373.755859, 17.512645, 0.000000, 0.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19480, 763.430786, -1381.915161, 17.512645, 0.000000, 0.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19480, 763.459716, -1365.405273, 17.512645, 0.000000, 0.000000, -0.099999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1566, 760.620300, -1362.325561, 14.394124, 0.000007, 0.000000, 154.900009, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1566, 757.758483, -1360.985351, 14.394124, 0.000007, 0.000000, 334.900024, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(6965, 777.494506, -1371.369018, 9.574121, 0.000000, 0.000007, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(744, 778.660522, -1371.129272, 8.394124, -0.000003, 0.000006, -31.699996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(744, 777.223937, -1370.116821, 8.394124, 0.000006, 0.000003, 62.699981, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(744, 776.714782, -1371.103393, 8.394124, 0.000003, -0.000003, 141.699966, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(744, 777.252868, -1371.727172, 8.104125, -0.000000, -0.000007, -163.599929, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(9697, 714.982910, -1333.695312, 12.552915, -0.299997, 0.000000, -0.199999, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(9697, 710.200439, -1348.568603, 12.554958, -0.299997, 0.000000, 179.800003, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(995, 764.429077, -1359.418457, 13.255620, 89.999992, 89.899993, -90.099975, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(995, 748.731628, -1352.743041, 13.255620, 89.999992, 89.999992, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(995, 741.731628, -1352.743041, 13.255620, 89.999992, 89.999992, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(995, 734.731628, -1352.743041, 13.255620, 89.999992, 89.999992, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(966, 774.636596, -1332.294189, 12.495573, 0.000000, 0.000000, 180.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3850, 781.888000, -1332.310058, 13.070233, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(910, 786.392639, -1332.088378, 13.752121, 0.000000, 0.000000, 269.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1334, 786.332763, -1334.565795, 13.545787, 0.000000, 0.000000, 88.800003, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(970, 779.013305, -1374.498046, 12.569538, 0.000000, 0.000007, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(998, 637.539978, -1384.076782, 13.271718, 89.999992, 179.600006, -90.000022, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(998, 637.539978, -1373.076782, 13.271718, 89.999992, 179.600006, -90.000022, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(998, 637.539978, -1362.076782, 13.271718, 89.999992, 179.600006, -90.000022, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(998, 637.539978, -1351.076782, 13.271718, 89.999992, 179.600006, -90.000022, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(998, 637.539978, -1340.076782, 13.271718, 89.999992, 179.600006, -90.000022, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19968, 642.718566, -1359.670898, 12.129487, 0.000000, 0.000000, 270.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19982, 637.535949, -1384.856811, 11.818924, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1256, 647.241455, -1373.311035, 13.343405, 0.000000, 0.000000, -0.299997, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1256, 647.212951, -1378.771362, 13.343405, 0.000000, 0.000000, -0.299997, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1256, 647.401184, -1340.400756, 13.343405, -0.000000, 0.000015, -0.299997, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1256, 647.436157, -1333.730590, 13.343405, -0.000000, 0.000015, -0.299997, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(995, 769.929077, -1359.418457, 13.255620, 89.999992, 89.899993, -90.099975, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(995, 775.429077, -1359.418457, 13.255620, 89.999992, 89.899993, -90.099975, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(995, 780.929077, -1359.418457, 13.255620, 89.999992, 89.899993, -90.099975, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(995, 755.731628, -1352.743041, 13.255620, 89.999992, 89.999992, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2955, 731.980590, -1353.956787, 14.016584, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2955, 731.970581, -1357.085571, 14.016584, 0.000000, 0.000000, 360.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11711, 732.038513, -1354.549560, 15.422182, 0.000000, 0.000000, 450.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11711, 732.038513, -1357.680175, 15.422182, 0.000000, 0.000000, 450.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(970, 776.193054, -1374.498046, 12.569538, 0.000000, 0.000007, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(970, 779.013305, -1368.087036, 12.569538, 0.000000, 0.000014, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(970, 776.193054, -1368.087036, 12.569538, 0.000000, 0.000014, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(970, 781.113403, -1370.167114, 12.569538, 0.000014, 0.000007, 89.999954, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(970, 781.113403, -1372.407714, 12.569538, 0.000014, 0.000007, 89.999954, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(970, 774.093139, -1370.167114, 12.569538, 0.000022, 0.000007, 89.999931, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(970, 774.093139, -1372.407714, 12.569538, 0.000022, 0.000007, 89.999931, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(638, 776.618713, -1384.662963, 13.520562, 0.000007, 0.000000, 89.999977, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(638, 779.298828, -1384.662963, 13.520562, 0.000007, 0.000000, 89.999977, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1419, 777.491821, -1384.973632, 13.136755, 0.000000, 0.000014, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1419, 778.372009, -1384.973632, 13.136755, 0.000000, -0.000014, 179.999908, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1419, 777.491821, -1384.353027, 13.136755, 0.000000, 0.000022, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1419, 778.372009, -1384.353027, 13.136755, 0.000000, -0.000022, 179.999862, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(949, 762.100585, -1362.764892, 13.515254, 0.000000, 0.000007, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(949, 756.470520, -1360.183593, 13.515254, 0.000000, 0.000007, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1226, 753.979675, -1351.686523, 16.413452, -0.000007, 0.000000, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1226, 746.899353, -1351.661865, 16.413452, -0.000007, 0.000000, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1226, 739.609497, -1351.636108, 16.413452, -0.000007, 0.000000, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1226, 762.686706, -1358.367187, 16.413452, -0.000007, 0.000000, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1226, 786.127258, -1358.448974, 16.413452, -0.000007, 0.000000, -90.199996, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19121, 774.163696, -1384.868652, 13.172854, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19121, 775.383789, -1384.868652, 13.172854, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19121, 780.463867, -1384.868652, 13.172854, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19121, 781.743774, -1384.868652, 13.172854, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1294, 785.680175, -1377.561645, 14.434135, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1294, 785.680175, -1370.561645, 14.434135, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1294, 785.680175, -1363.561645, 14.434135, 0.000000, 0.000000, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1294, 771.600036, -1383.351562, 14.434135, 0.000000, 0.000000, 270.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1294, 764.600036, -1383.351562, 14.434135, 0.000000, 0.000000, 270.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1368, 763.952331, -1370.790405, 13.586611, 0.000014, 0.000000, 89.999954, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1368, 763.952331, -1375.790405, 13.586611, 0.000014, 0.000000, 89.999954, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1368, 763.952331, -1380.790405, 13.586611, 0.000014, 0.000000, 89.999954, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1368, 763.952331, -1366.800659, 13.586611, 0.000022, 0.000000, 89.999931, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2001, 764.156372, -1373.854492, 12.877625, 0.000000, 0.000014, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2010, 764.143493, -1377.892211, 12.907622, 0.000000, 0.000014, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2011, 764.115112, -1378.796630, 12.877634, 0.000000, 0.000014, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2001, 764.156372, -1372.724487, 12.877625, 0.000000, 0.000014, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2011, 764.115112, -1369.027099, 12.877634, 0.000000, 0.000022, 0.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1496, 758.064514, -1378.646606, 24.550075, 0.000000, 0.000000, -0.199998, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(8674, 763.287170, -1370.355468, 25.401151, 0.000000, 0.000000, 89.900001, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(8674, 758.433044, -1363.425292, 25.401151, 0.000000, 0.000000, 159.899993, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(8674, 748.446289, -1361.627563, 25.401151, 0.000000, 0.000000, 179.899993, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(8674, 738.166076, -1361.609741, 25.401151, 0.000000, 0.000000, 179.899993, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(8674, 749.386291, -1384.876831, 25.401151, 0.000000, -0.000007, 179.899948, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(8674, 739.106079, -1384.859008, 25.401151, 0.000000, -0.000007, 179.899948, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3934, 741.865356, -1371.451782, 24.667280, 0.000000, 0.000000, 90.000000, 0, 0, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2614, 759.192871, -1361.577026, 17.026649, 0.000000, 0.000000, 154.899978, 0, 0, -1, 300.00, 300.00); 
}