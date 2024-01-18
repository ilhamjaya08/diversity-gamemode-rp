#define MAX_DYNAMIC_MARKETPLACE		20

#define Marketplace_GetPrice(%0)	MarketplaceData[%0][marketPrice]
#define Marketplace_GetType(%0)		MarketplaceData[%0][marketType]
#define Marketplace_GetProduct(%0)	MarketplaceData[%0][marketProduct]

enum E_MARKETPLACE_DATA
{
	marketID,
	marketType,
	marketPrice,
	marketProduct,

	Float:marketPos[3],

	marketPickup,
	Text3D:marketLabel
};

new Iterator:Marketplace<MAX_DYNAMIC_MARKETPLACE>,
	MarketplaceData[MAX_DYNAMIC_MARKETPLACE][E_MARKETPLACE_DATA];
