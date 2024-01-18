#include <YSI\y_hooks>

hook OnVehicleDeath(vehicleid, killerid)
{
    new vehicle_index;
    if((vehicle_index = Vehicle_ReturnID(vehicleid)) != -1)
    {
        if(Vehicle_GetType(vehicle_index) == VEHICLE_TYPE_FACTION)
        {
            for(new i = 0; i < MAX_GUNRACK_SLOT; i++)
            {
                Vehicle_ResetGunrack(vehicle_index, i);
            }
        }
    }
}