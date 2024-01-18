#include <YSI\y_hooks>

#define MAX_LOBBY_VIRTUAL_WORLD (100000)

new Lobby_World[MAX_LOBBY_VIRTUAL_WORLD+1] = {1, 2, ...};

Lobby_CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD)
{
    #pragma unused worldid
    #pragma unused interiorid
    #pragma unused playerid

    new objectid;

	objectid = CreateDynamicObjectEx(modelid, x, y, z, rx, ry, rz, streamdistance, drawdistance, Lobby_World, { -1 }, { -1 }, { -1 });

    return objectid;
}

hook OnGameModeInit()
{
	new tmpobjid;
	tmpobjid = Lobby_CreateDynamicObject(19378, 1961.678466, 1913.296264, 129.937500, 180.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14786, "ab_sfgymbeams", "gym_floor5", 0xFF584116);
	tmpobjid = Lobby_CreateDynamicObject(19378, 1961.678466, 1913.296264, 133.247467, 180.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18200, "w_town2cs_t", "mottled_creme_64HV", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19378, 1965.061523, 1917.167114, 129.937500, 0.000000, 180.000000, -89.999992, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1964.576293, 1917.148559, 128.523437, 0.000007, 0.000007, 89.999946, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19378, 1965.913574, 1912.680908, 129.937500, 0.000007, 180.000000, 179.999969, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1964.576293, 1917.148559, 132.603469, 0.000007, 0.000007, 89.999946, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1965.895019, 1913.166137, 128.523437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1965.895019, 1913.166137, 132.603469, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1965.864990, 1913.166137, 134.733505, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1965.864990, 1913.166137, 128.463485, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1964.576293, 1917.118530, 134.733505, 0.000007, 0.000007, 89.999946, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1964.576293, 1917.118530, 128.463485, 0.000007, 0.000007, 89.999946, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19378, 1960.264770, 1914.035156, 129.937500, -0.000007, 180.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1960.283325, 1913.549926, 128.523437, 0.000015, 0.000000, 179.999847, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1960.283325, 1913.549926, 132.603469, 0.000015, 0.000000, 179.999847, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1960.313354, 1913.549926, 134.733505, 0.000015, 0.000000, 179.999847, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1960.313354, 1913.549926, 128.463485, 0.000015, 0.000000, 179.999847, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19378, 1962.006713, 1911.048095, 129.937500, 0.000007, 180.000000, 89.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1962.491943, 1911.066650, 128.523437, 0.000000, -0.000007, -90.000091, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1962.491943, 1911.066650, 132.603469, 0.000000, -0.000007, -90.000091, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1962.491943, 1911.096679, 134.733505, 0.000000, -0.000007, -90.000091, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19448, 1962.491943, 1911.096679, 128.463485, 0.000000, -0.000007, -90.000091, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = Lobby_CreateDynamicObject(19354, 1963.101074, 1911.125610, 131.523422, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14577, "casinovault01", "dts_elevator_door", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = Lobby_CreateDynamicObject(1566, 1962.279541, 1917.070434, 131.523437, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
	tmpobjid = Lobby_CreateDynamicObject(638, 1964.048095, 1916.622802, 130.563461, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
	tmpobjid = Lobby_CreateDynamicObject(1726, 1965.408447, 1915.367431, 130.023437, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 

}