#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	SetPVarInt(playerid, "editGateID", -1);
	SetPVarInt(playerid, "editGateMode", EDIT_GATE_NONE);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new gate_id = Gate_Nearest(playerid);

	if (gate_id == -1)
	{
		return 1;
	}

	new toll_price = Gate_GetTollPrice(gate_id);

	if (toll_price > 0)
	{
		if (IsPlayerInAnyVehicle(playerid) && PRESSED(KEY_CROUCH))
		{
			if (Gate_IsDisabled(gate_id))
			{
				ShowPlayerFooter(playerid, "Gerbang tol ~r~dimatikan~w~!", 3000, 1);
				return 1;
			}

			if (Gate_IsOpened(gate_id))
			{
				ShowPlayerFooter(playerid, "Gerbang tol sudah ~g~terbuka~w~!", 3000, 1);
				return 1;
			}

			if (toll_price > GetMoney(playerid))
			{
				ShowPlayerFooter(playerid, sprintf("Uang kamu ~r~tidak cukup~w~! Biaya: $%d", toll_price), 3000, 1);
				return 1;
			}


			if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC && GetFactionType(playerid) != FACTION_GOV)
			{
				GiveMoney(playerid, -toll_price, ECONOMY_ADD_SUPPLY, "pay toll gate");
				ShowPlayerFooter(playerid, "Terima kasih telah ~g~membayar tol~w~!", 3000, 1);
				for(new i = 0; i != MAX_FACTIONS; i++) if(FactionData[i][factionExists] && FactionData[i][factionType] == FACTION_GOV) {
					FactionData[i][factionMoney] += toll_price;
				}
			}

			Gate_Operate(gate_id);
			defer Gate_Operate[5000](gate_id);		
		}
	}
	else if(((GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (newkeys & KEY_CROUCH)) || ((GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) && (newkeys & KEY_CTRL_BACK)))
	{
		if (Gate_IsDisabled(gate_id))
		{
			ShowPlayerFooter(playerid, "Gerbang ~r~dimatikan~w~!", 3000, 1);
			return 1;
		}

		if(!strcmp(GateData[gate_id][gatePassword], "none")) 
		{
			if((Gate_Faction(gate_id) != -1))
			{
				if(GetPlayerFactionID(playerid) == Gate_Faction(gate_id) || GetFactionType(playerid) == FACTION_POLICE)
				{
					Gate_Operate(gate_id);
				}
			}
			else
			{
				Gate_Operate(gate_id);
			}
		}
		else
		{
			Dialog_Show(playerid, PasswordedGate, DIALOG_STYLE_INPUT, "Gate Password", "Masukkan password:", "Masukkan", "");
		}
	}
	return 1;
}

hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(GetPVarInt(playerid, "editGateID") != -1)
	{
		new gate_id = GetPVarInt(playerid, "editGateID"),
			edit_mode = GetPVarInt(playerid, "editGateMode")
		;

		if(response == EDIT_RESPONSE_CANCEL)
    	{
    		Gate_Sync(gate_id);

    		SetPVarInt(playerid, "editGateID", -1);
			SetPVarInt(playerid, "editGateMode", EDIT_GATE_NONE);

			SendServerMessage(playerid, "Gagal mengubah posisi gate.");
    	}

    	if(response == EDIT_RESPONSE_FINAL)
    	{
    		if(edit_mode == EDIT_GATE_POS) {
    			Gate_SetObjectPos(gate_id, x, y, z, rx, ry, rz);
    			
    			Gate_Sync(gate_id);
    			Gate_Save(gate_id, SAVE_GATE_POS);
    			SendServerMessage(playerid, "Posisi utama gate telah perbaharui.");
    		}

    		if(edit_mode == EDIT_GATE_MOVE) {
    			Gate_SetObjectMove(gate_id, x, y, z, rx, ry, rz);

    			Gate_Sync(gate_id);
    			Gate_Save(gate_id, SAVE_GATE_MOVE);
    			SendServerMessage(playerid, "Posisi perpindahan gate telah perbaharui.");
    		}
	    	SetPVarInt(playerid, "editGateID", -1);
			SetPVarInt(playerid, "editGateMode", EDIT_GATE_NONE);
    	}
	}
}

// Dialog response
Dialog:PasswordedGate(playerid, response, listitem, inputtext[]) 
{
    if(response)  
	{
		new gate_id = Gate_Nearest(playerid);

    	if(strlen(inputtext) > 10)
			return Dialog_Show(playerid, PasswordedGate, DIALOG_STYLE_INPUT, "Gate Password", "Password salah\n\nMasukkan password:", "Masukkan", "");
			
		if(gate_id != -1)
		{
			if(!strcmp(inputtext, GateData[gate_id][gatePassword])) 
			{
				Gate_Operate(gate_id);
			}
			else 
			{
				Dialog_Show(playerid, PasswordedGate, DIALOG_STYLE_INPUT, "Gate Password", "Password salah\n\nMasukkan password:", "Masukkan", "");
			}
		}
		else SendErrorMessage(playerid, "You're not near any gate!");
	}
    return 1;
}