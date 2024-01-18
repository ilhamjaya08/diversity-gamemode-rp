#define MAX_CLOTHES_WARDROBE 		(3)
#define MAX_ACCESORIES_WARDROBE 	(3)
#define INVALID_SKIN_ID				(-1)
#define INVALID_MODEL_ID			(0)


enum E_CLOTHES_WARDROBE
{
	clothesID,
	clothesExists,
	clothesName[32],
	clothesModel
};

enum E_ACCESORIES_WARDROBE
{
	accID,
	accExists,
	accName[32],
	accModel
};

new ClothesData[MAX_HOUSES][MAX_CLOTHES_WARDROBE][E_CLOTHES_WARDROBE];

new AccesoriesData[MAX_HOUSES][MAX_ACCESORIES_WARDROBE][E_ACCESORIES_WARDROBE];