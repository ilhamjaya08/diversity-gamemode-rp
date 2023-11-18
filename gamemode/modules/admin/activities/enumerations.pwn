// Ini adalah file yang berisi enumerasi untuk modul Admin Activities.

#if defined ADMIN_ACTIVITY_ENUMERATIONS
  #endinput
#endif
#define ADMIN_ACTIVITY_ENUMERATIONS

// Enumerasi untuk tipe admin activity
enum
{
  ADMIN_ACTIVITY_UNKNOWN,
  ADMIN_ACTIVITY_ACCEPT_REPORT,
  ADMIN_ACTIVITY_DENY_REPORT,
  ADMIN_ACTIVITY_ACCEPT_STUCK,
  ADMIN_ACTIVITY_DENY_STUCK,
  ADMIN_ACTIVITY_BAN,
  ADMIN_ACTIVITY_UNBAN,
  ADMIN_ACTIVITY_JAIL,
  ADMIN_ACTIVITY_ANSWER
}

// Enum untuk menyimpan data admin activity yang akan direkam ke database.
enum E_ADMIN_ACTIVITY
{
  ORM:ORM,
  ID,
  Type[ADMIN_ACTIVITY_MAX_ACT_NAME],
  Issuer,
  Receiver,
  IssuerIP[16 + 1],
  ReceiverIP[16 + 1],
  Description[512]
}

// Variabel global untuk menampung activity sementara sebelum di-query.
new
  g_AdminActivityLog[E_ADMIN_ACTIVITY]
;
