#define DIALOG_EDIT_BONE 5000
#define IsCookingDrug(%0)		    GetPVarInt(%0, "CookingStart")//ngambil waktu cooking drug

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

enum weaponSettings
{
    ID,
    Float:Position[6],
    Bone,
    Hidden,
    WeaponExists
}
new WeaponSettings[MAX_PLAYERS][17][weaponSettings], WeaponTick[MAX_PLAYERS], EditingWeapon[MAX_PLAYERS];

new NgambilSenjata[MAX_PLAYERS];

GetWeaponObjectSlot(weaponid)
{
    new objectslot;
 
    switch (weaponid)
    {
        case 22..24: objectslot = 5;
        case 25..27: objectslot = 6;
        case 28, 29, 32: objectslot = 7;
        case 30, 31: objectslot = 8;
        case 33, 34: objectslot = 9;
        // case 35..38: objectslot = 9;
    }
    return objectslot;
}
 
GetWeaponModel(weaponid) //Will only return the model of wearable weapons (22-38)
{
    new model;
   
    switch(weaponid)
    {
        case 22..29: model = 324 + weaponid;
        case 30: model = 355;
        case 31: model = 356;
        case 32: model = 372;
        case 33..38: model = 324 + weaponid;
    }
    return model;
}
 
PlayerHasWeaponAttachment(playerid, weaponid)
{
    new weapon, ammo;
 
    for (new i; i < 13; i++)
    {
        GetPlayerWeaponData(playerid, i, weapon, ammo);
        if (weapon == weaponid && ammo) return 1;
    }
    return 0;
}

IsWeaponShotgun(weaponid)
    return (weaponid >= 25 && weaponid <= 27);

IsWeaponSMG(weaponid)
    return (weaponid >= 28 && weaponid <= 32);

IsWeaponPistol(weaponid)
    return (weaponid >= 22 && weaponid <= 24);

IsWeaponWearable(weaponid)
    return (weaponid >= 22 && weaponid <= 38);
 
IsWeaponHideable(weaponid)
    return (weaponid >= 22 && weaponid <= 24 || weaponid == 28 || weaponid == 32);
 
forward OnWeaponsLoaded(playerid);
public OnWeaponsLoaded(playerid)
{
    new weaponid, index;
    static rows, fields;
    cache_get_data(rows, fields);
    for (new i=0; i != rows; i++)
    {        
        weaponid = cache_get_field_int(i, "WeaponID");
        index = weaponid - 22;
        WeaponSettings[playerid][index][WeaponExists] = true;
        WeaponSettings[playerid][index][ID] = cache_get_field_int(i, "ID");
//        SendClientMessageEx(playerid, COLOR_WHITE, "Weapon ID %d || DB ID : %d", weaponid, WeaponSettings[playerid][index][ID]);
        // if(WeaponSettings[playerid][index][ID]) 
        // {                
        WeaponSettings[playerid][index][Position][0] = cache_get_field_float(i, "PosX");
        WeaponSettings[playerid][index][Position][1] = cache_get_field_float(i, "PosY");
        WeaponSettings[playerid][index][Position][2] = cache_get_field_float(i, "PosZ");
        WeaponSettings[playerid][index][Position][3] = cache_get_field_float(i, "RotX");
        WeaponSettings[playerid][index][Position][4] = cache_get_field_float(i, "RotY");
        WeaponSettings[playerid][index][Position][5] = cache_get_field_float(i, "RotZ");
        WeaponSettings[playerid][index][Bone] = cache_get_field_int(i, "Bone");
        WeaponSettings[playerid][index][Hidden] = cache_get_field_int(i, "Hidden");

        // }
    }
    return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
    EditingWeapon[playerid] = 0;
    WeaponTick[playerid] = 0;
}
timer ResetNgambilSenjata[2000](playerid)
{
    NgambilSenjata[playerid] = 0;
    return 1;
}
hook OnPlayerUpdate(playerid)
{
    if (NetStats_GetConnectedTime(playerid) - WeaponTick[playerid] >= 250)
    {
        new weaponid, ammo, objectslot, count, index; 
        for (new i = 2; i <= 7; i++) //Loop untuk senjata yang bisa di pake di badan doang.
        {
            GetPlayerWeaponData(playerid, i, weaponid, ammo);
            index = weaponid - 22;           
            if (weaponid && ammo && !WeaponSettings[playerid][index][Hidden] && IsWeaponWearable(weaponid) && EditingWeapon[playerid] != weaponid)
            {
                objectslot = GetWeaponObjectSlot(weaponid);
 
                if(GetPlayerWeapon(playerid) != weaponid)
                {
                    SetPlayerAttachedObject(playerid, objectslot, GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
                }
                else if (IsPlayerAttachedObjectSlotUsed(playerid, objectslot)) 
                {
                    RemovePlayerAttachedObject(playerid, objectslot);
                    if(IsCookingDrug(playerid))
                    {
                        Cooking_Reset(playerid);
                    }

                    if(NgambilSenjata[playerid] == 0)
                    {
                        if(IsWeaponPistol(weaponid))
                        {
                            ApplyAnimationEx(playerid, "PYTHON", "python_reload", 50,0,0,0,0,0,1,true, false);
                            NgambilSenjata[playerid] = 1;
                            defer ResetNgambilSenjata(playerid);
                        }
                        else if(IsWeaponShotgun(weaponid))
                        {
                            ApplyAnimationEx(playerid, "BUDDY", "buddy_reload", 50,0,0,0,0,0,1,true, false);
                            NgambilSenjata[playerid] = 1;
                            defer ResetNgambilSenjata(playerid);                            
                        }
                        else if(IsWeaponSMG(weaponid))
                        {
                            ApplyAnimationEx(playerid, "RIFLE", "rifle_load", 50,0,0,0,0,0,1,true, false);
                            NgambilSenjata[playerid] = 1;
                            defer ResetNgambilSenjata(playerid);    
                        }
                    }
                }
            }
        }
        for (new i=5; i <= 9; i++)
        { 
            if(IsPlayerAttachedObjectSlotUsed(playerid, i))
            {
                count = 0;    
                for (new j = 22; j <= 38; j++) 
                {
                    if(PlayerHasWeaponAttachment(playerid, j) && GetWeaponObjectSlot(j) == i)
                    {
                        count++;
                    }
                }
                if(!count) 
                {
                    RemovePlayerAttachedObject(playerid, i);
                }
            }
        }
        WeaponTick[playerid] = NetStats_GetConnectedTime(playerid);
    }
    return 1;
}
ResetWeaponSettings(playerid)
{
    for(new i = 0; i < 17; i++)
    {
        WeaponSettings[playerid][i][Position][0] = -0.116;
        WeaponSettings[playerid][i][Position][1] = 0.189;
        WeaponSettings[playerid][i][Position][2] = 0.088;
        WeaponSettings[playerid][i][Position][3] = 0.0;
        WeaponSettings[playerid][i][Position][4] = 44.5;
        WeaponSettings[playerid][i][Position][5] = 0.0;
        WeaponSettings[playerid][i][Bone] = 1;
        WeaponSettings[playerid][i][Hidden] = false;
        WeaponSettings[playerid][i][WeaponExists] = false;
    }    
    return 1;
}
hook OnPlayerConnect(playerid)
{  
    WeaponTick[playerid] = 0;
    EditingWeapon[playerid] = 0;
}
// WeapAttachSave(playerid, weaponid)
// {
//     new query[500], name[MAX_PLAYER_NAME];
//     GetPlayerName(playerid, name, MAX_PLAYER_NAME);

//     mysql_format(g_iHandle, query, sizeof(query), "UPDATE `weaponsettings` SET `Name` = '%s', `WeaponID` = '%d', `PosX` = '%.3f', `PosY` = '%.3f', `PosZ` = '%.3f', `RotX` = '%.3f', `RotY` = '%.3f', `RotZ` = '%.3f', `Bone` = '%d', `Hidden` = '%d', `WepExists` = '%d' WHERE `ID` = '%d' ", 
//     name, 
//     weaponid+22, //Ini karena jadi index dan akan jadi weapon ID kalau di tambah 22. karena sebelumnya di kurang 22
//     WeaponSettings[playerid][weaponid][Position][0], 
//     WeaponSettings[playerid][weaponid][Position][1], 
//     WeaponSettings[playerid][weaponid][Position][2], 
//     WeaponSettings[playerid][weaponid][Position][3], 
//     WeaponSettings[playerid][weaponid][Position][4], 
//     WeaponSettings[playerid][weaponid][Position][5],
//     WeaponSettings[playerid][weaponid][Bone],
//     WeaponSettings[playerid][weaponid][Hidden],
//     WeaponSettings[playerid][weaponid][WeaponExists], 
//     WeaponSettings[playerid][weaponid][ID]);

//     return mysql_tquery(g_iHandle, query);
// }
WeaponAtt_Save(playerid, weaponid)
{
    new query[500], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    if(!WeaponSettings[playerid][weaponid][WeaponExists])
    {
        WeaponSettings[playerid][weaponid][WeaponExists] = true;
        mysql_format(g_iHandle, query, sizeof(query), "INSERT INTO `weaponsettings` SET `Name` = '%s', `charID` = '%d', `WeaponID` = '%d', `PosX` = '%.3f', `PosY` = '%.3f', `PosZ` = '%.3f', `RotX` = '%.3f', `RotY` = '%.3f', `RotZ` = '%.3f', `Bone` = '%d', `Hidden` = '%d', `WepExists` = '%d'", 
        name,
        PlayerData[playerid][pID], 
        weaponid+22, //Ini karena jadi index dan akan jadi weapon ID kalau di tambah 22. karena sebelumnya di kurang 22
        WeaponSettings[playerid][weaponid][Position][0], 
        WeaponSettings[playerid][weaponid][Position][1], 
        WeaponSettings[playerid][weaponid][Position][2], 
        WeaponSettings[playerid][weaponid][Position][3], 
        WeaponSettings[playerid][weaponid][Position][4], 
        WeaponSettings[playerid][weaponid][Position][5],
        WeaponSettings[playerid][weaponid][Bone],
        WeaponSettings[playerid][weaponid][Hidden],
        WeaponSettings[playerid][weaponid][WeaponExists]); 
        mysql_tquery(g_iHandle, query);
    }
    else
    {
        mysql_format(g_iHandle, query, sizeof(query), "UPDATE `weaponsettings` SET `Name` = '%s', `WeaponID` = '%d', `PosX` = '%.3f', `PosY` = '%.3f', `PosZ` = '%.3f', `RotX` = '%.3f', `RotY` = '%.3f', `RotZ` = '%.3f', `Bone` = '%d', `Hidden` = '%d', `WepExists` = '%d' WHERE `charID` = '%d' AND `WeaponID` = '%d' ", 
        name, 
        weaponid+22, //Ini karena jadi index dan akan jadi weapon ID kalau di tambah 22. karena sebelumnya di kurang 22
        WeaponSettings[playerid][weaponid][Position][0], 
        WeaponSettings[playerid][weaponid][Position][1], 
        WeaponSettings[playerid][weaponid][Position][2], 
        WeaponSettings[playerid][weaponid][Position][3], 
        WeaponSettings[playerid][weaponid][Position][4], 
        WeaponSettings[playerid][weaponid][Position][5],
        WeaponSettings[playerid][weaponid][Bone],
        WeaponSettings[playerid][weaponid][Hidden],
        WeaponSettings[playerid][weaponid][WeaponExists], 
        PlayerData[playerid][pID],
        weaponid+22);
        mysql_tquery(g_iHandle, query);
    }
    return 1;
}
Function:OnPlayerAttachWeapon(playerid, weaponid)
{
    WeaponSettings[playerid][weaponid - 22][ID] = cache_insert_id();
    WeaponAtt_Save(playerid, weaponid - 22);
    return 1;
}
Function:SaveWeaponAttachment(playerid, weaponid)
{
    new playerindex, name[MAX_PLAYER_NAME];
    new query[160];
    static rows, fields;
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    cache_get_data(rows, fields);
    for(new i=0; i < rows; i++)
    {
        playerindex = cache_get_field_int(i, "charID");
        weaponid = cache_get_field_int(i, "WeaponID");
//        SendClientMessageEx(playerid, COLOR_WHITE, "PID : %d || P_Index : %d || Weapon in hand : %d || WeaponDBID : %d", PlayerData[playerid][pID], playerindex, GetPlayerWeapon(playerid), weaponid);
        if(PlayerData[playerid][pID] == playerindex && GetPlayerWeapon(playerid) == weaponid && WeaponSettings[playerid][weaponid - 22][WeaponExists])
        {        
            mysql_format(g_iHandle, query, sizeof(query), "UPDATE `weaponsettings` SET `Bone` = '%d' WHERE `charID` = '%d' AND `WeaponID` = '%d'", WeaponSettings[playerid][weaponid - 22][Bone], PlayerData[playerid][pID], weaponid);
            mysql_tquery(g_iHandle, query);
        }
    }
    return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (dialogid == DIALOG_EDIT_BONE)
    {
        if (response)
        {
            new weaponid = EditingWeapon[playerid], weaponname[18], string[150], name[MAX_PLAYER_NAME];
            GetPVarInt(playerid, "Listitem");
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
            GetPlayerName(playerid, name, sizeof(name));

            if(weaponid < 22)
                return SendErrorMessage(playerid, "Invalid weapon id!");

            WeaponSettings[playerid][weaponid - 22][Bone] = listitem + 1;
            WeaponSettings[playerid][weaponid - 22][Hidden] = false;
            
            format(string, sizeof(string), "You have successfully changed the bone of your %s.", weaponname);
            SendClientMessage(playerid, -1, string);
            if(!WeaponSettings[playerid][weaponid - 22][WeaponExists])
            {
                WeaponSettings[playerid][weaponid - 22][WeaponExists] = true;
                mysql_format(g_iHandle, string, sizeof(string), "INSERT INTO weaponsettings (Name, charID, WeaponID, Bone, Hidden, WepExists) VALUES ('%s',%d, %d, %d, %d, %d)", name, PlayerData[playerid][pID], weaponid, WeaponSettings[playerid][weaponid - 22][Bone], WeaponSettings[playerid][weaponid - 22][Hidden], WeaponSettings[playerid][weaponid - 22][WeaponExists]);
                mysql_tquery(g_iHandle, string, "OnPlayerAttachWeapon", "dd", playerid, weaponid);
                
            }//Bikin weaponexists
            else
            {
                mysql_format(g_iHandle, string, sizeof(string), "SELECT * FROM `weaponsettings` WHERE `WeaponID` = '%d' AND `charID` = '%d'", weaponid, PlayerData[playerid][pID]);
                mysql_tquery(g_iHandle, string, "SaveWeaponAttachment", "dd", playerid, weaponid);
            }
        }
        EditingWeapon[playerid] = 0;
        return 1;
    }
    return 0;
}
CMD:hidegun(playerid, params[])
{
    new weaponid = GetPlayerWeapon(playerid);
    if(!weaponid) 
        return ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu harus memegang senjata untuk menggunakan command ini.");

    if(IsWeaponWearable(weaponid))
    {   
        Dialog_Show(playerid, HideGun, DIALOG_STYLE_LIST, "Weapon Attachment", "Weapon Position\nWeapon Bone\nHide Gun", "Select", "Cancel");
    }
    else ShowPlayerFooter(playerid, "~r~ERROR: ~w~Kamu tidak bisa attach senjata tipe ini.");
    return 1;
}
Dialog:HideGun(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        new weaponid = GetPlayerWeapon(playerid);
        switch (listitem)
        {
            case 0:
            {   
                if (weaponid < 22)
                    return SendErrorMessage(playerid, "Invalid weapon id!");

                if (EditingWeapon[playerid])
                    return SendErrorMessage(playerid, "You are already editing a weapon.");
    
                if (WeaponSettings[playerid][weaponid - 22][Hidden])
                    return SendErrorMessage(playerid, "You cannot adjust a hidden weapon.");
            
                if(WeaponSettings[playerid][weaponid - 22][Bone] == 0)
                    return SendErrorMessage(playerid, "You need to set bone position first!");
    
                new index = weaponid - 22;

                EditingWeapon[playerid] = weaponid;

                SetPlayerArmedWeapon(playerid, 0);
            
                SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][index][Bone], WeaponSettings[playerid][index][Position][0], WeaponSettings[playerid][index][Position][1], WeaponSettings[playerid][index][Position][2], WeaponSettings[playerid][index][Position][3], WeaponSettings[playerid][index][Position][4], WeaponSettings[playerid][index][Position][5], 1.0, 1.0, 1.0);
                EditAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
            
                
            }
            case 1:
            {
                if (EditingWeapon[playerid])
                    return SendClientMessage(playerid, -1, "You are already editing a weapon.");
    
                EditingWeapon[playerid] = weaponid;
                ShowPlayerDialog(playerid, DIALOG_EDIT_BONE, DIALOG_STYLE_LIST, "Bone", "Spine\nHead\nLeft upper arm\nRight upper arm\nLeft hand\nRight hand\nLeft thigh\nRight thigh\nLeft foot\nRight foot\nRight calf\nLeft calf\nLeft forearm\nRight forearm\nLeft shoulder\nRight shoulder\nNeck\nJaw", "Choose", "Cancel");
            }
            case 2:
            {
                if (EditingWeapon[playerid])
                    return SendClientMessage(playerid, -1, "You cannot hide a weapon while you are editing it.");
    
                if (!IsWeaponHideable(weaponid))
                    return SendClientMessage(playerid, -1, "This weapon cannot be hidden.");
    
                new index = weaponid - 22, weaponname[18], name[MAX_PLAYER_NAME], string[150];
    
                GetWeaponName(weaponid, weaponname, sizeof(weaponname));
                GetPlayerName(playerid, name, MAX_PLAYER_NAME);
            
                if (WeaponSettings[playerid][index][Hidden])
                {
                    format(string, sizeof(string), "You have set your %s to show.", weaponname);
                    WeaponSettings[playerid][index][Hidden] = false;
                }
                else
                {
                    if (IsPlayerAttachedObjectSlotUsed(playerid, GetWeaponObjectSlot(weaponid)))
                        RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
    
                    format(string, sizeof(string), "You have set your %s not to show.", weaponname);
                    WeaponSettings[playerid][index][Hidden] = true;
                }
                SendClientMessage(playerid, -1, string);
            
                mysql_format(g_iHandle, string, sizeof(string), "UPDATE weaponsettings SET `Name` = '%s', `WeaponID` = '%d', `Hidden` = '%d' WHERE `ID` = %d", name, weaponid, WeaponSettings[playerid][index][Hidden], WeaponSettings[playerid][index][ID]);
                mysql_tquery(g_iHandle, string);
            }
        }
    }
    return 0;
} 