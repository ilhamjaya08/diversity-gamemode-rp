SSCANF:ApartmentRoomMenu(string[]) 
{
 	if(!strcmp(string,"createall",true)) return 1;
 	else if(!strcmp(string,"deleteall",true)) return 2;
 	else if(!strcmp(string,"priceall",true)) return 3;
 	else if(!strcmp(string,"extpositionall",true)) return 4;
 	else if(!strcmp(string,"intpositionall",true)) return 5;
	else if(!strcmp(string,"price", true)) return 6;
 	return 0;
}

CMD:armenu(playerid, params[])
	return cmd_apartroommenu(playerid, params);

CMD:apartroommenu(playerid, params[])
{
	static index, action, nextParams[128];

	if(GetAdminLevel(playerid) < 8)
        return PermissionError(playerid);

	if(sscanf(params, "k<ApartmentRoomMenu>S()[128]", action, nextParams))
	{
		SendSyntaxMessage(playerid, "/armenu [entity]");
		SendSyntaxMessage(playerid, "ENTITY: [createall/deleteall/priceall/price]");
		SendSyntaxMessage(playerid, "ENTITY: [extpositionall/intpositionall]");
		return 1;
	}
		
	switch(action)
	{
		case 1: // Createall
		{
			new apartmentid;
			if(sscanf(nextParams, "d", index))
			{
				SendSyntaxMessage(playerid, "/apartroommenu create [index]");
				return 1;
			}

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID Apartement tidak terdaftar");

			if(Apartment_RoomCount(index) >= MAX_APARTMENT_ROOM)
				return  SendErrorMessage(playerid, "Apartement ini sudah full, lebih dari 20!");

			for(new i = 0; i < MAX_APARTMENT_ROOM; i ++)
			{
				if((apartmentid = ApartmentRoom_Create(playerid, index)) != -1) SendServerMessage(playerid, "Sukses membuat Apartment "YELLOW"id: %d", apartmentid);
				else SendErrorMessage(playerid, "Slot apartement server sudah penuh, hubungi developer!");
			}
		}
		case 2: // Deleteall
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/apartroommenu deleteall [apartment id]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID Apartement tidak terdaftar");

			foreach(new i : ApartmentRoom) if(ApartmentRoomData[i][apartmentID] == ApartmentData[index][apartmentID])
			{
				ApartmentRoom_Delete(i, true);
				new next;
				Iter_SafeRemove(ApartmentRoom, i, next);
				i = next;
			}
			SendServerMessage(playerid, "Sukses menghapus apartment room untuk gedung "YELLOW"id: %d.", index);
		}
		case 3: // Price All
		{
			new amount;
			if(sscanf(nextParams, "dd", index, amount))
				return SendSyntaxMessage(playerid, "/apartroommenu priceall [apartment id] [amount]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			foreach(new i : ApartmentRoom)
			{
				if(ApartmentData[index][apartmentID] == ApartmentRoomData[i][apartmentID])
				{
					ApartmentRoomData[i][apartmentRoomPrice] = amount;
					ApartmentRoom_Sync(i);
					ApartmentRoom_Save(i);
				}
			}
			SendServerMessage(playerid, "Sukses mengganti harga apartment room untuk gedung "YELLOW"id: %d seharga %s.", index, FormatNumber(amount));
		}
		case 4: // Exterior Position
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/apartroommenu extpositionall [apartmentid]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			foreach(new i : ApartmentRoom)
			{
				if(ApartmentData[index][apartmentID] == ApartmentRoomData[i][apartmentID])
				{
					GetPlayerPos(playerid, ApartmentRoomData[i][apartmentRoomExteriorPosX], ApartmentRoomData[i][apartmentRoomExteriorPosY], ApartmentRoomData[i][apartmentRoomExteriorPosZ]);
					GetPlayerFacingAngle(playerid, ApartmentRoomData[i][apartmentRoomExteriorPosA]);
					ApartmentRoom_Sync(i);
					ApartmentRoom_Save(i);
				}
			}
			SendServerMessage(playerid, "Sukses mengganti exterior apartment room untuk gedung "YELLOW"id: %d.", index);
		}
		case 5: // Interior Position
		{
			if(sscanf(nextParams, "d", index))
				return SendSyntaxMessage(playerid, "/apartroommenu intpositionall [apartmentid]");

			if(!Apartment_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			foreach(new i : ApartmentRoom)
			{
				if(ApartmentData[index][apartmentID] == ApartmentRoomData[i][apartmentID])
				{
					GetPlayerPos(playerid, ApartmentRoomData[i][apartmentRoomInteriorPosX], ApartmentRoomData[i][apartmentRoomInteriorPosY], ApartmentRoomData[i][apartmentRoomInteriorPosZ]);
					GetPlayerFacingAngle(playerid, ApartmentRoomData[i][apartmentRoomInteriorPosA]);
					ApartmentRoom_Sync(i);
					ApartmentRoom_Save(i);
				}
			}
			SendServerMessage(playerid, "Sukses mengganti harga apartment room untuk gedung "YELLOW"id: %d.", index);
		}
		case 6: // Price All
		{
			new amount;
			if(sscanf(nextParams, "dd", index, amount))
				return SendSyntaxMessage(playerid, "/apartroommenu price [apartment room id] [amount]");

			if(!ApartmentRoom_IsExists(index))
				return SendErrorMessage(playerid, "ID apartment yang kamu input tidak terdaftar!");

			ApartmentRoomData[index][apartmentRoomPrice] = amount;
			ApartmentRoom_Sync(index);
			ApartmentRoom_Save(index);
			SendServerMessage(playerid, "Sukses mengganti harga apartment room untuk room "YELLOW"id: %d seharga %s.", index, FormatNumber(amount));
		}
		default: 
		{
			SendSyntaxMessage(playerid, "/apartmenu [entity]");
			SendSyntaxMessage(playerid, "ENTITY: [createall/deleteall/priceall]");
			SendSyntaxMessage(playerid, "ENTITY: [extpositionall/intpositionall]");
		}
	}
	return 1;
}

CMD:astorage(playerid, params[])
{
    new 
        index
    ;
    if((index = ApartmentRoom_Inside(playerid)) != -1 && ApartmentRoom_IsOwned(playerid, index))
    {
        Apartment_ShowStorage(playerid, index);
    }
    return 1;
}