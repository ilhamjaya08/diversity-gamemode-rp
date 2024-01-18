/*
		Filterscript criada por Carlos Victor - 06/10/2021

			Filterscript atualizado - 11/10/2021
			Update:
			Foi adicionado /savepos em veículos.

Comandos:
/savepos [Comentário (Opcional) ]

Syntax:

A pé:
SkinID, PosX, PosY, PosZ, Angle, InteriorID, VirtualWorldID //Comentário

Em veículo:
VehID, PosX, PosY, PosZ, Angle, InteriorId, VehicleVirutlaWorld //Comentário

GitHub: https://github.com/CarlinCV/SavePosition-SA-MP
Fórum: https://portalsamp.com/showthread.php?tid=1684

*/

#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>

#if defined FILTERSCRIPT

main(){
	print("[SavePosition] Carregado com sucesso!");
}

CMD:savepos(playerid, params[])
{
	new Float:P[4], Float:V[4], String[256];
	GetPlayerPos(playerid, P[0], P[1], P[2]);
	GetPlayerFacingAngle(playerid, P[3]);

	new File:log = fopen("savedpositions.txt", io_append);
	if(isnull(params))
	{ 		
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			GetVehiclePos(vehicleid, V[0], V[1], V[2]);
			GetVehicleZAngle(vehicleid, V[3]);

			format(String, sizeof(String), "%d, %f, %f, %f, %f, %d, %d //\r\n", GetVehicleModel(vehicleid), V[0], V[1], V[2], V[3], GetPlayerInterior(playerid), GetVehicleVirtualWorld(vehicleid));

			fwrite(log, String);
			fclose(log);

			SendClientMessage(playerid, 0x88AA62AA, "[SavePosition] As coordenadas do veiculo foram salvadas!");
			return 1;
		}

		format(String, sizeof(String), "%d, %f, %f, %f, %f, %d, %d //\r\n", GetPlayerSkin(playerid), P[0], P[1], P[2], P[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));

		fwrite(log, String);
		fclose(log);
	}
	else
	{ 
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			GetVehiclePos(vehicleid, V[0], V[1], V[2]);
			GetVehicleZAngle(vehicleid, V[3]);

			format(String, sizeof(String), "%d, %f, %f, %f, %f, %d, %d // %s\r\n", GetVehicleModel(vehicleid), V[0], V[1], V[2], V[3], GetPlayerInterior(playerid), GetVehicleVirtualWorld(vehicleid), params);

			fwrite(log, String);
			fclose(log);

			SendClientMessage(playerid, 0x88AA62AA, "[SavePosition] As coordenadas do veiculo foram salvadas!");
			return 1;
		}

		format(String, sizeof(String), "%d, %f, %f, %f, %f, %d, %d // %s\r\n", GetPlayerSkin(playerid), P[0], P[1], P[2], P[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), params);

		fwrite(log, String);
		fclose(log);
	}

	SendClientMessage(playerid, 0x88AA62AA, "[SavePosition] As coordenadas a pe foram salvadas!");
	return 1;
}

#endif