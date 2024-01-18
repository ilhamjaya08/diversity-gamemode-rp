// Global Function
Tags_Create(playerid)
{
	static index;

	if((index = Iter_Free(Tags)) != cellmin)
	{
		Iter_Add(Tags, index);

		new text[TAGS_TEXT_LENGTH], font[TAGS_FONT_LENGTH];

		GetPVarString(playerid, "TagsText", text, sizeof(text));
		GetPVarString(playerid, "TagsFont", font, sizeof(font));

		format(TagsData[index][tagText], TAGS_TEXT_LENGTH, text);
		format(TagsData[index][tagFont], TAGS_FONT_LENGTH, font);
		format(TagsData[index][tagPlayerName], MAX_PLAYER_NAME, NormalName(playerid));

		TagsData[index][tagPosition][0] = GetPVarFloat(playerid, "TagsPosX");
		TagsData[index][tagPosition][1] = GetPVarFloat(playerid, "TagsPosY");
		TagsData[index][tagPosition][2] = GetPVarFloat(playerid, "TagsPosZ");

		TagsData[index][tagRotation][0] = GetPVarFloat(playerid, "TagsPosRX");
		TagsData[index][tagRotation][1] = GetPVarFloat(playerid, "TagsPosRY");
		TagsData[index][tagRotation][2] = GetPVarFloat(playerid, "TagsPosRZ");

		TagsData[index][tagPlayerID] = GetPlayerSQLID(playerid);

		TagsData[index][tagBold] = GetPVarInt(playerid, "TagsBold");
		TagsData[index][tagSize] = GetPVarInt(playerid, "TagsSize");
		TagsData[index][tagColor] = GetPVarInt(playerid, "TagsColor");
		TagsData[index][tagExpired] = gettime() + 259200;

		new output[700];
		mysql_format(g_iHandle, output, sizeof(output), "INSERT INTO `tags`(`tagText`, `tagFont`, `tagCreated`, `tagColor`, `tagFontsize`, `tagBold`, `tagOwner`, `tagPosx`, `tagPosy`, `tagPosz`, `tagRotx`, `tagRoty`, `tagRotz`, `tagExpired`) VALUES ('%s','%s','%s','%d','%d','%d','%d','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%d')", 
			SQL_ReturnEscaped(TagsData[index][tagText]),			
			SQL_ReturnEscaped(TagsData[index][tagFont]),			
			SQL_ReturnEscaped(TagsData[index][tagPlayerName]),			
			TagsData[index][tagColor],			
			TagsData[index][tagSize],			
			TagsData[index][tagBold],			
			TagsData[index][tagPlayerID],			
			TagsData[index][tagPosition][0],			
			TagsData[index][tagPosition][1],			
			TagsData[index][tagPosition][2],
			TagsData[index][tagRotation][0],
			TagsData[index][tagRotation][1],
			TagsData[index][tagRotation][2],
			TagsData[index][tagExpired]
		);
		mysql_tquery(g_iHandle, output, "OnTagsCreated", "d", index);
		return index;
	}
	return -1;
}

Tags_Delete(index)
{
	if(Tags_IsExists(index))
	{
		mysql_tquery(g_iHandle, sprintf("DELETE FROM `tags` WHERE `tagId`='%d';", TagsData[index][tagID]));

		if (IsValidDynamicObject(TagsData[index][tagObjectID]))
			DestroyDynamicObject(TagsData[index][tagObjectID]);

		new tmp_TagsData[E_TAGS_DATA];
		TagsData[index] = tmp_TagsData;

		TagsData[index][tagObjectID] = INVALID_STREAMER_ID;
		Iter_Remove(Tags, index);
	}
	return 1;
}


Tags_IsExists(index)
{
	if(!Iter_Contains(Tags, index))
		return 0;

	return 1;
}

Tags_Sync(index)
{
	if(Tags_IsExists(index))
	{
		if(IsValidDynamicObject(TagsData[index][tagObjectID]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_X, TagsData[index][tagPosition][0]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_Y, TagsData[index][tagPosition][1]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_Z, TagsData[index][tagPosition][2]);

			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_R_X, TagsData[index][tagRotation][0]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_R_Y, TagsData[index][tagRotation][1]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_R_Z, TagsData[index][tagRotation][2]);

		}
		else TagsData[index][tagObjectID] = CreateDynamicObject(18661, TagsData[index][tagPosition][0], TagsData[index][tagPosition][1], TagsData[index][tagPosition][2], TagsData[index][tagRotation][0], TagsData[index][tagRotation][1], TagsData[index][tagRotation][2], 0, 0, -1, 30, 30);

		SetDynamicObjectMaterialText(TagsData[index][tagObjectID], 0, TagsData[index][tagText], OBJECT_MATERIAL_SIZE_512x512, TagsData[index][tagFont], TagsData[index][tagSize], TagsData[index][tagBold], RGBAToARGB(ColorList[TagsData[index][tagColor]]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	}
	return 1;
}

Tags_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Tags) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, TagsData[i][tagPosition][0], TagsData[i][tagPosition][1], TagsData[i][tagPosition][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}

// Player Function
Tags_Menu(playerid)
	return Dialog_Show(playerid, TagsMenu, DIALOG_STYLE_LIST, "Spray Tag", "Edit Position\nEdit Text\nFont Name\nFont Size\nText Color\nBold Text\nStart Spray!", "Select", "Close");

Tags_Reset(playerid)
{
	if(IsPlayerEditingTags(playerid))
	{
		SetPlayerEditingTags(playerid, false);

		if(IsValidDynamicObject(editing_object[playerid]))
			DestroyDynamicObject(editing_object[playerid]);

		editing_object[playerid] = INVALID_STREAMER_ID;
		DeletePVar(playerid, "TagsReady");
		DeletePVar(playerid, "TagsTimer");
	}
	return 1;
}

Tags_GetCount(playerid)
{
	new count;
	foreach(new i : Tags)
	{
		if(TagsData[i][tagPlayerID] != GetPlayerSQLID(playerid))
			continue;

		count++;
	}
	return count;
}

Tags_ObjectSync(playerid, bool:editing_position = false)
{
	if(!IsPlayerEditingTags(playerid))
		return 0;

	new tags_text[TAGS_TEXT_LENGTH], font_name[TAGS_FONT_LENGTH];

	GetPVarString(playerid, "TagsText", tags_text, TAGS_TEXT_LENGTH);
	GetPVarString(playerid, "TagsFont", font_name, TAGS_FONT_LENGTH);

	if(editing_position)
	{
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_X, GetPVarFloat(playerid, "TagsPosX"));
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_Y, GetPVarFloat(playerid, "TagsPosY"));
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_Z, GetPVarFloat(playerid, "TagsPosZ"));

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_R_X, GetPVarFloat(playerid, "TagsPosRX"));
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_R_Y, GetPVarFloat(playerid, "TagsPosRY"));
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_R_Z, GetPVarFloat(playerid, "TagsPosRZ"));
	}
	SetDynamicObjectMaterialText(editing_object[playerid], 0, tags_text, OBJECT_MATERIAL_SIZE_512x512, font_name, GetPVarInt(playerid, "TagsSize"), GetPVarInt(playerid, "TagsBold"), RGBAToARGB(ColorList[GetPVarInt(playerid, "TagsColor")]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	return 1;
}

Tags_DefaultVar(playerid, Float:x, Float:y, Float:z, Float:angle)
{
	SetPVarString(playerid, "TagsText", "TEXT");
	SetPVarString(playerid, "TagsFont", "Arial");

	SetPVarFloat(playerid, "TagsPosX", x);
	SetPVarFloat(playerid, "TagsPosY", y);
	SetPVarFloat(playerid, "TagsPosZ", z);
	
	SetPVarFloat(playerid, "TagsPosRX", 0);
	SetPVarFloat(playerid, "TagsPosRY", 0);
	SetPVarFloat(playerid, "TagsPosRZ", angle);

	SetPVarInt(playerid, "TagsBold", 1);
	SetPVarInt(playerid, "TagsColor", 1);
	SetPVarInt(playerid, "TagsSize", TAGS_DEFAULT_SIZE);
	return 1;
}

// Dialog Response
Dialog:TagsMenu(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(IsPlayerEditingTags(playerid))
		{
			switch(listitem)
			{
				case 0: // Editing Position
				{
					SendServerMessage(playerid, "Posisikan tulisan spray, pastikan tidak jauh "ORANGE"5 meter "WHITE"darimu!");
					EditDynamicObject(playerid, editing_object[playerid]);
				}
				case 1: // Editing Text
				{
					Dialog_Show(playerid, TagsText, DIALOG_STYLE_INPUT, "Spray Tag - Text", WHITE"Masukkan text untuk ditampilkan pada spray tag:\n\nFormat code:\n- (n): untuk membuat baris baru | (b): memberi warna biru | (bl): memberi warna hitam | (g): memberi warna hijau\n- (r): memberi warna merah | (y): memberi warna kuning | (w): memberi warna putih", "Change", "Back");
				}
				case 2: // Font Name
				{
					Dialog_Show(playerid, TagsFont, DIALOG_STYLE_LIST, "Spray Tag - Font Name", object_font, "Change", "Back");
				}
				case 3: // Font Name
				{
					Dialog_Show(playerid, TagsFontSize, DIALOG_STYLE_INPUT, "Spray Tag - Font Size", WHITE"Ukuran sekarang: "YELLOW"%d\n\n"WHITE"Masukkan ukuran font mulai dari angka 1 sampai "#TAGS_DEFAULT_MAX_SIZE":", "Update", "Back", GetPVarInt(playerid, "TagsSize"));
				}
				case 4: // Font Color
				{
					Dialog_Show(playerid, TagsColor, DIALOG_STYLE_INPUT, "Spray Tag - Font Color", color_string, "Change", "Back");
				}
				case 5: // Toggle bold
				{
					SetPVarInt(playerid, "TagsBold", !GetPVarInt(playerid, "TagsBold"));
					SendServerMessage(playerid, "Tulisan berganti menjadi "YELLOW"%s", GetPVarInt(playerid, "TagsBold") ? ("bold") : ("reguler"));

					Tags_Menu(playerid);
					Tags_ObjectSync(playerid);
				}
				case 6: // Save Tags
				{
					SetPVarInt(playerid, "TagsReady", 1);
					SetPVarInt(playerid, "TagsTimer", 5);
				}
			}
		}
	}
	else Tags_Reset(playerid);

	return 1;
}

Dialog:TagsText(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(isnull(inputtext))
			return Dialog_Show(playerid, TagsText, DIALOG_STYLE_INPUT, "Spray Tag - Text", WHITE"error: text tidak boleh kosong!!\n\nMasukkan text untuk ditampilkan pada spray tag:\n\nFormat code:\n- (n): untuk membuat baris baru | (b): memberi warna biru | (bl): memberi warna hitam | (g): memberi warna hijau\n- (r): memberi warna merah | (y): memberi warna kuning | (w): memberi warna putih", "Change", "Back");

		if(strlen(inputtext) > TAGS_TEXT_LENGTH)
			return Dialog_Show(playerid, TagsText, DIALOG_STYLE_INPUT, "Spray Tag - Text", WHITE"error: text hanya dibatasi 1 - "#TAGS_TEXT_LENGTH" karakter!\n\nMasukkan text untuk ditampilkan pada spray tag:\n\nFormat code:\n- (n): untuk membuat baris baru | (b): memberi warna biru | (bl): memberi warna hitam | (g): memberi warna hijau\n- (r): memberi warna merah | (y): memberi warna kuning | (w): memberi warna putih", "Change", "Back");

		SetPVarString(playerid, "TagsText", ReplaceString(inputtext));
		Tags_ObjectSync(playerid);
	}
	Tags_Menu(playerid);

	return 1;
}

Dialog:TagsFont(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(listitem == sizeof(FontNames) - 1)
			return Dialog_Show(playerid, TagsFontCustom, DIALOG_STYLE_INPUT, "Spray Tag - Custom Font", "Masukkan nama font yang akan kamu ubah:", "Input", "Back");

		SetPVarString(playerid, "TagsFont", inputtext);
		Tags_ObjectSync(playerid);
	}
	Tags_Menu(playerid);

	return 1;
}

Dialog:TagsFontCustom(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!strlen(inputtext))
			return Dialog_Show(playerid, TagsFontCustom, DIALOG_STYLE_INPUT, "Spray Tag - Custom Font", "error: tidak boleh kosong, silahkan masukkan nama font yang benar!\n\nMasukkan nama font yang akan kamu ubah:", "Input", "Back");

		SetPVarString(playerid, "TagsFont", inputtext);
		Tags_ObjectSync(playerid);
	}
	Tags_Menu(playerid);

	return 1;
}

Dialog:TagsFontSize(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(!(0 < strval(inputtext) <= TAGS_DEFAULT_MAX_SIZE))
			return Dialog_Show(playerid, TagsFontSize, DIALOG_STYLE_INPUT, "Spray Tag - Font Size", WHITE"error: ukuran dibatasi mulai dari 1 sampai "#TAGS_DEFAULT_MAX_SIZE"!\n\nUkuran sekarang: "YELLOW"%d\n\n"WHITE"Masukkan ukuran font mulai dari angka 1 sampai "#TAGS_DEFAULT_MAX_SIZE":", "Update", "Back", GetPVarInt(playerid, "TagsSize"));

		SetPVarInt(playerid, "TagsSize", strval(inputtext));
		Tags_ObjectSync(playerid);
	}
	Tags_Menu(playerid);

	return 1;
}

Dialog:TagsColor(playerid, response, listitem, inputtext[])
{
	if(response)
	{
        if(!(0 <= strval(inputtext) <= sizeof(ColorList)-1))
			return Dialog_Show(playerid, TagsColor, DIALOG_STYLE_INPUT, "Spray Tag - Font Color", color_string, "Change", "Back");

		SetPVarInt(playerid, "TagsColor", strval(inputtext));
		Tags_ObjectSync(playerid);
	}
	Tags_Menu(playerid);

	return 1;
}

Dialog:TrackTags(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new index = strval(inputtext);

		if(Tags_IsExists(index) && TagsData[index][tagPlayerID] == GetPlayerSQLID(playerid))
		{
			SendServerMessage(playerid, "Pergi ke tujuan waypoint yang telah dibuat.");
        	SetPlayerWaypoint(playerid, "Tags Position", TagsData[index][tagPosition][0], TagsData[index][tagPosition][1], TagsData[index][tagPosition][2]);
		}
	}
	return 1;
}