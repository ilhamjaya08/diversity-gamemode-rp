#define MAX_DYNAMIC_BARRICADES	100


new const gRoadblockModels[] = 
{
    19975, 	19972, 	19966, 	1459, 	978,     981, 	
    1238, 	1425,	3265,	3091,   1422,    19970, 	
    19971, 	1237,   1423,	983, 	 1251,   19953,
    19954,  19974, 	19834, 1428, 1437
};


enum E_BARRICADE_DATA
{
    cadeType,
    cadeModel,

    cadeText[225],
    Float:cadePos[6],

    cadeArea,
    cadeObject
};

new
	Iterator:Barricade<MAX_DYNAMIC_BARRICADES>,
	BarricadeData[MAX_DYNAMIC_BARRICADES][E_BARRICADE_DATA];
