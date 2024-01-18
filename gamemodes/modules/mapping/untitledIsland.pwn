#include <YSI\y_hooks>

hook OnGameModeInit()
{
new g_Object[73];
new g_Vehicle[2];
g_Object[0] = CreateObject(18751, -29.5069, -1729.4793, 7.5086, 0.0000, 0.0000, 0.0000); //IslandBase1
SetObjectMaterial(g_Object[0], 0, 16093, "a51_ext", "des_dirt1", 0x00000000);
SetObjectMaterial(g_Object[0], 1, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
SetObjectMaterial(g_Object[0], 2, 16093, "a51_ext", "des_dirt1", 0x00000000);
SetObjectMaterial(g_Object[0], 3, 16093, "a51_ext", "des_dirttrack1", 0x00000000);
g_Object[1] = CreateObject(18259, -27.2082, -1727.0528, 14.0705, 0.0000, 0.0000, 0.0000); //logcabinn01
SetObjectMaterial(g_Object[1], 0, 12862, "sw_block03", "sw_woodwall1", 0x00000000);
SetObjectMaterial(g_Object[1], 1, 1453, "break_farm", "CJ_HAY", 0x00000000);
g_Object[2] = CreateObject(3173, -15.7898, -1729.8808, 12.3903, 0.0000, 0.0000, 0.0000); //trailer_large4_01
g_Object[3] = CreateObject(695, -14.2941, -1700.8266, 1.2769, 0.0000, 0.0000, 0.0000); //sm_fir_scabtg
g_Object[4] = CreateObject(695, -44.1941, -1744.8968, -0.3429, 0.0000, 0.0000, 0.0000); //sm_fir_scabtg
g_Object[5] = CreateObject(2410, -13.4793, -1724.2557, 13.7767, 1.0000, 55.5998, 10.4998); //CJ_SURF_BOARD4
g_Object[6] = CreateObject(3927, -4.6721, -1707.3509, 11.6717, 0.0000, 0.0000, 0.0000); //d_sign01
g_Object[7] = CreateObject(3927, 0.3120, -1757.6356, 13.4294, 0.0000, 0.0000, 123.0998); //d_sign01
g_Object[8] = CreateObject(1463, -19.7999, -1734.4697, 13.5137, 0.0000, 0.0000, -90.4999); //DYN_WOODPILE2
g_Object[9] = CreateObject(1408, -48.2616, -1713.0269, 11.1873, 0.0000, 0.0000, 2.2999); //DYN_F_WOOD_2
g_Object[10] = CreateObject(1408, -51.2631, -1698.5959, 9.1773, 0.0000, 0.0000, 2.2999); //DYN_F_WOOD_2
g_Object[11] = CreateObject(1408, -43.0301, -1712.8171, 11.1873, 0.0000, 0.0000, 2.2999); //DYN_F_WOOD_2
g_Object[12] = CreateObject(1408, -37.7943, -1712.6070, 11.1873, 0.0000, 0.0000, 2.2999); //DYN_F_WOOD_2
g_Object[13] = CreateObject(1307, -44.1992, -1717.3427, 9.5325, 0.0000, 0.0000, 0.0000); //telgrphpoleall
g_Object[14] = CreateObject(17025, -9.4084, -1751.7049, 4.8149, -49.0000, -6.0000, -56.9999); //cunt_rockgp1_
SetObjectMaterial(g_Object[14], 0, 16175, "des2vegas_join", "vgs_rockmid1a", 0x00000000);
g_Object[15] = CreateObject(1462, -13.5799, -1725.3161, 12.7732, 0.0000, 0.0000, 86.4000); //DYN_woodpile
g_Object[16] = CreateObject(622, -64.1371, -1693.7061, 5.5952, -2.2000, 0.0000, 38.9000); //veg_palm03
g_Object[17] = CreateObject(622, 6.7122, -1693.8944, 8.1050, -2.2000, 0.0000, -36.5999); //veg_palm03
g_Object[18] = CreateObject(622, 6.9597, -1767.5708, 7.5245, 1.4999, -2.1999, -120.2999); //veg_palm03
g_Object[19] = CreateObject(17068, -92.1532, -1744.6414, 0.9887, 0.0000, 0.0000, -84.8000); //xjetty01
g_Object[20] = CreateObject(13367, -51.5081, -1704.8946, 11.6424, 0.0000, 0.0000, 0.0000); //sw_watertower01
g_Object[21] = CreateObject(1358, -51.9748, -1745.2886, 11.6540, 0.0000, 0.0000, 0.0000); //CJ_SKIP_Rubbish
g_Object[22] = CreateObject(1271, -34.4575, -1721.4626, 14.4765, 0.0000, 0.0000, 0.0000); //gunbox
g_Object[23] = CreateObject(12957, -36.1936, -1716.7244, 12.1745, 0.0000, 18.4000, 90.2000); //sw_pickupwreck01
g_Object[24] = CreateObject(16502, 29.4175, -1725.4123, -1.3426, -6.8999, 1.5999, 0.0000); //cn2_jetty1
g_Object[25] = CreateObject(1271, -34.4575, -1722.2423, 14.4765, 0.0000, 0.0000, 0.0000); //gunbox
g_Object[26] = CreateObject(1271, -34.4575, -1721.8321, 15.1365, 0.0000, 0.0000, 0.0000); //gunbox
g_Object[27] = CreateObject(1637, -48.3380, -1736.8598, 12.8360, 0.0000, 0.0000, -59.4999); //od_pat_hutb
g_Object[28] = CreateObject(1499, -32.0746, -1728.3634, 14.1201, 0.0000, 0.0000, 93.7999); //Gen_doorINT05
SetObjectMaterial(g_Object[28], 0, 17025, "cuntrock", "cliffmid1", 0x00000000);
g_Object[29] = CreateObject(1598, -50.2511, -1724.9396, 11.0270, 0.0000, 0.0000, 0.0000); //beachball
g_Object[30] = CreateObject(1598, -49.6311, -1724.9396, 11.0270, 0.0000, 0.0000, 0.0000); //beachball
g_Object[31] = CreateObject(3425, -54.6664, -1772.6108, 14.5504, 0.0000, 0.0000, 178.7999); //nt_windmill
g_Object[32] = CreateObject(847, -73.3231, -1721.5042, 9.2669, 0.0000, 0.0000, 0.0000); //DEAD_TREE_19
g_Object[33] = CreateObject(2725, -49.9963, -1725.5489, 11.2651, 0.0000, 0.0000, 0.0000); //LM_stripTable
g_Object[34] = CreateObject(1646, -50.2417, -1724.1286, 11.1177, 0.0000, 0.0000, -78.1999); //lounge_towel_up
g_Object[35] = CreateObject(1281, -50.1063, -1722.4294, 11.6158, 0.0000, 0.0000, 0.0000); //parktable1
g_Object[36] = CreateObject(1432, -24.0517, -1733.5509, 14.2665, 0.0000, 0.0000, 0.0000); //DYN_TABLE_2
g_Object[37] = CreateObject(1649, -31.7244, -1733.1635, 15.7465, 0.0000, 0.0000, -83.7999); //wglasssmash
g_Object[38] = CreateObject(1649, -32.4303, -1722.4261, 15.8965, 0.0000, 0.0000, -88.6999); //wglasssmash
g_Object[39] = CreateObject(1796, -30.7528, -1733.3292, 14.1061, 0.0000, 0.0000, 0.0000); //LOW_BED_4
g_Object[40] = CreateObject(19370, -30.3314, -1728.4664, 15.6365, 0.0000, 0.0000, -87.0000); //wall018
SetObjectMaterial(g_Object[40], 0, 6404, "beafron1_law2", "Gen_Scaffold_Wood_Under", 0x00000000);
g_Object[41] = CreateObject(19370, -27.7150, -1728.3294, 15.6365, 0.0000, 0.0000, -87.0000); //wall018
SetObjectMaterial(g_Object[41], 0, 6404, "beafron1_law2", "Gen_Scaffold_Wood_Under", 0x00000000);
g_Object[42] = CreateObject(19370, -26.0480, -1729.7952, 15.6365, 0.0000, 0.0000, -174.6000); //wall018
SetObjectMaterial(g_Object[42], 0, 6404, "beafron1_law2", "Gen_Scaffold_Wood_Under", 0x00000000);
g_Object[43] = CreateObject(19370, -25.6038, -1734.4947, 15.6365, 0.0000, 0.0000, -174.6000); //wall018
SetObjectMaterial(g_Object[43], 0, 6404, "beafron1_law2", "Gen_Scaffold_Wood_Under", 0x00000000);
g_Object[44] = CreateObject(2264, -23.1442, -1725.3157, 15.9265, 0.0000, 0.0000, -93.1000); //Frame_SLIM_5
g_Object[45] = CreateObject(1280, -28.4744, -1729.3706, 14.6067, 0.0000, 0.0000, 91.6000); //parkbench1
g_Object[46] = CreateObject(11737, -25.3982, -1732.1311, 14.2626, 0.0000, 0.0000, 92.1999); //RockstarMat1
g_Object[47] = CreateObject(1484, -23.6506, -1733.4805, 15.0410, 0.0000, 27.3000, 0.0000); //CJ_BEAR_BOTTLE
g_Object[48] = CreateObject(1484, -24.2099, -1734.1507, 15.0258, 0.0000, 27.3000, 0.0000); //CJ_BEAR_BOTTLE
g_Object[49] = CreateObject(2867, -24.1508, -1733.3953, 14.9165, 0.0000, 0.0000, 0.0000); //gb_foodwrap05
g_Object[50] = CreateObject(11737, -31.3961, -1727.5871, 14.1826, 0.0000, 0.0000, -87.0999); //RockstarMat1
g_Object[51] = CreateObject(13493, -23.4127, -1721.9956, 15.1565, 0.0000, 0.0000, 0.0000); //CE_nitewindows2
g_Object[52] = CreateObject(2279, -23.2091, -1724.0416, 16.0965, 0.0000, 0.0000, -82.6999); //Frame_Thick_6
g_Object[53] = CreateObject(19143, -25.6319, -1735.9781, 17.4765, 0.0000, 0.0000, 33.8999); //PinSpotLight1
g_Object[54] = CreateObject(2256, -27.5167, -1720.3837, 16.1465, 0.0000, 0.0000, 0.0000); //Frame_Clip_3
g_Object[55] = CreateObject(1811, -31.0899, -1722.8039, 14.7390, 0.0000, 0.0000, 123.3999); //MED_DIN_CHAIR_5
g_Object[56] = CreateObject(3171, -53.8946, -1729.5245, 9.6763, 0.0000, 0.0000, 0.0000); //trailer5_01
g_Object[57] = CreateObject(1811, -30.1753, -1722.0526, 14.7390, 0.0000, 0.0000, 63.0999); //MED_DIN_CHAIR_5
g_Object[58] = CreateObject(1232, -44.2406, -1719.1923, 13.8587, 0.0000, 0.0000, 0.0000); //Streetlamp1
g_Object[59] = CreateObject(1232, -12.9975, -1742.0693, 13.1730, 0.0000, 0.0000, 0.0000); //Streetlamp1
g_Object[60] = CreateObject(1649, -25.2105, -1719.7158, 15.8828, 0.0000, 0.0000, -179.0998); //wglasssmash
g_Object[61] = CreateObject(1649, -29.4548, -1719.9025, 15.8828, 0.0000, 0.0000, -177.4998); //wglasssmash
g_Object[62] = CreateObject(1649, -22.4471, -1722.0172, 15.5293, 0.0000, 0.0000, 97.6999); //wglasssmash
g_Object[63] = CreateObject(1649, -21.8380, -1732.6405, 15.5293, 0.0000, 0.0000, 92.6999); //wglasssmash
g_Object[64] = CreateObject(1232, 15.1739, -1696.7937, 7.8766, 0.0000, 0.0000, 0.0000); //Streetlamp1
g_Object[65] = CreateObject(1232, -52.3862, -1773.1890, 8.3110, 0.0000, 0.0000, 0.0000); //Streetlamp1
g_Object[66] = CreateObject(1232, 17.7636, -1730.2012, 6.6733, 0.0000, 0.0000, 0.0000); //Streetlamp1
g_Object[67] = CreateObject(1232, -77.8870, -1746.8905, 5.3981, 0.0000, 0.0000, 0.0000); //Streetlamp1
g_Object[68] = CreateObject(1232, -69.2464, -1689.4100, 8.4535, 0.0000, 0.0000, 0.0000); //Streetlamp1
g_Object[69] = CreateObject(752, -21.7913, -1704.7700, 7.9048, 0.0000, 0.0000, 0.0000); //sm_cunt_rock1
g_Object[70] = CreateObject(17068, -88.2237, -1672.4361, 0.3502, 0.0000, 0.0000, 51.1000); //xjetty01
g_Object[71] = CreateObject(17068, -102.8858, -1660.6055, 0.3502, 0.0000, 0.0000, 51.1000); //xjetty01
g_Object[72] = CreateObject(17068, -109.7966, -1655.0294, 0.3502, 0.0000, 0.0000, 51.1000); //xjetty01
g_Vehicle[0] = CreateVehicle(568, -18.8080, -1729.5859, 13.7889, 1.2256, 0, 0, -1); //Bandito
g_Vehicle[1] = CreateVehicle(493, -94.7830, -1741.1036, -0.0821, 95.0176, 0, 0, -1); //Jetmax
}