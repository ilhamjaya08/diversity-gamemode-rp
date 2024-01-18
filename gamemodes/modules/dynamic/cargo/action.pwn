#include <YSI\y_hooks>

hook OnGameModeInitEx()
{
	mysql_pquery(g_iHandle, sprintf("SELECT * FROM `cargo` ORDER BY `id` ASC LIMIT %d;", MAX_DYNAMIC_CARGO), "Cargo_Load", "");
}

task Cargo_FeatureUpdate[1000]()
{
	static counter;

	if(++counter > 1800)
	{
		foreach(new i : Cargo) if(CargoData[i][cargoExpired] < gettime())
		{
			mysql_tquery(g_iHandle, sprintf("DELETE FROM `cargo` WHERE `id`='%d';", CargoData[i][cargoID]));

			if (IsValidDynamicObject(CargoData[i][cargoObject]))
				DestroyDynamicObject(CargoData[i][cargoObject]);

			if(IsValidDynamic3DTextLabel(CargoData[i][cargoLabel]))
				DestroyDynamic3DTextLabel(CargoData[i][cargoLabel]);

			new tmp_CargoData[E_CARGO_DATA];
			CargoData[i] = tmp_CargoData;

			CargoData[i][cargoObject] = INVALID_STREAMER_ID;
			CargoData[i][cargoLabel] = Text3D:INVALID_STREAMER_ID;

			new next;
			Iter_SafeRemove(Cargo, i, next);
			i = next;
		}
		counter = 0;
	}
}

hook OnPlayerDisconnectEx(playerid, reason)
{
	if(GetPlayerCargoType(playerid) != CARGO_NONE)
	{
		if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0)
		{
			if(Cargo_Place(playerid, GetPlayerCargoType(playerid), GetPlayerCargoProduct(playerid)) != -1)
			{
				SetPlayerCargoProduct(playerid, 0);
				SetPlayerCargoType(playerid, CARGO_NONE);
			}
		}
	}
}