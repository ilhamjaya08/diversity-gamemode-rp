SSCANF:VendingMenu(string[]) 
{
	if(!strcmp(string,"create",true)) return 1;
	else if(!strcmp(string,"delete",true)) return 2;
	else if(!strcmp(string,"position",true)) return 3;
	else if(!strcmp(string,"price",true)) return 4;
	else if(!strcmp(string,"stock",true)) return 5;
	else if(!strcmp(string,"stock_price",true)) return 6;
	return 0;
}

CMD:vem(playerid, params[])
	return cmd_vendingmenu(playerid, params);

CMD:vendingmenu(playerid, params[])
{
	static index, action, nextParams[128];

	if(GetAdminLevel(playerid) < 8)
        return PermissionError(playerid);

	if(sscanf(params, "k<VendingMenu>S()[128]", action, nextParams))
	{
		SendSyntaxMessage(playerid, "/vendingmenu [entity]");
		SendSyntaxMessage(playerid, "ENTITY: [create/delete/position/price/stock/stock_price]");
		return 1;
	}
		
	switch(action)
	{
		case 1: // Create
		{
			new type;
			if(sscanf(nextParams, "d", type))
			{
				SendSyntaxMessage(playerid, "/vendingmenu create [type]");
				SendSyntaxMessage(playerid, "TYPE : 1.Sprunk | 2.Snack | 3.Cola");
				return 1;
			}

			if(type <= 0 || type > 3)
				return SendSyntaxMessage(playerid, "TYPE : 1.Sprunk | 2.Snack | 3.Cola");		
		
			if((index = Vending_Create(playerid, type)) != -1) SendServerMessage(playerid, "Sukses membuat Vending "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "Jumlah Vending sudah mencapai batas limit ("#MAX_DYNAMIC_VENDING" vending)");
		}
		case 2: // Delete
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/vendingmenu delete [vending id]");

			if(Vending_Delete(index)) SendServerMessage(playerid, "Sukses menghapus vending "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "ID vending yang kamu input tidak terdaftar!");
		}
		case 3: // Position
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/vendingmenu position [vending id]");

			if(!Vending_IsExists(index))
				return SendErrorMessage(playerid, "ID Vending yang kamu input tidak terdaftar!");

			GetPlayerPos(playerid, VendingData[index][vendPosX], VendingData[index][vendPosY], VendingData[index][vendPosZ]);
			GetPlayerFacingAngle(playerid, VendingData[index][vendPosA]);

			VendingData[index][vendInterior] = GetPlayerInterior(playerid);
			VendingData[index][vendWorld] = GetPlayerVirtualWorld(playerid);

			Vending_Sync(index);
			Vending_Save(index);
			SendServerMessage(playerid, "Sukses memindahkan vending "YELLOW"id: %d.", index);
		}
		case 4: // Price
		{
			new amount;
			if(sscanf(nextParams, "dd", index, amount))
				return SendSyntaxMessage(playerid, "/vendingmenu price [index] [amount]");

			if(!Vending_IsExists(index))
				return SendErrorMessage(playerid, "ID Vending yang kamu input tidak terdaftar!");

			VendingData[index][vendPrice] = amount;

			Vending_Sync(index);
			Vending_Save(index);
			SendServerMessage(playerid, "Sukses merubah harga vending "YELLOW"id: %d jumlah %s", index, FormatNumber(amount));
		}
		case 5: // Stock
		{
			new amount;
			if(sscanf(nextParams, "dd", index, amount))
				return SendSyntaxMessage(playerid, "/vendingmenu stock [index] [amount]");

			if(!Vending_IsExists(index))
				return SendErrorMessage(playerid, "ID Vending yang kamu input tidak terdaftar!");

			VendingData[index][vendStock] = amount;

			Vending_Sync(index);
			Vending_Save(index);
			SendServerMessage(playerid, "Sukses merubah stock vending "YELLOW"id: %d jumlah %s", index, FormatNumber(amount));
		}
		case 6: // Stock Price
		{
			new amount;
			if(sscanf(nextParams, "dd", index, amount))
				return SendSyntaxMessage(playerid, "/vendingmenu stock_price [index] [amount]");

			if(!Vending_IsExists(index))
				return SendErrorMessage(playerid, "ID Vending yang kamu input tidak terdaftar!");

			VendingData[index][vendStockPrice] = amount;

			Vending_Sync(index);
			Vending_Save(index);
			SendServerMessage(playerid, "Sukses merubah harga stock vending "YELLOW"id: %d jumlah %s", index, FormatNumber(amount));
		}
		default: 
		{
			SendSyntaxMessage(playerid, "/vendingmenu [entity]");
			SendSyntaxMessage(playerid, "ENTITY: [create/delete/position/price/stock/stock_price]");
		}
	}
	return 1;
}

CMD:nearestvending(playerid, params[])
{
    if (CheckAdmin(playerid, 3))
        return PermissionError(playerid);

    new
        id = -1;

    if((id = Vending_Nearest(playerid)) != -1) SendServerMessage(playerid, "You are standing near vending "YELLOW"ID: %d.", id);
    else SendServerMessage(playerid, "Kamu tidak berada didekat vending manapun apapun!");

    return 1;
}
CMD:vendmenu(playerid, params[])
{
	new 
		index = Vending_GetInside(playerid),
		headers[48],
		string[1024]
	;

	if(index == INVALID_VENDING_ID)
		return SendErrorMessage(playerid, "You are not near any vending to manage!");

	if(!Vending_IsOwned(playerid, index))
		return SendErrorMessage(playerid, "You are not owner of this vending machine!");

    format(headers, sizeof(headers), "Vending Settings");
    strcat(string, "Vending Menu\tCurrent\n");
    strcat(string, sprintf(""WHITE"Vending Name\t"RED"%s\n",VendingData[index][vendName]));
    strcat(string, sprintf(""WHITE"Vending Price\t"GREEN"%s\n",FormatNumber(VendingData[index][vendStockPrice])));
    strcat(string, sprintf(""WHITE"Vending Vault\t"GREEN"%s\n",FormatNumber(VendingData[index][vendVault])));
    strcat(string, sprintf(""WHITE"Vending Stock\t"GREEN"%d",VendingData[index][vendStock]));

	Dialog_Show(playerid, VENDING_MANAGE, DIALOG_STYLE_TABLIST_HEADERS, headers, string, "Select", "Close");
	return 1;
}

Dialog:VENDING_MANAGE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index;
		if((index = Vending_GetInside(playerid)) != INVALID_VENDING_ID && Vending_IsOwned(playerid, index))
		{
			switch(listitem)
			{
				case 0: Dialog_Show(playerid, VENDING_MANAGE_NAME, DIALOG_STYLE_INPUT, "Vending Menu", "Input Vending Name :", "Change", "Cancel");
				case 1: Dialog_Show(playerid, VENDING_MANAGE_PRICE, DIALOG_STYLE_INPUT, "Vending Menu", "Input New Vending Price :", "Change", "Cancel");
				case 2: 
				{
					new string[255];
					format(string, sizeof(string), "Vending Vault : "GREEN"%s\n\n"WHITE"Input Withdraw Amount :", FormatNumber(VendingData[index][vendVault]));
					Dialog_Show(playerid, VENDING_MANAGE_VAULT, DIALOG_STYLE_INPUT, "Vending Menu", string, "Withdraw", "Cancel");
				}
				case 3: Dialog_Show(playerid, VENDING_MANAGE_STOCK, DIALOG_STYLE_MSGBOX, "Vending Menu", "Are you sure you want to restock your vending machine with 100 stock inside ?", "Yes", "No");

			}
		}
	}
	return 1;
}

Dialog:VENDING_MANAGE_STOCK(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index;
		if((index = Vending_GetInside(playerid)) != INVALID_VENDING_ID && Vending_IsOwned(playerid, index))
		{
			VendingData[index][vendStock] += 100;
			SendServerMessage(playerid, "You bought 100 vending stock for your vending machine for $500!");
			GiveMoney(playerid, -500, ECONOMY_ADD_SUPPLY, "bought vending machine stock");
			Vending_Save(index);
		}
	}
	return 1;
}

Dialog:VENDING_MANAGE_NAME(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index;
		if((index = Vending_GetInside(playerid)) != INVALID_VENDING_ID && Vending_IsOwned(playerid, index))
		{
			if(isnull(inputtext))
				return Dialog_Show(playerid, VENDING_MANAGE_NAME, DIALOG_STYLE_INPUT, "Vending Menu", "ERROR: Tidak boleh kosong!\n\nInput Vending Name :", "Change", "Cancel");

			if(strlen(inputtext) > 50)
				return Dialog_Show(playerid, VENDING_MANAGE_NAME, DIALOG_STYLE_INPUT, "Vending Menu", "ERROR: Minimum 50 karakter\n\nInput Vending Name :", "Change", "Cancel");

			format(VendingData[index][vendName], 50, inputtext);
			SendServerMessage(playerid, "You set your vending machine name to %s", inputtext);
			Vending_Save(index);
		}
	}
	return 1;
}


Dialog:VENDING_MANAGE_PRICE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index;
		if((index = Vending_GetInside(playerid)) != INVALID_VENDING_ID && Vending_IsOwned(playerid, index))
		{
			if(isnull(inputtext))
				return Dialog_Show(playerid, VENDING_MANAGE_PRICE, DIALOG_STYLE_INPUT, "Vending Menu", "ERROR: Tidak boleh kosong\n\nInput New Vending Price :", "Change", "Cancel");

			if(!IsNumeric(inputtext))
				return Dialog_Show(playerid, VENDING_MANAGE_PRICE, DIALOG_STYLE_INPUT, "Vending Menu", "ERROR: Hanya boleh angka!\n\nInput New Vending Price :", "Change", "Cancel");

			if(strval(inputtext) <= 0 || strval(inputtext) > 25)
				return Dialog_Show(playerid, VENDING_MANAGE_PRICE, DIALOG_STYLE_INPUT, "Vending Menu", "ERROR: Minimal $1 - $25\n\nInput New Vending Price :", "Change", "Cancel");

			VendingData[index][vendStockPrice] = strval(inputtext);
			SendServerMessage(playerid, "You set your vending machine price for %s", FormatNumber(strval(inputtext)));
			Vending_Save(index);
		}
	}
	return 1;
}


Dialog:VENDING_MANAGE_VAULT(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index;
		if((index = Vending_GetInside(playerid)) != INVALID_VENDING_ID && Vending_IsOwned(playerid, index))
		{
			new string[255];
			format(string, sizeof(string), "Vending Vault : "GREEN"%s\n\n"WHITE"Input Withdraw Amount :", FormatNumber(VendingData[index][vendVault]));

			if(!IsNumeric(inputtext))
				return Dialog_Show(playerid, VENDING_MANAGE_VAULT, DIALOG_STYLE_INPUT, "Vending Menu", string, "Withdraw", "Cancel");

			if(strval(inputtext) < 1 || strval(inputtext) > VendingData[index][vendVault])
				return Dialog_Show(playerid, VENDING_MANAGE_VAULT, DIALOG_STYLE_INPUT, "Vending Menu", string, "Withdraw", "Cancel");

			VendingData[index][vendVault] -= strval(inputtext);
			GiveMoney(playerid, strval(inputtext));
			SendServerMessage(playerid, "You withdraw %s from your vending machine!", FormatNumber(strval(inputtext)));
			Vending_Save(index);
		}
	}
	return 1;
}