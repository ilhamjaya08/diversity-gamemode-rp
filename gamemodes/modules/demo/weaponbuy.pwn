enum E_WEAPON_LISTITEM
{
    E_WEAPON_LISTITEM_NAME[35],
    E_WEAPON_LISTITEM_WEAPON_ID,
    E_WEAPON_LISTITEM_MODEL
};

new const WEAPONS_LIST[][E_WEAPON_LISTITEM] =
{
    {"Grenade", WEAPON_GRENADE, 342},
    {"Tear Gas", WEAPON_TEARGAS, 343},
    {"Molotov Cocktail", WEAPON_MOLTOV, 344},
    {"RPG", WEAPON_ROCKETLAUNCHER, 359},
    {"HS Rocket", WEAPON_HEATSEEKER, 360},
    {"Flamethrower", WEAPON_FLAMETHROWER, 361},
    {"Satchel Charge", WEAPON_SATCHEL, 363},
    {"Fire Extinguisher", WEAPON_FIREEXTINGUISHER, 366}
};

CMD:weapons(playerid)
{
    new string[sizeof WEAPONS_LIST * 50];
    for (new i; i < sizeof WEAPONS_LIST; i++)
    {
        format(string, sizeof string, "%s%i\t%s\n", string, WEAPONS_LIST[i][E_WEAPON_LISTITEM_MODEL], WEAPONS_LIST[i][E_WEAPON_LISTITEM_NAME]);
    }
    return ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PREVIEW_MODEL, "Skin Selection Dialog", string, "Select", "Cancel");
}

CMD:skins(playerid)
{
    const MAX_SKINS = 312;
    
    new string[MAX_SKINS * 5];
    for (new i; i < MAX_SKINS; i++)
    {
        format(string, sizeof string, "%s%i\n", string, i);
    }
    return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PREVIEW_MODEL, "Skin Selection Dialog", string, "Select", "Cancel");
} 

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if (dialogid == 1)
    {
        if (response)
        {
            GivePlayerWeapon(playerid, WEAPONS_LIST[listitem][E_WEAPON_LISTITEM_WEAPON_ID], 50);
            GameTextForPlayer(playerid, "~g~~h~~h~~h~Weapon Spawned!", 3000, 3);
            return 1;
        }
    }
    if (dialogid == 2)
    {
        if (response)
        {
            SetPlayerSkin(playerid, listitem);
            GameTextForPlayer(playerid, "~g~~h~~h~~h~Skin Changed!", 3000, 3);
            return 1;
        }
    }
    return 1;
} 