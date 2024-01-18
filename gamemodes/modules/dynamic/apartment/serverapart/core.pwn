#define INVALID_APARTMENT_ID		-1

#define MAX_DYNAMIC_APARTMENT		10

#define MAX_APARTMENT_ROOM			20

enum E_APARTMENT_DATA
{
	apartmentID,
	apartmentName[128],
	apartmentType,
	
	//Exterior
	apartmentExteriorInt,
	apartmentExteriorWorld,
	Float:apartmentExteriorPosX,
	Float:apartmentExteriorPosY,
	Float:apartmentExteriorPosZ,
	Float:apartmentExteriorPosA,

	//Interior
	apartmentInteriorInt,
	apartmentInteriorWorld,
	Float:apartmentInteriorPosX,
	Float:apartmentInteriorPosY,
	Float:apartmentInteriorPosZ,
	Float:apartmentInteriorPosA,

	//Parking
	Float:apartmentParkingPosX,
	Float:apartmentParkingPosY,
	Float:apartmentParkingPosZ,
	Float:apartmentParkingPosA,

	Text3D:apartmentExteriorText,
	apartmentExteriorCheckpoint,
	apartmentExteriorPickup,

	Text3D:apartmentExteriorTextParking,
	apartmentExteriorPickupParking
};


enum
{
	APARTMENT_TYPE_NONE = 0,
	APARTMENT_TYPE_MODERN,
	APARTMENT_TYPE_LUXURY,
	APARTMENT_TYPE_PENTHOUSE
}

new
	Iterator:Apartment<MAX_DYNAMIC_APARTMENT>,
	ApartmentData[MAX_DYNAMIC_APARTMENT][E_APARTMENT_DATA];
