/*==================================================================== 
	Bus sidejob module 

	Note: 
==================================================================== */


#include <YSI\y_hooks>

#define BUS_SALARY			400
#define MAX_BUS_SPEED		80

#define IsPlayerWorkInBus(%0)		busWorking[%0]
#define SetPlayerWorkInBus(%0)		busWorking[%0]=true
#define StopPlayerWorkInBus(%0)		busWorking[%0]=false

static
	bool:busWorking[MAX_PLAYERS] = {false, ...},
	busRoute[MAX_PLAYERS] = {0, ...},
	busCounter[MAX_PLAYERS] = {0, ...},
	currentBRoute[MAX_PLAYERS] = {0, ...};

enum array_busRoute
{
	Float:b_x,
	Float:b_y,
	Float:b_z,
	b_time
};

stock const arr_busRoute1[][array_busRoute] = 
{
	{1799.1448,  -1904.0933, 13.4993 , 1}, // BUS START 
	{1824.0742,  -1867.9597, 13.4870 , 1}, // BUS RUTE A - 1
	{1798.2535,  -1829.5018, 13.4910 , 1}, // BUS RUTE A - 2
	{1696.7743,  -1807.8816, 13.4767 , 1}, // BUS RUTE A - 3
	{1692.4498,  -1753.3125, 13.4866 , 1}, // BUS RUTE A - 4
	{1642.9327,  -1729.3685, 13.4827 , 1}, // BUS RUTE A - 5
	{1579.5802,  -1729.2075, 13.4829 , 10}, // BUS RUTE A - 6 HALTE
	{1503.7462,  -1729.6741, 13.4834 , 1}, // BUS RUTE A - 7
	{1351.8206,  -1730.0387, 13.4833 , 1}, // BUS RUTE A - 8
	{1315.5096,  -1644.5126, 13.4830 , 10}, // BUS RUTE A - 9 HALTE
	{1324.6870,  -1524.6785, 13.4794 , 1}, // BUS RUTE A - 10
	{1360.7312,  -1326.8687, 13.4914 , 1}, // BUS RUTE A - 11
	{1363.2040,  -1104.6925, 23.9550 , 10}, // BUS RUTE A - 12 HALTE
	{1371.0967,  -1012.6967, 26.9240 , 1}, // BUS RUTE A - 13
	{1413.8687,  -953.5034,  35.8827 , 1}, // BUS RUTE A - 14
	{1570.5060,  -992.5035,  46.1226 , 1}, // BUS RUTE A - 15
	{1706.9377,  -805.1011,  56.1050 , 1}, // BUS RUTE A - 16
	{1697.7734,  -410.2684,  35.5103 , 1}, // BUS RUTE A - 17
	{1648.9012,  201.3097,   31.7584 , 1}, // BUS RUTE A - 18
	{1877.1342,  267.8607,   27.1534 , 1}, // BUS RUTE A - 19
	{2255.2207,  306.7214,   32.7624 , 1}, // BUS RUTE A - 20
	{2341.6353,  211.8747,   26.4359 , 1}, // BUS RUTE A - 21
	{2340.8901,  46.3165,    26.4356 , 10}, // BUS RUTE A - 22 HALTE
	{2404.2839,  -30.4033,   26.4342 , 1}, // BUS RUTE A - 23
	{2508.1313,  -10.5072,   26.4362 , 1}, // BUS RUTE A - 24
	{2588.7009,  39.5290,    26.4364 , 1}, // BUS RUTE A - 25
	{2733.6052,  2.9826, 	 31.3751 , 1}, // BUS RUTE A - 26
	{2699.9634,  -254.3856,  29.8148 , 1}, // BUS RUTE A - 27
	{2733.2573,  -425.2756,  17.6623 , 1}, // BUS RUTE A - 28
	{2840.9204,  -605.2313,  10.9170 , 1}, // BUS RUTE A - 29
	{2838.7009,  -962.5031,  18.4480 , 1}, // BUS RUTE A - 30
	{2867.4883,  -1359.8931, 11.0255 , 1}, // BUS RUTE A - 31
	{2842.6492,  -1579.4786, 11.0227 , 10}, // BUS RUTE A - 32 HALTE
	{2766.7156,  -1655.3799, 12.0131 , 1}, // BUS RUTE A - 33
	{2740.0273,  -1583.1725, 15.7836 , 1}, // BUS RUTE A - 34
	{2740.9146,  -1321.9661, 50.0159 , 10}, // BUS RUTE A - 35 HALTE
	{2694.7144,  -1255.4763, 57.1588 , 1}, // BUS RUTE A - 36
	{2534.7090,  -1253.4252, 38.5750 , 1}, // BUS RUTE A - 37
	{2400.1069,  -1253.2554, 23.9213 , 10}, // BUS RUTE A - 38 HALTE
	{2367.7949,  -1288.9546, 23.9373 , 1}, // BUS RUTE A - 39
	{2319.4470,  -1381.7328, 23.9666 , 1}, // BUS RUTE A - 40
	{2238.7920,  -1381.3176, 23.9289 , 10}, // BUS RUTE A - 41 HALTE
	{2210.4878,  -1453.1442, 23.9186 , 1}, // BUS RUTE A - 42
	{2184.7241,  -1689.7115, 13.7504 , 1}, // BUS RUTE A - 43
	{2289.6106,  -1735.6481, 13.4771 , 1}, // BUS RUTE A - 44 HALTE
	{2411.4434,  -1773.3228, 13.4911 , 1}, // BUS RUTE A - 45
	{2392.2734,  -1970.0033, 13.4785 , 1}, // BUS RUTE A - 46
	{2234.5220,  -1969.2791, 13.4551 , 10}, // BUS RUTE A - 47 HALTE
	{2242.2751,  -2042.8419, 13.4873 , 1}, // BUS RUTE A - 48
	{2534.1685,  -2335.3201, 22.3406 , 1}, // BUS RUTE A - 49
	{2680.4304,  -2449.3298, 13.6002 , 10}, // BUS RUTE A - 50 HALTE
	{2604.4072,  -2501.2617, 13.5928 , 1}, // BUS RUTE A - 51
	{2440.6440,  -2660.0032, 13.6196 , 1}, // BUS RUTE A - 52
	{2228.1694,  -2585.1677, 13.4983 , 1}, // BUS RUTE A - 53
	{2202.3933,  -2492.2061, 13.4983 , 10}, // BUS RUTE A - 54 HALTE
	{2174.0386,  -2434.3247, 13.4756 , 1}, // BUS RUTE A - 55
	{2294.2485,  -2261.9517, 13.4748 , 1}, // BUS RUTE A - 56
	{2214.9753,  -2177.5999, 13.4434 , 10}, // BUS RUTE A - 57 HALTE
	{2135.4053,  -2224.1926, 13.4890 , 1}, // BUS RUTE A - 58
	{2162.1843,  -2351.2092, 13.4552 , 1}, // BUS RUTE A - 59
	{2161.8811,  -2422.8914, 13.4756 , 1}, // BUS RUTE A - 60
	{1960.4026,  -2667.6555, 7.6933  , 1}, // BUS RUTE A - 61
	{1348.8390,  -2545.2629, 13.4791 , 1}, // BUS RUTE A - 62
	{1420.4886,  -2466.9011, 5.3445  , 1}, // BUS RUTE A - 63
	{1527.5891,  -2289.0388, -2.8951 , 1}, // BUS RUTE A - 64
	{1607.5775,  -2321.6741, -2.7508 , 1}, // BUS RUTE A - 65
	{1664.7310,  -2322.1406, -2.7450 , 10}, // BUS RUTE A - 66 HALTE
	{1734.5452,  -2282.5269, -2.7512 , 1}, // BUS RUTE A - 67
	{1783.6233,  -2256.5210, 5.4912  , 1}, // BUS RUTE A - 68
	{1735.4027,  -2299.9377, 13.4761 , 1}, // BUS RUTE A - 69
	{1629.3160,  -2250.7402, 13.4270 , 1}, // BUS RUTE A - 70
	{1537.4498,  -2283.5833, 13.4831 , 10}, // BUS RUTE A - 71 HALTE
	{1457.6007,  -2238.8125, 13.4746 , 1}, // BUS RUTE A - 72
	{1454.2654,  -2332.5674, 13.4832 , 1}, // BUS RUTE A - 73
	{1430.5533,  -2375.1223, 15.6839 , 1}, // BUS RUTE A - 74
	{1328.6346,  -2365.3418, 13.4756 , 1}, // BUS RUTE A - 75
	{1287.1459,  -2446.4019, 8.0454  , 1}, // BUS RUTE A - 76
	{1035.1221,  -2170.4990, 13.0571 , 1}, // BUS RUTE A - 77
	{1099.9346,  -1855.1971, 13.4781 , 10}, // BUS RUTE A - 78 HALTE
	{1292.5463,  -1855.1244, 13.4841 , 1}, // BUS RUTE A - 79
	{1473.8364,  -1874.8811, 13.4831 , 1}, // BUS RUTE A - 80
	{1602.7986,  -1875.4746, 13.4817 , 10}, // BUS RUTE A - 81 HALTE
	{1691.4028,  -1827.5400, 13.4827 , 1}, // BUS RUTE A - 82
	{1735.8328,  -1819.9781, 13.4679 , 1}, // BUS RUTE A - 83
	{1819.3386,  -1869.8273, 13.5143 , 1}, // BUS RUTE A - 84
	{1804.7250,  -1890.6194, 13.4986 , 1} // BUS STOP
};


stock const arr_busRoute2[][array_busRoute] = {
	{1799.1448,  -1904.0933, 13.4993,   1}, // BUS START 
	{1824.3209,  -1865.3304, 13.4966,   1}, // BUS RUTE B- 1
	{1824.8802,  -1708.1464, 13.4821,   10}, // BUS RUTE B - 2 HALTE
	{1786.9753,  -1607.2073, 13.4644,   1}, // BUS RUTE B- 3
	{1573.0294,  -1589.8663, 13.4856,   10}, // BUS RUTE B - 4 HALTE
	{1437.1602,  -1588.8027, 13.4815,   1}, // BUS RUTE B - 5
	{1448.3702,  -1506.9816, 13.4820,   1}, // BUS RUTE B - 6
	{1457.1256,  -1329.8964, 13.4835,   1}, // BUS RUTE B - 7
	{1484.1313,  -1140.8352, 24.0073,   1}, // BUS RUTE B - 8
	{1432.9156,  -1030.8872, 23.7590,   10}, // BUS RUTE B - 9 HALTE
	{1347.8762,  -1077.5583, 25.0395,   1}, // BUS RUTE B - 10
	{1339.5613,  -1270.5918, 13.4743,   1}, // BUS RUTE B - 11
	{1194.0060,  -1277.8805, 13.4210,   10}, // BUS RUTE B - 12 HALTE
	{1083.1810,  -1278.3356, 13.5125,   1}, // BUS RUTE B - 13
	{1034.3983,  -1320.3390, 13.4923,   1}, // BUS RUTE B - 14
	{849.6144,   -1319.8979, 13.5494,   1}, // BUS RUTE B - 15
	{689.9189,   -1316.6812, 13.6065,   10}, // BUS RUTE B - 16 HALTE
	{640.6963,   -1292.1328, 15.1497,   1}, // BUS RUTE B - 17
	{634.4540,   -1213.7819, 18.2113,   1}, // BUS RUTE B - 18
	{567.0422,   -1128.2577, 26.6875,   1}, // BUS RUTE B - 19
	{109.4844,   -1237.9259, 15.0840,   1}, // BUS RUTE B - 20
	{-202.2349,  -1517.0156, 14.6460,   1}, // BUS RUTE B - 21
	{-312.6907,  -1738.8989, 15.2625,   1}, // BUS RUTE B - 22
	{-306.8327,  -2251.7952, 29.5858,   1}, // BUS RUTE B - 23
	{-288.9944,  -2806.9822, 54.5446,   1}, // BUS RUTE B - 24
	{-864.0671,  -2815.1448, 70.4850,   1}, // BUS RUTE B - 25
	{-1311.3202, -2871.2732, 58.4751,   1}, // BUS RUTE B - 26
	{-1585.1366, -2743.2515, 48.6430,   10}, // BUS RUTE B - 27 HALTE
	{-1676.6079, -2677.7310, 48.6427,   1}, // BUS RUTE B - 28
	{-1776.2937, -2564.0103, 54.0392,   1}, // BUS RUTE B - 29
	{-1985.1023, -2532.6414, 36.3448,   1}, // BUS RUTE B - 30
	{-2120.7205, -2426.8916, 30.5649,   10}, // BUS RUTE B - 31 HALTE
	{-2175.2512, -2347.2578, 30.5694,   1}, // BUS RUTE B - 32
	{-2204.8040, -2271.0830, 30.5694,   1}, // BUS RUTE B - 33
	{-2240.5437, -2198.7612, 36.1893,   1}, // BUS RUTE B - 34
	{-2026.1913, -1911.0273, 48.8086,   1}, // BUS RUTE B - 35
	{-1647.8871, -1632.3358, 36.3585,   1}, // BUS RUTE B - 36
	{-1359.3243, -1668.2777, 45.4777,   1}, // BUS RUTE B - 37
	{-1059.2356, -1908.8611, 77.4352,   1}, // BUS RUTE B - 38
	{-951.1474,  -1907.7047, 81.4171,   1}, // BUS RUTE B - 39
	{-755.8625,  -1626.6796, 96.4620,   1}, // BUS RUTE B - 40
	{-721.7056,  -1322.6265, 63.5408,   1}, // BUS RUTE B - 41
	{-722.3495,  -1664.8455, 51.2613,   1}, // BUS RUTE B - 42
	{-656.5826,  -1557.1727, 22.8397,   1}, // BUS RUTE B - 43
	{-606.1495,  -1211.3336, 21.3368,   1}, // BUS RUTE B - 44
	{-574.0963,  -1076.6044, 23.6314,   10}, // BUS RUTE B - 45 HALTE
	{-488.7481,  -1008.3381, 24.8657,   1}, // BUS RUTE B - 46
	{-392.0166,  -677.4777,  17.8002,   1}, // BUS RUTE B - 47
	{-523.5019,  -391.6553,  17.5893,   1}, // BUS RUTE B - 48
	{-923.5973,  -451.6934,  28.9030,   1}, // BUS RUTE B - 49
	{-963.0558,  -335.6289,  36.2830,   1}, // BUS RUTE B - 50
	{-877.8933,  -252.8793,  37.5859,   1}, // BUS RUTE B - 51
	{-577.2632,  -255.3129,  62.7470,   10}, // BUS RUTE B - 52 HALTE
	{-295.3801,  -290.4201,  4.2394,    1}, // BUS RUTE B - 53
	{-208.9677,  -318.8250,  1.1820,    1}, // BUS RUTE B - 54
	{44.3134,    -593.7349,  5.3461,    1}, // BUS RUTE B - 55
	{109.1090,   -682.9587,  6.2475,    1}, // BUS RUTE B - 56
	{329.0319,   -572.4747,  40.6120,   1}, // BUS RUTE B - 57
	{656.2529,   -663.5726,  16.6034,   1}, // BUS RUTE B - 58
	{684.6974,   -549.1989,  16.2873,   1}, // BUS RUTE B - 59 
	{806.9089,   -532.9066,  16.2874,   10}, // BUS RUTE B - 60 HALTE
	{865.0080,   -566.1660,  17.9681,   1}, // BUS RUTE B - 61
	{1024.9156,  -461.5866,  51.4556,   1}, // BUS RUTE B - 62
	{1242.9056,  -419.9709,  3.2895,    1}, // BUS RUTE B - 63
	{1249.2552,  -482.7889,  19.7007,   1}, // BUS RUTE B - 64
	{1167.1628,  -708.7357,  62.1256,   1}, // BUS RUTE B - 65
	{1216.5443,  -947.3544,  42.7524,   10}, // BUS RUTE B - 66 HALTE
	{1339.2031,  -941.3075,  35.5702,   1}, // BUS RUTE B - 67
	{1515.8667,  -1000.2842, 40.3338,   1}, // BUS RUTE B - 68
	{1592.6409,  -1354.4714, 29.4629,   1}, // BUS RUTE B - 69
	{1598.6556,  -1522.2113, 19.5442,   1}, // BUS RUTE B - 70
	{1726.2699,  -1528.9490, 19.1163,   1}, // BUS RUTE B - 71
	{1973.7527,  -1520.7417, 3.4736,    1}, // BUS RUTE B - 72
	{2069.6572,  -1614.9655, 13.4785,   1}, // BUS RUTE B - 73
	{2079.5552,  -1667.9159, 13.4903,   1}, // BUS RUTE B - 74
	{2082.4055,  -1778.1429, 13.4829,   10}, // BUS RUTE B - 75 HALTE
	{2079.0964,  -1895.2772, 13.4519,   1}, // BUS RUTE B - 76
	{2023.0414,  -1929.9554, 13.4388,   1}, // BUS RUTE B - 77
	{1844.9753,  -1929.8435, 13.4847,   1}, // BUS RUTE B - 78
	{1824.2279,  -1904.2207, 13.4659,   1}, // BUS RUTE B - 79
	{1804.7250,  -1890.6194, 13.4986,   1} // BUS STOP
};

stock const arr_busRoute3[][array_busRoute] = {
	{1824.6434,	-1855.5780	,13.5140,	1}, // BUS RUTE C - 1
	{1825.7491,	-1760.6331	,13.4777,	1}, // BUS RUTE C - 2
	{1922.9827,	-1755.4747	,13.4800,	10}, // BUS RUTE C - 3 HALTE
	{1988.4988,	-1754.8135	,13.4835,	1}, // BUS RUTE C - 4
	{2150.2834,	-1755.1006	,13.4917,	1}, // BUS RUTE C - 5
	{2195.3083,	-1663.5623	,14.9339,	10}, // BUS RUTE C - 6 HALTE
	{2207.8950,	-1611.7603	,17.9974,	1}, // BUS RUTE C - 7
	{2215.5281,	-1403.7074	,23.9251,	1}, // BUS RUTE C - 8
	{2259.8289,	-1386.3774	,23.9334,	1}, // BUS RUTE C - 9
	{2273.8125,	-1336.2465	,23.9250,	10}, // BUS RUTE C - 10 HALTE
	{2273.8999,	-1232.4437	,23.9123,	1}, // BUS RUTE C - 11
	{2227.2195,	-1128.8353	,25.7291,	1}, // BUS RUTE C - 12
	{2037.4249,	-1029.5471	,35.4787,	1}, // BUS RUTE C - 13
	{1866.6110,	-1013.2244	,36.2325,	1}, // BUS RUTE C - 14
	{1466.2078,	-951.4584	,36.2337,	1}, // BUS RUTE C - 15
	{1325.1683,	-922.3513	,37.1378,	1}, // BUS RUTE C - 16
	{1190.5873,	-935.1897	,42.8487,	10}, // BUS RUTE C - 17 HALTE
	{1159.9174,	-905.9866	,42.7753,	1}, // BUS RUTE C - 18
	{1218.8937,	-603.8357	,52.5672,	1}, // BUS RUTE C - 19
	{1220.1255,	-242.5085	,25.9189,	1}, // BUS RUTE C - 20
	{1211.5449,	-150.2654	,40.0640,	1}, // BUS RUTE C - 21
	{1293.6161,	-89.2407	,36.7472,	1}, // BUS RUTE C - 22
	{1281.7009,	-49.3305	,33.1013,	1}, // BUS RUTE C - 23
	{1283.9240,	228.7820	,19.5044,	10}, // BUS RUTE C - 24 HALTE
	{1321.5354,	315.6637	,19.5100,	1}, // BUS RUTE C - 25
	{1332.4717,	470.9179	,19.9836,	1}, // BUS RUTE C - 26
	{933.4167,	377.5133	,19.9835,	1}, // BUS RUTE C - 27
	{587.3950,	383.7491	,19.0303,	1}, // BUS RUTE C - 28
	{392.0281,	653.4429	,14.9437,	1}, // BUS RUTE C - 29
	{271.0854,	875.3057	,21.2089,	1}, // BUS RUTE C - 30
	{251.9095,	1211.4750	,15.7096,	1}, // BUS RUTE C - 31
	{354.0199,	1406.2329	,6.8931,	10}, // BUS RUTE C - 32 HALTE
	{376.6362,	1495.0477	,9.5498,	1}, // BUS RUTE C - 33
	{500.3301,	1642.0352	,13.9800,	1}, // BUS RUTE C - 34
	{638.1505,	1709.7451	,7.0880,	10}, // BUS RUTE C - 35 HALTE
	{643.4980,	1756.4064	,4.9121,	1}, // BUS RUTE C - 36
	{691.3720,	1912.4723	,5.6410,	1}, // BUS RUTE C - 37
	{794.3821,	1913.4982	,5.6401,	1}, // BUS RUTE C - 38
	{807.6464,	1837.0975	,3.8907,	1}, // BUS RUTE C - 39
	{769.3096,	1442.0779	,20.4088,	1}, // BUS RUTE C - 40
	{769.1607,	1123.9648	,28.4309,	1}, // BUS RUTE C - 41
	{411.8922,	1029.6029	,28.4724,	10}, // BUS RUTE C - 42 HALTE
	{220.2986,	970.8843	,28.3483,	1}, // BUS RUTE C - 43
	{-75.1436,	850.5278	,18.2051,	1}, // BUS RUTE C - 44
	{-114.4104,	791.0772	,21.0671,	1}, // BUS RUTE C - 45
	{-291.8901,	634.1100	,15.7863,	1}, // BUS RUTE C - 46
	{-133.3814,	586.1705	,2.3523,	1}, // BUS RUTE C - 47
	{-172.8598,	359.3499	,12.1788,	1}, // BUS RUTE C - 48
	{-261.5655,	103.8582	,1.1842,	1}, // BUS RUTE C - 49
	{-311.7484,	-138.3591	,1.1786,	1}, // BUS RUTE C - 50
	{-261.7059,	-162.0980	,2.4648,	1}, // BUS RUTE C - 51
	{51.1668,	-213.2564	,1.5601,	1}, // BUS RUTE C - 52
	{179.8103,	-255.3635	,1.5266,	10}, // BUS RUTE C - 53 HALTE
	{206.1829,	-314.5955	,1.6202,	1}, // BUS RUTE C - 54
	{457.1780,	-409.9315	,28.4766,	1}, // BUS RUTE C - 55
	{451.4758,	-464.7860	,35.5416,	1}, // BUS RUTE C - 56
	{403.4063,	-622.5617	,32.6583,	1}, // BUS RUTE C - 57
	{244.7201,	-1027.5225	,57.3698,	1}, // BUS RUTE C - 58
	{128.9043,	-1288.5961	,47.2859,	1}, // BUS RUTE C - 59
	{125.6929,	-1457.1033	,25.6194,	1}, // BUS RUTE C - 60
	{110.3300,	-1552.7737	,7.5192,	1}, // BUS RUTE C - 61
	{122.1411,	-1594.9939	,10.6508,	1}, // BUS RUTE C - 62
	{209.0318,	-1735.3584	,4.4983,	1}, // BUS RUTE C - 63
	{341.9535,	-1761.0310	,5.0457,	1}, // BUS RUTE C - 64
	{414.8357,	-1775.6708	,5.3775,	10}, // BUS RUTE C - 65 HALTE
	{461.0707,	-1731.6732	,10.1474,	1}, // BUS RUTE C - 66
	{558.7706,	-1736.8065	,12.7885,	1}, // BUS RUTE C - 67
	{888.0894,	-1787.9348	,13.6263,	1}, // BUS RUTE C - 68
	{1045.8545,	-1948.5638	,13.0446,	1}, // BUS RUTE C - 69
	{1305.8203,	-2466.7981	,7.7646,	1}, // BUS RUTE C - 70
	{1330.4323,	-2571.7515	,13.4813,	1}, // BUS RUTE C - 71
	{1672.0334,	-2687.1296	,5.9679,	1}, // BUS RUTE C - 72
	{2177.2117,	-2484.2500	,13.4757,	1}, // BUS RUTE C - 73
	{2337.9614,	-2240.2341	,13.4754,	1}, // BUS RUTE C - 74
	{2700.8857,	-2169.6423	,11.0306,	1}, // BUS RUTE C - 5
	{2706.9585,	-2167.7856	,11.0307,	1}, // BUS RUTE C - 75
	{2717.2722,	-2070.3540	,12.5819,	10}, // BUS RUTE C - 76 HALTE
	{2716.6990,	-1988.6777	,13.4899,	1}, // BUS RUTE C - 77
	{2611.3977,	-1929.5953	,13.4763,	1}, // BUS RUTE C - 78
	{2519.2100,	-1892.9961	,13.4834,	1}, // BUS RUTE C - 79
	{2529.9031,	-1745.6477	,13.4810,	1}, // BUS RUTE C - 80
	{2468.2966,	-1729.7627	,13.4835,	1}, // BUS RUTE C - 81
	{2283.7141,	-1729.2096	,13.4835,	1}, // BUS RUTE C - 82
	{2198.7834,	-1731.6863	,13.5039,	1}, // BUS RUTE C - 83
	{2112.8870,	-1749.7468	,13.5069,	1}, // BUS RUTE C - 84
	{1843.6896,	-1749.4694	,13.4834,	1}, // BUS RUTE C - 85
	{1818.9585,	-1809.4042	,13.5007,	1}, // BUS RUTE C - 86
	{1818.6948,	-1874.8413	,13.5081,	1} // BUS RUTE C - 87
};


hook OnGameModeInit()
{
	CreateDynamicMapIcon(1789.9645,-1911.4059,13.5041, 56, -1, -1, 0, -1, _, MAPICON_GLOBAL); //Map Icon

	//Mappping Halte 1
	CreateDynamicObject(1257, 1574.792602, -1723.254272, 13.742572, 0.079784, 0.000000, 90.000000); 
	CreateDynamicObject(1257, 1319.371459, -1640.293945, 13.743680, -0.077509, 0.000000, 0.000000); 
	CreateDynamicObject(1257, 1369.142944, -1102.049438, 24.185516, 0.740795, 0.000000, -8.399996); 
	CreateDynamicObject(1257, 2337.233154, 38.998714, 26.640928, -0.002117, 0.000000, -178.299972); 
	CreateDynamicObject(1257, 2835.984619, -1580.041870, 11.243724, 0.046901, 0.000000, 150.000061); 
	CreateDynamicObject(1257, 2745.329345, -1319.911254, 50.611671, 10.133698, 0.000000, -360.000000); 
	CreateDynamicObject(1257, 2396.682128, -1247.478393, 24.104866, 2.819115, 0.000000, 90.099998); 
	CreateDynamicObject(1257, 2234.703369, -1375.558227, 24.192428, 0.031512, 0.000000, 90.000000); 
	CreateDynamicObject(1257, 2293.707275, -1740.796020, 13.662370, -0.005902, 0.000000, 270.000000); 
	CreateDynamicObject(1257, 2231.172363, -1963.935302, 13.717031, 0.050305, 0.000000, -270.000000); 
	CreateDynamicObject(1257, 2675.004394, -2453.069091, 13.788028, -0.033996, 0.000000, -180.000000); 
	CreateDynamicObject(1257, 2198.355224, -2486.720947, 13.699335, -0.024999, 0.000000, 90.000000); 
	CreateDynamicObject(1257, 2217.064208, -2171.430908, 13.697566, -0.075385, 0.000000, 45.099994); 
	CreateDynamicObject(1257, 1668.591674, -2325.805419, -2.589751, -0.110700, 0.000000, 270.000000); 
	CreateDynamicObject(1257, 1533.053710, -2277.728027, 13.658052, -0.014910, 0.000000, 90.000000); 
	CreateDynamicObject(1257, 1103.996215, -1859.065795, 13.661215, -0.166626, 0.000000, 270.000000); 
	CreateDynamicObject(1257, 1606.448730, -1881.244262, 13.677393, -0.071398, 0.000000, 270.000000); 
	CreateDynamicObject(1257, 1830.375976, -1704.230834, 13.717059, -0.036096, 0.000000, 0.000000); 
	CreateDynamicObject(1257, 1568.874633, -1585.581420, 13.643305, -0.028387, 0.000000, 90.000000); 
	CreateDynamicObject(1257, 1428.598999, -1025.177246, 23.958820, 0.040820, 0.000000, 90.000000); 
	CreateDynamicObject(1257, 1190.592529, -1271.805786, 13.670173, 0.026312, 0.000000, 90.000000); 
	CreateDynamicObject(1257, 685.613830, -1312.819824, 13.843959, 0.326294, 0.000000, 90.000000); 
	CreateDynamicObject(1257, -1587.704345, -2745.608398, 48.660835, 0.058196, 0.000000, -125.800033); 
	CreateDynamicObject(1257, -2116.279052, -2423.451904, 30.722740, -0.141813, 0.000000, 51.300006); 
	CreateDynamicObject(1257, -569.062316, -1073.761962, 23.678623, 0.329499, 0.000000, -34.300003); 
	CreateDynamicObject(1257, -575.724670, -258.143981, 62.780014, -2.170820, 0.000000, -104.700027); 
	CreateDynamicObject(1257, 810.072875, -538.736022, 16.436164, 0.055926, 0.000000, 270.000000); 
	CreateDynamicObject(1257, 1220.916625, -950.274169, 42.916530, -0.427299, 0.000000, -78.900054); 
	CreateDynamicObject(1257, 2075.492919, -1780.136474, 13.716918, 0.021804, 0.000000, 162.699981); 
	CreateDynamicObject(1257, 1926.583129, -1761.015869, 13.707822, 0.016210, 0.000000, 270.000000); 
	CreateDynamicObject(1257, 2199.340820, -1660.342407, 15.122483, 2.661712, 0.000000, -12.299998); 
	CreateDynamicObject(1257, 2277.250488, -1332.180541, 24.041608, -0.086308, 0.000000, 0.000000); 
	CreateDynamicObject(1257, 1186.469970, -930.604614, 43.281925, 0.219806, 0.000000, 100.199966); 
	CreateDynamicObject(1257, 1288.568725, 230.483062, 19.604722, 0.039313, 0.000000, -24.000013); 
	CreateDynamicObject(1257, 358.754821, 1409.333007, 7.047653, -0.627698, 0.000000, -18.100002); 
	CreateDynamicObject(1257, 643.677001, 1708.092407, 7.205147, -0.005200, 0.000000, -48.099994); 
	CreateDynamicObject(1257, 407.027770, 1030.592041, 28.634117, -0.025409, 0.000000, 104.399917); 
	CreateDynamicObject(1257, 174.222839, -258.670471, 1.773057, -0.024217, 0.000000, -180.000000); 
	CreateDynamicObject(1257, 417.917907, -1779.624755, 5.657438, 0.012699, 0.000000, 270.000000); 
	CreateDynamicObject(1257, 2722.941406, -2067.226806, 13.110141, 4.604675, 0.000000, 0.000000); 
}

hook OnPlayerConnect(playerid)
{
	StopPlayerWorkInBus(playerid);
	busRoute[playerid] = 0;
	busCounter[playerid] = 0;
	currentBRoute[playerid] = 0;

	RemoveBuildingForPlayer(playerid, 1438, 1015.530, -1337.170, 12.554, 0.250);
}

hook OnPlayerDisconnectEx(playerid, reason)
{
	if(IsPlayerWorkInBus(playerid))
	{
		SetBusDelay(playerid, JobConfig_GetExitDelay(SIDEJOB_BUS_DRIVER));
		DisablePlayerRaceCheckpoint(playerid);

		SetVehicleToRespawn(GetPlayerLastVehicle(playerid));
	}

	if(GetBusDelay(playerid)) {
		UpdateCharacterInt(playerid, "BusDelay", GetBusDelay(playerid));
	}
}

hook EnterBusVehicle(playerid, vehicleid)
{
	if(!IsAdminOnDuty(playerid) && !IsPlayerWorkInBus(playerid))
	{
		if (!JobConfig_IsJobEnabled(SIDEJOB_BUS_DRIVER))
		{
			SendCustomMessage(playerid, "BUS SIDEJOB", "Sidejob ini di-nonaktifkan oleh server.");
			SetCameraBehindPlayer(playerid);
			RemovePlayerFromVehicle(playerid);
			return 1;
		}

		if(GetBusDelay(playerid) > 0 && GetPlayerVIPLevel(playerid) < 2)
		{
			SendCustomMessage(playerid, "BUS SIDEJOB", "Tidak dapat bekerja bus sementara waktu, tunggu "YELLOW"%d menit "WHITE"untuk memulai kembali.", (GetBusDelay(playerid)/60));
			SetCameraBehindPlayer(playerid);
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		SetCameraBehindPlayer(playerid);
		Dialog_Show(playerid, BusSidejob, DIALOG_STYLE_MSGBOX, "Bus Sidejob", ""WHITE"Kamu sedang menaiki "YELLOW"bus kerja"WHITE". Apakah kamu ingin memulai pekerjaan ini?.\nKamu akan di tugaskan untuk kelilingi menuju beberapa halte di kota "LIGHTBLUE"Los Santos."WHITE"\n\nPilik opsi \""GREEN"Mulai"WHITE"\" untuk melakukan pekerjaan.", "Mulai", "Turun");
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(IsPlayerWorkInBus(playerid) && oldstate == PLAYER_STATE_DRIVER)
	{
		Dialog_Show(playerid, BusSidejobLeave, DIALOG_STYLE_MSGBOX, "Bus Sidejob", ""WHITE"Apakah kamu ingin turun dan menggagalkan pekerjaan ini?\nNantinya kamu harus menunggu selama "RED"10 menit "WHITE"untuk kembali bekerja!", "Lanjut", "Gagalkan");
	}
	return 1;
}

hook OnPlayerEnterRaceCP(playerid)
{
	if(IsPlayerConnected(playerid) && IsPlayerWorkInBus(playerid) && busCounter[playerid] == 1)
	{
		if (IsPlayerWaypointRecentlyShow(playerid))
		{
			ResetRecentWaypoint(playerid);
			SetBusCheckpoin(playerid, 0);
			return 1;
		}

		SetBusCheckpointRoute(playerid);
	}
	return 1;
}

hook OnPlayerLeaveRaceCP(playerid)
{
	if(IsPlayerConnected(playerid) && IsPlayerWorkInBus(playerid))
	{
		switch(busRoute[playerid])
		{
			case 1: busCounter[playerid] = arr_busRoute1[currentBRoute[playerid]][b_time];
			case 2: busCounter[playerid] = arr_busRoute2[currentBRoute[playerid]][b_time];
			case 3: busCounter[playerid] = arr_busRoute3[currentBRoute[playerid]][b_time];
		}
	}
}

hook OnPlayerVehicleDamage(playerid, vehicleid, Float:Damage)
{
	if(IsBusVehicle(vehicleid) && IsPlayerWorkInBus(playerid))
	{
		new
			Float:minimum_health,
			Float:vehicle_health
		;

		GetVehicleHealth(vehicleid, vehicle_health);
		JobConfig_GetBusMinimumHealth(minimum_health);

		new
			bool:is_veh_hp_above_minimum = (floatcmp(vehicle_health, minimum_health) == 1)
		;

		if (is_veh_hp_above_minimum)
		{
			SendCustomMessage(playerid, "BUS", "Bus lecet! hindari gagal dan berhati- hatilah membawa bus!");
		}
		else
		{
			SendServerMessage(playerid, "Kamu gagal menyelesaikan pekerjaan bus, kendaraan yang kamu bawa telah rusak!");
			CancelBusProgress(playerid);
		}
	}
	return 1;
}


CancelBusProgress(playerid, bool:done = false)
{
	if(IsPlayerWorkInBus(playerid))
	{
		PlayerData[playerid][pTestWarns] = 0;

		StopPlayerWorkInBus(playerid);
		currentBRoute[playerid] = busRoute[playerid] = busCounter[playerid] = 0;

		DisablePlayerRaceCheckpoint(playerid);
		SetVehicleToRespawn(GetPlayerLastVehicle(playerid));

		if(!done) {
			SetBusDelay(playerid, JobConfig_GetFailDelay(SIDEJOB_BUS_DRIVER));
			SendCustomMessage(playerid, "BUS","Kamu gagal dan tidak tuntas menyelesaikan pekerjaan ini.");
		}
	}
    return 1;
}

SetBusCheckpoin(playerid, mode)
{
	if(IsPlayerWorkInBus(playerid))
	{
		switch(busRoute[playerid])
		{
			case 1:
			{
				SetPlayerRaceCheckpoint(playerid, mode, arr_busRoute1[currentBRoute[playerid]][b_x], arr_busRoute1[currentBRoute[playerid]][b_y], arr_busRoute1[currentBRoute[playerid]][b_z], mode ? (-1.0) : (arr_busRoute1[currentBRoute[playerid] + 1][b_x]), mode ? (-1.0) : (arr_busRoute1[currentBRoute[playerid] + 1][b_y]), mode ? (-1.0) : (arr_busRoute1[currentBRoute[playerid] + 1][b_z]), 6);
				busCounter[playerid] = arr_busRoute1[currentBRoute[playerid]][b_time];
			}
			case 2:
			{
				SetPlayerRaceCheckpoint(playerid, mode, arr_busRoute2[currentBRoute[playerid]][b_x], arr_busRoute2[currentBRoute[playerid]][b_y], arr_busRoute2[currentBRoute[playerid]][b_z], mode ? (-1.00) : (arr_busRoute2[currentBRoute[playerid] + 1][b_x]), mode ? (-1.00) : (arr_busRoute2[currentBRoute[playerid] + 1][b_y]), mode ? (-1.00) : (arr_busRoute2[currentBRoute[playerid] + 1][b_z]), 6);
				busCounter[playerid] = arr_busRoute2[currentBRoute[playerid]][b_time];
			}
			case 3:
			{
				SetPlayerRaceCheckpoint(playerid, mode, arr_busRoute3[currentBRoute[playerid]][b_x], arr_busRoute3[currentBRoute[playerid]][b_y], arr_busRoute3[currentBRoute[playerid]][b_z], mode ? (-1.00) : (arr_busRoute3[currentBRoute[playerid] + 1][b_x]), mode ? (-1.00) : (arr_busRoute3[currentBRoute[playerid] + 1][b_y]), mode ? (-1.00) : (arr_busRoute3[currentBRoute[playerid] + 1][b_z]), 6);
				busCounter[playerid] = arr_busRoute3[currentBRoute[playerid]][b_time];
			}
		}
	}
	return 1;
}

SetBusCheckpointRoute(playerid)
{
	currentBRoute[playerid] ++;

	if((busRoute[playerid] == 1 && currentBRoute[playerid] == sizeof(arr_busRoute1)) ||	(busRoute[playerid] == 2 && currentBRoute[playerid] == sizeof(arr_busRoute2)) || (busRoute[playerid] == 3 && currentBRoute[playerid] == sizeof(arr_busRoute3)))
	{
		CancelBusProgress(playerid, true);
		
		new
			bonus,
			salary = JobConfig_GetBaseSalary(SIDEJOB_BUS_DRIVER)
		;
		JobConfig_GetBonus(SIDEJOB_BUS_DRIVER, bonus);

		SetBusDelay(playerid, JobConfig_GetSuccessDelay(SIDEJOB_BUS_DRIVER));
		AddPlayerSalary(playerid, salary + bonus, "Bus Sidejob");
		SendCustomMessage(playerid, "BUS","Kamu telah menyelesaikan pekerjaan, dan kamu mendapat upah "COL_GREEN"$%s (+ bonus: %s) "WHITE"dari pekerjaan ini.", FormatNumber(salary), FormatNumber(bonus));
	}
	else if((busRoute[playerid] == 1 && currentBRoute[playerid] == sizeof(arr_busRoute1) - 1) || (busRoute[playerid] == 2 && currentBRoute[playerid] == sizeof(arr_busRoute2) - 1) || (busRoute[playerid] == 3 && currentBRoute[playerid] == sizeof(arr_busRoute3) - 1))
	{
		SetBusCheckpoin(playerid, 1);
	}
	else SetBusCheckpoin(playerid, 0);
	return 1;
}


Dialog:BusSidejob(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Dialog_Show(playerid, BusSideJobRoute, DIALOG_STYLE_LIST, "Bus Route", "Route A\nRoute B\nRoute C", "Select", "Close");
	}
	else SendCustomMessage(playerid, "BUS SIDEJOB", "Kamu menolak pekerjaan ini dan turun dari kendaraan."),RemovePlayerFromVehicle(playerid);
	return 1;
}
Dialog:BusSideJobRoute(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SetPlayerWorkInBus(playerid);

		currentBRoute[playerid] = 0;
		busRoute[playerid] = listitem+1;

		SetEngineStatus(GetPlayerVehicleID(playerid), true);
		SetDoorStatus(GetPlayerVehicleID(playerid), true);

		SetBusCheckpoin(playerid, 0);
		SendCustomMessage(playerid, "BUS SIDEJOB", "Ikuti checkpoint yang ada dimap, itu merupakan rute tujuan yang akan dilalui.");
	}
	else SendCustomMessage(playerid, "BUS SIDEJOB", "Kamu menolak pekerjaan ini dan turun dari kendaraan."),RemovePlayerFromVehicle(playerid);
	return 1;
}
Dialog:BusSidejobLeave(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		PutPlayerInVehicle(playerid, GetPlayerLastVehicle(playerid), 0);
		return SendCustomMessage(playerid, "BUS SIDEJOB","Lanjutkan kembali pekerjaanmu, ikuti rute yang telah diberikan.");
	}
	else CancelBusProgress(playerid);
	return 1;
}


ptask Player_BusUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	if(IsPlayerWorkInBus(playerid))
	{
		if(IsPlayerInRaceCheckpoint(playerid))
		{
			if(--busCounter[playerid] == 0)
			{
				SetBusCheckpointRoute(playerid);
				return 1;
			}

			GameTextForPlayer(playerid, sprintf("WAITING TIME~n~%02d", busCounter[playerid]), 1000, 6);
			PlayerPlaySoundEx(playerid, 43000);
		}

		new
			Float:max_speed
		;

		JobConfig_GetBusMaxSpeed(max_speed);

		if(floatcmp(max_speed, GetVehicleSpeed(GetPlayerVehicleID(playerid))) == -1)
		{
			if(++PlayerData[playerid][pTestWarns] <= 3)
			{
				ShowPlayerFooter(playerid, sprintf("Hati-hati, batas kecapatan maksimal ~r~80 kmh ~w~(kesempatan ~y~%d/3~w~)", PlayerData[playerid][pTestWarns]), 3000, 1);
				SetVehicleSpeed(GetPlayerVehicleID(playerid), 20);
			}
			else CancelBusProgress(playerid);
		}
	}

	if(GetBusDelay(playerid))
	{
		SetBusDelay(playerid, (GetBusDelay(playerid)-1));

		if(!GetBusDelay(playerid)) {
			UpdateCharacterInt(playerid, "BusDelay", 0);
			SendCustomMessage(playerid, "BUS SIDEJOB", "Kamu bisa bekerja "CYAN"Bus "WHITE"kembali!.");
		}
	}
	return 1;
}

CMD:resetbus(playerid, params[])
{
	new userid;

	if(CheckAdmin(playerid, 5))
		return PermissionError(playerid);
	
	if(sscanf(params, "u", userid))
		return SendSyntaxMessage(playerid, "/resetbus [targetid]");

	SetBusDelay(userid, 0);
	SendServerMessage(playerid, "Kamu menghapus delay bus "RED"%s.", ReturnName(userid, 0));
	return 1;
}