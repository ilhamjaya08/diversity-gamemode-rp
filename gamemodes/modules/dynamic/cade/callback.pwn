#include <YSI\y_hooks>

hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(response == EDIT_RESPONSE_FINAL)
    {
        switch(PlayerData[playerid][pEditingMode])
        {
            case ROADBLOCK:
            {
                new index = PlayerData[playerid][pEditRoadblock];
                BarricadeData[index][cadePos][0] = x;
                BarricadeData[index][cadePos][1] = y;
                BarricadeData[index][cadePos][2] = z;
                BarricadeData[index][cadePos][3] = rx;
                BarricadeData[index][cadePos][4] = ry;
                BarricadeData[index][cadePos][5] = rz;
                Barricade_Sync(index);
                PlayerData[playerid][pEditRoadblock] = -1;
            }
        }
    }
    if(response == EDIT_RESPONSE_CANCEL)
    {
        ResetEditing(playerid);
    }
    return 1;
}