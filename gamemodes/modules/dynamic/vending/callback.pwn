#include <YSI\y_hooks>

// Event
hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, "SELECT * FROM `vending` ORDER BY `vendID` ASC LIMIT "#MAX_DYNAMIC_VENDING";", "Vending_Load", "");
}

hook OnPlayerConnect(playerid)
{
	Vending_SetInside(playerid, INVALID_VENDING_ID);
	playerUseVending[playerid] = 0;
}

hook OnPlayerDisconnect(playerid, reason)
{
	Vending_SetInside(playerid, INVALID_VENDING_ID);
	playerUseVending[playerid] = 0;
}

hook OnPlayerEnterDynArea(playerid, areaid)
{
	new streamer_info[2];
	Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, streamer_info);

	if(streamer_info[0] == VENDING_AREA_INDEX)
	{
		new index = streamer_info[1];

		if(Vending_IsExists(index)) 
		{
			new string[1024];
			if(VendingData[index][vendOwner] == INVALID_OWNER_ID)
			{
				format(string, sizeof(string), "~g~~h~[ID:%d]~n~[For Sell]~n~%s~n~~y~'/buy'~w~ untuk membeli vending machine ini", index, FormatNumber(VendingData[index][vendPrice]));
				ShowPlayerFooter(playerid, string, 10000, 1);
			}
			else
			{
				format(string, sizeof(string), "~g~~h~[ID:%d]~n~[Owner]~n~%s~n~%s~n~~w~Tekan Tombol '~y~H~w~' Price : ~g~%s", index, VendingData[index][vendOwnerName], VendingData[index][vendName], FormatNumber(VendingData[index][vendStockPrice]));
				ShowPlayerFooter(playerid, string, 10000, 1);
			}
			Vending_SetInside(playerid, index);
		}
	}
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	new streamer_info[1];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, streamer_info);

    if(streamer_info[0] == VENDING_AREA_INDEX) {
    	HidePlayerFooter(playerid);
    	Vending_SetInside(playerid, INVALID_VENDING_ID);
    }
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CTRL_BACK) //Key H
	{
		new index, Float:x, Float:y;
		if((index = Vending_GetInside(playerid)) != INVALID_VENDING_ID && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			GetXYInFrontOfVending(index, x, y, 0.5);
			if(IsPlayerInRangeOfPoint(playerid, 1, x, y, VendingData[index][vendPosZ]))
			{
				if(!playerUseVending[playerid])
				{
					if(VendingData[index][vendStock] > 0)
					{
						if(GetMoney(playerid) >= VendingData[index][vendStockPrice])
						{
							ApplyAnimation(playerid, "VENDING", "VEND_Use", 4.1, 0, 0, 0, 0, 0, 1);
							if(VendingData[index][vendType] == VENDING_MACHINE_TYPE_SNACK) 
							{
								PlayerPlaySound(playerid, 42601, 0.0, 0.0, 0.0);
								SetPlayerHunger(playerid, PlayerData[playerid][pHunger]+10.0);
							}
							else 
							{
								PlayerPlaySound(playerid, 42600, 0.0, 0.0, 0.0);
								SetPlayerEnergy(playerid, PlayerData[playerid][pEnergy]+10.0);
							}
							GiveMoney(playerid, -VendingData[index][vendStockPrice], ECONOMY_ADD_SUPPLY, "bought vending machine");

							VendingData[index][vendVault] += VendingData[index][vendStockPrice];
							VendingData[index][vendStock]--;

							SetHealth(playerid, GetHealth(playerid)+10.0);
							defer Player_UseVending(playerid, index);
							playerUseVending[playerid] = 1;
							Vending_Save(index);
						}
						else ShowPlayerFooter(playerid, "~r~ERROR:~w~ You dont have enough money!", 5000, 1);
					}
					else ShowPlayerFooter(playerid, "~r~ERROR:~w~ This vending machine is empty!", 5000, 1);
				}
			}
		}
	}
}

timer Player_UseVending[3000](playerid, index)
{
	if(!IsPlayerAttachedObjectSlotUsed(playerid, WEAPON_SLOT))
	{
		if(Vending_IsExists(index) && VendingData[index][vendType] == VENDING_MACHINE_TYPE_SNACK)
			SetPlayerAttachedObject(playerid, WEAPON_SLOT, 2702, 6, 0.173041, 0.049197, 0.056789, 0.000000, 274.166107, 299.057983, 1.000000, 1.000000, 1.000000);
		
		SetTimerEx("RemoveAttachedObject", 3000, false, "dd", playerid, WEAPON_SLOT);
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
		defer Player_ResetVending(playerid);
	}
	return 1;
}

timer Player_ResetVending[500](playerid)
{
	playerUseVending[playerid] = 0;
	return 1;
}