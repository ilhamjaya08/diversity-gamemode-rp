#include <YSI\y_hooks>

task Animal_FeatureUpdate[1000]()
{
	foreach(new i : Animals) if(AnimalData[i][animalTime]) {
		AnimalData[i][animalTime]--;

		if(!AnimalData[i][animalTime]) {
			Animal_Sync(i);
		}
	}
}

hook OnPlayerShootDynObj(playerid, weaponid, objectid, Float:x, Float:y, Float:z)
{
    new animalid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID);
    if(0 <= animalid < MAX_DYNAMIC_ANIMAL)
    {
        if(GetWeapon(playerid) >= 22 && AnimalData[animalid][animalObject] == objectid && !AnimalData[animalid][animalGut])
        {
            if(AnimalData[animalid][animalHealth] > 0) 
            {
                AnimalData[animalid][animalHealth] -= 50;
            }
            else if(AnimalData[animalid][animalHealth] <= 0)
            {
                AnimalData[animalid][animalHealth] = 0;
                if(AnimalData[animalid][animalModel] == ANIMAL_COW)
                {
                    MoveDynamicObject(AnimalData[animalid][animalObject], AnimalData[animalid][animalPos][0], AnimalData[animalid][animalPos][1], AnimalData[animalid][animalPos][2] - 1.0, 0.025, AnimalData[animalid][animalRot][0], AnimalData[animalid][animalRot][1] - 80.0, RandomFloat(0.0,360.0) + AnimalData[animalid][animalRot][2]);
                }
                else
                {
                    MoveDynamicObject(AnimalData[animalid][animalObject], AnimalData[animalid][animalPos][0], AnimalData[animalid][animalPos][1], AnimalData[animalid][animalPos][2] - 1.0, 0.025, AnimalData[animalid][animalRot][0] - 80.0, AnimalData[animalid][animalRot][1], RandomFloat(0.0,360.0) + AnimalData[animalid][animalRot][2]);
                }
                AnimalData[animalid][animalGut]      = true;
                Animal_Save(animalid, SAVE_HUNTING_GUTTING);
            }
        }
    }
}