#include <YSI\y_hooks>

forward Tags_Load();
public Tags_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Tags, i);

			TagsData[i][tagID] 			= cache_get_field_int(i, "tagId");
			TagsData[i][tagPlayerID] 	= cache_get_field_int(i, "tagOwner");
			TagsData[i][tagBold] 		= cache_get_field_int(i, "tagBold");
			TagsData[i][tagSize] 		= cache_get_field_int(i, "tagFontsize");
			TagsData[i][tagColor] 		= cache_get_field_int(i, "tagColor");
			TagsData[i][tagExpired] 	= cache_get_field_int(i, "tagExpired");

			cache_get_field_content(i, "tagText", TagsData[i][tagText]);
			cache_get_field_content(i, "tagFont", TagsData[i][tagFont]);
			cache_get_field_content(i, "tagCreated", TagsData[i][tagPlayerName]);

			TagsData[i][tagPosition][0] = cache_get_field_float(i, "tagPosx");
			TagsData[i][tagPosition][1] = cache_get_field_float(i, "tagPosy");
			TagsData[i][tagPosition][2] = cache_get_field_float(i, "tagPosz");

			TagsData[i][tagRotation][0] = cache_get_field_float(i, "tagRotx");
			TagsData[i][tagRotation][1] = cache_get_field_float(i, "tagRoty");
			TagsData[i][tagRotation][2] = cache_get_field_float(i, "tagRotz");

			Tags_Sync(i);
		}
		printf("*** Loaded %d spray tags.", cache_num_rows());
	}
	return 1;	
}

forward OnTagsCreated(index);
public OnTagsCreated(index)
{
	TagsData[index][tagID] = cache_insert_id();

	Tags_Sync(index);
	return 1;	
}

hook OnGameModeInitEx()
{
	mysql_tquery(g_iHandle, "SELECT * FROM `tags` ORDER BY `tagId` ASC LIMIT "#MAX_DYNAMIC_TAGS";", "Tags_Load", "");
}

hook OnPlayerConnect(playerid)
{
	editing_object[playerid] = INVALID_STREAMER_ID;
}

hook OnPlayerDisconnect(playerid, reason)
{
	Tags_Reset(playerid);
}

task Tags_Update[60000]()
{
	static
		counter;

	if(++counter >= 20)
	{
		foreach(new i : Tags) if(TagsData[i][tagExpired] < gettime())
		{
			mysql_tquery(g_iHandle, sprintf("DELETE FROM `tags` WHERE `tagId`='%d';", TagsData[i][tagID]));

			if (IsValidDynamicObject(TagsData[i][tagObjectID]))
				DestroyDynamicObject(TagsData[i][tagObjectID]);

			new tmp_TagsData[E_TAGS_DATA];
			TagsData[i] = tmp_TagsData;

			TagsData[i][tagObjectID] = INVALID_STREAMER_ID;

			new next;
			Iter_SafeRemove(Tags, i, next);
			i = next;
		}
		counter = 0;
	}
	return 1;
}

ptask Player_SprayTagging[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
        
	if(GetPVarInt(playerid, "TagsReady") == 1)
	{
		if(GetPVarInt(playerid, "TagsTimer"))
		{
			SetPVarInt(playerid, "TagsTimer", GetPVarInt(playerid, "TagsTimer") - 1);

			if(!GetPVarInt(playerid, "TagsTimer"))
			{
				ClearAnimations(playerid);
				DeletePVar(playerid, "TagsReady");

				if(Tags_Create(playerid) != -1) SendServerMessage(playerid, "Sukses membuat "YELLOW"spray tag"WHITE", akan hilang setelah "LIGHTBLUE"3 hari!");
				else SendErrorMessage(playerid, "Tags sudah mencapai batas maksimal!");

				Tags_Reset(playerid);
			}
			else
			{
				ApplyAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 1, 0, 1);
				ShowPlayerFooter(playerid, "Proses pembuatan ~y~spray tag ...", 1000);
			}
		}
	}
	return 1;
}

hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(IsPlayerEditingTags(playerid))
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
				return Tags_Menu(playerid), Tags_ObjectSync(playerid, true), SendErrorMessage(playerid, "Posisi "YELLOW"object "WHITE"melebihi "ORANGE"5 meter "WHITE"dari posisimu!!");

			SetPVarFloat(playerid, "TagsPosX", x);
			SetPVarFloat(playerid, "TagsPosY", y);
			SetPVarFloat(playerid, "TagsPosZ", z);

			SetPVarFloat(playerid, "TagsPosRX", rx);
			SetPVarFloat(playerid, "TagsPosRY", ry);
			SetPVarFloat(playerid, "TagsPosRZ", rz);

			Tags_Menu(playerid);
			Tags_ObjectSync(playerid);

			SendServerMessage(playerid, "Sukses memperbaharui posisi "YELLOW"object");
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{			
			Tags_Menu(playerid);
			Tags_ObjectSync(playerid, true);

			SendErrorMessage(playerid, "Gagal memperbaharui posisi object, object akan berubah keposisi sebelumnya.");
		}
	}
	return 1;
}