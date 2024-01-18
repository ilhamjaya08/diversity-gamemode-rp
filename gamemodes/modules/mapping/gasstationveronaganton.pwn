#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
//Remove Buildings///////////////////////////////////////////////////////////////////////////////////////////////
RemoveBuildingForPlayer(playerid, 17519, 2450.875, -1757.398, 16.000, 0.250);
RemoveBuildingForPlayer(playerid, 17757, 2450.875, -1757.398, 16.000, 0.250);
RemoveBuildingForPlayer(playerid, 17523, 2436.218, -1788.562, 15.023, 0.250);
RemoveBuildingForPlayer(playerid, 17765, 2436.218, -1788.562, 15.023, 0.250);
}
//Objects////////////////////////////////////////////////////////////////////////////////////////////////////////
hook OnGameModeInit()
{
new tmpobjid;
tmpobjid = CreateObject(5409, 2440.627929, -1775.240966, 17.156999, 0.000000, 0.000000, 90.000000, 300.00); 
SetObjectMaterial(tmpobjid, 1, 10377, "cityhall_sfs", "ws_concretenew_step", 0x00000000);
tmpobjid = CreateObject(19545, 2445.951904, -1773.446044, 12.722000, 0.000000, 0.500000, 0.246998, 300.00); 
SetObjectMaterial(tmpobjid, 0, 3452, "bballvgnint", "Bow_Abattoir_Conc2", 0x00000000);
tmpobjid = CreateObject(19545, 2431.107910, -1773.447998, 12.696997, 0.000000, 359.247009, 0.246997, 300.00); 
SetObjectMaterial(tmpobjid, 0, 3452, "bballvgnint", "Bow_Abattoir_Conc2", 0x00000000);
tmpobjid = CreateObject(19545, 2450.915039, -1773.454956, 12.671998, 0.000000, 0.500000, 0.246998, 300.00); 
SetObjectMaterial(tmpobjid, 0, 3452, "bballvgnint", "Bow_Abattoir_Conc2", 0x00000000);
tmpobjid = CreateObject(3660, 2433.486083, -1792.894042, 14.498997, 0.000000, 0.000000, 0.000000, 300.00); 
SetObjectMaterial(tmpobjid, 0, 13364, "cetown3cs_t", "ws_sandstone2", 0x00000000);
SetObjectMaterial(tmpobjid, 1, 12908, "ce_ground11", "grassdead1", 0x00000000);
SetObjectMaterial(tmpobjid, 3, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
tmpobjid = CreateObject(3660, 2448.711914, -1792.878051, 14.498997, 0.000000, 0.000000, 0.000000, 300.00); 
SetObjectMaterial(tmpobjid, 0, 13364, "cetown3cs_t", "ws_sandstone2", 0x00000000);
SetObjectMaterial(tmpobjid, 1, 12908, "ce_ground11", "grassdead1", 0x00000000);
SetObjectMaterial(tmpobjid, 3, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
tmpobjid = CreateObject(8947, 2440.392089, -1772.255004, 9.781000, 0.000000, 0.000000, 270.000000, 300.00); 
SetObjectMaterial(tmpobjid, 1, 13364, "cetown3cs_t", "ws_sandstone2", 0x00000000);
SetObjectMaterial(tmpobjid, 2, 13364, "cetown3cs_t", "ws_sandstone2", 0x00000000);
tmpobjid = CreateObject(3578, 2458.487060, -1787.073974, 11.826000, 0.000000, 0.000000, 270.000000, 300.00); 
SetObjectMaterial(tmpobjid, 0, 10377, "cityhall_sfs", "ws_concretenew_step", 0x00000000);
tmpobjid = CreateObject(3578, 2458.499023, -1776.791015, 11.826000, 0.000000, 0.000000, 270.000000, 300.00); 
SetObjectMaterial(tmpobjid, 0, 10377, "cityhall_sfs", "ws_concretenew_step", 0x00000000);
tmpobjid = CreateObject(3578, 2458.510009, -1766.488037, 11.826000, 0.000000, 0.000000, 270.000000, 300.00); 
SetObjectMaterial(tmpobjid, 0, 10377, "cityhall_sfs", "ws_concretenew_step", 0x00000000);
tmpobjid = CreateObject(3578, 2458.527099, -1756.969970, 11.826000, 0.000000, 0.000000, 270.000000, 300.00); 
SetObjectMaterial(tmpobjid, 0, 10377, "cityhall_sfs", "ws_concretenew_step", 0x00000000);
tmpobjid = CreateObject(3406, 2424.653076, -1798.031982, 10.543000, 0.000000, 0.000000, 90.000000, 300.00); 
SetObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
SetObjectMaterial(tmpobjid, 1, 13364, "cetown3cs_t", "ws_sandstone2", 0x00000000);
SetObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
}
///////////////////////