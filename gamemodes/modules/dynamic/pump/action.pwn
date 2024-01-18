#include <YSI\y_hooks>


forward OnPumpCreated(pumpid);
public OnPumpCreated(pumpid)
{
    PumpData[pumpid][pumpID] = cache_insert_id();

    Pump_Sync(pumpid);
    Pump_Save(pumpid, true);
    return 1;
}

forward Pump_Load(bizid);
public Pump_Load(bizid)
{
    static id;

    if(cache_num_rows())
    {
        for (new i = 0; i != cache_num_rows(); i ++)
        {
        	if((id = Iter_Free(GasPump)) != cellmin)
        	{
        		Iter_Add(GasPump, id);

    	        PumpData[id][pumpBusiness] = bizid;
    	        PumpData[id][pumpID] = cache_get_field_int(i, "pumpID");
    	        PumpData[id][pumpFuel] = cache_get_field_int(i, "pumpFuel");
    	        
    	        PumpData[id][pumpPos][0] = cache_get_field_float(i, "pumpPosX");
    	        PumpData[id][pumpPos][1] = cache_get_field_float(i, "pumpPosY");
    	        PumpData[id][pumpPos][2] = cache_get_field_float(i, "pumpPosZ");
    	        PumpData[id][pumpPos][3] = cache_get_field_float(i, "pumpPosA");

    	        Pump_Sync(id);
        	}
        	else break;
        }
        printf("*** Loaded %d gas pump.", cache_num_rows());
    }
    return 1;
}


hook OnPlayerLogin(playerid)
{
	SetPVarInt(playerid, "EditingPump", -1);
}

hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(GetPVarInt(playerid, "EditingPump") != -1)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			new id = GetPVarInt(playerid, "EditingPump");

			if(Pump_Exists(id))
			{
				PumpData[id][pumpPos][0] = x;
				PumpData[id][pumpPos][1] = y;
				PumpData[id][pumpPos][2] = z;
				PumpData[id][pumpPos][3] = rz;

				Pump_Sync(id);
				Pump_Save(id, true);

				SetPVarInt(playerid, "EditingPump", -1);

				SendServerMessage(playerid, "Sukses mengubah posisi pompa id "YELLOW"%d.", id);
			}
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			static id;

			id = GetPVarInt(playerid, "EditingPump");

			if(Pump_Exists(id))
			{
				Pump_Sync(id);
				SetPVarInt(playerid, "EditingPump", -1);

				SendServerMessage(playerid, "Gagal mengubah posisi pompa id "YELLOW"%d.", id);
			}
		}
	}
}


Pump_Create(playerid, bizid)
{
    static Float:x, Float:y, Float:z, Float:angle, id = -1;

    if((id = Iter_Free(GasPump)) != cellmin)
    {
    	Iter_Add(GasPump, id);

    	GetPlayerPos(playerid, x, y, z);
    	GetPlayerFacingAngle(playerid, angle);

        x += 5.0 * floatsin(-angle, degrees);
        y += 5.0 * floatcos(-angle, degrees);

        PumpData[id][pumpPos][0] = x;
        PumpData[id][pumpPos][1] = y;
        PumpData[id][pumpPos][2] = z;
        PumpData[id][pumpPos][3] = angle;

        PumpData[id][pumpFuel] = 0;
        PumpData[id][pumpBusiness] = bizid;

        mysql_tquery(g_iHandle, sprintf("INSERT INTO `pumps` (`ID`) VALUES(%d)", BusinessData[bizid][bizID]), "OnPumpCreated", "d", id);
        return id;
    }
    return -1;
}

Pump_Delete(pumpid)
{
    if(Iter_Contains(GasPump, pumpid))
    {
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `pumps` WHERE `pumpID` = '%d'", PumpData[pumpid][pumpID]));

        if(IsValidDynamic3DTextLabel(PumpData[pumpid][pumpText3D]))
            DestroyDynamic3DTextLabel(PumpData[pumpid][pumpText3D]);

        if(IsValidDynamicObject(PumpData[pumpid][pumpObject]))
            DestroyDynamicObject(PumpData[pumpid][pumpObject]);

        new tmp_PumpData[E_PUMP_DATA];
        PumpData[pumpid] = tmp_PumpData;

        PumpData[pumpid][pumpText3D] = Text3D:INVALID_STREAMER_ID;
        PumpData[pumpid][pumpObject] = INVALID_STREAMER_ID;

        Iter_Remove(GasPump, pumpid);
    }
    return 1;
}

Pump_Exists(pumpid)
{
	if(Iter_Contains(GasPump, pumpid))
		return 1;

	return 0;
}

Pump_DeleteBusiness(bizid)
{
	foreach(new pumpid : GasPump) if(PumpData[pumpid][pumpBusiness] == bizid)
    {
        mysql_tquery(g_iHandle, sprintf("DELETE FROM `pumps` WHERE `pumpID` = '%d'", PumpData[pumpid][pumpID]));

        if(IsValidDynamic3DTextLabel(PumpData[pumpid][pumpText3D]))
            DestroyDynamic3DTextLabel(PumpData[pumpid][pumpText3D]);

        if(IsValidDynamicObject(PumpData[pumpid][pumpObject]))
            DestroyDynamicObject(PumpData[pumpid][pumpObject]);

        new tmp_PumpData[E_PUMP_DATA];
        PumpData[pumpid] = tmp_PumpData;

        PumpData[pumpid][pumpText3D] = Text3D:INVALID_STREAMER_ID;
        PumpData[pumpid][pumpObject] = INVALID_STREAMER_ID;

        new next;
        Iter_SafeRemove(GasPump, pumpid, next);
        pumpid = next;
    }
    return 1;
}

Pump_Sync(pumpid)
{
    if(Iter_Contains(GasPump, pumpid))
    {
        if(IsValidDynamic3DTextLabel(PumpData[pumpid][pumpText3D]))
        {
        	UpdateDynamic3DTextLabelText(PumpData[pumpid][pumpText3D], COLOR_CLIENT, sprintf("[Gas Pump, %d]\n"WHITE"Kapasitas bahan bakar: "YELLOW"%d liter\n"WHITE"Gunakan (/refuel) untuk mengisi", pumpid, PumpData[pumpid][pumpFuel]));

        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PumpData[pumpid][pumpText3D], E_STREAMER_X, PumpData[pumpid][pumpPos][0]);
        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PumpData[pumpid][pumpText3D], E_STREAMER_Y, PumpData[pumpid][pumpPos][1]);
        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PumpData[pumpid][pumpText3D], E_STREAMER_Z, PumpData[pumpid][pumpPos][2]);
        }
        else PumpData[pumpid][pumpText3D] = CreateDynamic3DTextLabel(sprintf("[Gas Pump, %d]\n"WHITE"Kapasitas bahan bakar: "YELLOW"%d liter\n"WHITE"Gunakan (/refuel) untuk mengisi", pumpid, PumpData[pumpid][pumpFuel]), COLOR_CLIENT, PumpData[pumpid][pumpPos][0], PumpData[pumpid][pumpPos][1], PumpData[pumpid][pumpPos][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);

        if(IsValidDynamicObject(PumpData[pumpid][pumpObject]))
        {
        	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, PumpData[pumpid][pumpObject], E_STREAMER_X, PumpData[pumpid][pumpPos][0]);
        	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, PumpData[pumpid][pumpObject], E_STREAMER_Y, PumpData[pumpid][pumpPos][1]);
        	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, PumpData[pumpid][pumpObject], E_STREAMER_Z, PumpData[pumpid][pumpPos][2]);
        	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, PumpData[pumpid][pumpObject], E_STREAMER_R_Z, PumpData[pumpid][pumpPos][3]);
        }
        else PumpData[pumpid][pumpObject] = CreateDynamicObject(1676, PumpData[pumpid][pumpPos][0], PumpData[pumpid][pumpPos][1], PumpData[pumpid][pumpPos][2], 0.0, 0.0, PumpData[pumpid][pumpPos][3], 0, 0);
    }
    return 1;
}

Pump_Save(pumpid, save_all)
{
    if(Iter_Contains(GasPump, pumpid))
	{
		if(save_all)
		{
		    new query[256];

		    format(query, sizeof(query), "UPDATE `pumps` SET `pumpPosX` = '%.4f', `pumpPosY` = '%.4f', `pumpPosZ` = '%.4f', `pumpPosA` = '%.4f', `pumpFuel` = '%d' WHERE `pumpID` = '%d';",
		        PumpData[pumpid][pumpPos][0],
		        PumpData[pumpid][pumpPos][1],
		        PumpData[pumpid][pumpPos][2],
		        PumpData[pumpid][pumpPos][3],
		        PumpData[pumpid][pumpFuel],
		        PumpData[pumpid][pumpID]
		    );
		    mysql_tquery(g_iHandle, query);
		}
		else mysql_tquery(g_iHandle, sprintf("UPDATE `pumps` SET pumpFuel=%d WHERE pumpID=%d;", PumpData[pumpid][pumpFuel], PumpData[pumpid][pumpID]));
	}
    return 1;
}

Pump_Nearest(playerid, Float:range = 10.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : GasPump) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, PumpData[i][pumpPos][0], PumpData[i][pumpPos][1], PumpData[i][pumpPos][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}