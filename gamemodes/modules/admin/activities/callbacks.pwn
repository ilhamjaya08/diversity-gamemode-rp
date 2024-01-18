// Ini adalah file yang berisi callback untuk modul Admin Activities.

#if defined ADMIN_ACTIVITY_CALLBACKS
  #endinput
#endif
#define ADMIN_ACTIVITY_CALLBACKS

// =========================================================

#include <YSI\y_hooks>

// =========================================================

hook OnAdminActivityRecorded(const description[])
{
  printf("[ADMIN ACTIVITY] Admin activity recorded. Description: %s", description);
  return 1;
}

// =========================================================

hook OnSQLMigrationFinished(const migration_file[])
{
  printf("[ADMIN ACTIVITY] Migration(s) on file \"%s\" successfully executed.", migration_file);
  return 1;
}

// =========================================================

hook OnDBConnReady()
{
  printf("[ADMIN ACTIVITY] Initialization called.");
  // Menjalankan inisialisasi ORM.
  AdminActivity_Initialize();
  // Menjalankan migration.
  // TODO: Seharusnya bikin 1 function untuk menjalankan migration dari semua script.
  mysql_tquery_file(
    g_iHandle,
    "sql_migrations/20210130_104400_+0700_000000_create_admin_acitivities_table.sql",
    "OnSQLMigrationFinished",
    "s", "20210130_104400_+0700_000000_create_admin_acitivities_table.sql");
  return 1;
}

// =========================================================
