#define MAX_PET 1000

#define PET_NONE    (0)
#define PET_FOLLOW  (1)
#define PET_SIT     (2)
#define PET_STAY    (3)
#define PET_LAY     (4)
#define PET_JUMP    (5)

enum E_PLAYER_PET
{
    petModelID,
    petName[128],
    petModel,
    petStatus,
    Text3D:petText,
    bool:petSpawn,
    bool:petIdle,
    Float:posX,
    Float:posY,
    Float:posZ,
    Float:idle_posX,
    Float:idle_posY,
    Float:idle_posZ,
    Timer:petTimer
}

new PetData[MAX_PLAYERS][E_PLAYER_PET];