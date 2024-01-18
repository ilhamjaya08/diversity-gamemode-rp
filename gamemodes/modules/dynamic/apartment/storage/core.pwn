#define MAX_APARTMENT_STORAGE           (10)

//Enumurator / Struktur Data untuk storage apartemen
enum APARTMENT_STORAGE
{
    apartmentItemID,
    apartmentItemExists,
    apartmentItemName[32],
    apartmentItemModel,
    apartmentItemQuantity
};
new ApartmentStorage[MAX_DYNAMIC_APARTMENT_ROOM][MAX_APARTMENT_STORAGE][APARTMENT_STORAGE];