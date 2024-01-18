#define MAX_DYNAMIC_PLANTS 						300

#define INVALID_PLANT_ID 						-1	// id tidak valid tanaman
#define PLANT_HARVEST_WAITING 					5	// waktu menunggu dapat saat panen (detik)
#define PLANT_HARVEST_AMOUNT 					5	// jumlah narkoba yang didapat
#define PLANT_HARVEST_TIME 						10	// waktu untuk bisa panen
#define PLANT_SEEDS_AMOUNT 						25	// jumlah bibit yang dibutuhkan


#define GetPlayerNearestPlant(%0)				playerInsidePlant[%0]
#define SetPlayerNearestPlant(%0,%1)			playerInsidePlant[%0]=%1

#define GetPlayerHarvestingPlant(%0)			playerHarvestingPlant[%0]
#define SetPlayerHarvestingPlant(%0,%1)			playerHarvestingPlant[%0]=%1

#define GetPlayerHarvestingType(%0)				playerHarvestingPlantType[%0]
#define SetPlayerHarvestingType(%0,%1)			playerHarvestingPlantType[%0]=%1

#define GetPlayerHarvestingTime(%0)				playerHarvestingPlantTime[%0]
#define SetPlayerHarvestingTime(%0,%1)			playerHarvestingPlantTime[%0]=%1


enum
{
	e_PLANT_NONE = 0,
	e_PLANT_WEED,
	e_PLANT_COCAINE,
	e_PLANT_HEROIN
};

enum E_PLANT_DATA
{
    plantID,
   	plantType,
    plantTime,

    plantHarvest,
    plantExpired,

    Float:plantPos[4],

    plantArea,
    plantObject
};

new
	Iterator:Plants<MAX_DYNAMIC_PLANTS>,
	PlantData[MAX_DYNAMIC_PLANTS][E_PLANT_DATA];

new
	bool:playerHarvestingPlant[MAX_PLAYERS] = {false, ...},
	playerInsidePlant[MAX_PLAYERS] = {INVALID_PLANT_ID, ...},
	playerHarvestingPlantType[MAX_PLAYERS] = {e_PLANT_NONE, ...},
	playerHarvestingPlantTime[MAX_PLAYERS] = {0, ...};