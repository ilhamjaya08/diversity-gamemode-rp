
timer Pet_Update[100](playerid, targetid)
{
    if(PetData[playerid][petModelID] != 0 && PetData[playerid][petSpawn] && PetData[playerid][petStatus] == PET_FOLLOW)
    {

        if(!IsPlayerConnected(targetid) || !IsPlayerSpawned(targetid) || GetActorVirtualWorld(PetData[playerid][petModel]) != GetPlayerVirtualWorld(targetid))
        {
            PetData[playerid][petStatus] = PET_STAY;
            stop PetData[playerid][petTimer];
            ClearActorAnimations(PetData[playerid][petModel]);
            return 1;
        }

        new 
            Float:plrX, Float:plrY, Float:plrZ,
            Float:actorX, Float:actorY, Float:actorZ, 
            Float:actorAngle, Float:playerAngle, animIndex
        ;

        GetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ);
        GetPlayerPos(targetid, plrX, plrY, plrZ);
        GetPlayerFacingAngle(targetid, playerAngle);
        actorAngle = (GetAngleToPoint(actorX, actorY, plrX, plrY));

        animIndex = GetPlayerAnimationIndex(targetid);
        switch(animIndex)
        {
            case 1222..1236, 1246..1250:
            {
                
                if(GetDistance2D(plrX, plrY, actorX, actorY) > 3.0 && GetDistance2D(plrX, plrY, actorX, actorY) < 5.0)
                {
                    GetXYFromAngle(actorX, actorY, actorAngle, 0.1);
                    ApplyActorAnimation(PetData[playerid][petModel], "ped", "WALK_civi", 4.1, 1, 1, 1, 1, 0);
                    MapAndreas_FindZ_For2DCoord(actorX, actorY, actorZ);
                    SetFacingPlayer(PetData[playerid][petModel], targetid);
                    if(PetData[playerid][petModelID] == 20063) SetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ+0.5);
                    else SetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ+1);

                    UpdatePetText3D(playerid, actorX, actorY, actorZ+1.5);
                }
                else if(GetDistance2D(plrX, plrY, actorX, actorY) >= 5.0)
                {
                    GetXYFromAngle(actorX, actorY, actorAngle, 0.3);
                    ApplyActorAnimation(PetData[playerid][petModel], "ped", "run_civi", 4.1, 1, 1, 1, 1, 0);
                    MapAndreas_FindZ_For2DCoord(actorX, actorY, actorZ);
                    SetFacingPlayer(PetData[playerid][petModel], targetid);
                    if(PetData[playerid][petModelID] == 20063) SetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ+0.5);
                    else SetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ+1);

                    UpdatePetText3D(playerid, actorX, actorY, actorZ+1.5);
                }
            }
            default:
            {
                if (GetDistance2D(plrX, plrY, actorX, actorY) > 3.0 && GetDistance2D(plrX, plrY, actorX, actorY) < 5.0)
                {
                    GetXYFromAngle(actorX, actorY, actorAngle, 0.1);
                    ApplyActorAnimation(PetData[playerid][petModel], "ped", "WALK_civi", 4.1, 1, 1, 1, 1, 0);
                    MapAndreas_FindZ_For2DCoord(actorX, actorY, actorZ);
                    SetFacingPlayer(PetData[playerid][petModel], targetid);
                    if(PetData[playerid][petModelID] == 20063) SetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ+0.5);
                    else SetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ+1);

                    UpdatePetText3D(playerid, actorX, actorY, actorZ+1.5);
                }
                else if(GetDistance2D(plrX, plrY, actorX, actorY) >= 5.0)
                {
                    GetXYFromAngle(actorX, actorY, actorAngle, 0.3);
                    ApplyActorAnimation(PetData[playerid][petModel], "ped", "run_civi", 4.1, 1, 1, 1, 1, 0);
                    MapAndreas_FindZ_For2DCoord(actorX, actorY, actorZ);
                    SetFacingPlayer(PetData[playerid][petModel], targetid);
                    if(PetData[playerid][petModelID] == 20063) SetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ+0.5);
                    else SetActorPos(PetData[playerid][petModel], actorX, actorY, actorZ+1);

                    UpdatePetText3D(playerid, actorX, actorY, actorZ+1.5);
                }
                else if(GetDistance2D(plrX, plrY, actorX, actorY) <= 3.0)
                {
                    ClearActorAnimations(PetData[playerid][petModel]);
                    UpdatePetText3D(playerid, actorX, actorY, actorZ+0.5);
                }
            }
        }
    }
    return 1;
}