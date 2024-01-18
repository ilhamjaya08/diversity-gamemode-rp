#include <a_samp> 
#include <mapandreas> 
#include <YSI\y_hooks>

#define 	chopperid 497 //ID of the vehicle model ( http://wiki.sa-mp.com/wiki/Vehicles:Helicopters )
#define 	ropelength 50 //length of slideable rope (ingame meters)
#define 	SWATSKIN 285 //the skin, who may slide down the rope ( http://wiki.sa-mp.com/wiki/Skins:All )

#define offsetz 12
#define dur 250

new r0pes[MAX_PLAYERS][ropelength];
new Float:pl_pos[MAX_PLAYERS][5]; //cause pvar + array = sux

new playerUseRope[MAX_PLAYERS];
new playerVehicleRope[MAX_PLAYERS];
// new RopeTimer[MAX_PLAYERS];

hook OnPlayerDisconnect(playerid, reason)
{
    if(playerUseRope[playerid] == 1)
	{
	    for(new destr=0;destr<=ropelength;destr++)
		{
		    DestroyObject(r0pes[playerid][destr]);
		}
	}
}
hook OnVehicleDeath(vehicleid, killerid)
{
	if(GetVehicleModel(vehicleid) == chopperid)
	{
	    foreach(new shg : Player)
		{
	        if(playerVehicleRope[shg] == vehicleid && playerUseRope[shg] == 1)
	        {
	            DisablePlayerCheckpoint(shg);
	            playerUseRope[shg] = 0;
	            DisablePlayerCheckpoint(shg);
	            ClearAnimations(shg);
	            TogglePlayerControllable(shg,1);
	            for(new destr3=0;destr3<=ropelength;destr3++)
				{
				    DestroyObject(r0pes[shg][destr3]);
				}
			}
		}
	}
}

// forward syncanim(playerid);
// public syncanim(playerid)
// {
// 	if(playerUseRope[playerid] == 1)
// 	{
// 		RopeTimer[playerid] = SetTimerEx("syncanim",dur,0,"i",playerid);
// 		ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0,0);
// 	}
// 	else
// 	{
// 		ClearAnimations(playerid);
// 		KillTimer(RopeTimer[playerid]);
// 	}
// 	return 1;
// }

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == chopperid && ispassenger)
	{
		playerVehicleRope[playerid] = GetPlayerVehicleID(playerid);
		playerUseRope[playerid] = 0;
	}
	else playerVehicleRope[playerid] = INVALID_VEHICLE_ID;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if(playerUseRope[playerid] == 1 && GetPlayerSkin(playerid) == SWATSKIN)
    {
        playerUseRope[playerid] = 0;
        playerVehicleRope[playerid] = 0;
        ClearAnimations(playerid);
        TogglePlayerControllable(playerid,0);
        TogglePlayerControllable(playerid,1);
        DisablePlayerCheckpoint(playerid);
        for(new destr4=0;destr4<=ropelength;destr4++)
		{
		    DestroyObject(r0pes[playerid][destr4]);
		}
	}
}