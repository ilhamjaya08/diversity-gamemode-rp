
enum e_FurnitureData {
    e_FurnitureType,
    e_FurnitureName[50],
    e_FurnitureModel
};

stock const g_aFurnitureTypes[][] = {
    {"Frames"},
    {"Tables"},
    {"Chairs"},
    {"Beds"},
    {"Cabinets"},
    {"Television Sets"},
    {"Kitchen Appliances"},
    {"Bathroom Appliances"},
    {"Misc Furniture"},
    {"Newest Furniture"}
};

new const g_aFurnitureData[][e_FurnitureData] = {
    {1, "Frame 1", 2289},
    {1, "Frame 2", 2288},
    {1, "Frame 3", 2287},
    {1, "Frame 4", 2286},
    {1, "Frame 5", 2285},
    {1, "Frame 6", 2284},
    {1, "Frame 7", 2283},
    {1, "Frame 8", 2282},
    {1, "Frame 9", 2281},
    {1, "Frame 10", 2280},
    {1, "Frame 11", 2279},
    {1, "Frame 12", 2278},
    {1, "Frame 13", 2277},
    {1, "Frame 14", 2276},
    {1, "Frame 15", 2275},
    {1, "Frame 16", 2274},
    {1, "Frame 17", 2273},
    {1, "Frame 18", 2272},
    {1, "Frame 19", 2271},
    {1, "Frame 20", 2270},
    {1, "Frame 21", 2267},
    {1, "Frame 22", 2283},
    {2, "Table 1", 1433},
    {2, "Table 2", 1998},
    {2, "Table 3", 2008},
    {2, "Table 4", 2180},
    {2, "Table 5", 2185},
    {2, "Table 6", 2205},
    {2, "Table 7", 2314},
    {2, "Table 8", 2635},
    {2, "Table 9", 2637},
    {2, "Table 10", 2644},
    {2, "Table 11", 2747},
    {2, "Table 12", 2764},
    {2, "Table 13", 2763},
    {2, "Table 14", 2762},
    {2, "Table 15", 936},
    {2, "Table 16", 937},
    {2, "Table 17", 941},
    {2, "Table 18", 2115},
    {2, "Table 19", 2116},
    {2, "Table 20", 2112},
    {2, "Table 21", 2111},
    {2, "Table 22", 2110},
    {2, "Table 23", 2109},
    {2, "Table 24", 2085},
    {2, "Table 25", 2032},
    {2, "Table 26", 2031},
    {2, "Table 27", 2030},
    {2, "Table 28", 2029},
    {2, "Table 29", 2357},
    {2, "Table 30", 11689},
    {2, "Table 31", 2236},
    {2, "Table 32", 2081},
    {3, "Chair 1", 1671},
    {3, "Chair 2", 1704},
    {3, "Chair 3", 1705},
    {3, "Chair 4", 1708},
    {3, "Chair 5", 1711},
    {3, "Chair 6", 1715},
    {3, "Chair 7", 1721},
    {3, "Chair 8", 1724},
    {3, "Chair 9", 1727},
    {3, "Chair 10", 1729},
    {3, "Chair 11", 1735},
    {3, "Chair 12", 1739},
    {3, "Chair 13", 1805},
    {3, "Chair 14", 1806},
    {3, "Chair 15", 1810},
    {3, "Chair 16", 1811},
    {3, "Chair 17", 2079},
    {3, "Chair 18", 2120},
    {3, "Chair 19", 2124},
    {3, "Chair 20", 2356},
    {3, "Chair 21", 1768},
    {3, "Chair 22", 1766},
    {3, "Chair 23", 1764},
    {3, "Chair 24", 1763},
    {3, "Chair 25", 1761},
    {3, "Chair 26", 1760},
    {3, "Chair 27", 1757},
    {3, "Chair 28", 1756},
    {3, "Chair 29", 1753},
    {3, "Chair 30", 1713},
    {3, "Chair 31", 1712},
    {3, "Chair 32", 1706},
    {3, "Chair 33", 1703},
    {3, "Chair 34", 1702},
    {3, "Chair 35", 1754},
    {3, "Chair 36", 1755},
    {3, "Chair 37", 1758},
    {3, "Chair 38", 1759},
    {3, "Chair 39", 1762},
    {3, "Chair 40", 1765},
    {3, "Chair 41", 1767},
    {3, "Chair 42", 1769},
    {4, "Bed 1", 1700},
    {4, "Bed 2", 1701},
    {4, "Bed 3", 1725},
    {4, "Bed 4", 1745},
    {4, "Bed 5", 1793},
    {4, "Bed 6", 1794},
    {4, "Bed 7", 1795},
    {4, "Bed 8", 1796},
    {4, "Bed 9", 1797},
    {4, "Bed 10", 1771},
    {4, "Bed 11", 1798},
    {4, "Bed 12", 1799},
    {4, "Bed 13", 1800},
    {4, "Bed 14", 1801},
    {4, "Bed 15", 1802},
    {4, "Bed 16", 1812},
    {4, "Bed 17", 2090},
    {4, "Bed 18", 2299},
    {4, "Bed 19", 11720},
    {5, "Cabinet 1", 1416},
    {5, "Cabinet 2", 1417},
    {5, "Cabinet 3", 1741},
    {5, "Cabinet 4", 1742},
    {5, "Cabinet 5", 1743},
    {5, "Cabinet 6", 2025},
    {5, "Cabinet 7", 2065},
    {5, "Cabinet 8", 2066},
    {5, "Cabinet 9", 2067},
    {5, "Cabinet 10", 2087},
    {5, "Cabinet 11", 2088},
    {5, "Cabinet 12", 2094},
    {5, "Cabinet 13", 2095},
    {5, "Cabinet 14", 2306},
    {5, "Cabinet 15", 2307},
    {5, "Cabinet 16", 2323},
    {5, "Cabinet 17", 2328},
    {5, "Cabinet 18", 2329},
    {5, "Cabinet 19", 2330},
    {5, "Cabinet 20", 2708},
    {5, "Cabinet 21", 2164},
    {6, "Television 1", 1518},
    {6, "Television 2", 1717},
    {6, "Television 3", 1747},
    {6, "Television 4", 1748},
    {6, "Television 5", 1749},
    {6, "Television 6", 1750},
    {6, "Television 7", 1752},
    {6, "Television 8", 1781},
    {6, "Television 9", 1791},
    {6, "Television 10", 1792},
    {6, "Television 11", 2312},
    {6, "Television 12", 2316},
    {6, "Television 13", 2317},
    {6, "Television 14", 2318},
    {6, "Television 15", 2320},
    {6, "Television 16", 2595},
    {6, "Television 17", 16377},
    {6, "Television 18", 1429},
    {7, "Kitchen 1", 2013},
    {7, "Kitchen 2", 2017},
    {7, "Kitchen 3", 2127},
    {7, "Kitchen 4", 2130},
    {7, "Kitchen 5", 2131},
    {7, "Kitchen 6", 2132},
    {7, "Kitchen 7", 2135},
    {7, "Kitchen 8", 2136},
    {7, "Kitchen 9", 2144},
    {7, "Kitchen 10", 2147},
    {7, "Kitchen 11", 2149},
    {7, "Kitchen 12", 2150},
    {7, "Kitchen 13", 2415},
    {7, "Kitchen 14", 2417},
    {7, "Kitchen 15", 2421},
    {7, "Kitchen 16", 2426},
    {7, "Kitchen 17", 2014},
    {7, "Kitchen 18", 2015},
    {7, "Kitchen 19", 2016},
    {7, "Kitchen 20", 2018},
    {7, "Kitchen 21", 2019},
    {7, "Kitchen 22", 2022},
    {7, "Kitchen 23", 2133},
    {7, "Kitchen 24", 2134},
    {7, "Kitchen 25", 2137},
    {7, "Kitchen 26", 2138},
    {7, "Kitchen 27", 2139},
    {7, "Kitchen 28", 2140},
    {7, "Kitchen 29", 2141},
    {7, "Kitchen 30", 2142},
    {7, "Kitchen 31", 2143},
    {7, "Kitchen 32", 2145},
    {7, "Kitchen 33", 2148},
    {7, "Kitchen 34", 2151},
    {7, "Kitchen 35", 2152},
    {7, "Kitchen 36", 2153},
    {7, "Kitchen 37", 2154},
    {7, "Kitchen 38", 2155},
    {7, "Kitchen 39", 2156},
    {7, "Kitchen 40", 2157},
    {7, "Kitchen 41", 2158},
    {7, "Kitchen 42", 2159},
    {7, "Kitchen 43", 2160},
    {7, "Kitchen 44", 2134},
    {7, "Kitchen 45", 2135},
    {7, "Kitchen 46", 2338},
    {7, "Kitchen 47", 2341},
    {8, "Kitchen 48", 15036},
    {8, "Bathroom 1", 2514},
    {8, "Bathroom 2", 2516},
    {8, "Bathroom 3", 2517},
    {8, "Bathroom 4", 2518},
    {8, "Bathroom 5", 2520},
    {8, "Bathroom 6", 2521},
    {8, "Bathroom 7", 2522},
    {8, "Bathroom 8", 2523},
    {8, "Bathroom 9", 2524},
    {8, "Bathroom 10", 2525},
    {8, "Bathroom 11", 2526},
    {8, "Bathroom 12", 2527},
    {8, "Bathroom 13", 2528},
    {8, "Bathroom 14", 2738},
    {8, "Bathroom 15", 2739},
    {9, "Washer", 1208},
    {9, "Ceiling Fan", 1661},
    {9, "Ceiling Fan 2", 1657},
    {9, "Moose Head", 1736},
    {9, "Radiator", 1738},
    {9, "Mop and Pail", 1778},
    {9, "Water Cooler", 1808},
    {9, "Water Cooler 2", 2002},
    {9, "Money Safe", 1829},
    {9, "Printer", 2186},
    {9, "Computer", 2190},
    {9, "Treadmill", 2627},
    {9, "Bench Press", 2629},
    {9, "Exercise Bike", 2630},
    {9, "Mat 1", 2631},
    {9, "Mat 2", 2632},
    {9, "Mat 3", 2817},
    {9, "Mat 4", 2818},
    {9, "Mat 5", 2833},
    {9, "Mat 6", 2834},
    {9, "Mat 7", 2835},
    {9, "Mat 8", 2836},
    {9, "Mat 9", 2841},
    {9, "Mat 10", 2842},
    {9, "Mat 11", 2847},
    {9, "Book Pile 1", 2824},
    {9, "Book Pile 2", 2826},
    {9, "Book Pile 3", 2827},
    {9, "Basketball", 2114},
    {9, "Lamp 1", 2108},
    {9, "Lamp 2", 2106},
    {9, "Lamp 3", 2069},
    {9, "Lamp 4", 2074},
    {9, "Dresser 1", 2569},
    {9, "Dresser 2", 2570},
    {9, "Dresser 3", 2573},
    {9, "Dresser 4", 2574},
    {9, "Dresser 5", 2576},
    {9, "Book", 2894},
    {9, "Fireplace", 11725},
    {9, "Disk Jockey Stuff", 14820},
    {9, "Wash Tuffle", 19927},
    {9, "CCTV Monitor", 2606},
    {10, "Small Talk Toilet", 2514},
    {10, "Baby Toilet", 2521},
    {10, "Chique Toilet", 2528},
    {10, "Police Cell Toilet", 2602},
    {10, "Toilet Toilet", 2738},
    {10, "Toilet Paper", 19873},
    {10, "Soft White Sink", 2515},
    {10, "Regular Sink", 2518},
    {10, "Chique Du Sink", 2523},
    {10, "Bright White Sink", 2524},
    {10, "Retro Sink", 11709},
    {10, "Sprunk Bath", 2097},
    {10, "Regular Bath", 2516},
    {10, "Regular Bath 2", 2519},
    {10, "Bath Decor", 2522},
    {10, "Mac Bath", 2526},
    {10, "Heart Bath", 11732},
    {10, "Regular Shower", 2517},
    {10, "Regular Shower 2", 2520},
    {10, "Mac Shower", 2527},
    {10, "The Queen Elizabeth", 1700},
    {10, "The King George", 1701},
    {10, "Prisoner's Dream", 1771},
    {10, "Regular Bed", 1794},
    {10, "Swanky Bed", 1795},
    {10, "Swanky Bed 2", 1798},
    {10, "Swanky Bed 3", 2298},
    {10, "Wooden Bed", 1804},
    {10, "Bed and Cup", 2301},
    {10, "Luxury Bed", 2563},
    {10, "Dark Luxury Bed", 2566},
    {10, "Twin Hotel Beds", 2564},
    {10, "Twin Dark Hotel Beds", 2565},
    {10, "Red Love Bed", 11720},
    {10, "Heart Bed", 11731},
    {10, "Zebra Bed", 14446},
    {10, "Bed Set", 15035},
    {10, "Bed Set 2", 15039},
    {10, "Wheel Chair", 1369},
    {10, "Office Chair", 1671},
    {10, "Office Chair 2", 1714},
    {10, "Swivel Chair", 1715},
    {10, "Dark Blue Chair", 1704},
    {10, "Brown Chair", 1705},
    {10, "Blue Seat", 1708},
    {10, "Restaurant Chair", 1720},
    {10, "Waiting Room Chair", 1722},
    {10, "Grandma's Seat", 1735},
    {10, "Dining Chair", 1739},
    {10, "Luxury Dining Chair", 2122},
    {10, "Luxury Dining Chair 2", 2123},
    {10, "Barber's Chair", 2343},
    {10, "Chair and Speakers", 11665},
    {10, "Ol' Grandpa's", 11734},
    {10, "Brown Couch", 1702},
    {10, "Blue Couch", 1703},
    {10, "Pfrple Couch", 1706},
    {10, "Funky Couch", 1707},
    {10, "Dusty Couch", 1712},
    {10, "Big Blue Couch", 1713},
    {10, "Leather Couch", 1753},
    {10, "Gangland Couch", 1756},
    {10, "Gangland Couch 2", 1760},
    {10, "Gangland Couch 3", 1764},
    {10, "Swanky Couch", 2290},
    {10, "Love Couch", 11717},
    {10, "Rich Mahogany Door", 1491},
    {10, "Rich Mahogany Door 2", 1502},
    {10, "ShitInc. Door", 1492},
    {10, "ShitInc. Door 2", 1493},
    {10, "Wired Door", 1495},
    {10, "Wired Door 2", 1500},
    {10, "Wired Door 3", 1501},
    {10, "Heavy Door", 1496},
    {10, "Heavy Door 2", 1497},
    {10, "Red Door", 1504},
    {10, "Blue Door", 1505},
    {10, "White Door", 1506},
    {10, "Yellow Door", 1507},
    {10, "Lab Door", 1523},
    {10, "Alex Inc. Door", 1536},
    {10, "Pink Door", 1535},
    {10, "Chique Door", 1557},
    {10, "Jail Door", 19302},
    {10, "Cage Wall", 19304},
    {10, "Elevator Door", 18756},
    {10, "Big Blue Door", 11714},
    {10, "Chique Metal Pillar", 3440},
    {10, "Chinese Pillar", 3533},
    {10, "Roman Pillar", 19943},
    {10, "Security Camera", 1616},
    {10, "Security Camera 2", 1622},
    {10, "Whiteboi Fridge", 2131},
    {10, "Whiteboi Sink", 2132},
    {10, "Whiteboi Kitchen cabs", 2133},
    {10, "Whiteboi Kitcehn desk", 2340},
    {10, "Ol' Rusty Fridge", 2147},
    {10, "Classy Cook's Kitchen desk", 2334},
    {10, "Classy Cook's Kitchen sink", 2336},
    {10, "Classy Cook's Kitchen corner", 2338},
    {10, "Cookie Dough Cook Machine", 2170},
    {10, "LoveU2 Fridge", 2127},
    {10, "LoveU2 Unit", 2127},
    {10, "LoveU2 Sink", 2130},
    {10, "LoveU2 Cookin'", 2129},
    {10, "Sprunk2Kitch", 2452},
    {10, "Empty Sprunk Machine", 2443},
    {10, "Ice Fridge", 2361},
    {10, "SeeJay MicroWave", 2149},
    {10, "Pizza Baby Oven", 2426},
    {10, "Trash Bin", 1328},
    {10, "Dem Hippo Bin", 1371},
    {10, "Cluckin' Bin", 2770},
    {10, "Rolling Trash Can", 1337},
    {10, "Dumpster", 1415},
    {10, "Dumpster No. 2", 1439},
    {10, "Desk Lamp", 2196},
    {10, "Lava Lamp", 2238},
    {10, "Bunga Bunga Lamp", 2726},
    {10, "Triad Lamp", 3534},
    {10, "Industrial Lights", 921},
    {10, "The Bollard Inc. Light", 1215},
    {10, "Retro Lamp", 1734},
    {10, "Luxury Lamp", 15050},
    {10, "Classy Lamp", 2069},
    {10, "Ol' Man's Lamp", 2073},
    {10, "China China Lamp", 2075},
    {10, "Skylight", 2989},
    {10, "Airport Light", 3526},
    {10, "Headlight", 3785},
    {10, "Fanny Fan", 14527},
    {10, "Build Light", 19279},
    {10, "Bolla Bolla 1", 19121},
    {10, "Bolla Bolla 2", 19122},
    {10, "Bolla Bolla 3", 19123},
    {10, "Bolla Bolla 4", 19124},
    {10, "Bolla Bolla 5", 19125},
    {10, "Bolla Bolla 6", 19126},
    {10, "Bolla Bolla 7", 19127},
    {10, "Red Neons", 18647},
    {10, "Blue Neons", 18648},
    {10, "Green Neons", 18649},
    {10, "Yellow Neons", 18650},
    {10, "Pink Neons", 18651},
    {10, "White Neons", 18652},
    {10, "Rimbo Rambo Desk", 1998},
    {10, "Rimbo Rambo Desk 2", 1999},
    {10, "Rimbo Rambo Desk 3", 2008},
    {10, "Wooden Unit", 2161},
    {10, "Wooden Unit 2", 2162},
    {10, "Wooden Metal Cabinet", 2163},
    {10, "Wooden Metal Cabinet 2", 2164},
    {10, "Wooden Metal Cabinet 3", 2167},
    {10, "Wooden Desk with Computer", 2165},
    {10, "Wooden Desk", 2166},
    {10, "Library Desk", 2183},
    {10, "Rich Mahogany Cabinet", 2204},
    {10, "Rich Mahogany Desk", 2205},
    {10, "Super Rich Desk", 2207},
    {10, "Wooden Seperator", 2208},
    {10, "Glass Desk", 2209},
    {10, "Glass Unit", 2210},
    {10, "Glass Unit 2", 2211},
    {10, "Office Set", 16378},
    {10, "Macintosh 680", 2190},
    {10, "Model Art", 2594},
    {10, "Blue Curtains Closed", 2558},
    {10, "Blue Curtains Open", 2559},
    {10, "Big Blue Curtains Closed", 2561},
    {10, "Luxury Curtains", 14752},
    {10, "LS:CDF Flag", 2047},
    {10, "Red-Blue Flag", 2048},
    {10, "American Flag", 2614},
    {10, "Red Flag", 19306},
    {10, "Green Flag", 2993},
    {10, "Pfrple Flag", 19307},
    {10, "Red Carpet", 2631},
    {10, "Blue Carpet", 2632},
    {10, "Rockstar Carpet", 11737},
    {10, "Tiger Car", 1828},
    {10, "Pfrple Bedroom Rug", 2815},
    {10, "Green Bedroom Rug", 2817},
    {10, "Red Square Rug", 2818},
    {10, "Classy Rug", 2833},
    {10, "Classy Rug 2", 2834},
    {10, "Classy Rug 3", 2836},
    {10, "Round Classy Rug", 2835},
    {10, "Round Blue Rug", 2841},
    {10, "Sexy Rug", 2847},
    {10, "Sexy Statue", 3935},
    {10, "Lion Statue", 3471},
    {10, "Ol' Pal's Deer", 1736},
    {10, "Huge Budha", 14608},
    {10, "Burger Poster", 2641},
    {10, "Burger Poster 2", 2642},
    {10, "Burger Shots", 2643},
    {10, "Wash Hands", 2685},
    {10, "Ring Donuts", 2715},
    {10, "Target Poster", 2051},
    {10, "Gun Poster", 2055},
    {10, "Artistic Squares", 2257},
    {10, "Yellow Cab", 2254},
    {10, "Plant Pot", 949},
    {10, "Plant Pot 2", 2001},
    {10, "Plant Pot 3", 2010},
    {10, "Palm Pot", 2011},
    {10, "Natural Plant", 2244},
    {10, "Plant Wall Decor", 2345},
    {10, "Plant Ornament", 3802},
    {10, "WinPlanterz", 3811},
    {10, "Funky Plant", 14804},
    {10, "Blueprint", 3111},
    {10, "The Knife", 19583},
    {10, "Meat!", 2589},
    {10, "Ol' Man's Threadmill", 2627},
    {10, "Gym Bench", 2628},
    {10, "Gym Bike", 2630},
    {10, "Punch Bag", 1985},
    {10, "Blue Pool Table", 2964},
    {10, "Aristona TV", 1518},
    {10, "Ol' Skool TV", 1748},
    {10, "SmallWatch", 1749},
    {10, "Swanky TV", 1752},
    {10, "Swank HD TV", 1786},
    {10, "TV in Ward", 2091},
    {10, "White TV in Ward", 2093},
    {10, "Funky Sphere TV", 2224},
    {10, "TV Unit", 2296},
    {10, "TV Unit 2", 2297},
    {10, "TV Stand", 14604},
    {10, "OLED TV", 19786},
    {10, "Bee Bee Gone! Arcade", 2778},
    {10, "Duality Arcade", 2779},
    {10, "Nintendo 64", 1719},
    {10, "Playstation 5", 2028},
    {10, "Swanky Speaker", 2229},
    {10, "Swanky Speaker 2", 2230},
    {10, "Swanky Speaker 3", 2231},
    {10, "Swanky Speaker 4", 2233},
    {10, "HiFi Set", 2227},
    {10, "Safe", 2332},
    {10, "Medium Book Shelf", 1742},
    {10, "Big Book Case", 14455},
    {10, "Book n TV Shelf", 2608},
    {10, "Warehouse Shelf", 2567},
    {10, "Wooden Cabinet", 1740},
    {10, "Wooden Cabinet 2", 1741},
    {10, "Wooden Cabinet 3", 1743},
    {10, "Ol' Lady's Cabinet", 2078},
    {10, "Office Cabinet", 2204},
    {10, "Bright Hotel Dresser", 2562},
    {10, "Dark Hotel Dresser", 2568},
    {10, "Regular Hotel Dresser", 2570},
    {10, "Hotel Dresser Set", 2573},
    {10, "Hotel Dresser Set 2", 2574},
    {10, "Rich Mahogany Dresser", 2576},
    {10, "Tool Cabinet", 19899},
    {10, "Park Table", 1281},
    {10, "Small Dining Table", 1433},
    {10, "Chair and Table Set", 1594},
    {10, "Luxe Set", 1825},
    {10, "Glass Coffee Table", 1827},
    {10, "Roman Dining", 2086},
    {10, "Coffee Swank Table", 1822},
    {10, "Rich Mahogany Coffee Table", 2311},
    {10, "Bright TV Table", 2313},
    {10, "Dark TV Table", 2315},
    {10, "Slot Table", 2592},
    {10, "Pizza Table", 2764},
    {10, "Cosy Set", 2799},
    {10, "Cosy Set 2", 2802},
    {10, "HP Deskjet 2000", 2202}
};