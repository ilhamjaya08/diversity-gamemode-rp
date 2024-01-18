#define INVALID_APARTMENT_ROOM		-1
#define INVALID_ROOM_OWNER			-1

#define MAX_PLAYER_APARTMENT		2

#define MAX_DYNAMIC_APARTMENT_ROOM 	1000

enum E_APARTMENTROOM_DATA
{
	apartmentID,
	apartmentRoomID,

	apartmentRoomOwner,
	apartmentRoomOwnerName[128],
	apartmentRoomName[128],
	apartmentRoomPrice,

	apartmentRoomInterior,
	apartmentRoomWorld,
	Float:apartmentRoomExteriorPosX,
	Float:apartmentRoomExteriorPosY,
	Float:apartmentRoomExteriorPosZ,
	Float:apartmentRoomExteriorPosA,

	Float:apartmentRoomInteriorPosX,
	Float:apartmentRoomInteriorPosY,
	Float:apartmentRoomInteriorPosZ,
	Float:apartmentRoomInteriorPosA,

	Text3D:apartmentRoomText,
	apartmentRoomPickup,
	apartmentRoomLock
};

new	Iterator:ApartmentRoom<MAX_DYNAMIC_APARTMENT_ROOM>,
	ApartmentRoomData[MAX_DYNAMIC_APARTMENT_ROOM][E_APARTMENTROOM_DATA];
