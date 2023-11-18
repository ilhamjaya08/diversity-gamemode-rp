#include <YSI\y_hooks>

hook OnPlayerConnect(playerid, reason)
{
    PetData[playerid][petModel] = INVALID_ACTOR_ID;
    PetData[playerid][petText] = Text3D:INVALID_STREAMER_ID;
    PetData[playerid][petStatus] = PET_NONE;
    PetData[playerid][petSpawn] = false;
}

hook OnPlayerDisconnectEx(playerid, reason)
{
    PetDespawn(playerid);
}