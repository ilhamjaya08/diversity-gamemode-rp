
new gActor[15];
new FishName[MAX_PLAYERS][MAX_FISH][32];
new Float:FishWeight[MAX_PLAYERS][MAX_FISH];
new PlayerTemp[MAX_PLAYERS][playerTemp];

new misscallList[MAX_PLAYERS][10][128];
new latestInbox[MAX_PLAYERS][10][128];

new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];
new ContactData[MAX_PLAYERS][MAX_CONTACTS][contactData];
new DroppedItems[MAX_DROPPED_ITEMS][droppedItems];

new HouseStorage[MAX_HOUSES][MAX_HOUSE_STORAGE][houseStorage];

new FurnitureData[MAX_FURNITURE][furnitureData];

new LocationData[MAX_PLAYERS][MAX_GPS_LOCATIONS][locationData];

new ArrestData[MAX_ARREST_POINTS][arrestPoints];
new TicketData[MAX_PLAYERS][MAX_PLAYER_TICKETS][ticketData];

new ListedFurniture[MAX_PLAYERS][MAX_HOUSE_FURNITURE],
    NearestItems[MAX_PLAYERS][MAX_LISTED_ITEMS],
    ListedContacts[MAX_PLAYERS][MAX_CONTACTS],
    ListedHouse[MAX_PLAYERS][MAX_OWNABLE_HOUSES+1],
    /*ListedDamage[MAX_PLAYERS][MAX_DAMAGE],*/
    ListedTickets[MAX_PLAYERS][MAX_PLAYER_TICKETS],
    ListedInventory[MAX_PLAYERS][MAX_INVENTORY];

//NRN
new NameCounter[MAX_PLAYERS];

//Drinking
new PlayerDrinking[MAX_PLAYERS];
/*==============================================================================
    Global Variable
==============================================================================*/

new board[5];
new g_StatusOOC = 1, g_ServerLocked, Auction;
new Text:gLoginTextdraws, BillboardCheckout[MAX_PLAYERS], g_ServerRestart, g_RestartTime, fishzone[FISH_ZONE], g_MysqlRaceCheck[MAX_PLAYERS];

new selectCategory[MAX_PLAYERS] = {-1, ...}, selectIndex[MAX_PLAYERS] = {-1, ...};
new JailArea, NSArea, SAMDArea;//, production;

new fishNames[5][] = {
    "Carp", "Bass", "Cod", "Plaice", "Tuna"
};

/*==============================================================================
    Fixed Arrays
==============================================================================*/

new Float:NSArray[] =
{
    1169.8767,1975.7563,
    1125.5262,1973.4691,
    1121.7913,2010.0787,
    1170.5946,2012.2588
};

/*new Float:production_Array[] =
{
    1492.01, 1791.86,
    1491.96, 1786.34,
    1487.19, 1786.48,
    1487.16, 1792.00
};*/

new Float:SAMDArray[] =
{
    1808.91, -1222.62,
    1808.92, -1206.56,
    1803.65, -1206.56,
    1803.65, -1222.62
};

new Float:JailArray[] =
{
    -3436.51, 1586.94,
    -3436.66, 1553.46,
    -3415.43, 1551.47,
    -3414.27, 1586.35
};

// new Float:Woods[5][3] = {
//     {0.000, 1.440, 0.000},
//     {0.000, 0.070, 0.000},
//     {0.000, -1.130, 0.000},
//     {0.000, -2.650, 0.000},
//     {0.000, -4.239, 0.009}
// };

// new Float:WoodsCheckpoint[][3] = {
//     {-1425.3168,-1525.4558,101.7477},
//     {-284.5327,-2175.3335,28.6824},
//     {-2001.3712,-2414.0410,30.6250},
//     {-1119.2782,-1673.4211,76.3672},
//     {1558.4120,-27.9331,21.3384}
// };

//Small
new Float:zones_points_0[] = {
    710.0,-2085.0,140.0,-2085.0,140.0,-1807.0,-246.0,-1805.0,-272.0,-1879.0,-248.0,-1941.0,-228.0,-1997.0,-230.0,-2027.0,-212.0,-2061.0,-214.0,-2095.0,
    -216.0,-2135.0,-126.0,-2353.0,26.0,-2471.0,30.0,-2511.0,66.0,-2601.0,66.0,-2663.0,64.0,-2705.0,130.0,-2619.0,142.0,-2531.0,126.0,-2437.0,
    466.0,-2439.0,994.0,-2451.0,944.0,-2271.0,822.0,-2181.0,710.0,-2085.0
};

new Float:zones_points_10[] = {
    996.0,-2453.0,590.0,-2457.0,588.0,-2521.0,568.0,-2541.0,534.0,-2547.0,502.0,-2521.0,490.0,-2475.0,324.0,-2477.0,324.0,-2539.0,458.0,-2547.0,
    378.0,-2653.0,180.0,-2725.0,68.0,-2731.0,64.0,-2905.0,266.0,-2863.0,534.0,-2863.0,592.0,-2543.0,998.0,-2541.0,794.0,-2639.0,784.0,-2749.0,
    876.0,-2773.0,884.0,-2651.0,1138.0,-2737.0,996.0,-2453.0
};
new Float:zones_points_6[] = {
    266.0, -2865.0, 766.0, -2815.0
};
//Medium
new Float:zones_points_7[] = {
    994.0,-2453.0,128.0,-2453.0,142.0,-2531.0,130.0,-2619.0,172.0,-2711.0,366.0,-2645.0,436.0,-2559.0,214.0,-2547.0,214.0,-2461.0,994.0,-2453.0
};
new Float:zones_points_8[] = {
    996.0,-2543.0,596.0,-2545.0,530.0,-2865.0,766.0,-2867.0,912.0,-2815.0,738.0,-2751.0,700.0,-2753.0,696.0,-2663.0,996.0,-2543.0
};
new Float:zones_points_9[] = {
    886.0,-2651.0,1132.0,-2735.0,998.0,-2793.0,876.0,-2767.0,886.0,-2651.0
};
//Big
new Float:zones_points_1[] = {
    258.0, -2505.0, 43.0
};
new Float:zones_points_2[] = {
    546.0, -2505.0, 43.0
};
new Float:zones_points_3[] = {
    742.0, -2707.0, 43.0
};
new Float:zones_points_4[] = {
    370.0, -2737.0, 43.0
};
new Float:zones_points_5[] = {
    990.0, -2879.0, 43.0
};

new zones_text[FISH_ZONE][64] = {
    "Small",
    "Small",
    "Small ",
    "Medium",
    "Medium",
    "Medium",
    "Big",
    "Big",
    "Big",
    "Big",
    "Big"
};

enum g_accList
{
    accListType,
    accListModel,
    accListName[24]
};

new const accList[][g_accList] =
{
    //Cap
    {1,18955,"CapOverEye1"},
    {1,18956,"CapOverEye2"},
    {1,18957,"CapOverEye3"},
    {1,18958,"CapOverEye4"},
    {1,18959,"CapOverEye5"},
    {1,19553,"StrawHat1"},
    {1,19554,"Beanie1"},
    {1,19558,"19558"},
    {1,18639,"BlackHat1"},
    {1,18638,"HardHat1"},
    {1,19097,"CowboyHat4"},
    {1,19096,"CowboyHat3"},
    {1,18964,"SkullyCap1"},
    {1,18969,"HatMan1"},
    {1,18968,"HatMan2"},
    {1,18967,"HatMan3"},
    {1,18950,"HatBowler4"},
    {1,18948,"HatBowler2"},
    {1,18949,"HatBowler3"},
    {1,19137,"CluckinBellHat1"},
    {1,18926,"Hat1"},
    {1,18927,"Hat2"},
    {1,18928,"Hat3"},
    {1,18940,"CapBack3"},
    {1,18943,"CapBack5"},
    {1,18922,"Beret2"},
    {1,18921,"Beret1"},
    {1,18923,"Beret3"},
    {1,9067,"HoodyHat1"},
    {1,19069,"HoodyHat3"},
    {1,19161,"PoliceHat1"},

    //Bandana
    {2,18891, "Bandana1"},
    {2,18892, "Bandana2"},
    {2,18893, "Bandana3"},
    {2,18894, "Bandana4"},
    {2,18895, "Bandana5"},
    {2,18896, "Bandana6"},
    {2,18897, "Bandana7"},
    {2,18898, "Bandana8"},
    {2,18899, "Bandana9"},
    {2,18900, "Bandana10"},
    {2,18901, "Bandana11"},
    {2,18902, "Bandana12"},
    {2,18903, "Bandana13"},
    {2,18904, "Bandana14"},
    {2,18905, "Bandana15"},
    {2,18906, "Bandana16"},
    {2,18907, "Bandana17"},
    {2,18908, "Bandana18"},
    {2,18909, "Bandana19"},
    {2,18910, "Bandana20"},

    //Mask
    {3,18911, "Mask1"},
    {3,18912, "Mask2"},
    {3,18913, "Mask3"},
    {3,18914, "Mask4"},
    {3,18915, "Mask5"},
    {3,18916, "Mask6"},
    {3,18917, "Mask7"},
    {3,18918, "Mask8"},
    {3,18919, "Mask9"},
    {3,18920, "Mask10"},
    {3,19036,"HockeyMask1"},
    {3,18974,"MaskZorro1"},
    {3,19163,"GimpMask1"},

    //Helmet
    {4,19113, "SillyHelmet1"},
    {4,19114, "SillyHelmet2"},
    {4,19115, "SillyHelmet3"},
    {4,19116, "PlainHelmet1"},
    {4,19117, "PlainHelmet2"},
    {4,19118, "PlainHelmet3"},
    {4,19119, "PlainHelmet4"},
    {4,19120, "PlainHelmet5"},
    {4,18976, "MotorcycleHelmet2"},
    {4,18977, "MotorcycleHelmet3"},
    {4,18978, "MotorcycleHelmet4"},
    {4,18979, "MotorcycleHelmet5"},

    //Watch
    {5,19039, "WatchType1"},
    {5,19040, "WatchType2"},
    {5,19041, "WatchType3"},
    {5,19042, "WatchType4"},
    {5,19043, "WatchType5"},
    {5,19044, "WatchType6"},
    {5,19045, "WatchType7"},
    {5,19046, "WatchType8"},
    {5,19047, "WatchType9"},
    {5,19048, "WatchType10"},
    {5,19049, "WatchType11"},
    {5,19050, "WatchType12"},
    {5,19051, "WatchType13"},
    {5,19052, "WatchType14"},
    {5,19053, "WatchType15"},

    //Glasses
    {6,19006, "GlassesType1"},
    {6,19007, "GlassesType2"},
    {6,19008, "GlassesType3"},
    {6,19009, "GlassesType4"},
    {6,19010, "GlassesType5"},
    {6,19011, "GlassesType6"},
    {6,19012, "GlassesType7"},
    {6,19013, "GlassesType8"},
    {6,19014, "GlassesType9"},
    {6,19015, "GlassesType10"},
    {6,19016, "GlassesType11"},
    {6,19017, "GlassesType12"},
    {6,19018, "GlassesType13"},
    {6,19019, "GlassesType14"},
    {6,19020, "GlassesType15"},
    {6,19021, "GlassesType16"},
    {6,19022, "GlassesType17"},
    {6,19023, "GlassesType18"},
    {6,19024, "GlassesType19"},
    {6,19025, "GlassesType20"},
    {6,19026, "GlassesType21"},
    {6,19027, "GlassesType22"},
    {6,19028, "GlassesType23"},
    {6,19029, "GlassesType24"},
    {6,19030, "GlassesType25"},
    {6,19031, "GlassesType26"},
    {6,19032, "GlassesType27"},
    {6,19033, "GlassesType28"},
    {6,19034, "GlassesType29"},
    {6,19035, "GlassesType30"},

    //Misc
    {7,19896,"CigarettePack1"},
    {7,19897,"CigarettePack2"},
    {7,19904,"ConstructionVest1"},
    {7,19942,"PoliceRadio1"},
    {7,19801,"Balaclava1"},
    {7,19623,"Camera1"},
    {7,19624,"Case1"},
    {7,19559,"HikerBackpack1"},
    {7,19556,"BoxingGloveR"},
    {7,19555,"BoxingGloveL"},
    {7,19142,"SWATARMOUR1"},
    {7,19141,"SWATHELMET1"},
    {7,19520,"pilotHat01"},
    {7,19521,"policeHat01"},
    {7,19515,"SWATAgrey"},
    {7,19330,"fire_hat01"},
    {7,1550,"CJ_MONEY_BAG"},
    {7,19347,"badge01"},
    {7,371,"gun_para"},
    {7,2919,"kmb_holdall"}
};

enum e_InventoryItems {
    e_InventoryItem[32],
    e_InventoryModel,
    e_InventoryMax,
    bool:e_InventoryDrop
};

new const g_aInventoryItems[][e_InventoryItems] = {
    {"Marijuana", 1578, 1000, true},
    {"Ecstasy", 1578, 1000, true},
    {"LSD", 1578, 1000, true},
    {"Cocaine", 1575, 1000, true},
    {"Heroin", 1577, 1000, true},
    {"Steroids", 1241, 1000, true},
    {"Marijuana Seeds", 1578, 250, false},
    {"Cocaine Seeds", 1575, 250, false},
    {"Heroin Opium Seeds", 1577, 250, false},
    {"Cooked Burger", 2703, 5, true},
    {"Cooked Pizza", 2702, 5, true},
    {"Cooked Fish", 19630, 5, true},
    {"Cellphone", 330, 1, false},
    {"GPS System", 18875, 1, false},
    {"Spray Can", 365, 3, false},
    {"Fuel Can", 1650, 3, true},
    {"Crowbar", 18634, 1, true},
    {"Mask", 19036, 1, false},
    {"First Aid", 1580, 3, true},
    {"Frozen Pizza", 2814, 5, true},
    {"Frozen Burger", 2768, 5, true},
    {"Armored Vest", 19142, 1, false},
    {"Chicken", 2663, 5, true},
    {"Portable Radio", 18868, 1, false},
    {"Component", 18633, 2000, false},
    {"Fish Rod", 18632, 1, true},
    {"Bait", 19630, 100, false},
    {"Snack", 2768, 5, true},
    {"Kunci Gubuk", 11746, 1, true},
    {"Materials", 11746, 50000, false},
    {"Water", 1484, 5, true},
    {"Laptop", 19893, 1, true},
    {"Stamps", 2059, 50000, false},
    {"Neladryl Acetate", 2709, 10, false},
    {"Kratotamax Plus 1.0", 2709, 10, false},
    {"Lazattavitus Extra", 2709, 10, false},
    {"Campfire", 19632, 1, true},
    {"Cow Meat", 2804, 15, true},
    {"Deer Meat", 2804, 15, true},
    {"MP3 Player", 18875, 1, false},
    {"Bobby Pin", 11746, 20, false},
    {"Cigarettes", 19896, 20, false},
    {"Kevlar Vest", 373, 10, false},
    {"Wheat Plant", 743, 30, false}
};

enum e_Cargo {
    Float:cX,
    Float:cY,
    Float:cZ,
    cType[16],
    cPrice
};

stock const Float:arrHospitalDeliver[][3] = {
    {-2692.6580, 635.4608, 14.4531},
    {-334.9757, 1063.0171, 19.7392},
    {1579.9666, 1767.1462, 10.8203},
    {1177.8599, -1308.3982, 13.8301},
    {2024.4246, -1404.1580, 17.2020},
    {1243.9304, 331.4186, 19.5547}
};

stock const Float:arrAdminJail[][4] = {
    { -662.9457, 2387.1042, 161.1497, 262.1245 },
    { -662.9703, 2383.8120, 161.1497, 267.3467 },
    { -663.0639, 2380.8518, 161.1497, 266.7199 },
    { -662.8998, 2377.5854, 161.1497, 263.1688 },
    { -662.7150, 2374.2581, 161.1497, 268.4955 },
    { -662.6577, 2370.9348, 161.1497, 268.8087 },
    { -643.2560, 2370.8784, 161.1497, 89.9983 },
    { -643.1832, 2374.2544, 161.1497, 88.1183 },
    { -643.3958, 2377.4780, 161.1497, 85.9250 },
    { -643.2233, 2380.6394, 161.1497, 88.6405 },
    { -643.2049, 2383.8350, 161.1497, 88.8494 },
    { -643.1349, 2387.1594, 161.1497, 87.0971 }
};

stock const Float:arrModshop[][3] = {
    {2246.1946,-2016.3121,13.5469},
    {2254.0725,-2016.3597,13.5469},
    {2261.1731,-2016.5896,13.5429},
    {2267.9636,-2016.4058,13.5430},
    {2275.3857,-2016.4050,13.5430},
    {2282.2642,-2016.2533,13.5430}
};
stock Float:prisonzone[] = {
    287.9440, 1485.6139,
    110.1903, 1485.4751,
    110.3721, 1335.2150,
    288.4406, 1335.0648
};

stock Float:parkingzone[] = {
    1611.4738,-1140.7721,
    1610.4360,-1081.3734,
    1661.4900,-1077.7687,
    1659.8763,-1140.9791
};

stock Float:insurancezone[] = {
    1111.0923,-1731.6001,
    1111.6676,-1807.6343,
    1054.0153,-1807.4988,
    1055.4120,-1731.5062
};


stock Float:lszone[] = {
    1617.6521,-1583.0151,
    1617.6741,-1865.7930,
    1382.1992,-1864.9624,
    1383.0245,-1549.5415
};

stock Float:hospitalzone[] = {
    1247.2733,-1388.2351,
    1249.2280,-1287.8173,
    1070.2064,-1288.3540,
    1070.0472,-1388.0856
};

stock Float:lsbszone[] = {
    1053.8552,-1389.9081,
    921.6613,-1389.7572,
    923.8369,-1299.7631,
    1047.7202,-1291.5868
};

stock Float:lsbankzone[] = {
    563.9460,-1252.7360,
    790.5073,-1221.1792,
    790.0660,-1389.5959,
    593.3109,-1392.4103
};

stock Float:smbzone[] = {
    50.0206,-1775.7719,
    168.5811,-1776.3425,
    173.8938,-1981.9022,
    46.1569,-1968.7955
};

stock Float:mekanikzone[] = {
    2500.5247,-1515.0846,
    2500.8113,-1565.1672,
    2540.3713,-1565.1637,
    2540.2966,-1515.0743
};

stock Float:mekanikrepair[][] = {
    {
        2508.8662,-1552.8523,
        2526.7703,-1553.3390,
        2526.6479,-1564.5950,
        2509.3992,-1564.1813
    },
    {
        2525.9558,-1555.1058,
        2525.1060,-1538.2097,
        2537.2957,-1538.1779,
        2537.2957,-1555.4388
    }
};

stock Float:mekanikzoneship[] = {
    2553.96, -2261.73,
    2613.58, -2261.56,
    2613.58, -2244.96,
    2553.86, -2245.76
};

stock Float:ganjazone[] = {
    -328.0,-1474.0,
    -331.0,-1558.0,
    -242.0,-1556.0,
    -214.0,-1469.0,
    -328.0,-1474.0,
    -322.0,-1315.0,
    -331.0,-1429.0,
    -164.0,-1415.0,
    -165.0,-1302.0,
    322.0,-1315.0,
    -588.0,-1294.0,
    -588.0,-1408.0,
    -557.0,-1433.0,
    -401.0,-1396.0,
    -377.0,-1370.0,
    -345.0,-1265.0,
    -588.0,-1294.0
};

stock Float:ganjabb1[] = {
    18.03, 68.61,
    36.09, 61.51,
    83.19, 26.81,
    80.33, -15.94,
    71.00, -51.39,
    39.27, -8.98,
    21.80, 10.31,
    7.15, 36.62
};

stock Float:ganjabb2[] = {
    -11.91, 4.18,
    20.15, -29.27,
    30.30, -43.11,
    43.73, -65.67,
    57.95, -98.22,
    45.02, -117.38,
    26.26, -122.91,
    -51.62, -110.22,
    -30.51, -37.09
};

stock Float:ganjabb3[] = {
    -98.35, 150.58,
    -183.27, 177.71,
    -203.56, 178.55,
    -220.20, 143.06,
    -188.02, 118.25,
    -144.55, 99.71,
    -117.16, 92.83
};

stock Float:ganjabb4[] = {
    -119.46, 61.62,
    -232.13, 105.63,
    -245.99, 78.38,
    -265.90, 21.05,
    -281.24, -38.51,
    -279.28, -54.50,
    -269.12, -68.77,
    -242.12, -82.36,
    -211.49, -87.72,
    -181.61, -86.67,
    -167.78, -63.34
};

stock Float:ganjadillimore[] = {
    760.49, -223.87,
    777.36, -222.54,
    853.08, -222.64,
    852.89, -256.93,
    899.32, -300.87,
    967.42, -298.20,
    999.47, -290.04,
    1001.73, -327.69,
    1001.43, -392.01,
    944.48, -380.77,
    906.92, -367.20,
    774.61, -273.95,
    740.01, -264.28,
    740.05, -243.79
};
//
stock Float:ganjapalo[] = {
    2006.47, 168.31,
    2007.83, 237.86,
    1914.55, 248.48,
    1909.04, 224.44,
    1908.06, 203.66,
    1908.81, 190.49,
    1964.22, 172.43
};

stock const accBones[][24] = {
    {"Spine"},
    {"Head"},
    {"Left upper arm"},
    {"Right upper arm"},
    {"Left hand"},
    {"Right hand"},
    {"Left thigh"},
    {"Right thigh"},
    {"Left foot"},
    {"Right foot"},
    {"Right calf"},
    {"Left calf"},
    {"Left forearm"},
    {"Right forearm"},
    {"Left clavicle"},
    {"Right clavicle"},
    {"Neck"},
    {"Jaw"}
};


stock const Float:g_arrWeaponDamage[] = {
    1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
    1.0, 1.0, 1.0, 1.0, 82.5, 0.0, 1.0, 9.9, 46.2, 0.0, 8.25, 13.2,
    46.2, 3.3, 3.3, 4.95, 6.6, 8.25, 9.9, 9.9, 6.6, 24.75, 41.25,
    82.5, 82.5, 1.0, 46.2, 82.5, 0.0, 0.33, 0.33, 0.0, 0.0, 0.0,
    0.0, 0.0, 2.64, 9.9, 330.0, 82.5, 1.0, 1.0, 165.0
};

stock const g_aPreloadLibs[][] =
{
    "AIRPORT",      "ATTRACTORS",   "BAR",          "BASEBALL",     "BD_FIRE",
    "BEACH",        "BENCHPRESS",   "BF_INJECTION", "BIKE_DBZ",     "BIKED",
    "BIKEH",        "BIKELEAP",     "BIKES",        "BIKEV",        "BLOWJOBZ",
    "BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
    "BUS",          "CAMERA",       "CAR",          "CAR_CHAT",     "CARRY",
    "CASINO",       "CHAINSAW",     "CHOPPA",       "CLOTHES",      "COACH",
    "COLT45",       "COP_AMBIENT",  "COP_DVBYZ",    "CRACK",        "CRIB",
    "DAM_JUMP",     "DANCING",      "DEALER",       "DILDO",        "DODGE",
    "DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
    "FIGHT_D",      "FIGHT_E",      "FINALE",       "FINALE2",      "FLAME",
    "FLOWERS",      "FOOD",         "FREEWEIGHTS",  "GANGS",        "GFUNK",
    "GHANDS",       "GHETTO_DB",    "GOGGLES",      "GRAFFITI",     "GRAVEYARD",
    "GRENADE",      "GYMNASIUM",    "HAIRCUTS",     "HEIST9",       "INT_HOUSE",
    "INT_OFFICE",   "INT_SHOP",     "JST_BUISNESS", "KART",         "KISSING",
    "KNIFE",        "LAPDAN1",      "LAPDAN2",      "LAPDAN3",      "LOWRIDER",
    "MD_CHASE",     "MD_END",       "MEDIC",        "MISC",         "MTB",
    "MUSCULAR",     "NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",
    "PARK",         "PAULNMAC",     "PED",          "PLAYER_DVBYS", "PLAYIDLES",
    "POLICE",       "POOL",         "POOR",         "PYTHON",       "QUAD",
    "QUAD_DBZ",     "RAPPING",      "RIFLE",        "RIOT",         "ROB_BANK",
    "ROCKET",       "RUNNINGMAN",   "RUSTLER",      "RYDER",        "SCRATCHING",
    "SEX",          "SHAMAL",       "SHOP",         "SHOTGUN",      "SILENCED",
    "SKATE",        "SMOKING",      "SNIPER",       "SNM",          "SPRAYCAN",
    "STRIP",        "SUNBATHE",     "SWAT",         "SWEET",        "SWIM",
    "SWORD",        "TANK",         "TATTOOS",      "TEC",          "TRAIN",
    "TRUCK",        "UZI",          "VAN",          "VENDING",      "VORTEX",
    "WAYFARER",     "WEAPONS",      "WOP",          "WUZI"
};


// stock Float:safezone_0[] = {
//     619.0, -1395.5,
//     795.0, -1395.5, 
//     619.0, -1315.5,
//     795.0, -1315.5
// };
// stock Float:safezone_1[] = {
//     1324.0, -2661.5,
//     2100.0, -2661.5, 
//     1324.0, -2174.5,
//     2100.0, -2174.5
// };
// stock Float:safezone_2[] = {
//     1063.0, -2260.5,
//     1520.0, -2260.5, 
//     1063.0, -1882.5,
//     1520.0, -1882.5
// };

// stock Float:safezone_3[] = {
//     1129.0, -2380.5,
//     1324.0, -2380.5, 
//     1129.0, -2260.5,
//     1324.0, -2260.5
// };

// stock Float:safezone_4[] = {
//     1040.0, -1844.5,
//     1291.0, -1844.5, 
//     1040.0, -1714.5,
//     1291.0, -1714.5
// };

// stock Float:safezone_5[] = {
//     1038.0, -1714.5,
//     1291.0, -1714.5, 
//     1038.0, -1581.5,
//     1291.0, -1581.5
// };

// stock Float:safezone_6[] = {
//     1319.0, -1876.5,
//     1587.0, -1876.5, 
//     1319.0, -1581.5,
//     1587.0, -1581.5
// };

// stock Float:safezone_7[] = {
//     1518.0, -1766.5,
//     1618.0, -1766.5, 
//     1518.0, -1666.5,
//     1618.0, -1666.5
// };

// stock Float:safezone_8[] = {
//     1690.0, -1950.5,
//     1810.0, -1950.5, 
//     1690.0, -1806.5,
//     1810.0, -1806.5
// };

// stock Float:safezone_9[] = {
//     2001.0, -2096.5,
//     2104.0, -2096.5, 
//     2001.0, -1966.5,
//     2104.0, -1966.5
// };

// stock Float:safezone_10[] = {
//     1983.0, -1451.5,
//     2101.0, -1451.5, 
//     1983.0, -1352.5,
//     2101.0, -1352.5
// };

// stock Float:safezone_11[] = {
//     2211.0, -1380.5,
//     2272.0, -1380.5, 
//     2211.0, -1298.5,
//     2272.0, -1298.5
// };

// stock Float:safezone_12[] = {
//     1025.0, -1568.5,
//     1215.0, -1568.5, 
//     1025.0, -1389.5,
//     1215.0, -1389.5
// };

// stock Float:safezone_13[] = {
//     1067.0, -1389.5,
//     1253.0, -1389.5, 
//     1067.0, -1276.5,
//     1253.0, -1276.5
// };

// stock Float:safezone_14[] = {
//     803.0, -1315.5,
//     938.0, -1315.5, 
//     803.0, -1154.5,
//     938.0, -1154.5
// };

// stock Float:safezone_15[] = {
//     506.0, -1315.5,
//     619.0, -1315.5, 
//     506.0, -1237.5,
//     619.0, -1237.5
// };

// stock Float:safezone_16[] = {
//     601.0, -612.4,
//     676.9, -612.4,  
//     601.0, -534.4,
//     676.9, -534.4
// };
