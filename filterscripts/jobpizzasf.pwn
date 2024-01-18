// ~ ~ Pizza Job SAMP Script ~ ~ //
// Made by "Angelo Brand" //
// ~Please dont Remove my Credit~ //

#include <a_samp>
#include <zcmd>

#define COLOR_RED 0xFF0000FF
#define COLOR_SILVER 0xDDDDDDFF
#define COLOR_GREEN 0x00FF00FF

new PizzaJob[256];
new Pizza[256];


public OnFilterScriptInit()
{
	Pizza[0] = CreateVehicle(448,-1803.9338,954.8958,24.4896,272.2979,-1,-1,3); //Pizza 1
	Pizza[1] = CreateVehicle(448,-1803.9116,951.9764,24.4892,271.7650,-1,-1,3); //Pizza 2
    Pizza[2] = CreateVehicle(448,-1803.9611,958.2033,24.4897,273.6116,-1,-1,3); //Pizza 3

	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
    {
  		if(GetPlayerVehicleID(playerid) == Pizza[0])
        {
            //>>>>>>>>>> MISSION STARTED
			PizzaJob[playerid] = 1;
        	new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s is now an on duty as Pizzaboy.", name );
            SendClientMessageToAll(COLOR_SILVER, string);
            SetPlayerRaceCheckpoint(playerid,0,-1899.6952,846.4348,34.6103,-2217.7075,731.3439,48.8657,5.0);
        	SendClientMessage(playerid, 0xFFFF00FF, "You have started the Pizza Missions! Follow the checkpoints to delivery the Pizza.");
			//SendClientMessage(playerid, 0xFF00FF, "[PizzaJob] :{FFFF00}Cancel Mission {FF0000}tipe /stopdrive");
		}
		if(GetPlayerVehicleID(playerid) == Pizza[1])
        {
            //>>>>>>>>>> MISSION STARTED
			PizzaJob[playerid] = 1;
        	new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s is now an on duty as Pizzaboy.", name );
            SendClientMessageToAll(COLOR_SILVER, string);
            SetPlayerRaceCheckpoint(playerid,0,-1899.6952,846.4348,34.6103,-2217.7075,731.3439,48.8657,5.0);
        	SendClientMessage(playerid, 0xFFFF00FF, "You have started the Pizza Missions! Follow the checkpoints to delivery the Pizza.");
			//SendClientMessage(playerid, 0xFF00FF, "[PizzaJob] :{FFFF00}Cancel Mission {FF0000}tipe /stopdrive");
		}
		if(GetPlayerVehicleID(playerid) == Pizza[2])
        {
            //>>>>>>>>>> MISSION STARTED
			PizzaJob[playerid] = 1;
        	new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s is now an on duty as Pizzaboy.", name );
            SendClientMessageToAll(COLOR_SILVER, string);
            SetPlayerRaceCheckpoint(playerid,0,-1899.6952,846.4348,34.6103,-2217.7075,731.3439,48.8657,5.0);
        	SendClientMessage(playerid, 0xFFFF00FF, "You have started the Pizza Missions! Follow the checkpoints to delivery the Pizza.");
			//SendClientMessage(playerid, 0xFF00FF, "[PizzaJob] :{FFFF00}Cancel Mission {FF0000}tipe /stopdrive");
		}
		
	}
    if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
		if(PizzaJob[playerid] > 0 )
		{
			PizzaJob[playerid] = 0;
			new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s has left his job as Pizzaboy.", name );
            SendClientMessageToAll(COLOR_RED, string);
            DisablePlayerRaceCheckpoint(playerid);
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 10.0);
        	GameTextForPlayer(playerid,"Mission Canceled!",5000,5);
      		SendClientMessage(playerid, 0xFF0000FF, "You have left your job and did'nt earn anything.");
			//GivePlayerMoney(playerid,15000);
		}
    }
    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == Pizza[0],Pizza[1],Pizza[2])
     {
		if(PizzaJob[playerid] == 1){
            PizzaJob[playerid] = 2;
            SetPlayerRaceCheckpoint(playerid,0,-2217.7075,731.3439,48.8657,-2254.1589,301.5724,34.7605,5.0);
			//SetPlayerCheckpoint(playerid,-1946.0288,599.7076,35.1088,5);
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 10.0);
            //SendClientMessage(playerid,0xFF00FF,"[BUSDRIVER]: {FF0000}Continue following those checkpoints in the map !");
            //GameTextForPlayer(playerid,"~b~Continue following the ~r~checkpoints to receive ~g~~h~some cash ~b~!",5000,5);
            return 1;
		}
		if(PizzaJob[playerid] == 2){
            PizzaJob[playerid] = 3;
            SetPlayerRaceCheckpoint(playerid,1,-2254.1589,301.5724,34.7605,-1799.4376,-93.5345,7.0420, 5.0);
            //SetPlayerCheckpoint(playerid,-1554.4264,669.8592,7.1316,5);
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 10.0);
            return 1;
  		}
		
		if(PizzaJob[playerid] == 3){
            PizzaJob[playerid] = 4;
            SetPlayerRaceCheckpoint(playerid,2,-1799.4376,-93.5345,7.0420,-1798.5428,945.8399,24.3272, 5.0);
            //SetPlayerCheckpoint(playerid,-1554.4264,669.8592,7.1316,5);
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 10.0);
            return 1;
		}

		if(PizzaJob[playerid] == 4){
            PizzaJob[playerid] = 5;
            SetPlayerRaceCheckpoint(playerid,3,-1798.5428,945.8399,24.3272,0,0,0, 5.0);
            //SetPlayerCheckpoint(playerid,-1554.4264,669.8592,7.1316,5);
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 10.0);
            return 1;
		}
		
		if(PizzaJob[playerid] == 5){
            PizzaJob[playerid] = 0;
            TogglePlayerControllable(playerid, 0);
            DisablePlayerRaceCheckpoint(playerid);
            //DisablePlayerCheckpoint(playerid);
            TogglePlayerControllable(playerid, 1);
            GameTextForPlayer(playerid,"Mission Completed",5000,5);
            SendClientMessage(playerid, 0xFF00FF, "Congratulations! You have earned $4000 from delivery the Pizza.");
            PlayerPlaySound(playerid, 1139, 0.0, 0.0, 10.0);
			GivePlayerMoney(playerid,4000);
			new name[MAX_PLAYER_NAME], string[48];
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "~ %s has completed the Pizza Mission.", name );
            SendClientMessageToAll(COLOR_GREEN, string);
   			RemovePlayerFromVehicle(playerid);
   			
		}


     }
    return 1;
}

////////////////////
