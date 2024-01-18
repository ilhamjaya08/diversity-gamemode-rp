#include <YSI\y_iterate>

#define MAX_MATERIALS		16

#define MAX_TEXTURE			10
#define MAX_TEXTURE_OBJECT	50

#define E_TYPE_NONE			0
#define E_TYPE_WALL			1
#define E_TYPE_FLOOR		2
#define E_TYPE_CEILING		3
#define E_TYPE_DOOR			4
#define E_TYPE_STAIRS		5

enum E_TEXTURE
{
	tType[MAX_TEXTURE_OBJECT],

	tModel[MAX_TEXTURE_OBJECT],

	Float:tPosX[MAX_TEXTURE_OBJECT],
	Float:tPosY[MAX_TEXTURE_OBJECT],
	Float:tPosZ[MAX_TEXTURE_OBJECT],

	Float:tPosRX[MAX_TEXTURE_OBJECT],
	Float:tPosRY[MAX_TEXTURE_OBJECT],
	Float:tPosRZ[MAX_TEXTURE_OBJECT],

	tWorld[MAX_TEXTURE_OBJECT],
	tInt[MAX_TEXTURE_OBJECT],

	tObjects[MAX_TEXTURE_OBJECT],
	tMaterial[MAX_TEXTURE_OBJECT]
};
new texture[MAX_TEXTURE][E_TEXTURE],
	Iterator:Texture<MAX_TEXTURE>;


enum E_PROPERTIES
{
	propType,	
	propModel,

	Float:propX,
	Float:propY,
	Float:propZ,
	Float:propRX,
	Float:propRY,
	Float:propRZ,

	propWorld,
	propInt
};

new TextureObjects[][E_PROPERTIES] =
{
	{E_TYPE_FLOOR, 19379, 1895.326416, -2494.198242, 12.489116, 0.000000, 90.000000, 0.000000, -1, -1},
	{E_TYPE_FLOOR, 19379, 1895.326416, -2484.618652, 12.489116, 0.000000, 90.000000, 0.000000, -1, -1},
	{E_TYPE_FLOOR, 19379, 1905.807617, -2484.618652, 12.489116, 0.000000, 90.000000, 0.000000, -1, -1},
	{E_TYPE_FLOOR, 19379, 1905.807617, -2494.239013, 12.489116, 0.000000, 90.000000, 0.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1910.959594, -2484.609863, 14.315052, 0.000000, 0.000000, 0.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1910.959594, -2494.232177, 14.315052, 0.000000, 0.000000, 0.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1902.707397, -2494.232177, 14.315052, 0.000000, 0.000000, 0.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1906.109375, -2498.956054, 14.315052, 0.000000, 0.000000, 90.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1906.109375, -2486.854003, 14.315052, 0.000000, 0.000000, 90.000000, -1, -1},
	{E_TYPE_WALL, 19395, 1902.714721, -2488.541748, 14.315066, 0.000000, 0.000000, 0.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1906.109375, -2479.784179, 14.315052, 0.000000, 0.000000, 90.000000, -1, -1},
	{E_TYPE_WALL, 19395, 1901.352661, -2485.308837, 14.315066, 0.000000, 0.000000, 0.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1896.479980, -2479.784179, 14.315052, 0.000000, 0.000000, 90.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1901.362548, -2479.704101, 14.315052, 0.000000, 0.000000, 180.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1891.760742, -2484.476318, 14.315052, 0.000000, 0.000000, 180.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1891.760742, -2494.089599, 14.315052, 0.000000, 0.000000, 180.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1896.499877, -2498.956054, 14.315052, 0.000000, 0.000000, 90.000000, -1, -1},
	{E_TYPE_WALL, 19395, 1897.391357, -2485.308837, 14.315066, 0.000000, 0.000000, 0.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1897.401367, -2479.704101, 14.315052, 0.000000, 0.000000, 180.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1892.551391, -2486.828613, 14.315052, 0.000000, 0.000000, 270.000000, -1, -1},
	{E_TYPE_DOOR, 1491, 1902.698852, -2489.271484, 12.575054, 0.000000, 0.000000, 90.000000, -1, -1},
	{E_TYPE_DOOR, 1491, 1901.337890, -2486.049072, 12.575054, 0.000000, 0.000000, 90.000000, -1, -1},
	{E_TYPE_DOOR, 1491, 1897.412841, -2486.055419, 12.575054, 0.000000, 0.000000, 90.000000, -1, -1},
	{E_TYPE_DOOR, 1498, 1898.386718, -2498.922607, 12.575054, 0.000000, 0.000000, 0.000000, -1, -1},
	{E_TYPE_CEILING, 19377, 1905.807617, -2494.239013, 15.969142, 0.000000, 90.000000, 0.000000, -1, -1},
	{E_TYPE_CEILING, 19377, 1905.807617, -2484.645019, 15.969142, 0.000000, 90.000000, 0.000000, -1, -1},
	{E_TYPE_CEILING, 19377, 1895.336303, -2484.645019, 15.969142, 0.000000, 90.000000, 0.000000, -1, -1},
	{E_TYPE_CEILING, 19377, 1895.336303, -2494.245117, 15.969142, 0.000000, 90.000000, 0.000000, -1, -1},
	{E_TYPE_WALL, 19459, 1895.562011, -2491.697509, 14.315052, 0.000000, 0.000000, 180.000000, -1, -1},
	{E_TYPE_STAIRS, 14407, 1893.668334, -2488.837646, 12.725064, 0.000000, 0.000000, 540.000000, -1, -1}

};

new SelectTexture[MAX_PLAYERS] = {-1, ...},
	SelectType[MAX_PLAYERS] = {E_TYPE_NONE, ...};

Texture_Refresh(id, edittype = 0)
{
	if(Iter_Contains(Texture, id))
	{
		for(new index = 0; index != MAX_TEXTURE_OBJECT; index++)
		{
			if((!edittype) ? texture[id][tModel][index] > 0 : texture[id][tType][index] == edittype)
			{
				if(!IsValidDynamicObject(texture[id][tObjects][index]))
				{
					texture[id][tObjects][index] = CreateDynamicObject(texture[id][tModel][index], 
						texture[id][tPosX][index], texture[id][tPosY][index], texture[id][tPosZ][index], 
						texture[id][tPosRX][index], texture[id][tPosRY][index], texture[id][tPosRZ][index], 
						texture[id][tWorld][index], texture[id][tInt][index]
					);
				}

				if(texture[id][tMaterial][index] > 0) {
					SetDynamicObjectMaterial(texture[id][tObjects][index], 0, GetTModel(texture[id][tMaterial][index]), GetTXDName(texture[id][tMaterial][index]), GetTextureName(texture[id][tMaterial][index]), 0);
				}
			}
		}
	}
	else printf("[debug] Texture id %d doesn't exists.", id);
	return 1;
}

CMD:testcreate(playerid, params[])
{
	new id = Iter_Free(Texture),
		count = 0;

	Iter_Add(Texture, id);

	for(new index = 0; index != MAX_TEXTURE_OBJECT; index++) if(!texture[id][tModel][index]) 
	{
		if(count >= sizeof(TextureObjects))
			break;

		texture[id][tType][index] = TextureObjects[count][propType];

		texture[id][tModel][index] = TextureObjects[count][propModel];

		texture[id][tPosX][index] = TextureObjects[count][propX];
		texture[id][tPosY][index] = TextureObjects[count][propY];
		texture[id][tPosZ][index] = TextureObjects[count][propZ];

		texture[id][tPosRX][index] = TextureObjects[count][propRX];
		texture[id][tPosRY][index] = TextureObjects[count][propRY];
		texture[id][tPosRZ][index] = TextureObjects[count][propRZ];

		texture[id][tWorld][index] = TextureObjects[count][propWorld];
		texture[id][tInt][index] = TextureObjects[count][propInt];

		texture[id][tMaterial][index] = 0;

		count++;
	}
	SendServerMessage(playerid, "Successfull created test texture id: %d", id);
	Texture_Refresh(id, 0);
	return 1;
}

CMD:testedit(playerid, params[])
{
	new index;

	if(sscanf(params, "d", index))
		return SendSyntaxMessage(playerid, "/testedit[index]");

	if(!Iter_Contains(Texture, index))
		return SendErrorMessage(playerid, "Invalid texture id.");

	SelectTexture[playerid] = index;
	Texture_Refresh(SelectTexture[playerid], 0);
	return 1;
}

CMD:editmode(playerid, params[])
{
	if(SelectTexture[playerid] != -1)
	{
		Dialog_Show(playerid, EditTexture, DIALOG_STYLE_LIST, "Edit Texture", "Wall\nFloor\nCeiling\nDoor\nStairs", "Select", "Close");
		return 1;
	}
	SendErrorMessage(playerid, "/testedit first.");
	return 1;
}

Dialog:EditTexture(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		SelectType[playerid] = (listitem+1);

		SendServerMessage(playerid, "Index type: %d",SelectType[playerid]);
		Dialog_Show(playerid, InsertTexture, DIALOG_STYLE_INPUT, "Input Texture Format", "Insert texture format\nFollowing format: Model ID TXD Name Texture Name\n\nInsert example: "YELLOW"18202 w_towncs_t hatwall256hi", "Done", "Close");
	}
	return 1;
}

Dialog:InsertTexture(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new model, txd[32], textures[32];

		if(sscanf(inputtext, "ds[32]s[32]", model, txd, textures))
			return Dialog_Show(playerid, InsertTexture, DIALOG_STYLE_INPUT, "Ga ke input", "Insert texture format\nFollowing format: Model ID TXD Name Texture Name\n\nInsert example: "YELLOW"18202 w_towncs_t hatwall256hi", "Done", "Close");

		if(!IsValidTexture(model, txd, textures))
			return Dialog_Show(playerid, InsertTexture, DIALOG_STYLE_INPUT, "Ga valid", "Insert texture format\nFollowing format: Model ID TXD Name Texture Name\n\nInsert example: "YELLOW"18202 w_towncs_t hatwall256hi", "Done", "Close");

		for(new index = 0; index != MAX_TEXTURE_OBJECT; index++) if(texture[SelectTexture[playerid]][tModel][index] && texture[SelectTexture[playerid]][tType][index] == SelectType[playerid]) {
			texture[SelectTexture[playerid]][tMaterial][index] = GetTextureIndex(model, txd, textures);
		}
		Texture_Refresh(SelectTexture[playerid], SelectType[playerid]);

/*		SelectTexture[playerid] = -1;*/
		SelectType[playerid] = E_TYPE_NONE;
	}
	return 1;
}

