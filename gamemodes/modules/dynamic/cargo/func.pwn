forward CargoCreated(index);
public CargoCreated(index)
{
	CargoData[index][cargoID] = cache_insert_id();

	Cargo_Sync(index);
	Cargo_Save(index);
	return 1;
}

forward Cargo_Load();
public Cargo_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Cargo, i);

	        CargoData[i][cargoID] = cache_get_field_int(i, "id");
	        CargoData[i][cargoType] = cache_get_field_int(i, "type");
	        CargoData[i][cargoExpired] = cache_get_field_int(i, "expired");
	        CargoData[i][cargoProduct] = cache_get_field_int(i, "product");
	        
	        CargoData[i][cargoX] = cache_get_field_float(i, "posX");
	        CargoData[i][cargoY] = cache_get_field_float(i, "posY");
	        CargoData[i][cargoZ] = cache_get_field_float(i, "posZ");
	        CargoData[i][cargoA] = cache_get_field_float(i, "posA");

	        Cargo_Sync(i);
    	}
    	printf("*** Loaded %d cargo.", cache_num_rows());
	}
	return 1;
}


Cargo_Exists(index)
{
	if(Iter_Contains(Cargo, index))
		return 1;

	return 0;
}

Cargo_Place(playerid, type, product)
{
	static index, Float:x, Float:y, Float:z, Float:angle;

	if((index = Iter_Free(Cargo)) != cellmin)
	{
		Iter_Add(Cargo, index);

		GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, angle);

        x += 0.7 * floatsin(-angle, degrees);
        y += 0.7 * floatcos(-angle, degrees);

		CargoData[index][cargoX] = x;
		CargoData[index][cargoY] = y;
		CargoData[index][cargoZ] = z;
		CargoData[index][cargoA] = angle;

		CargoData[index][cargoType] = type;
		CargoData[index][cargoProduct] = product;
		CargoData[index][cargoExpired] = (gettime() + 86400);

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `cargo`(`Type`) VALUES ('%d')", type), "CargoCreated", "d", index);
		return index;
	}
	return -1;
}

Cargo_Delete(index)
{
	if(Cargo_Exists(index))
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `cargo` WHERE `id`='%d';", CargoData[index][cargoID]));

		if (IsValidDynamicObject(CargoData[index][cargoObject]))
			DestroyDynamicObject(CargoData[index][cargoObject]);

		if(IsValidDynamic3DTextLabel(CargoData[index][cargoLabel]))
			DestroyDynamic3DTextLabel(CargoData[index][cargoLabel]);

		new tmp_CargoData[E_CARGO_DATA];
		CargoData[index] = tmp_CargoData;

		CargoData[index][cargoObject] = INVALID_STREAMER_ID;
		CargoData[index][cargoLabel] = Text3D:INVALID_STREAMER_ID;

		Iter_Remove(Cargo, index);
	}
	return 1;
}

Cargo_Sync(index)
{
	if(Cargo_Exists(index))
	{
		if (IsValidDynamicObject(CargoData[index][cargoObject]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, CargoData[index][cargoObject], E_STREAMER_X, CargoData[index][cargoX]);
        	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, CargoData[index][cargoObject], E_STREAMER_Y, CargoData[index][cargoY]);
        	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, CargoData[index][cargoObject], E_STREAMER_Z, (CargoData[index][cargoZ] - 0.6));
		}
		else CargoData[index][cargoObject] = CreateDynamicObject(1271, CargoData[index][cargoX], CargoData[index][cargoY], CargoData[index][cargoZ]-0.6, 0, 0, CargoData[index][cargoA], 0, 0, -1, 40);

		if (IsValidDynamic3DTextLabel(CargoData[index][cargoLabel]))
		{
			UpdateDynamic3DTextLabelText(CargoData[index][cargoLabel], COLOR_CLIENT, sprintf("[CARGO]\n"LIGHTGREEN"%s", Cargo_TypeName(CargoData[index][cargoType])));

        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, CargoData[index][cargoLabel], E_STREAMER_X, CargoData[index][cargoX]);
        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, CargoData[index][cargoLabel], E_STREAMER_Y, CargoData[index][cargoY]);
        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, CargoData[index][cargoLabel], E_STREAMER_Z, CargoData[index][cargoZ]);
		}
		else CargoData[index][cargoLabel] = CreateDynamic3DTextLabel(sprintf("[CARGO]\n"LIGHTGREEN"%s", Cargo_TypeName(CargoData[index][cargoType])), COLOR_CLIENT, CargoData[index][cargoX], CargoData[index][cargoY], CargoData[index][cargoZ], 3);
	}
	return 1;
}

Cargo_Save(index)
{
	if(Cargo_Exists(index))
	{
		new query[256];

		mysql_format(g_iHandle, query, sizeof(query), "UPDATE `cargo` SET `type`='%d',`posX`='%.3f',`posY`='%.3f',`posZ`='%.3f',`posA`='%.3f',`expired`=%d,`product`=%d WHERE id='%d';",
			CargoData[index][cargoType],
			CargoData[index][cargoX],
			CargoData[index][cargoY],
			CargoData[index][cargoZ],
			CargoData[index][cargoA],
			CargoData[index][cargoExpired],
			CargoData[index][cargoProduct],
			CargoData[index][cargoID]
		);
		mysql_tquery(g_iHandle, query);
	}
	return 1;
}

Cargo_TypeName(type)
{
	new name[16];
	switch(type)
	{
		case CARGO_FUEL: name="fuel";
		case CARGO_MART: name="retail";
		case CARGO_GUN: name="ammunation";
		case CARGO_CLOTHES: name="clothes";
		case CARGO_MEAL: name="food";
		case CARGO_DEALER: name="dealership";
		case CARGO_FURNITURE: name="furniture";
		case CARGO_ELECTRONICS: name="electronics";
		case CARGO_BAR: name="bar";
	}
	return name;
}

Cargo_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Cargo) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, CargoData[i][cargoX], CargoData[i][cargoY], CargoData[i][cargoZ]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}


// Player
Cargo_AnimPlay(playerid)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, JOB_SLOT))
		RemovePlayerAttachedObject(playerid, JOB_SLOT);

	SetPlayerAttachedObject(playerid, JOB_SLOT, 1271, 1,0.237980,0.473312,-0.066999, 1.099999,88.000007,-177.400085, 0.716000,0.572999,0.734000);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
	return 1;
}

Cargo_AnimStop(playerid)
{
	ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 0, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, JOB_SLOT);
	return 1;
}


// Dialog
Dialog:CargoList(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(Vehicle_Nearest(playerid, 4) != GetPVarInt(playerid, "NearestVehicle"))
			return SendErrorMessage(playerid, "Kendaraan terlalu jauh darimu!"), DeletePVar(playerid, "NearestVehicle");

		if(GetPlayerCargoType(playerid) != CARGO_NONE)
			return SendErrorMessage(playerid, "Kamu sedang mengangkut kargo!.");

		new 
			Cache:execute,
			id = cargo_listed[playerid][listitem];

		execute = mysql_query(g_iHandle, sprintf("SELECT * FROM `vehicle_cargo` WHERE `id`='%d';", id));

		if(cache_num_rows())
		{
	        Cargo_AnimPlay(playerid);
			SetPlayerCargoProduct(playerid, cache_get_field_int(0, "product"));
			SetPlayerCargoType(playerid, cache_get_field_int(0, "type"));

			SendServerMessage(playerid, "Kemu mengambil kargo "YELLOW"%s "LIGHTBLUE"(%d product(s)) "WHITE"dari "CYAN"%s.", Cargo_TypeName(GetPlayerCargoType(playerid)), GetPlayerCargoProduct(playerid), GetVehicleNameByVehicle(GetPVarInt(playerid, "NearestVehicle")));
			mysql_tquery(g_iHandle, sprintf("DELETE FROM `vehicle_cargo` WHERE `id`='%d';", id));
			DeletePVar(playerid, "NearestVehicle");
		}
		else SendErrorMessage(playerid, "Cargo sudah tidak ada lagi!");

		cache_delete(execute);
	}
	return 1;
}