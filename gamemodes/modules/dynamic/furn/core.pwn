/*
	Defined list for furniture system.
*/
#define MAX_MATERIALS		        16
#define MAX_FURNSTORE				10
#define MAX_EMPLOYE					3

#define MAX_FURN_OBJECT				(MAX_FURNSTORE*100)
#define MAX_FURNSTORE_OBJECT		50

new ManageFurnStore[MAX_PLAYERS] = {-1, ...},
	ManageFurnObject[MAX_PLAYERS] = {-1, ...},
	SelectToFired[MAX_PLAYERS][MAX_EMPLOYE],
	ListedFurnObject[MAX_PLAYERS][MAX_FURNSTORE_OBJECT],
	editFurnPosition[MAX_PLAYERS] = {-1, ...};
    
new produceObject[MAX_PLAYERS] = {INVALID_OBJECT_ID, ...},
    bool:startProduce[MAX_PLAYERS],
    productionCount[MAX_PLAYERS],
    productionAdd[MAX_PLAYERS],
    Timer:productionTimer[MAX_PLAYERS];

enum E_FURNSTORE
{
	storeID,

	storeName[32],
	storeOwnerName[MAX_PLAYER_NAME],

	Float:storePos[3],
	Float:storeIntPos[3],

	storeOwner,
	storePrice,
	storeVault,
	storeEmploye[MAX_EMPLOYE],

	storePickup,
	Text3D:storeLabel,
	storeCP
};

new storeData[MAX_FURNSTORE][E_FURNSTORE],
	Iterator:FurnStore<MAX_FURNSTORE>;


enum E_FURNPROP {
	furnID,

	furnName[32],

	Float:furnPos[3],
	Float:furnRot[3],
	furnPrice,
	furnStock,
	furnModel,
	furnStoreId,

	furnMaterials[MAX_MATERIALS],

	Text3D:furnLabel,
	furnObject
};
new FurnStore[MAX_FURN_OBJECT][E_FURNPROP],
	Iterator:FurnObject<MAX_FURN_OBJECT>;

public OnGameModeInit()
{
	new tmpobjid;
    tmpobjid = CreateDynamicObject(19379, 1479.442504, 1771.412963, 9.820310, 0.000000, 90.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14771, "int_brothelint3", "carpbroth1", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1479.442504, 1771.412963, 13.380313, 0.000000, 90.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "donut_ceil", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1468.942382, 1771.412963, 9.820310, 0.000000, 90.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14771, "int_brothelint3", "carpbroth1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19379, 1479.442504, 1781.023681, 9.820310, 0.000000, 90.000038, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14771, "int_brothelint3", "carpbroth1", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1468.942382, 1781.023681, 9.820310, 0.000000, 90.000038, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14771, "int_brothelint3", "carpbroth1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19445, 1470.069335, 1766.577636, 11.570336, 0.000022, 0.000000, 89.999931, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 14531, "int_zerosrca", "CJ_RC_WIN", 0x00000000);
    tmpobjid = CreateDynamicObject(19805, 1479.000732, 1766.639282, 12.046256, 0.000000, -0.000022, 179.999862, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 14531, "int_zerosrca", "CJ_RC_WIN", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1479.442504, 1790.631347, 9.820310, 0.000000, 90.000045, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14771, "int_brothelint3", "carpbroth1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19379, 1468.942382, 1790.631347, 9.820310, 0.000000, 90.000045, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14771, "int_brothelint3", "carpbroth1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19445, 1470.069335, 1795.403076, 11.570336, 0.000029, 0.000000, 89.999908, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 14531, "int_zerosrca", "CJ_RC_WIN", 0x00000000);
    tmpobjid = CreateDynamicObject(19805, 1469.099731, 1766.639282, 12.046256, 0.000000, -0.000022, 179.999862, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 14531, "int_zerosrca", "CJ_RC_WIN", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1468.972167, 1771.412963, 13.380313, 0.000000, 90.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "donut_ceil", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1479.442504, 1781.003295, 13.380313, 0.000000, 90.000030, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "donut_ceil", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1468.972167, 1781.003295, 13.380313, 0.000000, 90.000030, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "donut_ceil", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1479.442504, 1790.624023, 13.380313, 0.000000, 90.000038, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "donut_ceil", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1468.972167, 1790.624023, 13.380313, 0.000000, 90.000038, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "donut_ceil", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1484.748901, 1781.057250, 11.570336, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1484.748901, 1793.887329, 11.570336, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
    tmpobjid = CreateDynamicObject(19383, 1484.748901, 1787.476440, 11.570336, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1489.417846, 1781.057250, 11.570336, 0.000022, 0.000007, 89.999931, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1494.109130, 1785.915893, 11.570336, 0.000000, -0.000015, 179.999862, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1494.109130, 1795.534545, 11.570336, 0.000000, -0.000015, 179.999862, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1489.588256, 1795.534545, 11.570336, -0.000022, 0.000007, -89.999931, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "breezewall", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1489.911987, 1790.615356, 13.380313, 0.000000, 90.000038, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "donut_ceil", 0x00000000);
    tmpobjid = CreateDynamicObject(19377, 1489.911987, 1781.014282, 13.380313, 0.000000, 90.000038, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "donut_ceil", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1489.922729, 1790.631347, 9.820310, 0.000000, 90.000045, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "stadium_ground2", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 14531, "int_zerosrca", "stadium_ground2", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 1489.922729, 1780.996948, 9.820310, 0.000000, 90.000045, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 14531, "int_zerosrca", "stadium_ground2", 0x00000000);
    tmpobjid = CreateDynamicObject(2459, 1473.646606, 1776.077148, 9.906250, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
    tmpobjid = CreateDynamicObject(2459, 1473.646606, 1781.775512, 9.906250, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
    tmpobjid = CreateDynamicObject(2459, 1473.646606, 1787.336791, 9.906250, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
    tmpobjid = CreateDynamicObject(2460, 1468.405029, 1767.163330, 9.906250, 0.000022, 0.000000, 89.999931, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
    tmpobjid = CreateDynamicObject(2460, 1472.895019, 1768.624023, 9.906250, 0.000000, -0.000022, 179.999862, -1, 3, -1, 150.00, 150.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(19899, 1486.277587, 1795.005615, 9.923306, -0.000022, 0.000000, -89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19445, 1484.598754, 1771.427856, 11.570336, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19445, 1479.688232, 1766.577636, 11.570336, 0.000022, 0.000000, 89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19353, 1463.652099, 1766.557250, 11.570314, 0.000022, 0.000000, 89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19445, 1484.598754, 1781.057250, 11.570336, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19445, 1479.688232, 1795.403076, 11.570336, 0.000029, 0.000000, 89.999908, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19353, 1463.652099, 1795.382690, 11.570314, 0.000029, 0.000000, 89.999908, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19445, 1484.598754, 1793.887329, 11.570336, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19383, 1484.598754, 1787.476440, 11.570336, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19445, 1463.716918, 1774.656982, 11.570336, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19445, 1463.716918, 1784.147583, 11.570336, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19445, 1463.716918, 1793.787231, 11.570336, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19383, 1463.716918, 1768.236083, 11.570336, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1496, 1463.677368, 1767.508789, 9.816246, 0.000022, 0.000000, 89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1893, 1478.857543, 1769.752319, 13.296257, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1893, 1468.365722, 1769.752319, 13.296257, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1893, 1478.857543, 1779.355102, 13.296257, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1893, 1468.365722, 1779.355102, 13.296257, 0.000000, 0.000029, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1893, 1478.857543, 1788.976074, 13.296257, 0.000000, 0.000037, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1893, 1468.365722, 1788.976074, 13.296257, 0.000000, 0.000037, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2414, 1484.156616, 1771.097045, 9.906250, -0.000022, 0.000000, -89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2414, 1484.156616, 1773.097778, 9.906250, -0.000022, 0.000000, -89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2414, 1484.156616, 1775.097656, 9.906250, -0.000022, 0.000000, -89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2414, 1484.156616, 1777.087036, 9.906250, -0.000029, 0.000000, -89.999908, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2190, 1468.129394, 1767.497436, 10.966259, 0.000022, 0.000000, 89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2414, 1470.454101, 1768.645263, 9.906250, 0.000000, -0.000022, 179.999862, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1514, 1469.326293, 1768.496215, 11.196251, 0.000000, -0.000022, 179.999862, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2362, 1469.116699, 1768.612792, 10.966258, 0.000000, -0.000022, 179.999862, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(1885, 1469.312866, 1769.303466, 9.906250, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2482, 1471.081176, 1766.759277, 9.886248, 0.000000, -0.000022, 179.999862, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2482, 1472.511474, 1766.759277, 9.886248, 0.000000, -0.000022, 179.999862, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2414, 1484.156616, 1779.087768, 9.906250, -0.000029, 0.000000, -89.999908, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2414, 1484.156616, 1781.087646, 9.906250, -0.000029, 0.000000, -89.999908, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19899, 1485.356323, 1782.964477, 9.923306, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19900, 1485.233764, 1784.734008, 9.882514, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(2491, 1474.002807, 1768.903564, 9.906250, 0.000000, 0.000022, 0.000000, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19921, 1485.542358, 1783.072875, 11.265328, 0.000022, -0.000003, 98.499931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(3033, 1489.404541, 1789.140136, 9.908346, 89.999992, 540.000000, -89.999969, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(3033, 1491.863891, 1789.140136, 9.908346, 89.999992, 540.000000, -89.999969, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(3041, 1493.505004, 1790.096191, 9.842520, 0.000022, 0.000000, 89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(3041, 1493.505004, 1785.454833, 9.842520, 0.000022, 0.000000, 89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19815, 1493.965209, 1785.406738, 11.846323, -0.000022, 0.000000, -89.999931, -1, 3, -1, 150.00, 150.00);
    tmpobjid = CreateDynamicObject(19815, 1493.965209, 1790.218139, 11.846323, -0.000022, 0.000000, -89.999931, -1, 3, -1, 150.00, 150.00);

	#if defined store_OnGameModeInit
		return store_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit store_OnGameModeInit
#if defined store_OnGameModeInit
	forward store_OnGameModeInit();
#endif