#define MAX_FARM_PLANT 500
#define MAX_PLAYER_PLANT 5
#define INVALID_FARM_PLANT -1

enum E_FARMER_DATA
{
    Float:plantPercentage,
    plantOwner,
    plantOwnerName[128],
    plantTime,
    plantObject,
    Float:plantPosX,
    Float:plantPosY,
    Float:plantPosZ,
    Text3D:plantText
}
new FarmerData[MAX_FARM_PLANT][E_FARMER_DATA];

new
	Iterator:FarmPlant<MAX_FARM_PLANT>;

new 
    bool:Player_IsFarming[MAX_PLAYERS] = {false, ...},
    Player_PlantCount[MAX_PLAYERS] = {0, ...},
    Plant_TimerCount[MAX_PLAYERS] = {0, ...}
;
