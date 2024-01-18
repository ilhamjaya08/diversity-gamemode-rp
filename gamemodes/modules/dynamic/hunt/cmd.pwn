SSCANF:AnimalMenu(string[]) 
{
    if(!strcmp(string,"create",true)) return 1;
    else if(!strcmp(string,"delete",true)) return 2;
    else if(!strcmp(string,"position",true)) return 3;
    else if(!strcmp(string,"time",true)) return 4;
    return 0;
}

CMD:anm(playerid, params[])
    return cmd_animalmenu(playerid, params);

CMD:animalmenu(playerid, params[])
{
    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    new
        animal_id, action, modelid, nextParams[128]
    ;

    if(sscanf(params, "k<AnimalMenu>S()[128]", action, nextParams))
        return SendSyntaxMessage(playerid, "/animalmenu [create/delete/position/time]");

    switch(action)
    {
        case 1: // Create
        {
            if(sscanf(nextParams, "d", modelid))
                return SendSyntaxMessage(playerid, "/animalmenu <modelid> (19315 deer, 19833 cow)");

            new Float:x, Float:y, Float:z;

            GetXYInFrontOfPlayer(playerid, x, y, 2.0);
            GetPlayerPos(playerid, z, z, z);

            if((animal_id = Animal_Create(modelid, x, y, z)) != INVALID_ITERATOR_SLOT) 
            {
                SendServerMessage(playerid, "Sukses membuat animal dengan id: %d", animal_id);
                return 1; 
            }
            SendErrorMessage(playerid, "Slot animal sudah mencapai batas maksimal (%d animals), hubungi scripter segera!.", MAX_DYNAMIC_ANIMAL);
        }
        case 2: // Delete
        {
            if(sscanf(nextParams, "d", animal_id))
                return SendSyntaxMessage(playerid, "/animalmenu delete <animal id>");

            if(!Animal_Exists(animal_id))
                return SendErrorMessage(playerid, "Id animal tidak terdaftar diserver.");

            if(Animal_Delete(animal_id)) {
                SendServerMessage(playerid, "Animal id "YELLOW"%d "WHITE"telah dihapus dari server!", animal_id);
                return 1;
            }
            SendErrorMessage(playerid, "Id animal tidak terdaftar diserver.");
        }
        case 3: // Position
        {
            if(sscanf(nextParams, "d", animal_id))
                return SendSyntaxMessage(playerid, "/animalmenu position <animal_id>");

            if(!Animal_Exists(animal_id))
                return SendErrorMessage(playerid, "Id animal tidak terdaftar diserver.");

            new Float:x, Float:y, Float:z;

            GetXYInFrontOfPlayer(playerid, x, y, 2.0);
            GetPlayerPos(playerid, z, z, z);

            Animal_SetPosition(animal_id, x, y, z);
            Animal_Sync(animal_id);
            Animal_Save(animal_id, SAVE_HUNTING_POS);
            SendServerMessage(playerid, "Posisi animal id "YELLOW"%d"WHITE" telah diperbaharui!", animal_id);
        }
        case 4: // Time
        {
            new time;

            if(sscanf(nextParams, "dd", animal_id, time))
                return SendSyntaxMessage(playerid, "/animalmenu time <animal id> <time>");

            if(!Animal_Exists(animal_id))
                return SendErrorMessage(playerid, "Id animal tidak terdaftar diserver.");

            if(time < 0)
                return SendErrorMessage(playerid, "Masukkan angka lebih dari nol!.");

            Animal_SetTime(animal_id, time);
            Animal_Sync(animal_id);
            Animal_Save(animal_id, SAVE_HUNTING_TIME);

            SendServerMessage(playerid, "Waktu spawn animal id "YELLOW"%d"WHITE" telah diperbaharui menjadi "GREEN"%d detik!", animal_id, time);
        }
        default: SendSyntaxMessage(playerid, "/animalmenu [create/delete/position/time]");
    }
    return 1;
}


// Job commands
CMD:gut(playerid, params[])
{
    new animal_id, Float:x, Float:y, Float:z;

    if(GetWeapon(playerid) != 4)
        return SendErrorMessage(playerid, "You need to hold a knife to start gutting animal");

    if(PlayerData[playerid][pHunger] < 15 || PlayerData[playerid][pEnergy] < 15)
        return SendErrorMessage(playerid, "You're too tired to work at this time");

    if((animal_id = Animal_Nearest(playerid, 3.0)) != -1)
    {
        if(!AnimalData[animal_id][animalGut])
            return SendErrorMessage(playerid, "Bunuh terlebih dahulu hewan yang akan dipotong.");

        SetPlayerHunger(playerid, PlayerData[playerid][pHunger]-0.9);
        SetPlayerEnergy(playerid, PlayerData[playerid][pEnergy]-0.8);

        GetPlayerPos(playerid, x, y, z);
        if(AnimalData[animal_id][animalModel] == ANIMAL_DEER) 
        {
            DropItem("Deer Meat", "Animal", 2804, 2, x, y, z - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
        }
        else 
        {
            DropItem("Cow Meat", "Animal", 2804, 2, x, y, z - 0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
        }

        AnimalData[animal_id][animalGut]   = 0;
        AnimalData[animal_id][animalTime]  = 3600;
        AnimalData[animal_id][animalHealth] = 100;

        Animal_Sync(animal_id);
        Animal_Save(animal_id, SAVE_HUNTING_TIME);
        Animal_Save(animal_id, SAVE_HUNTING_GUTTING);
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
        SetHuntingSkill(playerid, 1.0);
    }
    else SendErrorMessage(playerid, "Kamu tidak berada 3 meter didekat hewan mati.");
    return 1;
}
