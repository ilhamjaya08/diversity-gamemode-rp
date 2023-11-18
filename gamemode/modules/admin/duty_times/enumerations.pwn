// Ini adalah file yang berisi enumerasi untuk modul Admin Duty Times.

#if defined ADMIN_DUTY_TIMES_ENUMERATIONS
  #endinput
#endif
#define ADMIN_DUTY_TIMES_ENUMERATIONS

// Enum untuk menyimpan data admin duty times yang akan direkam ke database.
enum E_ADMIN_DUTY_TIMES
{
  ORM:ORM,
  ID,
  Account
}

// Variabel global untuk menampung duty times sementara sebelum di-query.
new
  g_AdminDutyTimeLog[E_ADMIN_DUTY_TIMES]
;
