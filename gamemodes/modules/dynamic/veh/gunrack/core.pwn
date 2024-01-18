#define MAX_GUNRACK_SLOT 5

enum E_GUN_RACK
{
	weaponModel,
	weaponAmmo,
	weaponExists
};

new GunrackData[MAX_DYNAMIC_VEHICLES][E_GUN_RACK][MAX_GUNRACK_SLOT];