
enum houseInteriors {
    eHouseInterior,
    Float:eHouseX,
    Float:eHouseY,
    Float:eHouseZ,
    Float:eHouseAngle,
    string:eHouseDesc[64]
};

new const Float:arrHouseInteriors[16][houseInteriors] = {
    {3, 1875.9360, -2408.6245, 13.5845, 176.9765, "Small House"},
    {4, 1882.1200, -2434.8401, 13.5845, 358.3110, "Medium House"},
    {5, 1882.1200, -2434.8401, 13.5845, 358.3110, "Large House"},
    {1, 2556.0383, 633.4515, 21.2615, 1.7381, "House Interior #1"},
    {1, 2736.6782, 662.4202, 14.6852, 3.9311, "House Interior #2"},
    {1, 855.3284, 2215.3530, 13.4289, 1.8198, "House Interior #3"},
    {1, -148.2302, 2826.3831, 89.2977, 89.2438, "House Interior #4"},
    {1, 2503.7449, 1085.5264, 21.7483, 0.0287, "House Interior #5"},
    {1, 2198.8848, 2853.9248, 13.3265, 86.9946, "House Interior #6"},
    {1, 1954.1510, 2818.2856, 13.8840, 0.3487, "House Interior #7"},
    {1, 2908.1392, 2221.6880, 16.6550, 0.9005, "House Interior #8"},
    {1, 2599.3940, 2902.4700, 14.6350, 0.9634, "House Interior #9"},
    {1, 2359.5508, 968.1644, 20.9434, 269.2414, "House Interior #10"},
    {1, 2909.0598, 1069.3241, 14.4375, 359.1456, "House Interior #11"},
    {2, 1605.3278, 1777.5321, 37.3125, 182.2300, "Gas Station Super #1"},
    {1, -270.3460, 1553.3621, 79.6461, 359.5221, "Electronic Shop #1"}
};

stock const ObjectList[][] = {
    {18244, "cuntw_stwnmotsign1"},
    {9314, "advert01_sfn"},
    {19475, "Plane001"},
    {19475, "Plane001"},
    {19476, "Plane002"},
    {19477, "Plane003"},
    {19478, "Plane004"},
    {19479, "Plane005"},
    {19480, "Plane006"},
    {19481, "Plane007"},
    {19482, "Plane008"},
    {19483, "Plane009"}
};

stock const FontSizes[][] = {
    {OBJECT_MATERIAL_SIZE_32x32, "32x32" },
    {OBJECT_MATERIAL_SIZE_64x32, "64x32" },
    {OBJECT_MATERIAL_SIZE_64x64, "64x64" },
    {OBJECT_MATERIAL_SIZE_128x32, "128x32" },
    {OBJECT_MATERIAL_SIZE_128x64, "128x64" },
    {OBJECT_MATERIAL_SIZE_128x128, "128x128" },
    {OBJECT_MATERIAL_SIZE_256x32, "256x32" },
    {OBJECT_MATERIAL_SIZE_256x64, "256x64" },
    {OBJECT_MATERIAL_SIZE_256x128 ,"256x128" },
    {OBJECT_MATERIAL_SIZE_256x256 ,"256x256" },
    {OBJECT_MATERIAL_SIZE_512x64, "512x64" },
    {OBJECT_MATERIAL_SIZE_512x128, "512x128" },
    {OBJECT_MATERIAL_SIZE_512x256, "512x256" },
    {OBJECT_MATERIAL_SIZE_512x512, "512x512" }
};

stock const AvailableColor[][] =
{
    {0xFFFF0000, "Red" },
    {0xFFFFFFFF, "White" },
    {0xFF00FFFF, "Cyan" },
    {0xFFC0C0C0, "Silver" },
    {0xFF0000FF, "Blue" },
    {0xFF808080, "Grey" },
    {0xFF0000A0, "Dark Blue" },
    {0xFF000000, "Black" },
    {0xFF33CCFF, "Lightblue" },
    {0xFFFFA500, "Orange" },
    {0xFF800080, "Pfrple" },
    {0xFFA52A2A, "Brown" },
    {0xFFFFFF00, "Yellow" },
    {0xFF800000, "Maroon" },
    {0xFF00FF00, "Lime" },
    {0xFF008000, "Green" },
    {0xFFFF00FF, "Fuchsia" },
    {0xFF808000, "Olive" }
};

stock const g_arrVehicleNames[][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

stock const Float:g_arrDrivingCheckpoints[][] = {
    {1150.3688, -1674.3969, 13.78},
    {1150.2283,-1572.1079,13.27},
    {1297.3367,-1572.0890,13.38},
    {1297.2411,-1852.5016,13.38},
    {1425.4194,-1872.4116,13.38},
    {1570.5751,-1872.4644,13.38},
    {1570.8784,-1730.0461,13.38},
    {1433.7212,-1731.0153,13.38},
    {1312.3274,-1731.7233,13.38},
    {1312.2893,-1570.4691,13.38},
    {1357.0247,-1396.8232,13.33},
    {1194.7001,-1397.0439,13.23},
    {1194.1786,-1570.1896,13.38},
    {1149.6901,-1571.1787,13.27},
    {1149.1445,-1675.4083,13.78},
    {1134.4229,-1676.0897,13.75}
};

new g_aMaleSkins[210] = {
    1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
    30, 32, 33, 34, 35, 36, 37, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60,
    61, 62, 66, 68, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102,
    103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
    121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146,
    147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170, 171, 173, 174, 175, 176,
    177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 200, 202, 203, 204, 206,
    208, 209, 210, 212, 213, 217, 220, 221, 222, 223, 228, 229, 230, 234, 235, 236, 239, 240,
    241, 242, 247, 248, 249, 250, 253, 254, 255, 258, 259, 260, 261, 262, 268, 272, 273, 289,
    290, 291, 292, 293, 294, 295, 296, 297, 299, 303, 304, 305, 20003, 20004, 20005, 20006, 20007, 20008,
    20009, 20010, 20011, 20012, 20013, 20014, 20015, 20016, 20017, 20018, 20019, 20020, 20021,
    20058, 20060, 20061

};


new g_aFemaleSkins[78] = {
    9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69,
    75, 76, 77, 85, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 140, 141,
    145, 148, 150, 151, 152, 157, 169, 178, 190, 191, 192, 193, 194, 195,
    196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 219, 224, 225,
    226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263,
    298, 20059
};
