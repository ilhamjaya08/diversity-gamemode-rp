#define MAX_DYNAMIC_CARGO				(100)
#define MAX_CARGO_LOADED				(30)

#define GetPlayerCargoType(%0)			cargo_type{%0}
#define SetPlayerCargoType(%0,%1)		cargo_type{%0}=%1

#define GetPlayerCargoProduct(%0)		cargo_product{%0}
#define SetPlayerCargoProduct(%0,%1)	cargo_product{%0}=%1

enum E_CARGO_DATA {
	cargoID,
	cargoType,
	cargoExpired,
	cargoProduct,

	Float:cargoX,
	Float:cargoY,
	Float:cargoZ,
	Float:cargoA,

	cargoObject,
	Text3D:cargoLabel
};


new 
	Iterator:Cargo<MAX_DYNAMIC_CARGO>,
	CargoData[MAX_DYNAMIC_CARGO][E_CARGO_DATA];

// Player Variable
new
	cargo_product[MAX_PLAYERS] = {0, ...},
	cargo_type[MAX_PLAYERS] = {CARGO_NONE, ...},
	cargo_listed[MAX_PLAYERS][MAX_CARGO_LOADED] = {0, ...};