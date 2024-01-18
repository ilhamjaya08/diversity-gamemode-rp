#define INVALID_VENDING_ID			-1
#define INVALID_OWNER_ID			-1

#define MAX_DYNAMIC_VENDING			50
#define MAX_OWNABLE_VENDING			2

#define Vending_GetInside(%0)		playerNearVending[%0]
#define Vending_SetInside(%0,%1)	playerNearVending[%0]=%1

#define	VENDING_MACHINE_TYPE_SPRUNK			(1) 
#define	VENDING_MACHINE_TYPE_SNACK			(2)
#define	VENDING_MACHINE_TYPE_COLA			(3)

enum E_VENDING_DATA
{
	vendID,
	
	vendOwner,
	vendOwnerName[128],
	vendName[128],
	vendPrice,

	vendType,
	vendInterior,
	vendWorld,
	Float:vendPosX,
	Float:vendPosY,
	Float:vendPosZ,
	Float:vendPosA,

	vendArea,
	vendObject,

	vendStock,
	vendStockPrice,
	vendVault
};

new
	Iterator:Vending<MAX_DYNAMIC_VENDING>,
	VendingData[MAX_DYNAMIC_VENDING][E_VENDING_DATA];

new
	playerNearVending[MAX_PLAYERS] = {INVALID_VENDING_ID, ...},
	playerUseVending[MAX_PLAYERS]
	;