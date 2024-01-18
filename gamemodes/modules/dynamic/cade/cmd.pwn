CMD:roadblock(playerid, params[])
{
    new
        index,
        option[15],
        nextParams[225],
        // vehicleid = Vehicle_Nearest(playerid, 5),
        Float:fX, Float:fY, Float:fZ;
        
    if(GetFactionType(playerid) != FACTION_POLICE && GetFactionType(playerid) != FACTION_MEDIC)
        return SendErrorMessage(playerid, "Kamu bukan seorang petugas kepolisian atau medic!");

    if(!IsPlayerDuty(playerid))
        return SendErrorMessage(playerid, "Duty terlebih dahulu!");

    if(PlayerData[playerid][pFactionRank] < 3)
        return SendErrorMessage(playerid, "Harus rank 3 keatas yang di izinkan");

    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "Harus turun dari kendaraan untuk menggunakan perintah!");

    if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
        return SendErrorMessage(playerid, "Hanya bisa digunakan di lokasi outdoor!");

    if(sscanf(params,"s[15]S()[225]", option, nextParams))
    {
        SendSyntaxMessage(playerid, "/roadblock [entity]");
        SendSyntaxMessage(playerid, "ENTITY : [add/addcustom/edit/nearest/destroy/destroyall]");
        return 1;
    }
    GetPlayerPos(playerid, fX, fY, fZ);

    if(!strcmp(option, "add", true))
    {
        new text[225];

        if(sscanf(nextParams,"s[225]", text))
            return SendSyntaxMessage(playerid, "/roadblock add [text]");

        if((index = Barricade_Create(playerid, 2, 981, text)) != -1) 
        {
            PlayerData[playerid][pEditingMode] = ROADBLOCK;
            PlayerData[playerid][pEditRoadblock] = index;
            EditDynamicObject(playerid, BarricadeData[index][cadeObject]);
            SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "RADIO: %s has dropped a roadblock at %s. ((ID %d))", ReturnName(playerid, 0), GetLocation(fX, fY, fZ), index);
        }
        else 
        {
            SendErrorMessage(playerid, "Roadblock sudah mencapai batas maksimal ("#MAX_DYNAMIC_ROADBLOCK" roadblock).");
        }
    }
    else if(!strcmp(option, "addcustom", true))
    {
        new
            output[500]; 
         
        for (new i = 0; i != sizeof(gRoadblockModels); i++) { 
            strcat(output, sprintf("%i(0,0,195,1,1,1)\n", gRoadblockModels[i]));
        } 
         
        ShowPlayerDialog(playerid, DIALOG_BARRICADE, DIALOG_STYLE_PREVIEW_MODEL, "Roadblock Objects", output, "Select", "Cancel"); 
    }
    else if(!strcmp(option, "edit", true))
    {
        if(sscanf(nextParams, "d", index))
            return SendSyntaxMessage(playerid, "/roadblock edit <roadblockid>");

        if(Barricade_IsExists(index))
        {
            PlayerData[playerid][pEditingMode] = ROADBLOCK;
            PlayerData[playerid][pEditRoadblock] = index;
            EditDynamicObject(playerid, BarricadeData[index][cadeObject]);
        }
        else SendErrorMessage(playerid, "Invalid roadblock id!");
    }
    else if(!strcmp(option, "nearest", true))
    {
        if((index = Barricade_Nearest(playerid)) != -1 && BarricadeData[index][cadeType] == 2)
        {
            SendServerMessage(playerid, "You stands near roadblock (( ID : %d ))", index);
        }
        else SendErrorMessage(playerid, "Kamu tidak berada didekat roadblock.");
    }
    else if(!strcmp(option, "destroy", true))
    {
        if((index = Barricade_Nearest(playerid)) != -1 && BarricadeData[index][cadeType] == 2)
        {
            Barricade_Delete(index);
            SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "RADIO: %s has picked up a roadblock at %s.", ReturnName(playerid, 0), GetLocation(fX, fY, fZ));
        }
        else SendErrorMessage(playerid, "Kamu tidak berada didekat roadblock.");
    }
    else if(!strcmp(option, "destroyall", true))
    {
        foreach(new i : Barricade) if(BarricadeData[i][cadeType] == 2)
        {
            Barricade_Delete(i, true);

            new next;
            Iter_SafeRemove(Barricade, i, next);
            i = next;
        }
        SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "RADIO: %s has destroyed all of the roadblocks.", ReturnName(playerid, 0));
    }
    else 
    {
        SendSyntaxMessage(playerid, "/roadblock [entity]");
        SendSyntaxMessage(playerid, "ENTITY : [add/addcustom/edit/nearest/destroy/destroyall]");
    }
    return 1;
}

CMD:spike(playerid, params[])
{
    new
        index, Float:fX, Float:fY, Float:fZ;

    if(GetFactionType(playerid) != FACTION_POLICE)
        return SendErrorMessage(playerid, "Kamu bukan seorang petugas kepolisian!");

    if(!IsPlayerDuty(playerid))
        return SendErrorMessage(playerid, "Duty terlebih dahulu!");

    if(PlayerData[playerid][pFactionRank] < 3)
        return SendErrorMessage(playerid, "Harus rank 3 keatas yang di izinkan");

    if(IsPlayerInAnyVehicle(playerid))
        return SendErrorMessage(playerid, "Harus turun dari kendaraan untuk menggunakan perintah!");

    if(GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
        return SendErrorMessage(playerid, "Hanya bisa digunakan di lokasi outdoor!");

    if(isnull(params))
        return SendSyntaxMessage(playerid, "/spike [add/destroy/destroyall]");

    GetPlayerPos(playerid, fX, fY, fZ);

    if(!strcmp(params, "add", true))
    {
        if(Barricade_Create(playerid, 1, 2899, "-") != -1) SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "RADIO: %s has dropped a spikestrip at %s.", ReturnName(playerid, 0), GetLocation(fX, fY, fZ));
        else SendErrorMessage(playerid, "Spikestrip sudah mencapai batas maksimal ("#MAX_DYNAMIC_ROADBLOCK" spikestrip).");
    }
    else if(!strcmp(params, "destroy", true))
    {
        if((index = Barricade_Nearest(playerid)) != -1 && BarricadeData[index][cadeType] == 1)
        {
            Barricade_Delete(index);
            SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "RADIO: %s has picked up a spikestrip at %s.", ReturnName(playerid, 0), GetLocation(fX, fY, fZ));
        }
        else SendErrorMessage(playerid, "Kamu tidak berada didekat spikestrip.");
    }
    else if(!strcmp(params, "destroyall", true))
    {
        foreach(new i : Barricade) if(BarricadeData[i][cadeType] == 1)
        {
            Barricade_Delete(i, true);

            new next;
            Iter_SafeRemove(Barricade, i, next);
            i = next;
        }
        SendFactionMessage(PlayerData[playerid][pFaction], COLOR_RADIO, "RADIO: %s has destroyed all of the spikestrips.", ReturnName(playerid, 0));
    }
    else SendSyntaxMessage(playerid, "/spike [add/destroy/destroyall]");
    return 1;
}