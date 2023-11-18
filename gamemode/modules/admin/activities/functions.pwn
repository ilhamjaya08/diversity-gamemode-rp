// Ini adalah file yang berisi function untuk modul Admin Activities.

#if defined ADMIN_ACTIVITY_FUNCTIONS
  #endinput
#endif
#define ADMIN_ACTIVITY_FUNCTIONS

// =========================================================

#include <a_mysql>

// =========================================================

AdminActivity_Initialize()
{
  new
    ORM:ormid = g_AdminActivityLog[ORM] = orm_create(ADMIN_ACTTIVITY_TABLE_NAME)
  ;

  orm_addvar_int(ormid, g_AdminActivityLog[ID], "id");
  orm_addvar_string(ormid, g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "type");
  orm_addvar_int(ormid, g_AdminActivityLog[Issuer], "issuer");
  orm_addvar_int(ormid, g_AdminActivityLog[Receiver], "receiver");
  orm_addvar_string(ormid, g_AdminActivityLog[IssuerIP], 16, "issuer_ip_address");
  orm_addvar_string(ormid, g_AdminActivityLog[ReceiverIP], 16, "receiver_ip_address");
  orm_addvar_string(ormid, g_AdminActivityLog[Description], ADMIN_ACTIVITY_MAX_DESC, "description");

  orm_setkey(ormid, "id");
  return 1;
}

// =========================================================

AdminActivity_Write(issuerid, receiverid, type, const description[])
{
  if (!SQL_IsLogged(issuerid) || !SQL_IsCharacterLogged(issuerid))
  {
    return 0;
  }

  switch(type)
  {
    case ADMIN_ACTIVITY_ACCEPT_REPORT:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "accept_report");
    }
    case ADMIN_ACTIVITY_DENY_REPORT:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "deny_report");
    }
    case ADMIN_ACTIVITY_ACCEPT_STUCK:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "accept_stuck");
    }
    case ADMIN_ACTIVITY_DENY_STUCK:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "deny_stuck");
    }
    case ADMIN_ACTIVITY_BAN:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "ban");
    }
    case ADMIN_ACTIVITY_UNBAN:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "unban");
    }
    case ADMIN_ACTIVITY_JAIL:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "jail");
    }
    case ADMIN_ACTIVITY_ANSWER:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "answer");
    }
    default:
    {
      format(g_AdminActivityLog[Type], ADMIN_ACTIVITY_MAX_ACT_NAME, "unknown");
    }
  }

  g_AdminActivityLog[Issuer] = AccountData[issuerid][pID];

  if (receiverid == INVALID_PLAYER_ID || !SQL_IsLogged(receiverid) || !SQL_IsCharacterLogged(receiverid))
  {
    // Jika receiver tidak online, maka akan diarahkan ke issuer.
    receiverid = issuerid;
  }

  // Menetapkan receiver dari activity berdasarkan ID character-nya.
  g_AdminActivityLog[Receiver] = PlayerData[receiverid][pID];

  GetPlayerIp(issuerid, g_AdminActivityLog[IssuerIP], 16);
  GetPlayerIp(receiverid, g_AdminActivityLog[ReceiverIP], 16);
  format(g_AdminActivityLog[Description], ADMIN_ACTIVITY_MAX_DESC, "%s", description);

  orm_insert(g_AdminActivityLog[ORM], "OnAdminActivityRecorded", "s", description);
  return 1;
}
