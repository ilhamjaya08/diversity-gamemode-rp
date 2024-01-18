//Pre-Defined
#define INVALID_FIRE_ID -1
#define MAX_DYNAMIC_FIRE 500
// #define MAX_VEHICLE_FIRE 5
// #define MAX_BUSINESS_FIRE 5
// #define MAX_HOUSE_FIRE 5

//Macros
#define Fire_GetInside(%0)		playerInsideFire[%0]
#define Fire_SetInside(%0,%1)	playerInsideFire[%0]=%1

//Enum
enum E_FIRE
{
    fireID,
    fireObject,
    fireModel,
    fireArea,
    fireInterior,
    fireVirtualWorld,
    Float:fireHealth,

    Float:firePosX,
    Float:firePosY,
    Float:firePosZ
};
new 
    FireData[MAX_DYNAMIC_FIRE][E_FIRE],
    Iterator:Fire<MAX_DYNAMIC_FIRE>;

new
	playerInsideFire[MAX_PLAYERS] = {INVALID_FIRE_ID, ...};