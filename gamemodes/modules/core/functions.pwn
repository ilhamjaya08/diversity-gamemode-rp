/*	Function List */

abs(number)
{
    return (number < 0 ? (-1 * number) : number);
}

SendClientErrorMessage(playerid, const fmat[], {Float, _}:...)
{
    new
        str[145];

    format(str, sizeof(str), "ERROR: %s", fmat);
    va_format(str, sizeof(str), str, va_start<2>);
    return SendClientMessage(playerid, X11_GREY_80, str);
}

SendClientSyntaxMessage(playerid, const fmat[], {Float, _}:...)
{
    new
        str[145];

    format(str, sizeof(str), "USAGE: %s", fmat);
    va_format(str, sizeof(str), str, va_start<2>);
    return SendClientMessage(playerid, X11_GREY_80, str);
}

SendClientServerMessage(playerid, const fmat[], {Float, _}:...)
{
    new
        str[145];

    format(str, sizeof(str), "SERVER: "WHITE"%s", fmat);
    va_format(str, sizeof(str), str, va_start<2>);
    return SendClientMessage(playerid, X11_GREY_80, str);
}

stock GetVehicleNeedFlip(vehicleid)//return 1 if need, 0 if not
{
    new Float:Quat[2];
    GetVehicleRotationQuat(vehicleid, Quat[0], Quat[1], Quat[0], Quat[0]);
    return (Quat[1] >= 0.60 || Quat[1] <= -0.60);
}

SendPlayerPos(playerid, Float:x, Float:y, Float:z, Float:angle, int = 0, vw = 0)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
    else SetPlayerPos(playerid, x, y, z);

    SetPlayerFacingAngle(playerid, angle);
    SetPlayerInterior(playerid, int);
    SetPlayerVirtualWorld(playerid, vw);

    SetCameraBehindPlayer(playerid);
	return 1;
}

Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    x1 -= x2;
    y1 -= y2;
    z1 -= z2;
    return floatsqroot((x1 * x1) + (y1 * y1) + (z1 * z1));
}

stock IsLeapYear(year)
{
	if(year % 4 == 0) return true;
	else return false;
}

stock TimestampToDate(Timestamp, &year, &month, &day, &hour, &minute, &second, HourGMT = 0, MinuteGMT = 0)
{
	new tmp = 2;
	year = 1970;
	month = 1;
	Timestamp -= 172800; // Delete two days from the current timestamp. This is necessary, because the timestamp retrieved using gettime() includes two too many days.
	for(;;)
	{
		if(Timestamp >= 31536000)
		{
			year ++;
			Timestamp -= 31536000;
			tmp ++;
			if(tmp == 4)
			{
				if(Timestamp >= 31622400)
				{
					tmp = 0;
					year ++;
					Timestamp -= 31622400;
				}
				else break;
			}
		}
		else break;
	}
	for(new i = 0; i < 12; i ++)
	{
		if(Timestamp >= MonthTimes[i][2 + IsLeapYear(year)])
		{
			month ++;
			Timestamp -= MonthTimes[i][2 + IsLeapYear(year)];
		}
		else break;
	}
	day = 1 + (Timestamp / 86400);
	Timestamp %= 86400;
	hour = HourGMT + (Timestamp / 3600);
	Timestamp %= 3600;
	minute = MinuteGMT + (Timestamp / 60);
	second = (Timestamp % 60);
	if(minute > 59)
	{
		minute = 0;
		hour ++;
		if(hour > 23)
		{
			hour -= 24;
			day ++;
			if(day > MonthTimes[month][IsLeapYear(year)])
			{
				day = 1;
				month ++;
				if(month > 12)
				{
					month = 1;
					year ++;
				}
			}
		}
	}
	return true;
}

ConvertHBEColor(value, bool:phone = false) 
{
    if(!phone)
    {
        new color;
        if(value >= 90 && value <= 100) color = 0x15a014FF;
        else if(value >= 80 && value < 90) color = 0x1b9913FF;
        else if(value >= 70 && value < 80) color = 0x1a7f08FF;
        else if(value >= 60 && value < 70) color = 0x326305FF;
        else if(value >= 50 && value < 60) color = 0x375d04FF;
        else if(value >= 40 && value < 50) color = 0x603304FF;
        else if(value >= 30 && value < 40) color = 0xd72800FF;
        else if(value >= 10 && value < 30) color = 0xfb3508FF;
        else if(value >= 0 && value < 10) color = 0xFF0000FF;
        else color = X11_WHITE;
        return color;
    }
    else
    {
        new color;
        if(value >= 90 && value <= 100) color = 0xFFFFFFFF;
        else if(value >= 80 && value < 90) color = 0xFFFFFFFF; //Tandaincolor
        else if(value >= 70 && value < 80) color = 0xFFFFFFFF;
        else if(value >= 60 && value < 70) color = 0xFFFFFFFF;
        else if(value >= 50 && value < 60) color = 0xFFFFFFFF;
        else if(value >= 40 && value < 50) color = 0x603304FF;
        else if(value >= 30 && value < 40) color = 0xfb3508FF;
        else if(value >= 10 && value < 30) color = 0xfb3508FF;
        else if(value >= 0 && value < 10) color = 0xFF0000FF;
        else color = X11_WHITE;
        return color;        
    }
}

stock GetMonthName(Month)
{
	new month[12];

	switch(Month)
	{
        case 1: month = "January";
        case 2: month = "February";
        case 3: month = "March";
        case 4: month = "April";
        case 5: month = "May";
        case 6: month = "June";
        case 7: month = "July";
        case 8: month = "August";
        case 9: month = "September";
        case 10: month = "October";
        case 11: month = "November";
        case 12: month = "December";
	}

	return month;
}

stock GetShortMonthName(Month)
{
	new MonthName[12];

	switch(Month)
	{
		case 1: MonthName = "Jan";
		case 2: MonthName = "Feb";
		case 3: MonthName = "Mar";
		case 4: MonthName = "Apr";
		case 5: MonthName = "May";
		case 6: MonthName = "Jun";
		case 7: MonthName = "Jul";
		case 8: MonthName = "Aug";
		case 9: MonthName = "Sep";
		case 10: MonthName = "Oct";
		case 11: MonthName = "Nov";
		case 12: MonthName = "Dec";
	}
	return MonthName;
}

stock GetDay(Day)
{
	new str[12];
	switch(Day)
	{
		case 1: str = "1";
		case 2: str = "2";
		case 3: str = "3";
		case 4: str = "4";
		case 5: str = "5";
		case 6: str = "6";
		case 7: str = "7";
		case 8: str = "8";
		case 9: str = "9";
		case 10: str = "10";
		case 11: str = "11";
		case 12: str = "12";
		case 13: str = "13";
		case 14: str = "14";
		case 15: str = "15";
		case 16: str = "16";
		case 17: str = "17";
		case 18: str = "18";
		case 19: str = "19";
		case 20: str = "20";
		case 21: str = "21";
		case 22: str = "22";
		case 23: str = "23";
		case 24: str = "24";
		case 25: str = "25";
		case 26: str = "26";
		case 27: str = "27";
		case 28: str = "28";
		case 29: str = "29";
		case 30: str = "30";
		case 31: str = "31";
	}
	return str;
}

stock GetWeekDay(day=0, month=0, year=0)
{
	if(!day)
			getdate(year, month, day);
	new
		szWeekDay[17],
		j,
		e;

	if(month <= 2)
	{
		month += 12;
		--year;
	}

	j = year % 100;
	e = year / 100;

	switch((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7)
	{
		case 0: szWeekDay = "Sat";
		case 1: szWeekDay = "Sun";
		case 2: szWeekDay = "Mon";
		case 3: szWeekDay = "Tue";
		case 4: szWeekDay = "Wed";
		case 5: szWeekDay = "Thu";
		case 6: szWeekDay = "Fri";
	}
	return szWeekDay;
}

stock UnixDate(timestamp)
{
	new dateString[50];

	new date[6];
	TimestampToDate(timestamp, date[2], date[1], date[0], date[3], date[4], date[5]);
	format(dateString, sizeof(dateString), "%s %s %s %i, %02d:%02d:%02d", GetWeekDay(date[0], date[1], date[2]), GetDay(date[0]), GetShortMonthName(date[1]), date[2], date[3], date[4], date[5]);
	return dateString;
}

UpdateCharacterInt(playerid, const column_name[], value)
{
	mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `%s` = '%d' WHERE `ID` = '%d';", column_name, value, GetPlayerSQLID(playerid)));
	return 1;
}

stock UpdateCharacterFloat(playerid, const column_name[], Float:value) 
{
	mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `%s` = '%.4f' WHERE `ID`='%d';", column_name, value, GetPlayerSQLID(playerid)));
	return 1;
}

UpdateCharacterString(playerid, const column_name[], value[]) 
{
	mysql_tquery(g_iHandle, sprintf("UPDATE `characters` SET `%s` = '%s' WHERE `ID`='%d';", column_name, SQL_ReturnEscaped(value), GetPlayerSQLID(playerid)));
	return 1;
}

GetEngineStatus(vehicleid)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(engine != 1)
        return 0;

    return 1;
}

GetHoodStatus(vehicleid)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(bonnet != 1)
        return 0;

    return 1;
}

GetTrunkStatus(vehicleid)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(boot != 1)
        return 0;

    return 1;
}

stock GetAlarmStatus(vehicleid)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(alarm != 1)
        return 0;

    return 1;
}

GetDoorStatus(vehicleid)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(doors != 1)
        return 0;

    return 1;
}

GetLightStatus(vehicleid)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if(lights != 1)
        return 0;

    return 1;
}

SetEngineStatus(vehicleid, status)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    return SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
}

SetLightStatus(vehicleid, status)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}

SetTrunkStatus(vehicleid, status)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, status, objective);
}

SetHoodStatus(vehicleid, status)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}

SetDoorStatus(vehicleid, status)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    return SetVehicleParamsEx(vehicleid, engine, lights, alarm, status, bonnet, boot, objective);
}

stock SetAlarmStatus(vehicleid, status)
{
    static engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    return SetVehicleParamsEx(vehicleid, engine, lights, status, doors, bonnet, boot, objective);
}

stock IsPoweredVehicle(vehicleid)
{
    new
        model = GetVehicleModel(vehicleid);

    if (400 <= model <= 611)
    {
        static const g_EngineInfo[] = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,
            1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
        };

        return g_EngineInfo[model - 400];
    }
    return 0;
}

GetPlayerAnimation(playerid, animlib[], animname[])
{
    static
        l_animlib[32],
        l_animname[32];

    GetAnimationName(GetPlayerAnimationIndex(playerid),l_animlib,32,l_animname,32);
    
    if (strcmp(animlib, l_animlib, true) == 0 && strcmp(animname, l_animname, true) == 0)
        return true;

    return false;
}
stock Float:cache_get_field_float(row, const field_name[]);

//Global Function Server Side Health
Float:GetHealth(playerid)
{
    return PlayerData[playerid][pHealth]; 
}
Float:GetArmour(playerid)
{
    return PlayerData[playerid][pArmorStatus]; 
}

Player_IsFactionSalaryExceeded(playerid)
{
    if (Economy_GetMaxFactSalaryWeekly() == 0)
    {
        return 0;
    }

    return (PlayerData[playerid][pFactionSalaryCollected] >= Economy_GetMaxFactSalaryWeekly() ? 1 : 0);
}