#include <a_samp>

#define red 0xFF0000AA

new Snow[MAX_PLAYERS];
new SnowOff[MAX_PLAYERS];

public OnFilterScriptInit()
{
    for(new i = 0; i <MAX_PLAYERS; i++){
    Snow[i] = CreatePlayerObject(i, 18864, 0, 0, 0, 0, 0, 0);}
    return 1;
}

public OnPlayerConnect(playerid)
{
    AttachObjectToPlayer(Snow[playerid], playerid, 1.5, 0.5, 0, 0, 1.5, 2);
    SnowOff[playerid] = 0;
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp("/snow", cmdtext, true, 5) == 0) // Enable snow for all players.
    {
        for(new i = 0; i <MAX_PLAYERS; i++){
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerAdmin(i)){
        if(SnowOff[i] == 1){
        AttachObjectToPlayer(Snow[i], i, 1.5, 0.5, 0, 0, 1.5, 2);
        SnowOff[i] = 0;}}}
        return 1;
    }

    if (strcmp("/nosnow", cmdtext, true, 7) == 0) // Disable Snow for all players.
    {
        for(new i = 0; i <MAX_PLAYERS; i++){
        if(!IsPlayerConnected(i)) continue;
        if (CheckAdmin(playerid, 7))
        return PermissionError(playerid);{
        if(SnowOff[i] == 0){
        DestroyPlayerObject(i, Snow[i]);
        SnowOff[i] = 1;}}}
        return 1;
    }

    if (strcmp("/snowon", cmdtext, true, 7) == 0) // Enable snow for player if player disabled it before.
    {
         if(SnowOff[playerid] == 1) {
         AttachObjectToPlayer(Snow[playerid], playerid, 1.5, 0.5, 0, 0, 1.5, 2);
         SendClientMessage(playerid, red, "You have set your snow on.");
         SnowOff[playerid] = 0;}
         return 1;
    }

    if (strcmp("/snowoff", cmdtext, true, 8) == 0) // Disable snow only for 1 player.
    {
         if(SnowOff[playerid] == 0) {
         DestroyPlayerObject(playerid, Snow[playerid]);
         SendClientMessage(playerid, red, "You have set your snow off.");
         SnowOff[playerid] = 1;}
         return 1;
    }
    return 0;
}
