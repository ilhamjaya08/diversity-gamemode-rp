SSCANF:ApartmentMenu(string[]) 
{
 	if(!strcmp(string,"create",true)) return 1;
 	else if(!strcmp(string,"delete",true)) return 2;
 	else if(!strcmp(string,"position",true)) return 3;
 	else if(!strcmp(string,"type",true)) return 4;
 	else if(!strcmp(string,"parking",true)) return 5;
 	else if(!strcmp(string,"interior",true)) return 6;
 	else if(!strcmp(string,"virtualworld",true)) return 7;
 	else if(!strcmp(string,"intposition",true)) return 8;
 	return 0;
}

CMD:amenu(playerid, params[])
	return cmd_apartmenu(playerid, params);

CMD:apartmenu(playerid, params[])
{
	static index, action, nextParams[128];

	if(GetAdminLevel(playerid) < 8)
        return PermissionError(playerid);

	if(sscanf(params, "k<ApartmentMenu>S()[128]", action, nextParams))
	{
		SendSyntaxMessage(playerid, "/apartmenu [entity]");
		SendSyntaxMessage(playerid, "ENTITY: [create/delete/position/type/parking]");
		SendSyntaxMessage(playerid, "ENTITY: [interior/virtualworld/intposition]");
		return 1;
	}
		
	switch(action)
	{
		case 1: // Create
		{
			new type, name[128];
			if(sscanf(nextParams, "ds[128]", type, name))
			{
				SendSyntaxMessage(playerid, "/apartmenu create [type] [name]");
				SendSyntaxMessage(playerid, "TYPE : 1.Modern | 2.Luxury | 3.Penthouse");
				return 1;
			}

			if(type <= 0 || type > 3)
				return SendSyntaxMessage(playerid, "TYPE : 1.Modern | 2.Luxury | 3.Penthouse");	

			if(isnull(name))	
			{
				SendErrorMessage(playerid, "Fill the name!");
				SendSyntaxMessage(playerid, "/apartmenu create [type] [name]");
				SendSyntaxMessage(playerid, "TYPE : 1.Modern | 2.Luxury | 3.Penthouse");
				return 1;
			}

			if(strlen(name) >  128)
			{
				SendErrorMessage(playerid, "128 Character name only!");
				SendSyntaxMessage(playerid, "/apartmenu create [type] [name]");
				SendSyntaxMessage(playerid, "TYPE : 1.Modern | 2.Luxury | 3.Penthouse");
				return 1;
			}

			if((index = Apartment_Create(playerid, type, name)) != -1) SendServerMessage(playerid, "Sukses membuat Apartment "YELLOW"id: %d, Name %s", index, name);
			else SendErrorMessage(playerid, "Jumlah Apartment sudah mencapai batas limit ("#MAX_DYNAMIC_APARTMENT" apartment)");
		}
		case 2: // Delete
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/apartmenu delete [apartment id] - WARN : REMOVE ROOM (IF AVAILABLE) FIRST BEFORE DOING THIS!");
			
			if(Apartment_Delete(index)) SendServerMessage(playerid, "Sukses menghapus apartment "YELLOW"id: %d.", index);
			else SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");
		}
		case 3: // Position
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/apartmenu position [apartment id]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			GetPlayerPos(playerid, ApartmentData[index][apartmentExteriorPosX], ApartmentData[index][apartmentExteriorPosY], ApartmentData[index][apartmentExteriorPosZ]);
			GetPlayerFacingAngle(playerid, ApartmentData[index][apartmentExteriorPosA]);

			ApartmentData[index][apartmentExteriorInt] = GetPlayerInterior(playerid);
			ApartmentData[index][apartmentExteriorWorld] = GetPlayerVirtualWorld(playerid);

			Apartment_Sync(index);
			Apartment_Save(index);
			SendServerMessage(playerid, "Sukses memindahkan apartment "YELLOW"id: %d.", index);
		}
		case 4: // type
		{
			new type;
			if(sscanf(nextParams, "dd", index, type))
			{
				SendSyntaxMessage(playerid, "/apartmenu type [index] [type]");
				SendSyntaxMessage(playerid, "TYPE : 1.Modern | 2.Luxury | 3.Penthouse");
				return 1;
			}
			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID Apartment yang kamu input tidak terdaftar!");

			ApartmentData[index][apartmentType] = type;

			Apartment_Sync(index);
			Apartment_Save(index);
			SendServerMessage(playerid, "Sukses merubah type Apartment "YELLOW"id: %d menjadi %s", index, Apartment_GetType(type));
		}
		case 5: // Parking
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/apartmenu parking [apartment id]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			GetPlayerPos(playerid, ApartmentData[index][apartmentParkingPosX], ApartmentData[index][apartmentParkingPosY], ApartmentData[index][apartmentParkingPosZ]);
			GetPlayerFacingAngle(playerid, ApartmentData[index][apartmentParkingPosA]);

			Apartment_Sync(index);
			Apartment_Save(index);
			SendServerMessage(playerid, "Sukses memindahkan apartment parking lot "YELLOW"id: %d.", index);
		}
		case 6: // Interior
		{
			new interiorid;
			if(sscanf(nextParams, "dd", index, interiorid))
				return SendSyntaxMessage(playerid, "/apartmenu interior [apartment id] [interiorid]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			
			ApartmentData[index][apartmentInteriorInt] = interiorid;

			Apartment_Sync(index);
			Apartment_Save(index);
			SendServerMessage(playerid, "Sukses memindahkan apartment interior "YELLOW"id: %d ke %d", index, interiorid);
		}
		case 7: // VirtualWorld
		{
			new vw;
			if(sscanf(nextParams, "dd", index, vw))
				return SendSyntaxMessage(playerid, "/apartmenu virtualworld [apartment id] [virtualworld]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			
			ApartmentData[index][apartmentInteriorInt] = vw;

			Apartment_Sync(index);
			Apartment_Save(index);
			SendServerMessage(playerid, "Sukses memindahkan apartment world "YELLOW"id: %d ke %d", index, vw);
		}

		case 8: // Interior Position
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/apartmenu intposition [apartment id]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			
			GetPlayerPos(playerid, ApartmentData[index][apartmentInteriorPosX], ApartmentData[index][apartmentInteriorPosY], ApartmentData[index][apartmentInteriorPosZ]);
			GetPlayerFacingAngle(playerid, ApartmentData[index][apartmentInteriorPosA]);

			ApartmentData[index][apartmentInteriorInt] = GetPlayerInterior(playerid);
			ApartmentData[index][apartmentInteriorWorld] = GetPlayerVirtualWorld(playerid);

			Apartment_Sync(index);
			Apartment_Save(index);
			SendServerMessage(playerid, "Sukses memindahkan apartment interior position "YELLOW"id: %d", index);
		}
		default: 
		{
			SendSyntaxMessage(playerid, "/apartmenu [entity]");
			SendSyntaxMessage(playerid, "ENTITY: [create/delete/position/type/parking]");
			SendSyntaxMessage(playerid, "ENTITY: [interior/virtualworld/intposition]");
		}
	}
	return 1;
}