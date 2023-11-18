// Ini adalah file yang berisi function untuk modul Admin Duty Times.

#if defined ADMIN_DUTY_TIMES_FUNCTIONS
  #endinput
#endif
#define ADMIN_DUTY_TIMES_FUNCTIONS

// =========================================================

#include <a_mysql>

// =========================================================

ADuty_UpdateAllEndDuty()
{
  new
    query[128]
  ;

  mysql_format(g_iHandle, query, sizeof(query), "UPDATE `%s` SET `ended_at` = CURRENT_TIMESTAMP WHERE `ended_at` IS NULL;", ADMIN_DUTY_TIMES_TABLE_NAME);
  mysql_tquery(g_iHandle, query, "OnADutyUpdateAllEndDuty");
  return 1;
}

// =========================================================

AdminDutyTime_Initialize()
{
  new
    ORM:ormid = g_AdminDutyTimeLog[ORM] = orm_create(ADMIN_DUTY_TIMES_TABLE_NAME)
  ;

  orm_addvar_int(ormid, g_AdminDutyTimeLog[ID], "id");
  orm_addvar_int(ormid, g_AdminDutyTimeLog[Account], "account");

  orm_setkey(ormid, "id");
  return 1;
}

// =========================================================

AdminDutyTime_WriteStartTime(playerid)
{
  if (!SQL_IsLogged(playerid) || !SQL_IsCharacterLogged(playerid))
  {
    return 0;
  }

  new
    description[128],
    Timestamp:now = Now() + Hours:7,
    timestamp[64]
  ;

  g_AdminDutyTimeLog[Account] = AccountData[playerid][pID];

  TimeFormat(now, "[%d/%m/%Y %H:%M:%S]", timestamp);
  format(description, sizeof(description), "Admin %s (playerid=%d, IP=%s) started admin duty at %s", ReturnName(playerid, 0), playerid, ReturnIP(playerid), timestamp);
  orm_insert(g_AdminDutyTimeLog[ORM], "OnADutyTimeDutyStarted", "s", description);
  return 1;
}

// =========================================================

AdminDutyTime_UpdateEndTime(playerid)
{
  if (!SQL_IsLogged(playerid) || !SQL_IsCharacterLogged(playerid))
  {
    return 0;
  }

  new
    account_id = AccountData[playerid][pID],
    query[128],
    description[128],
    Timestamp:now = Now() + Hours:7,
    timestamp[64]
  ;

  TimeFormat(now, "[%d/%m/%Y %H:%M:%S]", timestamp);
  format(description, sizeof(description), "Admin %s (playerid=%d, IP=%s) ended admin duty at %s", ReturnName(playerid, 0), playerid, ReturnIP(playerid), timestamp);
  mysql_format(g_iHandle, query, sizeof(query), "UPDATE `%s` SET `ended_at` = CURRENT_TIMESTAMP WHERE `account` = %d AND `ended_at` IS NULL;", ADMIN_DUTY_TIMES_TABLE_NAME, account_id);
  mysql_tquery(g_iHandle, query, "OnADutyEndDutyUpdated", "s", description);
  return 1;
}
