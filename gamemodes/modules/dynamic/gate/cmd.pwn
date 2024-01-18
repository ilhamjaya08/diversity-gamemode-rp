SSCANF:GateMenu(string[]) 
{
	if(!strcmp(string,"create",true)) return 1;
	else if(!strcmp(string,"delete",true)) return 2;
	else if(!strcmp(string,"pos",true)) return 3;
	else if(!strcmp(string,"move",true)) return 4;
	else if(!strcmp(string,"password",true)) return 5;
	else if(!strcmp(string,"radius",true)) return 6;
	else if(!strcmp(string,"faction",true)) return 7;
	else if(!strcmp(string,"linkid",true)) return 8;
	else if(!strcmp(string,"removelinkid",true)) return 9;
	else if(!strcmp(string,"world",true)) return 10;
	else if(!strcmp(string,"interior",true)) return 11;
	else if(!strcmp(string,"tollprice",true)) return 12;
	else if(!strcmp(string,"enable",true)) return 13;
	else if(!strcmp(string,"disable",true)) return 14;
	else if(!strcmp(string,"nearest",true)) return 15;
	return 0;
}

CMD:gatemenu(playerid, params[])
{
    if (CheckAdmin(playerid, 6))
        return PermissionError(playerid);

	new
		gate_id, action, nextParams[128]
	;

	if(sscanf(params, "k<GateMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/gatemenu [create/delete/pos/move/password/radius/faction/linkid/removelinkid/world/interior/tollprice/enable/disable/nearest]");

	switch(action)
	{
		case 1: // Create
		{
			new modelId;

			if(sscanf(nextParams, "d", modelId))
				return SendSyntaxMessage(playerid, "/gatemenu create <model id>");

			new Float:x, Float:y, Float:z, Float:angle, vw, int;
			GetPlayerPos(playerid, z, z, z);
			GetPlayerFacingAngle(playerid, angle);
			GetXYInFrontOfPlayer(playerid, x, y, 3.0);
			vw  = GetPlayerVirtualWorld(playerid);
			int = GetPlayerInterior(playerid);

			if((gate_id = Gate_Create(modelId, x, y, z, 0, 0, angle, vw, int)) != INVALID_ITERATOR_SLOT) {
				return SendServerMessage(playerid, "Sukses membuat gate dengan id: %d", gate_id);
			}

			SendErrorMessage(playerid, "Slot gate sudah mencapai batas maksimal (%d gate), hubungi scripter segera!.", MAX_DYNAMIC_GATE);
		}
		case 2: // Delete
		{
			new last_gate_id;

			if(sscanf(nextParams, "d", gate_id))
				return SendSyntaxMessage(playerid, "/gatemenu delete <gate id>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			last_gate_id = GateData[gate_id][gateID];

			if(Gate_Delete(gate_id)) {
				foreach(new i : Gates) if(GateData[i][gateLinkID] == last_gate_id) {
	        		GateData[i][gateLinkID] = -1;
			        Gate_Save(i, SAVE_GATE_LINKID);
	        		break;
		        }
				SendServerMessage(playerid, "Gate id "RED"%d "WHITE"telah dihapus dari server!", gate_id);
			}
			else SendErrorMessage(playerid, "Id gate tidak terdaftar diserver.", gate_id);
		}
		case 3: // Position
		{
			if(sscanf(nextParams, "d", gate_id))
				return SendSyntaxMessage(playerid, "/gatemenu pos <gate id>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			if(Gate_Nearest(playerid) == -1)
				return SendErrorMessage(playerid, "Kamu terlalu jauh dari gate tersebut!");

			SetPVarInt(playerid, "editGateID", gate_id);
			SetPVarInt(playerid, "editGateMode", EDIT_GATE_POS);

			Gate_UpdateObjectPos(gate_id);
			EditDynamicObject(playerid, Gate_ObjectID(gate_id));
		}
		case 4: // Move
		{
			if(sscanf(nextParams, "d", gate_id))
				return SendSyntaxMessage(playerid, "/gatemenu move <gate id>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			if(Gate_Nearest(playerid) == -1)
				return SendErrorMessage(playerid, "Kamu terlalu jauh dari gate tersebut!");

			SetPVarInt(playerid, "editGateID", gate_id);
			SetPVarInt(playerid, "editGateMode", EDIT_GATE_MOVE);

			Gate_UpdateObjectPos(gate_id);
			EditDynamicObject(playerid, Gate_ObjectID(gate_id));
		}
		case 5: // Password
		{
			new gate_password[10];

			if(sscanf(nextParams, "ds[10]", gate_id, gate_password))
				return SendSyntaxMessage(playerid, "/gatemenu password <gate id> <password ('none' untuk menghapus)");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			format(GateData[gate_id][gatePassword], 10, gate_password);
			Gate_Save(gate_id, SAVE_GATE_PASSWORD);

			SendServerMessage(playerid, "Sukses mengubah password gate menjadi: "YELLOW"%s.", gate_password);
		}
		case 6: // Radius
		{
			new gate_radius;

			if(sscanf(nextParams, "dd", gate_id, gate_radius))
				return SendSyntaxMessage(playerid, "/gatemenu radius <gate id> <radius (5 - 10)>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			if(gate_radius < 5 || gate_radius > 10)
				return SendErrorMessage(playerid, "Radius hanya dibatasi antara 5 - 10.");

			GateData[gate_id][gateRadius] = gate_radius;
			Gate_Save(gate_id, SAVE_GATE_RADIUS);

			SendServerMessage(playerid, "Sukses mengubah radius gate menjadi: "YELLOW"%d.", gate_radius);
		}
		case 7: // Faction
		{
			new gate_faction;

			if(sscanf(nextParams, "dd", gate_id, gate_faction))
				return SendSyntaxMessage(playerid, "/gatemenu faction <gate id> <faction id (-1 to disable)>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

	        if((gate_faction < -1 || gate_faction >= MAX_FACTIONS) || (gate_faction != -1 && !FactionData[gate_faction][factionExists]))
	            return SendErrorMessage(playerid, "Faction id tidak terdaftar diserver.");

	        GateData[gate_id][gateFaction] = (gate_faction == -1) ? (-1) : (FactionData[gate_faction][factionID]);
	        Gate_Save(gate_id, SAVE_GATE_FACTION);

			SendServerMessage(playerid, "Gate id "YELLOW"%d "WHITE"telah dikhususkan untuk faction id: "YELLOW"%d.", gate_id, gate_faction);
		}
		case 8: // LinkID
		{
			new gate_link;

			if(sscanf(nextParams, "dd", gate_id, gate_link))
				return SendSyntaxMessage(playerid, "/gatemenu linkid <gate id> <gate id link>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			if(!Gate_Exists(gate_link))
				return SendErrorMessage(playerid, "Indeks gate yang akan dilink tidak terdaftar!.");

	        GateData[gate_id][gateLinkID] = (gate_link == -1) ? (-1) : (GateData[gate_link][gateID]);
	        GateData[gate_link][gateLinkID] = (gate_link == -1) ? (-1) : (GateData[gate_id][gateID]);

	        Gate_Save(gate_id, SAVE_GATE_LINKID);
	        Gate_Save(gate_link, SAVE_GATE_LINKID);
			SendServerMessage(playerid, "Gate id "YELLOW"%d "WHITE"telah link dengan gate id: "YELLOW"%d.", gate_id, gate_link);
		}
		case 9: // Remove LinkID
		{
			if(sscanf(nextParams, "d", gate_id))
				return SendSyntaxMessage(playerid, "/gatemenu removelinkid <gate id>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

	        GateData[gate_id][gateLinkID] = -1;
	        Gate_Save(gate_id, SAVE_GATE_LINKID);

	        foreach(new i : Gates) if(GateData[i][gateLinkID] == GateData[gate_id][gateID]) {
        		GateData[i][gateLinkID] = -1;
		        Gate_Save(i, SAVE_GATE_LINKID);
        		break;
	        }
			SendServerMessage(playerid, "Gate id "YELLOW"%d "WHITE"telah dihilangkan dengan link gate lainnya.", gate_id);
		}
		case 10: // Gate Virtual World
		{
			new world;
			if(sscanf(nextParams, "dd", gate_id, world))
				return SendSyntaxMessage(playerid, "/gatemenu world <gate id> <world>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

	        GateData[gate_id][gateWorld] = world;
	        Gate_Save(gate_id, SAVE_GATE_POS);
			SendServerMessage(playerid, "Gate id "YELLOW"%d "WHITE"telah di ubah virtual worldnya ke %d.", gate_id, world);
		}
		case 11: // Remove LinkID
		{
			new int;
			if(sscanf(nextParams, "dd", gate_id, int))
				return SendSyntaxMessage(playerid, "/gatemenu interior <gate id> <interior>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

	        GateData[gate_id][gateInt] = int;
	        Gate_Save(gate_id, SAVE_GATE_POS);
			SendServerMessage(playerid, "Gate id "YELLOW"%d "WHITE"telah di ubah interiornya ke %d.", gate_id, int);
		}
		case 12: // Toll Gate Price
		{
			new price;
			if(sscanf(nextParams, "dd", gate_id, price))
				return SendSyntaxMessage(playerid, "/gatemenu tollprice <gate id> <price> | Set '0' to remove the price.");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			if (price < 0 || price > MAX_GATE_TOLL_PRICE)
				return SendErrorMessage(playerid, "Harga gerbang tol salah! Harus di antara 0 dan %d!", MAX_GATE_TOLL_PRICE);

			GateData[gate_id][gateTollPrice] = price;
			Gate_Save(gate_id, SAVE_GATE_ALL);
			SendServerMessage(playerid, "Gate id "YELLOW"%d "WHITE"telah di ubah toll price menjadi %d.", gate_id, price);
		}
		case 13: // Enable Gate
		{
			if(sscanf(nextParams, "d", gate_id))
				return SendSyntaxMessage(playerid, "/gatemenu enable <gate id>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			if (Gate_RemoveFlag(gate_id, GATE_FLAG_DISABLED))
			{
				Gate_Save(gate_id, SAVE_GATE_ALL);
				SendServerMessage(playerid, "Gate id "YELLOW"%d "WHITE"telah diaktifkan.", gate_id);
			}
			else
			{
				SendErrorMessage(playerid, "Gagal mengaktifkan gate!.");
			}
		}
		case 14: // Disable Gate
		{
			if(sscanf(nextParams, "d", gate_id))
				return SendSyntaxMessage(playerid, "/gatemenu disable <gate id>");

			if(!Gate_Exists(gate_id))
				return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

			if (Gate_SetFlag(gate_id, GATE_FLAG_DISABLED))
			{
				Gate_Save(gate_id, SAVE_GATE_ALL);
				SendServerMessage(playerid, "Gate id "YELLOW"%d "WHITE"telah dimatikan.", gate_id);
			}
			else
			{
				SendErrorMessage(playerid, "Gagal mematikan gate!.");
			}
		}
		case 15:
		{
			return cmd_nearestgate(playerid, params);
		}
		default: SendSyntaxMessage(playerid, "/gatemenu [create/delete/pos/move/password/radius/faction/linkid/removelinkid/world/interior/tollprice/enable/disable/nearest]");
	}
	return 1;
}

CMD:gm(playerid, params[])
{
	return cmd_gatemenu(playerid, params);
}

CMD:gotogate(playerid, params[])
{
	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	new gate_id;

	if(sscanf(params, "d", gate_id))
		return SendSyntaxMessage(playerid, "/gotogate [gate id]");

	if(!Gate_Exists(gate_id))
		return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

	SetPlayerInterior(playerid, GateData[gate_id][gateInt]);
	SetPlayerVirtualWorld(playerid, GateData[gate_id][gateWorld]);
	SetPlayerPos(playerid, GateData[gate_id][gatePosition][0], GateData[gate_id][gatePosition][1], GateData[gate_id][gatePosition][2]);
	SetPlayerFacingAngle(playerid, GateData[gate_id][gateRotation][2]);

	SendServerMessage(playerid, "Kamu telah teleportasi ke gate id: "YELLOW"%d", gate_id);
	return 1;
}

CMD:nearestgate(playerid, params[])
{
	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	new gate_id = Gate_Nearest(playerid);
	SendServerMessage(playerid, "Nearest gate id: "YELLOW"%s", (gate_id == -1) ? ("none") : sprintf("%d", gate_id));
	return 1;
}

CMD:infogate(playerid, params[])
{
	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

    new gate_id;

	if(sscanf(params, "d", gate_id))
		return SendSyntaxMessage(playerid, "/infogate [gate id]");

	if(!Gate_Exists(gate_id))
		return SendErrorMessage(playerid, "Indeks gate tidak terdaftar!.");

    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Gate Info", WHITE"ID: %d\nPassword: %s\nRadius: %d\nFaction: %d\nLinkID: %d\nVirtual World :%d\nInterior : %d","Close","", GateData[gate_id][gateID], GateData[gate_id][gatePassword], GateData[gate_id][gateRadius], GateData[gate_id][gateFaction], GateData[gate_id][gateLinkID], GateData[gate_id][gateWorld], GateData[gate_id][gateInt]);
	return 1;
}

CMD:gatehelp(playerid, params[])
{
	if (CheckAdmin(playerid, 1))
        return PermissionError(playerid);

	SendServerMessage(playerid, "/gatemenu, /gotogate, /nearestgate, /infogate.");
	return 1;
}