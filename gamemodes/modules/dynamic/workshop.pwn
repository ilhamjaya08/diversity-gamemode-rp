#include <YSI\y_hooks>

enum _:E_EDIT_TYPE {
	EDIT_NONE = 0,
	EDIT_BOARD,
	EDIT_GATEPOS,
	EDIT_GATEMOVE,
	EDIT_GATEPOS2,
	EDIT_GATEMOVE2
};

new EditingBoard[MAX_PLAYERS] = {-1, ...},
	EditingType[MAX_PLAYERS] = {0, ...},
	Editing[MAX_PLAYERS] = {-1, ...};

Function:Workshop_Load() {
	for(new id; id < cache_num_rows(); id++)  {
		new str[128];
		
		Iter_Add(Workshop, id);

		WorkshopData[id][wID] = cache_get_field_int(id, "ID");
		WorkshopData[id][wPrice] = cache_get_field_int(id, "Price");
		WorkshopData[id][wVault] = cache_get_field_int(id, "Vault");
		WorkshopData[id][wComponent] = cache_get_field_int(id, "Component");
		WorkshopData[id][wOwner] = cache_get_field_int(id, "Owner");
		WorkshopData[id][wSeal] = cache_get_field_int(id, "Seal");

		cache_get_field_content(id, "Name", WorkshopData[id][wName]);
		cache_get_field_content(id, "Text", WorkshopData[id][wText]);
		cache_get_field_content(id, "Pos", str, 128);

		sscanf(str, "p<|>fff", WorkshopData[id][wPos][0], WorkshopData[id][wPos][1], WorkshopData[id][wPos][2]);
		cache_get_field_content(id, "BoardPos", str, 72);
		sscanf(str, "p<|>ffffff", WorkshopData[id][wBoard][0], WorkshopData[id][wBoard][1], WorkshopData[id][wBoard][2], WorkshopData[id][wBoard][3], WorkshopData[id][wBoard][4], WorkshopData[id][wBoard][5]);
		Workshop_Refresh(id);
	}
	return 1;
}

stock Workshop_Create(playerid, price, name[])
{
	new Float:x, Float:y, Float:z;

	for (new id; id < MAX_WORKSHOP; id ++) if (!Iter_Contains(Workshop, id)) 
	{
		if (GetPlayerPos(playerid, x, y, z)) {
			format(WorkshopData[id][wName], 32, name);
			format(WorkshopData[id][wText], 128, "none");
			WorkshopData[id][wPos][0] = WorkshopData[id][wBoard][0] = x;
			WorkshopData[id][wPos][1] = WorkshopData[id][wBoard][1] = y;
			WorkshopData[id][wPos][2] = WorkshopData[id][wBoard][2] = z;

			WorkshopData[id][wPrice] = price;
			WorkshopData[id][wOwner] = 0;
			WorkshopData[id][wComponent] = 0;
			WorkshopData[id][wVault] = 0;
			WorkshopData[id][wSeal] = 0;
			WorkshopData[id][wToggle] = 0;
			
			WorkshopData[id][wPickup] = CreateDynamicPickup(1239, 23, WorkshopData[id][wPos][0], WorkshopData[id][wPos][1], WorkshopData[id][wPos][2]);
			WorkshopData[id][wLabel] = CreateDynamic3DTextLabel("Workshop Point", -1, WorkshopData[id][wPos][0], WorkshopData[id][wPos][1], WorkshopData[id][wPos][2]+0.5, 7.0);
			WorkshopData[id][wBoardObject] = CreateDynamicObject(18244, WorkshopData[id][wBoard][0], WorkshopData[id][wBoard][1], WorkshopData[id][wBoard][2], 0,0,0);
			SetDynamicObjectMaterialText(WorkshopData[id][wBoardObject], 0, WorkshopData[id][wText], OBJECT_MATERIAL_SIZE_512x256, "Ariel", 32, 1, -1, 0xFF000000, 1);
			Iter_Add(Workshop, id);
			mysql_tquery(g_iHandle, "INSERT INTO `workshop` SET `Price`='0'", "Workshop_Created", "d", id);
			return id;
		}
	}
	return 1;
}

Function:Workshop_Created(id)
{
	WorkshopData[id][wID] = cache_insert_id();
	Workshop_Refresh(id);
	Workshop_Save(id);
	return 1;
}

stock Workshop_Refresh(id)
{
	if (id != -1 && Iter_Contains(Workshop,id))
	{
		new str[128];

		if (IsValidDynamicObject(WorkshopData[id][wBoardObject])) DestroyDynamicObject(WorkshopData[id][wBoardObject]);
		if (IsValidDynamicPickup(WorkshopData[id][wPickup])) DestroyDynamicPickup(WorkshopData[id][wPickup]);
		if (IsValidDynamic3DTextLabel(WorkshopData[id][wLabel])) DestroyDynamic3DTextLabel(WorkshopData[id][wLabel]);

		new
			price = WorkshopData[id][wPrice],
			after_inflation_price = Economy_GetAmountAfterInflation(price)
		;
		
		if(WorkshopData[id][wOwner]) {
			if(WorkshopData[id][wSeal]) format(str, sizeof(str), "This workshop sealed by the {C0C0C0}authority");
			else format(str, sizeof(str), "%s\n%s", WorkshopData[id][wName], WorkshopData[id][wText]);
		}
		else format(str, sizeof(str), "This workshop is for {FF0000}sale{FFFFFF}\nPrice: {00FF00}%s{FFFFFF}\n\nType /buy to buy this", FormatNumber(after_inflation_price));

        WorkshopData[id][wPickup] = CreateDynamicPickup(1239, 23, WorkshopData[id][wPos][0], WorkshopData[id][wPos][1], WorkshopData[id][wPos][2]);
		WorkshopData[id][wLabel] = CreateDynamic3DTextLabel("Workshop Point", -1, WorkshopData[id][wPos][0], WorkshopData[id][wPos][1], WorkshopData[id][wPos][2]+0.5, 7.0);
		WorkshopData[id][wBoardObject] = CreateDynamicObject(18244, WorkshopData[id][wBoard][0], WorkshopData[id][wBoard][1], WorkshopData[id][wBoard][2], WorkshopData[id][wBoard][3], WorkshopData[id][wBoard][4], WorkshopData[id][wBoard][5]);
        SetDynamicObjectMaterialText(WorkshopData[id][wBoardObject], 0, str, OBJECT_MATERIAL_SIZE_512x256, "Ariel", 32, 1, -1, 0xFF000000, 1);
        Workshop_Save(id);
	}
	return 1;
}

Workshop_RefreshAll()
{
	foreach(new id : Workshop)
	{
		Workshop_Refresh(id);
	}
}

stock Workshop_Nearest(playerid)
{
	foreach(new id : Workshop) if(Iter_Contains(Workshop, id) && IsPlayerInRangeOfPoint(playerid, 10.0, WorkshopData[id][wPos][0], WorkshopData[id][wPos][1], WorkshopData[id][wPos][2])) {
		return id;
	}
	return -1;
}

stock Workshop_Save(id)
{
	new query[1024];

	format(query, sizeof(query), "UPDATE workshop SET `Price`='%d', `Name`='%s', `Text`='%s', `Owner`='%d', `Toggle`='%d', `Vault`='%d', `Seal`='%d', `Component`='%d'", 
		WorkshopData[id][wPrice],
		SQL_ReturnEscaped(WorkshopData[id][wName]),
		SQL_ReturnEscaped(WorkshopData[id][wText]),
		WorkshopData[id][wOwner],
		WorkshopData[id][wToggle],
		WorkshopData[id][wVault],
		WorkshopData[id][wSeal],
		WorkshopData[id][wComponent]);

	format(query, sizeof(query), "%s, `Pos` = '%.4f|%.4f|%.4f', `BoardPos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f' WHERE `ID` = '%d'", 
		query,
		WorkshopData[id][wPos][0],
		WorkshopData[id][wPos][1],
		WorkshopData[id][wPos][2],
		WorkshopData[id][wBoard][0],
		WorkshopData[id][wBoard][1],
		WorkshopData[id][wBoard][2],
		WorkshopData[id][wBoard][3],
		WorkshopData[id][wBoard][4],
		WorkshopData[id][wBoard][5],
		WorkshopData[id][wID]
	);
	return mysql_tquery(g_iHandle, query);
}

stock Workshop_GetCount(playerid)
{
	new 
		count = 0;

	foreach(new id : Workshop) if (Iter_Contains(Workshop, id) && Workshop_IsOwner(playerid, id)) {
		count++;
	}
	return count;
}

stock GetWorkshopByID(sqlid)
{
    foreach(new id : Workshop) if(Iter_Contains(Workshop, id) && WorkshopData[id][wID] == sqlid)
        return id;

    return -1;
}

stock Workshop_IsOwner(playerid, id) {
	if (Iter_Contains(Workshop, id) && WorkshopData[id][wOwner] == GetPlayerSQLID(playerid)) {
		return 1;
	}
	return 0;
}

stock Workshop_Employe(playerid, ws) {
	new str[128], Cache: cache;
	format(str, sizeof(str), "SELECT * FROM `workshop_employe` WHERE `Name`='%s' AND `Workshop`='%d'", NormalName(playerid), WorkshopData[ws][wID]);
	cache = mysql_query(g_iHandle, str);
	new result = cache_num_rows();
	cache_delete(cache);
	return result;
}

stock Workshop_AddEmploye(playerid, ws)
{
	new str[128];
	format(str, sizeof(str), "INSERT INTO `workshop_employe` SET `Name`='%s', `Workshop`='%d', `Time`=UNIX_TIMESTAMP()", NormalName(playerid), WorkshopData[ws][wID]);
	mysql_tquery(g_iHandle, str);
	return 1;
}

static Workshop_RemoveEmploye(id)
{
	new query[200];
	format(query,sizeof(query),"DELETE FROM `workshop_employe` WHERE `ID`='%d'", id);
	mysql_tquery(g_iHandle, query);
	return 1;
}

static RemoveWorkshopEmploye(id)
{
	new query[200];
	format(query,sizeof(query),"DELETE FROM `workshop_employe` WHERE `Workshop`='%d'", WorkshopData[id][wID]);
	mysql_tquery(g_iHandle, query);
	return 1;
}

stock Employe_GetCount(workshopid)
{
	new query[144], Cache: check, count;
	mysql_format(g_iHandle, query, sizeof(query), "SELECT * FROM workshop_employe WHERE Workshop = '%d'", WorkshopData[workshopid][wID]);
	check = mysql_query(g_iHandle, query);
	new result = cache_num_rows();
	if(result) {
		for(new i; i != result; i++) {
			count++;
		}
	}
	cache_delete(check);
	return count;
}

CMD:createworkshop(playerid, params[])
{
	static
		id, 
		price, 
		name[32];

	if(CheckAdmin(playerid, 9))
		return PermissionError(playerid);

	if (sscanf(params, "ds[32]", price, name)) return SendSyntaxMessage(playerid, "/createworkshop [price] [workshop name]");
	if (price < 1) return SendErrorMessage(playerid, "Invalid price for this workshop.");

	id = Workshop_Create(playerid, price, name);
	SendServerMessage(playerid, "You have created new workshop with id %d.", id);
	return 1;
}

CMD:destroyworkshop(playerid, params[])
{
	static 
		id = -1,
		str[128];

	if(CheckAdmin(playerid, 6))
		return PermissionError(playerid);

	if (sscanf(params, "d", id)) return SendSyntaxMessage(playerid, "/destroyworkshop [id]");
	if (!Iter_Contains(Workshop,id)) return SendErrorMessage(playerid, "Invalid workshop Id.");

	if (IsValidDynamicObject(WorkshopData[id][wBoardObject])) DestroyDynamicObject(WorkshopData[id][wBoardObject]);
	if (IsValidDynamicPickup(WorkshopData[id][wPickup])) DestroyDynamicPickup(WorkshopData[id][wPickup]);
	if (IsValidDynamic3DTextLabel(WorkshopData[id][wLabel])) DestroyDynamic3DTextLabel(WorkshopData[id][wLabel]);

	format(str, sizeof(str), "DELETE FROM workshop WHERE ID=%d", WorkshopData[id][wID]);
	mysql_tquery(g_iHandle, str);

	new tmp[workshopEnums];
	WorkshopData[id] = tmp;
	Iter_Remove(Workshop, id);
	SendServerMessage(playerid, "You've remove workshop id %d from this server.", id);
	return 1;
}

CMD:editworkshop(playerid, params[])
{
	static 
		id = -1,
		opsi[10],
		string[200];

	if(CheckAdmin(playerid, 9))
		return PermissionError(playerid);

	if (sscanf(params, "ds[10]S()[200]", id, opsi, string)) return SendSyntaxMessage(playerid, "/editworkshop [id] [location/toggle/price/name/text/boardpos/sell]");
	if (!Iter_Contains(Workshop,id)) return SendErrorMessage(playerid, "This workshop isn't exists.");

	if (!strcmp(opsi, "location", true))
	{
		GetPlayerPos(playerid, WorkshopData[id][wPos][0], WorkshopData[id][wPos][1], WorkshopData[id][wPos][2]);
		Workshop_Refresh(id);
	}
	else if (!strcmp(opsi, "toggle", true))
	{
		WorkshopData[id][wToggle] = (WorkshopData[id][wToggle] ? (false) : (true));

		Workshop_Save(id);
		SendServerMessage(playerid, "This workshop toggle %s.", (WorkshopData[id][wToggle]) ? ("disable") : ("enable"));
	}
	else if (!strcmp(opsi, "price", true))
	{
		static 
			price;

		if (sscanf(string, "d", price)) return SendSyntaxMessage(playerid, "/editworkshop id price [price]");
		if (price < 1) return SendErrorMessage(playerid, "Invalid price for this workshop.");

		WorkshopData[id][wPrice] = price;
		SendServerMessage(playerid, "You've set workshop price to %s.", FormatNumber(price));
		Workshop_Refresh(id);
	}	
	else if (!strcmp(opsi, "name", true))
	{
		static 
			name[32];

		if (sscanf(string, "s[32]", name)) return SendSyntaxMessage(playerid, "/editworkshop id name [name]");
		if (isnull(name)) return SendErrorMessage(playerid, "Name can't null.");

		format(WorkshopData[id][wName], 32, name);
		Workshop_Refresh(id);
	}
	else if (!strcmp(opsi, "sell", true))
	{
		format(WorkshopData[id][wName], 32, "Workshop");
		format(WorkshopData[id][wText], 128, "This workshop for sale");
		WorkshopData[id][wOwner] = 0;
		WorkshopData[id][wComponent] = 0;
		WorkshopData[id][wVault] = 0;
		WorkshopData[id][wSeal] = 0;
		WorkshopData[id][wToggle] = 0;

		RemoveWorkshopEmploye(id);
		SendServerMessage(playerid, "You've sell this workshop.");
		Workshop_Refresh(id);
	}
	else if (!strcmp(opsi, "text", true))
	{
		static 
			name[128];

		if (sscanf(string, "s[128]", name)) return SendSyntaxMessage(playerid, "/editworkshop id text [text]");
		if (isnull(name)) return SendErrorMessage(playerid, "Text can't null.");

		FixText(name);

		format(WorkshopData[id][wText], 128, ColouredText(name));
		Workshop_Refresh(id);
	}
	else if (!strcmp(opsi, "boardpos", true))
	{
		EditDynamicObject(playerid, WorkshopData[id][wBoardObject]);
		EditingBoard[playerid] = id;
		EditingType[playerid] = EDIT_BOARD;
		SendServerMessage(playerid, "Edit this board using your mouse.");
	}
	else if (!strcmp(opsi, "gatepos", true))
	{
		EditDynamicObject(playerid, WorkshopData[id][wBoardObject]);
		EditingBoard[playerid] = id;
		EditingType[playerid] = EDIT_BOARD;
		SendServerMessage(playerid, "Edit this board using your mouse.");
	}
	return 1;
}

CMD:wmenu(playerid, params[]) {
	return cmd_workshopmenu(playerid, "\1");
}

CMD:wm(playerid, params[]) {
	return cmd_workshopmenu(playerid, "\1");
}
CMD:workshopmenu(playerid, params[])
{
	new 
		id = Workshop_Nearest(playerid),
		is_owner = Workshop_IsOwner(playerid, id);

	if (id == -1) return SendErrorMessage(playerid, "You're not in anything workshop.");
	if (!is_owner && !Workshop_Employe(playerid, id)) return SendErrorMessage(playerid, "Unable to use this action.");
	if (WorkshopData[id][wSeal]) return SendErrorMessage(playerid, "This workshop is sealed by the authority.");
	
	Dialog_Show(playerid, WorkshopMenu, DIALOG_STYLE_LIST, "Workshop Menu", "Toggle Gate\n{%s}Workshop Name\n{%s}Board Text\nComponent (total: %d)\nEmploye\nVault", "Select", "Close", 
		(is_owner) ? ("FFFFFF") : ("E74C3C"),
		(is_owner) ? ("FFFFFF") : ("E74C3C"),
		WorkshopData[id][wComponent]
	);
	Editing[playerid] = id;
	return 1;
}
//================================ [ DIALOG RESPONSE ] ================================
Dialog:WorkshopMenu(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new id = Editing[playerid],
			is_owner = Workshop_IsOwner(playerid, id);

		switch(listitem)
		{
			case 0:  {
				WorkshopData[id][wToggle] = (WorkshopData[id][wToggle] ? (false) : (true));

				/*for (new i = 0; i < MAX_GATES; i ++) if(GateData[i][gateExists] && GateData[i][gateWorkshop] == WorkshopData[id][wID]) {
					Gate_Operate(i, true, WorkshopData[id][wToggle]);
				}*/
				
				SendServerMessage(playerid, "You have toggle the gate.");
				Editing[playerid] = -1;
				Workshop_Save(id);
			}
			case 1: {
				if (Workshop_IsOwner(playerid, id)) Dialog_Show(playerid, WorkshopName, DIALOG_STYLE_INPUT, "Workshop Name", "Insert text to change workshop name:", "Set", "Close");
				else cmd_wm(playerid, "\1");
			}
			case 2: {
				if (Workshop_IsOwner(playerid, id)) Dialog_Show(playerid, WorkshopText, DIALOG_STYLE_INPUT, "Board Text", "Insert text to change board text:", "Set", "Close");
				else cmd_wm(playerid, "\1");
			}
			case 3: Dialog_Show(playerid, WorkshopComponent, DIALOG_STYLE_INPUT, "Store Component", "Current component: %d\nYour component: %d\nInsert how much component you want to store:", "Store", "Close", WorkshopData[id][wComponent], Inventory_Count(playerid, "Component"));
			case 4: 
			{
				Dialog_Show(playerid, ShowEmploye, DIALOG_STYLE_LIST, "Employe Management", "{%s}Add Employe\n{%s}Remove Employe\n{%s}Remove All Employe\n{FFFFFF}Employe Members", "Select", "Close",
					(is_owner) ? ("FFFFFF") : ("E74C3C"), (is_owner) ? ("FFFFFF") : ("E74C3C"), (is_owner) ? ("FFFFFF") : ("E74C3C")
				);			
			}
			case 5: Dialog_Show(playerid, WorkshopVault, DIALOG_STYLE_LIST, "Workshop Vault", "Deposit\n{%s}Withdraw", "Select", "Close", (is_owner) ? ("FFFFFF") : ("E74C3C"));
		}
	}
	return 1;
}

Dialog:WorkshopVault(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = Editing[playerid];
		switch(listitem)
		{
			case 0: Dialog_Show(playerid, WorkshopDeposit, DIALOG_STYLE_INPUT, "Vault > Deposit", "Kamu memiliki uang total: %s\n\nBerapa banyak uang yang akan kamu simpan?", "Deposit", "Close", FormatNumber(GetMoney(playerid)));
			case 1: 
			{
				if (!Workshop_IsOwner(playerid, id)) return SendErrorMessage(playerid, "You're not owner this workshop.");
				Dialog_Show(playerid, WorkshopWithdraw, DIALOG_STYLE_INPUT, "Vault > Withdraw", "Workshop menyimpan yang total: %s\n\nBerapa banyak uang yang akan kamu ambil?", "Withdraw", "Close", FormatNumber(WorkshopData[id][wVault]));
			}
		}
	}
	return 1;
}

Dialog:WorkshopDeposit(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = Editing[playerid];

		if(strval(inputtext) < 1) return Dialog_Show(playerid, WorkshopDeposit, DIALOG_STYLE_INPUT, "Vault > Deposit", "Kamu memiliki uang total: %s\n\nBerapa banyak uang yang akan kamu simpan?", "Deposit", "Close", FormatNumber(GetMoney(playerid)));
		if(strval(inputtext) > GetMoney(playerid)) return Dialog_Show(playerid, WorkshopDeposit, DIALOG_STYLE_INPUT, "Vault > Deposit", "Uang kamu tidak cukup\nKamu memiliki uang total: %s\n\nBerapa banyak uang yang akan kamu simpan?", "Deposit", "Close", FormatNumber(GetMoney(playerid)));

		GiveMoney(playerid, -strval(inputtext));
		WorkshopData[id][wVault] += strval(inputtext);
		Workshop_Save(id);
		SendServerMessage(playerid, "You've save %s to workshop bank, now workshop saved %s on vault.", FormatNumber(strval(inputtext)), FormatNumber(WorkshopData[id][wVault]));
	}
	return 1;
}

Dialog:WorkshopWithdraw(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = Editing[playerid];
		if(strval(inputtext) < 1) return Dialog_Show(playerid, WorkshopWithdraw, DIALOG_STYLE_INPUT, "Vault > Withdraw", "Workshop menyimpan yang total: %s\n\nBerapa banyak uang yang akan kamu ambil?", "Withdraw", "Close", FormatNumber(WorkshopData[id][wVault]));
		if(strval(inputtext) > WorkshopData[id][wVault]) return Dialog_Show(playerid, WorkshopWithdraw, DIALOG_STYLE_INPUT, "Vault > Withdraw", "Workshop tidak menyimpan uang sebanyak itu\nWorkshop menyimpan yang total: %s\n\nBerapa banyak uang yang akan kamu ambil?", "Withdraw", "Close", FormatNumber(WorkshopData[id][wVault]));

		GiveMoney(playerid, strval(inputtext));
		WorkshopData[id][wVault] -= strval(inputtext);
		Workshop_Save(id);
		SendServerMessage(playerid, "You've withdrawn %s from workshop bank, now workshop saved %s on vault.", FormatNumber(strval(inputtext)), FormatNumber(WorkshopData[id][wVault]));
	}
	return 1;
}

Dialog:WorkshopComponent(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = Editing[playerid];

		if (isnull(inputtext)) return Dialog_Show(playerid, WorkshopComponent, DIALOG_STYLE_INPUT, "Error: Store Component", "Current component: %d\nYour component: %d\nInsert how much component you want to store:", "Store", "Close", WorkshopData[id][wComponent], Inventory_Count(playerid, "Component"));
		if (strval(inputtext) < 1) return Dialog_Show(playerid, WorkshopComponent, DIALOG_STYLE_INPUT, "Error: Store Component", "Current component: %d\nYour component: %d\nInsert how much component you want to store:", "Store", "Close", WorkshopData[id][wComponent], Inventory_Count(playerid, "Component"));
		if (strval(inputtext) > Inventory_Count(playerid, "Component")) return Dialog_Show(playerid, WorkshopComponent, DIALOG_STYLE_INPUT, "Error: Store Component", "Current component: %d\nYour component: %d\nInsert how much component you want to store:", "Store", "Close", WorkshopData[id][wComponent], Inventory_Count(playerid, "Component"));

		WorkshopData[id][wComponent] += strval(inputtext);
		Inventory_Remove(playerid, "Component", strval(inputtext));
		Workshop_Save(id);
		SendServerMessage(playerid,"You've stored "YELLOW"%d "WHITE"component to this workshop, current component: "YELLOW"%d", strval(inputtext),WorkshopData[id][wComponent]);
	}
	return 1;
}

stock Employe(playerid, id, type = 0)
{
	new query[255], Cache: cache;
	format(query, sizeof(query), "SELECT * FROM `workshop_employe` WHERE `Workshop`='%d'", WorkshopData[id][wID]);
	cache = mysql_query(g_iHandle, query);

	if(!cache_num_rows()) return SendErrorMessage(playerid, "There are no one employe for this workshop.");
	
	format(query, sizeof(query), "#\tName\tDate Added\n");
	for(new i; i < cache_num_rows(); i++) {
		new ws = cache_get_field_int(i, "ID"),
			time = cache_get_field_int(i, "Time"),
			name[24];

		cache_get_field_content(i, "Name", name);
		format(query, sizeof(query), "%s%d\t%s\t%s\n", query, ws, name, ConvertTimestamp(Timestamp:time));
	}
	if (!type)
		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Workshop Employe", query, "Close", "");
	else
		Dialog_Show(playerid, EmployeRemove, DIALOG_STYLE_TABLIST_HEADERS, "Remove Employe", query, "Remove", "Close");

	cache_delete(cache);
	return 1;
}

Dialog:ShowEmploye(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = Editing[playerid],
			is_owner = Workshop_IsOwner(playerid, id);

		switch(listitem)
		{
			case 0: {
				if (is_owner) Dialog_Show(playerid, AddEmploye, DIALOG_STYLE_INPUT, "Add Employe", "Masukkan nama ataupun id player untuk kamu masukkan sebagai -\npekerja di workshop ini.", "Add", "Close");
				else cmd_wm(playerid, "\1");
			}
			case 1: {
				if (is_owner) Employe(playerid, id, 1);
				else cmd_wm(playerid, "\1");
			}
			case 2: {
				if (is_owner)
				{
					RemoveWorkshopEmploye(id);
					SendServerMessage(playerid, "You've remove all employe on this workshop.");
				}
				else cmd_wm(playerid, "\1");
			}
			case 3: Employe(playerid, id, 0);
		}
	}
	return 1;
}

Dialog:EmployeRemove(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Workshop_RemoveEmploye(strval(inputtext));
		SendServerMessage(playerid,"You've remove list employe number #%d from your workshop.", strval(inputtext));
	}
	return 1;
}

Dialog:AddEmploye(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id,
			ws = Editing[playerid];

		if (Employe_GetCount(ws) > 3) return SendErrorMessage(playerid, "This workshop is limited 3 employe.");
		if (sscanf(inputtext, "u", id)) return Dialog_Show(playerid, AddEmploye, DIALOG_STYLE_INPUT, "Add Employe", "Masukkan nama ataupun id player untuk kamu masukkan sebagai -\npekerja di workshop ini.", "Add", "Close");
		if (!IsPlayerConnected(id)) return Dialog_Show(playerid, AddEmploye, DIALOG_STYLE_INPUT, "Add Employe", "Player yang kamu masukkan tidak terkoneksi dalam game\nMasukkan nama ataupun id player untuk kamu masukkan sebagai -\npekerja di workshop ini.", "Add", "Close");
		if (Workshop_Employe(id, ws)) return Dialog_Show(playerid, AddEmploye, DIALOG_STYLE_INPUT, "Add Employe", "Player tersebut sudah masuk dalam list employe\nMasukkan nama ataupun id player untuk kamu masukkan sebagai -\npekerja di workshop ini.", "Add", "Close");

		Workshop_AddEmploye(id, ws);
		SendServerMessage(playerid, "Kamu memasukkan %s ke dalam list pekerja workshopmu.", NormalName(id));
		SendServerMessage(id, "%s mempekerjakan kamu di workshop miliknya (Workshop: %s).", NormalName(playerid), WorkshopData[ws][wName]);
	}
	return 1;
}

Dialog:WorkshopText(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = Editing[playerid];

		if(isnull(inputtext)) return Dialog_Show(playerid, WorkshopText, DIALOG_STYLE_INPUT, "Board Text", "Inputtext can't be null\nInsert text to change board text:", "Set", "Close");
		if(strlen(inputtext) > 128) return Dialog_Show(playerid, WorkshopText, DIALOG_STYLE_INPUT, "Board Text", "Text too long\nInsert text to change board text:", "Set", "Close");

		FixText(inputtext);

		format(WorkshopData[id][wText], 128, ColouredText(inputtext));
		Workshop_Refresh(id);
	}
	return 1;
}

Dialog:WorkshopName(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = Editing[playerid];

		if(isnull(inputtext)) return Dialog_Show(playerid, WorkshopName, DIALOG_STYLE_INPUT, "Board Text", "Inputtext can't be null\nInsert text to change workshop name:", "Set", "Close");
		if(strlen(inputtext) > 32) return Dialog_Show(playerid, WorkshopName, DIALOG_STYLE_INPUT, "Board Text", "Text too long\nInsert text to change workshop name:", "Set", "Close");

		format(WorkshopData[id][wName], 32, inputtext);
		Workshop_Refresh(id);
	}
	return 1;
}

hook OnGameModeExit()
{
	foreach(new i : Workshop) {
        Workshop_Save(i);
    }
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new
		id = EditingBoard[playerid],
		type = EditingType[playerid];

	if (response == EDIT_RESPONSE_FINAL)
	{
		if (id != -1 && Iter_Contains(Workshop,id))
		{
			switch(type)
			{
				case EDIT_NONE: return 0;
				case EDIT_BOARD:
				{
					WorkshopData[id][wBoard][0] = x;
					WorkshopData[id][wBoard][1] = y;
					WorkshopData[id][wBoard][2] = z;
					WorkshopData[id][wBoard][3] = rx;
					WorkshopData[id][wBoard][4] = ry;
					WorkshopData[id][wBoard][5] = rz;

					Workshop_Refresh(id);

					SendServerMessage(playerid, "You've editing board for this workshop.");
				}
			}
		}
		EditingBoard[playerid] = -1;
		EditingType[playerid] = EDIT_NONE;
	}
	if(response == EDIT_RESPONSE_CANCEL)
	{
		if (id != -1 && Iter_Contains(Workshop,id))
			Workshop_Refresh(id);

		EditingBoard[playerid] = -1;
		EditingType[playerid] = EDIT_NONE;
	}
	#if defined ws_OnPlayerEditDynamicObject
		return ws_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEditDynamicObject
	#undef OnPlayerEditDynamicObject
#else
	#define _ALS_OnPlayerEditDynamicObject
#endif

#define OnPlayerEditDynamicObject ws_OnPlayerEditDynamicObject
#if defined ws_OnPlayerEditDynamicObject
	forward ws_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
#endif