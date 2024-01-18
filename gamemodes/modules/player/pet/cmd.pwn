CMD:givepet(playerid, params[])
{
    new targetid, petmodel;

    if(CheckAdmin(playerid, 6))
        return PermissionError(playerid);

    if(sscanf(params, "ud", targetid, petmodel))
        return SendSyntaxMessage(playerid, "/givepet [playerid] [petmodel]");

    if(!IsValidPetModel(petmodel))
        return SendErrorMessage(playerid, "Invalid Pet model!");   

    PetData[targetid][petModelID] = petmodel;
    format(PetData[targetid][petName], 128, "Jack");
    SendServerMessage(playerid, "You give %s a pet model id %d", ReturnName(targetid), petmodel);
    return 1;
}

// CMD:petmenu(playerid, params[])
// {
//     if(!PetData[playerid][petModelID])
//         return SendErrorMessage(playerid, "You dont have a pet!");

//     ShowPetMenu(playerid);
//     return 1;
// }