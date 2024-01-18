/*
	Furniture object maker.

	Made by: Agus Syahputra
	Idea by: Jogjagamers
*/

Function:FurnObject_Load(index)
{
	new query[32];

	for(new i = 0; i != cache_num_rows(); i++)
	{
		Iter_Add(FurnObject, i);

		cache_get_field_content(i, "name", FurnStore[i][furnName], 32);

		cache_get_field_content(i, "materials", query, 32);
        sscanf(query, "p<|>dddddddddddddddd", 
        	FurnStore[i][furnMaterials][0],
			FurnStore[i][furnMaterials][1],
			FurnStore[i][furnMaterials][2],
			FurnStore[i][furnMaterials][3],
			FurnStore[i][furnMaterials][4],
			FurnStore[i][furnMaterials][5],
			FurnStore[i][furnMaterials][6],
			FurnStore[i][furnMaterials][7],
			FurnStore[i][furnMaterials][8],
			FurnStore[i][furnMaterials][9],
			FurnStore[i][furnMaterials][10],
			FurnStore[i][furnMaterials][11],
			FurnStore[i][furnMaterials][12],
			FurnStore[i][furnMaterials][13],
			FurnStore[i][furnMaterials][14],
			FurnStore[i][furnMaterials][15]
		);

        FurnStore[i][furnID] = cache_get_field_int(i, "id");
		FurnStore[i][furnModel] = cache_get_field_int(i, "model");

		FurnStore[i][furnPos][0] = cache_get_field_float(i, "x");
		FurnStore[i][furnPos][1] = cache_get_field_float(i, "y");
		FurnStore[i][furnPos][2] = cache_get_field_float(i, "z");
		FurnStore[i][furnRot][0] = cache_get_field_float(i, "rx");
		FurnStore[i][furnRot][1] = cache_get_field_float(i, "ry");
		FurnStore[i][furnRot][2] = cache_get_field_float(i, "rz");
		
		FurnStore[i][furnPrice] = cache_get_field_int(i, "price");
		FurnStore[i][furnStock] = cache_get_field_int(i, "stock");
		FurnStore[i][furnStoreId] = cache_get_field_int(i, "storeid");

		FurnObject_Refresh(i);
	}
	printf("Loaded furnobject data - %d count.", cache_num_rows());
	return 1;
}

FurnObject_Save(index)
{
	if(Iter_Contains(FurnObject, index))
	{
		new query[500];

		format(query, sizeof(query), "UPDATE `furnobject` SET model=%d,name='%s',x=%.3f,y=%.3f,z=%.3f,rx=%.3f,ry=%.3f,rz=%.3f", 
			FurnStore[index][furnModel],
			FurnStore[index][furnName],
			FurnStore[index][furnPos][0],
			FurnStore[index][furnPos][1],
			FurnStore[index][furnPos][2],
			FurnStore[index][furnRot][0],
			FurnStore[index][furnRot][1],
			FurnStore[index][furnRot][2]
		);
		format(query, sizeof(query), "%s, price=%d,stock=%d,storeid=%d,materials='%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d' WHERE id=%d", 
			query,
			FurnStore[index][furnPrice],
			FurnStore[index][furnStock],
			FurnStore[index][furnStoreId],
			FurnStore[index][furnMaterials][0],
			FurnStore[index][furnMaterials][1],
			FurnStore[index][furnMaterials][2],
			FurnStore[index][furnMaterials][3],
			FurnStore[index][furnMaterials][4],
			FurnStore[index][furnMaterials][5],
			FurnStore[index][furnMaterials][6],
			FurnStore[index][furnMaterials][7],
			FurnStore[index][furnMaterials][8],
			FurnStore[index][furnMaterials][9],
			FurnStore[index][furnMaterials][10],
			FurnStore[index][furnMaterials][11],
			FurnStore[index][furnMaterials][12],
			FurnStore[index][furnMaterials][13],
			FurnStore[index][furnMaterials][14],
			FurnStore[index][furnMaterials][15],
			FurnStore[index][furnID]
		);
		mysql_tquery(g_iHandle, query);
	}
	return 1;
}

FurnObject_Sync(index)
{
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnStore[index][furnObject], E_STREAMER_X, FurnStore[index][furnPos][0]);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnStore[index][furnObject], E_STREAMER_Y, FurnStore[index][furnPos][1]);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnStore[index][furnObject], E_STREAMER_Z, FurnStore[index][furnPos][2]);

    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnStore[index][furnObject], E_STREAMER_R_X, FurnStore[index][furnRot][0]);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnStore[index][furnObject], E_STREAMER_R_Y, FurnStore[index][furnRot][1]);
    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, FurnStore[index][furnObject], E_STREAMER_R_Z, FurnStore[index][furnRot][2]);

    Streamer_SetIntData(STREAMER_TYPE_OBJECT, FurnStore[index][furnObject], E_STREAMER_MODEL_ID, FurnStore[index][furnModel]);

    for(new i = 0; i != MAX_MATERIALS; i++) if(FurnStore[index][furnMaterials][i] > 0)
	{
			SetDynamicObjectMaterial(FurnStore[index][furnObject], i, 
			GetTModel(FurnStore[index][furnMaterials][i]), 
			GetTXDName(FurnStore[index][furnMaterials][i]), 
			GetTextureName(FurnStore[index][furnMaterials][i]), 0
		);

	}
	return 1;
}

FurnObject_Refresh(index)
{
	if(Iter_Contains(FurnObject, index)) 
	{
		if(!IsValidDynamicObject(FurnStore[index][furnObject]))
		{
			FurnStore[index][furnObject] = CreateDynamicObject(FurnStore[index][furnModel], 
				FurnStore[index][furnPos][0], FurnStore[index][furnPos][1], FurnStore[index][furnPos][2], 
				FurnStore[index][furnRot][0], FurnStore[index][furnRot][1], FurnStore[index][furnRot][2], 
				(FurnStore[index][furnStoreId]+1), 3
			);
		}
		FurnObject_Sync(index);	    
			
		if(IsValidDynamic3DTextLabel(FurnStore[index][furnLabel]))
			DestroyDynamic3DTextLabel(FurnStore[index][furnLabel]);
		
		new string[100];
		format(string, sizeof(string), "[id: %d]\n%s \nPrice: %s \nStock: %d", index, FurnStore[index][furnName], FormatNumber(FurnStore[index][furnPrice]), FurnStore[index][furnStock]);
		FurnStore[index][furnLabel] = CreateDynamic3DTextLabel(string, COLOR_BLUE, FurnStore[index][furnPos][0], FurnStore[index][furnPos][1], FurnStore[index][furnPos][2], 5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, FurnStore[index][furnStoreId]+1, 3);

		foreach(new i : Player) if(SQL_IsLogged(i) && IsPlayerInRangeOfPoint(i, 5, FurnStore[index][furnPos][0], FurnStore[index][furnPos][1], FurnStore[index][furnPos][2])) {
			Streamer_Update(i);
		}
	}
	return 1;
}

FurnObject_List(playerid, index)
{
	if(Iter_Contains(FurnStore, index))
	{
		new count = 0,
	    	info[255];

	    strcat(info, "Furniture\tSlot (ID)\tDistance (meters)\n");
	    foreach(new i : FurnObject) if(FurnStore[i][furnStoreId] == storeData[index][storeID])
	    {
	    	strcat(info, sprintf("%s\t%d\t%.1f\n", FurnStore[i][furnName], i, GetPlayerDistanceFromPoint(playerid, FurnStore[i][furnPos][0], FurnStore[i][furnPos][1], FurnStore[i][furnPos][2])));
	    	ListedFurnObject[playerid][count++] = i;
	    }
	    if(count != MAX_FURNSTORE_OBJECT)
	    	strcat(info, "Add New\t\n");

	    Dialog_Show(playerid, ManageFurn, DIALOG_STYLE_TABLIST_HEADERS, "Exhibits", info, "Select", "Back");
	}
	return 1;
}

FurnObject_Category(playerid)
{
	new string[120];
	for (new i = 0; i < sizeof(g_aFurnitureTypes); i ++) {
        strcat(string, sprintf("%s\n", g_aFurnitureTypes[i]));
    }
    Dialog_Show(playerid, SelectType, DIALOG_STYLE_LIST, "Object Category", string, "Modify", "Cancel");
	return 1;
}

FurnObject_Count(index)
{
	new count = 0;

	foreach(new i : FurnObject) if(FurnStore[i][furnStoreId] == storeData[index][storeID]) {
		count++;
	}
	return count;
}

FurnObject_Add(playerid, objectid, index)
{
	if(FurnObject_Count(index) >= MAX_FURNSTORE_OBJECT) return -1;

	new id = Iter_Free(FurnObject),
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, 1.5);

	format(FurnStore[id][furnName], 32, "Unnamed");

	FurnStore[id][furnPos][0] = x;
	FurnStore[id][furnPos][1] = y;
	FurnStore[id][furnPos][2] = z;
	FurnStore[id][furnRot][0] = 0;
	FurnStore[id][furnRot][1] = 0;
	FurnStore[id][furnRot][2] = 0;

	FurnStore[id][furnModel] = objectid;
	FurnStore[id][furnStoreId] = storeData[index][storeID];
	FurnStore[id][furnPrice] = 0;
	FurnStore[id][furnStock] = 0;

	Iter_Add(FurnObject, id);

	mysql_tquery(g_iHandle, "INSERT INTO `furnobject`(`price`) VALUES (0)", "FurnObject_Created", "d", id);
	
	FurnObject_Refresh(id);
	Streamer_Update(playerid);
	return id;
}

Function:FurnObject_Created(index)
{
	FurnStore[index][furnID] = cache_insert_id();
	
	FurnObject_Save(index);
	return 1;
}
