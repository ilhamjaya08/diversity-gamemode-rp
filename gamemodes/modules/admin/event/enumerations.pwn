#include <YSI\y_hooks>

enum _:E_EVENT_TEAM
{
	TEAM_NONE = 0,
	TEAM_A,
	TEAM_B
}

enum _:E_EVENT_TYPE
{
	TYPE_NONE = 0,
	TYPE_TDM,
	TYPE_JETPACK,
	TYPE_DM
}

enum event_Jetpack {
    Float:jX,
    Float:jY,
    Float:jZ
};

new const arrJetEvent[][event_Jetpack] = {
	//Los Santos
	{725.51,-1476.08,29.68},
	{725.10,-1584.11,5.44},
	{725.26,-1667.08,17.05},
	{724.54,-1766.82,6.23},
	{724.42,-1842.11,20.70},
	{724.41,-1857.00,5.35},
	{715.27,-1914.62,19.21},
	{749.51,-1985.47,25.89},
	{805.21,-2048.82,11.13},
	{843.19,-2061.51,3.03},
	{911.29,-2065.96,14.53},
	{993.35,-2064.41,32.82},
	{1060.26,-2041.09,83.97},
	{1130.01,-2039.44,94.28},
	{1232.69,-2037.65,75.04},
	{1148.08,-2037.00,69.00},

    //San Fierro
	{-1533.40, -417.72, 11.40},
	{-1567.65, -452.43, 6.21},
	{-1612.69, -497.22, 13.74},
	{-1734.83, -580.01, 18.18},
	{-1872.11, -579.87, 50.09},
	{-1965.11, -579.28, 29.44},
	{-2069.07, -574.30, 74.39},
	{-2163.35, -481.39, 53.86},
	{-2161.57, -457.08, 44.74},
	{-2110.10, -397.55, 38.23},
	{-2068.84, -394.53, 39.59},
	{-2036.40, -386.08, 39.81},
	{-1996.79, -393.14, 43.32},
	{-1919.60, -450.80, 31.89},
	{-1820.38, -557.38, 30.91},
	{-1491.26,-377.14,15.53},

	//Las Venturas
	{1733.75, 2319.28, 28.35},
	{1696.49, 2328.40, 17.70},
	{1690.81, 2274.46, 21.56},
	{1596.32, 2208.17, 10.82},
	{1596.12, 2187.56, 15.79},
	{1572.73, 2150.90, 12.80},
	{1572.75, 2131.49, 29.58},
	{1572.52, 2085.22, 11.49},
	{1572.65, 2061.60, 30.63},
	{1546.65, 1999.93, 14.73},
	{1484.20, 2009.34, 12.07},
	{1483.90, 1983.16, 13.53},
	{1471.25, 1980.38, 14.19},
	{1472.40, 2013.94, 15.29},
	{1476.86,2052.31,20.87},
	{1518.72, 2062.13, 10.82}
};

enum 	E_EVENT
{
	eventMessage[128],
	eventType,
	eventJetpackType,
	eventCreated,
	eventStart,
	Float:eventHealth,
	Float:eventArmor,
	eventTarget,
	eventBonus,
	eventSelectTeam,
	eventWinner,
	eventOpen,
	eventWorld,
	eventInt,
	eventWeapons[3],
	eventAmmo[3],

	//DM enum's
	Float:eventSpawnX_DM,
	Float:eventSpawnY_DM,
	Float:eventSpawnZ_DM,

	//Team enum's
	eventSkin[2],
	eventTeamScore[2],
	eventScore[2],
	Float:eventSpawnX[2],
	Float:eventSpawnY[2],
	Float:eventSpawnZ[2],
	Float:eventSpawnA[2]
};

new EventData[E_EVENT];