#define MAX_DYNAMIC_RENTAL	10

enum ENUM_RENTAL_DATA
{
		rentIndex,

Float:	rentPosX,
Float:	rentPosY,
Float:	rentPosZ,

Float:	rentSpawnX,
Float:	rentSpawnY,
Float:	rentSpawnZ,
Float:	rentSpawnRZ,

		rentPickup,
Text3D:	rentLabel

};

new
	RentalData[MAX_DYNAMIC_RENTAL][ENUM_RENTAL_DATA];

new
	Iterator:RentalPoints<MAX_DYNAMIC_RENTAL>;

new 
	rental_vehicles_model[MAX_PLAYERS][5],
	rental_vehicles_price[MAX_PLAYERS][5];

