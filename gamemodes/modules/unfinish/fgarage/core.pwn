#define MAX_FACTION_GARAGE  10

enum E_FACTION_GARAGE {
    garageid,
    factionid,
    Float:garagePos[3],
    Float:spawnPos[3],
    vehicleModel[10]
}

new FactionGarage[MAX_FACTION_GARAGE][E_FACTION_GARAGE];