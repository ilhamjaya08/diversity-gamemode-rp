#define MAX_DAMAGE                      (55)
#define TOTAL_BODY_STATUS				(7)

enum damageData {
    damageID,
    damageExists,
    damageBodypart,
    damageWeapon,
    Float:damageAmount,
	Float:damageKevlar,
    damageTime
};

new DamageData[MAX_PLAYERS][MAX_DAMAGE][damageData];
new damageList[MAX_PLAYERS][10][128];