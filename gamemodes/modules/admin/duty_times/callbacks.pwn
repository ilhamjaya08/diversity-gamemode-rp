// Ini adalah file yang berisi callback untuk modul Admin Duty Times.

#if defined ADMIN_DUTY_TIMES_CALLBACKS
  #endinput
#endif
#define ADMIN_DUTY_TIMES_CALLBACKS

// =========================================================

#include <YSI\y_iterate>
#include <YSI\y_hooks>

// =========================================================

hook OnADutyTimeDutyStarted(const description[])
{
  printf("[ADMIN DUTY TIMES] Admin duty times started. %s", description);
  return 1;
}

// =========================================================

hook OnADutyEndDutyUpdated(const description[])
{
  printf("[ADMIN DUTY TIMES] Admin duty times updated. %s", description);
  return 1;
}

// =========================================================

forward OnADutyUpdateAllEndDuty();
public OnADutyUpdateAllEndDuty()
{
  printf("[ADMIN DUTY TIMES] All Admin duty times are updated.");
  return 1;
}

// =========================================================

hook OnSQLMigrationFinished(const migration_file[])
{
  printf("[ADMIN DUTY TIMES] Migration(s) on file \"%s\" successfully executed.", migration_file);
  return 1;
}

// =========================================================

hook OnDBConnReady()
{
  printf("[ADMIN DUTY TIMES] Initialization called.");
  // Menjalankan inisialisasi ORM.
  AdminDutyTime_Initialize();
  // Menjalankan migration.
  // TODO: Seharusnya bikin 1 function untuk menjalankan migration dari semua script.
  mysql_tquery_file(
    g_iHandle,
    "sql_migrations/20210206_202500_+0700_000000_create_admin_duty_times_table.sql",
    "OnSQLMigrationFinished",
    "s", "20210206_202500_+0700_000000_create_admin_duty_times_table.sql");

  // Update semua admin duty times jika masih ada admin duty times yg tidak ada ended_at.
  ADuty_UpdateAllEndDuty();
  return 1;
}

// =========================================================

hook OnGameModeExit()
{
  foreach (new playerid : Player)
  {
    if (AccountData[playerid][pAdminDuty])
    {
      AdminDutyTime_UpdateEndTime(playerid);
    }
  }

  // Meng-update semua admin duty yang masih null ended_at nya.
  ADuty_UpdateAllEndDuty();
}

// =========================================================

hook OnPlayerDisconnect(playerid, reason)
{
  if (AccountData[playerid][pAdminDuty])
  {
    AdminDutyTime_UpdateEndTime(playerid);
  }
}
