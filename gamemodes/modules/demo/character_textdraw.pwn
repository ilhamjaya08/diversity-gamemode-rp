#include <YSI\y_hooks>

new SelectCharTD[MAX_PLAYERS];

hook OnGameModeInit()
{
    CreateActor(5, 1641.7559,-2326.6182,13.5469,258.7923);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    SelectCharTD[playerid] = 0;
    return 1;
}

stock RefrestCharacterListTextDraw(playerid, num)
{
    if(CharacterList[playerid][num][0] != EOS) {
        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_character][5], "Spawn_Character");
        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_character][2], sprintf("%s", CharacterList[playerid][num]));
    }
    else{
        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_character][5], "Create_Character");
        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_character][2], "Empty_Slow");
    }
    return 1;
}
