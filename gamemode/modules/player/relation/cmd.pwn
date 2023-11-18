new SelectedGift[MAX_PLAYERS];
new InviteTarget[MAX_PLAYERS];
new PlayerID[MAX_PLAYERS];
// new PlayerText:RelationshipTD[MAX_PLAYERS][4];
// new PlayerBar:RelationshipProgressBar[MAX_PLAYERS][1];

hook OnPlayerConnect(playerid)
{
    InviteTarget[playerid] = 0;
    SelectedGift[playerid] = 0;
    PlayerID[playerid] = playerid; //Untuk ngeset playerID dia.
}


hook OnPlayerDisconnect(playerid, reason)
{
	// PlayerTextDrawDestroy(playerid, RelationshipTD[playerid][0]);
	// PlayerTextDrawDestroy(playerid, RelationshipTD[playerid][1]);
	// PlayerTextDrawDestroy(playerid, RelationshipTD[playerid][2]);
	// PlayerTextDrawDestroy(playerid, RelationshipTD[playerid][3]);
	// DestroyPlayerProgressBar(playerid, RelationshipProgressBar[playerid][0]);
    InviteTarget[playerid] = 0;
    SelectedGift[playerid] = 0;
}

IsPlayerNearPartner(playerid)
{
    foreach(new i : Player)
    {   
        if(i != playerid)
        {
            if(PlayerData[playerid][pPartnerID] > 0 && PlayerData[playerid][pID] == PlayerData[i][pPartnerID])
            {
                return i;
            }
        }
    }
    return -1;
}
IsPlayerNearCouple(playerid)
{
    new Float:love = PlayerData[playerid][pLove]; 
    foreach(new i : Player)
    {   
        //Ngecheck playerid tidak sama dengan i yang di look
        //Ngecheck partnerid si player dia harus lebih dari 0
        //ngecheck partnerid kalau sama dengan si partner
       
        //SendClientMessageEx(playerid, COLOR_WHITE, "DEBUGER : playerid %d , targetID : %d", playerid, i);
        if(i != playerid)
        {
            if(PlayerData[playerid][pPartnerID] > 0 && PlayerData[playerid][pID] == PlayerData[i][pPartnerID])
            {
                GetPlayerPos(i, PlayerData[i][pPos][0], PlayerData[i][pPos][1], PlayerData[i][pPos][2]);
                if(IsPlayerInRangeOfPoint(playerid, 5.0, PlayerData[i][pPos][0], PlayerData[i][pPos][1], PlayerData[i][pPos][2]))
                {
                    SetPlayerLove(playerid, love+0.5);
                    //SendClientMessageEx(playerid, COLOR_WHITE, "DEBUGER : playerid %d , targetID : %d (ID PLAYERID DAN I BERBEDA)", playerid, i);
                }
            }
        }
    }
    return 1;
}
task IsPartnerNear[60000]() 
{
    foreach(new i : Player)
    {
        IsPlayerNearCouple(i);
    }
    return 1;
}


SetPlayerLove(playerid, Float:love)
{
    PlayerData[playerid][pLove] = love;

    if(PlayerData[playerid][pLove] > 100)
        PlayerData[playerid][pLove] = 100;

    else if(PlayerData[playerid][pLove] < 0)
        PlayerData[playerid][pLove] = 0;

    // if(!PlayerData[playerid][pTogRelation]) 
    // {
    //     SetPlayerProgressBarValue(playerid, RelationshipProgressBar[playerid][0], PlayerData[playerid][pLove]);
    // }
    return 1;
}
CMD:relationship(playerid, params[])
{
    if(PlayerData[playerid][pStatus] == 0)
        return SendClientMessageEx(playerid, COLOR_WHITE, "You're not in any relationship");

    new output[255], time;
    new	Cache:execute = mysql_query(g_iHandle, sprintf("SELECT `PartnerGift` FROM `characters` WHERE ID = '%d'", PlayerData[playerid][pID]));
	if(cache_num_rows())
	{
		time = cache_get_field_int(0, "PartnerGift");
        SelectedGift[playerid] = time;
        strcat(output, sprintf(""WHITE"Relationship Information\n"));
        if(gettime() < time)
        {
            strcat(output, sprintf(""WHITE"Send Gift %s\n", ConvertTimestamp(Timestamp:time)));
        }
        else
        {
            strcat(output, sprintf(""WHITE"Send Gift (Available)\n"));
        }
        strcat(output, sprintf(""WHITE"Breakup / Divorce\n"));
        cache_delete(execute);
    }
    Dialog_Show(playerid, RelationInformation, DIALOG_STYLE_LIST, "Relationship Status", output, "Select", "Cancel");
    return 1;
}
Dialog:RelationInformation(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                new output[600], partnername[32], Float:partnerlove, Float:totalpercentage;
                new partnerID = PlayerData[playerid][pPartnerID];
                new Float:playerlove = PlayerData[playerid][pLove];
                new Cache:checkname = mysql_query(g_iHandle, sprintf("SELECT `PartnerName` FROM `characters` WHERE `ID` = '%d' LIMIT 1;",PlayerData[playerid][pID]));
                if(cache_num_rows())
                {
                    cache_get_field_content(0, "PartnerName", partnername, 32);
                    cache_delete(checkname);
                }

                new Cache:checklove = mysql_query(g_iHandle, sprintf("SELECT `Love` FROM `characters` WHERE `ID` = '%d' LIMIT 1;", PlayerData[playerid][pPartnerID]));
                if(cache_num_rows())
                {
                    partnerlove = cache_get_field_float(0, "Love");
                    cache_delete(checklove);
                }
                totalpercentage = (playerlove/2) + (partnerlove/2);

                format(output, sizeof(output), ""WHITE"["GREEN"Relationship Status"WHITE"]\n\n");
                format(output, sizeof(output), "%s"WHITE"Nama Partner : "RED"%s (%d)\n", output, partnername, partnerID);
                if(PlayerData[playerid][pStatus] == 1) 
                {
                    format(output, sizeof(output), "%s"WHITE"Status : "GREEN"Dating\n", output); 
                } 
                else if(PlayerData[playerid][pStatus] == 2) 
                {
                    format(output, sizeof(output), "%s"WHITE"Status : "GREEN"Married\n", output);  
                }
                format(output, sizeof(output), "%s"WHITE"Love Percentage : "YELLOW"%.2f%%\n", output, totalpercentage);

                Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Relationship Status", output, "Close", "");
            }
            case 1:
            {
                new gift_time = SelectedGift[playerid];
                if(gettime() < gift_time)
			        return SendErrorMessage(playerid, "You need need to wait 1x24 hours to send another gift!");

                new targetid = IsPlayerNearPartner(playerid);
  
                if(IsPlayerConnected(targetid))
                {
                    if(targetid != INVALID_PLAYER_ID && targetid != playerid && IsPlayerInRangeOfPoint(playerid, 5.0, PlayerData[targetid][pPos][0], PlayerData[targetid][pPos][1], PlayerData[targetid][pPos][2]))
                    { 
                        SetPlayerLove(playerid, PlayerData[playerid][pLove]+10);
                        SetPlayerLove(targetid, PlayerData[targetid][pLove]+10);
                        new gift_date = gettime() + 86400;
                        mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `PartnerGift` = '%d' WHERE ID = %d;", gift_date, PlayerData[playerid][pID]));
                        mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `PartnerGift` = '%d' WHERE ID = %d;", gift_date, PlayerData[targetid][pID]));
                        SendClientMessageEx(playerid, COLOR_WHITE, "You send a "RED"gift "WHITE"to your "YELLOW"partner!");
                        SendClientMessageEx(targetid, COLOR_WHITE, "You just receive a "RED"gift "WHITE"from your "YELLOW"partner!");
                    }
                    else SendErrorMessage(playerid, "You're not close enough to your partner!");
                }
                else
                {
                    new partnerlove;
                    new Cache:checkaccount = mysql_query(g_iHandle, sprintf("SELECT `Love` FROM `characters` WHERE `ID` = '%d' LIMIT 1;",PlayerData[playerid][pPartnerID]));
                    if(cache_num_rows())
                    {
                        partnerlove = cache_get_field_int(0, "Love");
                        cache_delete(checkaccount);
                    }
                    SendClientMessageEx(playerid, COLOR_WHITE, "You send a "RED"gift "WHITE"to your "YELLOW"partner when they're not in the city!");
                    SetPlayerLove(playerid, PlayerData[playerid][pLove]+10);
                    //Ngeupdate partnergift time nya untuk keduanya
                    new gift_date = gettime() + 86400;
                    mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `PartnerGift` = '%d' WHERE ID = %d;", gift_date, PlayerData[playerid][pID]));
                    //Ngeupdate partnertgift timenya ketika offline
                    mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `PartnerGift` = '%d' WHERE ID = %d;", gift_date, PlayerData[playerid][pPartnerID]));
                    //Ngeupdate love si partnernya kalau offline
                    mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `Love` = '%d' WHERE ID = %d;", partnerlove+10, PlayerData[playerid][pPartnerID]));
                }                
            }
            case 2:
            {   
                new targetid = IsPlayerNearPartner(playerid);

                if(targetid != INVALID_PLAYER_ID && IsPlayerConnected(targetid))
                {
                    if(targetid != playerid && IsPlayerInRangeOfPoint(playerid, 5.0, PlayerData[targetid][pPos][0], PlayerData[targetid][pPos][1], PlayerData[targetid][pPos][2]))
                    {    
                        new nametarget[MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
                        GetPlayerName(targetid, nametarget, sizeof(nametarget));
                        GetPlayerName(playerid, name, sizeof(name));
                        SendClientMessageEx(playerid, COLOR_WHITE,"Kamu telah "RED"memutuskan "WHITE"hubungan mu dengan "YELLOW"%s!", nametarget);
                        SendClientMessageEx(targetid, COLOR_WHITE,"%s telah "RED"memutuskan "WHITE"hubungan dengan "YELLOW"mu!", name);

                        PlayerData[playerid][pStatus] = 0;
                        PlayerData[targetid][pStatus] = 0;

                        SetPlayerLove(targetid, 0);
                        SetPlayerLove(playerid, 0);

                        PlayerData[playerid][pPartnerID] = 0;
                        PlayerData[targetid][pPartnerID] = 0;

                        format(PlayerData[playerid][pPartnerName], 64, "Single");
                        format(PlayerData[targetid][pPartnerName], 64, "Single");
                        SQL_SaveCharacter(playerid);
                    }
                    else SendErrorMessage(playerid, "You're not close enough to your partner to perform this!");
                }
                else
                {
                    mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `Status` = '0', `Love` = '0.0', `PartnerID` = '0', `PartnerName` = 'Single' WHERE ID = %d", PlayerData[playerid][pPartnerID]));

                    PlayerData[playerid][pStatus] = 0;
                    SetPlayerLove(playerid, 0);
                    PlayerData[playerid][pPartnerID] = 0;
                    format(PlayerData[playerid][pPartnerName], 64, "Single");
                    SQL_SaveCharacter(playerid);

                    SendClientMessage(playerid, COLOR_WHITE, "Your partner is not online but you decide to breakup, now you're single!");
                }                                   
            }
        }
    }
    return 1;
}

CMD:relationcheck(playerid, params[])
{
    static
        userid;
    if (CheckAdmin(playerid, 3))
        return PermissionError(playerid);

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/relationcheck [playerid/PartOfName]");

    new output[600], partnername[32], Float:partnerlove, Float:totalpercentage;
    new partnerID = PlayerData[userid][pPartnerID];
    new Float:playerlove = PlayerData[userid][pLove];
    new Cache:checkname = mysql_query(g_iHandle, sprintf("SELECT `PartnerName` FROM `characters` WHERE `ID` = '%d' LIMIT 1;",PlayerData[userid][pID]));
    if(cache_num_rows())
    {
        cache_get_field_content(0, "PartnerName", partnername, 32);
        cache_delete(checkname);
    }

    new Cache:checklove = mysql_query(g_iHandle, sprintf("SELECT `Love` FROM `characters` WHERE `ID` = '%d' LIMIT 1;", PlayerData[userid][pPartnerID]));
    if(cache_num_rows())
    {
        partnerlove = cache_get_field_float(0, "Love");
        cache_delete(checklove);
    }
    totalpercentage = (playerlove/2) + (partnerlove/2);

    format(output, sizeof(output), ""WHITE"["GREEN"Relationship Status"WHITE"]\n\n");
    format(output, sizeof(output), "%s"WHITE"Nama Partner : "RED"%s (UniqueID: %d)\n", output, partnername, partnerID);
    if(PlayerData[userid][pStatus] == 0) 
    {
        format(output, sizeof(output), "%s"WHITE"Status : "GREEN"Single\n", output);
        format(output, sizeof(output), "%s"WHITE"Love Percentage : "YELLOW"%.2f%%\n", output, playerlove); 
    }
    else if(PlayerData[userid][pStatus] == 1) 
    {
        format(output, sizeof(output), "%s"WHITE"Status : "GREEN"Dating\n", output);
        format(output, sizeof(output), "%s"WHITE"Love Percentage : "YELLOW"%.2f%%\n", output, totalpercentage); 
    } 
    else if(PlayerData[userid][pStatus] == 2) 
    {
        format(output, sizeof(output), "%s"WHITE"Status : "GREEN"Married\n", output);  
        format(output, sizeof(output), "%s"WHITE"Government Allowance : "GREEN"$500\n", output);
        format(output, sizeof(output), "%s"WHITE"Love Percentage : "YELLOW"%.2f%%\n", output, totalpercentage);
    }

    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Relationship Status", output, "Close", "");
    return 1;
}
CMD:invite(playerid, params[])
{
    static
        userid;

    if(sscanf(params, "u", userid))
        return SendSyntaxMessage(playerid, "/invite [playerid/PartOfName]"); 

    if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0))
        return SendErrorMessage(playerid, "That player is disconnected or not near you.");

    if(userid == playerid)
        return SendErrorMessage(playerid, "You can't date yourself!.");

    if(PlayerData[playerid][pGender] == PlayerData[userid][pGender])
        return SendErrorMessage(playerid, "You cannot date the same gender as you!");

    InviteTarget[playerid] = userid;
    Dialog_Show(playerid, RelationMenu, DIALOG_STYLE_LIST, "Relationship Invitation", "Invite to date\nMarry her!", "Select", "Cancel");
    return 1;
}

Dialog:RelationMenu(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new userid = InviteTarget[playerid], name[MAX_PLAYER_NAME], nametarget[MAX_PLAYER_NAME];
        GetPlayerName(userid, nametarget, sizeof(nametarget));
        GetPlayerName(playerid, name, sizeof(name));
        switch(listitem)
        {
            case 0:
            {
                if(PlayerData[playerid][pStatus] >= 1)
                    return SendErrorMessage(playerid, "You're in relationship!.");
                    
                if(PlayerData[userid][pStatus] >= 1)
                    return SendErrorMessage(playerid, "That player is in relationship!.");

                SendClientMessageEx(playerid, COLOR_WHITE, "You have invited"RED" %s "WHITE"to date you!", nametarget);

                //Untuk nyimpen playerid si player di dalam InviteTarget si target.
                InviteTarget[userid] = playerid;

                Dialog_Show(userid, RelationInvite, DIALOG_STYLE_MSGBOX, "Relationship Invitation", ""RED"%s "WHITE"has invited you to date them", "Accept", "Decline", name);
            }
            case 1:
            {
                if(IsPlayerInRangeOfPoint(playerid, 10.0, 1220.0037, -1446.7375, 45.2224))
                {
                    if(PlayerData[playerid][pLove] == 100 && PlayerData[userid][pLove] == 100)
                    {
                        if(PlayerData[playerid][pPartnerID] == PlayerData[userid][pID])
                        {
                            InviteTarget[userid] = playerid;
                            SendClientMessageEx(playerid, COLOR_WHITE, "You have proposed"RED" %s "WHITE"to marry you!", nametarget);
                            Dialog_Show(userid, RelationInviteMarry, DIALOG_STYLE_MSGBOX, "Relationship Invitation", ""RED"%s "WHITE"has proposed you to marry them", "Accept", "Decline", name);               
                        }
                        else return SendClientMessageEx(playerid, COLOR_WHITE, "This player is not your partner!");
                    }
                    else return SendClientMessageEx(playerid, COLOR_WHITE, "Both of you need to gain full love percentage bar to propose this player!");
                }
                else return SendClientMessageEx(playerid, COLOR_WHITE, "You're not inside the church!");
            }
        }
    }
    return 1;
}

Dialog:RelationInvite(playerid, response, listitem, inputtext[])
{
    //Pindahin InviteTarget si player yang accept ke userid
    new userid = InviteTarget[playerid] , name[MAX_PLAYER_NAME], nametarget[MAX_PLAYER_NAME];
    GetPlayerName(userid, nametarget, sizeof(nametarget));
    GetPlayerName(playerid, name, sizeof(name));
    if(response)
    {
        SendClientMessageEx(userid, COLOR_WHITE, ""RED"%s "WHITE"accepted you to become your "GREEN"partner", name);
        SendClientMessageEx(playerid, COLOR_WHITE, ""RED"You "WHITE"accepted %s to become your "GREEN"partner", nametarget);
        PlayerData[playerid][pStatus] = 1;
        PlayerData[userid][pStatus] = 1;
    
        GetPlayerName(playerid, PlayerData[userid][pPartnerName], MAX_PLAYER_NAME);
        GetPlayerName(userid, PlayerData[playerid][pPartnerName], MAX_PLAYER_NAME);

        //Simpen ID SQL satu sama lain
        PlayerData[playerid][pPartnerID] = PlayerData[userid][pID];
        PlayerData[userid][pPartnerID] = PlayerData[playerid][pID];

        SQL_SaveCharacter(playerid);
        SQL_SaveCharacter(userid);

        InviteTarget[playerid] = 0;
        InviteTarget[userid] = 0; 
    }
    else
    {
        SendClientMessageEx(userid, COLOR_WHITE, ""RED"%s "WHITE"denied you to become your "GREEN"partner", name);
        SendClientMessageEx(playerid, COLOR_WHITE, ""RED"You "WHITE"denied %s to become your "GREEN"partner", nametarget);
        PlayerData[playerid][pStatus] = 0;
        PlayerData[userid][pStatus] = 0;
        InviteTarget[playerid] = 0;
        InviteTarget[userid] = 0; 
    }
    return 1;
}

Dialog:RelationInviteMarry(playerid, response, listitem, inputtext[])
{
    //Pindahin InviteTarget si player yang accept ke userid
    new userid = InviteTarget[playerid] , name[MAX_PLAYER_NAME], nametarget[MAX_PLAYER_NAME];
    GetPlayerName(userid, nametarget, sizeof(nametarget));
    GetPlayerName(playerid, name, sizeof(name));
    if(response)
    {
        SendClientMessageEx(userid, COLOR_WHITE, ""RED"%s "WHITE"accepted you to become your "GREEN"lifetime partner", name);
        SendClientMessageEx(playerid, COLOR_WHITE, ""RED"You "WHITE"accepted %s to become your "GREEN"lifetime partner", nametarget);

        // Status nikah
        PlayerData[playerid][pStatus] = 2;
        PlayerData[userid][pStatus] = 2;
        
        // Reset Love kedua player sesudah nikah
        SetPlayerLove(playerid, 0);
        SetPlayerLove(userid, 0);

        //Simpen Nama ketika sudah nikah
        GetPlayerName(playerid, PlayerData[userid][pPartnerName], MAX_PLAYER_NAME);
        GetPlayerName(userid, PlayerData[playerid][pPartnerName], MAX_PLAYER_NAME);

        //Simpen ID SQL satu sama lain
        PlayerData[playerid][pPartnerID] = PlayerData[userid][pID];
        PlayerData[userid][pPartnerID] = PlayerData[playerid][pID];

        SendClientMessageToAllEx(COLOR_WHITE, ""YELLOW"[Church] "RED"%s "WHITE"Telah menikah dan menjadi pasangan resmi "RED"%s", name, nametarget);
        if(PlayerData[playerid][pGender] == 2) {
            Dialog_Show(playerid, MarriedName, DIALOG_STYLE_INPUT, "Happy Wedding!","Kamu bisa mengganti nama mu, selamat atas pernikahanmu!", "Change", "Close");         
        }
        else if(PlayerData[userid][pGender] == 2){
            Dialog_Show(userid, MarriedName, DIALOG_STYLE_INPUT, "Happy Wedding!","Kamu bisa mengganti nama mu, selamat atas pernikahanmu!", "Change", "Close");         
        }
        SQL_SaveCharacter(playerid);
        SQL_SaveCharacter(userid);

        //Reset Invitation.
        InviteTarget[playerid] = 0;
        InviteTarget[userid] = 0; 
    }
    else
    {
        SendClientMessageEx(userid, COLOR_WHITE, ""RED"%s "WHITE"denied you to become your "GREEN"lifetime partner", name);
        SendClientMessageEx(playerid, COLOR_WHITE, ""RED"You "WHITE"denied %s to become your "GREEN"lifetime partner", nametarget);
        PlayerData[playerid][pStatus] = 0;
        PlayerData[userid][pStatus] = 0;
        InviteTarget[playerid] = 0;
        InviteTarget[userid] = 0; 
    }
    return 1;
}

Dialog:MarriedName(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(!IsValidRoleplayName(inputtext))    
            return Dialog_Show(playerid, NRPName, DIALOG_STYLE_INPUT, "Happy Wedding", "[ERROR] Kamu harus masukan nama yang roleplay!", "Change", "Close");

        mysql_tquery(g_iHandle, sprintf("SELECT * FROM `characters` WHERE `Character` = '%s';", inputtext), "OnNRPNameChange", "ds", playerid, inputtext);

    }
    else SendClientMessage(playerid, COLOR_WHITE, "Kamu menolak untuk mengganti namamu!");
    return 1;
}