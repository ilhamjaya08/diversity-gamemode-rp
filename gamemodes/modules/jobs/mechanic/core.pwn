

#define ENGINE_EXP			(25)
#define BODY_EXP 				(20)
#define TIRE_EXP 				(25)
#define HYDRAULIC_EXP		(25)
#define COLOR_EXP 			(25)
#define PAINTJOB_EXP 		(25)
#define UPGRADE_EXP			(25)
#define MODIF_EXP				(25)
#define MAINTENANCE_EXP	(20)


// ========================[ DEFINED ]========================
#define GetMechanicLevel(%0)		PlayerData[%0][pMechanicLevel]
#define SetMechanicLevel(%0,%1)		PlayerData[%0][pMechanicLevel]=%1

#define GetMechanicEXP(%0)			PlayerData[%0][pMechanicEXP]
#define SetMechanicEXP(%0,%1)		PlayerData[%0][pMechanicEXP]=%1

#define IsRepairingVehicle(%0)		GetPVarInt(%0, "MechanicStart")
#define SetRepairingVehicle(%0,%1)	SetPVarInt(%0, "MechanicStart", %1)

#define SetRepairTime(%0,%1)		SetPVarInt(%0, "MechanicTime", %1)
#define GetRepairTime(%0)			GetPVarInt(%0, "MechanicTime")

#define SetRepairType(%0,%1)		SetPVarInt(%0, "MechanicType", %1)
#define GetRepairType(%0)			GetPVarInt(%0, "MechanicType")

#define SetRepairVehicle(%0,%1)		SetPVarInt(%0, "MechanicVehicle", %1)
#define GetRepairVehicle(%0)		GetPVarInt(%0, "MechanicVehicle")

#define SetRepairComponent(%0,%1)	SetPVarInt(%0, "MechanicComponent", %1)
#define GetRepairComponent(%0)		GetPVarInt(%0, "MechanicComponent")

#define MECH_MENU_CHANGE_COLOR						(1)
#define MECH_MENU_REPAIR_TIRE							(2)
#define MECH_MENU_REPAIR_BODY							(4)
#define MECH_MENU_HALF_REPAIR_ENGINE			(8)
#define MECH_MENU_REPAIR_ENGINE						(16)
#define MECH_MENU_CHANGE_PAINTJOB					(32)
#define MECH_MENU_INSTALL_HYDRAULICS			(64)
#define MECH_MENU_CHANGE_WHEELS						(128)
#define MECH_MENU_UPGRADE									(256)
#define MECH_MENU_MODIF										(512)
#define MECH_MENU_UNINSTALL_MODIF					(1024)
#define MECH_MENU_NEON										(2048)
#define MECH_MENU_TURBO										(4096)
#define MECH_MENU_INTERIM_MT							(8192)
#define MECH_MENU_FULL_MT									(16384)
#define MECH_MENU_ADD_IMMOBILIZER					(32768)

#define MECH_MENU_ID_CHANGE_COLOR					(1)
#define MECH_MENU_ID_REPAIR_TIRE					(2)
#define MECH_MENU_ID_REPAIR_BODY					(3)
#define MECH_MENU_ID_HALF_REPAIR_ENGINE		(4)
#define MECH_MENU_ID_REPAIR_ENGINE				(5)
#define MECH_MENU_ID_CHANGE_PAINTJOB			(6)
#define MECH_MENU_ID_INSTALL_HYDRAULICS		(7)
#define MECH_MENU_ID_CHANGE_WHEELS				(8)
#define MECH_MENU_ID_UPGRADE							(9)
#define MECH_MENU_ID_MODIF								(10)
#define MECH_MENU_ID_UNINSTALL_MODIF			(11)
#define MECH_MENU_ID_NEON									(12)
#define MECH_MENU_ID_TURBO								(13)
#define MECH_MENU_ID_INTERIM_MT						(14)
#define MECH_MENU_ID_FULL_MT							(15)
#define MECH_MENU_ID_ADD_IMMOBILIZER			(16)

// ========================[ ENUMS ]========================
enum
{
	REPAIR_NONE = 0,
	REPAIR_TIRE,
	REPAIR_BODY,
	REPAIR_COLOR,
	REPAIR_ENGINE,
	REPAIR_PAINTJOB,
	REPAIR_HYDRAULIC,
	REPAIR_WHEELS,
	REPAIR_ENGUPGRADE,
	REPAIR_BODYUPGRADE,
	REPAIR_GASUPGRADE,
	REPAIR_MODIF,
	REPAIR_UNINSTALL_MOD,
	REPAIR_NEON,
	REPAIR_TURBO,
	REPAIR_INTERIM_MT,
	REPAIR_FULL_MT,
	REPAIR_ADD_IMMOBILIZER
};

enum E_MECHANIC_SERVICE
{
	MECH_SERVICE_NONE,
	MECH_SERVICE_CHANGE_COLOR,
	MECH_SERVICE_REPAIR_TIRE,
	MECH_SERVICE_REPAIR_BODY,
	MECH_SERVICE_HALF_REPAIR_ENGINE,
	MECH_SERVICE_REPAIR_ENGINE,
	MECH_SERVICE_CHANGE_PAINTJOB,
	MECH_SERVICE_INSTALL_HYDRAULICS,
	MECH_SERVICE_CHANGE_WHEELS,
	MECH_SERVICE_UPGRADE,
	MECH_SERVICE_MODIF,
	MECH_SERVICE_UNINSTALL_MODIF,
	MECH_SERVICE_NEON,
	MECH_SERVICE_TURBO,
	MECH_SERVICE_INTERIM_MT,
	MECH_SERVICE_FULL_MT,
	MECH_SERVICE_ADD_IMMOBILIZER
};

enum E_COMPONENT_USED
{
	repair_color,
	repair_tire,
	repair_body,
	repair_engine,
	repair_paintjob,
	repair_hydraulics,
	repair_wheels,
	upgrade,
	modif,
	uninstall_modif,
	neon,
	turbo,
	interim_mt,
	full_mt,
	add_immobilizer
};

// ========================[ VARIABLES ]========================

new
	g_PlayerRepairRequirement[MAX_PLAYERS + 1][E_MECHANIC_SERVICE]
;

new const componentUsed[][E_COMPONENT_USED] =
{
	// Penggunaan komponent
	{	50, 40, 100, 25,   0,   0,   0,   0,   0,  1,	 0,     0,	4,  5,  10 },
	{	40, 40,  80, 20, 250,   0,   0,   0,   0,  1,	 0,     0,	3,  4,  10 },
	{	30, 30,  60, 15, 200, 150, 150, 150, 300,  1,  300,  7000,  2,  3,  10 },
	{	20, 30,  50, 10, 150, 100, 100, 125, 250,  1,  200,	 5000,  1,  2,  10 }
};
