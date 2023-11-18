Anim_IsExists(playerid, slot)
{
    if(AnimData[playerid][slot][AnimExists]) 
        return 1;

    return 0;
}

forward LoadPlayerAnimation(playerid);
public LoadPlayerAnimation(playerid)
{
	static
		rows,
		fields
	;

	cache_get_data(rows, fields);

	for (new i = 0; i != rows; i ++) 
	{
        new 
            slot = cache_get_field_int(i, "slot")
        ;
		
        AnimData[playerid][slot][AnimExists] = true;
		cache_get_field_content(i, "animlib", AnimData[playerid][slot][AnimLib]);
		cache_get_field_content(i, "animname", AnimData[playerid][slot][AnimName]);
	}
	return 1;
}


Anim_Save(playerid, slot)
{
    if(Anim_IsExists(playerid, slot))
    {
        new string[1024];
        format(string, sizeof(string), "UPDATE `player_animation` SET `animlib` = '%s', `animname` = '%s' WHERE `playerid` = '%d' AND `slot` = '%d'", 
            SQL_ReturnEscaped(AnimData[playerid][slot][AnimLib]),
            SQL_ReturnEscaped(AnimData[playerid][slot][AnimName]),
            GetPlayerSQLID(playerid),
            slot
        );
        return mysql_tquery(g_iHandle, string);
    }
    return 0;
}

Anim_Insert(playerid, slot)
{
    new query[1024];
    format(query, sizeof(query), "INSERT INTO `player_animation` (`slot`, `playerid`, `animlib`, `animname`) VALUES ('%d','%d','%s','%s')", 
        slot, 
        GetPlayerSQLID(playerid), 
        SQL_ReturnEscaped(AnimData[playerid][slot][AnimLib]), 
        SQL_ReturnEscaped(AnimData[playerid][slot][AnimName])
    );
    mysql_tquery(g_iHandle, query);
    return 1;
}