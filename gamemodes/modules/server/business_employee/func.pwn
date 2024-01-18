#define MAX_BUSINESS_EMPLOYEE (3)

Business_IsEmployee(playerid, bizid) 
{
    new str[128], Cache: cache;
    format(str, sizeof(str), "SELECT * FROM `business_employe` WHERE `Name`='%s' AND `Business`='%d'", NormalName(playerid), BusinessData[bizid][bizID]);
    cache = mysql_query(g_iHandle, str);
    new result = cache_num_rows();
    cache_delete(cache);
    return result;
}

Business_ResetHours(bizid)
{
    new str[255];
    format(str, sizeof(str), "UPDATE `business_employe` SET `DutyHour`='0' WHERE `Business` = '%d'", BusinessData[bizid][bizID]);
    mysql_tquery(g_iHandle, str);
    return 1;  
}

Business_UpdateHour(playerid, bizid, amount)
{
  new str[255], Cache:cache, query[255], dutyhour;

  format(query, sizeof(query), "SELECT * FROM `business_employe` WHERE `Business`='%d' AND `playerID` = '%d'", BusinessData[bizid][bizID], GetPlayerSQLID(playerid));
  cache = mysql_query(g_iHandle, query);
  if(cache_num_rows())
  {
      dutyhour = cache_get_field_int(0, "DutyHour");
  }
  dutyhour += amount;
  format(str, sizeof(str), "UPDATE `business_employe` SET `DutyHour`='%d' WHERE `Business` = '%d' AND `playerID` = '%d'", dutyhour, BusinessData[bizid][bizID], GetPlayerSQLID(playerid));
  mysql_tquery(g_iHandle, str);
  cache_delete(cache);
  return 1;  
}

Business_AddEmploye(playerid, bizid)
{
    new str[1024];
    format(str, sizeof(str), "INSERT INTO `business_employe` SET `Name`='%s', `PlayerID` = '%d', `Business`='%d', `DutyHour`='0', `Time`=UNIX_TIMESTAMP()", NormalName(playerid), GetPlayerSQLID(playerid), BusinessData[bizid][bizID]);
    mysql_tquery(g_iHandle, str);
    return 1;
}

Business_RemoveEmploye(id)
{
    new query[255];
    format(query,sizeof(query),"DELETE FROM `business_employe` WHERE `ID`='%d'", id);
    mysql_tquery(g_iHandle, query);
    return 1;
}

Business_RemoveAllEmploye(bizid)
{
    new query[255];
    format(query,sizeof(query),"DELETE FROM `business_employe` WHERE `Business`='%d'", BusinessData[bizid][bizID]);
    mysql_tquery(g_iHandle, query);
    return 1;
}

Business_EmployeGetCount(bizid)
{
    new query[255], Cache: check, count;
    mysql_format(g_iHandle, query, sizeof(query), "SELECT * FROM business_employe WHERE Business = '%d'", BusinessData[bizid][bizID]);
    check = mysql_query(g_iHandle, query);
    new result = cache_num_rows();
    if(result) {
      for(new i; i != result; i++) {
        count++;
      }
    }
    cache_delete(check);
    return count;
}

Business_ShowEmploye(playerid, bizid)
{
    new query[1024], Cache: cache, string[1024];
    format(query, sizeof(query), "SELECT * FROM `business_employe` WHERE `Business`='%d'", BusinessData[bizid][bizID]);
    cache = mysql_query(g_iHandle, query);

    if(!cache_num_rows()) return SendErrorMessage(playerid, "There are no one employe for this business.");
    
    strcat(string, "#\tName\tDate Added\n");
    for(new i; i < cache_num_rows(); i++) {
      new id = cache_get_field_int(i, "ID"),
        time = cache_get_field_int(i, "Time"),
        name[24];

      cache_get_field_content(i, "Name", name);
      strcat(string, sprintf("%d\t"YELLOW"%s\t"RED"%s"WHITE"\n", id, name, ConvertTimestamp(Timestamp:time)));
    }
    Dialog_Show(playerid, BizEmployeeManagement, DIALOG_STYLE_TABLIST_HEADERS, "Employee List", string, "Choose", "Close");
    cache_delete(cache);
    return 1;
}


Business_ShowEmployeDetails(playerid, bizid, id)
{
    new query[255], Cache: cache, string[2054];

    new
        dutyhour,
        name[38],
        time
    ;

    format(query, sizeof(query), "SELECT * FROM `business_employe` WHERE `Business`='%d' AND `ID` = '%d'", BusinessData[bizid][bizID], id);
    cache = mysql_query(g_iHandle, query);

    if(cache_num_rows())
    {
      dutyhour = cache_get_field_int(0, "DutyHour");
      time = cache_get_field_int(0, "Time");
      cache_get_field_content(0, "Name", name);
  
      format(string, sizeof(string), "Details\tStatus\n");   
      format(string, sizeof(string), "%s"WHITE"%s\tJoined "RED"%s\n", string, name, ConvertTimestamp(Timestamp:time));
      format(string, sizeof(string), "%s"WHITE"%s\t"GREEN"Duty Hour %d Hour(s)\n", string, name, dutyhour);
      format(string, sizeof(string), "%s"YELLOW"Remove Employee", string);

      Dialog_Show(playerid, BusinessEmployeeDetails, DIALOG_STYLE_TABLIST_HEADERS, "Employee Details", string, "Details", "Close");
      cache_delete(cache);
    }
    return 1;
}

Business_EmployeeDuty(bizid)
{
    foreach(new i : Player)
    {
        if(Business_IsEmployee(i, bizid) && PlayerData[i][pBizJobDuty] != -1)
          return 1;
    }    
    return 0;
}