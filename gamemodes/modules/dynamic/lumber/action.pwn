#include <YSI\y_hooks>

hook OnPlayerConnect(playerid) {
	SetPVarInt(playerid, "lumber_cutting", -1);
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(GetPlayerJob(playerid) == JOB_LUMBERJACK && GetPVarInt(playerid, "lumber_cutting") != -1)
    {
        new 
            lumber_id = GetPVarInt(playerid, "lumber_cutting");

        Reset_Lumber(playerid);
        LumberData[lumber_id][lumberGetCut]   = false;
        LumberData[lumber_id][lumberCut]      = true;
    }
}

task Lumber_FeatureUpdate[1000]()
{
	foreach(new i : Lumbers) if(LumberData[i][lumberTime]) {
		LumberData[i][lumberTime]--;

		if(!LumberData[i][lumberTime]) {
			Lumber_Sync(i);
		}
	}
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_NO) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerJob(playerid) == JOB_LUMBERJACK)
    {
        new id;
        if((id = Lumber_Nearest(playerid, 2)) != -1)
        {
        	if(LumberData[id][lumberTime])
            {
                new
                    times[3];

                GetElapsedTime(LumberData[id][lumberTime], times[0], times[1], times[2]);
                GameTextForPlayer(playerid, sprintf("~g~~h~Harap Menunggu...~n~~y~~h~%02d:%02d:%02d", times[0], times[1], times[2]), 2000, 4);
                return 1;
            }

        	if(LumberData[id][lumberCut])
        		return GameTextForPlayer(playerid, "~g~~h~/loadtree~n~~y~~h~untuk_meletakkan~n~~y~~h~ke_mobil_pickup.", 1000, 4);

            if(GetPlayerWeapon(playerid) != WEAPON_CHAINSAW)
            	return GameTextForPlayer(playerid, "~g~~h~Potong pohon~n~~y~~h~dengan chainsaw '~w~N~y~~h~'", 2000, 4);

        	if(LumberData[id][lumberGetCut])
            	return GameTextForPlayer(playerid, "~g~~h~Pohon sedang dipotong ...'", 2000, 4);

            TogglePlayerControllable(playerid, 0);
            SetPlayerArmedWeapon(playerid, WEAPON_CHAINSAW);
            SetPlayerLookAt(playerid, LumberData[id][lumberPos][0], LumberData[id][lumberPos][1]);

            LumberData[id][lumberGetCut] = true;
            SetPVarInt(playerid, "lumber_cutting", id);

            lumber_timer[playerid] = repeat HarvestingLumber(playerid);

            SetPlayerProgressBarValue(playerid, PlayerData[playerid][pCuttingBar], 0.0);
            ShowPlayerProgressBar(playerid, PlayerData[playerid][pCuttingBar]);

            ApplyAnimation(playerid, "CRACK", "null", 4.0, 0, 0, 0, 1, 0, 1);
            ApplyAnimation(playerid, "CHAINSAW", "WEAPON_csaw", 4.1, 1, 0, 0, 1, 0, 1);

            SendServerMessage(playerid, "Tekan '"RED"F"WHITE"' untuk menggagalkan pemotongan.");
        }
    }

    if((newkeys & KEY_SECONDARY_ATTACK) && GetPlayerJob(playerid) == JOB_LUMBERJACK && GetPVarInt(playerid, "lumber_cutting") != -1)
    {
        new 
            lumber_id = GetPVarInt(playerid, "lumber_cutting");

        Reset_Lumber(playerid);
        LumberData[lumber_id][lumberGetCut]   = false;
        SendServerMessage(playerid, "Kamu telah menggagalkan proses pemotongan kayu.");
    }
    return 1;
}

timer HarvestingLumber[1000](playerid) 
{
	new id;

	if((id = GetPVarInt(playerid, "lumber_cutting")) != -1)
    {
        if(GetPlayerWeapon(playerid) == WEAPON_CHAINSAW)
        {
            new Float:time, level = GetLumberLevel(playerid);

            switch(level)
            {
                case 1: time = 2.0; 
                case 2: time = 5.0; 
                case 3: time = 7.5; 
                default: time = 10.0; 
            }

            new Float: value = (GetPlayerProgressBarValue(playerid, PlayerData[playerid][pCuttingBar]) + time);
            
            if(value >= 100.0)
            {
	            Reset_Lumber(playerid);
                MoveDynamicObject(LumberData[id][lumberObject], LumberData[id][lumberPos][0], LumberData[id][lumberPos][1], LumberData[id][lumberPos][2] - 1.0, 0.025, LumberData[id][lumberRot][0], LumberData[id][lumberRot][1] - 80.0, RandomFloat(0.0,360.0) + LumberData[id][lumberRot][2]);

                LumberData[id][lumberGetCut]   = false;
                LumberData[id][lumberCut]      = true;
                Lumber_Save(id, SAVE_LUMBER_CUTTING);
                return 1;
            }
            SetPlayerProgressBarValue(playerid, PlayerData[playerid][pCuttingBar], value);
            GameTextForPlayer(playerid, "~g~~h~Memotong pohon ..", 1000, 4);
        }
    }
    return 1;
}