#include <YSI\y_hooks>

hook OnGameModeInit()
{
new g_Object[732];
g_Object[0] = CreateObject(19464, 908.9829, -1475.7220, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[0], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[1] = CreateObject(18981, 917.3012, -1463.5339, 2752.8217, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[1], 0, 15034, "genhotelsave", "bathtile05_int", 0xFFFFFFFF);
g_Object[2] = CreateObject(1536, 920.2229, -1476.0039, 2753.0510, 0.0000, 0.0000, 180.0000); //Gen_doorEXT15
SetObjectMaterial(g_Object[2], 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0xFFFFFFFF);
g_Object[3] = CreateObject(1536, 920.1928, -1476.0039, 2753.0510, 0.0000, 0.0000, 0.0000); //Gen_doorEXT15
SetObjectMaterial(g_Object[3], 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0xFFFFFFFF);
g_Object[4] = CreateObject(19464, 921.7540, -1478.8221, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[4], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[5] = CreateObject(19464, 918.6541, -1478.8221, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[5], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[6] = CreateObject(19464, 915.8043, -1475.9718, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[6], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[7] = CreateObject(19464, 909.8748, -1475.9718, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[7], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[8] = CreateObject(19450, 913.7258, -1472.9619, 2753.2600, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[8], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[9] = CreateObject(19450, 920.3264, -1477.5727, 2753.2399, 0.0000, 90.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[9], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[10] = CreateObject(19464, 918.6643, -1475.7132, 2751.6335, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[10], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[11] = CreateObject(19565, 918.5355, -1475.3172, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[11], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[12] = CreateObject(19565, 918.5355, -1475.7860, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[12], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[13] = CreateObject(19565, 918.5355, -1474.8469, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[13], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[14] = CreateObject(19565, 918.5355, -1474.3763, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[14], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[15] = CreateObject(19565, 918.5355, -1473.9061, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[15], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[16] = CreateObject(19565, 918.5355, -1473.4455, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[16], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[17] = CreateObject(19565, 918.5355, -1472.9752, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[17], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[18] = CreateObject(19464, 918.6243, -1475.6832, 2750.9328, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[18], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[19] = CreateObject(19464, 918.6743, -1475.6832, 2750.9328, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[19], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[20] = CreateObject(19450, 913.7258, -1476.4620, 2753.2500, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[20], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[21] = CreateObject(1708, 917.9519, -1473.0107, 2753.2717, 0.0000, 0.0000, -90.0000); //kb_chair02
SetObjectMaterial(g_Object[21], 1, 1746, "cj_sofa", "CJ_FAB4", 0xFFFFFFFF);
SetObjectMaterial(g_Object[21], 2, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[22] = CreateObject(2315, 914.4351, -1472.9880, 2753.3161, 0.0000, 0.0000, 0.0000); //CJ_TV_TABLE4
g_Object[23] = CreateObject(1708, 917.9519, -1471.4803, 2753.2717, 0.0000, 0.0000, -90.0000); //kb_chair02
SetObjectMaterial(g_Object[23], 1, 1746, "cj_sofa", "CJ_FAB4", 0xFFFFFFFF);
SetObjectMaterial(g_Object[23], 2, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[24] = CreateObject(1708, 912.3715, -1472.4554, 2753.2717, 0.0000, 0.0000, 89.0000); //kb_chair02
SetObjectMaterial(g_Object[24], 1, 1746, "cj_sofa", "CJ_FAB4", 0xFFFFFFFF);
SetObjectMaterial(g_Object[24], 2, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[25] = CreateObject(1708, 912.3646, -1473.9858, 2753.2717, 0.0000, 0.0000, 89.0000); //kb_chair02
SetObjectMaterial(g_Object[25], 1, 1746, "cj_sofa", "CJ_FAB4", 0xFFFFFFFF);
SetObjectMaterial(g_Object[25], 2, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[26] = CreateObject(2001, 912.7150, -1475.1645, 2753.3142, 0.0000, 0.0000, 0.0000); //nu_plant_ofc
SetObjectMaterial(g_Object[26], 1, 630, "gta_potplants", "kb_teracota_pot64", 0xFFFFFFFF);
g_Object[27] = CreateObject(2001, 917.7155, -1475.1645, 2753.3142, 0.0000, 0.0000, 0.0000); //nu_plant_ofc
SetObjectMaterial(g_Object[27], 1, 630, "gta_potplants", "kb_teracota_pot64", 0xFFFFFFFF);
g_Object[28] = CreateObject(1753, 916.2219, -1475.3032, 2753.2915, 0.0000, 0.0000, 180.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[28], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[29] = CreateObject(19786, 915.2346, -1475.9768, 2755.8620, 0.0000, 0.0000, 180.0000); //LCDTVBig1
SetObjectMaterial(g_Object[29], 0, 14570, "traidaqua", "ab_tv", 0xFFFFFFFF);
SetObjectMaterial(g_Object[29], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[30] = CreateObject(2816, 915.4837, -1472.9720, 2753.8125, 0.0000, 0.0000, 0.0000); //gb_bedmags01
g_Object[31] = CreateObject(2855, 914.5407, -1472.9958, 2753.8032, 0.0000, 0.0000, 0.0000); //gb_bedmags05
g_Object[32] = CreateObject(955, 909.4804, -1473.5239, 2753.6857, 0.0000, 0.0000, 90.0000); //CJ_EXT_SPRUNK
g_Object[33] = CreateObject(956, 909.4525, -1474.9178, 2753.7165, 0.0000, 0.0000, 90.0000); //CJ_EXT_CANDY
g_Object[34] = CreateObject(19825, 911.2739, -1475.8176, 2756.0183, 0.0000, 0.0000, 180.0000); //SprunkClock1
g_Object[35] = CreateObject(19565, 906.5717, -1457.0998, 2756.3854, 0.0000, 0.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[35], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[36] = CreateObject(19565, 907.0421, -1457.0998, 2756.3854, 0.0000, 0.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[36], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[37] = CreateObject(19464, 906.1342, -1472.8424, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[37], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[38] = CreateObject(19464, 901.8338, -1466.9337, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[38], 0, 10765, "airportgnd_sfse", "white", 0xFF998F4E);
g_Object[39] = CreateObject(19464, 904.7039, -1469.8027, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[39], 0, 10765, "airportgnd_sfse", "white", 0xFF998F4E);
g_Object[40] = CreateObject(19464, 904.6939, -1458.9835, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[40], 0, 10765, "airportgnd_sfse", "white", 0xFF998F4E);
g_Object[41] = CreateObject(19464, 903.8833, -1463.8735, 2754.3547, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[41], 0, 10765, "airportgnd_sfse", "white", 0xFF692015);
g_Object[42] = CreateObject(19464, 901.8338, -1461.8331, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[42], 0, 10765, "airportgnd_sfse", "white", 0xFF998F4E);
g_Object[43] = CreateObject(19464, 901.8338, -1464.5334, 2756.9982, 0.0000, 90.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[43], 0, 10765, "airportgnd_sfse", "white", 0xFF998F4E);
g_Object[44] = CreateObject(19565, 929.6234, -1457.1499, 2756.6357, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[44], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[45] = CreateObject(18981, 892.3007, -1463.5339, 2752.8217, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[45], 0, 15034, "genhotelsave", "bathtile05_int", 0xFFFFFFFF);
g_Object[46] = CreateObject(1337, 903.8958, -1462.4918, 2754.5273, 31.9999, 0.0000, 90.0000); //BinNt07_LA
SetObjectMaterial(g_Object[46], 1, 1328, "labins01_la", "bins9_LAe2", 0xFFFFFFFF);
g_Object[47] = CreateObject(1337, 903.8958, -1463.2926, 2754.5273, 31.9999, 0.0000, 90.0000); //BinNt07_LA
SetObjectMaterial(g_Object[47], 1, 1328, "labins01_la", "bins9_LAe2", 0xFFFFFFFF);
g_Object[48] = CreateObject(2593, 904.4027, -1465.8520, 2754.1142, 0.0000, 0.0000, 0.0000); //roleplay_rack
g_Object[49] = CreateObject(2593, 904.4027, -1464.6418, 2754.1142, 0.0000, 0.0000, 0.0000); //roleplay_rack
g_Object[50] = CreateObject(19450, 911.7766, -1461.8607, 2752.3906, 90.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[50], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[51] = CreateObject(1569, 911.7252, -1459.2601, 2753.2839, 0.0000, 0.0000, -122.0998); //ADAM_V_DOOR
g_Object[52] = CreateObject(19174, 904.8389, -1469.5666, 2755.6752, 0.0000, 0.0000, 90.0000); //SAMPPicture3
SetObjectMaterial(g_Object[52], 0, 2266, "picture_frame", "CJ_PAINTING3", 0xFFFFFFFF);
g_Object[53] = CreateObject(19174, 904.8389, -1459.3762, 2755.6752, 0.0000, 0.0000, 90.0000); //SAMPPicture3
SetObjectMaterial(g_Object[53], 0, 2266, "picture_frame", "CJ_PAINTING16", 0xFFFFFFFF);
g_Object[54] = CreateObject(19450, 915.3461, -1463.5118, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[54], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[55] = CreateObject(19450, 913.4473, -1463.5218, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[55], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[56] = CreateObject(2162, 926.0319, -1463.4350, 2753.2990, 0.0000, 0.0000, -180.0000); //MED_OFFICE_UNIT_1
g_Object[57] = CreateObject(19565, 909.4722, -1457.0998, 2756.3854, 0.0000, 0.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[57], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[58] = CreateObject(19402, 918.8341, -1462.7749, 2755.0104, 0.0000, 0.0000, 90.0000); //wall050
SetObjectMaterial(g_Object[58], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[59] = CreateObject(19450, 917.1854, -1464.6108, 2753.2399, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[59], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[60] = CreateObject(19450, 916.5449, -1464.6108, 2753.2500, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[60], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[61] = CreateObject(19466, 918.9342, -1462.7762, 2756.4970, 0.0000, 0.0000, 90.0000); //window001
g_Object[62] = CreateObject(19087, 919.7230, -1462.7740, 2756.3122, 0.0000, 0.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[62], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[63] = CreateObject(19087, 917.9428, -1462.7740, 2756.3122, 0.0000, 0.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[63], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[64] = CreateObject(19087, 919.8325, -1462.7740, 2755.5312, 90.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[64], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[65] = CreateObject(19087, 919.8325, -1462.7740, 2755.8715, 90.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[65], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[66] = CreateObject(19087, 919.8325, -1462.7740, 2754.4501, 90.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[66], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[67] = CreateObject(19087, 918.8919, -1462.7740, 2755.5412, 0.0000, 0.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[67], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[68] = CreateObject(18762, 916.7473, -1463.0930, 2754.7031, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
SetObjectMaterial(g_Object[68], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[69] = CreateObject(19385, 911.7733, -1458.5091, 2755.0256, 0.0000, 0.0000, 0.0000); //wall033
SetObjectMaterial(g_Object[69], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[70] = CreateObject(19464, 907.7542, -1456.9422, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[70], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[71] = CreateObject(19464, 908.7846, -1456.9621, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[71], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[72] = CreateObject(3051, 910.3054, -1457.1009, 2754.6354, 0.0000, 0.0000, 135.6000); //lift_dr
SetObjectMaterial(g_Object[72], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[73] = CreateObject(3051, 907.3848, -1457.0985, 2754.6354, 0.0000, 0.0000, 135.6000); //lift_dr
SetObjectMaterial(g_Object[73], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[74] = CreateObject(19565, 909.9224, -1457.0998, 2756.3854, 0.0000, 0.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[74], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[75] = CreateObject(3051, 909.0891, -1457.1036, 2754.6354, 0.0000, 0.0000, -43.9000); //lift_dr
SetObjectMaterial(g_Object[75], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[76] = CreateObject(3051, 906.1680, -1457.0931, 2754.6354, 0.0000, 0.0000, -43.9000); //lift_dr
SetObjectMaterial(g_Object[76], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[77] = CreateObject(19565, 909.9323, -1457.1499, 2756.4155, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[77], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[78] = CreateObject(19565, 909.4622, -1457.1499, 2756.4155, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[78], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[79] = CreateObject(19565, 909.4622, -1457.1499, 2756.6357, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[79], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[80] = CreateObject(19565, 909.9326, -1457.1499, 2756.6357, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[80], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[81] = CreateObject(19565, 909.2525, -1456.9095, 2756.4055, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[81], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[82] = CreateObject(19565, 910.1328, -1456.9095, 2756.4055, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[82], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[83] = CreateObject(19565, 907.2523, -1456.9095, 2756.4055, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[83], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[84] = CreateObject(19565, 906.3621, -1456.9095, 2756.4055, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[84], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[85] = CreateObject(19565, 906.5822, -1457.1499, 2756.4055, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[85], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[86] = CreateObject(19565, 907.0526, -1457.1499, 2756.4055, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[86], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[87] = CreateObject(19565, 906.5623, -1457.1499, 2756.6455, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[87], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[88] = CreateObject(19565, 907.0327, -1457.1499, 2756.6455, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[88], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[89] = CreateObject(19565, 906.5625, -1457.1499, 2756.4052, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[89], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[90] = CreateObject(19174, 909.6889, -1457.1361, 2756.5361, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[90], "1. Stock", 0, 90, "Arial Black", 14, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[90], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[91] = CreateObject(19174, 906.8087, -1457.1361, 2756.5361, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[91], "1. Stock", 0, 90, "Arial Black", 14, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[91], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[92] = CreateObject(19174, 915.0288, -1463.6440, 2755.8454, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[92], "Cityhall", 0, 90, "Times New Roman", 40, 1, 0xFFA5A9A7, 0x0, 1);
SetObjectMaterial(g_Object[92], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[93] = CreateObject(19174, 915.0288, -1463.6440, 2755.4851, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[93], "Los Santos", 0, 90, "Times New Roman", 25, 1, 0xFFA5A9A7, 0x0, 1);
SetObjectMaterial(g_Object[93], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[94] = CreateObject(1753, 908.0017, -1472.2602, 2753.2915, 0.0000, 0.0000, 180.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[94], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[95] = CreateObject(19174, 909.4691, -1457.0837, 2754.0336, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[95], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[95], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[96] = CreateObject(19174, 907.0280, -1457.0837, 2754.9841, 0.0000, 180.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[96], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[96], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[97] = CreateObject(2315, 924.1851, -1472.9880, 2753.3061, 0.0000, 0.0000, 0.0000); //CJ_TV_TABLE4
g_Object[98] = CreateObject(19464, 921.7551, -1475.7132, 2751.6335, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[98], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[99] = CreateObject(19464, 921.7249, -1475.6832, 2750.9328, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[99], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[100] = CreateObject(19464, 921.7951, -1475.6933, 2750.9328, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[100], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[101] = CreateObject(19565, 921.6159, -1475.3172, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[101], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[102] = CreateObject(19565, 921.6159, -1475.7873, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[102], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[103] = CreateObject(19565, 921.6159, -1474.8465, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[103], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[104] = CreateObject(19565, 921.6159, -1474.3763, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[104], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[105] = CreateObject(19565, 921.6159, -1473.9056, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[105], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[106] = CreateObject(19565, 921.6159, -1473.4355, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[106], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[107] = CreateObject(19565, 921.6159, -1472.9753, 2754.1630, 90.0000, 90.0000, 0.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[107], 0, 15048, "labigsave", "ah_carpet2kb", 0xFFFFFFFF);
g_Object[108] = CreateObject(19450, 926.7258, -1472.9619, 2753.2500, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[108], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[109] = CreateObject(19450, 926.7258, -1476.4620, 2753.2509, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[109], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[110] = CreateObject(19464, 924.8234, -1475.9718, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[110], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[111] = CreateObject(19464, 930.7633, -1475.9718, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[111], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[112] = CreateObject(19464, 931.2830, -1475.7220, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[112], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[113] = CreateObject(2001, 922.5961, -1475.1645, 2753.3142, 0.0000, 0.0000, 0.0000); //nu_plant_ofc
SetObjectMaterial(g_Object[113], 1, 630, "gta_potplants", "kb_teracota_pot64", 0xFFFFFFFF);
g_Object[114] = CreateObject(1753, 925.8120, -1475.3032, 2753.2915, 0.0000, 0.0000, 180.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[114], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[115] = CreateObject(2001, 926.9959, -1475.1645, 2753.3142, 0.0000, 0.0000, 0.0000); //nu_plant_ofc
SetObjectMaterial(g_Object[115], 1, 630, "gta_potplants", "kb_teracota_pot64", 0xFFFFFFFF);
g_Object[116] = CreateObject(19786, 924.9046, -1475.9768, 2755.8620, 0.0000, 0.0000, 180.0000); //LCDTVBig1
SetObjectMaterial(g_Object[116], 0, 14570, "traidaqua", "ab_tv", 0xFFFFFFFF);
SetObjectMaterial(g_Object[116], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[117] = CreateObject(19825, 929.0645, -1475.8176, 2756.0183, 0.0000, 0.0000, 180.0000); //SprunkClock1
g_Object[118] = CreateObject(1708, 922.4799, -1472.6322, 2753.2717, 0.0000, 0.0000, 89.0000); //kb_chair02
SetObjectMaterial(g_Object[118], 1, 1746, "cj_sofa", "CJ_FAB4", 0xFFFFFFFF);
SetObjectMaterial(g_Object[118], 2, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[119] = CreateObject(1708, 922.4628, -1474.1623, 2753.2717, 0.0000, 0.0000, 89.0000); //kb_chair02
SetObjectMaterial(g_Object[119], 1, 1746, "cj_sofa", "CJ_FAB4", 0xFFFFFFFF);
SetObjectMaterial(g_Object[119], 2, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[120] = CreateObject(1708, 927.5222, -1473.0107, 2753.2717, 0.0000, 0.0000, -90.0000); //kb_chair02
SetObjectMaterial(g_Object[120], 1, 1746, "cj_sofa", "CJ_FAB4", 0xFFFFFFFF);
SetObjectMaterial(g_Object[120], 2, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[121] = CreateObject(1708, 927.5123, -1471.4803, 2753.2717, 0.0000, 0.0000, -90.0000); //kb_chair02
SetObjectMaterial(g_Object[121], 1, 1746, "cj_sofa", "CJ_FAB4", 0xFFFFFFFF);
SetObjectMaterial(g_Object[121], 2, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[122] = CreateObject(955, 930.7802, -1473.5239, 2753.6857, 0.0000, 0.0000, 270.0000); //CJ_EXT_SPRUNK
g_Object[123] = CreateObject(956, 930.8322, -1474.9178, 2753.7165, 0.0000, 0.0000, 270.0000); //CJ_EXT_CANDY
g_Object[124] = CreateObject(2816, 924.3339, -1472.9720, 2753.8125, 0.0000, 0.0000, 0.0000); //gb_bedmags01
g_Object[125] = CreateObject(2855, 925.5050, -1472.9338, 2753.8032, 0.0000, 0.0000, -48.0000); //gb_bedmags05
g_Object[126] = CreateObject(19450, 927.4669, -1461.8607, 2752.3906, 90.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[126], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[127] = CreateObject(18762, 920.9376, -1463.0930, 2754.7031, 0.0000, 0.0000, 0.0000); //Concrete1mx1mx5m
SetObjectMaterial(g_Object[127], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[128] = CreateObject(19450, 922.2877, -1463.5218, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[128], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[129] = CreateObject(19174, 924.0399, -1463.6440, 2755.5251, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[129], "Los Santos", 0, 90, "Times New Roman", 25, 1, 0xFFA5A9A7, 0x0, 1);
SetObjectMaterial(g_Object[129], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[130] = CreateObject(19174, 924.0399, -1463.6440, 2755.8454, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[130], "Cityhall", 0, 90, "Times New Roman", 40, 1, 0xFFA5A9A7, 0x0, 1);
SetObjectMaterial(g_Object[130], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[131] = CreateObject(19385, 927.4738, -1458.5091, 2755.0256, 0.0000, 0.0000, 0.0000); //wall033
SetObjectMaterial(g_Object[131], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[132] = CreateObject(1569, 927.4956, -1459.2479, 2753.2839, 0.0000, 0.0000, -48.7999); //ADAM_V_DOOR
g_Object[133] = CreateObject(19174, 918.8895, -1462.8747, 2756.3559, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[133], "i", 0, 90, "Webdings", 70, 1, 0xFFA5A9A7, 0x0, 1);
SetObjectMaterial(g_Object[133], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[134] = CreateObject(18981, 918.0518, -1454.1363, 2757.7150, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[134], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[135] = CreateObject(18981, 897.3908, -1463.8270, 2757.7150, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[135], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[136] = CreateObject(18981, 943.0202, -1463.8270, 2757.7150, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[136], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[137] = CreateObject(19464, 934.9027, -1464.8940, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[137], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[138] = CreateObject(18981, 923.0510, -1463.5339, 2752.8317, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[138], 0, 15034, "genhotelsave", "bathtile05_int", 0xFFFFFFFF);
g_Object[139] = CreateObject(19450, 922.7360, -1464.6108, 2753.2529, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[139], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[140] = CreateObject(19464, 934.1234, -1472.8424, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[140], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[141] = CreateObject(19464, 934.9027, -1470.8310, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[141], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[142] = CreateObject(1753, 934.0222, -1472.2602, 2753.2915, 0.0000, 0.0000, 180.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[142], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[143] = CreateObject(3034, 934.7407, -1465.0699, 2755.4609, 0.0000, 0.0000, -90.0000); //bd_window
SetObjectMaterial(g_Object[143], 0, 9901, "ferry_building", "skylight_windows", 0xFFFFFFFF);
g_Object[144] = CreateObject(19430, 934.8759, -1466.7534, 2757.2348, 90.0000, 0.0000, 0.0000); //wall070
SetObjectMaterial(g_Object[144], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[145] = CreateObject(19450, 925.7769, -1463.5218, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[145], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[146] = CreateObject(19430, 934.8759, -1462.4420, 2757.2348, 90.0000, 0.0000, 0.0000); //wall070
SetObjectMaterial(g_Object[146], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[147] = CreateObject(19174, 934.7780, -1459.5168, 2755.6752, 0.0000, 0.0000, 270.0000); //SAMPPicture3
SetObjectMaterial(g_Object[147], 0, 2266, "picture_frame", "CJ_PAINTING16", 0xFFFFFFFF);
g_Object[148] = CreateObject(19174, 934.7780, -1470.5576, 2755.6752, 0.0000, 0.0000, 270.0000); //SAMPPicture3
SetObjectMaterial(g_Object[148], 0, 2254, "picture_frame_clip", "CJ_PAINTING15", 0xFFFFFFFF);
g_Object[149] = CreateObject(19450, 933.2952, -1476.0218, 2753.2500, 0.0000, 90.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[149], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[150] = CreateObject(19450, 906.5750, -1476.0218, 2753.2500, 0.0000, 90.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[150], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[151] = CreateObject(19450, 913.1157, -1472.9416, 2753.2800, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[151], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[152] = CreateObject(3051, 929.1109, -1457.0914, 2754.6354, 0.0000, 0.0000, -43.9000); //lift_dr
SetObjectMaterial(g_Object[152], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[153] = CreateObject(3051, 930.3195, -1457.1086, 2754.6354, 0.0000, 0.0000, 134.6999); //lift_dr
SetObjectMaterial(g_Object[153], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[154] = CreateObject(3051, 933.3319, -1457.0992, 2754.6354, 0.0000, 0.0000, 136.6000); //lift_dr
SetObjectMaterial(g_Object[154], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[155] = CreateObject(3051, 932.1450, -1457.0965, 2754.6354, 0.0000, 0.0000, -43.9000); //lift_dr
SetObjectMaterial(g_Object[155], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[156] = CreateObject(19174, 930.0083, -1457.0837, 2754.9841, 0.0000, 180.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[156], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[156], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[157] = CreateObject(19174, 932.4487, -1457.0837, 2754.0231, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[157], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[157], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[158] = CreateObject(19464, 934.9027, -1458.9647, 2755.7070, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[158], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[159] = CreateObject(18766, 925.5288, -1463.5604, 2758.5424, 90.0000, 90.0000, 90.0000); //Concrete10mx1mx5m
SetObjectMaterial(g_Object[159], 0, 10765, "airportgnd_sfse", "white", 0xFFBDBEC6);
g_Object[160] = CreateObject(19464, 931.9254, -1456.9621, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[160], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[161] = CreateObject(19464, 926.0551, -1456.9422, 2755.7070, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[161], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[162] = CreateObject(18766, 914.8186, -1463.5604, 2758.5424, 90.0000, 90.0000, 90.0000); //Concrete10mx1mx5m
SetObjectMaterial(g_Object[162], 0, 10765, "airportgnd_sfse", "white", 0xFFBDBEC6);
g_Object[163] = CreateObject(18766, 924.1887, -1463.5604, 2758.5424, 90.0000, 90.0000, 90.0000); //Concrete10mx1mx5m
SetObjectMaterial(g_Object[163], 0, 10765, "airportgnd_sfse", "white", 0xFFBDBEC6);
g_Object[164] = CreateObject(18766, 907.2075, -1470.9383, 2758.5424, 90.0000, 90.0000, 0.0000); //Concrete10mx1mx5m
SetObjectMaterial(g_Object[164], 0, 10765, "airportgnd_sfse", "white", 0xFFBDBEC6);
g_Object[165] = CreateObject(18766, 907.3577, -1461.0788, 2758.5424, 90.0000, 90.0000, 0.0000); //Concrete10mx1mx5m
SetObjectMaterial(g_Object[165], 0, 10765, "airportgnd_sfse", "white", 0xFFBDBEC6);
g_Object[166] = CreateObject(18766, 933.2080, -1470.9383, 2758.5424, 90.0000, 90.0000, 0.0000); //Concrete10mx1mx5m
SetObjectMaterial(g_Object[166], 0, 10765, "airportgnd_sfse", "white", 0xFFBDBEC6);
g_Object[167] = CreateObject(18981, 918.0518, -1454.1363, 2759.4965, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[167], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[168] = CreateObject(18981, 897.3908, -1463.8270, 2759.4863, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[168], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[169] = CreateObject(18981, 942.9807, -1463.8270, 2759.4863, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[169], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[170] = CreateObject(18762, 913.1666, -1473.9322, 2759.4521, 0.0000, 90.0000, 90.0000); //Concrete1mx1mx5m
SetObjectMaterial(g_Object[170], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[171] = CreateObject(18762, 913.1666, -1469.0615, 2759.4519, 0.0000, 90.0000, 90.0000); //Concrete1mx1mx5m
SetObjectMaterial(g_Object[171], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[172] = CreateObject(18762, 927.4771, -1473.9322, 2759.5019, 0.0000, 90.0000, 90.0000); //Concrete1mx1mx5m
SetObjectMaterial(g_Object[172], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[173] = CreateObject(18762, 927.4771, -1468.9621, 2759.5019, 0.0000, 90.0000, 90.0000); //Concrete1mx1mx5m
SetObjectMaterial(g_Object[173], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[174] = CreateObject(19464, 924.8234, -1475.9615, 2760.7905, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[174], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[175] = CreateObject(19464, 918.8933, -1475.9615, 2760.7905, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[175], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[176] = CreateObject(19464, 912.9534, -1475.9615, 2760.7905, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[176], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[177] = CreateObject(19464, 910.1743, -1475.9914, 2762.0214, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[177], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[178] = CreateObject(19464, 939.3153, -1475.9914, 2762.0214, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[178], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[179] = CreateObject(19464, 918.8933, -1476.1118, 2757.9890, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[179], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[180] = CreateObject(18766, 933.0078, -1461.0710, 2758.5424, 90.0000, 90.0000, 0.0000); //Concrete10mx1mx5m
SetObjectMaterial(g_Object[180], 0, 10765, "airportgnd_sfse", "white", 0xFFBDBEC6);
g_Object[181] = CreateObject(3858, 909.8286, -1473.8785, 2762.0288, 0.0000, 0.0000, -45.2000); //ottosmash1
SetObjectMaterial(g_Object[181], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[182] = CreateObject(3859, 912.4848, -1466.5985, 2762.0224, 0.0000, 0.0000, 106.8000); //ottosmash04
SetObjectMaterial(g_Object[182], 0, 1717, "cj_tv", "green_glass_64", 0xFF9F9D94);
g_Object[183] = CreateObject(3859, 917.5772, -1466.6174, 2762.0224, 0.0000, 0.0000, 106.8000); //ottosmash04
SetObjectMaterial(g_Object[183], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[184] = CreateObject(3859, 922.6889, -1466.6313, 2762.0224, 0.0000, 0.0000, 107.0998); //ottosmash04
SetObjectMaterial(g_Object[184], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[185] = CreateObject(3858, 930.5883, -1473.8929, 2762.0288, 0.0000, 0.0000, -44.7000); //ottosmash1
SetObjectMaterial(g_Object[185], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[186] = CreateObject(1897, 920.0504, -1466.5904, 2761.1047, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[187] = CreateObject(1897, 920.0504, -1466.5904, 2763.3256, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[188] = CreateObject(1897, 920.0504, -1466.5904, 2763.8161, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[189] = CreateObject(1897, 925.1815, -1466.5904, 2763.8161, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[190] = CreateObject(1897, 925.1810, -1466.5904, 2763.3256, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[191] = CreateObject(1897, 925.1810, -1466.5904, 2761.1057, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[192] = CreateObject(1897, 930.4218, -1466.5904, 2761.1047, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[193] = CreateObject(1897, 930.4212, -1466.5904, 2763.3256, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[194] = CreateObject(1897, 930.4212, -1466.5904, 2763.8161, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[195] = CreateObject(1897, 914.9406, -1466.5904, 2763.8161, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[196] = CreateObject(1897, 914.9406, -1466.5904, 2763.3256, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[197] = CreateObject(1897, 914.9412, -1466.5904, 2761.1057, 0.0000, 0.0000, -90.0000); //wheel_support
g_Object[198] = CreateObject(1897, 909.9411, -1466.5904, 2761.1057, 0.0000, 0.0000, 90.0000); //wheel_support
g_Object[199] = CreateObject(1897, 909.9409, -1466.5904, 2763.3256, 0.0000, 0.0000, 90.0000); //wheel_support
g_Object[200] = CreateObject(1897, 909.9403, -1466.5904, 2763.8161, 0.0000, 0.0000, 90.0000); //wheel_support
g_Object[201] = CreateObject(19087, 914.9141, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[201], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[202] = CreateObject(19087, 912.5037, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[202], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[203] = CreateObject(19087, 917.4243, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[203], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[204] = CreateObject(19087, 919.8441, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[204], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[205] = CreateObject(19087, 922.2941, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[205], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[206] = CreateObject(19087, 924.7442, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[206], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[207] = CreateObject(19087, 927.1638, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[207], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[208] = CreateObject(19087, 929.5642, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[208], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[209] = CreateObject(19087, 930.3847, -1466.5832, 2764.9125, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[209], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[210] = CreateObject(19087, 930.3350, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[210], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[211] = CreateObject(19087, 927.8847, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[211], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[212] = CreateObject(19087, 925.4448, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[212], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[213] = CreateObject(1897, 909.8302, -1475.7408, 2763.8161, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[214] = CreateObject(19087, 920.5443, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[214], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[215] = CreateObject(19087, 918.1032, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[215], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[216] = CreateObject(19087, 915.6630, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[216], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[217] = CreateObject(19087, 913.2529, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[217], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[218] = CreateObject(19087, 912.5025, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[218], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[219] = CreateObject(19087, 912.5025, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[219], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[220] = CreateObject(19087, 914.9229, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[220], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[221] = CreateObject(19087, 917.5131, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[221], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[222] = CreateObject(19087, 919.9437, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[222], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[223] = CreateObject(19087, 922.6140, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[223], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[224] = CreateObject(19087, 925.0349, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[224], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[225] = CreateObject(19087, 927.4047, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[225], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[226] = CreateObject(19087, 929.8048, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[226], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[227] = CreateObject(19087, 930.3850, -1466.5832, 2762.2011, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[227], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[228] = CreateObject(19087, 923.0048, -1466.5832, 2764.4221, 0.0000, 90.0000, 0.0000); //Rope1
SetObjectMaterial(g_Object[228], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[229] = CreateObject(1897, 909.8308, -1475.7419, 2763.3256, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[230] = CreateObject(1897, 909.8308, -1475.7419, 2761.1062, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[231] = CreateObject(1897, 909.8308, -1471.2009, 2761.1062, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[232] = CreateObject(1897, 909.8308, -1471.2010, 2763.3256, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[233] = CreateObject(1897, 909.8302, -1471.2004, 2763.8161, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[234] = CreateObject(19087, 909.8543, -1468.6241, 2764.4221, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[234], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[235] = CreateObject(19087, 909.8543, -1466.6048, 2764.4221, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[235], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[236] = CreateObject(19087, 909.8543, -1471.3337, 2764.4221, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[236], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[237] = CreateObject(19087, 909.8543, -1473.1749, 2764.4221, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[237], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[238] = CreateObject(19087, 909.8543, -1473.1749, 2764.9125, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[238], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[239] = CreateObject(19087, 909.8543, -1470.7441, 2764.9125, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[239], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[240] = CreateObject(19087, 909.8543, -1468.3044, 2764.9125, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[240], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[241] = CreateObject(19087, 909.8543, -1466.6335, 2764.9125, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[241], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[242] = CreateObject(19087, 909.8543, -1473.2651, 2762.2016, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[242], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[243] = CreateObject(19087, 909.8543, -1470.8254, 2762.2016, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[243], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[244] = CreateObject(19087, 909.8543, -1468.4858, 2762.2016, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[244], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[245] = CreateObject(19087, 909.8543, -1466.6445, 2762.2016, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[245], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[246] = CreateObject(3859, 927.8892, -1466.6334, 2762.0224, 0.0000, 0.0000, 107.0998); //ottosmash04
SetObjectMaterial(g_Object[246], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[247] = CreateObject(1897, 930.5916, -1471.2004, 2763.8161, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[248] = CreateObject(1897, 930.5916, -1471.2010, 2763.3256, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[249] = CreateObject(1897, 930.5913, -1471.2009, 2761.1062, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[250] = CreateObject(1897, 930.5913, -1475.7423, 2761.1062, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[251] = CreateObject(1897, 930.5905, -1475.7419, 2763.3256, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[252] = CreateObject(1897, 930.5902, -1475.7408, 2763.8161, 0.0000, 0.0000, 180.0000); //wheel_support
g_Object[253] = CreateObject(19087, 930.5562, -1466.6445, 2762.2016, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[253], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[254] = CreateObject(19087, 930.5562, -1468.9952, 2762.2016, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[254], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[255] = CreateObject(19087, 930.5562, -1471.4339, 2762.2016, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[255], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[256] = CreateObject(19087, 930.5562, -1473.8431, 2762.2016, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[256], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[257] = CreateObject(19087, 930.5562, -1473.8431, 2764.4338, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[257], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[258] = CreateObject(19087, 930.5562, -1471.3935, 2764.4338, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[258], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[259] = CreateObject(19087, 930.5562, -1469.0124, 2764.4338, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[259], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[260] = CreateObject(19087, 930.5562, -1466.5511, 2764.4338, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[260], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[261] = CreateObject(19087, 930.5562, -1466.5511, 2764.9143, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[261], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[262] = CreateObject(19087, 930.5562, -1468.9724, 2764.9143, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[262], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[263] = CreateObject(19087, 930.5562, -1471.3735, 2764.9143, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[263], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[264] = CreateObject(19087, 930.5562, -1473.8155, 2764.9143, 0.0000, 90.0000, 90.0000); //Rope1
SetObjectMaterial(g_Object[264], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[265] = CreateObject(19565, 929.9935, -1457.1499, 2756.6357, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[265], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[266] = CreateObject(19565, 932.5051, -1457.1499, 2756.6357, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[266], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[267] = CreateObject(19565, 932.8754, -1457.1499, 2756.6357, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[267], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[268] = CreateObject(19565, 929.6226, -1457.1499, 2756.4155, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[268], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[269] = CreateObject(19565, 929.9931, -1457.1499, 2756.4155, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[269], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[270] = CreateObject(19565, 932.5037, -1457.1499, 2756.4155, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[270], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[271] = CreateObject(19565, 932.8837, -1457.1499, 2756.4155, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[271], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[272] = CreateObject(19174, 929.8189, -1457.1361, 2756.5361, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[272], "1. Stock", 0, 90, "Arial Black", 14, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[272], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[273] = CreateObject(19174, 932.6793, -1457.1361, 2756.5361, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[273], "1. Stock", 0, 90, "Arial Black", 14, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[273], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[274] = CreateObject(19565, 929.4240, -1456.9095, 2756.3754, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[274], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[275] = CreateObject(19565, 930.1942, -1456.9095, 2756.3754, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[275], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[276] = CreateObject(19565, 932.2946, -1456.9095, 2756.3754, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[276], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[277] = CreateObject(19565, 933.0853, -1456.9095, 2756.3754, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[277], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[278] = CreateObject(11711, 920.2321, -1475.9582, 2756.0922, 0.0000, 0.0000, 0.0000); //ExitSign1
g_Object[279] = CreateObject(19450, 915.3059, -1457.0123, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[279], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[280] = CreateObject(19450, 913.4359, -1457.0023, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[280], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[281] = CreateObject(19450, 925.8062, -1456.9923, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[281], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[282] = CreateObject(19450, 922.7467, -1457.0123, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[282], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[283] = CreateObject(19450, 918.8057, -1457.0223, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[283], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[284] = CreateObject(19450, 916.5449, -1461.1208, 2753.2600, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[284], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[285] = CreateObject(19450, 916.5449, -1457.8409, 2753.2500, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[285], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[286] = CreateObject(19450, 922.7354, -1461.1175, 2753.2500, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[286], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[287] = CreateObject(19450, 922.7354, -1457.6269, 2753.2600, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[287], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[288] = CreateObject(19450, 922.2871, -1457.0223, 2752.3906, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[288], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF3D4A68);
g_Object[289] = CreateObject(19430, 918.8248, -1462.7816, 2757.2348, 90.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[289], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF46597A);
g_Object[290] = CreateObject(2162, 923.5117, -1463.4350, 2753.2990, 0.0000, 0.0000, -180.0000); //MED_OFFICE_UNIT_1
g_Object[291] = CreateObject(2162, 915.5119, -1463.4350, 2753.2990, 0.0000, 0.0000, -180.0000); //MED_OFFICE_UNIT_1
g_Object[292] = CreateObject(2162, 913.4514, -1463.4350, 2753.2990, 0.0000, 0.0000, -180.0000); //MED_OFFICE_UNIT_1
g_Object[293] = CreateObject(2199, 927.3060, -1460.9044, 2753.1269, 0.0000, 0.0000, 270.0000); //MED_OFFICE6_MC_1
SetObjectMaterial(g_Object[293], 2, 14650, "ab_trukstpc", "sa_wood08_128", 0xFFFFFFFF);
g_Object[294] = CreateObject(2199, 911.9057, -1461.3148, 2753.1269, 0.0000, 0.0000, 90.0000); //MED_OFFICE6_MC_1
SetObjectMaterial(g_Object[294], 2, 14650, "ab_trukstpc", "sa_wood08_128", 0xFFFFFFFF);
g_Object[295] = CreateObject(1671, 918.5828, -1460.8330, 2753.7797, 0.0000, 0.0000, 0.0000); //swivelchair_A
g_Object[296] = CreateObject(2817, 914.6895, -1473.4670, 2753.7687, 0.0000, 0.0000, 0.0000); //gb_bedrug01
SetObjectMaterial(g_Object[296], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[297] = CreateObject(2817, 914.6895, -1473.4670, 2753.8088, 0.0000, 0.0000, 0.0000); //gb_bedrug01
SetObjectMaterial(g_Object[297], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[298] = CreateObject(2817, 914.6895, -1473.4770, 2753.7687, 0.0000, 0.0000, 0.0000); //gb_bedrug01
SetObjectMaterial(g_Object[298], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[299] = CreateObject(2817, 924.4199, -1473.4770, 2753.7687, 0.0000, 0.0000, 0.0000); //gb_bedrug01
SetObjectMaterial(g_Object[299], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[300] = CreateObject(2817, 924.4199, -1473.4770, 2753.7988, 0.0000, 0.0000, 0.0000); //gb_bedrug01
SetObjectMaterial(g_Object[300], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[301] = CreateObject(1999, 919.2733, -1462.1870, 2753.2299, 0.0000, 0.0000, 180.0000); //officedesk2
SetObjectMaterial(g_Object[301], 0, 18232, "cw_truckstopcs_t", "des_roswin3", 0xFFFFFFFF);
SetObjectMaterial(g_Object[301], 1, 14802, "lee_bdupsflat", "Bdup_table", 0xFFFFFFFF);
SetObjectMaterial(g_Object[301], 2, 14802, "lee_bdupsflat", "Bdup_table", 0xFFFFFFFF);
g_Object[302] = CreateObject(2163, 924.7196, -1456.9438, 2754.5229, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_2
g_Object[303] = CreateObject(2163, 922.4096, -1456.9438, 2754.5229, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_2
g_Object[304] = CreateObject(2163, 913.0283, -1456.9438, 2754.5229, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_2
g_Object[305] = CreateObject(2163, 915.2387, -1456.9438, 2754.5229, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_2
g_Object[306] = CreateObject(19825, 919.1264, -1457.1561, 2756.2692, 0.0000, 0.0000, 0.0000); //SprunkClock1
g_Object[307] = CreateObject(2200, 918.3737, -1457.1142, 2753.3464, 0.0000, 0.0000, 0.0000); //MED_OFFICE5_UNIT_1
g_Object[308] = CreateObject(16780, 914.5795, -1460.3094, 2757.3347, 0.0000, 0.0000, 0.0000); //ufo_light03
g_Object[309] = CreateObject(16780, 923.9711, -1460.3094, 2757.3347, 0.0000, 0.0000, 0.0000); //ufo_light03
g_Object[310] = CreateObject(14687, 921.2670, -1462.5118, 2755.5612, 0.0000, 0.0000, 0.0000); //Int_tat_lights02
g_Object[311] = CreateObject(14687, 934.2390, -1458.7705, 2755.5612, 0.0000, 0.0000, 90.0000); //Int_tat_lights02
g_Object[312] = CreateObject(14687, 934.2490, -1463.6103, 2755.5612, 0.0000, 0.0000, 90.0000); //Int_tat_lights02
g_Object[313] = CreateObject(14687, 934.2188, -1468.0317, 2755.5612, 0.0000, 0.0000, 90.0000); //Int_tat_lights02
g_Object[314] = CreateObject(14687, 910.8579, -1463.6103, 2755.5612, 0.0000, 0.0000, 90.0000); //Int_tat_lights02
g_Object[315] = CreateObject(14687, 910.8579, -1458.7292, 2755.5612, 0.0000, 0.0000, 90.0000); //Int_tat_lights02
g_Object[316] = CreateObject(14687, 910.8579, -1468.0600, 2755.5612, 0.0000, 0.0000, 90.0000); //Int_tat_lights02
g_Object[317] = CreateObject(14687, 926.0379, -1465.9333, 2755.5612, 0.0000, 0.0000, 0.0000); //Int_tat_lights02
g_Object[318] = CreateObject(14687, 916.5460, -1465.9333, 2755.5612, 0.0000, 0.0000, 0.0000); //Int_tat_lights02
g_Object[319] = CreateObject(3051, 910.3054, -1457.1009, 2761.3532, 0.0000, 0.0000, 135.6000); //lift_dr
SetObjectMaterial(g_Object[319], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[320] = CreateObject(3051, 907.3848, -1457.0985, 2761.3666, 0.0000, 0.0000, 135.6000); //lift_dr
SetObjectMaterial(g_Object[320], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[321] = CreateObject(3051, 909.0891, -1457.1036, 2761.3569, 0.0000, 0.0000, -43.9000); //lift_dr
SetObjectMaterial(g_Object[321], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[322] = CreateObject(3051, 906.1680, -1457.0931, 2761.3669, 0.0000, 0.0000, -43.9000); //lift_dr
SetObjectMaterial(g_Object[322], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[323] = CreateObject(3051, 929.1109, -1457.0914, 2761.3395, 0.0000, 0.0000, -43.9000); //lift_dr
SetObjectMaterial(g_Object[323], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[324] = CreateObject(3051, 930.3195, -1457.1086, 2761.3398, 0.0000, 0.0000, 134.6999); //lift_dr
SetObjectMaterial(g_Object[324], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[325] = CreateObject(3051, 933.3319, -1457.0992, 2761.3481, 0.0000, 0.0000, 136.6000); //lift_dr
SetObjectMaterial(g_Object[325], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[326] = CreateObject(3051, 932.1450, -1457.0965, 2761.3471, 0.0000, 0.0000, -43.9000); //lift_dr
SetObjectMaterial(g_Object[326], 0, 10023, "bigwhitesfe", "liftdoors_kb_256", 0xFFFFFFFF);
g_Object[327] = CreateObject(19464, 932.2858, -1456.9621, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[327], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[328] = CreateObject(19464, 930.2645, -1456.9421, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[328], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[329] = CreateObject(19464, 907.3543, -1456.9421, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[329], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[330] = CreateObject(19464, 909.2437, -1456.9521, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[330], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[331] = CreateObject(19174, 930.0083, -1457.0837, 2761.5593, 0.0000, 180.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[331], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[331], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[332] = CreateObject(19174, 907.0269, -1457.0837, 2761.5593, 0.0000, 180.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[332], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[332], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[333] = CreateObject(19174, 909.4674, -1457.0837, 2760.6384, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[333], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[333], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[334] = CreateObject(19174, 932.4478, -1457.0837, 2760.6384, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[334], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[334], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[335] = CreateObject(19174, 932.7396, -1457.1361, 2763.1921, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[335], "E.G.", 0, 90, "Arial Black", 20, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[335], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[336] = CreateObject(19174, 906.8192, -1457.1361, 2763.1921, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[336], "E.G.", 0, 90, "Arial Black", 20, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[336], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[337] = CreateObject(19174, 909.7092, -1457.1361, 2763.1921, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[337], "E.G.", 0, 90, "Arial Black", 20, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[337], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[338] = CreateObject(19565, 907.0526, -1457.1499, 2763.0705, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[338], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[339] = CreateObject(19565, 906.5822, -1457.1499, 2763.0705, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[339], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[340] = CreateObject(19565, 909.5128, -1457.1499, 2763.0705, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[340], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[341] = CreateObject(19565, 909.9533, -1457.1499, 2763.0705, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[341], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[342] = CreateObject(19565, 909.9533, -1457.1499, 2763.3208, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[342], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[343] = CreateObject(19565, 909.5128, -1457.1499, 2763.3208, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[343], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[344] = CreateObject(19565, 907.0526, -1457.1499, 2763.3208, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[344], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[345] = CreateObject(19565, 906.5825, -1457.1499, 2763.3208, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[345], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[346] = CreateObject(19565, 929.6544, -1457.1499, 2763.3208, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[346], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[347] = CreateObject(19565, 930.0045, -1457.1499, 2763.3208, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[347], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[348] = CreateObject(19565, 932.5454, -1457.1499, 2763.3208, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[348], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[349] = CreateObject(19565, 932.9459, -1457.1499, 2763.3208, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[349], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[350] = CreateObject(19565, 932.9459, -1457.1499, 2763.0905, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[350], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[351] = CreateObject(19565, 932.5454, -1457.1499, 2763.0905, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[351], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[352] = CreateObject(19565, 929.9940, -1457.1499, 2763.0905, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[352], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[353] = CreateObject(19565, 929.6536, -1457.1499, 2763.0905, 90.0000, 90.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[353], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[354] = CreateObject(19565, 929.4539, -1456.9095, 2763.0720, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[354], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[355] = CreateObject(19565, 930.2045, -1456.9095, 2763.0720, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[355], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[356] = CreateObject(19565, 932.3449, -1456.9095, 2763.0720, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[356], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[357] = CreateObject(19565, 933.1455, -1456.9095, 2763.0720, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[357], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[358] = CreateObject(19565, 910.1544, -1456.9095, 2763.0720, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[358], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[359] = CreateObject(19565, 909.3046, -1456.9095, 2763.0720, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[359], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[360] = CreateObject(19565, 907.2540, -1456.9095, 2763.0720, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[360], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[361] = CreateObject(19565, 906.3842, -1456.9095, 2763.0720, 0.0000, 0.0000, 90.0000); //IceCreamBarsBox1
SetObjectMaterial(g_Object[361], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[362] = CreateObject(19387, 922.6312, -1457.0212, 2761.6650, 0.0000, 0.0000, 90.0000); //wall035
SetObjectMaterial(g_Object[362], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[363] = CreateObject(19464, 917.4323, -1456.9128, 2765.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[363], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[364] = CreateObject(19464, 927.1738, -1456.9331, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[364], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[365] = CreateObject(19464, 911.5225, -1456.9331, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[365], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[366] = CreateObject(19464, 921.2628, -1456.9331, 2765.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[366], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[367] = CreateObject(19387, 916.0405, -1457.0412, 2761.6650, 0.0000, 0.0000, 90.0000); //wall035
SetObjectMaterial(g_Object[367], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[368] = CreateObject(19174, 921.0272, -1457.1136, 2761.4895, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[368], "Damen ", 0, 90, "Arial", 15, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[368], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[369] = CreateObject(1753, 925.3228, -1457.5426, 2759.9807, 0.0000, 0.0000, 0.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[369], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[370] = CreateObject(1753, 911.7719, -1457.5426, 2759.9807, 0.0000, 0.0000, 0.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[370], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[371] = CreateObject(19464, 938.5679, -1461.3734, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[371], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[372] = CreateObject(19464, 901.4240, -1456.9521, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[372], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[373] = CreateObject(19464, 901.0338, -1466.3739, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[373], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[374] = CreateObject(19464, 901.0341, -1458.5622, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[374], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[375] = CreateObject(19387, 938.5313, -1465.9105, 2761.6650, 0.0000, 0.0000, 0.0000); //wall035
SetObjectMaterial(g_Object[375], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[376] = CreateObject(3858, 927.8206, -1473.8166, 2764.9653, -45.5998, 90.0000, 0.0000); //ottosmash1
SetObjectMaterial(g_Object[376], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[377] = CreateObject(3858, 922.0006, -1473.8166, 2764.9653, -45.5998, 90.0000, 0.0000); //ottosmash1
SetObjectMaterial(g_Object[377], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[378] = CreateObject(3858, 916.1806, -1473.8166, 2764.9653, -45.5998, 90.0000, 0.0000); //ottosmash1
SetObjectMaterial(g_Object[378], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[379] = CreateObject(3858, 910.3609, -1473.8166, 2764.9653, -45.5998, 90.0000, 0.0000); //ottosmash1
SetObjectMaterial(g_Object[379], 0, 1717, "cj_tv", "green_glass_64", 0xFFFFFFFF);
g_Object[380] = CreateObject(18981, 897.3908, -1463.8270, 2765.3720, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[380], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[381] = CreateObject(18981, 943.0200, -1463.8270, 2765.3720, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[381], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[382] = CreateObject(18981, 920.8698, -1454.0860, 2765.3720, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[382], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[383] = CreateObject(19430, 911.7835, -1458.6311, 2757.2348, 90.0000, 0.0000, 0.0000); //wall070
SetObjectMaterial(g_Object[383], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF46597A);
g_Object[384] = CreateObject(19430, 927.4541, -1458.6311, 2757.2348, 90.0000, 0.0000, 0.0000); //wall070
SetObjectMaterial(g_Object[384], 0, 1376, "cranes_dyn2_cj", "ws_oldpaintedblue", 0xFF46597A);
g_Object[385] = CreateObject(18981, 897.3609, -1463.8270, 2759.5163, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[385], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[386] = CreateObject(18981, 943.0114, -1463.8270, 2759.5163, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[386], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[387] = CreateObject(18981, 919.9412, -1454.1279, 2759.5063, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[387], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[388] = CreateObject(19464, 901.0340, -1473.3723, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[388], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[389] = CreateObject(19464, 938.5737, -1473.3653, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[389], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[390] = CreateObject(19464, 938.5720, -1470.4040, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[390], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[391] = CreateObject(19464, 938.5689, -1466.2845, 2765.8708, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[391], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[392] = CreateObject(19464, 938.1936, -1456.9521, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[392], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[393] = CreateObject(19464, 938.5936, -1455.4936, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[393], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[394] = CreateObject(19464, 934.8054, -1476.1616, 2762.3205, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[394], 0, 14801, "lee_bdupsmain", "Bdup_Blinds", 0xFFFFFFFF);
g_Object[395] = CreateObject(19464, 905.7351, -1476.1616, 2762.3205, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[395], 0, 14801, "lee_bdupsmain", "Bdup_Blinds", 0xFFFFFFFF);
g_Object[396] = CreateObject(19464, 900.7233, -1475.9814, 2762.0214, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[396], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[397] = CreateObject(19464, 912.9534, -1475.9814, 2762.4321, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[397], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[398] = CreateObject(19464, 918.8842, -1475.9814, 2762.4321, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[398], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[399] = CreateObject(19464, 924.8151, -1475.9814, 2762.4321, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[399], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[400] = CreateObject(19464, 929.9545, -1475.9914, 2762.0214, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[400], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[401] = CreateObject(19464, 929.9545, -1475.9914, 2756.0769, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[401], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[402] = CreateObject(19464, 907.5247, -1475.9914, 2756.1970, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[402], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[403] = CreateObject(1753, 937.9417, -1468.2910, 2759.9807, 0.0000, 0.0000, -90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[403], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[404] = CreateObject(1753, 937.9417, -1459.7016, 2759.9807, 0.0000, 0.0000, -90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[404], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[405] = CreateObject(1753, 937.9417, -1472.6518, 2759.9807, 0.0000, 0.0000, -90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[405], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[406] = CreateObject(1753, 901.6710, -1475.1933, 2759.9807, 0.0000, 0.0000, 90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[406], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[407] = CreateObject(1753, 901.6710, -1471.3133, 2759.9807, 0.0000, 0.0000, 90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[407], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[408] = CreateObject(19464, 901.0339, -1470.4338, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[408], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[409] = CreateObject(19464, 901.0319, -1461.3629, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[409], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[410] = CreateObject(19786, 901.1464, -1470.2236, 2762.4023, 0.0000, 0.0000, 90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[410], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
SetObjectMaterial(g_Object[410], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[411] = CreateObject(19786, 901.1464, -1474.1933, 2762.4023, 0.0000, 0.0000, 90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[411], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
SetObjectMaterial(g_Object[411], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[412] = CreateObject(19786, 901.1464, -1460.6839, 2762.4023, 0.0000, 0.0000, 90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[412], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
SetObjectMaterial(g_Object[412], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[413] = CreateObject(1753, 901.6710, -1461.7126, 2759.9807, 0.0000, 0.0000, 90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[413], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[414] = CreateObject(19786, 938.5164, -1460.6839, 2762.4023, 0.0000, 0.0000, -90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[414], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
SetObjectMaterial(g_Object[414], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[415] = CreateObject(19786, 938.5164, -1469.3752, 2762.4023, 0.0000, 0.0000, -90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[415], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
SetObjectMaterial(g_Object[415], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[416] = CreateObject(19786, 938.5164, -1473.5050, 2762.4023, 0.0000, 0.0000, -90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[416], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
SetObjectMaterial(g_Object[416], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[417] = CreateObject(2002, 937.9525, -1471.5343, 2759.9567, 0.0000, 0.0000, -90.0000); //water_coolnu
g_Object[418] = CreateObject(2002, 901.6923, -1472.2650, 2759.9567, 0.0000, 0.0000, 90.0000); //water_coolnu
g_Object[419] = CreateObject(948, 901.5866, -1462.8619, 2759.9685, 0.0000, 0.0000, 0.0000); //Plant_Pot_10
g_Object[420] = CreateObject(948, 901.5866, -1458.4813, 2759.9685, 0.0000, 0.0000, 0.0000); //Plant_Pot_10
g_Object[421] = CreateObject(948, 937.9970, -1458.4813, 2759.9685, 0.0000, 0.0000, 0.0000); //Plant_Pot_10
g_Object[422] = CreateObject(948, 937.9224, -1462.8619, 2759.9685, 0.0000, 0.0000, 0.0000); //Plant_Pot_10
g_Object[423] = CreateObject(2010, 920.5430, -1457.4154, 2759.9716, 0.0000, 0.0000, 0.0000); //nu_plant3_ofc
SetObjectMaterial(g_Object[423], 1, 6490, "tvstudio_law2", "tvstud03_LAw2", 0xFFFFFFFF);
g_Object[424] = CreateObject(2010, 918.2318, -1457.4154, 2759.9716, 0.0000, 0.0000, 0.0000); //nu_plant3_ofc
SetObjectMaterial(g_Object[424], 1, 6490, "tvstudio_law2", "tvstud03_LAw2", 0xFFFFFFFF);
g_Object[425] = CreateObject(19174, 920.0172, -1457.1037, 2760.9187, 0.0000, 90.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[425], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[425], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[426] = CreateObject(19174, 918.8164, -1457.0937, 2763.3608, 0.0000, -90.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[426], "y", 0, 90, "Wingdings", 25, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[426], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[427] = CreateObject(19174, 921.5076, -1457.1037, 2761.8898, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[427], "__", 0, 90, "Arial Black", 50, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[427], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[428] = CreateObject(19174, 919.6466, -1457.0937, 2761.8898, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[428], "__", 0, 90, "Arial Black", 50, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[428], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[429] = CreateObject(19464, 915.5947, -1475.9527, 2750.9528, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[429], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[430] = CreateObject(1491, 921.8579, -1457.0078, 2760.0092, 0.0000, 0.0000, 0.0000); //Gen_doorINT01
SetObjectMaterial(g_Object[430], 0, 18008, "intclothesa", "CJ_VICT_DOOR2", 0xFFFFFFFF);
g_Object[431] = CreateObject(19174, 920.1066, -1457.1335, 2761.4895, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[431], "Herren", 0, 90, "Arial", 15, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[431], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[432] = CreateObject(19174, 920.4569, -1457.1135, 2762.3503, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[432], "WC", 0, 90, "Arial Black", 50, 1, 0xFF000000, 0x0, 0);
SetObjectMaterial(g_Object[432], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[433] = CreateObject(1491, 915.2772, -1457.0078, 2760.0092, 0.0000, 0.0000, 0.0000); //Gen_doorINT01
SetObjectMaterial(g_Object[433], 0, 2878, "cj_vic", "CJ_VICT_DOOR", 0xFFFFFFFF);
g_Object[434] = CreateObject(19464, 909.6546, -1475.9527, 2750.9528, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[434], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[435] = CreateObject(19464, 919.3026, -1456.9830, 2760.4577, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[435], 0, 14847, "mp_policesf", "mp_cop_carpet", 0xFFFFFFFF);
g_Object[436] = CreateObject(19464, 924.8046, -1475.9527, 2750.9528, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[436], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[437] = CreateObject(19464, 930.7351, -1475.9527, 2750.9528, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[437], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[438] = CreateObject(19464, 931.2553, -1475.6628, 2750.9528, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[438], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[439] = CreateObject(19464, 909.0150, -1475.6628, 2750.9528, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[439], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[440] = CreateObject(19464, 906.1853, -1472.7926, 2750.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[440], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[441] = CreateObject(19464, 934.0755, -1472.7926, 2750.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[441], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[442] = CreateObject(19464, 902.6057, -1456.9630, 2750.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[442], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[443] = CreateObject(19464, 934.8853, -1464.3923, 2750.9729, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[443], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[444] = CreateObject(19464, 934.8853, -1458.4527, 2750.9729, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[444], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[445] = CreateObject(19464, 904.7053, -1458.9631, 2750.9729, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[445], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[446] = CreateObject(19464, 904.7053, -1469.7829, 2750.9729, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[446], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[447] = CreateObject(19464, 934.8853, -1470.3321, 2750.9729, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[447], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[448] = CreateObject(19464, 910.9254, -1456.9630, 2750.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[448], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[449] = CreateObject(19464, 936.8955, -1456.9630, 2750.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[449], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[450] = CreateObject(19464, 930.4655, -1456.9630, 2750.9729, 0.0000, 0.0000, 89.8999); //wall104
SetObjectMaterial(g_Object[450], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[451] = CreateObject(19464, 901.8554, -1461.8431, 2750.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[451], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[452] = CreateObject(19464, 901.8554, -1466.9239, 2750.9729, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[452], 0, 5042, "bombshop_las", "greymetal", 0xFFFFFFFF);
g_Object[453] = CreateObject(19089, 936.7622, -1476.0279, 2765.0139, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[453], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[454] = CreateObject(19089, 905.3505, -1476.0279, 2765.1140, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[454], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[455] = CreateObject(19464, 911.6925, -1448.0040, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[455], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[456] = CreateObject(19089, 934.6113, -1476.0279, 2765.1140, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[456], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[457] = CreateObject(19089, 932.5114, -1476.0279, 2765.1140, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[457], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[458] = CreateObject(19089, 935.6959, -1476.0279, 2764.8884, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[458], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[459] = CreateObject(19089, 907.6110, -1476.0279, 2765.1140, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[459], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[460] = CreateObject(19089, 903.2706, -1476.0279, 2765.1140, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[460], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[461] = CreateObject(19089, 933.5557, -1476.0279, 2764.8884, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[461], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[462] = CreateObject(18981, 918.2313, -1463.8270, 2765.3820, 0.0000, 90.0000, 0.0000); //Concrete1mx25mx25m
SetObjectMaterial(g_Object[462], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[463] = CreateObject(19464, 911.6925, -1453.9134, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[463], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[464] = CreateObject(18763, 911.5178, -1450.7408, 2758.4553, 0.0000, 0.0000, 0.0000); //Concrete3mx3mx5m
SetObjectMaterial(g_Object[464], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[465] = CreateObject(18763, 911.5178, -1454.4918, 2758.4553, 0.0000, 0.0000, 0.0000); //Concrete3mx3mx5m
SetObjectMaterial(g_Object[465], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[466] = CreateObject(2515, 912.4298, -1451.4028, 2761.0720, 0.0000, 0.0000, 90.0000); //CJ_BS_SINK
SetObjectMaterial(g_Object[466], 0, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
SetObjectMaterial(g_Object[466], 1, 11301, "carshow_sfse", "ws_rollerdoor_silver", 0xFFFFFFFF);
g_Object[467] = CreateObject(2515, 912.4298, -1450.0821, 2761.0720, 0.0000, 0.0000, 90.0000); //CJ_BS_SINK
SetObjectMaterial(g_Object[467], 0, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
SetObjectMaterial(g_Object[467], 1, 11301, "carshow_sfse", "ws_rollerdoor_silver", 0xFFFFFFFF);
g_Object[468] = CreateObject(2515, 912.4298, -1453.8331, 2761.0720, 0.0000, 0.0000, 90.0000); //CJ_BS_SINK
SetObjectMaterial(g_Object[468], 0, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
SetObjectMaterial(g_Object[468], 1, 11301, "carshow_sfse", "ws_rollerdoor_silver", 0xFFFFFFFF);
g_Object[469] = CreateObject(2515, 912.4298, -1455.2136, 2761.0720, 0.0000, 0.0000, 90.0000); //CJ_BS_SINK
SetObjectMaterial(g_Object[469], 0, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
SetObjectMaterial(g_Object[469], 1, 11301, "carshow_sfse", "ws_rollerdoor_silver", 0xFFFFFFFF);
g_Object[470] = CreateObject(19786, 926.8073, -1450.6240, 2762.2639, 0.0000, 0.0000, -90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[470], 0, 10765, "airportgnd_sfse", "white", 0xFF5E7072);
SetObjectMaterial(g_Object[470], 1, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
g_Object[471] = CreateObject(19786, 911.7078, -1454.4040, 2762.2639, 0.0000, 0.0000, 90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[471], 0, 10765, "airportgnd_sfse", "white", 0xFF5E7072);
SetObjectMaterial(g_Object[471], 1, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
g_Object[472] = CreateObject(19089, 906.5056, -1476.0279, 2764.8884, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[472], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[473] = CreateObject(19089, 904.2954, -1476.0279, 2764.8884, 0.0000, 0.0000, 0.0000); //Rope3
SetObjectMaterial(g_Object[473], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[474] = CreateObject(19786, 911.7078, -1450.7137, 2762.2639, 0.0000, 0.0000, 90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[474], 0, 10765, "airportgnd_sfse", "white", 0xFF5E7072);
SetObjectMaterial(g_Object[474], 1, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
g_Object[475] = CreateObject(19786, 926.8577, -1454.5439, 2762.2639, 0.0000, 0.0000, -90.0000); //LCDTVBig1
SetObjectMaterial(g_Object[475], 0, 10765, "airportgnd_sfse", "white", 0xFF5E7072);
SetObjectMaterial(g_Object[475], 1, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
g_Object[476] = CreateObject(2741, 911.9041, -1452.5372, 2761.9111, 0.0000, 0.0000, 90.0000); //CJ_SOAP_DISP
g_Object[477] = CreateObject(11706, 912.6079, -1452.6064, 2759.8071, 0.0000, 0.0000, 0.0000); //SmallWasteBin1
g_Object[478] = CreateObject(11707, 911.9008, -1448.4228, 2760.9423, 0.0000, 0.0000, 90.0000); //TowelRack1
g_Object[479] = CreateObject(11707, 913.8812, -1456.6722, 2760.9423, 0.0000, 0.0000, 180.0000); //TowelRack1
g_Object[480] = CreateObject(19464, 911.5319, -1456.8735, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[480], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[481] = CreateObject(19464, 917.4118, -1456.8935, 2765.9201, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[481], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[482] = CreateObject(19464, 923.3214, -1456.8935, 2765.9201, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[482], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[483] = CreateObject(19464, 919.2819, -1456.8735, 2762.5297, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[483], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[484] = CreateObject(19387, 922.6309, -1456.8415, 2761.6650, 0.0000, 0.0000, 90.0000); //wall035
SetObjectMaterial(g_Object[484], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[485] = CreateObject(19387, 916.0405, -1456.8415, 2761.6650, 0.0000, 0.0000, 90.0000); //wall035
SetObjectMaterial(g_Object[485], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[486] = CreateObject(19464, 919.2819, -1454.2237, 2762.5297, 90.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[486], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[487] = CreateObject(19464, 919.2819, -1449.1544, 2762.5297, 90.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[487], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[488] = CreateObject(2602, 918.8112, -1454.3535, 2760.4091, 0.0000, 0.0000, -92.0000); //Police_cell_Toilet
g_Object[489] = CreateObject(2602, 918.7774, -1452.1710, 2760.4091, 0.0000, 0.0000, -92.0000); //Police_cell_Toilet
g_Object[490] = CreateObject(2602, 918.7683, -1450.1290, 2760.4091, 0.0000, 0.0000, -92.0000); //Police_cell_Toilet
g_Object[491] = CreateObject(2528, 917.0606, -1445.8050, 2760.0144, 0.0000, 0.0000, 0.0000); //CJ_TOILET3
g_Object[492] = CreateObject(19464, 915.8820, -1445.1855, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[492], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[493] = CreateObject(19464, 912.8524, -1444.4643, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[493], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[494] = CreateObject(19464, 915.5230, -1444.4941, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[494], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[495] = CreateObject(1491, 916.2495, -1447.5289, 2759.9321, 0.0000, 0.0000, 0.0000); //Gen_doorINT01
g_Object[496] = CreateObject(1491, 913.3394, -1447.5289, 2759.9321, 0.0000, 0.0000, 0.0000); //Gen_doorINT01
g_Object[497] = CreateObject(19464, 920.3118, -1447.4841, 2762.5297, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[497], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[498] = CreateObject(19464, 910.8120, -1447.4841, 2762.5297, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[498], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[499] = CreateObject(19464, 915.2119, -1447.4741, 2765.3906, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[499], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[500] = CreateObject(19464, 918.5029, -1444.4145, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[500], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[501] = CreateObject(19430, 915.5341, -1447.5362, 2760.7014, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[501], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[502] = CreateObject(2528, 914.2509, -1445.7755, 2760.0144, 0.0000, 0.0000, 0.0000); //CJ_TOILET3
g_Object[503] = CreateObject(18075, 915.5850, -1450.0450, 2764.8454, 0.0000, 0.0000, 0.0000); //lightD
g_Object[504] = CreateObject(16779, 915.4411, -1452.3680, 2764.8708, 0.0000, 0.0000, 0.0000); //ufo_light02
g_Object[505] = CreateObject(19814, 911.8272, -1452.5699, 2761.1025, 0.0000, 0.0000, 90.0000); //ElectricalOutlet2
g_Object[506] = CreateObject(19814, 911.8272, -1452.5699, 2761.2126, 0.0000, 0.0000, 90.0000); //ElectricalOutlet2
g_Object[507] = CreateObject(19814, 911.8272, -1452.5699, 2760.9824, 0.0000, 0.0000, 90.0000); //ElectricalOutlet2
g_Object[508] = CreateObject(19464, 926.8728, -1453.9134, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[508], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[509] = CreateObject(19464, 926.7316, -1456.8741, 2762.5297, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[509], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[510] = CreateObject(11707, 924.6409, -1456.6822, 2760.9423, 0.0000, 0.0000, 180.0000); //TowelRack1
g_Object[511] = CreateObject(18763, 927.2877, -1454.4918, 2758.4553, 0.0000, 0.0000, 0.0000); //Concrete3mx3mx5m
SetObjectMaterial(g_Object[511], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[512] = CreateObject(18763, 927.2877, -1450.5815, 2758.4553, 0.0000, 0.0000, 0.0000); //Concrete3mx3mx5m
SetObjectMaterial(g_Object[512], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[513] = CreateObject(19464, 926.8828, -1448.0235, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[513], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[514] = CreateObject(2515, 926.2197, -1455.2136, 2761.0720, 0.0000, 0.0000, -90.0000); //CJ_BS_SINK
SetObjectMaterial(g_Object[514], 0, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
SetObjectMaterial(g_Object[514], 1, 11301, "carshow_sfse", "ws_rollerdoor_silver", 0xFFFFFFFF);
g_Object[515] = CreateObject(2515, 926.2197, -1453.7335, 2761.0720, 0.0000, 0.0000, -90.0000); //CJ_BS_SINK
SetObjectMaterial(g_Object[515], 0, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
SetObjectMaterial(g_Object[515], 1, 11301, "carshow_sfse", "ws_rollerdoor_silver", 0xFFFFFFFF);
g_Object[516] = CreateObject(2515, 926.2197, -1451.2635, 2761.0720, 0.0000, 0.0000, -90.0000); //CJ_BS_SINK
SetObjectMaterial(g_Object[516], 0, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
SetObjectMaterial(g_Object[516], 1, 11301, "carshow_sfse", "ws_rollerdoor_silver", 0xFFFFFFFF);
g_Object[517] = CreateObject(2515, 926.2197, -1449.8236, 2761.0720, 0.0000, 0.0000, -90.0000); //CJ_BS_SINK
SetObjectMaterial(g_Object[517], 0, 11150, "ab_acc_control", "ws_shipmetal5", 0xFFFFFFFF);
SetObjectMaterial(g_Object[517], 1, 11301, "carshow_sfse", "ws_rollerdoor_silver", 0xFFFFFFFF);
g_Object[518] = CreateObject(11706, 926.1981, -1452.5063, 2759.8071, 0.0000, 0.0000, 0.0000); //SmallWasteBin1
g_Object[519] = CreateObject(2741, 926.6439, -1452.5472, 2761.9111, 0.0000, 0.0000, -90.0000); //CJ_SOAP_DISP
g_Object[520] = CreateObject(19174, 929.8189, -1457.1361, 2763.1921, 0.0000, 0.0000, 0.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[520], "E.G.", 0, 90, "Arial Black", 20, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[520], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[521] = CreateObject(11707, 926.6912, -1448.4228, 2760.9423, 0.0000, 0.0000, -90.0000); //TowelRack1
g_Object[522] = CreateObject(19814, 926.7271, -1452.5400, 2760.9824, 0.0000, 0.0000, -90.0000); //ElectricalOutlet2
g_Object[523] = CreateObject(19814, 926.7271, -1452.5400, 2761.1225, 0.0000, 0.0000, -90.0000); //ElectricalOutlet2
g_Object[524] = CreateObject(19814, 926.7271, -1452.5400, 2761.2626, 0.0000, 0.0000, -90.0000); //ElectricalOutlet2
g_Object[525] = CreateObject(2528, 919.8004, -1449.7551, 2760.0144, 0.0000, 0.0000, 90.0000); //CJ_TOILET3
g_Object[526] = CreateObject(2528, 919.8004, -1452.9956, 2760.0144, 0.0000, 0.0000, 90.0000); //CJ_TOILET3
g_Object[527] = CreateObject(2528, 919.8004, -1455.6451, 2760.0144, 0.0000, 0.0000, 90.0000); //CJ_TOILET3
g_Object[528] = CreateObject(19464, 925.4016, -1447.4841, 2762.5297, 90.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[528], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[529] = CreateObject(1753, 931.0811, -1470.3409, 2759.9807, 0.0000, 0.0000, 90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[529], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[530] = CreateObject(1491, 921.5900, -1450.5792, 2759.9321, 0.0000, 0.0000, 90.0000); //Gen_doorINT01
g_Object[531] = CreateObject(1491, 921.5869, -1453.6593, 2759.9321, 0.0000, 0.0000, 90.0000); //Gen_doorINT01
g_Object[532] = CreateObject(1491, 921.5869, -1456.7395, 2759.9321, 0.0000, 0.0000, 90.0000); //Gen_doorINT01
g_Object[533] = CreateObject(19430, 921.5739, -1454.4365, 2760.6806, 0.0000, 0.0000, 0.0000); //wall070
SetObjectMaterial(g_Object[533], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[534] = CreateObject(19430, 920.7645, -1454.4365, 2760.6806, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[534], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[535] = CreateObject(19430, 919.9735, -1451.3664, 2760.7014, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[535], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[536] = CreateObject(19430, 920.7636, -1451.3763, 2760.7014, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[536], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[537] = CreateObject(19430, 921.5739, -1448.2961, 2760.6806, 0.0000, 0.0000, 0.0000); //wall070
SetObjectMaterial(g_Object[537], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[538] = CreateObject(19430, 920.1641, -1454.4265, 2760.6806, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[538], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[539] = CreateObject(19430, 921.5739, -1451.3564, 2760.6806, 0.0000, 0.0000, 0.0000); //wall070
SetObjectMaterial(g_Object[539], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[540] = CreateObject(19430, 920.7636, -1448.4565, 2760.7014, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[540], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[541] = CreateObject(19430, 920.1535, -1448.4565, 2760.7014, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[541], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[542] = CreateObject(19464, 921.5219, -1449.1544, 2765.3295, 90.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[542], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[543] = CreateObject(19464, 921.5020, -1454.2047, 2765.3295, 90.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[543], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[544] = CreateObject(18075, 926.6956, -1450.3454, 2764.8454, 0.0000, 0.0000, 0.0000); //lightD
g_Object[545] = CreateObject(16779, 923.8812, -1452.3680, 2764.8708, 0.0000, 0.0000, 0.0000); //ufo_light02
g_Object[546] = CreateObject(19175, 924.2739, -1447.6396, 2762.4118, 0.0000, 0.0000, 0.0000); //SAMPPicture4
SetObjectMaterial(g_Object[546], 0, 2266, "picture_frame", "CJ_PAINTING18", 0xFFFFFFFF);
SetObjectMaterial(g_Object[546], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[547] = CreateObject(19089, 930.4857, -1451.8974, 2759.9978, 0.0000, 90.0000, 90.0000); //Rope3
SetObjectMaterial(g_Object[547], 0, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
g_Object[548] = CreateObject(19089, 930.4857, -1459.2679, 2759.9978, 0.0000, 90.0000, 90.0000); //Rope3
SetObjectMaterial(g_Object[548], 0, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
g_Object[549] = CreateObject(1753, 931.1015, -1474.7010, 2759.9807, 0.0000, 0.0000, 90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[549], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[550] = CreateObject(1753, 909.3314, -1472.6711, 2759.9807, 0.0000, 0.0000, -90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[550], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[551] = CreateObject(1753, 909.3314, -1468.1905, 2759.9807, 0.0000, 0.0000, -90.0000); //SWANK_COUCH_1
SetObjectMaterial(g_Object[551], 0, 1726, "mrk_couches2", "kb_sofa5_256", 0xFFFFFFFF);
g_Object[552] = CreateObject(19089, 909.8756, -1451.8974, 2759.9978, 0.0000, 90.0000, 90.0000); //Rope3
SetObjectMaterial(g_Object[552], 0, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
g_Object[553] = CreateObject(19089, 909.8756, -1459.2375, 2759.9978, 0.0000, 90.0000, 90.0000); //Rope3
SetObjectMaterial(g_Object[553], 0, 1560, "7_11_door", "cj_sheetmetal2", 0xFFFFFFFF);
g_Object[554] = CreateObject(19174, 901.1901, -1465.8480, 2762.9099, 0.0000, 0.0000, 90.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[554], "___________", 0, 90, "Arial", 24, 1, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[554], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[555] = CreateObject(19174, 901.1901, -1465.8480, 2763.1000, 0.0000, 0.0000, 90.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[555], "___________", 0, 90, "Arial", 24, 1, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[555], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[556] = CreateObject(19174, 938.4401, -1465.8480, 2763.1000, 0.0000, 0.0000, 270.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[556], "___________", 0, 90, "Arial", 24, 1, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[556], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[557] = CreateObject(19174, 938.4398, -1465.8580, 2762.9018, 0.0000, 0.0000, 270.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[557], "Personalverwaltung", 0, 90, "Arial Black", 14, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[557], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[558] = CreateObject(19174, 938.4503, -1465.8480, 2762.9299, 0.0000, 0.0000, 270.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[558], "___________", 0, 90, "Arial", 24, 1, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[558], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[559] = CreateObject(1491, 938.5797, -1465.1302, 2760.0092, 0.0000, 0.0000, 270.0000); //Gen_doorINT01
SetObjectMaterial(g_Object[559], 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0xFFFFFFFF);
g_Object[560] = CreateObject(1536, 901.1024, -1465.1301, 2759.9863, 0.0000, 0.0000, -90.0000); //Gen_doorEXT15
SetObjectMaterial(g_Object[560], 0, 1569, "adam_v_doort", "ws_guardhousedoor", 0xFFFFFFFF);
g_Object[561] = CreateObject(19814, 908.2202, -1475.8642, 2760.3498, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[562] = CreateObject(19814, 908.4503, -1475.8642, 2760.3498, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[563] = CreateObject(19814, 902.2800, -1475.8642, 2760.3498, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[564] = CreateObject(19814, 902.5399, -1475.8642, 2760.3498, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[565] = CreateObject(19814, 901.1403, -1462.3841, 2760.3098, 0.0000, 0.0000, 90.0000); //ElectricalOutlet2
g_Object[566] = CreateObject(19814, 901.1704, -1458.9731, 2760.3098, 0.0000, 0.0000, 90.0000); //ElectricalOutlet2
g_Object[567] = CreateObject(19814, 901.1702, -1468.3935, 2760.3098, 0.0000, 0.0000, 90.0000); //ElectricalOutlet2
g_Object[568] = CreateObject(19814, 938.4500, -1459.0124, 2760.3098, 0.0000, 0.0000, 270.0000); //ElectricalOutlet2
g_Object[569] = CreateObject(19814, 938.4500, -1462.3730, 2760.3098, 0.0000, 0.0000, 270.0000); //ElectricalOutlet2
g_Object[570] = CreateObject(19814, 938.4500, -1471.0437, 2760.3098, 0.0000, 0.0000, 270.0000); //ElectricalOutlet2
g_Object[571] = CreateObject(19814, 938.4500, -1472.0240, 2760.3098, 0.0000, 0.0000, 270.0000); //ElectricalOutlet2
g_Object[572] = CreateObject(19814, 936.9995, -1475.8741, 2760.3098, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[573] = CreateObject(19814, 937.2398, -1475.8741, 2760.3098, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[574] = CreateObject(2961, 904.8776, -1457.0854, 2761.3278, 0.0000, 0.0000, 0.0000); //fire_break
g_Object[575] = CreateObject(2961, 934.5474, -1457.0854, 2761.3278, 0.0000, 0.0000, 0.0000); //fire_break
g_Object[576] = CreateObject(2962, 934.5465, -1457.0898, 2761.3232, 0.0000, 0.0000, 0.0000); //fire_break_glass
g_Object[577] = CreateObject(2962, 904.8767, -1457.0898, 2761.3232, 0.0000, 0.0000, 0.0000); //fire_break_glass
g_Object[578] = CreateObject(19826, 917.0244, -1456.6499, 2761.3168, 0.0000, 0.0000, 180.0000); //LightSwitch1
SetObjectMaterial(g_Object[578], 0, 14706, "labig2int2", "lightswitch01_int", 0xFFFFFFFF);
g_Object[579] = CreateObject(19826, 917.1646, -1456.6499, 2761.3168, 0.0000, 0.0000, 180.0000); //LightSwitch1
SetObjectMaterial(g_Object[579], 0, 14706, "labig2int2", "lightswitch01_int", 0xFFFFFFFF);
g_Object[580] = CreateObject(19826, 923.6148, -1456.6499, 2761.3168, 0.0000, 0.0000, 180.0000); //LightSwitch1
SetObjectMaterial(g_Object[580], 0, 14706, "labig2int2", "lightswitch01_int", 0xFFFFFFFF);
g_Object[581] = CreateObject(19826, 923.8048, -1456.6499, 2761.3168, 0.0000, 0.0000, 180.0000); //LightSwitch1
SetObjectMaterial(g_Object[581], 0, 14706, "labig2int2", "lightswitch01_int", 0xFFFFFFFF);
g_Object[582] = CreateObject(19814, 913.2304, -1475.8453, 2753.5849, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[583] = CreateObject(19814, 916.9713, -1475.8453, 2753.5849, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[584] = CreateObject(19814, 923.0114, -1475.8453, 2753.5849, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[585] = CreateObject(19814, 926.5117, -1475.8453, 2753.5849, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[586] = CreateObject(19814, 918.1419, -1462.6749, 2753.4748, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[587] = CreateObject(19814, 918.5722, -1462.6749, 2753.4748, 0.0000, 0.0000, 180.0000); //ElectricalOutlet2
g_Object[588] = CreateObject(19786, 906.7141, -1472.8266, 2755.8620, 0.0000, 0.0000, 180.0000); //LCDTVBig1
SetObjectMaterial(g_Object[588], 0, 14570, "traidaqua", "ab_tv", 0xFFFFFFFF);
SetObjectMaterial(g_Object[588], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[589] = CreateObject(19786, 932.9738, -1472.8266, 2755.8620, 0.0000, 0.0000, 180.0000); //LCDTVBig1
SetObjectMaterial(g_Object[589], 0, 14570, "traidaqua", "ab_tv", 0xFFFFFFFF);
SetObjectMaterial(g_Object[589], 1, 14571, "chinese_furn", "ab_tv_noise", 0xFFFFFFFF);
g_Object[590] = CreateObject(19387, 938.6715, -1465.9105, 2761.6650, 0.0000, 0.0000, 0.0000); //wall035
SetObjectMaterial(g_Object[590], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[591] = CreateObject(19464, 938.6336, -1470.4040, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[591], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[592] = CreateObject(19464, 938.6336, -1461.3641, 2762.5297, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[592], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[593] = CreateObject(19464, 938.6320, -1466.2845, 2765.8708, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[593], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[594] = CreateObject(19430, 944.8953, -1468.0417, 2759.9421, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[594], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[595] = CreateObject(18762, 944.7965, -1465.6184, 2760.4494, 0.0000, 90.0000, 90.0000); //Concrete1mx1mx5m
SetObjectMaterial(g_Object[595], 0, 10765, "airportgnd_sfse", "white", 0xFF3B4E78);
g_Object[596] = CreateObject(19430, 944.8953, -1463.2016, 2759.9421, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[596], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[597] = CreateObject(19430, 944.8953, -1465.6627, 2759.9421, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[597], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[598] = CreateObject(19430, 944.3754, -1466.2519, 2760.1323, 90.0000, 90.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[598], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[599] = CreateObject(19430, 944.3754, -1464.9720, 2760.1323, 90.0000, 90.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[599], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[600] = CreateObject(1714, 946.6273, -1466.6816, 2759.9899, 0.0000, 0.0000, -90.0000); //kb_swivelchair1
g_Object[601] = CreateObject(19175, 944.2650, -1465.4127, 2759.8366, 0.0000, 0.0000, 270.0000); //SAMPPicture4
SetObjectMaterialText(g_Object[601], "Schalter l", 0, 90, "Arial", 20, 1, 0xFFFFFFFF, 0x0, 0);
SetObjectMaterial(g_Object[601], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[602] = CreateObject(19175, 944.2650, -1467.7425, 2759.8366, 0.0000, 0.0000, 270.0000); //SAMPPicture4
SetObjectMaterialText(g_Object[602], "Schalter ll", 0, 90, "Arial", 20, 1, 0xFFFFFFFF, 0x0, 0);
SetObjectMaterial(g_Object[602], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[603] = CreateObject(1714, 946.6273, -1464.5013, 2759.9899, 0.0000, 0.0000, -90.0000); //kb_swivelchair1
g_Object[604] = CreateObject(19808, 945.0086, -1464.4233, 2760.9680, 0.0000, 0.0000, 90.0000); //Keyboard1
g_Object[605] = CreateObject(19808, 945.0086, -1466.7937, 2760.9680, 0.0000, 0.0000, 90.0000); //Keyboard1
g_Object[606] = CreateObject(2601, 944.5239, -1464.4315, 2760.9790, 0.0000, 0.0000, 0.0000); //CJ_JUICE_CAN
SetObjectMaterial(g_Object[606], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[607] = CreateObject(2601, 944.6040, -1466.7921, 2760.9790, 0.0000, 0.0000, 0.0000); //CJ_JUICE_CAN
SetObjectMaterial(g_Object[607], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[608] = CreateObject(2263, 945.0792, -1464.4593, 2761.1420, -16.7000, 0.0000, 90.0000); //Frame_SLIM_4
SetObjectMaterial(g_Object[608], 0, 3881, "apsecurity_sfxrf", "WIN_DESKTOP", 0xFFFFFFFF);
SetObjectMaterial(g_Object[608], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[609] = CreateObject(2601, 944.6040, -1464.4322, 2760.9189, 0.0000, 90.0000, 90.0000); //CJ_JUICE_CAN
SetObjectMaterial(g_Object[609], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[610] = CreateObject(2263, 944.1259, -1466.7998, 2760.9052, 16.4999, 0.0000, 270.0000); //Frame_SLIM_4
SetObjectMaterial(g_Object[610], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
SetObjectMaterial(g_Object[610], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[611] = CreateObject(2263, 944.1373, -1464.4189, 2760.8666, 16.4999, 0.0000, 270.0000); //Frame_SLIM_4
SetObjectMaterial(g_Object[611], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
SetObjectMaterial(g_Object[611], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[612] = CreateObject(2263, 945.0676, -1466.8298, 2761.1801, -16.7000, 0.0000, 90.0000); //Frame_SLIM_4
SetObjectMaterial(g_Object[612], 0, 3881, "apsecurity_sfxrf", "WIN_DESKTOP", 0xFFFFFFFF);
SetObjectMaterial(g_Object[612], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[613] = CreateObject(2601, 944.6040, -1466.7922, 2760.9189, 0.0000, 90.0000, 90.0000); //CJ_JUICE_CAN
SetObjectMaterial(g_Object[613], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
g_Object[614] = CreateObject(19513, 944.8659, -1463.8675, 2760.9340, 0.0000, 0.0000, 90.0000); //whitephone
g_Object[615] = CreateObject(19513, 944.8659, -1466.2380, 2760.9340, 0.0000, 0.0000, 90.0000); //whitephone
g_Object[616] = CreateObject(1811, 939.2077, -1463.7757, 2760.5717, 0.0000, 0.0000, 180.0000); //MED_DIN_CHAIR_5
g_Object[617] = CreateObject(1811, 939.2077, -1462.7456, 2760.5717, 0.0000, 0.0000, 180.0000); //MED_DIN_CHAIR_5
g_Object[618] = CreateObject(1811, 939.2077, -1461.7054, 2760.5717, 0.0000, 0.0000, 180.0000); //MED_DIN_CHAIR_5
g_Object[619] = CreateObject(1811, 939.2077, -1467.8857, 2760.5717, 0.0000, 0.0000, 180.0000); //MED_DIN_CHAIR_5
g_Object[620] = CreateObject(1811, 939.2077, -1468.9260, 2760.5717, 0.0000, 0.0000, 180.0000); //MED_DIN_CHAIR_5
g_Object[621] = CreateObject(1811, 939.2077, -1469.9460, 2760.5717, 0.0000, 0.0000, 180.0000); //MED_DIN_CHAIR_5
g_Object[622] = CreateObject(19175, 938.7739, -1462.8496, 2762.4118, 0.0000, 0.0000, 90.0000); //SAMPPicture4
SetObjectMaterial(g_Object[622], 0, 2266, "picture_frame", "CJ_PAINTING16", 0xFFFFFFFF);
SetObjectMaterial(g_Object[622], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[623] = CreateObject(19175, 938.7739, -1468.7794, 2762.4118, 0.0000, 0.0000, 90.0000); //SAMPPicture4
SetObjectMaterial(g_Object[623], 0, 2266, "picture_frame", "CJ_PAINTING16", 0xFFFFFFFF);
SetObjectMaterial(g_Object[623], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[624] = CreateObject(19464, 941.5139, -1471.3243, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[624], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[625] = CreateObject(19464, 947.4340, -1471.3243, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[625], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[626] = CreateObject(19464, 947.4340, -1460.3436, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[626], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[627] = CreateObject(19464, 941.7039, -1460.3232, 2762.5297, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[627], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[628] = CreateObject(19464, 949.9140, -1463.3531, 2762.5297, 0.0000, 0.0000, 180.0000); //wall104
SetObjectMaterial(g_Object[628], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[629] = CreateObject(19464, 949.9140, -1469.2729, 2762.5297, 0.0000, 0.0000, 180.0000); //wall104
SetObjectMaterial(g_Object[629], 0, 15041, "bigsfsave", "wall6", 0xFFFFFFFF);
g_Object[630] = CreateObject(1811, 940.7675, -1460.8951, 2760.5717, 0.0000, 0.0000, 90.0000); //MED_DIN_CHAIR_5
g_Object[631] = CreateObject(1811, 942.0974, -1460.8951, 2760.5717, 0.0000, 0.0000, 90.0000); //MED_DIN_CHAIR_5
g_Object[632] = CreateObject(1811, 943.3975, -1460.8951, 2760.5717, 0.0000, 0.0000, 90.0000); //MED_DIN_CHAIR_5
g_Object[633] = CreateObject(1811, 943.3975, -1470.7954, 2760.5717, 0.0000, 0.0000, -90.0000); //MED_DIN_CHAIR_5
g_Object[634] = CreateObject(1811, 942.0269, -1470.7954, 2760.5717, 0.0000, 0.0000, -90.0000); //MED_DIN_CHAIR_5
g_Object[635] = CreateObject(1811, 940.6666, -1470.7954, 2760.5717, 0.0000, 0.0000, -90.0000); //MED_DIN_CHAIR_5
g_Object[636] = CreateObject(2010, 939.3461, -1470.7407, 2759.9838, 0.0000, 0.0000, 0.0000); //nu_plant3_ofc
SetObjectMaterial(g_Object[636], 1, 18012, "genintgeneric", "planterbox128", 0xFFFFFFFF);
g_Object[637] = CreateObject(2010, 939.3461, -1460.8907, 2759.9838, 0.0000, 0.0000, 0.0000); //nu_plant3_ofc
SetObjectMaterial(g_Object[637], 1, 18012, "genintgeneric", "planterbox128", 0xFFFFFFFF);
g_Object[638] = CreateObject(2161, 944.8826, -1460.4896, 2760.8225, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_4
g_Object[639] = CreateObject(2161, 945.2528, -1471.2099, 2760.8225, 0.0000, 0.0000, 180.0000); //MED_OFFICE_UNIT_4
g_Object[640] = CreateObject(2162, 949.7091, -1469.1296, 2760.9421, 0.0000, 0.0000, 270.0000); //MED_OFFICE_UNIT_1
g_Object[641] = CreateObject(2162, 949.7091, -1461.5295, 2760.9421, 0.0000, 0.0000, 270.0000); //MED_OFFICE_UNIT_1
g_Object[642] = CreateObject(2164, 949.7589, -1464.0985, 2759.9963, 0.0000, 0.0000, -90.0000); //MED_OFFICE_UNIT_5
g_Object[643] = CreateObject(2167, 946.9199, -1460.2558, 2759.9951, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_7
g_Object[644] = CreateObject(2167, 948.2697, -1460.2558, 2759.9951, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_7
g_Object[645] = CreateObject(2167, 948.2697, -1471.3559, 2759.9951, 0.0000, 0.0000, 180.0000); //MED_OFFICE_UNIT_7
g_Object[646] = CreateObject(2167, 946.9196, -1471.3559, 2759.9951, 0.0000, 0.0000, 180.0000); //MED_OFFICE_UNIT_7
g_Object[647] = CreateObject(2186, 949.3242, -1466.6075, 2759.9931, 0.0000, 0.0000, -90.0000); //PHOTOCOPIER_1
g_Object[648] = CreateObject(19464, 941.5139, -1471.3044, 2767.2912, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[648], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[649] = CreateObject(19464, 946.9442, -1471.3044, 2767.2912, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[649], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[650] = CreateObject(19464, 946.9442, -1460.3536, 2767.2912, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[650], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[651] = CreateObject(19464, 941.7042, -1460.3536, 2767.2912, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[651], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[652] = CreateObject(19464, 938.6845, -1463.3634, 2767.2912, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[652], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[653] = CreateObject(19464, 938.7045, -1468.3736, 2767.2912, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[653], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[654] = CreateObject(19464, 949.8944, -1468.3736, 2767.2912, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[654], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[655] = CreateObject(19464, 949.8944, -1462.4427, 2767.2912, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[655], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[656] = CreateObject(19464, 949.8944, -1462.4427, 2757.5200, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[656], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[657] = CreateObject(19464, 949.8944, -1468.3530, 2757.5200, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[657], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[658] = CreateObject(19464, 949.8944, -1471.3038, 2757.5200, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[658], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[659] = CreateObject(19464, 943.5642, -1471.3038, 2757.5200, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[659], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[660] = CreateObject(19464, 941.6843, -1471.3038, 2757.5200, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[660], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[661] = CreateObject(19464, 941.6843, -1460.3537, 2757.5200, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[661], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[662] = CreateObject(19464, 947.6240, -1460.3537, 2757.5200, 0.0000, 0.0000, 90.0000); //wall104
SetObjectMaterial(g_Object[662], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[663] = CreateObject(19464, 938.6441, -1462.1733, 2757.5200, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[663], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[664] = CreateObject(18075, 944.4329, -1465.8193, 2764.8713, 0.0000, 0.0000, 0.0000); //lightD
g_Object[665] = CreateObject(16780, 943.8864, -1467.9200, 2764.9145, 0.0000, 0.0000, 0.0000); //ufo_light03
g_Object[666] = CreateObject(16780, 943.8864, -1464.1998, 2764.9145, 0.0000, 0.0000, 0.0000); //ufo_light03
g_Object[667] = CreateObject(3034, 946.9309, -1460.4698, 2762.8015, 0.0000, 0.0000, 0.0000); //bd_window
SetObjectMaterial(g_Object[667], 0, 9901, "ferry_building", "skylight_windows", 0xFFFFFFFF);
g_Object[668] = CreateObject(3034, 941.9708, -1460.4698, 2762.8015, 0.0000, 0.0000, 0.0000); //bd_window
SetObjectMaterial(g_Object[668], 0, 9901, "ferry_building", "skylight_windows", 0xFFFFFFFF);
g_Object[669] = CreateObject(3034, 946.9309, -1471.1999, 2762.8015, 0.0000, 0.0000, 180.0000); //bd_window
SetObjectMaterial(g_Object[669], 0, 9901, "ferry_building", "skylight_windows", 0xFFFFFFFF);
g_Object[670] = CreateObject(3034, 941.9207, -1471.1904, 2762.8015, 0.0000, 0.0000, 180.0000); //bd_window
SetObjectMaterial(g_Object[670], 0, 9901, "ferry_building", "skylight_windows", 0xFFFFFFFF);
g_Object[671] = CreateObject(19450, 909.2650, -1461.9305, 2764.9331, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[671], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[672] = CreateObject(19825, 949.6734, -1466.1933, 2762.9707, 0.0000, 0.0000, -90.0000); //SprunkClock1
SetObjectMaterial(g_Object[672], 0, 1654, "dynamite", "clock64", 0xFFFFFFFF);
g_Object[673] = CreateObject(19450, 918.8350, -1461.9305, 2764.9331, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[673], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[674] = CreateObject(19450, 928.3848, -1461.9305, 2764.9331, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[674], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[675] = CreateObject(19450, 930.5847, -1461.9305, 2764.9331, 0.0000, 90.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[675], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[676] = CreateObject(19450, 934.5548, -1465.0008, 2764.9331, 0.0000, 90.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[676], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[677] = CreateObject(19450, 934.5551, -1471.1998, 2764.9331, 0.0000, 90.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[677], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[678] = CreateObject(19450, 905.3654, -1471.1998, 2764.9331, 0.0000, 90.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[678], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[679] = CreateObject(19450, 905.3654, -1464.9895, 2764.9331, 0.0000, 90.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[679], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[680] = CreateObject(19450, 933.1546, -1471.1811, 2766.5825, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[680], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[681] = CreateObject(19450, 936.0051, -1471.1811, 2766.5825, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[681], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[682] = CreateObject(19450, 936.0150, -1465.2004, 2766.5925, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[682], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[683] = CreateObject(19450, 933.1547, -1468.3299, 2766.5925, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[683], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[684] = CreateObject(19450, 931.2150, -1460.4696, 2766.5925, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[684], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[685] = CreateObject(19450, 921.5955, -1460.4696, 2766.5925, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[685], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[686] = CreateObject(19450, 911.9658, -1460.4696, 2766.5925, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[686], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[687] = CreateObject(19450, 908.7152, -1460.4593, 2766.5825, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[687], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[688] = CreateObject(19450, 928.4057, -1463.4294, 2766.5825, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[688], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[689] = CreateObject(19450, 918.7656, -1463.4294, 2766.5825, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[689], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[690] = CreateObject(19450, 911.6956, -1463.4294, 2766.5625, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[690], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[691] = CreateObject(19450, 903.9754, -1465.1798, 2766.5725, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[691], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[692] = CreateObject(19450, 903.9754, -1471.2004, 2766.5725, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[692], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[693] = CreateObject(19450, 906.8054, -1468.1510, 2766.5725, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[693], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[694] = CreateObject(19450, 906.8054, -1471.1826, 2766.5727, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[694], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[695] = CreateObject(945, 911.4801, -1462.0312, 2772.0705, 0.0000, 0.0000, 0.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[695], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[695], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[695], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[695], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[696] = CreateObject(945, 907.9799, -1462.0312, 2772.0705, 0.0000, 0.0000, 0.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[696], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[696], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[696], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[696], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[697] = CreateObject(945, 915.2000, -1462.0312, 2772.0705, 0.0000, 0.0000, 0.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[697], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[697], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[697], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[697], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[698] = CreateObject(945, 919.0300, -1462.0312, 2772.0705, 0.0000, 0.0000, 0.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[698], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[698], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[698], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[698], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[699] = CreateObject(945, 923.3801, -1462.0312, 2772.0705, 0.0000, 0.0000, 0.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[699], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[699], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[699], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[699], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[700] = CreateObject(945, 927.1604, -1462.0312, 2772.0705, 0.0000, 0.0000, 0.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[700], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[700], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[700], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[700], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[701] = CreateObject(945, 931.3502, -1462.0312, 2772.0705, 0.0000, 0.0000, 0.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[701], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[701], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[701], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[701], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[702] = CreateObject(945, 934.5601, -1464.2613, 2772.0705, 0.0000, 0.0000, 90.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[702], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[702], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[702], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[702], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[703] = CreateObject(945, 934.5601, -1468.5815, 2772.0705, 0.0000, 0.0000, 90.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[703], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[703], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[703], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[703], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[704] = CreateObject(945, 934.5601, -1473.1910, 2772.0705, 0.0000, 0.0000, 90.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[704], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[704], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[704], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[704], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[705] = CreateObject(945, 905.3192, -1473.1910, 2772.0705, 0.0000, 0.0000, 90.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[705], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[705], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[705], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[705], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[706] = CreateObject(945, 905.3192, -1464.6014, 2772.0705, 0.0000, 0.0000, 90.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[706], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[706], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[706], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[706], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[707] = CreateObject(945, 905.3192, -1468.9615, 2772.0705, 0.0000, 0.0000, 90.0000); //WS_CF_LAMPS
SetObjectMaterial(g_Object[707], 0, 0, "INVALID", "INVALID", 0xFFFFFFFF);
SetObjectMaterial(g_Object[707], 1, 12850, "cunte_block1", "lightwall256", 0xFFFFFFFF);
SetObjectMaterial(g_Object[707], 2, 8482, "csrspalace02", "casinolightsyel_128", 0xFFFFFFFF);
SetObjectMaterial(g_Object[707], 3, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[708] = CreateObject(19450, 901.1259, -1471.0997, 2766.5539, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[708], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[709] = CreateObject(19450, 901.1259, -1461.4602, 2766.5539, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[709], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[710] = CreateObject(19450, 901.1259, -1461.4602, 2758.2934, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[710], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[711] = CreateObject(19450, 901.1259, -1471.1606, 2758.2934, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[711], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[712] = CreateObject(19450, 905.7857, -1457.0102, 2766.5637, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[712], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[713] = CreateObject(19450, 915.4157, -1457.0102, 2766.5637, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[713], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[714] = CreateObject(19450, 925.0053, -1457.0102, 2766.5637, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[714], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[715] = CreateObject(19450, 934.6154, -1457.0102, 2766.5637, 0.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[715], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[716] = CreateObject(19450, 938.5158, -1461.8902, 2766.5637, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[716], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[717] = CreateObject(19450, 938.5158, -1471.4997, 2766.5637, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[717], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[718] = CreateObject(19450, 938.5158, -1471.4298, 2758.2827, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[718], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[719] = CreateObject(19450, 938.5158, -1460.3293, 2758.2827, 0.0000, 0.0000, 0.0000); //wall090
SetObjectMaterial(g_Object[719], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[720] = CreateObject(19450, 940.1759, -1457.0283, 2760.3825, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[720], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[721] = CreateObject(19450, 899.4359, -1457.0283, 2760.3825, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[721], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[722] = CreateObject(19450, 899.4655, -1475.8977, 2760.3825, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[722], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[723] = CreateObject(19450, 940.1760, -1475.8878, 2760.3825, 90.0000, 0.0000, 90.0000); //wall090
SetObjectMaterial(g_Object[723], 0, 10765, "airportgnd_sfse", "white", 0xFF000000);
g_Object[724] = CreateObject(11721, 936.6129, -1457.0749, 2760.5214, 0.0000, 0.0000, 0.0000); //Radiator1
SetObjectMaterial(g_Object[724], 1, 14704, "lahss2_2int2", "HS_radiator2", 0xFFFFFFFF);
g_Object[725] = CreateObject(11721, 902.9525, -1457.0749, 2760.5214, 0.0000, 0.0000, 0.0000); //Radiator1
SetObjectMaterial(g_Object[725], 1, 14704, "lahss2_2int2", "HS_radiator2", 0xFFFFFFFF);
g_Object[726] = CreateObject(19174, 901.1901, -1465.8580, 2762.9018, 0.0000, 0.0000, 90.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[726], "Besprechungsraum", 0, 90, "Arial Black", 14, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[726], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[727] = CreateObject(19174, 901.1901, -1465.8580, 2762.7216, 0.0000, 0.0000, 90.0000); //SAMPPicture3
SetObjectMaterialText(g_Object[727], "nur für Befugte!", 0, 90, "Arial Black", 14, 0, 0xFF000000, 0x0, 1);
SetObjectMaterial(g_Object[727], 1, 0, "INVALID", "INVALID", 0xFFFFFFFF);
g_Object[728] = CreateObject(19464, 938.6441, -1469.6035, 2757.5200, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[728], 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0xFFFFFFFF);
g_Object[729] = CreateObject(19464, 938.5836, -1464.4643, 2765.7199, 0.0000, 0.0000, 0.0000); //wall104
SetObjectMaterial(g_Object[729], 0, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
g_Object[730] = CreateObject(19430, 920.7636, -1448.4466, 2763.5612, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[730], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
g_Object[731] = CreateObject(19430, 920.1735, -1448.4266, 2763.5612, 0.0000, 0.0000, 90.0000); //wall070
SetObjectMaterial(g_Object[731], 0, 17049, "cuntwf", "sw_walltile", 0xFFFFFFFF);
}