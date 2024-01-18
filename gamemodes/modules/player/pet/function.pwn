UpdatePetText3D(playerid, Float:x, Float:y, Float:z)
{
    if(IsValidDynamic3DTextLabel(PetData[playerid][petText]))
    {
        Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PetData[playerid][petText], E_STREAMER_X, x);
        Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PetData[playerid][petText], E_STREAMER_Y, y);
        Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, PetData[playerid][petText], E_STREAMER_Z, z);
    }
    return 1;
}

IsPetSpawned(playerid)
{
    if(PetData[playerid][petSpawn])
        return 1;

    return 0;
}

ShowPetMenu(playerid)
{
    new string[255];
    format(string, sizeof(string), "Pet Spawn\nPet Despawn\nPet Name\nPet Stay\nPet Follow\nPet Sit\nPet Lay\nPet Jump");
    Dialog_Show(playerid, PETMENU, DIALOG_STYLE_LIST, "Pet Menu", string, "Choose", "Close");
    return 1;
}

PetSpawn(playerid)
{
    if(PetData[playerid][petSpawn])
        return SendErrorMessage(playerid, "You already have your pet spawned!");

    if(GetPlayerVirtualWorld(playerid) != 0)
        return SendErrorMessage(playerid, "You need to stay on virtual world 0 to spawn your own pet!");

    new 
        petmodelid = PetData[playerid][petModelID],
        string[255]
    ;

    new Float:fX, Float:fY, Float:fZ, Float:fAngle;

    GetXYInFrontOfPlayer(playerid, fX, fY, -1.0);
    GetPlayerPos(playerid, fZ, fZ, fZ);
    GetPlayerFacingAngle(playerid, fAngle);

    PetData[playerid][petModel] = CreateActor(petmodelid, fX, fY+2, fZ, fAngle);
    format(string, sizeof(string), "Owner: %s\nName: %s", ReturnName(playerid), PetData[playerid][petName]);
    PetData[playerid][petText] = CreateDynamic3DTextLabel(string, X11_WHITE, fX, fY+2, fZ, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

    PetData[playerid][petSpawn] = true;
    PetData[playerid][petStatus] = PET_FOLLOW;
    SendServerMessage(playerid, "You have spawned your pet!");
    PetData[playerid][petTimer] = repeat Pet_Update(playerid, playerid);
    return 1;
}


PetDespawn(playerid)
{
    if(PetData[playerid][petSpawn])
    {
        if(IsValidActor(PetData[playerid][petModel]))
            DestroyActor(PetData[playerid][petModel]);
        
        if(IsValidDynamic3DTextLabel(PetData[playerid][petText]))
            DestroyDynamic3DTextLabel(PetData[playerid][petText]);

        PetData[playerid][petModel] = INVALID_ACTOR_ID;
        PetData[playerid][petText] = Text3D:INVALID_STREAMER_ID;
        PetData[playerid][petStatus] = PET_NONE;
        PetData[playerid][petSpawn] = false;
        stop PetData[playerid][petTimer];

        SendServerMessage(playerid, "You De-spawn your pet!");
    }
    return 1;
}

PetSit(playerid)
{
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_SIT;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "ped", "SEAT_down", 4.1, 0, 0, 0, 1, 0);
        SendServerMessage(playerid, "Your pet is now sit!");
    }
    return 1;
}

PetLay(playerid)
{
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_LAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "CRACK", "crckidle2", 4.1, 0, 0, 0, 1, 0);
        SendServerMessage(playerid, "Your pet is now lay!");
    }
    return 1;
}


PetJump(playerid)
{
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_LAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        ApplyActorAnimation(PetData[playerid][petModel], "BSKTBALL", "BBALL_DEF_JUMP_SHOT", 4.1, 1, 0, 0, 0, 0);
        SendServerMessage(playerid, "Your pet is now lay!");
    }
    return 1;
}

PetStay(playerid)
{
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        PetData[playerid][petStatus] = PET_STAY;
        stop PetData[playerid][petTimer];
        ClearActorAnimations(PetData[playerid][petModel]);
        SendServerMessage(playerid, "Your pet is now Stay!");
    }
    return 1;
}

PetFollow(playerid, targetid)
{
    if(!IsPetSpawned(playerid))
        return SendErrorMessage(playerid, "Your pet is not spawned!");

    if(IsValidActor(PetData[playerid][petModel]))
    {
        if(PetData[playerid][petStatus] == PET_FOLLOW)
        {
            stop PetData[playerid][petTimer];
        }
        PetData[playerid][petStatus] = PET_FOLLOW;
        ClearActorAnimations(PetData[playerid][petModel]);
        PetData[playerid][petTimer] = repeat Pet_Update(playerid, targetid);
        SendServerMessage(playerid, "Your pet is now following!");
    }
    return 1;
}

PetName(playerid)
{
    if(PetData[playerid][petSpawn])
        return SendErrorMessage(playerid, "De-spawn pet mu terlebih dahulu!");

    if(strcmp(PetData[playerid][petName], "Jack", true))
        return SendErrorMessage(playerid, "Nama pet mu sudah tidak bisa di ubah lagi!");

    Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Pet Name", "WARNING: Pergantian nama pet hanya bisa 1x\n\nInput your pet name:", "Input Name", "Cancel");
    return 1;
}

Dialog:PET_NAME(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(isnull(inputtext) || IsNumeric(inputtext))
            return Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Pet Name", "ERROR: Fill the name!\nInput your pet name:", "Input Name", "Cancel");

        if(strlen(inputtext) > 128)
            return Dialog_Show(playerid, PET_NAME, DIALOG_STYLE_INPUT, "Pet Name", "ERROR: Name are not allowed more than 128 character!\nInput your pet name:", "Input Name", "Cancel");

        format(PetData[playerid][petName], 128, "%s", inputtext);
        SendServerMessage(playerid, "You have change your pet name to %s", inputtext);
    }
    return 1;
}

Dialog:PETMENU(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: PetSpawn(playerid);
            case 1: PetDespawn(playerid);
            case 2: PetName(playerid);
            case 3: PetStay(playerid);
            case 4: Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Pet Follow", "Input Player ID that you wanted your pet to follow\nFill empty if you want to follow yourself!", "Follow", "Cancel");
            case 5: PetSit(playerid);
            case 6: PetLay(playerid);
            case 7: PetJump(playerid);
        }
    }
    return 1;
}
Dialog:PET_MENU_FOLLOW(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new targetid;

        if(isnull(inputtext))
            return PetFollow(playerid, playerid);

        if(!IsNumeric(inputtext))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Pet Follow", "Input Player ID that you wanted your pet to follow!", "Follow", "Cancel");

        if(sscanf(inputtext, "u", targetid))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Pet Follow", "ERROR: Input playerid can't be empty!\n\nInput Player ID that you wanted your pet to follow!", "Follow", "Cancel");
    
        if(targetid == INVALID_PLAYER_ID || !IsPlayerSpawned(targetid))
            return Dialog_Show(playerid, PET_MENU_FOLLOW, DIALOG_STYLE_INPUT, "Pet Follow", "ERROR: Invalid player id!\n\nInput Player ID that you wanted your pet to follow!", "Follow", "Cancel");


        PetFollow(playerid, targetid);
        SendServerMessage(playerid, "Your pet is now following %s", ReturnName(targetid));
    }
    return 1;
}
stock Float:GetDistance2D(Float:x1, Float:y1, Float:x2, Float:y2) {
	return floatsqroot(
		((x1 - x2) * (x1 - x2)) +
		((y1 - y2) * (y1 - y2))
	);
}

stock Float:GetAbsoluteAngle(Float:angle) {
	while(angle < 0.0) {
		angle += 360.0;
	}
	while(angle > 360.0) {
		angle -= 360.0;
	}
	return angle;
}

// Returns the offset heading from north between a point and a destination
stock Float:GetAngleToPoint(Float:fPointX, Float:fPointY, Float:fDestX, Float:fDestY) {
	return GetAbsoluteAngle(-(
		90.0 - (
			atan2(
				(fDestY - fPointY),
				(fDestX - fPointX)
			)
		)
	));
}

stock GetXYFromAngle(&Float:x, &Float:y, Float:a, Float:distance) 
{
    x += (distance*floatsin(-a,degrees));
    y += (distance*floatcos(-a,degrees));
}


stock SetFacingPlayer(actorid, playerid)
{
    new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid, pX, pY, pZ);

    return SetFacingPoint(actorid, pX, pY);
}

stock SetFacingPoint(actorid, Float:x, Float:y)
{

    new Float:pX, Float:pY, Float:pZ;
    GetActorPos(actorid, pX, pY, pZ);

    new Float:angle;

    if( y > pY ) angle = (-acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 90.0);
    else if( y < pY && x < pX ) angle = (acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 450.0);
    else if( y < pY ) angle = (acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 90.0);

    if(x > pX) angle = (floatabs(floatabs(angle) + 180.0));
    else angle = (floatabs(angle) - 180.0);

    return SetActorFacingAngle(actorid, angle);
}

IsValidPetModel(skinid)
{
    switch(skinid)
    {
        case 20062..20069:
            return 1;
    }
    return 0;
}