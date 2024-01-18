SSCANF:MarketplaceMenu(string[]) 
{
 	if(!strcmp(string,"create",true)) return 1;
 	else if(!strcmp(string,"delete",true)) return 2;
 	else if(!strcmp(string,"type",true)) return 3;
 	else if(!strcmp(string,"price",true)) return 4;
 	else if(!strcmp(string,"stock",true)) return 5;
 	else if(!strcmp(string,"position",true)) return 6;
 	return 0;
}

CMD:marketplace(playerid, params[])
{
	static action, nextParams[128];

	if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

	if(sscanf(params, "k<MarketplaceMenu>S()[128]", action, nextParams))
		return SendSyntaxMessage(playerid, "/marketplace [create/delete/position/type/price/stock]");

	switch(action)
	{
		case 1: // Create
		{
			new id, type, product, price;

			if(sscanf(nextParams, "ddd", type, product, price)) {
				SendSyntaxMessage(playerid, "/marketplace create [type] [product] [price]");
				return SendCustomMessage(playerid, "TYPE", "1. Retail | 2. Ammu | 3. Cloth | 4. Meal | 5. Dealer | 6. Fuel | 7. Furniture | 8. Electronic | 9. Bar.");
			}

			if(!(CARGO_NONE < type <= CARGO_BAR))
				return SendErrorMessage(playerid, "TYPE: 1. Retail | 2. Ammu | 3. Cloth | 4. Meal | 5. Dealer | 6. Fuel | 7. Furniture | 8. Electronic | 9. Bar.");

			if(!(5 <= product <= 15))
				return SendErrorMessage(playerid, "Produk dibatasi mulai dari 5 sampai 15.");

			if(!(50 <= price <= 150))
				return SendErrorMessage(playerid, "Harga dibatasi mulai dari $50 sampai $150.");

			if((id = Marketplace_Create(playerid, type, product, price)) != -1) SendServerMessage(playerid, "Sukses membuat marketplace id: "YELLOW"%d", id);
			else SendErrorMessage(playerid, "Marketplace sudah mencapai batas maksimal");
		}
		case 2: // Delete
		{
			new id;

			if(sscanf(nextParams, "d", id))
				return SendSyntaxMessage(playerid, "/marketplace delete [marketplace id]");

			if(!Marketplace_IsExists(id))
				return SendErrorMessage(playerid, "Marketplace tidak terdaftar");

			Marketplace_Delete(id);
			SendServerMessage(playerid, "Sukses menghapus marketplace id: "YELLOW"%d", id);
		}
		case 3: // Type
		{
			new id, type;

			if(sscanf(nextParams, "dd", id, type)) {
				SendSyntaxMessage(playerid, "/marketplace type [marketplace id] [type id]");
				return SendCustomMessage(playerid, "TYPE", "1. Retail | 2. Ammu | 3. Cloth | 4. Meal | 5. Dealership | 5. Fuel | 7. Furniture | 8. Electronic | 9. Bar.");
			}

			if(!Marketplace_IsExists(id))
				return SendErrorMessage(playerid, "Marketplace tidak terdaftar");

			if(!(CARGO_NONE < type <= CARGO_BAR))
				return SendErrorMessage(playerid, "TYPE: 1. Retail | 2. Ammu | 3. Cloth | 4. Meal | 5. Dealership | 6. Fuel | 7. Furniture | 8. Electronic | 9. Bar.");

			MarketplaceData[id][marketType] = type;

			Marketplace_Sync(id);
			Marketplace_Save(id);
			SendServerMessage(playerid, "Sukses mengubah tipe marketplace id: "YELLOW"%d "WHITE"menjadi "GREEN"%s", id, Marketplace_TypeName(type));
		}
		case 4: // Price
		{
			new id, price;

			if(sscanf(nextParams, "dd", id, price))
				return SendSyntaxMessage(playerid, "/marketplace price [marketplace id] [price]");

			if(!Marketplace_IsExists(id))
				return SendErrorMessage(playerid, "Marketplace tidak terdaftar");

			if(!(25 <= price <= 150))
				return SendErrorMessage(playerid, "Harga dibatasi mulai dari $25 sampai $150.");

			MarketplaceData[id][marketPrice] = price;

			Marketplace_Sync(id);
			Marketplace_Save(id);
			SendServerMessage(playerid, "Sukses mengubah harga marketplace id: "YELLOW"%d "WHITE"menjadi "GREEN"%s", id, FormatNumber(price));
		}
		case 5: // Stock
		{
			new id, product;

			if(sscanf(nextParams, "dd", id, product))
				return SendSyntaxMessage(playerid, "/marketplace stock [marketplace id] [stock]");

			if(!Marketplace_IsExists(id))
				return SendErrorMessage(playerid, "Marketplace tidak terdaftar");

			if(!(5 <= product <= 15))
				return SendErrorMessage(playerid, "Produk dibatasi mulai dari 5 sampai 15.");

			MarketplaceData[id][marketProduct] = product;

			Marketplace_Sync(id);
			Marketplace_Save(id);
			SendServerMessage(playerid, "Sukses mengubah produk marketplace id: "YELLOW"%d "WHITE"menjadi "GREEN"%d", id, product);
		}
		case 6: // Position
		{
			new id;

			if(sscanf(nextParams, "d", id))
				return SendSyntaxMessage(playerid, "/marketplace position [marketplace id]");

			if(!Marketplace_IsExists(id))
				return SendErrorMessage(playerid, "Marketplace tidak terdaftar");

			GetPlayerPos(playerid, MarketplaceData[id][marketPos][0], MarketplaceData[id][marketPos][1], MarketplaceData[id][marketPos][2]);
			Marketplace_Sync(id);
			Marketplace_Save(id, true);
			SendServerMessage(playerid, "Sukses memperbaharui posisi marketplace id: "YELLOW"%d", id);
		}
	}
	return 1;
}