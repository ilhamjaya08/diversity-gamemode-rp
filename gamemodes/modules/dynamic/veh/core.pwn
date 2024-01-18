#define MAX_PLAYER_VEHICLES				3
#define MAX_VEHICLE_STORAGE				5
#define MAX_VIP_VEHICLES				5
#define MAX_RENTED_VEHICLES				2
#define MAX_OWNED_VEHICLES				110
#define MAX_DYNAMIC_VEHICLES			1000

#define RETURN_INVALID_VEHICLE_ID		-1

enum
{
	VEHICLE_TYPE_NONE = 0,
	VEHICLE_TYPE_PLAYER,
	VEHICLE_TYPE_FACTION,
	VEHICLE_TYPE_SIDEJOB,
	VEHICLE_TYPE_RENTAL,
	VEHICLE_TYPE_DRIVING_SCHOOL
};

enum
{
	VEHICLE_STATE_NONE = 0,
	VEHICLE_STATE_SPAWNED,
	VEHICLE_STATE_DEAD,
	VEHICLE_STATE_INSURANCE,
	VEHICLE_STATE_IMPOUND,
	VEHICLE_STATE_PARKED,
	VEHICLE_STATE_HOUSEPARKED,
	VEHICLE_STATE_APARTPARKED
};

enum
{
	VEHICLE_SAVE_ALL = 0,
	VEHICLE_SAVE_POSITION,
	VEHICLE_SAVE_COLOR,
	VEHICLE_SAVE_MISC,
	VEHICLE_SAVE_DAMAGES,
	VEHICLE_SAVE_COMPONENT
};

enum
{
	VEHICLE_SIDEJOB_NONE = 0,
	VEHICLE_SIDEJOB_BUS,
	VEHICLE_SIDEJOB_SWEEPER,
	VEHICLE_SIDEJOB_TRASHMASTER,
	VEHICLE_SIDEJOB_MONEYTRANS,
	VEHICLE_SIDEJOB_BOXVILLE
};

enum e_TRUNK_FLAGS
{
	e_TRUNK_NOTHING = 0,
	e_TRUNK_WEAPON,
	e_TRUNK_INVENTORY
};

enum E_VEHICLE_DATA
{
		// Info
		vehIndex,
		vehPlate[32],
		vehModel,
		vehExtraID,

		// World
		vehVirtual,
		vehInterior,
Float:	vehPosX,
Float:	vehPosY,
Float:	vehPosZ,
Float:	vehPosRZ,

		// Color
		vehColor1,
		vehColor2,
		vehPaintjob,

		// Damaged
		vehPanel,
		vehDoor,
		vehLight,
		vehTires,
Float:	vehHealth,

		// Additions
		vehType,
		vehState,
Float:	vehFuel,
Float:	vehLastCoords[3],
	
		// Trunk Storage
		e_TRUNK_FLAGS:vehTrunkType[MAX_VEHICLE_STORAGE],

		// Trunk Storage - Weapon
		vehAmmo[MAX_VEHICLE_STORAGE],
		vehWeapon[MAX_VEHICLE_STORAGE],
		vehDurability[MAX_VEHICLE_STORAGE],
		vehSerial[MAX_VEHICLE_STORAGE],

		// Other
		vehSiren,
		vehMod[MAX_VEHICLE_MOD_SECTIONS],
		vehLumber,
		vehRentTime,
		vehKillerID,
		vehVehicleID,
		vehInsurance,

		// Vehicle Upgrade
		vehEngineUpgrade,
		vehBodyUpgrade,
		Float:vehBodyRepair,
		vehGasUpgrade,
		vehTurbo,

		// Vehicle Component Preview
		vehModSectionPreview,
		vehModCompPreview,

		// Vehicle Neon
		vehNeonL, //Neon kiri
		vehNeonR,  //Neon kanan
		vehNeonColor,
		vehTogNeon,

		//Truck Haul
		vehComponent,
		vehWoods,

		//vehicle Interior ((RV))
		vehInteriorVW,

		vehURL[128],
		vehAudio,

		vehParking,
		vehHouseParking,

		vehDoorStatus,
		vehEngineStatus,

		vehHandBrake,

		vehLockTire,
		Text3D:vehLockTireText,

		// Mileage
		Float:accumulatedMileage, // Mileage yang terakumulasi.
		Float:currentMileage,		  // Mileage saat ini
		Float:durabilityMileage,   // Ketahanan kendaraan di nilai mileage tertentu.
		
		Timer:vehLockTireTimer,
		Timer:vehHandbrakeTimer
		
};

enum E_VEHICLE_STORAGE_DATA {
	vehInvIndex,
    vehInvName[32],
    vehInvModel,
    vehInvQuantity
};

new
	VehicleData[MAX_DYNAMIC_VEHICLES][E_VEHICLE_DATA],
	VehicleStorageData[MAX_DYNAMIC_VEHICLES][MAX_VEHICLE_STORAGE][E_VEHICLE_STORAGE_DATA];

new
	// Iterator:ServerVehicles<MAX_DYNAMIC_VEHICLES>,
	Iterator:OwnedVehicles<MAX_PLAYERS, MAX_DYNAMIC_VEHICLES>,
	Iterator:RentedVehicles<MAX_PLAYERS, MAX_DYNAMIC_VEHICLES>;

new 
	g_selected_vehicle[MAX_PLAYERS][MAX_OWNED_VEHICLES] = {INVALID_VEHICLE_ID, ...},
	g_selected_vehicle_time[MAX_PLAYERS][MAX_OWNED_VEHICLES] = {INVALID_VEHICLE_ID, ...},
	g_selected_vehicle_price[MAX_PLAYERS][MAX_OWNED_VEHICLES] = {INVALID_VEHICLE_ID, ...};
	
new parking_selected_vehicle[MAX_PLAYERS][MAX_OWNED_VEHICLES] = {INVALID_VEHICLE_ID, ...};