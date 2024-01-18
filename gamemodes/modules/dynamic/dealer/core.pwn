#define 	MAX_DYNAMIC_DEALERSHIP	20

enum
{
	DEALER_SAVE_ALL = 0,
	DEALER_SAVE_POS,
	DEALER_SAVE_SPAWN,
	DEALER_SAVE_NAME,
	DEALER_SAVE_STOCK,
	DEALER_SAVE_LOCK
};

enum E_DEALERSHIP_DATA
{
	dealerID,
	bool:dealerLock,
	dealerStock,
	
	dealerName[24],

	Float:dealerPos[3],
	Float:dealerSpawn[4],

	dealerPickup,
	dealerMapIcon,
	Text3D:dealerLabel
};

new
	Iterator:Dealership<MAX_DYNAMIC_DEALERSHIP>,
	DealershipData[MAX_DYNAMIC_DEALERSHIP][E_DEALERSHIP_DATA];


new
	gListedDealerVehiclePrice[MAX_PLAYERS][10];