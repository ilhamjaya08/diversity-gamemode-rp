/**

  File ini berisi constants tentang VehicleValidMods.
  Sejauh ini, informasi tentang VehicleValidMods adalah menyimpan informasi tentang ID komponen mod yang valid untuk ID model kendaraan tertentu.
  Hal ini untuk mencegah terjadinya player berusaha melakukan mod komponen di luar ID yang sudah ditentukan agar server tidak crash.

  Harap perbaharui tulisan ini jika ada perubahan.
 */

/**
  Include guard: Menghindari file ini di-include berulang kali.
*/
#if defined _inc_VEHVALIDMODS_CONST
  #endinput
#endif
#define _inc_VEHVALIDMODS_CONST


// Jumlah model kendaraan yang tersedia di SA-MP.
#define MAX_VEHICLE_MODELS                  (212)
// Jumlah maksimal mod yang bisa dipasang dan kompatibel ke kendaraan.
#define MAX_VEHICLE_COMPAT_MODS             (44)
// ID maksimal untuk ID mod kendaraan (untuk keperluan y_foreach)
#define MAX_VEHICLE_MOD_ID                  (1193)
// Jumlah mod yang ada di GTA San Andreas
#define MAX_VEHICLE_MODS                    (194)
// Jumlah bagian kendaraan yang bisa di-mod.
#define MAX_VEHICLE_MOD_SECTIONS            (17)
// ID untuk penanda section mod-nya invalid.
#define INVALID_VEHICLE_MOD_SECTION_ID      ( -1)

#define VEHICLE_MOD_SECTION_BULLBAR         (0)
#define VEHICLE_MOD_SECTION_EXHAUST         (1)
#define VEHICLE_MOD_SECTION_FRONT_BULLBARS  (2)
#define VEHICLE_MOD_SECTION_FRONT_BUMPER    (3)
#define VEHICLE_MOD_SECTION_FRONT_SIGN      (4)
#define VEHICLE_MOD_SECTION_HOOD            (5)
#define VEHICLE_MOD_SECTION_HYDRAULICS      (6)
#define VEHICLE_MOD_SECTION_LAMPS           (7)
#define VEHICLE_MOD_SECTION_NITRO           (8)
#define VEHICLE_MOD_SECTION_REAR_BULLBARS   (9)
#define VEHICLE_MOD_SECTION_REAR_BUMPER     (10)
#define VEHICLE_MOD_SECTION_ROOF            (11)
#define VEHICLE_MOD_SECTION_SIDESKIRT       (12)
#define VEHICLE_MOD_SECTION_SPOILER         (13)
#define VEHICLE_MOD_SECTION_STEREO          (14)
#define VEHICLE_MOD_SECTION_VENTS           (15)
#define VEHICLE_MOD_SECTION_WHEELS          (16)

#include <YSI\y_iterate>

enum E_VEHICLE_MOD
{
  VEHICLE_MOD_MODEL_ID,
  VEHICLE_MOD_MODEL_NAME[32],
  VEHICLE_MOD_MODEL_SECTION,
  VEHICLE_MOD_MODEL_BRAND[32],
  VEHICLE_MOD_COMMENT[64]
};

static const g_VehicleModSections[MAX_VEHICLE_MOD_SECTIONS][32] =
{
  {"Bullbar"},
  {"Exhaust"},
  {"Front Bullbars"},
  {"Front Bumper"},
  {"Front Sign"},
  {"Hood"},
  {"Hydraulics"},
  {"Lamps"},
  {"Nitro"},
  {"Rear Bullbars"},
  {"Rear Bumper"},
  {"Roof"},
  {"Sideskirt"},
  {"Spoiler"},
  {"Stereo"},
  {"Vents"},
  {"Wheels"}
};

static const g_VehicleMods[MAX_VEHICLE_MODS][E_VEHICLE_MOD] =
{
  {1000, "spl_b_mar_m", VEHICLE_MOD_SECTION_SPOILER, "Pro", "Certain Transfender cars"},
  {1001, "spl_b_bab_m", VEHICLE_MOD_SECTION_SPOILER, "Win", "Certain Transfender cars"},
  {1002, "spl_b_bar_m", VEHICLE_MOD_SECTION_SPOILER, "Drag", "Certain Transfender cars"},
  {1003, "spl_b_mab_m", VEHICLE_MOD_SECTION_SPOILER, "Alpha", "Certain Transfender cars"},
  {1004, "bnt_b_sc_m", VEHICLE_MOD_SECTION_VENTS, "Champ Scoop", "Certain Transfender cars"},
  {1005, "bnt_b_sc_l", VEHICLE_MOD_SECTION_VENTS, "Fury Scoop", "Certain Transfender cars"},
  {1006, "rf_b_sc_r", VEHICLE_MOD_SECTION_ROOF, "Roof Scoop", "Certain Transfender cars"},
  {1007, "wg_l_b_ssk", VEHICLE_MOD_SECTION_SIDESKIRT, "Right Sideskirt", "Certain Transfender cars"},
  {1008, "nto_b_l", VEHICLE_MOD_SECTION_NITRO, "5 times", "Most cars"},
  {1009, "nto_b_s", VEHICLE_MOD_SECTION_NITRO, "2 times", "Most cars"},
  {1010, "nto_b_tw", VEHICLE_MOD_SECTION_NITRO, "10 times", "Most cars"},
  {1011, "bnt_b_sc_p_m", VEHICLE_MOD_SECTION_VENTS, "Race Scoop", "Certain Transfender cars"},
  {1012, "bnt_b_sc_p_l", VEHICLE_MOD_SECTION_VENTS, "Worx Scoop", "Certain Transfender cars"},
  {1013, "lgt_b_rspt", VEHICLE_MOD_SECTION_LAMPS, "Round Fog", "Certain Transfender cars"},
  {1014, "spl_b_bar_l", VEHICLE_MOD_SECTION_SPOILER, "Champ", "Certain Transfender cars"},
  {1015, "spl_b_bbr_l", VEHICLE_MOD_SECTION_SPOILER, "Race", "Certain Transfender cars"},
  {1016, "spl_b_bbr_m", VEHICLE_MOD_SECTION_SPOILER, "Worx", "Certain Transfender cars"},
  {1017, "wg_r_b_ssk", VEHICLE_MOD_SECTION_SIDESKIRT, "Left Sideskirt", "Certain Transfender cars"},
  {1018, "exh_b_ts", VEHICLE_MOD_SECTION_EXHAUST, "Upswept", "Certain Transfender cars"},
  {1019, "exh_b_t", VEHICLE_MOD_SECTION_EXHAUST, "Twin", "Certain Transfender cars"},
  {1020, "exh_b_l", VEHICLE_MOD_SECTION_EXHAUST, "Large", "Certain Transfender cars"},
  {1021, "exh_b_m", VEHICLE_MOD_SECTION_EXHAUST, "Medium", "Certain Transfender cars"},
  {1022, "exh_b_s", VEHICLE_MOD_SECTION_EXHAUST, "Small", "Certain Transfender cars"},
  {1023, "spl_b_bbb_m", VEHICLE_MOD_SECTION_SPOILER, "Fury", "Certain Transfender cars"},
  {1024, "lgt_b_sspt", VEHICLE_MOD_SECTION_LAMPS, "Square Fog", "Certain Transfender cars"},
  {1025, "wheel_or1", VEHICLE_MOD_SECTION_WHEELS, "Offroad", "Certain Transfender cars"},
  {1026, "wg_l_a_s", VEHICLE_MOD_SECTION_SIDESKIRT, "Right Alien Sideskirt", "Sultan"},
  {1027, "wg_r_a_s", VEHICLE_MOD_SECTION_SIDESKIRT, "Left Alien Sideskirt", "Sultan"},
  {1028, "exh_a_s", VEHICLE_MOD_SECTION_EXHAUST, "Alien", "Sultan"},
  {1029, "exh_c_s", VEHICLE_MOD_SECTION_EXHAUST, "X-Flow", "Sultan"},
  {1030, "wg_r_c_s", VEHICLE_MOD_SECTION_SIDESKIRT, "Left X-Flow Sideskirt", "Sultan"},
  {1031, "wg_l_c_s", VEHICLE_MOD_SECTION_SIDESKIRT, "Right X-Flow Sideskirt", "Sultan"},
  {1032, "rf_a_s", VEHICLE_MOD_SECTION_ROOF, "Alien Roof Vent", "Sultan"},
  {1033, "rf_c_s", VEHICLE_MOD_SECTION_ROOF, "X-Flow Roof Vent", "Sultan"},
  {1034, "exh_a_l", VEHICLE_MOD_SECTION_EXHAUST, "Alien", "Elegy"},
  {1035, "rf_c_l", VEHICLE_MOD_SECTION_ROOF, "X-Flow Roof Vent", "Elegy"},
  {1036, "wg_l_a_l", VEHICLE_MOD_SECTION_SIDESKIRT, "Right Alien Sideskirt", "Elegy"},
  {1037, "exh_c_l", VEHICLE_MOD_SECTION_EXHAUST, "X-Flow", "Elegy"},
  {1038, "rf_a_l", VEHICLE_MOD_SECTION_ROOF, "Alien Roof Vent", "Elegy"},
  {1039, "wg_l_c_l", VEHICLE_MOD_SECTION_SIDESKIRT, "Left X-Flow Sideskirt", "Elegy"},
  {1040, "wg_r_a_l", VEHICLE_MOD_SECTION_SIDESKIRT, "Left Alien Sideskirt", "Elegy"},
  {1041, "wg_r_c_l", VEHICLE_MOD_SECTION_SIDESKIRT, "Right X-Flow Sideskirt", "Elegy"},
  {1042, "wg_l_lr_br1", VEHICLE_MOD_SECTION_SIDESKIRT, "Right Chrome Sideskirt", "Broadway"},
  {1043, "exh_lr_br2", VEHICLE_MOD_SECTION_EXHAUST, "Slamin", "Broadway"},
  {1044, "exh_lr_br1", VEHICLE_MOD_SECTION_EXHAUST, "Chrome", "Broadway"},
  {1045, "exh_c_f", VEHICLE_MOD_SECTION_EXHAUST, "X-Flow", "Flash"},
  {1046, "exh_a_f", VEHICLE_MOD_SECTION_EXHAUST, "Alien", "Flash"},
  {1047, "wg_l_a_f", VEHICLE_MOD_SECTION_SIDESKIRT, "Right Alien Sideskirt", "Flash"},
  {1048, "wg_l_c_f", VEHICLE_MOD_SECTION_SIDESKIRT, "Right X-Flow Sideskirt", "Flash"},
  {1049, "spl_a_f_r", VEHICLE_MOD_SECTION_SPOILER, "Alien", "Flash"},
  {1050, "spl_c_f_r", VEHICLE_MOD_SECTION_SPOILER, "X-Flow", "Flash"},
  {1051, "wg_r_a_f", VEHICLE_MOD_SECTION_SIDESKIRT, "Left Alien Sideskirt", "Flash"},
  {1052, "wg_r_c_f", VEHICLE_MOD_SECTION_SIDESKIRT, "Left X-Flow Sideskirt", "Flash"},
  {1053, "rf_c_f", VEHICLE_MOD_SECTION_ROOF, "X-Flow", "Flash"},
  {1054, "rf_a_f", VEHICLE_MOD_SECTION_ROOF, "Alien", "Flash"},
  {1055, "rf_a_st", VEHICLE_MOD_SECTION_ROOF, "Alien", "Statum"},
  {1056, "wg_l_a_st", VEHICLE_MOD_SECTION_SIDESKIRT, "Right Alien Sideskirt", "Stratum"},
  {1057, "wg_l_c_st", VEHICLE_MOD_SECTION_SIDESKIRT, "Right X-Flow Sideskirt", "Stratum"},
  {1058, "spl_a_st_r", VEHICLE_MOD_SECTION_SPOILER, "Alien", "Statum"},
  {1059, "exh_c_st", VEHICLE_MOD_SECTION_EXHAUST, "X-Flow", "Statum"},
  {1060, "spl_c_st_r", VEHICLE_MOD_SECTION_SPOILER, "X-Flow", "Statum"},
  {1061, "rf_c_st", VEHICLE_MOD_SECTION_ROOF, "X-Flow", "Statum"},
  {1062, "wg_r_a_st", VEHICLE_MOD_SECTION_SIDESKIRT, "Left Alien Sideskirt", "Stratum"},
  {1063, "wg_r_c_st", VEHICLE_MOD_SECTION_SIDESKIRT, "Left X-Flow Sideskirt", "Stratum"},
  {1064, "exh_a_st", VEHICLE_MOD_SECTION_EXHAUST, "Alien", "Statum"},
  {1065, "exh_a_j", VEHICLE_MOD_SECTION_EXHAUST, "Alien", "Jester"},
  {1066, "exh_c_j", VEHICLE_MOD_SECTION_EXHAUST, "X-Flow", "Jester"},
  {1067, "rf_a_j", VEHICLE_MOD_SECTION_ROOF, "Alien", "Jester"},
  {1068, "rf_c_j", VEHICLE_MOD_SECTION_ROOF, "X-Flow", "Jester"},
  {1069, "wg_l_a_j", VEHICLE_MOD_SECTION_SIDESKIRT, "Right Alien Sideskirt", "Jester"},
  {1070, "wg_l_c_j", VEHICLE_MOD_SECTION_SIDESKIRT, "Right X-Flow Sideskirt", "Jester"},
  {1071, "wg_r_a_j", VEHICLE_MOD_SECTION_SIDESKIRT, "Left Alien Sideskirt", "Jester"},
  {1072, "wg_r_c_j", VEHICLE_MOD_SECTION_SIDESKIRT, "Left X-Flow Sideskirt", "Jester"},
  {1073, "wheel_sr6", VEHICLE_MOD_SECTION_WHEELS, "Shadow", "Most cars"},
  {1074, "wheel_sr3", VEHICLE_MOD_SECTION_WHEELS, "Mega", "Most cars"},
  {1075, "wheel_sr2", VEHICLE_MOD_SECTION_WHEELS, "Rimshine", "Most cars"},
  {1076, "wheel_lr4", VEHICLE_MOD_SECTION_WHEELS, "Wires", "Most cars"},
  {1077, "wheel_lr1", VEHICLE_MOD_SECTION_WHEELS, "Classic", "Most cars"},
  {1078, "wheel_lr3", VEHICLE_MOD_SECTION_WHEELS, "Twist", "Most cars"},
  {1079, "wheel_sr1", VEHICLE_MOD_SECTION_WHEELS, "Cutter", "Most cars"},
  {1080, "wheel_sr5", VEHICLE_MOD_SECTION_WHEELS, "Switch", "Most cars"},
  {1081, "wheel_sr4", VEHICLE_MOD_SECTION_WHEELS, "Grove", "Most cars"},
  {1082, "wheel_gn1", VEHICLE_MOD_SECTION_WHEELS, "Import", "Most cars"},
  {1083, "wheel_lr2", VEHICLE_MOD_SECTION_WHEELS, "Dollar", "Most cars"},
  {1084, "wheel_lr5", VEHICLE_MOD_SECTION_WHEELS, "Trance", "Most cars"},
  {1085, "wheel_gn2", VEHICLE_MOD_SECTION_WHEELS, "Atomic", "Most cars"},
  {1086, "stereo", VEHICLE_MOD_SECTION_STEREO, "Stereo", "Most cars"},
  {1087, "hydralics", VEHICLE_MOD_SECTION_HYDRAULICS, "Hydraulics", "Most cars"},
  {1088, "rf_a_u", VEHICLE_MOD_SECTION_ROOF, "Alien", "Uranus"},
  {1089, "exh_c_u", VEHICLE_MOD_SECTION_EXHAUST, "X-Flow", "Uranus"},
  {1090, "wg_l_a_u", VEHICLE_MOD_SECTION_SIDESKIRT, "Right Alien Sideskirt", "Uranus"},
  {1091, "rf_c_u", VEHICLE_MOD_SECTION_ROOF, "X-Flow", "Uranus"},
  {1092, "exh_a_u", VEHICLE_MOD_SECTION_EXHAUST, "Alien", "Uranus"},
  {1093, "wg_l_c_u", VEHICLE_MOD_SECTION_SIDESKIRT, "Left X-Flow Sideskirt", "Uranus"},
  {1094, "wg_r_a_u", VEHICLE_MOD_SECTION_SIDESKIRT, "Left Alien Sideskirt", "Uranus"},
  {1095, "wg_r_c_u", VEHICLE_MOD_SECTION_SIDESKIRT, "Right X-Flow Sideskirt", "Uranus"},
  {1096, "wheel_gn3", VEHICLE_MOD_SECTION_WHEELS, "Ahab", "Most cars"},
  {1097, "wheel_gn4", VEHICLE_MOD_SECTION_WHEELS, "Virtual", "Most cars"},
  {1098, "wheel_gn5", VEHICLE_MOD_SECTION_WHEELS, "Access", "Most cars"},
  {1099, "wg_r_lr_br1", VEHICLE_MOD_SECTION_SIDESKIRT, "Left Chrome Sideskirt", "Broadway"},
  {1100, "misc_c_lr_rem1", VEHICLE_MOD_SECTION_BULLBAR, "Chrome Grill", "Remington"},
  {1101, "wg_r_lr_rem1", VEHICLE_MOD_SECTION_SIDESKIRT, "Left `Chrome Flames` Sideskirt", "Remington"},
  {1102, "wg_r_lr_sv", VEHICLE_MOD_SECTION_SIDESKIRT, "Left `Chrome Strip` Sideskirt", "Savanna"},
  {1103, "rf_lr_bl2", VEHICLE_MOD_SECTION_ROOF, "Covertible", "Blade"},
  {1104, "exh_lr_bl1", VEHICLE_MOD_SECTION_EXHAUST, "Chrome", "Blade"},
  {1105, "exh_lr_bl2", VEHICLE_MOD_SECTION_EXHAUST, "Slamin", "Blade"},
  {1106, "wg_l_lr_rem2", VEHICLE_MOD_SECTION_SIDESKIRT, "Right `Chrome Arches`", "Remington"},
  {1107, "wg_r_lr_bl1", VEHICLE_MOD_SECTION_SIDESKIRT, "Left `Chrome Strip` Sideskirt", "Blade"},
  {1108, "wg_l_lr_bl1", VEHICLE_MOD_SECTION_SIDESKIRT, "Right `Chrome Strip` Sideskirt", "Blade"},
  {1109, "bbb_lr_slv1", VEHICLE_MOD_SECTION_REAR_BULLBARS, "Chrome", "Slamvan"},
  {1110, "bbb_lr_slv2", VEHICLE_MOD_SECTION_REAR_BULLBARS, "Slamin", "Slamvan"},
  {1111, "bnt_lr_slv1", VEHICLE_MOD_SECTION_FRONT_SIGN, "Little Sign?", "Slamvan"},
  {1112, "bnt_lr_slv2", VEHICLE_MOD_SECTION_FRONT_SIGN, "Little Sign?", "Slamvan"},
  {1113, "exh_lr_slv1", VEHICLE_MOD_SECTION_EXHAUST, "Chrome", "Slamvan"},
  {1114, "exh_lr_slv2", VEHICLE_MOD_SECTION_EXHAUST, "Slamin", "Slamvan"},
  {1115, "fbb_lr_slv1", VEHICLE_MOD_SECTION_FRONT_BULLBARS, "Chrome", "Slamvan"},
  {1116, "fbb_lr_slv2", VEHICLE_MOD_SECTION_FRONT_BULLBARS, "Slamin", "Slamvan"},
  {1117, "fbmp_lr_slv1", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Chrome", "Slamvan"},
  {1118, "wg_l_lr_slv1", VEHICLE_MOD_SECTION_SIDESKIRT, "Right `Chrome Trim` Sideskirt", "Slamvan"},
  {1119, "wg_l_lr_slv2", VEHICLE_MOD_SECTION_SIDESKIRT, "Right `Wheelcovers` Sideskirt", "Slamvan"},
  {1120, "wg_r_lr_slv1", VEHICLE_MOD_SECTION_SIDESKIRT, "Left `Chrome Trim` Sideskirt", "Slamvan"},
  {1121, "wg_r_lr_slv2", VEHICLE_MOD_SECTION_SIDESKIRT, "Left `Wheelcovers` Sideskirt", "Slamvan"},
  {1122, "wg_l_lr_rem1", VEHICLE_MOD_SECTION_SIDESKIRT, "Right `Chrome Flames` Sideskirt", "Remington"},
  {1123, "misc_c_lr_rem2", VEHICLE_MOD_SECTION_BULLBAR, "Bullbar Chrome Bars", "Remington"},
  {1124, "wg_r_lr_rem2", VEHICLE_MOD_SECTION_SIDESKIRT, "Left `Chrome Arches` Sideskirt", "Remington"},
  {1125, "misc_c_lr_rem3", VEHICLE_MOD_SECTION_BULLBAR, "Bullbar Chrome Lights", "Remington"},
  {1126, "exh_lr_rem1", VEHICLE_MOD_SECTION_EXHAUST, "Chrome Exhaust", "Remington"},
  {1127, "exh_lr_rem2", VEHICLE_MOD_SECTION_EXHAUST, "Slamin Exhaust", "Remington"},
  {1128, "rf_lr_bl1", VEHICLE_MOD_SECTION_ROOF, "Vinyl Hardtop", "Blade"},
  {1129, "exh_lr_sv1", VEHICLE_MOD_SECTION_EXHAUST, "Chrome", "Savanna"},
  {1130, "rf_lr_sv1", VEHICLE_MOD_SECTION_ROOF, "Hardtop", "Savanna"},
  {1131, "rf_lr_sv2", VEHICLE_MOD_SECTION_ROOF, "Softtop", "Savanna"},
  {1132, "exh_lr_sv2", VEHICLE_MOD_SECTION_EXHAUST, "Slamin", "Savanna"},
  {1133, "wg_l_lr_sv", VEHICLE_MOD_SECTION_SIDESKIRT, "Right `Chrome Strip` Sideskirt", "Savanna"},
  {1134, "wg_l_lr_t1", VEHICLE_MOD_SECTION_SIDESKIRT, "Right `Chrome Strip` Sideskirt", "Tornado"},
  {1135, "exh_lr_t2", VEHICLE_MOD_SECTION_EXHAUST, "Slamin", "Tornado"},
  {1136, "exh_lr_t1", VEHICLE_MOD_SECTION_EXHAUST, "Chrome", "Tornado"},
  {1137, "wg_r_lr_t1", VEHICLE_MOD_SECTION_SIDESKIRT, "Left `Chrome Strip` Sideskirt", "Tornado"},
  {1138, "spl_a_s_b", VEHICLE_MOD_SECTION_SPOILER, "Alien", "Sultan"},
  {1139, "spl_c_s_b", VEHICLE_MOD_SECTION_SPOILER, "X-Flow", "Sultan"},
  {1140, "rbmp_c_s", VEHICLE_MOD_SECTION_REAR_BUMPER, "X-Flow", "Sultan"},
  {1141, "rbmp_a_s", VEHICLE_MOD_SECTION_REAR_BUMPER, "Alien", "Sultan"},
  {1142, "bntr_b_ov", VEHICLE_MOD_SECTION_HOOD, "Left Oval Hoods", "Certain Transfender Cars"},
  {1143, "bntl_b_ov", VEHICLE_MOD_SECTION_HOOD, "Right Oval Hoods", "Certain Transfender Cars"},
  {1144, "bntr_b_sq", VEHICLE_MOD_SECTION_HOOD, "Left Square Hoods", "Certain Transfender Cars"},
  {1145, "bntl_b_sq", VEHICLE_MOD_SECTION_HOOD, "Right Square Hoods", "Certain Transfender Cars"},
  {1146, "spl_c_l_b", VEHICLE_MOD_SECTION_SPOILER, "X-Flow", "Elegy"},
  {1147, "spl_a_l_b", VEHICLE_MOD_SECTION_SPOILER, "Alien", "Elegy"},
  {1148, "rbmp_c_l", VEHICLE_MOD_SECTION_REAR_BUMPER, "X-Flow", "Elegy"},
  {1149, "rbmp_a_l", VEHICLE_MOD_SECTION_REAR_BUMPER, "Alien", "Elegy"},
  {1150, "rbmp_a_f", VEHICLE_MOD_SECTION_REAR_BUMPER, "Alien", "Flash"},
  {1151, "rbmp_c_f", VEHICLE_MOD_SECTION_REAR_BUMPER, "X-Flow", "Flash"},
  {1152, "fbmp_c_f", VEHICLE_MOD_SECTION_FRONT_BUMPER, "X-Flow", "Flash"},
  {1153, "fbmp_a_f", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Alien", "Flash"},
  {1154, "rbmp_a_st", VEHICLE_MOD_SECTION_REAR_BUMPER, "Alien", "Stratum"},
  {1155, "fbmp_a_st", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Alien", "Stratum"},
  {1156, "rbmp_c_st", VEHICLE_MOD_SECTION_REAR_BUMPER, "X-Flow", "Stratum"},
  {1157, "fbmp_c_st", VEHICLE_MOD_SECTION_FRONT_BUMPER, "X-Flow", "Stratum"},
  {1158, "spl_c_j_b", VEHICLE_MOD_SECTION_SPOILER, "X-Flow", "Jester"},
  {1159, "rbmp_a_j", VEHICLE_MOD_SECTION_REAR_BUMPER, "Alien", "Jester"},
  {1160, "fbmp_a_j", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Alien", "Jester"},
  {1161, "rbmp_c_j", VEHICLE_MOD_SECTION_REAR_BUMPER, "X-Flow", "Jester"},
  {1162, "spl_a_j_b", VEHICLE_MOD_SECTION_SPOILER, "Alien", "Jester"},
  {1163, "spl_c_u_b", VEHICLE_MOD_SECTION_SPOILER, "X-Flow", "Uranus"},
  {1164, "spl_a_u_b", VEHICLE_MOD_SECTION_SPOILER, "Alien", "Uranus"},
  {1165, "fbmp_c_u", VEHICLE_MOD_SECTION_FRONT_BUMPER, "X-Flow", "Uranus"},
  {1166, "fbmp_a_u", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Alien", "Uranus"},
  {1167, "rbmp_c_u", VEHICLE_MOD_SECTION_REAR_BUMPER, "X-Flow", "Uranus"},
  {1168, "rbmp_a_u", VEHICLE_MOD_SECTION_REAR_BUMPER, "Alien", "Uranus"},
  {1169, "fbmp_a_s", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Alien", "Sultan"},
  {1170, "fbmp_c_s", VEHICLE_MOD_SECTION_FRONT_BUMPER, "X-Flow", "Sultan"},
  {1171, "fbmp_a_l", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Alien", "Elegy"},
  {1172, "fbmp_c_l", VEHICLE_MOD_SECTION_FRONT_BUMPER, "X-Flow", "Elegy"},
  {1173, "fbmp_c_j", VEHICLE_MOD_SECTION_FRONT_BUMPER, "X-Flow", "Jester"},
  {1174, "fbmp_lr_br1", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Chrome", "Broadway"},
  {1175, "fbmp_lr_br2", VEHICLE_MOD_SECTION_REAR_BUMPER, "Slamin", "Broadway"},
  {1176, "rbmp_lr_br1", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Chrome", "Broadway"},
  {1177, "rbmp_lr_br2", VEHICLE_MOD_SECTION_REAR_BUMPER, "Slamin", "Broadway"},
  {1178, "rbmp_lr_rem2", VEHICLE_MOD_SECTION_REAR_BUMPER, "Slamin", "Remington"},
  {1179, "fbmp_lr_rem1", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Chrome", "Remington"},
  {1180, "rbmp_lr_rem1", VEHICLE_MOD_SECTION_REAR_BUMPER, "Chrome", "Remington"},
  {1181, "fbmp_lr_bl2", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Slamin", "Blade"},
  {1182, "fbmp_lr_bl1", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Chrome", "Blade"},
  {1183, "rbmp_lr_bl2", VEHICLE_MOD_SECTION_REAR_BUMPER, "Slamin", "Blade"},
  {1184, "rbmp_lr_bl1", VEHICLE_MOD_SECTION_REAR_BUMPER, "Chrome", "Blade"},
  {1185, "fbmp_lr_rem2", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Slamin", "Remington"},
  {1186, "rbmp_lr_sv2", VEHICLE_MOD_SECTION_REAR_BUMPER, "Slamin", "Savanna"},
  {1187, "rbmp_lr_sv1", VEHICLE_MOD_SECTION_REAR_BUMPER, "Chrome", "Savanna"},
  {1188, "fbmp_lr_sv2", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Slamin", "Savanna"},
  {1189, "fbmp_lr_sv1", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Chrome", "Savanna"},
  {1190, "fbmp_lr_t2", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Slamin", "Tornado"},
  {1191, "fbmp_lr_t1", VEHICLE_MOD_SECTION_FRONT_BUMPER, "Chrome", "Tornado"},
  {1192, "rbmp_lr_t1", VEHICLE_MOD_SECTION_REAR_BUMPER, "Chrome", "Tornado"},
  {1193, "rbmp_lr_t2", VEHICLE_MOD_SECTION_REAR_BUMPER, "Slamin", "Tornado"}
};

static const g_VehicleValidMods[MAX_VEHICLE_MODELS][MAX_VEHICLE_COMPAT_MODS] =
{
  { 1008, 1009, 1010, 1013, 1018, 1019, 1020, 1021, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Landstalker (400)
  { 1001, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013, 1017, 1019, 1020, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Bravura (401)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Buffalo (402)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Linerunner (403)
  { 1000, 1002, 1007, 1008, 1009, 1010, 1013, 1016, 1017, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Perrenial (404)
  { 1000, 1001, 1008, 1009, 1010, 1014, 1018, 1019, 1020, 1021, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Sentinel (405)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Dumper (406)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Firetruck (407)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Trashmaster (408)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Stretch (409)
  { 1001, 1003, 1007, 1008, 1009, 1010, 1013, 1017, 1019, 1020, 1021, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Manana (410)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Infernus (411)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Voodoo (412)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Pony (413)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Mule (414)
  { 1001, 1003, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Cheetah (415)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Ambulance (416)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Leviathan (417)
  { 1002, 1006, 1008, 1009, 1010, 1016, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Moonbeam (418)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Esperanto (419)
  { 1001, 1003, 1004, 1005, 1008, 1009, 1010, 1019, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Taxi (420)
  { 1000, 1008, 1009, 1010, 1014, 1016, 1018, 1019, 1020, 1021, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Washington (421)
  { 1007, 1008, 1009, 1010, 1013, 1017, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Bobcat (422)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Mr Whoopee (423)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // BF Injection (424)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hunter (425)
  { 1001, 1003, 1004, 1005, 1006, 1008, 1009, 1010, 1019, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Premier (426)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Enforcer (427)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Securicar (428)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Banshee (429)
  { }, // Predator (430)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Bus (431)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Rhino (432)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Barracks (433)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hotknife (434)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Trailer 1 (435)
  { 1001, 1003, 1006, 1007, 1008, 1009, 1010, 1013, 1017, 1019, 1020, 1021, 1022, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Previon (436)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Coach (437)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Cabbie (438)
  { 1001, 1003, 1007, 1008, 1009, 1010, 1013, 1017, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Stallion (439)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Rumpo (440)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // RC Bandit (441)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Romero (442)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Packer (443)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Monster (444)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Admiral (445)
  { }, // Squalo (446)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Seasparrow (447)
  { }, // Pizzaboy (448)
  { }, // Tram (449)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Trailer 2 (450)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Turismo (451)
  { }, // Speeder (452)
  { }, // Reefer (453)
  { }, // Tropic (454)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Flatbed (455)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Yankee (456)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Caddy (457)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Solair (458)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Berkley's RC Van (459)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Skimmer (460)
  { }, // PCJ-600 (461)
  { }, // Faggio (462)
  { }, // Freeway (463)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // RC Baron (464)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // RC Raider (465)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Glendale (466)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Oceanic (467)
  { }, // Sanchez (468)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Sparrow (469)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Patriot (470)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Quad (471)
  { }, // Coastguard (472)
  { }, // Dinghy (473)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hermes (474)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Sabre (475)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Rustler (476)
  { 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // ZR-350 (477)
  { 1004, 1005, 1008, 1009, 1010, 1012, 1013, 1020, 1021, 1022, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Walton (478)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Regina (479)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Comet (480)
  { }, // BMX (481)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Burrito (482)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Camper (483)
  { }, // Marquis (484)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Baggage (485)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Dozer (486)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Maverick (487)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // News Chopper (488)
  { 1000, 1002, 1004, 1005, 1006, 1008, 1009, 1010, 1013, 1016, 1018, 1019, 1020, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Rancher (489)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // FBI Rancher (490)
  { 1003, 1007, 1008, 1009, 1010, 1014, 1017, 1018, 1019, 1020, 1021, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Virgo (491)
  { 1000, 1004, 1005, 1006, 1008, 1009, 1010, 1016, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Greenwood (492)
  { }, // Jetmax (493)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hotring (494)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Sandking (495)
  { 1001, 1002, 1003, 1006, 1007, 1008, 1009, 1010, 1011, 1017, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143 }, // Blista Compact (496)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Police Maverick (497)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Boxville (498)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Benson (499)
  { 1008, 1009, 1010, 1013, 1019, 1020, 1021, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Mesa (500)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // RC Goblin (501)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hotring Racer A (502)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hotring Racer B (503)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Bloodring Banger (504)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Rancher (505)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Super GT (506)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Elegant (507)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Journey (508)
  { }, // Bike (509)
  { }, // Mountain Bike (510)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Beagle (511)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Cropdust (512)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Stunt (513)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Tanker (514)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Roadtrain (515)
  { 1000, 1002, 1004, 1007, 1008, 1009, 1010, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Nebula (516)
  { 1002, 1003, 1007, 1008, 1009, 1010, 1016, 1017, 1018, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Majestic (517)
  { 1001, 1003, 1005, 1006, 1007, 1008, 1009, 1010, 1013, 1017, 1018, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Buccaneer (518)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Shamal (519)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hydra (520)
  { }, // FCR-900 (521)
  { }, // NRG-500 (522)
  { }, // HPV1000 (523)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Cement Truck (524)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Tow Truck (525)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Fortune (526)
  { 1001, 1007, 1008, 1009, 1010, 1014, 1015, 1017, 1018, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Cadrona (527)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // FBI Truck (528)
  { 1001, 1003, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1017, 1018, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Willard (529)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Forklift (530)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Tractor (531)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Combine (532)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Feltzer (533)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1100, 1101, 1106, 1122, 1123, 1124, 1125, 1126, 1127, 1178, 1179, 1180, 1185 }, // Remington (534)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1109, 1110, 1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121 }, // Slamvan (535)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1103, 1104, 1105, 1107, 1108, 1128, 1181, 1182, 1183, 1184 }, // Blade (536)
  { }, // Freight (537)
  { }, // Streak (538)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Vortex (539)
  { 1001, 1004, 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1020, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Vincent (540)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Bullet (541)
  { 1008, 1009, 1010, 1014, 1015, 1018, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1144, 1145 }, // Clover (542)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Sadler (543)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Firetruck LA (544)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hustler (545)
  { 1001, 1002, 1004, 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Intruder (546)
  { 1000, 1003, 1008, 1009, 1010, 1016, 1018, 1019, 1020, 1021, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143 }, // Primo (547)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Cargobob (548)
  { 1001, 1003, 1007, 1008, 1009, 1010, 1011, 1012, 1017, 1018, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Tampa (549)
  { 1001, 1003, 1004, 1005, 1006, 1008, 1009, 1010, 1018, 1019, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Sunrise (550)
  { 1002, 1003, 1005, 1006, 1008, 1009, 1010, 1016, 1018, 1019, 1020, 1021, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Merit (551)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Utility (552)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Nevada (553)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Yosemite (554)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Windsor (555)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Monster A (556)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Monster B (557)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1096, 1097, 1098, 1163, 1164, 1165, 1166, 1167, 1168 }, // Uranus (558)
  { 1008, 1009, 1010, 1025, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1158, 1159, 1160, 1161, 1162, 1173 }, // Jester (559)
  { 1008, 1009, 1010, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1138, 1139, 1140, 1141, 1169, 1170 }, // Sultan (560)
  { 1008, 1009, 1010, 1025, 1026, 1027, 1030, 1031, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 1062, 1063, 1064, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1154, 1155, 1156, 1157 }, // Stratum (561)
  { 1008, 1009, 1010, 1025, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1146, 1147, 1148, 1149, 1171, 1172 }, // Elegy (562)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Raindance (563)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // RC Tiger (564)
  { 1008, 1009, 1010, 1025, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1150, 1151, 1152, 1153 }, // Flash (565)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Tahoma (566)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1102, 1129, 1130, 1131, 1132, 1133, 1186, 1187, 1188, 1189 }, // Savanna (567)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Bandito (568)
  { }, // Freight Flat (569)
  { }, // Streak Carriage (570)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Kart (571)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Mower (572)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Duneride (573)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Sweeper (574)
  { 1008, 1009, 1010, 1025, 1042, 1043, 1044, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1099, 1174, 1175, 1176, 1177 }, // Broadway (575)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1134, 1135, 1136, 1137, 1190, 1191, 1192, 1193 }, // Tornado (576)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // AT-400 (577)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // DFT-30 (578)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Huntley (579)
  { 1001, 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1020, 1023, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Stafford (580)
  { }, // BF-400 (581)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Newsvan (582)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Tug (583)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Trailer 3 (584)
  { 1000, 1001, 1002, 1003, 1006, 1007, 1008, 1009, 1010, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Emperor (585)
  { }, // Wayfarer (586)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Euros (587)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Hotdog (588)
  { 1000, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013, 1016, 1017, 1018, 1020, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1144, 1145 }, // Club (589)
  { }, // Freight Carriage (590)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Trailer 3 (591)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Andromada (592)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Dodo (593)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // RC Cam (594)
  { }, // Launch (595)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Police Car (LSPD) (596)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Police Car (SFPD) (597)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Police Car (LVPD) (598)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Police Ranger (599)
  { 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1013, 1017, 1018, 1020, 1022, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Picador (600)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // S.W.A.T. Van (601)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Alpha (602)
  { 1001, 1006, 1007, 1008, 1009, 1010, 1017, 1018, 1019, 1020, 1023, 1024, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098, 1142, 1143, 1144, 1145 }, // Phoenix (603)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Glendale (604)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Sadler (605)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Luggage Trailer A (606)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Luggage Trailer B (607)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Stair Trailer (608)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Boxville (609)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 }, // Farm Plow (610)
  { 1008, 1009, 1010, 1025, 1073, 1074, 1075, 1076, 1077, 1078, 1079, 1080, 1081, 1082, 1083, 1084, 1085, 1086, 1087, 1096, 1097, 1098 } // Utility Trailer (611)
};

new
  // Untuk iterator mod yang kompatibel berdasarkan model-nya.
  // Sebenarnya untuk mempermudah pencarian ID component-nya pake Iter_Contains.
  Iterator:g_Iter_VVM[MAX_VEHICLE_MODELS]<MAX_VEHICLE_MOD_ID>,
  // Untuk menyimpan section mod yang bisa di-mod berdasarkan ID model-nya.
  Iterator:gI_VehModableSect[MAX_VEHICLE_MODELS]<MAX_VEHICLE_MOD_SECTIONS>,
  g_VehicleModableSections[MAX_VEHICLE_MODELS][256],
  // Untuk menyimpan daftar komponen mod yang bisa di-mod dan dipisah berdasarkan section-nya.
  Iterator:gI_VehModableComp[MAX_VEHICLE_MODELS]<MAX_VEHICLE_MOD_SECTIONS, MAX_VEHICLE_MOD_ID>,
  g_VehicleModableComponents[MAX_VEHICLE_MODELS][MAX_VEHICLE_MOD_SECTIONS][512]
;

IsModValid(vehicleid, componentid)
{
  new model = GetVehicleModel(vehicleid);
  
  //Untuk ngecheck component id kurang dari 1000 dan lebih dari max vehicle mod id
  if(componentid < 1000 || componentid > MAX_VEHICLE_MOD_ID+1)
  {
    return 0;
  }
  //Untuk ngecheck model kendaraan nya valid
  if(model < 400 || model > 611)
  {
    return 0;
  }
  //untuk ngecheck kalau model id kendaraannya valid.
  model = model - 400;


  if(!Iter_Contains(g_Iter_VVM[model], componentid)) // Kalau komponennya valid, di add
  {
    return 0;
  }
  return 1;
}

VehicleMod_GetSectionName(section, value[], length = sizeof(value))
{
  format(value, length, "(unknown)");

  if (section < 0 || section > MAX_VEHICLE_MOD_SECTIONS)
  {
    return 1;
  }

  format(value, length, "%s", g_VehicleModSections[section]);
  return 1;
}

VehicleMod_GetComponentName(componentid, bool:include_section_name = true, value[], length = sizeof(value))
{
  format(value, length, "");

  if (componentid < 1000 || componentid > (MAX_VEHICLE_MOD_ID+1))
  {
    return 1;
  }

  if (include_section_name)
  {
    new mod_section = g_VehicleMods[componentid - 1000][VEHICLE_MOD_MODEL_SECTION];
    format(value, length, "%s - ", g_VehicleModSections[mod_section]);
  }

  strcat(value, g_VehicleMods[componentid - 1000][VEHICLE_MOD_MODEL_BRAND], length);
  return 1;
}

VehicleMod_GetComponentSection(componentid)
{
  if (componentid < 1000 || componentid > 1194)
  {
    return INVALID_VEHICLE_MOD_SECTION_ID;
  }

  componentid = componentid - 1000;
  return g_VehicleMods[componentid][VEHICLE_MOD_MODEL_SECTION];
}

Vehicle_HasAnyModableComponent(vehicleid)
{
  new model = GetVehicleModel(vehicleid);

  //Untuk ngecheck model kendaraan nya valid
  if(model < 400 || model > 611)
  {
    return 0;
  }

  //untuk ngecheck kalau model id kendaraannya valid.
  model = model - 400;

  if(Iter_Count(g_Iter_VVM[model]) < 1) // Kalau jumlah component yang bisa di-mod kurang dari 1, berarti tidak bisa di-mod.
  {
    return 0;
  }

  return 1;
}

Vehicle_IsModSectionModable(vehicleid, section)
{
  new model = GetVehicleModel(vehicleid);
  
  // Untuk memeriksa section-nya kurang dari 0 dan lebih dari MAX_VEHICLE_MOD_SECTIONS
  if(section < 0 || section > MAX_VEHICLE_MOD_SECTIONS+1)
  {
    return 0;
  }
  //Untuk ngecheck model kendaraan nya valid
  if(model < 400 || model > 611)
  {
    return 0;
  }
  //untuk ngecheck kalau model id kendaraannya valid.
  model = model - 400;


  if(!Iter_Contains(gI_VehModableSect[model], section)) // Kalau section-nya valid, di add
  {
    return 0;
  }
  return 1;
}

Vehicle_GetModableSection(vehicleid, value[], length  = sizeof(value))
{
  // Reset value terlebih dahulu.
  format(value, length, "");

  // Mengembalikan ID model kendaraannya.
  new model = GetVehicleModel(vehicleid);

  // Jika tidak ada section yang bisa di-mod, maka hanya mengembalikan header-nya saja.
  if(!model || !Vehicle_HasAnyModableComponent(vehicleid))
  {
    format(value, length, "Section ID\tSection Name\n");
    return 1;
  }

  model = model - 400;

  format(value, length, "%s", g_VehicleModableSections[model]);
  return 1;
}

Vehicle_GetModableComponent(vehicleid, section, bool:modelid_only, value[], length = sizeof(value))
{
  // Reset value terlebih dahulu.
  format(value, length, "");

  // Mengembalikan ID model kendaraannya.
  new model = GetVehicleModel(vehicleid);

  // Jika tidak ada section yang bisa di-mod, maka hanya mengembalikan header-nya saja.
  if(!model || section < 0 || section > MAX_VEHICLE_MOD_SECTIONS+1 || !Vehicle_HasAnyModableComponent(vehicleid))
  {
    if (!modelid_only)
    {
      format(value, length, "Component ID\tComponent Name\n");
    }

    return 1;
  }

  model = model - 400;

  if (modelid_only)
  {
    foreach(new i : gI_VehModableComp[model]<section>)
    {
      if (strlen(value) < 1)
      {
        format(value, length, "%d\n", i);
      }
      else
      {
        format(value, length, "%s%d\n", value, i);
      }
    }
  }
  else
  {
    format(value, length, "%s", g_VehicleModableComponents[model][section]);
  }

  return 1;
}

Vehicle_RegisterValidMod(modelid, componentid)
{
  new valid_mod_index = componentid - 1000;
  new section = g_VehicleMods[valid_mod_index][VEHICLE_MOD_MODEL_SECTION];

  if (!Iter_Contains(gI_VehModableSect[modelid], section))
  {
    Iter_Add(gI_VehModableSect[modelid], section);
  }

  if (!Iter_Contains(gI_VehModableComp[modelid]<section>, componentid))
  {
    Iter_Add(gI_VehModableComp[modelid]<section>, componentid);
  }
}

Vehicle_BuildComponentList(modelid, section)
{
  if (modelid < 0 || modelid > MAX_VEHICLE_MODELS)
  {
    return 1;
  }

  if (section < 0 || section > MAX_VEHICLE_MOD_SECTIONS)
  {
    return 1;
  }

  new str[64];
  format(g_VehicleModableComponents[modelid][section], 512, "Component ID\tComponent Name\n");

  foreach(new componentid : gI_VehModableComp[modelid]<section>)
  {
    new valid_mod_index = componentid - 1000;

    format(str, sizeof(str), "%d\t%s\n", componentid, g_VehicleMods[valid_mod_index][VEHICLE_MOD_MODEL_BRAND]);
    strcat(g_VehicleModableComponents[modelid][section], str);
  }

  // printf("modelid: %d -> component string:\n%s", modelid+400, g_VehicleModableComponents[modelid][section]);
  return 1;
}

Vehicle_BuildSectionList(modelid)
{
  if (modelid < 0 || modelid > MAX_VEHICLE_MODELS)
  {
    return 1;
  }

  new str[64];
  format(g_VehicleModableSections[modelid], 256, "Section ID\tSection Name\n");

  foreach(new i : gI_VehModableSect[modelid])
  {
    format(str, sizeof(str), "%d\t%s\n", i, g_VehicleModSections[i]);
    strcat(g_VehicleModableSections[modelid], str);

    // printf("modelid: %d -> section: %d -> section string:\n%s", modelid+400, i, g_VehicleModableSections[modelid]);
    Vehicle_BuildComponentList(modelid, i);
  }

  return 1;
}

hook OnGameModeInit()
{
  // Inisialisasi iterator.
  Iter_Init(g_Iter_VVM);
  Iter_Init(gI_VehModableSect);
  Iter_Init(gI_VehModableComp);

  // Memuat mod ke section yang sesuai.
  // PreLoadVehicleModSections();

  // Memasukkan semua ID mod component-nya ke dalam iterator.
  for (new model = 0; model < MAX_VEHICLE_MODELS; model++)
  {
    for (new mod = 0; mod < MAX_VEHICLE_COMPAT_MODS; mod++)
    {
          // Hanya memasukkan ID mod lebih dari atau sama dengan 1000.
      if (g_VehicleValidMods[model][mod] >= 1000)
      {
        Iter_Add(g_Iter_VVM[model], g_VehicleValidMods[model][mod]);
        Vehicle_RegisterValidMod(model, g_VehicleValidMods[model][mod]);
      }			
    }

    // Membentuk string dialog untuk menampilkan section mod yang valid untuk model kendaraannya.
    Vehicle_BuildSectionList(model);

    // Untuk memuat informasi mod yang cocok berdasarkan ID model kendaraannya.
    // printf("Vehicle Mod Compability -> modelid: %d | model_name: %s | compatible mods: %d mods", 400 + model, GetVehicleNameByModel(400 + model), Iter_Count(g_Iter_VVM[model]));
  }
  return 1;
}

#include <YSI\y_hooks>