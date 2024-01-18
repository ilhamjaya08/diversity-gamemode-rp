forward MarketplaceCreated(index);
public MarketplaceCreated(index)
{
	MarketplaceData[index][marketID] = cache_insert_id();

	Marketplace_Save(index, true);
	Marketplace_Sync(index);
	return 1;
}

forward Marketplace_Load();
public Marketplace_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Marketplace, i);

	        MarketplaceData[i][marketID] = cache_get_field_int(i, "id");
	        MarketplaceData[i][marketType] = cache_get_field_int(i, "type");
	        MarketplaceData[i][marketPrice] = cache_get_field_int(i, "price");
	        MarketplaceData[i][marketProduct] = cache_get_field_int(i, "product");
	        
	        MarketplaceData[i][marketPos][0] = cache_get_field_float(i, "posX");
	        MarketplaceData[i][marketPos][1] = cache_get_field_float(i, "posY");
	        MarketplaceData[i][marketPos][2] = cache_get_field_float(i, "posZ");

	        Marketplace_Sync(i);
    	}
    	printf("*** Loaded %d marketplace.", cache_num_rows());
	}
	return 1;
}


hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, "SELECT * FROM `marketplace` ORDER BY `id` ASC LIMIT "#MAX_DYNAMIC_MARKETPLACE"", "Marketplace_Load", "");
}


Marketplace_IsExists(index)
{
	if(Iter_Contains(Marketplace, index))
		return 1;
	return 0;
}

Marketplace_Create(playerid, type, products, price)
{
	static index;

	if((index = Iter_Free(Marketplace)) != cellmin)
	{
		Iter_Add(Marketplace, index);

		GetPlayerPos(playerid, MarketplaceData[index][marketPos][0], MarketplaceData[index][marketPos][1], MarketplaceData[index][marketPos][2]);
		MarketplaceData[index][marketType] = type;
		MarketplaceData[index][marketProduct] = products;
		MarketplaceData[index][marketPrice] = price;

		mysql_tquery(g_iHandle, sprintf("INSERT INTO `marketplace`(`type`) VALUES ('%d')", type), "MarketplaceCreated", "d", index);
		return index;
	}
	return -1;
}

Marketplace_Delete(index)
{
	if(Marketplace_IsExists(index))
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `marketplace` WHERE `id`='%d';", MarketplaceData[index][marketID]));

		if(IsValidDynamicPickup(MarketplaceData[index][marketPickup]))
			DestroyDynamicPickup(MarketplaceData[index][marketPickup]);

		if(IsValidDynamic3DTextLabel(MarketplaceData[index][marketLabel]))
			DestroyDynamic3DTextLabel(MarketplaceData[index][marketLabel]);

		new tmp_MarketplaceData[E_MARKETPLACE_DATA];
		MarketplaceData[index] = tmp_MarketplaceData;

		MarketplaceData[index][marketPickup] = INVALID_STREAMER_ID;
		MarketplaceData[index][marketLabel] = Text3D:INVALID_STREAMER_ID;

		Iter_Remove(Marketplace, index);
	}
	return 1;
}

Marketplace_Save(index, bool:save_all = false)
{
	if(Marketplace_IsExists(index))
	{
		if(save_all)
		{
			new query[255];
			mysql_format(g_iHandle, query, sizeof(query), "UPDATE `marketplace` SET `posX`='%.3f',`posY`='%.3f',`posZ`='%.3f', `type`='%d', `product`='%d', `price`='%d' WHERE `id`='%d';", 
				MarketplaceData[index][marketPos][0],
				MarketplaceData[index][marketPos][1],
				MarketplaceData[index][marketPos][2],
				MarketplaceData[index][marketType],
				MarketplaceData[index][marketProduct],
				MarketplaceData[index][marketPrice],
				MarketplaceData[index][marketID]
			);
			mysql_tquery(g_iHandle, query);
		}
		else {
			mysql_tquery(g_iHandle, sprintf("UPDATE `marketplace` SET `type`='%d', `product`='%d', `price`='%d' WHERE `id`='%d';", 
				MarketplaceData[index][marketType],
				MarketplaceData[index][marketProduct],
				MarketplaceData[index][marketPrice],
				MarketplaceData[index][marketID]
			));
		}
	}
	return 1;
}

Marketplace_TypeName(type)
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

Marketplace_Sync(index)
{
    if(Marketplace_IsExists(index))
    {
    	new label_text[255];
    	format(label_text, sizeof(label_text), "[Marketplace %s]\n"WHITE"Harga: "GREEN"%s"WHITE"/kargo\nProduk: "YELLOW"%d"WHITE" pcs/kargo\nGunakan perintah "YELLOW"/cargo "WHITE"pada marketplace ini", Marketplace_TypeName(MarketplaceData[index][marketType]), FormatNumber(MarketplaceData[index][marketPrice]), MarketplaceData[index][marketProduct]);

        if(IsValidDynamic3DTextLabel(MarketplaceData[index][marketLabel]))
        {
        	UpdateDynamic3DTextLabelText(MarketplaceData[index][marketLabel], COLOR_CLIENT, label_text);

        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, MarketplaceData[index][marketLabel], E_STREAMER_X, MarketplaceData[index][marketPos][0]);
        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, MarketplaceData[index][marketLabel], E_STREAMER_Y, MarketplaceData[index][marketPos][1]);
        	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, MarketplaceData[index][marketLabel], E_STREAMER_Z, (MarketplaceData[index][marketPos][2] + 0.75));
        }
        else MarketplaceData[index][marketLabel] = CreateDynamic3DTextLabel(label_text, COLOR_CLIENT, MarketplaceData[index][marketPos][0], MarketplaceData[index][marketPos][1], MarketplaceData[index][marketPos][2] + 0.75, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);

        if(IsValidDynamicPickup(MarketplaceData[index][marketPickup]))
        {
        	Streamer_SetFloatData(STREAMER_TYPE_PICKUP, MarketplaceData[index][marketPickup], E_STREAMER_X, MarketplaceData[index][marketPos][0]);
        	Streamer_SetFloatData(STREAMER_TYPE_PICKUP, MarketplaceData[index][marketPickup], E_STREAMER_Y, MarketplaceData[index][marketPos][1]);
        	Streamer_SetFloatData(STREAMER_TYPE_PICKUP, MarketplaceData[index][marketPickup], E_STREAMER_Z, MarketplaceData[index][marketPos][2]);
        }
        else MarketplaceData[index][marketPickup] = CreateDynamicPickup(1271, 23, MarketplaceData[index][marketPos][0], MarketplaceData[index][marketPos][1], MarketplaceData[index][marketPos][2],  0, 0);
    }
    return 1;
}

Marketplace_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Marketplace) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, MarketplaceData[i][marketPos][0], MarketplaceData[i][marketPos][1], MarketplaceData[i][marketPos][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}

Marketplace_Price(business)
{
	new price = 100;

	foreach(new i : Marketplace)
	{
		if(BusinessData[business][bizType] != MarketplaceData[i][marketType])
			continue;

		price = MarketplaceData[i][marketPrice];
		break;
	}
	return price;
}