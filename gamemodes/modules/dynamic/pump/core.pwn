#define MAX_DYNAMIC_PUMPS	(100)

#define Pump_BusinessID(%0)	PumpData[%0][pumpBusiness]

enum E_PUMP_DATA
{
    pumpID,
    pumpBusiness,
    Float:pumpPos[4],
    pumpFuel,

    pumpObject,
    Text3D:pumpText3D
};

new
	PumpData[MAX_DYNAMIC_PUMPS][E_PUMP_DATA],
	Iterator:GasPump<MAX_DYNAMIC_PUMPS>;
