#if defined _inc_hooks
  #undef _inc_hooks
#endif
#if defined SERVER_ECONOMY_HOOKS
  #endinput
#endif
#define SERVER_ECONOMY_HOOKS



#include <YSI_Coding\y_hooks>



hook OnScriptInit()
{
  Economy_InitEnum();
  Economy_InitTempEnum();
}

hook OnDBConnReady()
{
  printf("[SERVER ECONOMY] Initialization called.");
  Economy_InitORM();
  Economy_InitLoad();
}

hook OnScriptExit()
{
  Economy_Save();
}

hook OnEconomyInitLoaded()
{
  if (cache_num_rows() == 0)
  {
    print("[SERVER ECONOMY] Server economy not detected. Creating new one ...");

    Economy_InitEnum(false);
    Economy_CreateConfig();
    return 1;
  }

  static economyid;
  cache_get_value_name_int(0, "id", economyid);
  Economy_Load(economyid);
  return 1;
}

hook OnEconomyLoaded()
{
  printf("[SERVER ECONOMY] Server economy loaded. [SQL ID: %d | Supply: %s | Reserve: %s | Inflation rate: %d%% | Sales tax rate: %d%% | Treatment price: %s | Component price: %s]"
    , Economy_GetSQLID()
    , FormatNumber(Economy_GetSupply())
    , FormatNumber(Economy_GetReserve())
    , Economy_GetInflationRate()
    , Economy_GetSalesTaxRate()
    , FormatNumber(Economy_GetTreatmentPrice())
    , FormatNumber(Economy_GetComponentPrice())
  );

  Economy_UpdateSummary();
  Economy_UpdatePickupInfo();

  House_RefreshAll();
  Business_RefreshAll();
  Workshop_RefreshAll();
  return 1;
}

hook OnEconomyConfigCreated()
{
  Economy_Load();
  return 1;
}

hook OnEconomySaved(E_SERVER_ECONOMY_ACTION:action, amount)
{
  if (action == ECONOMY_ACTION_DEFLATE || action == ECONOMY_ACTION_INFLATE)
  {
    Economy_Recreate(action);
  }

  Economy_UpdateSummary();
  Economy_UpdatePickupInfo();
}

hook OnEconomyRecreated(E_SERVER_ECONOMY_ACTION:action)
{
  if (action == ECONOMY_ACTION_DEFLATE)
  {
    printf("[SERVER ECONOMY] New server economy implemented because deflated. [SQL ID: %d | Supply: %s | Reserve: %s | Inflation rate: %d%% | Sales tax rate: %d%%] | Treatment price: %s | Component price: %s]"
      , Economy_GetSQLID()
      , FormatNumber(Economy_GetSupply())
      , FormatNumber(Economy_GetReserve())
      , Economy_GetInflationRate()
      , Economy_GetSalesTaxRate()
      , FormatNumber(Economy_GetTreatmentPrice())
      , FormatNumber(Economy_GetComponentPrice())
    );
  }
  else if (action == ECONOMY_ACTION_INFLATE)
  {
    printf("[SERVER ECONOMY] New server economy implemented because inflated. [SQL ID: %d | Supply: %s | Reserve: %s | Inflation rate: %d%% | Sales tax rate: %d%%] | Treatment price: %s | Component price: %s]"
      , Economy_GetSQLID()
      , FormatNumber(Economy_GetSupply())
      , FormatNumber(Economy_GetReserve())
      , Economy_GetInflationRate()
      , Economy_GetSalesTaxRate()
      , FormatNumber(Economy_GetTreatmentPrice())
      , FormatNumber(Economy_GetComponentPrice())
    );
  }
  else
  {
    printf("[SERVER ECONOMY] New server economy implemented. [SQL ID: %d | Supply: %s | Reserve: %s | Inflation rate: %d%% | Sales tax rate: %d%%] | Treatment price: %s | Component price: %s]"
      , Economy_GetSQLID()
      , FormatNumber(Economy_GetSupply())
      , FormatNumber(Economy_GetReserve())
      , Economy_GetInflationRate()
      , Economy_GetSalesTaxRate()
      , FormatNumber(Economy_GetTreatmentPrice())
      , FormatNumber(Economy_GetComponentPrice())
    );
  }

  Economy_UpdateSummary();

  House_RefreshAll();
  Business_RefreshAll();
  Workshop_RefreshAll();
  return 1;
}
