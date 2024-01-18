#include <YSI\y_hooks>

/**
 *
 * Macros
 *
 */
#define TEXTDRAW_BRIGHT2  "~h~~h~"

#define SPEEDO_Y_COORD    (5.0)

/**
 *
 * Variables
 *
 */

// new PlayerText:Speedo_Health[MAX_PLAYERS];
new PlayerText:SpeedometerTextdraw[MAX_PLAYERS][3];
new PlayerBar:FuelBar[MAX_PLAYERS];
new PlayerBar:DamageBar[MAX_PLAYERS];
/**
 *
 * Functions
 *
 */
SpeedometerNew_Init(playerid)
{
  SpeedometerTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, 436.000000, 414.000000, "5");
  PlayerTextDrawFont(playerid, SpeedometerTextdraw[playerid][0], 1);
  PlayerTextDrawLetterSize(playerid, SpeedometerTextdraw[playerid][0], 0.162497, 0.899999);
  PlayerTextDrawTextSize(playerid, SpeedometerTextdraw[playerid][0], 342.000000, 7.500000);
  PlayerTextDrawSetOutline(playerid, SpeedometerTextdraw[playerid][0], 0);
  PlayerTextDrawSetShadow(playerid, SpeedometerTextdraw[playerid][0], 0);
  PlayerTextDrawAlignment(playerid, SpeedometerTextdraw[playerid][0], 2);
  PlayerTextDrawColor(playerid, SpeedometerTextdraw[playerid][0], 255);
  PlayerTextDrawBackgroundColor(playerid, SpeedometerTextdraw[playerid][0], 255);
  PlayerTextDrawBoxColor(playerid, SpeedometerTextdraw[playerid][0], -1);
  PlayerTextDrawUseBox(playerid, SpeedometerTextdraw[playerid][0], 1);
  PlayerTextDrawSetProportional(playerid, SpeedometerTextdraw[playerid][0], 1);
  PlayerTextDrawSetSelectable(playerid, SpeedometerTextdraw[playerid][0], 0);
  
  SpeedometerTextdraw[playerid][1] = CreatePlayerTextDraw(playerid, 474.000000, 412.000000, "Infernus");
  PlayerTextDrawFont(playerid, SpeedometerTextdraw[playerid][1], 1);
  PlayerTextDrawLetterSize(playerid, SpeedometerTextdraw[playerid][1], 0.141663, 1.250000);
  PlayerTextDrawTextSize(playerid, SpeedometerTextdraw[playerid][1], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, SpeedometerTextdraw[playerid][1], 1);
  PlayerTextDrawSetShadow(playerid, SpeedometerTextdraw[playerid][1], 0);
  PlayerTextDrawAlignment(playerid, SpeedometerTextdraw[playerid][1], 2);
  PlayerTextDrawColor(playerid, SpeedometerTextdraw[playerid][1], -1);
  PlayerTextDrawBackgroundColor(playerid, SpeedometerTextdraw[playerid][1], 255);
  PlayerTextDrawBoxColor(playerid, SpeedometerTextdraw[playerid][1], 50);
  PlayerTextDrawUseBox(playerid, SpeedometerTextdraw[playerid][1], 0);
  PlayerTextDrawSetProportional(playerid, SpeedometerTextdraw[playerid][1], 1);
  PlayerTextDrawSetSelectable(playerid, SpeedometerTextdraw[playerid][1], 0);
  
  SpeedometerTextdraw[playerid][2] = CreatePlayerTextDraw(playerid, 431.000000, 427.000000, "100_MPH");
  PlayerTextDrawFont(playerid, SpeedometerTextdraw[playerid][2], 1);
  PlayerTextDrawLetterSize(playerid, SpeedometerTextdraw[playerid][2], 0.141663, 1.000000);
  PlayerTextDrawTextSize(playerid, SpeedometerTextdraw[playerid][2], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, SpeedometerTextdraw[playerid][2], 0);
  PlayerTextDrawSetShadow(playerid, SpeedometerTextdraw[playerid][2], 0);
  PlayerTextDrawAlignment(playerid, SpeedometerTextdraw[playerid][2], 1);
  PlayerTextDrawColor(playerid, SpeedometerTextdraw[playerid][2], -1);
  PlayerTextDrawBackgroundColor(playerid, SpeedometerTextdraw[playerid][2], 255);
  PlayerTextDrawBoxColor(playerid, SpeedometerTextdraw[playerid][2], 50);
  PlayerTextDrawUseBox(playerid, SpeedometerTextdraw[playerid][2], 0);
  PlayerTextDrawSetProportional(playerid, SpeedometerTextdraw[playerid][2], 1);
  PlayerTextDrawSetSelectable(playerid, SpeedometerTextdraw[playerid][2], 0);

  DamageBar[playerid] = CreatePlayerProgressBar(playerid, 464.000000, 438.000000, 26.000000, 8.500000, -16776961, 100.000000, 0);
  SetPlayerProgressBarValue(playerid, DamageBar[playerid], 50.000000);
  
  FuelBar[playerid] = CreatePlayerProgressBar(playerid, 488.000000, 438.000000, 23.000000, 8.500000, 1097458175, 100.000000, 0);
  SetPlayerProgressBarValue(playerid, FuelBar[playerid], 50.000000);
  return 1;
}

Speedometer_Initialize(playerid)
{
  VehiclesTextdraw[playerid][0] = CreatePlayerTextDraw(playerid, 519.000000, 323.000000, "ld_dual:white");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][0], 4);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][0], 0.600000, 2.000000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][0], 85.000000, 51.000000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][0], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][0], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][0], 1);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][0], 255);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][0], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][0], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][0], 1);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][0], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][0], 0);

  VehiclesTextdraw[playerid][1] = CreatePlayerTextDraw(playerid, 520.000000, 324.000000, "ld_dual:white");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][1], 4);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][1], 0.600000, 2.000000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][1], 81.000000, 48.500000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][1], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][1], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][1], 1);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][1], 1296911871);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][1], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][1], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][1], 1);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][1], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][1], 0);

  VehiclesTextdraw[playerid][2] = CreatePlayerTextDraw(playerid, 584.000000, 310.000000, "ld_pool:ball");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][2], 4);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][2], 0.600000, 2.000000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][2], 54.000000, 66.500000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][2], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][2], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][2], 1);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][2], 1296911871);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][2], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][2], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][2], 1);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][2], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][2], 0);

  VehiclesTextdraw[playerid][3] = CreatePlayerTextDraw(playerid, 584.000000, 292.000000, "Preview_Model");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][3], 5);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][3], 0.600000, 2.000000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][3], 65.500000, 92.500000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][3], 0);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][3], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][3], 1);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][3], -1);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][3], 0);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][3], 255);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][3], 0);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][3], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][3], 0);
  PlayerTextDrawSetPreviewModel(playerid, VehiclesTextdraw[playerid][3], 560);
  PlayerTextDrawSetPreviewRot(playerid, VehiclesTextdraw[playerid][3], -10.000000, 0.000000, -20.000000, 1.000000);
  PlayerTextDrawSetPreviewVehCol(playerid, VehiclesTextdraw[playerid][3], 1, 1);

  VehiclesTextdraw[playerid][4] = CreatePlayerTextDraw(playerid, 524.000000, 326.000000, "Heath:");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][4], 1);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][4], 0.162496, 1.200000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][4], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][4], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][4], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][4], 1);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][4], -1);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][4], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][4], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][4], 0);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][4], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][4], 0);

  VehiclesTextdraw[playerid][5] = CreatePlayerTextDraw(playerid, 524.000000, 337.000000, "Speed:");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][5], 1);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][5], 0.170833, 1.200000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][5], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][5], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][5], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][5], 1);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][5], -1);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][5], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][5], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][5], 0);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][5], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][5], 0);

  VehiclesTextdraw[playerid][6] = CreatePlayerTextDraw(playerid, 524.000000, 349.000000, "Fuel:");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][6], 1);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][6], 0.170833, 1.200000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][6], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][6], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][6], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][6], 1);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][6], -1);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][6], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][6], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][6], 0);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][6], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][6], 0);

  VehiclesTextdraw[playerid][7] = CreatePlayerTextDraw(playerid, 547.000000, 326.000000, "100.0%");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][7], 1);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][7], 0.162496, 1.200000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][7], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][7], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][7], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][7], 1);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][7], 1433087999);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][7], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][7], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][7], 0);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][7], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][7], 0);

  VehiclesTextdraw[playerid][8] = CreatePlayerTextDraw(playerid, 553.000000, 337.000000, "100");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][8], 1);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][8], 0.170833, 1.200000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][8], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][8], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][8], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][8], 2);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][8], 1433087999);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][8], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][8], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][8], 0);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][8], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][8], 0);

  VehiclesTextdraw[playerid][9] = CreatePlayerTextDraw(playerid, 568.000000, 337.000000, "Mph");
  PlayerTextDrawFont(playerid, VehiclesTextdraw[playerid][9], 1);
  PlayerTextDrawLetterSize(playerid, VehiclesTextdraw[playerid][9], 0.170833, 1.200000);
  PlayerTextDrawTextSize(playerid, VehiclesTextdraw[playerid][9], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, VehiclesTextdraw[playerid][9], 1);
  PlayerTextDrawSetShadow(playerid, VehiclesTextdraw[playerid][9], 0);
  PlayerTextDrawAlignment(playerid, VehiclesTextdraw[playerid][9], 2);
  PlayerTextDrawColor(playerid, VehiclesTextdraw[playerid][9], -1);
  PlayerTextDrawBackgroundColor(playerid, VehiclesTextdraw[playerid][9], 255);
  PlayerTextDrawBoxColor(playerid, VehiclesTextdraw[playerid][9], 50);
  PlayerTextDrawUseBox(playerid, VehiclesTextdraw[playerid][9], 0);
  PlayerTextDrawSetProportional(playerid, VehiclesTextdraw[playerid][9], 1);
  PlayerTextDrawSetSelectable(playerid, VehiclesTextdraw[playerid][9], 0);


  /*Player Progress Bars
  Requires "progress2" include by Southclaws
  Download: https://github.com/Southclaws/progress2/releases */
  FuellBar[playerid] = CreatePlayerProgressBar(playerid, 526.000000, 363.000000, 62.000000, 4.000000, -1, 100.000000, 0);
  SetPlayerProgressBarValue(playerid, FuellBar[playerid], 50.000000);
}

// Speedometer_Destroy(playerid)
// {
//   for(new i = 0; i < 3; i++ )
//   {
//     PlayerTextDrawDestroy(playerid, SpeedometerTextdraw[playerid][i]);
//   }
//   // for(new i = 0; i < 6; i++ )
//   // {
//   //   TextDrawDestroy(playerid, VehicleTextdraw[i]);
//   // }
//   DestroyPlayerProgressBar(playerid, FuelBar[playerid]);
//   DestroyPlayerProgressBar(playerid, DamageBar[playerid]);
// }

SpeedometerNew_Hide(playerid)
{
  for(new i = 0; i < 3; i++ )
  {
    PlayerTextDrawHide(playerid, SpeedometerTextdraw[playerid][i]);
  }
  for(new i = 0; i < 6; i++ )
  {
    TextDrawHideForPlayer(playerid, VehicleTextdraw[i]);
  }
  HidePlayerProgressBar(playerid, FuelBar[playerid]);
  HidePlayerProgressBar(playerid, DamageBar[playerid]);
}

Speedometer_UpdateModel(playerid)
{
  new
    vehicleid = GetPlayerVehicleID(playerid)
  ;
  if (vehicleid == INVALID_VEHICLE_ID)
  {
    return 0;
  }
  new modelid = GetVehicleModel(vehicleid);
  if (modelid < 400 || modelid > 611)
  {
    return 0;
  }
  new color1, color2;
  GetVehicleColor(vehicleid, color1, color2);
  // Mendapatkan nama kendaraan dan meng-update nya.
  // strcat(name, GetVehicleNameByVehicle(vehicleid));
  // PlayerTextDrawSetString(playerid, g_Speedo_Vehicle_Name[playerid], name);
  PlayerTextDrawHide(playerid, VehiclesTextdraw[playerid][3]);
  PlayerTextDrawSetPreviewModel(playerid, VehiclesTextdraw[playerid][3], modelid);
  PlayerTextDrawSetPreviewVehCol(playerid, VehiclesTextdraw[playerid][3], color1, color2);
  PlayerTextDrawShow(playerid, VehiclesTextdraw[playerid][3]);
  return 1;
}

Speedometer_Hide(playerid)
{
  for(new i = 0; i < 10; i++)
  {
    PlayerTextDrawHide(playerid, VehiclesTextdraw[playerid][i]);
  }
  HidePlayerProgressBar(playerid, FuellBar[playerid]);
  return 1;
}

Speedometer_Show(playerid)
{
  for(new i = 0; i < 10; i++)
  {
    PlayerTextDrawShow(playerid, VehiclesTextdraw[playerid][i]);
  }
  ShowPlayerProgressBar(playerid, FuellBar[playerid]);
  return 1;
}
SpeedometerNew_Show(playerid)
{
  for(new i = 0; i < 3; i++ )
  {
    PlayerTextDrawShow(playerid, SpeedometerTextdraw[playerid][i]);
  }
  for(new i = 0; i < 6; i++ )
  {
    TextDrawShowForPlayer(playerid, VehicleTextdraw[i]);
  }
  ShowPlayerProgressBar(playerid, FuelBar[playerid]);
  ShowPlayerProgressBar(playerid, DamageBar[playerid]);
}

// Speedometer_GetTransmission(vehicleid, dest[], len = sizeof(dest))
// {
//   if (IsVehicleDrivingBackwards(vehicleid))
//   {
//     format(dest, len, "~r~"TEXTDRAW_BRIGHT2"R ~b~N ~g~D");
//   }
//   else if (GetVehicleSpeed(vehicleid) < 1.0)
//   {
//     format(dest, len, "~r~R ~b~"TEXTDRAW_BRIGHT2"N ~g~D");
//   }
//   else
//   {
//     format(dest, len, "~r~R ~b~N ~g~"TEXTDRAW_BRIGHT2"D");
//   }

//   return 1;
// }

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
  if(newstate == PLAYER_STATE_DRIVER)
  {
    Speedometer_UpdateModel(playerid);
  }
  return 1;
}

Speedometer_Update(playerid)
{
  // Mendapatkan ID kendaraan player.
  new vehicleid = GetPlayerVehicleID(playerid);

  // Abaikan jika kendaraannya tidak valid.
  if (vehicleid == INVALID_VEHICLE_ID)
  {
    return 1;
  }

  // Abaikan jika kendaraannya tidak memiliki speedometer.
  if (!IsSpeedoVehicle(vehicleid))
  {
    return 1;
  }

  new
    speed = floatround(GetVehicleSpeed(vehicleid)),
    // transmission[40],
    Float:max_health = 1000.0,
    Float:health,
    Float:fuel = Vehicle_GetFuel(vehicleid)
  ;

  // Mendapatkan health kendaraan.
  GetVehicleHealth(vehicleid, health);

  // Mendapatkan state transmisi kendaraan,
  // Speedometer_GetTransmission(vehicleid, transmission);

  // Memeriksa upgrade engine kendaraan.
  // Fungsinya untuk mencocokkan health kendaraan dengan engine upgrade-nya.
  if (VehicleData[Vehicle_ReturnID(vehicleid)][vehEngineUpgrade] == 1)
  {
    if (health > 2000.0)
    {
      health = 2000.0;
    }
    max_health = 2000.0;
  }
  else
  {
    if (health > 1000.0)
    {
      health = 1000.0;
    }
  }
  if(PlayerData[playerid][pHudStyle] == 0)
  {
    PlayerTextDrawSetString(playerid, VehiclesTextdraw[playerid][8], sprintf("%d", speed));
    // PlayerTextDrawSetString(playerid, g_Speedo_Transmission_Value[playerid], transmission);
    PlayerTextDrawSetString(playerid, VehiclesTextdraw[playerid][7], sprintf("%.1f", health));
    // PlayerTextDrawSetString(playerid, FUELVALUE_SPEEDO[playerid], sprintf("%.0fL", fuel));
    SetPlayerProgressBarValue(playerid, FuellBar[playerid], fuel);
    Speedometer_UpdateModel(playerid);
  }
  else
  {
    PlayerTextDrawSetString(playerid, SpeedometerTextdraw[playerid][0], sprintf("%d", vehicleid));
    PlayerTextDrawSetString(playerid, SpeedometerTextdraw[playerid][1], sprintf("%s", GetVehicleNameByModel(GetVehicleModel(vehicleid))));
    PlayerTextDrawSetString(playerid, SpeedometerTextdraw[playerid][2], sprintf("%d_km/h", speed));

    SetPlayerProgressBarValue(playerid, FuelBar[playerid], fuel);
    SetPlayerProgressBarValue(playerid, DamageBar[playerid], health);
    SetPlayerProgressBarMaxValue(playerid, DamageBar[playerid], max_health);
    
    // PlayerTextDrawSetString(playerid, g_Speedo_Transmission_Value[playerid], transmission);
    //PlayerTextDrawSetString(playerid, Speedo_Fuel_Amount[playerid], sprintf("%.0fL", fuel));
  }

  // if (IsABicycle(vehicleid))
  // {
  //   // PlayerTextDrawSetString(playerid, g_Speedo_Mileage_Value[playerid], "- / -");
  //   PlayerTextDrawSetString(playerid, g_Speedo_Mileage_Value[playerid], "- / -");
  // }
  // else
  // {
  //   new
  //     accumulated_mileage = Vehicle_GetAccumulatedMileage(vehicleid),
  //     current_mileage = Vehicle_GetCurrentMileage(vehicleid)
  //     // durability_mileage = Vehicle_GetDurabilityMileage(vehicleid)
  //   ;

  //   PlayerTextDrawSetString(
  //     playerid,
  //     g_Speedo_Mileage_Value[playerid],
  //     // sprintf("%s / %s", FormatNumber(accumulated_mileage + current_mileage, "", "."), FormatNumber(accumulated_mileage + durability_mileage, "", "."))
  //     sprintf("%s", FormatNumber(accumulated_mileage + current_mileage, "", "."))
  //   );
  // }
  // SetPlayerProgressBarValue(playerid, g_Speedo_Fuel_Bar[playerid], fuel);
  return 1;
}

/**
 *
 * Callbacks
 *
 */

ptask Player_SpeedoUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
    
    // Abaikan jika state player bukan pengemudi.
    // Abaikan jika opsi speedomter dimatikan.
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !PlayerData[playerid][pDisableSpeedo])
    {
        Speedometer_Update(playerid);
    }
    return 1;
}

SpeedRadar_Init(playerid)
{
    RadarBOX[playerid] = CreatePlayerTextDraw(playerid, 557.000000, 121.000000, "_");
    PlayerTextDrawFont(playerid, RadarBOX[playerid], 1);
    PlayerTextDrawLetterSize(playerid, RadarBOX[playerid], 0.600000, 5.899997);
    PlayerTextDrawTextSize(playerid, RadarBOX[playerid], 298.500000, 106.000000);
    PlayerTextDrawSetOutline(playerid, RadarBOX[playerid], 1);
    PlayerTextDrawSetShadow(playerid, RadarBOX[playerid], 0);
    PlayerTextDrawAlignment(playerid, RadarBOX[playerid], 2);
    PlayerTextDrawColor(playerid, RadarBOX[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, RadarBOX[playerid], 255);
    PlayerTextDrawBoxColor(playerid, RadarBOX[playerid], 100);
    PlayerTextDrawUseBox(playerid, RadarBOX[playerid], 1);
    PlayerTextDrawSetProportional(playerid, RadarBOX[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, RadarBOX[playerid], 0);

    SpeedRadarTD[playerid] = CreatePlayerTextDraw(playerid, 533.000000, 119.000000, "Speed Radar");
    PlayerTextDrawFont(playerid, SpeedRadarTD[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpeedRadarTD[playerid], 0.212500, 1.000000);
    PlayerTextDrawTextSize(playerid, SpeedRadarTD[playerid], 620.000000, 15.500000);
    PlayerTextDrawSetOutline(playerid, SpeedRadarTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpeedRadarTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpeedRadarTD[playerid], 1);
    PlayerTextDrawColor(playerid, SpeedRadarTD[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SpeedRadarTD[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpeedRadarTD[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpeedRadarTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpeedRadarTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpeedRadarTD[playerid], 0);

    SpeedTextTD[playerid] = CreatePlayerTextDraw(playerid, 509.000000, 146.000000, "Speed");
    PlayerTextDrawFont(playerid, SpeedTextTD[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpeedTextTD[playerid], 0.225000, 1.100000);
    PlayerTextDrawTextSize(playerid, SpeedTextTD[playerid], 620.000000, 15.500000);
    PlayerTextDrawSetOutline(playerid, SpeedTextTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpeedTextTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpeedTextTD[playerid], 1);
    PlayerTextDrawColor(playerid, SpeedTextTD[playerid], 16777215);
    PlayerTextDrawBackgroundColor(playerid, SpeedTextTD[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpeedTextTD[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpeedTextTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpeedTextTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpeedTextTD[playerid], 0);

    ModelTextTD[playerid] = CreatePlayerTextDraw(playerid, 509.000000, 132.000000, "Model");
    PlayerTextDrawFont(playerid, ModelTextTD[playerid], 1);
    PlayerTextDrawLetterSize(playerid, ModelTextTD[playerid], 0.225000, 1.100000);
    PlayerTextDrawTextSize(playerid, ModelTextTD[playerid], 620.000000, 15.500000);
    PlayerTextDrawSetOutline(playerid, ModelTextTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, ModelTextTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, ModelTextTD[playerid], 1);
    PlayerTextDrawColor(playerid, ModelTextTD[playerid], 16777215);
    PlayerTextDrawBackgroundColor(playerid, ModelTextTD[playerid], 255);
    PlayerTextDrawBoxColor(playerid, ModelTextTD[playerid], 50);
    PlayerTextDrawUseBox(playerid, ModelTextTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, ModelTextTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, ModelTextTD[playerid], 0);

    PlateTextTD[playerid] = CreatePlayerTextDraw(playerid, 509.500000, 161.000000, "Plate");
    PlayerTextDrawFont(playerid, PlateTextTD[playerid], 1);
    PlayerTextDrawLetterSize(playerid, PlateTextTD[playerid], 0.225000, 1.100000);
    PlayerTextDrawTextSize(playerid, PlateTextTD[playerid], 620.000000, 15.500000);
    PlayerTextDrawSetOutline(playerid, PlateTextTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, PlateTextTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, PlateTextTD[playerid], 1);
    PlayerTextDrawColor(playerid, PlateTextTD[playerid], 16777215);
    PlayerTextDrawBackgroundColor(playerid, PlateTextTD[playerid], 255);
    PlayerTextDrawBoxColor(playerid, PlateTextTD[playerid], 50);
    PlayerTextDrawUseBox(playerid, PlateTextTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, PlateTextTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, PlateTextTD[playerid], 0);

    SeparatorTD[playerid] = CreatePlayerTextDraw(playerid, 538.000000, 127.000000, ":~n~:~n~:");
    PlayerTextDrawFont(playerid, SeparatorTD[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SeparatorTD[playerid], 0.316666, 1.650002);
    PlayerTextDrawTextSize(playerid, SeparatorTD[playerid], 620.000000, 15.500000);
    PlayerTextDrawSetOutline(playerid, SeparatorTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SeparatorTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, SeparatorTD[playerid], 1);
    PlayerTextDrawColor(playerid, SeparatorTD[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SeparatorTD[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SeparatorTD[playerid], 50);
    PlayerTextDrawUseBox(playerid, SeparatorTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SeparatorTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SeparatorTD[playerid], 0);

    ModelTD[playerid] = CreatePlayerTextDraw(playerid, 548.000000, 132.000000, "N/A");
    PlayerTextDrawFont(playerid, ModelTD[playerid], 1);
    PlayerTextDrawLetterSize(playerid, ModelTD[playerid], 0.204165, 0.949998);
    PlayerTextDrawTextSize(playerid, ModelTD[playerid], 614.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, ModelTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, ModelTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, ModelTD[playerid], 1);
    PlayerTextDrawColor(playerid, ModelTD[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, ModelTD[playerid], 255);
    PlayerTextDrawBoxColor(playerid, ModelTD[playerid], 50);
    PlayerTextDrawUseBox(playerid, ModelTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, ModelTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, ModelTD[playerid], 0);

    SpeedTD[playerid] = CreatePlayerTextDraw(playerid, 548.000000, 147.000000, "N/A");
    PlayerTextDrawFont(playerid, SpeedTD[playerid], 1);
    PlayerTextDrawLetterSize(playerid, SpeedTD[playerid], 0.204165, 0.949998);
    PlayerTextDrawTextSize(playerid, SpeedTD[playerid], 614.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, SpeedTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, SpeedTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, SpeedTD[playerid], 1);
    PlayerTextDrawColor(playerid, SpeedTD[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, SpeedTD[playerid], 255);
    PlayerTextDrawBoxColor(playerid, SpeedTD[playerid], 50);
    PlayerTextDrawUseBox(playerid, SpeedTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, SpeedTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, SpeedTD[playerid], 0);

    PlateTD[playerid] = CreatePlayerTextDraw(playerid, 548.000000, 162.000000, "N/A");
    PlayerTextDrawFont(playerid, PlateTD[playerid], 1);
    PlayerTextDrawLetterSize(playerid, PlateTD[playerid], 0.204165, 0.949998);
    PlayerTextDrawTextSize(playerid, PlateTD[playerid], 614.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlateTD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, PlateTD[playerid], 0);
    PlayerTextDrawAlignment(playerid, PlateTD[playerid], 1);
    PlayerTextDrawColor(playerid, PlateTD[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, PlateTD[playerid], 255);
    PlayerTextDrawBoxColor(playerid, PlateTD[playerid], 50);
    PlayerTextDrawUseBox(playerid, PlateTD[playerid], 0);
    PlayerTextDrawSetProportional(playerid, PlateTD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, PlateTD[playerid], 0);
    return 1;
}


EnableSpeedRadar(playerid)
{
    PlayerTextDrawShow(playerid, RadarBOX[playerid]);
    PlayerTextDrawShow(playerid, SpeedRadarTD[playerid]);
    PlayerTextDrawShow(playerid, SpeedTextTD[playerid]);
    PlayerTextDrawShow(playerid, ModelTextTD[playerid]);
    PlayerTextDrawShow(playerid, PlateTextTD[playerid]);
    PlayerTextDrawShow(playerid, SeparatorTD[playerid]);
    PlayerTextDrawShow(playerid, ModelTD[playerid]);
    PlayerTextDrawShow(playerid, SpeedTD[playerid]);
    PlayerTextDrawShow(playerid, PlateTD[playerid]);
    Player_RadarToggle[playerid] = true;
    return 1;
}

DisableSpeedRadar(playerid)
{
    PlayerTextDrawHide(playerid, RadarBOX[playerid]);
    PlayerTextDrawHide(playerid, SpeedRadarTD[playerid]);
    PlayerTextDrawHide(playerid, SpeedTextTD[playerid]);
    PlayerTextDrawHide(playerid, ModelTextTD[playerid]);
    PlayerTextDrawHide(playerid, PlateTextTD[playerid]);
    PlayerTextDrawHide(playerid, SeparatorTD[playerid]);
    PlayerTextDrawHide(playerid, ModelTD[playerid]);
    PlayerTextDrawHide(playerid, SpeedTD[playerid]);
    PlayerTextDrawHide(playerid, PlateTD[playerid]);
    Player_RadarToggle[playerid] = false;
    return 1;
}