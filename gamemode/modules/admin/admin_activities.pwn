// Ini adalah file utama untuk memuat modul Admin Activities.

#if defined ADMIN_ACTIVITY_MODULE
  #endinput
#endif
#define ADMIN_ACTIVITY_MODULE

// =========================================================

#include <a_mysql>

// =========================================================

// Nama tabel untuk menyimpan admin activities.
#define ADMIN_ACTTIVITY_TABLE_NAME "admin_activities"
// Panjang maksimum untuk tipe activity.
#define ADMIN_ACTIVITY_MAX_ACT_NAME (14)
// Panjang maksimum untuk description.
#define ADMIN_ACTIVITY_MAX_DESC     (512)

// =========================================================

#include "activities/enumerations.pwn"
#include "activities/functions.pwn"
#include "activities/callbacks.pwn"
