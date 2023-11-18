/*	Dropped Weapon	*/

enum E_GUN_DROP {
	gun_sql,
	gun_dropped[MAX_PLAYER_NAME],
	gun_model,
	gun_ammo,
	gun_time,
	gun_durability
};

new DroppedGuns[MAX_GUN_DROPPED][E_GUN_DROP],
	Iterator:Dropped<MAX_GUN_DROPPED>;

Drop_Gun(playerid, weaponid, ammo, durability)
{
	static
		i
	;
	if((i = Iter_Free(Dropped)) != -1)
	{
		DroppedGuns[i][gun_dropped][0] 	= EOS;
		DroppedGuns[i][gun_model] 		= weaponid;
		DroppedGuns[i][gun_ammo] 		= ammo;
		DroppedGuns[i][gun_time] 		= gettime();
		DroppedGuns[i][gun_durability] 	= durability;

		strcat(DroppedGuns[i][gun_dropped], NormalName(playerid), MAX_PLAYER_NAME);

		
		return i;
	}
	return -1;
}