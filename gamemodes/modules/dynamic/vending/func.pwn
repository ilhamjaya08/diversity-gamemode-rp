#include <YSI_Coding\y_hooks>


// Callback
forward OnVendingCreated(index);
public OnVendingCreated(index)
{
	VendingData[index][vendID] = cache_insert_id();

	Vending_Sync(index);
	Vending_Save(index);
	return 1;
}

forward Vending_Load();
public Vending_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Vending, i);

			VendingData[i][vendID] = cache_get_field_int(i, "vendID");
			VendingData[i][vendInterior] = cache_get_field_int(i, "vendInterior");
			VendingData[i][vendWorld] = cache_get_field_int(i, "vendWorld");
			VendingData[i][vendOwner] = cache_get_field_int(i, "vendOwner");

			cache_get_field_content(i, "vendName", VendingData[i][vendName], 128);
			cache_get_field_content(i, "vendOwnerName", VendingData[i][vendOwnerName], 128);

            VendingData[i][vendPosX] = cache_get_field_float(i, "vendX");
            VendingData[i][vendPosY] = cache_get_field_float(i, "vendY");
            VendingData[i][vendPosZ] = cache_get_field_float(i, "vendZ");
            VendingData[i][vendPosA] = cache_get_field_float(i, "vendA");


			VendingData[i][vendPrice] = cache_get_field_int(i, "vendPrice");
			VendingData[i][vendType] = cache_get_field_int(i, "vendType");


			VendingData[i][vendStockPrice] = cache_get_field_int(i, "vendStockPrice");
			VendingData[i][vendStock] = cache_get_field_int(i, "vendStock");
			VendingData[i][vendVault] = cache_get_field_int(i, "vendVault");

			Vending_Sync(i);
		}
		printf("*** Loaded %d Vending's", cache_num_rows());
	}
	return 1;
}

// Function
Vending_IsExists(index)
{
	if(Iter_Contains(Vending, index))
		return 1;
	
	return 0;
}

Vending_Create(playerid, type)
{
	static
		index;

	if((index = Iter_Free(Vending)) != cellmin)
	{
		Iter_Add(Vending, index);

		GetPlayerPos(playerid, VendingData[index][vendPosX], VendingData[index][vendPosY], VendingData[index][vendPosZ]);
		GetPlayerFacingAngle(playerid, VendingData[index][vendPosA]);

		VendingData[index][vendInterior] = GetPlayerInterior(playerid);
		VendingData[index][vendWorld] = GetPlayerVirtualWorld(playerid);

		VendingData[index][vendPrice] = 999999;
		VendingData[index][vendStockPrice] = 5;
		VendingData[index][vendVault] = 0;
		VendingData[index][vendType] = type;

		format(VendingData[index][vendName], 128, "None");
		format(VendingData[index][vendOwnerName], 128, "None");
		VendingData[index][vendOwner] = INVALID_OWNER_ID;

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `vending`(`vendInterior`) VALUES('%d');", VendingData[index][vendInterior]), "OnVendingCreated", "d", index);
		return index;
	}
	return -1;
}
Vending_IsOwned(playerid, index)
{
	if(Vending_IsExists(index))
	{
		if(VendingData[index][vendOwner] == GetPlayerSQLID(playerid))
			return 1;
	}
	return 0;
}
Vending_Delete(index)
{
	if(Vending_IsExists(index))
	{
		Iter_Remove(Vending, index);

		mysql_tquery(g_iHandle, sprintf("DELETE FROM `vending` WHERE `vendID`='%d';", VendingData[index][vendID]));

		if(IsValidDynamicArea(VendingData[index][vendArea]))
			DestroyDynamicArea(VendingData[index][vendArea]);

		if(IsValidDynamicObject(VendingData[index][vendObject]))
			DestroyDynamicObject(VendingData[index][vendObject]);

		new tmp_VendingData[E_VENDING_DATA];
		VendingData[index] = tmp_VendingData;

		VendingData[index][vendArea] = INVALID_STREAMER_ID;
		VendingData[index][vendObject] = INVALID_STREAMER_ID;
		return 1;
	}
	return 0;
}

Vending_Sync(index)
{
	if(Vending_IsExists(index))
	{
		if(IsValidDynamicObject(VendingData[index][vendObject]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VendingData[index][vendObject], E_STREAMER_X, VendingData[index][vendPosX]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VendingData[index][vendObject], E_STREAMER_Y, VendingData[index][vendPosY]);

			if(VendingData[index][vendType] == VENDING_MACHINE_TYPE_COLA) Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VendingData[index][vendObject], E_STREAMER_Z, VendingData[index][vendPosZ] - 1);
			else Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VendingData[index][vendObject], E_STREAMER_Z, VendingData[index][vendPosZ] - 0.6);
			
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VendingData[index][vendObject], E_STREAMER_R_Z, VendingData[index][vendPosA] - 180);
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, VendingData[index][vendObject], E_STREAMER_INTERIOR_ID, VendingData[index][vendInterior]);
			Streamer_SetIntData(STREAMER_TYPE_OBJECT, VendingData[index][vendObject], E_STREAMER_WORLD_ID, VendingData[index][vendWorld]);
		}
		else 
		{
			new modelid = Vending_GetModelByType(VendingData[index][vendType]);
			switch(VendingData[index][vendType])
			{
				case VENDING_MACHINE_TYPE_COLA:
				{
					VendingData[index][vendObject] = CreateDynamicObject(modelid, VendingData[index][vendPosX], VendingData[index][vendPosY], VendingData[index][vendPosZ] - 1, 0.0, 0.0, (VendingData[index][vendPosA] - 180), VendingData[index][vendWorld], VendingData[index][vendInterior], -1, 300, 300);
													 
				}
				default:
				{
					VendingData[index][vendObject] = CreateDynamicObject(modelid, VendingData[index][vendPosX], VendingData[index][vendPosY], VendingData[index][vendPosZ] - 0.6, 0.0, 0.0, (VendingData[index][vendPosA] - 180), VendingData[index][vendWorld], VendingData[index][vendInterior], -1, 300, 300);
				}
			}
		}

		if(IsValidDynamicArea(VendingData[index][vendArea]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_AREA, VendingData[index][vendArea], E_STREAMER_X, VendingData[index][vendPosX]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, VendingData[index][vendArea], E_STREAMER_Y, VendingData[index][vendPosY]);
			Streamer_SetFloatData(STREAMER_TYPE_AREA, VendingData[index][vendArea], E_STREAMER_Z, VendingData[index][vendPosZ] - 0.4);

			Streamer_SetIntData(STREAMER_TYPE_AREA, VendingData[index][vendArea], E_STREAMER_INTERIOR_ID, VendingData[index][vendInterior]);
			Streamer_SetIntData(STREAMER_TYPE_AREA, VendingData[index][vendArea], E_STREAMER_WORLD_ID, VendingData[index][vendWorld]);
		}
		else
		{			
			VendingData[index][vendArea] = CreateDynamicCylinder(VendingData[index][vendPosX], VendingData[index][vendPosY], VendingData[index][vendPosZ] - 1.0, VendingData[index][vendPosZ] + 3.0, 1.0, VendingData[index][vendWorld], VendingData[index][vendInterior]);

			new streamer_info[2];

			streamer_info[0] = VENDING_AREA_INDEX;
			streamer_info[1] = index;
			Streamer_SetArrayData(STREAMER_TYPE_AREA, VendingData[index][vendArea], E_STREAMER_EXTRA_ID, streamer_info);
		}
	}
	return 1;
}
Vending_GetModelByType(type)
{
	new model;
	switch(type)
	{
		case VENDING_MACHINE_TYPE_SPRUNK:
		{
			model = 955;
		}
		case VENDING_MACHINE_TYPE_SNACK:
		{
			model = 956;
		}
		case VENDING_MACHINE_TYPE_COLA:
		{
			model = 1302;
		}
	}
	return model;
}

Vending_Save(index)
{
	if(Vending_IsExists(index))
	{
		new query[2058];
		format(query, sizeof(query), "UPDATE vending SET vendOwner = '%d', vendName='%s', vendOwnerName='%s', vendPrice='%d', vendStockPrice='%d', vendType='%d', vendVault='%d'", 
			VendingData[index][vendOwner],
			SQL_ReturnEscaped(VendingData[index][vendName]),
			SQL_ReturnEscaped(VendingData[index][vendOwnerName]),
			VendingData[index][vendPrice],
			VendingData[index][vendStockPrice],
			VendingData[index][vendType],
			VendingData[index][vendVault]
		);
		format(query, sizeof(query), "%s, vendX='%.3f',vendY='%.3f',vendZ='%.3f',vendA='%.3f',vendInterior='%d',vendWorld='%d',vendStock='%d' WHERE vendID='%d';",
			query, 
			VendingData[index][vendPosX],
			VendingData[index][vendPosY],
			VendingData[index][vendPosZ],
			VendingData[index][vendPosA],
			VendingData[index][vendInterior],
			VendingData[index][vendWorld],
			VendingData[index][vendStock],
			VendingData[index][vendID]
		);
		return mysql_tquery(g_iHandle, query);
	}
	return 0;
}

Vending_Nearest(playerid)
{
	foreach(new i : Vending) if(IsPlayerInRangeOfPoint(playerid, 3.0, VendingData[i][vendPosX], VendingData[i][vendPosY], VendingData[i][vendPosZ]))
	{
		if(GetPlayerInterior(playerid) == VendingData[i][vendInterior] && GetPlayerVirtualWorld(playerid) == VendingData[i][vendWorld])
			return i;
	}
	return -1;
}

GetXYInFrontOfVending(index, &Float:x, &Float:y, Float:distance)
{
	if(Vending_IsExists(index))
	{
		new Float:a, Float:z;
		GetDynamicObjectRot(VendingData[index][vendObject], x, y, a);
		GetDynamicObjectPos(VendingData[index][vendObject], x, y, z);

		a += 180.0;
		if(a > 359.0) a -= 359.0;

		x += (distance * floatsin(-a, degrees));
		y += (distance * floatcos(-a, degrees));
	}
}

Vending_GetCount(playerid)
{
    new
        count = 0;

    foreach(new i : Vending) if(Vending_IsOwned(playerid, i))
    {
        count++;
    }
    return count;
}