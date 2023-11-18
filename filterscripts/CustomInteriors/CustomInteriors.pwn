#define FILTERSCRIPT

#include <a_samp>
#include <streamer>

// --- Businesses
#include "interiors/business/burger1"
#include "interiors/business/electronic1"
#include "interiors/business/gassuperint1"
// --- Houses
#include "interiors/house/house001"
#include "interiors/house/house002"
#include "interiors/house/house003"
#include "interiors/house/house004"
#include "interiors/house/house005"
#include "interiors/house/house006"
#include "interiors/house/house007"
#include "interiors/house/house008"
#include "interiors/house/house009"
#include "interiors/house/house010"
#include "interiors/house/house011"
// --- Factions
#include "interiors/faction/lspd_jail"

public OnFilterScriptInit()
{
  // --- Businesses
  Init_BurgerShop1Int(3);
  Init_ElectronicShop1Int(1);
  Init_GasStationSuper1Int(2);
  // --- Houses
  Init_House001Int(1);
  Init_House002Int(1);
  Init_House003Int(1);
  Init_House004Int(1);
  Init_House005Int(1);
  Init_House006Int(1);
  Init_House007Int(1);
  Init_House008Int(1);
  Init_House009Int(1);
  Init_House010Int(1);
  Init_House011Int(1);
  // --- Faction
  Init_LSPDJail(2);
  return 1;
}

public OnFilterScriptExit()
{
  return 1;
}
