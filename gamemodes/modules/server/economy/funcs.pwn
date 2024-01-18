#if defined _inc_funcs
  #undef _inc_funcs
#endif
#if defined SERVER_ECONOMY_FUNCS
  #endinput
#endif
#define SERVER_ECONOMY_FUNCS



#define SERVER_ECONOMY_TABLE_NAME      "server_economies"
#define DEFAULT_COMPONENT_PRICE        1
#define DEFAULT_MATERIAL_PRICE         10
#define DEFAULT_TREATMENT_PRICE        100
#define DEF_RENT_VEH_DAMAGED_FORFEIT   1.000
#define DEF_RENT_VEH_OVERTIME_FORFEIT  100
#define DEF_RENT_VEH_DESTROYED_FORFEIT 100



static enum E_SERVER_ECONOMY
{
  ORM:ORM,
  SQL_ID,
  SUPPLY,
  RESERVE,
  INFLATION_RATE,
  SALES_TAX_RATE,
  MAX_FACTION_SALARY_WEEKLY,
  TREATMENT_PRICE,
  COMPONENT_PRICE,
  MATERIAL_PRICE,
  RENT_VEH_OVERTIME_FORFEIT,
  RENT_VEH_DESTROYED_FORFEIT,
  Float:RENT_VEH_DAMAGED_FORFEIT,
  CREATED_AT,
  UPDATED_AT,
  DELETED_AT
};

enum E_SERVER_ECONOMY_FLOW
{
  ECONOMY_FLOW_NONE = 0,
  ECONOMY_ADD_SUPPLY,
  ECONOMY_TAKE_SUPPLY
};

enum E_SERVER_ECONOMY_ACTION
{
  ECONOMY_ACTION_NONE = 0,
  ECONOMY_ACTION_DEFLATE,
  ECONOMY_ACTION_INFLATE
};



static ServerEconomy[E_SERVER_ECONOMY];
static TempServerEconomy[E_SERVER_ECONOMY];
static string:EconomySummary[768];



Economy_IsLoaded()
{
  return ((ServerEconomy[ORM] != MYSQL_INVALID_ORM) ? 1 : 0);
}

Economy_GetSQLID()
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  return (ServerEconomy[SQL_ID]);
}

Economy_GetSupply()
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  return (ServerEconomy[SUPPLY]);
}

Economy_GetReserve()
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  return (ServerEconomy[RESERVE]);
}

Economy_GetInflationRate()
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  return (ServerEconomy[INFLATION_RATE]);
}

Economy_GetSalesTaxRate()
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  return (ServerEconomy[SALES_TAX_RATE]);
}

Economy_GetTreatmentPrice()
{
  if (!Economy_IsLoaded())
  {
    return DEFAULT_TREATMENT_PRICE;
  }

  return (ServerEconomy[TREATMENT_PRICE]);
}

Economy_GetComponentPrice()
{
  if (!Economy_IsLoaded())
  {
    return DEFAULT_COMPONENT_PRICE;
  }

  return (ServerEconomy[COMPONENT_PRICE]);
}

Economy_GetMaterialPrice()
{
  if (!Economy_IsLoaded())
  {
    return DEFAULT_MATERIAL_PRICE;
  }

  return (ServerEconomy[MATERIAL_PRICE]);
}

Economy_GetRentVehOvertimeFine()
{
  if (!Economy_IsLoaded())
  {
    return DEF_RENT_VEH_OVERTIME_FORFEIT;
  }

  return (ServerEconomy[RENT_VEH_OVERTIME_FORFEIT]);
}

Economy_GetRentVehDestroyedFine()
{
  if (!Economy_IsLoaded())
  {
    return DEF_RENT_VEH_DESTROYED_FORFEIT;
  }

  return (ServerEconomy[RENT_VEH_DESTROYED_FORFEIT]);
}

Float:Economy_GetRentVehDamagedFine()
{
  if (!Economy_IsLoaded())
  {
    return DEF_RENT_VEH_DAMAGED_FORFEIT;
  }

  return (ServerEconomy[RENT_VEH_DAMAGED_FORFEIT]);
}

void:Economy_InitEnum(bool:reset_orm = true)
{
  if (reset_orm)
  {
    ServerEconomy[ORM] = MYSQL_INVALID_ORM;
  }

  ServerEconomy[SQL_ID] = 0;
  ServerEconomy[SUPPLY] = 1_000_000;
  ServerEconomy[RESERVE] = 1_000_000;
  ServerEconomy[INFLATION_RATE] = 0;
  ServerEconomy[SALES_TAX_RATE] = 0;
  ServerEconomy[MAX_FACTION_SALARY_WEEKLY] = 10_000;
  ServerEconomy[TREATMENT_PRICE] = DEFAULT_TREATMENT_PRICE;
  ServerEconomy[COMPONENT_PRICE] = DEFAULT_COMPONENT_PRICE;
  ServerEconomy[MATERIAL_PRICE] = DEFAULT_MATERIAL_PRICE;
  ServerEconomy[RENT_VEH_OVERTIME_FORFEIT] = DEF_RENT_VEH_OVERTIME_FORFEIT;
  ServerEconomy[RENT_VEH_DESTROYED_FORFEIT] = DEF_RENT_VEH_DESTROYED_FORFEIT;
  ServerEconomy[RENT_VEH_DAMAGED_FORFEIT] = DEF_RENT_VEH_DAMAGED_FORFEIT;
  ServerEconomy[CREATED_AT] = 0;
  ServerEconomy[UPDATED_AT] = 0;
  ServerEconomy[DELETED_AT] = 0;
}

void:Economy_InitTempEnum()
{
  TempServerEconomy[ORM] = MYSQL_INVALID_ORM;
  TempServerEconomy[SQL_ID] = 0;
  TempServerEconomy[SUPPLY] = 1_000_000;
  TempServerEconomy[RESERVE] = 1_000_000;
  TempServerEconomy[INFLATION_RATE] = 0;
  TempServerEconomy[SALES_TAX_RATE] = 0;
  TempServerEconomy[MAX_FACTION_SALARY_WEEKLY] = 10_000;
  TempServerEconomy[TREATMENT_PRICE] = DEFAULT_TREATMENT_PRICE;
  TempServerEconomy[COMPONENT_PRICE] = DEFAULT_COMPONENT_PRICE;
  TempServerEconomy[MATERIAL_PRICE] = DEFAULT_MATERIAL_PRICE;
  TempServerEconomy[RENT_VEH_OVERTIME_FORFEIT] = DEF_RENT_VEH_OVERTIME_FORFEIT;
  TempServerEconomy[RENT_VEH_DESTROYED_FORFEIT] = DEF_RENT_VEH_DESTROYED_FORFEIT;
  TempServerEconomy[RENT_VEH_DAMAGED_FORFEIT] = DEF_RENT_VEH_DAMAGED_FORFEIT;
  TempServerEconomy[CREATED_AT] = 0;
  TempServerEconomy[UPDATED_AT] = 0;
  TempServerEconomy[DELETED_AT] = 0;
}

void:Economy_InitORM()
{
  new
    ORM:orm = ServerEconomy[ORM] = orm_create(SERVER_ECONOMY_TABLE_NAME, g_iHandle)
  ;

  orm_addvar_int(orm, ServerEconomy[SQL_ID], "id");
  orm_addvar_int(orm, ServerEconomy[SUPPLY], "supply");
  orm_addvar_int(orm, ServerEconomy[RESERVE], "reserve");
  orm_addvar_int(orm, ServerEconomy[INFLATION_RATE], "inflation_rate");
  orm_addvar_int(orm, ServerEconomy[SALES_TAX_RATE], "sales_tax_rate");
  orm_addvar_int(orm, ServerEconomy[MAX_FACTION_SALARY_WEEKLY], "max_faction_salary_weekly");
  orm_addvar_int(orm, ServerEconomy[TREATMENT_PRICE], "treatment_price");
  orm_addvar_int(orm, ServerEconomy[COMPONENT_PRICE], "component_price");
  orm_addvar_int(orm, ServerEconomy[MATERIAL_PRICE], "material_price");
  orm_addvar_int(orm, ServerEconomy[RENT_VEH_OVERTIME_FORFEIT], "rental_vehicle_overtime_forfeit");
  orm_addvar_int(orm, ServerEconomy[RENT_VEH_DESTROYED_FORFEIT], "rental_vehicle_destroyed_forfeit");
  orm_addvar_float(orm, ServerEconomy[RENT_VEH_DAMAGED_FORFEIT], "rental_vehicle_damaged_forfeit");
  orm_addvar_int(orm, ServerEconomy[DELETED_AT], "deleted_at");
  orm_setkey(orm, "id");
}

Economy_InitLoad()
{
  static string:query[256];
  mysql_format(g_iHandle, query, sizeof(query), "\
    SELECT\
      `id`\
    FROM\
      `%s`\
    WHERE `deleted_at` = 0\
    ORDER BY `id` DESC\
    LIMIT 1;\
  ", SERVER_ECONOMY_TABLE_NAME);
  mysql_tquery(g_iHandle, query, "OnEconomyInitLoaded", "d", 0);
  return 1;
}

Economy_Load(economyid = 0)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  if (economyid)
  {
    ServerEconomy[SQL_ID] = economyid;
  }

  orm_load(ServerEconomy[ORM], "OnEconomyLoaded", "d", economyid);
  return 1;
}

Economy_Save(E_SERVER_ECONOMY_ACTION:action = ECONOMY_ACTION_NONE, amount = 0)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  ServerEconomy[UPDATED_AT] = gettime();

  if (action == ECONOMY_ACTION_DEFLATE)
  {
    ServerEconomy[DELETED_AT] = gettime();
  }
  else if (action == ECONOMY_ACTION_INFLATE)
  {
    ServerEconomy[DELETED_AT] = gettime();
  }

  orm_save(ServerEconomy[ORM], "OnEconomySaved", "ii", _:action, amount);
  return 1;
}

Economy_GetMaxFactSalaryWeekly()
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  return (ServerEconomy[MAX_FACTION_SALARY_WEEKLY]);
}

Economy_SetMaxFactSalaryWeekly(amount)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  ServerEconomy[MAX_FACTION_SALARY_WEEKLY] = amount;

  Economy_Save();
  return 1;
}

Economy_GetSalesTax(amount)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  new
    sales_tax_rate = Economy_GetSalesTaxRate(),
    sales_tax = floatround((amount * floatdiv(sales_tax_rate, 100)), floatround_floor)
  ;

  if (sales_tax < 0)
  {
    sales_tax = 0;
  }

  return sales_tax;
}

Economy_GetInflation(amount)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  new
    inflation_rate = Economy_GetInflationRate(),
    inflation = floatround(((amount * floatdiv(inflation_rate, 100))), floatround_floor)
  ;

  if (inflation < 0)
  {
    inflation = 0;
  }

  return inflation;
}

Economy_GetAmountAfterSalesTax(amount)
{
  if (!Economy_IsLoaded())
  {
    return amount;
  }

  new after_sales_tax = amount + Economy_GetSalesTax(amount);

  if (after_sales_tax < 0)
  {
    after_sales_tax = amount;
  }

  return after_sales_tax;
}

Economy_GetAmountAfterInflation(amount)
{
  if (!Economy_IsLoaded())
  {
    return amount;
  }

  new after_inflation = amount + Economy_GetInflation(amount);

  if (after_inflation < 0)
  {
    after_inflation = amount;
  }

  return after_inflation;
}

Economy_AddSupplyAmount(amount)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  ServerEconomy[RESERVE] += amount;

  new
    bool:is_able_to_deflate = (Economy_GetReserve() > (Economy_GetSupply() * 2) && Economy_GetInflationRate() > 0)
  ;

  if (is_able_to_deflate)
  {
    new
      supply = Economy_GetSupply(),
      sales_tax_rate = Economy_GetSalesTaxRate(),
      inflation_rate = Economy_GetInflationRate(),
      treatment_price = Economy_GetTreatmentPrice(),
      component_price = Economy_GetComponentPrice(),
      new_supply = floatround((supply / 2), floatround_round)
    ;

    TempServerEconomy[SUPPLY] = TempServerEconomy[RESERVE] = new_supply;
    TempServerEconomy[INFLATION_RATE] = inflation_rate - 1;
    TempServerEconomy[SALES_TAX_RATE] = sales_tax_rate;
    TempServerEconomy[TREATMENT_PRICE] = treatment_price;
    TempServerEconomy[COMPONENT_PRICE] = component_price;
    TempServerEconomy[MAX_FACTION_SALARY_WEEKLY] = ServerEconomy[MAX_FACTION_SALARY_WEEKLY];

    Economy_Save(ECONOMY_ACTION_DEFLATE);
    return 1;
  }

  Economy_Save();
  return 1;
}

Economy_RequestSupply(amount)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  if (Economy_GetReserve() > amount)
  {
    ServerEconomy[RESERVE] -= amount;

    Economy_Save();
    return amount;
  }

  new
    supply = Economy_GetSupply(),
    reserve = Economy_GetReserve(),
    sales_tax_rate = Economy_GetSalesTaxRate(),
    treatment_price = Economy_GetTreatmentPrice(),
    component_price = Economy_GetComponentPrice(),
    inflation_rate = Economy_GetInflationRate()
  ;

  TempServerEconomy[SUPPLY] = supply * 2;
  TempServerEconomy[RESERVE] = (supply * 2) + reserve - amount;
  TempServerEconomy[INFLATION_RATE] = inflation_rate + 1;
  TempServerEconomy[SALES_TAX_RATE] = sales_tax_rate;
  TempServerEconomy[TREATMENT_PRICE] = treatment_price;
  TempServerEconomy[COMPONENT_PRICE] = component_price;
  TempServerEconomy[MAX_FACTION_SALARY_WEEKLY] = ServerEconomy[MAX_FACTION_SALARY_WEEKLY];

  Economy_Save(ECONOMY_ACTION_INFLATE);
  return amount;
}

Economy_SetTreatmentPrice(value)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  if (value < 0)
  {
    value = 0;
  }

  new
    old_price = Economy_GetTreatmentPrice()
  ;

  ServerEconomy[TREATMENT_PRICE] = value;
  Economy_Save();

  CallRemoteFunction("OnUpdateTreatmentPrice", "dd", old_price, value);
  return 1;
}

Economy_SetComponentPrice(value)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  if (value < 0)
  {
    value = 0;
  }

  new
    old_price = Economy_GetComponentPrice()
  ;

  ServerEconomy[COMPONENT_PRICE] = value;
  Economy_Save();

  CallRemoteFunction("OnUpdateComponentPrice", "dd", old_price, value);
  return 1;
}

Economy_SetMaterialPrice(value)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  if (value < 0)
  {
    value = 0;
  }

  new
    old_price = Economy_GetMaterialPrice()
  ;

  ServerEconomy[MATERIAL_PRICE] = value;
  Economy_Save();

  CallRemoteFunction("OnUpdateMaterialPrice", "dd", old_price, value);
  return 1;
}

Economy_SetRentVehOvertimeFine(value)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  if (value < 0)
  {
    value = 0;
  }

  ServerEconomy[RENT_VEH_OVERTIME_FORFEIT] = value;
  Economy_Save();
  return 1;
}

Economy_SetRentVehDestroyedFine(value)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  if (value < 0)
  {
    value = 0;
  }

  ServerEconomy[RENT_VEH_DESTROYED_FORFEIT] = value;
  Economy_Save();
  return 1;
}

Economy_SetRentVehDamagedFine(Float:value)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  if (value < 0)
  {
    value = 0.000;
  }

  ServerEconomy[RENT_VEH_DAMAGED_FORFEIT] = value;
  Economy_Save();
  return 1;
}

Economy_CreateConfig()
{
  orm_insert(ServerEconomy[ORM], "OnEconomyConfigCreated", "d", 0);
  return 1;
}

Economy_Recreate(E_SERVER_ECONOMY_ACTION:action)
{
  if (!Economy_IsLoaded())
  {
    return 0;
  }

  ServerEconomy[SQL_ID] = 0;
  ServerEconomy[SUPPLY] = TempServerEconomy[SUPPLY];
  ServerEconomy[RESERVE] = TempServerEconomy[RESERVE];
  ServerEconomy[INFLATION_RATE] = TempServerEconomy[INFLATION_RATE];
  ServerEconomy[SALES_TAX_RATE] = TempServerEconomy[SALES_TAX_RATE];
  ServerEconomy[TREATMENT_PRICE] = TempServerEconomy[TREATMENT_PRICE];
  ServerEconomy[COMPONENT_PRICE] = TempServerEconomy[COMPONENT_PRICE];
  ServerEconomy[MAX_FACTION_SALARY_WEEKLY] = TempServerEconomy[MAX_FACTION_SALARY_WEEKLY];
  ServerEconomy[RENT_VEH_OVERTIME_FORFEIT] = TempServerEconomy[RENT_VEH_OVERTIME_FORFEIT];
  ServerEconomy[RENT_VEH_DESTROYED_FORFEIT] = TempServerEconomy[RENT_VEH_DESTROYED_FORFEIT];
  ServerEconomy[RENT_VEH_DAMAGED_FORFEIT] = TempServerEconomy[RENT_VEH_DAMAGED_FORFEIT];
  ServerEconomy[CREATED_AT] = 0;
  ServerEconomy[UPDATED_AT] = 0;
  ServerEconomy[DELETED_AT] = 0;

  orm_insert(ServerEconomy[ORM], "OnEconomyRecreated", "d", _:action);
  return 1;
}

Economy_UpdateSummary()
{
  format(EconomySummary, sizeof(EconomySummary), "\
    #\tInfo\tValue\n\
    1\tSupply (Read-only)\t%s\n\
    2\tReserve (Read-only)\t%s\n\
    3\tInflation Rate (Read-only)\t%d%%\n\
    4\tSales Tax Rate (Read-only)\t%d%%\n\
    5\tMaximum Faction Salary Weekly\t%s\n\
    6\tTreatment Price\t%s\n\
    7\tComponent Price\t%s\n\
    8\tMaterial Price\t%s\n\
    9\tRental Vehicle Forfeit (Overtime)\t%s\n\
    10\tRental Vehicle Forfeit (Destroyed)\t%s\n\
    11\tRental Vehicle Forfeit Rate (Damaged)\tx%.3f\
  ", FormatNumber(Economy_GetSupply())
  , FormatNumber(Economy_GetReserve())
  , Economy_GetInflationRate()
  , Economy_GetSalesTaxRate()
  , FormatNumber(Economy_GetMaxFactSalaryWeekly())
  , FormatNumber(Economy_GetTreatmentPrice())
  , FormatNumber(Economy_GetComponentPrice())
  , FormatNumber(Economy_GetMaterialPrice())
  , FormatNumber(Economy_GetRentVehOvertimeFine())
  , FormatNumber(Economy_GetRentVehDestroyedFine())
  , Economy_GetRentVehDamagedFine());
  return 1;
}

Economy_UpdatePickupInfo()
{
  // Treatment price
  Location_UpdateLabelsByType(LOCATION_TREATMENT, sprintf("[Medical Treatment]\n\
  "WHITE"Type "YELLOW"/treatment"WHITE" to get medical treatment\n\
  "GREEN"%s\
  ", FormatNumber(Economy_GetTreatmentPrice())));

  return 1;
}

Economy_ShowSummary(playerid)
{
  if (!IsPlayerConnected(playerid))
  {
    return 0;
  }

  Dialog_Show(playerid, AdjustEconomy, DIALOG_STYLE_TABLIST_HEADERS, "Economy Summary", EconomySummary, "Edit", "Close");
  return 1;
}

Dialog:AdjustFactSal(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    Economy_ShowSummary(playerid);
    return 1;
  }

  new value = strval(inputtext);

  if (value < 0 || value > 100_000)
  {
    SendClientMessage(playerid, X11_RED, "Wrong value.");
    Dialog_Show(playerid, AdjustFactSal, DIALOG_STYLE_INPUT, "Economy - Set Maximum Faction Salary Weekly", "Input value (0 - 100,000). 0 means unlimited.", "Change", "Close");
    return 1;
  }

  SendClientMessage(playerid, X11_WHITE, "You've updated maximum faction salary.");
  Economy_SetMaxFactSalaryWeekly(value);
  Economy_UpdateSummary();
  Economy_ShowSummary(playerid);
  return 1;
}

Dialog:AdjustTreatmentPrice(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    Economy_ShowSummary(playerid);
    return 1;
  }

  new value = strval(inputtext);

  if (value < 0 || value > 100_000)
  {
    SendClientMessage(playerid, X11_RED, "Wrong value.");
    Dialog_Show(playerid, AdjustTreatmentPrice, DIALOG_STYLE_INPUT, "Economy - Set Treatment Price", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    return 1;
  }

  SendClientMessage(playerid, X11_WHITE, "You've updated treatment price.");
  Economy_SetTreatmentPrice(value);
  Economy_UpdateSummary();
  Economy_ShowSummary(playerid);
  return 1;
}

Dialog:AdjustCompPrice(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    Economy_ShowSummary(playerid);
    return 1;
  }

  new value = strval(inputtext);

  if (value < 0 || value > 100_000)
  {
    SendClientMessage(playerid, X11_RED, "Wrong value.");
    Dialog_Show(playerid, AdjustCompPrice, DIALOG_STYLE_INPUT, "Economy - Set Component Price", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    return 1;
  }

  SendClientMessage(playerid, X11_WHITE, "You've updated component price.");
  Economy_SetComponentPrice(value);
  Economy_UpdateSummary();
  Economy_ShowSummary(playerid);
  return 1;
}

Dialog:AdjustMatPrice(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    Economy_ShowSummary(playerid);
    return 1;
  }

  new value = strval(inputtext);

  if (value < 0 || value > 100_000)
  {
    SendClientMessage(playerid, X11_RED, "Wrong value.");
    Dialog_Show(playerid, AdjustMatPrice, DIALOG_STYLE_INPUT, "Economy - Set Material Price", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    return 1;
  }

  SendClientMessage(playerid, X11_WHITE, "You've updated material price.");
  Economy_SetMaterialPrice(value);
  Economy_UpdateSummary();
  Economy_ShowSummary(playerid);
  return 1;
}

Dialog:AdjRentVehOvertime(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    Economy_ShowSummary(playerid);
    return 1;
  }

  new value = strval(inputtext);

  if (value < 0 || value > 100_000)
  {
    SendClientMessage(playerid, X11_RED, "Wrong value.");
    Dialog_Show(playerid, AdjRentVehOvertime, DIALOG_STYLE_INPUT, "Economy - Set Rental Vehicle Forfeit (Overtime)", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    return 1;
  }

  SendClientMessage(playerid, X11_WHITE, "You've updated rental vehicle forfeit for overtime.");
  Economy_SetRentVehOvertimeFine(value);
  Economy_UpdateSummary();
  Economy_ShowSummary(playerid);
  return 1;
}

Dialog:AdjRentVehDestroyed(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    Economy_ShowSummary(playerid);
    return 1;
  }

  new value = strval(inputtext);

  if (value < 0 || value > 100_000)
  {
    SendClientMessage(playerid, X11_RED, "Wrong value.");
    Dialog_Show(playerid, AdjRentVehDestroyed, DIALOG_STYLE_INPUT, "Economy - Set Rental Vehicle Forfeit (Destroyed)", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    return 1;
  }

  SendClientMessage(playerid, X11_WHITE, "You've updated rental vehicle forfeit for destroyed.");
  Economy_SetRentVehDestroyedFine(value);
  Economy_UpdateSummary();
  Economy_ShowSummary(playerid);
  return 1;
}

Dialog:AdjRentVehDamaged(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    Economy_ShowSummary(playerid);
    return 1;
  }

  static Float:value;
  sscanf(inputtext, "F(-1.0)", value);

  if (value < 0.000 || value > 100.000)
  {
    SendClientMessage(playerid, X11_RED, "Wrong value.");
    Dialog_Show(playerid, AdjRentVehDamaged, DIALOG_STYLE_INPUT, "Economy - Set Rental Vehicle Forfeit Rate (Damaged)", "Input value (0.0 - 100.0). 0 means free.", "Change", "Close");
    return 1;
  }

  SendClientMessage(playerid, X11_WHITE, "You've updated rental vehicle forfeit rate for damaged.");
  Economy_SetRentVehDamagedFine(value);
  Economy_UpdateSummary();
  Economy_ShowSummary(playerid);
  return 1;
}

Dialog:AdjustEconomy(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    return 1;
  }

  switch (listitem)
  {
    case 4: // Sales Tax Rate
    {
      if (CheckAdmin(playerid, 8))
      {
        return 1;
      }

      Dialog_Show(playerid, AdjustFactSal, DIALOG_STYLE_INPUT, "Economy - Set Maximum Faction Salary Weekly", "Input value (0 - 100,000). 0 means unlimited.", "Change", "Close");
    }
    case 5: // Treatment Price
    {
      if (CheckAdmin(playerid, 8))
      {
        return 1;
      }

      Dialog_Show(playerid, AdjustTreatmentPrice, DIALOG_STYLE_INPUT, "Economy - Set Treatment Price", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    }
    case 6: // Component Price
    {
      if (CheckAdmin(playerid, 8))
      {
        return 1;
      }

      Dialog_Show(playerid, AdjustCompPrice, DIALOG_STYLE_INPUT, "Economy - Set Component Price", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    }
    case 7: // Material Price
    {
      if (CheckAdmin(playerid, 8))
      {
        return 1;
      }

      Dialog_Show(playerid, AdjustMatPrice, DIALOG_STYLE_INPUT, "Economy - Set Material Price", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    }
    case 8: // Rental Vehicle Forfeit (Overtime)
    {
      if (CheckAdmin(playerid, 8))
      {
        return 1;
      }

      Dialog_Show(playerid, AdjRentVehOvertime, DIALOG_STYLE_INPUT, "Economy - Set Rental Vehicle Forfeit (Overtime)", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    }
    case 9: // Rental Vehicle Forfeit (Destroyed)
    {
      if (CheckAdmin(playerid, 8))
      {
        return 1;
      }

      Dialog_Show(playerid, AdjRentVehDestroyed, DIALOG_STYLE_INPUT, "Economy - Set Rental Vehicle Forfeit (Destroyed)", "Input value (0 - 100,000). 0 means free.", "Change", "Close");
    }
    case 10: // Rental Vehicle Forfeit Rate (Damaged)
    {
      if (CheckAdmin(playerid, 8))
      {
        return 1;
      }

      Dialog_Show(playerid, AdjRentVehDamaged, DIALOG_STYLE_INPUT, "Economy - Set Rental Vehicle Forfeit Rate (Damaged)", "Input value (0.0 - 100.0). 0 means free.", "Change", "Close");
    }
  }

  return 1;
}
