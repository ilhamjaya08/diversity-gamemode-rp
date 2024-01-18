#if defined _inc_funcs
  #undef _inc_funcs
#endif
#if defined SERVER_JOBCONFIG_FUNCS
  #endinput
#endif
#define SERVER_JOBCONFIG_FUNCS



#define BOXVILLE_TABLE_NAME          "sidejob_boxville_configs"
#define BUS_DRIVER_TABLE_NAME        "sidejob_bus_driver_configs"
#define MONEY_TRANSPORTER_TABLE_NAME "sidejob_money_transporter_configs"
#define SWEEPER_TABLE_NAME           "sidejob_sweeper_configs"
#define TRASHMASTER_TABLE_NAME       "sidejob_trashmaster_configs"



enum E_SERVER_JOB
{
  JOB_UNKNOWN = 0,
  SIDEJOB_BOXVILLE,
  SIDEJOB_BUS_DRIVER,
  SIDEJOB_MONEY_TRANSPORTER,
  SIDEJOB_SWEEPER,
  SIDEJOB_TRASHMASTER
};

static enum E_SERVER_JOBCONFIG_SECTION
{
  JOBCONFIG_SECTION_NONE = 0,
  ENABLED,
  BASE_SALARY,
  BONUS_CHANCE,
  BONUS_MINIMUM,
  BONUS_MAXIMUM,
  EXIT_DELAY,
  FAIL_DELAY,
  SUCCESS_DELAY,
  // -- Trashmaster
  TRSHMSTR_EARN_PER_TRASH,
  TRSHMSTR_MAX_TRASHES,
  // -- Bus Driver
  BUSDRVR_MINIMUM_HEALTH,
  BUSDRVR_MAX_SPEED,
  // -- Boxville
  BXVL_EARN_PER_HOUSE,
  BXVL_MAX_HOUSES_DELIVERED,
  // -- Money Transporter
  MNTRNSPTR_MAX_ATM_CASH,
  MNTRNSPTR_MAX_VAN_CASH,
  Float:MNTRNSPTR_DEPOSIT_CASH_RATE
};

static enum E_SERVER_JOBCONFIG
{
  // ---------------------------------
  ORM:TRASHMASTER_ORM,
  TRASHMASTER_SQL_ID,
  TRASHMASTER_ENABLED,
  TRASHMASTER_BASE_SALARY,
  Float:TRASHMASTER_BONUS_CHANCE,
  TRASHMASTER_BONUS_MINIMUM,
  TRASHMASTER_BONUS_MAXIMUM,
  TRASHMASTER_EXIT_DELAY,
  TRASHMASTER_FAIL_DELAY,
  TRASHMASTER_SUCCESS_DELAY,
  TRASHMASTER_EARN_PER_TRASH,
  TRASHMASTER_MAX_TRASHES,
  TRASHMASTER_CREATED_AT,
  TRASHMASTER_UPDATED_AT,
  // ---------------------------------
  ORM:SWEEPER_ORM,
  SWEEPER_SQL_ID,
  SWEEPER_ENABLED,
  SWEEPER_BASE_SALARY,
  Float:SWEEPER_BONUS_CHANCE,
  SWEEPER_BONUS_MINIMUM,
  SWEEPER_BONUS_MAXIMUM,
  SWEEPER_EXIT_DELAY,
  SWEEPER_FAIL_DELAY,
  SWEEPER_SUCCESS_DELAY,
  SWEEPER_CREATED_AT,
  SWEEPER_UPDATED_AT,
  // ---------------------------------
  ORM:BUS_DRIVER_ORM,
  BUS_DRIVER_SQL_ID,
  BUS_DRIVER_ENABLED,
  BUS_DRIVER_BASE_SALARY,
  Float:BUS_DRIVER_BONUS_CHANCE,
  BUS_DRIVER_BONUS_MINIMUM,
  BUS_DRIVER_BONUS_MAXIMUM,
  BUS_DRIVER_EXIT_DELAY,
  BUS_DRIVER_FAIL_DELAY,
  BUS_DRIVER_SUCCESS_DELAY,
  Float:BUS_DRIVER_MINIMUM_HEALTH,
  Float:BUS_DRIVER_MAX_SPEED,
  BUS_DRIVER_CREATED_AT,
  BUS_DRIVER_UPDATED_AT,
  // ---------------------------------
  ORM:BOXVILLE_ORM,
  BOXVILLE_SQL_ID,
  BOXVILLE_ENABLED,
  BOXVILLE_BASE_SALARY,
  Float:BOXVILLE_BONUS_CHANCE,
  BOXVILLE_BONUS_MINIMUM,
  BOXVILLE_BONUS_MAXIMUM,
  BOXVILLE_EXIT_DELAY,
  BOXVILLE_FAIL_DELAY,
  BOXVILLE_SUCCESS_DELAY,
  BOXVILLE_EARN_PER_HOUSE,
  BOXVILLE_MAX_HOUSES_DELIVERED,
  BOXVILLE_CREATED_AT,
  BOXVILLE_UPDATED_AT,
  // ---------------------------------
  ORM:MONEY_TRANSPORTER_ORM,
  MONEY_TRANSPORTER_SQL_ID,
  MONEY_TRANSPORTER_ENABLED,
  MONEY_TRANSPORTER_BASE_SALARY,
  Float:MONEY_TRANSPORTER_BONUS_CHANCE,
  MONEY_TRANSPORTER_BONUS_MINIMUM,
  MONEY_TRANSPORTER_BONUS_MAXIMUM,
  MONEY_TRANSPORTER_EXIT_DELAY,
  MONEY_TRANSPORTER_FAIL_DELAY,
  MONEY_TRANSPORTER_SUCCESS_DELAY,
  MONEY_TRANSPORTER_MAX_ATM_CASH,
  MONEY_TRANSPORTER_MAX_VAN_CASH,
  Float:MN_TRNSPTR_DEPOSIT_CASH_RATE,
  MONEY_TRANSPORTER_CREATED_AT,
  MONEY_TRANSPORTER_UPDATED_AT
  // ---------------------------------
};



static JobConfig[E_SERVER_JOBCONFIG];
static string:BoxvilleSummary[1_024];
static string:BusDriverSummary[1_024];
static string:MoneyTransporterSummary[1_024];
static string:SweeperSummary[1_024];
static string:TrashmasterSummary[1_024];

static E_SERVER_JOB:PlayerJobConfig[MAX_PLAYERS + 1];
static E_SERVER_JOBCONFIG_SECTION:PlayerJobConfigSection[MAX_PLAYERS + 1];



// ======================================================
// PLAYER CONFIG
// ======================================================

JobConfig_ResetLastConfig(playerid)
{
  if (playerid >= 0 && playerid < MAX_PLAYERS)
  {
    PlayerJobConfigSection[playerid] = JOBCONFIG_SECTION_NONE;
  }

  return 1;
}

E_SERVER_JOBCONFIG_SECTION:JobConfig_GetLastConfig(playerid)
{
  if (playerid >= 0 && playerid < MAX_PLAYERS)
  {
    return (PlayerJobConfigSection[playerid]);
  }

  return JOBCONFIG_SECTION_NONE;
}

JobConfig_SetLastConfig(playerid, E_SERVER_JOBCONFIG_SECTION:section)
{
  if (playerid >= 0 && playerid < MAX_PLAYERS)
  {
    PlayerJobConfigSection[playerid] = section;
  }

  return 1;
}

JobConfig_ResetLastJob(playerid)
{
  if (playerid >= 0 && playerid < MAX_PLAYERS)
  {
    PlayerJobConfig[playerid] = JOB_UNKNOWN;
  }

  return 1;
}

E_SERVER_JOB:JobConfig_GetLastJob(playerid)
{
  if (playerid >= 0 && playerid < MAX_PLAYERS)
  {
    return (PlayerJobConfig[playerid]);
  }

  return JOB_UNKNOWN;
}

JobConfig_SetLastJob(playerid, E_SERVER_JOB:job)
{
  if (playerid >= 0 && playerid < MAX_PLAYERS)
  {
    PlayerJobConfig[playerid] = job;
  }

  return 1;
}

// ======================================================
// GENERAL SETTINGS
// ======================================================

JobConfig_GetJobName(E_SERVER_JOB:job, string:name[], len = sizeof(name))
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      format(name, len, "Boxville");
    }
    case SIDEJOB_BUS_DRIVER:
    {
      format(name, len, "Bus Driver");
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      format(name, len, "Money Transporter");
    }
    case SIDEJOB_SWEEPER:
    {
      format(name, len, "Sweeper");
    }
    case SIDEJOB_TRASHMASTER:
    {
      format(name, len, "Trashmaster");
    }
    default:
    {
      format(name, len, "(Unknown)");
    }
  }

  return 1;
}

JobConfig_IsLoaded(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return ((JobConfig[BOXVILLE_ORM] != MYSQL_INVALID_ORM) ? 1 : 0);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return ((JobConfig[BUS_DRIVER_ORM] != MYSQL_INVALID_ORM) ? 1 : 0);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return ((JobConfig[MONEY_TRANSPORTER_ORM] != MYSQL_INVALID_ORM) ? 1 : 0);
    }
    case SIDEJOB_SWEEPER:
    {
      return ((JobConfig[SWEEPER_ORM] != MYSQL_INVALID_ORM) ? 1 : 0);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return ((JobConfig[TRASHMASTER_ORM] != MYSQL_INVALID_ORM) ? 1 : 0);
    }
    default:
    {
      return 0;
    }
  }

  return 0;
}

JobConfig_IsJobEnabled(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BOXVILLE_ENABLED]);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BUS_DRIVER_ENABLED]);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[MONEY_TRANSPORTER_ENABLED]);
    }
    case SIDEJOB_SWEEPER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[SWEEPER_ENABLED]);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[TRASHMASTER_ENABLED]);
    }
    default:
    {
      return 1;
    }
  }

  return 0;
}

JobConfig_SetJobEnabled(E_SERVER_JOB:job, amount)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return JobConfig[BOXVILLE_ENABLED] = (amount > 0 ? 1 : 0);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return JobConfig[BUS_DRIVER_ENABLED] = (amount > 0 ? 1 : 0);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return JobConfig[MONEY_TRANSPORTER_ENABLED] = (amount > 0 ? 1 : 0);
    }
    case SIDEJOB_SWEEPER:
    {
      return JobConfig[SWEEPER_ENABLED] = (amount > 0 ? 1 : 0);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return JobConfig[TRASHMASTER_ENABLED] = (amount > 0 ? 1 : 0);
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_Save(job);
  return 1;
}

JobConfig_GetSQLID(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BOXVILLE_SQL_ID]);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BUS_DRIVER_SQL_ID]);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[MONEY_TRANSPORTER_SQL_ID]);
    }
    case SIDEJOB_SWEEPER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[SWEEPER_SQL_ID]);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[TRASHMASTER_SQL_ID]);
    }
    default:
    {
      return 0;
    }
  }

  return 0;
}

JobConfig_GetBaseSalary(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BOXVILLE_BASE_SALARY]);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BUS_DRIVER_BASE_SALARY]);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[MONEY_TRANSPORTER_BASE_SALARY]);
    }
    case SIDEJOB_SWEEPER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[SWEEPER_BASE_SALARY]);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[TRASHMASTER_BASE_SALARY]);
    }
    default:
    {
      return 0;
    }
  }

  return 0;
}

JobConfig_SetBaseSalary(E_SERVER_JOB:job, amount)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_BASE_SALARY] = amount;
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_BASE_SALARY] = amount;
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_BASE_SALARY] = amount;
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_BASE_SALARY] = amount;
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_BASE_SALARY] = amount;
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_Save(job);
  return 1;
}

JobConfig_GetBonusChance(E_SERVER_JOB:job, &Float:amount)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      amount = (!JobConfig_IsLoaded(job) ? 0.00 : JobConfig[BOXVILLE_BONUS_CHANCE]);
      return 1;
    }
    case SIDEJOB_BUS_DRIVER:
    {
      amount = (!JobConfig_IsLoaded(job) ? 0.00 : JobConfig[BUS_DRIVER_BONUS_CHANCE]);
      return 1;
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      amount = (!JobConfig_IsLoaded(job) ? 0.00 : JobConfig[MONEY_TRANSPORTER_BONUS_CHANCE]);
      return 1;
    }
    case SIDEJOB_SWEEPER:
    {
      amount = (!JobConfig_IsLoaded(job) ? 0.00 : JobConfig[SWEEPER_BONUS_CHANCE]);
      return 1;
    }
    case SIDEJOB_TRASHMASTER:
    {
      amount = (!JobConfig_IsLoaded(job) ? 0.00 : JobConfig[TRASHMASTER_BONUS_CHANCE]);
      return 1;
    }
    default:
    {
      amount = 0.00;
      return 0;
    }
  }

  return 0;
}

JobConfig_SetBonusChance(E_SERVER_JOB:job, Float:amount)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_BONUS_CHANCE] = amount;
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_BONUS_CHANCE] = amount;
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_BONUS_CHANCE] = amount;
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_BONUS_CHANCE] = amount;
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_BONUS_CHANCE] = amount;
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_Save(job);
  return 1;
}

JobConfig_GetBonusMinimum(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BOXVILLE_BONUS_MINIMUM]);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BUS_DRIVER_BONUS_MINIMUM]);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[MONEY_TRANSPORTER_BONUS_MINIMUM]);
    }
    case SIDEJOB_SWEEPER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[SWEEPER_BONUS_MINIMUM]);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[TRASHMASTER_BONUS_MINIMUM]);
    }
    default:
    {
      return 0;
    }
  }

  return 0;
}

JobConfig_SetBonusMinimum(E_SERVER_JOB:job, amount)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_BONUS_MINIMUM] = amount;
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_BONUS_MINIMUM] = amount;
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_BONUS_MINIMUM] = amount;
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_BONUS_MINIMUM] = amount;
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_BONUS_MINIMUM] = amount;
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_Save(job);
  return 1;
}

JobConfig_GetBonusMaximum(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BOXVILLE_BONUS_MAXIMUM]);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BUS_DRIVER_BONUS_MAXIMUM]);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[MONEY_TRANSPORTER_BONUS_MAXIMUM]);
    }
    case SIDEJOB_SWEEPER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[SWEEPER_BONUS_MAXIMUM]);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[TRASHMASTER_BONUS_MAXIMUM]);
    }
    default:
    {
      return 0;
    }
  }

  return 0;
}

JobConfig_SetBonusMaximum(E_SERVER_JOB:job, amount)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_BONUS_MAXIMUM] = amount;
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_BONUS_MAXIMUM] = amount;
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_BONUS_MAXIMUM] = amount;
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_BONUS_MAXIMUM] = amount;
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_BONUS_MAXIMUM] = amount;
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_Save(job);
  return 1;
}

JobConfig_GetBonus(E_SERVER_JOB:job, &amount = 0)
{
  new
    rand = random(101),
    Float:bonus_chance
  ;

  JobConfig_GetBonusChance(job, bonus_chance);

  if (!floatcmp(bonus_chance, 0.0))
  {
    amount = 0;
    return 1;
  }
  else if (rand <= floatround(bonus_chance) || !(floatcmp(bonus_chance, 100.0)))
  {
    new
      min_bonus = JobConfig_GetBonusMinimum(job),
      max_bonus = JobConfig_GetBonusMaximum(job),
      current_bonus = random(max_bonus + 1)
    ;

    if (current_bonus < min_bonus)
    {
      amount = min_bonus;
    }
    else
    {
      amount = current_bonus;
    }

    return 1;
  }

  amount = 0;
  return 1;
}

JobConfig_GetExitDelay(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BOXVILLE_EXIT_DELAY]);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BUS_DRIVER_EXIT_DELAY]);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[MONEY_TRANSPORTER_EXIT_DELAY]);
    }
    case SIDEJOB_SWEEPER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[SWEEPER_EXIT_DELAY]);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[TRASHMASTER_EXIT_DELAY]);
    }
    default:
    {
      return 0;
    }
  }

  return 0;
}

JobConfig_SetExitDelay(E_SERVER_JOB:job, amount)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_EXIT_DELAY] = amount;
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_EXIT_DELAY] = amount;
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_EXIT_DELAY] = amount;
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_EXIT_DELAY] = amount;
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_EXIT_DELAY] = amount;
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_Save(job);
  return 1;
}

JobConfig_GetFailDelay(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BOXVILLE_FAIL_DELAY]);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BUS_DRIVER_FAIL_DELAY]);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[MONEY_TRANSPORTER_FAIL_DELAY]);
    }
    case SIDEJOB_SWEEPER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[SWEEPER_FAIL_DELAY]);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[TRASHMASTER_FAIL_DELAY]);
    }
    default:
    {
      return 0;
    }
  }

  return 0;
}

JobConfig_SetFailDelay(E_SERVER_JOB:job, amount)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_FAIL_DELAY] = amount;
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_FAIL_DELAY] = amount;
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_FAIL_DELAY] = amount;
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_FAIL_DELAY] = amount;
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_FAIL_DELAY] = amount;
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_Save(job);
  return 1;
}

JobConfig_GetSuccessDelay(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BOXVILLE_SUCCESS_DELAY]);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[BUS_DRIVER_SUCCESS_DELAY]);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[MONEY_TRANSPORTER_SUCCESS_DELAY]);
    }
    case SIDEJOB_SWEEPER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[SWEEPER_SUCCESS_DELAY]);
    }
    case SIDEJOB_TRASHMASTER:
    {
      return (!JobConfig_IsLoaded(job) ? 0 : JobConfig[TRASHMASTER_SUCCESS_DELAY]);
    }
    default:
    {
      return 0;
    }
  }

  return 0;
}

JobConfig_SetSuccessDelay(E_SERVER_JOB:job, amount)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_SUCCESS_DELAY] = amount;
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_SUCCESS_DELAY] = amount;
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_SUCCESS_DELAY] = amount;
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_SUCCESS_DELAY] = amount;
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_SUCCESS_DELAY] = amount;
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_Save(job);
  return 1;
}

// ======================================================
// SPECIAL SETTINGS
// ======================================================

// --------------- Trashmaster ---------------

JobConfig_GetEarnPerTrash()
{
  if (!JobConfig_IsLoaded(SIDEJOB_TRASHMASTER))
  {
    return 0;
  }

  return (JobConfig[TRASHMASTER_EARN_PER_TRASH]);
}

JobConfig_SetEarnPerTrash(amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_TRASHMASTER))
  {
    return 0;
  }

  JobConfig[TRASHMASTER_EARN_PER_TRASH] = amount;

  JobConfig_Save(SIDEJOB_TRASHMASTER);
  return 1;
}

JobConfig_GetMaxTrashes()
{
  if (!JobConfig_IsLoaded(SIDEJOB_TRASHMASTER))
  {
    return 0;
  }

  return (JobConfig[TRASHMASTER_MAX_TRASHES]);
}

JobConfig_SetMaxTrashes(amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_TRASHMASTER))
  {
    return 0;
  }

  JobConfig[TRASHMASTER_MAX_TRASHES] = amount;

  JobConfig_Save(SIDEJOB_TRASHMASTER);
  return 1;
}

// --------------- Boxville ---------------

JobConfig_GetEarnPerHouse()
{
  if (!JobConfig_IsLoaded(SIDEJOB_BOXVILLE))
  {
    return 0;
  }

  return (JobConfig[BOXVILLE_EARN_PER_HOUSE]);
}

JobConfig_SetEarnPerHouse(amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_BOXVILLE))
  {
    return 0;
  }

  JobConfig[BOXVILLE_EARN_PER_HOUSE] = amount;

  JobConfig_Save(SIDEJOB_BOXVILLE);
  return 1;
}

JobConfig_GetMaxHousesDelivered()
{
  if (!JobConfig_IsLoaded(SIDEJOB_BOXVILLE))
  {
    return 0;
  }

  return (JobConfig[BOXVILLE_MAX_HOUSES_DELIVERED]);
}

JobConfig_SetMaxHousesDelivered(amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_BOXVILLE))
  {
    return 0;
  }

  JobConfig[BOXVILLE_MAX_HOUSES_DELIVERED] = amount;

  JobConfig_Save(SIDEJOB_BOXVILLE);
  return 1;
}

// --------------- Bus Driver ---------------

JobConfig_GetBusMinimumHealth(&Float:health)
{
  if (!JobConfig_IsLoaded(SIDEJOB_BUS_DRIVER))
  {
    health = 0.0;
    return 0;
  }

  health = JobConfig[BUS_DRIVER_MINIMUM_HEALTH];
  return 1;
}

JobConfig_SetBusMinimumHealth(Float:amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_BUS_DRIVER))
  {
    return 0;
  }

  JobConfig[BUS_DRIVER_MINIMUM_HEALTH] = amount;

  JobConfig_Save(SIDEJOB_BUS_DRIVER);
  return 1;
}

JobConfig_GetBusMaxSpeed(&Float:speed)
{
  if (!JobConfig_IsLoaded(SIDEJOB_BUS_DRIVER))
  {
    speed = 0.0;
    return 0;
  }

  speed = JobConfig[BUS_DRIVER_MAX_SPEED];
  return 1;
}

JobConfig_SetBusMaxSpeed(Float:amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_BUS_DRIVER))
  {
    return 0;
  }

  JobConfig[BUS_DRIVER_MAX_SPEED] = amount;

  JobConfig_Save(SIDEJOB_BUS_DRIVER);
  return 1;
}

// --------------- Money Transporter ---------------

JobConfig_GetMaxATMCash()
{
  if (!JobConfig_IsLoaded(SIDEJOB_MONEY_TRANSPORTER))
  {
    return 0;
  }

  return (JobConfig[MONEY_TRANSPORTER_MAX_ATM_CASH]);
}

JobConfig_SetMaxATMCash(amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_MONEY_TRANSPORTER))
  {
    return 0;
  }

  JobConfig[MONEY_TRANSPORTER_MAX_ATM_CASH] = amount;

  JobConfig_Save(SIDEJOB_MONEY_TRANSPORTER);
  return 1;
}

JobConfig_GetMaxVanCash()
{
  if (!JobConfig_IsLoaded(SIDEJOB_MONEY_TRANSPORTER))
  {
    return 0;
  }

  return (JobConfig[MONEY_TRANSPORTER_MAX_VAN_CASH]);
}

JobConfig_SetMaxVanCash(amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_MONEY_TRANSPORTER))
  {
    return 0;
  }

  JobConfig[MONEY_TRANSPORTER_MAX_VAN_CASH] = amount;

  JobConfig_Save(SIDEJOB_MONEY_TRANSPORTER);
  return 1;
}

JobConfig_GetDepositCashRate(&Float:amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_MONEY_TRANSPORTER))
  {
    amount = 0.00;
    return 0;
  }

  amount = JobConfig[MN_TRNSPTR_DEPOSIT_CASH_RATE];
  return 0;
}

JobConfig_SetDepositCashRate(Float:amount)
{
  if (!JobConfig_IsLoaded(SIDEJOB_MONEY_TRANSPORTER))
  {
    return 0;
  }

  JobConfig[MN_TRNSPTR_DEPOSIT_CASH_RATE] = amount;

  JobConfig_Save(SIDEJOB_MONEY_TRANSPORTER);
  return 1;
}

// ======================================================
// ======================================================
// ======================================================

void:JobConfig_InitEnum(E_SERVER_JOB:job = JOB_UNKNOWN, bool:reset_orm = true)
{
  // ---------------------------------
  if (reset_orm)
  {
    JobConfig[TRASHMASTER_ORM] = MYSQL_INVALID_ORM;
  }

  if (job == JOB_UNKNOWN || job == SIDEJOB_TRASHMASTER)
  {
    JobConfig[TRASHMASTER_SQL_ID] = 0;
    JobConfig[TRASHMASTER_ENABLED] = 1;
    JobConfig[TRASHMASTER_BASE_SALARY] = 500;
    JobConfig[TRASHMASTER_BONUS_CHANCE] = 100.00;
    JobConfig[TRASHMASTER_BONUS_MINIMUM] = 100;
    JobConfig[TRASHMASTER_BONUS_MAXIMUM] = 200;
    JobConfig[TRASHMASTER_EXIT_DELAY] = 300;
    JobConfig[TRASHMASTER_FAIL_DELAY] = 600;
    JobConfig[TRASHMASTER_SUCCESS_DELAY] = 1_200;
    JobConfig[TRASHMASTER_EARN_PER_TRASH] = 5;
    JobConfig[TRASHMASTER_MAX_TRASHES] = 100;
    JobConfig[TRASHMASTER_CREATED_AT] = 0;
    JobConfig[TRASHMASTER_UPDATED_AT] = 0;
  }
  // ---------------------------------
  if (reset_orm)
  {
    JobConfig[SWEEPER_ORM] = MYSQL_INVALID_ORM;
  }

  if (job == JOB_UNKNOWN || job == SIDEJOB_SWEEPER)
  {
    JobConfig[SWEEPER_SQL_ID] = 0;
    JobConfig[SWEEPER_ENABLED] = 1;
    JobConfig[SWEEPER_BASE_SALARY] = 500;
    JobConfig[SWEEPER_BONUS_CHANCE] = 100.00;
    JobConfig[SWEEPER_BONUS_MINIMUM] = 100;
    JobConfig[SWEEPER_BONUS_MAXIMUM] = 200;
    JobConfig[SWEEPER_EXIT_DELAY] = 300;
    JobConfig[SWEEPER_FAIL_DELAY] = 600;
    JobConfig[SWEEPER_SUCCESS_DELAY] = 1_200;
    JobConfig[SWEEPER_CREATED_AT] = 0;
    JobConfig[SWEEPER_UPDATED_AT] = 0;
  }
  // ---------------------------------
  if (reset_orm)
  {
    JobConfig[BUS_DRIVER_ORM] = MYSQL_INVALID_ORM;
  }

  if (job == JOB_UNKNOWN || job == SIDEJOB_BUS_DRIVER)
  {
    JobConfig[BUS_DRIVER_SQL_ID] = 0;
    JobConfig[BUS_DRIVER_ENABLED] = 1;
    JobConfig[BUS_DRIVER_BASE_SALARY] = 750;
    JobConfig[BUS_DRIVER_BONUS_CHANCE] = 100.00;
    JobConfig[BUS_DRIVER_BONUS_MINIMUM] = 100;
    JobConfig[BUS_DRIVER_BONUS_MAXIMUM] = 200;
    JobConfig[BUS_DRIVER_EXIT_DELAY] = 300;
    JobConfig[BUS_DRIVER_FAIL_DELAY] = 600;
    JobConfig[BUS_DRIVER_SUCCESS_DELAY] = 1_200;
    JobConfig[BUS_DRIVER_MINIMUM_HEALTH] = 450.0;
    JobConfig[BUS_DRIVER_MAX_SPEED] = 90.0;
    JobConfig[BUS_DRIVER_CREATED_AT] = 0;
    JobConfig[BUS_DRIVER_UPDATED_AT] = 0;
  }
  // ---------------------------------
  if (reset_orm)
  {
    JobConfig[BOXVILLE_ORM] = MYSQL_INVALID_ORM;
  }

  if (job == JOB_UNKNOWN || job == SIDEJOB_BOXVILLE)
  {
    JobConfig[BOXVILLE_SQL_ID] = 0;
    JobConfig[BOXVILLE_ENABLED] = 1;
    JobConfig[BOXVILLE_BASE_SALARY] = 500;
    JobConfig[BOXVILLE_BONUS_CHANCE] = 100.00;
    JobConfig[BOXVILLE_BONUS_MINIMUM] = 100;
    JobConfig[BOXVILLE_BONUS_MAXIMUM] = 200;
    JobConfig[BOXVILLE_EXIT_DELAY] = 300;
    JobConfig[BOXVILLE_FAIL_DELAY] = 600;
    JobConfig[BOXVILLE_SUCCESS_DELAY] = 1_200;
    JobConfig[BOXVILLE_EARN_PER_HOUSE] = 10;
    JobConfig[BOXVILLE_MAX_HOUSES_DELIVERED] = 20;
    JobConfig[BOXVILLE_CREATED_AT] = 0;
    JobConfig[BOXVILLE_UPDATED_AT] = 0;
  }
  // ---------------------------------
  if (reset_orm)
  {
    JobConfig[MONEY_TRANSPORTER_ORM] = MYSQL_INVALID_ORM;
  }

  if (job == JOB_UNKNOWN || job == SIDEJOB_MONEY_TRANSPORTER)
  {
    JobConfig[MONEY_TRANSPORTER_SQL_ID] = 0;
    JobConfig[MONEY_TRANSPORTER_ENABLED] = 1;
    JobConfig[MONEY_TRANSPORTER_BASE_SALARY] = 500;
    JobConfig[MONEY_TRANSPORTER_BONUS_CHANCE] = 100.00;
    JobConfig[MONEY_TRANSPORTER_BONUS_MINIMUM] = 100;
    JobConfig[MONEY_TRANSPORTER_BONUS_MAXIMUM] = 200;
    JobConfig[MONEY_TRANSPORTER_EXIT_DELAY] = 300;
    JobConfig[MONEY_TRANSPORTER_FAIL_DELAY] = 600;
    JobConfig[MONEY_TRANSPORTER_SUCCESS_DELAY] = 1_200;
    JobConfig[MONEY_TRANSPORTER_MAX_ATM_CASH] = 25_000;
    JobConfig[MONEY_TRANSPORTER_MAX_VAN_CASH] = 50_000;
    JobConfig[MN_TRNSPTR_DEPOSIT_CASH_RATE] = 0.000;
    JobConfig[MONEY_TRANSPORTER_CREATED_AT] = 0;
    JobConfig[MONEY_TRANSPORTER_UPDATED_AT] = 0;
  }
  // ---------------------------------
}

void:JobConfig_InitORM(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      new
        ORM:orm = JobConfig[BOXVILLE_ORM] = orm_create(BOXVILLE_TABLE_NAME, g_iHandle)
      ;

      orm_addvar_int(orm, JobConfig[BOXVILLE_SQL_ID], "id");
      orm_addvar_int(orm, JobConfig[BOXVILLE_ENABLED], "enabled");
      orm_addvar_int(orm, JobConfig[BOXVILLE_BASE_SALARY], "base_salary");
      orm_addvar_float(orm, JobConfig[BOXVILLE_BONUS_CHANCE], "bonus_chance");
      orm_addvar_int(orm, JobConfig[BOXVILLE_BONUS_MINIMUM], "bonus_minimum");
      orm_addvar_int(orm, JobConfig[BOXVILLE_BONUS_MAXIMUM], "bonus_maximum");
      orm_addvar_int(orm, JobConfig[BOXVILLE_EXIT_DELAY], "exit_delay");
      orm_addvar_int(orm, JobConfig[BOXVILLE_FAIL_DELAY], "fail_delay");
      orm_addvar_int(orm, JobConfig[BOXVILLE_SUCCESS_DELAY], "success_delay");
      orm_addvar_int(orm, JobConfig[BOXVILLE_EARN_PER_HOUSE], "earn_per_house");
      orm_addvar_int(orm, JobConfig[BOXVILLE_MAX_HOUSES_DELIVERED], "max_houses_delivered");
      orm_addvar_int(orm, JobConfig[BOXVILLE_CREATED_AT], "created_at");
      orm_addvar_int(orm, JobConfig[BOXVILLE_UPDATED_AT], "updated_at");

      orm_setkey(orm, "id");
    }
    case SIDEJOB_BUS_DRIVER:
    {
      new
        ORM:orm = JobConfig[BUS_DRIVER_ORM] = orm_create(BUS_DRIVER_TABLE_NAME, g_iHandle)
      ;

      orm_addvar_int(orm, JobConfig[BUS_DRIVER_SQL_ID], "id");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_ENABLED], "enabled");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_BASE_SALARY], "base_salary");
      orm_addvar_float(orm, JobConfig[BUS_DRIVER_BONUS_CHANCE], "bonus_chance");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_BONUS_MINIMUM], "bonus_minimum");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_BONUS_MAXIMUM], "bonus_maximum");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_EXIT_DELAY], "exit_delay");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_FAIL_DELAY], "fail_delay");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_SUCCESS_DELAY], "success_delay");
      orm_addvar_float(orm, JobConfig[BUS_DRIVER_MINIMUM_HEALTH], "minimum_health");
      orm_addvar_float(orm, JobConfig[BUS_DRIVER_MAX_SPEED], "max_speed");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_CREATED_AT], "created_at");
      orm_addvar_int(orm, JobConfig[BUS_DRIVER_UPDATED_AT], "updated_at");

      orm_setkey(orm, "id");
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      new
        ORM:orm = JobConfig[MONEY_TRANSPORTER_ORM] = orm_create(MONEY_TRANSPORTER_TABLE_NAME, g_iHandle)
      ;

      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_SQL_ID], "id");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_ENABLED], "enabled");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_BASE_SALARY], "base_salary");
      orm_addvar_float(orm, JobConfig[MONEY_TRANSPORTER_BONUS_CHANCE], "bonus_chance");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_BONUS_MINIMUM], "bonus_minimum");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_BONUS_MAXIMUM], "bonus_maximum");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_EXIT_DELAY], "exit_delay");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_FAIL_DELAY], "fail_delay");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_SUCCESS_DELAY], "success_delay");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_MAX_ATM_CASH], "max_atm_cash");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_MAX_VAN_CASH], "max_van_cash");
      orm_addvar_float(orm, JobConfig[MN_TRNSPTR_DEPOSIT_CASH_RATE], "deposit_cash_rate");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_CREATED_AT], "created_at");
      orm_addvar_int(orm, JobConfig[MONEY_TRANSPORTER_UPDATED_AT], "updated_at");

      orm_setkey(orm, "id");
    }
    case SIDEJOB_SWEEPER:
    {
      new
        ORM:orm = JobConfig[SWEEPER_ORM] = orm_create(SWEEPER_TABLE_NAME, g_iHandle)
      ;

      orm_addvar_int(orm, JobConfig[SWEEPER_SQL_ID], "id");
      orm_addvar_int(orm, JobConfig[SWEEPER_ENABLED], "enabled");
      orm_addvar_int(orm, JobConfig[SWEEPER_BASE_SALARY], "base_salary");
      orm_addvar_float(orm, JobConfig[SWEEPER_BONUS_CHANCE], "bonus_chance");
      orm_addvar_int(orm, JobConfig[SWEEPER_BONUS_MINIMUM], "bonus_minimum");
      orm_addvar_int(orm, JobConfig[SWEEPER_BONUS_MAXIMUM], "bonus_maximum");
      orm_addvar_int(orm, JobConfig[SWEEPER_EXIT_DELAY], "exit_delay");
      orm_addvar_int(orm, JobConfig[SWEEPER_FAIL_DELAY], "fail_delay");
      orm_addvar_int(orm, JobConfig[SWEEPER_SUCCESS_DELAY], "success_delay");
      orm_addvar_int(orm, JobConfig[SWEEPER_CREATED_AT], "created_at");
      orm_addvar_int(orm, JobConfig[SWEEPER_UPDATED_AT], "updated_at");

      orm_setkey(orm, "id");
    }
    case SIDEJOB_TRASHMASTER:
    {
      new
        ORM:orm = JobConfig[TRASHMASTER_ORM] = orm_create(TRASHMASTER_TABLE_NAME, g_iHandle)
      ;

      orm_addvar_int(orm, JobConfig[TRASHMASTER_SQL_ID], "id");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_ENABLED], "enabled");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_BASE_SALARY], "base_salary");
      orm_addvar_float(orm, JobConfig[TRASHMASTER_BONUS_CHANCE], "bonus_chance");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_BONUS_MINIMUM], "bonus_minimum");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_BONUS_MAXIMUM], "bonus_maximum");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_EXIT_DELAY], "exit_delay");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_FAIL_DELAY], "fail_delay");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_SUCCESS_DELAY], "success_delay");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_EARN_PER_TRASH], "earn_per_trash");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_MAX_TRASHES], "max_trashes");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_CREATED_AT], "created_at");
      orm_addvar_int(orm, JobConfig[TRASHMASTER_UPDATED_AT], "updated_at");

      orm_setkey(orm, "id");
    }
  }
}

void:JobConfig_InitLoad(E_SERVER_JOB:job)
{
  static string:query[256];

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      mysql_format(g_iHandle, query, sizeof(query), "\
        SELECT\
          `id`\
        FROM\
          `%s`\
        ORDER BY `id` DESC\
        LIMIT 1;\
      ", BOXVILLE_TABLE_NAME);

      mysql_tquery(g_iHandle, query, "OnJobConfigInitLoaded", "d", _:job);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      mysql_format(g_iHandle, query, sizeof(query), "\
        SELECT\
          `id`\
        FROM\
          `%s`\
        ORDER BY `id` DESC\
        LIMIT 1;\
      ", BUS_DRIVER_TABLE_NAME);

      mysql_tquery(g_iHandle, query, "OnJobConfigInitLoaded", "d", _:job);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      mysql_format(g_iHandle, query, sizeof(query), "\
        SELECT\
          `id`\
        FROM\
          `%s`\
        ORDER BY `id` DESC\
        LIMIT 1;\
      ", MONEY_TRANSPORTER_TABLE_NAME);

      mysql_tquery(g_iHandle, query, "OnJobConfigInitLoaded", "d", _:job);
    }
    case SIDEJOB_SWEEPER:
    {
      mysql_format(g_iHandle, query, sizeof(query), "\
        SELECT\
          `id`\
        FROM\
          `%s`\
        ORDER BY `id` DESC\
        LIMIT 1;\
      ", SWEEPER_TABLE_NAME);

      mysql_tquery(g_iHandle, query, "OnJobConfigInitLoaded", "d", _:job);
    }
    case SIDEJOB_TRASHMASTER:
    {
      mysql_format(g_iHandle, query, sizeof(query), "\
        SELECT\
          `id`\
        FROM\
          `%s`\
        ORDER BY `id` DESC\
        LIMIT 1;\
      ", TRASHMASTER_TABLE_NAME);

      mysql_tquery(g_iHandle, query, "OnJobConfigInitLoaded", "d", _:job);
    }
  }
}

JobConfig_CreateConfig(E_SERVER_JOB:job)
{
  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      orm_insert(JobConfig[BOXVILLE_ORM], "OnJobConfigCreated", "d", _:job);
    }
    case SIDEJOB_BUS_DRIVER:
    {
      orm_insert(JobConfig[BUS_DRIVER_ORM], "OnJobConfigCreated", "d", _:job);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      orm_insert(JobConfig[MONEY_TRANSPORTER_ORM], "OnJobConfigCreated", "d", _:job);
    }
    case SIDEJOB_SWEEPER:
    {
      orm_insert(JobConfig[SWEEPER_ORM], "OnJobConfigCreated", "d", _:job);
    }
    case SIDEJOB_TRASHMASTER:
    {
      orm_insert(JobConfig[TRASHMASTER_ORM], "OnJobConfigCreated", "d", _:job);
    }
  }

  return 1;
}

JobConfig_Load(E_SERVER_JOB:job, job_id = 0)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  if (!job_id)
  {
    return 0;
  }

  new
    ORM:orm = MYSQL_INVALID_ORM
  ;

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_SQL_ID] = job_id;
      orm = JobConfig[BOXVILLE_ORM];
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_SQL_ID] = job_id;
      orm = JobConfig[BUS_DRIVER_ORM];
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_SQL_ID] = job_id;
      orm = JobConfig[MONEY_TRANSPORTER_ORM];
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_SQL_ID] = job_id;
      orm = JobConfig[SWEEPER_ORM];
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_SQL_ID] = job_id;
      orm = JobConfig[TRASHMASTER_ORM];
    }
    default:
    {
      return 0;
    }
  }

  orm_load(orm, "OnJobConfigLoaded", "dd", _:job, job_id);
  return 1;
}

JobConfig_Save(E_SERVER_JOB:job)
{
  if (!JobConfig_IsLoaded(job))
  {
    return 0;
  }

  static ORM:orm;

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig[BOXVILLE_UPDATED_AT] = gettime();
      orm = JobConfig[BOXVILLE_ORM];
    }
    case SIDEJOB_BUS_DRIVER:
    {
      JobConfig[BUS_DRIVER_UPDATED_AT] = gettime();
      orm = JobConfig[BUS_DRIVER_ORM];
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      JobConfig[MONEY_TRANSPORTER_UPDATED_AT] = gettime();
      orm = JobConfig[MONEY_TRANSPORTER_ORM];
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig[SWEEPER_UPDATED_AT] = gettime();
      orm = JobConfig[SWEEPER_ORM];
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig[TRASHMASTER_UPDATED_AT] = gettime();
      orm = JobConfig[TRASHMASTER_ORM];
    }
    default:
    {
      return 0;
    }
  }

  JobConfig_UpdateSummary(job);

  orm_save(orm, "OnJobConfigSaved", "d", _:job);
  return 1;
}

// ======================================================
// ======================================================
// ======================================================

JobConfig_UpdateSummary(E_SERVER_JOB:job)
{
  static Float:bonus_chance;

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      JobConfig_GetBonusChance(job, bonus_chance);

      format(BoxvilleSummary, sizeof(BoxvilleSummary), "\
      #\tConfig\tValue\n\
      1\tStatus\t%s\n\
      2\tBase Salary\t%s\n\
      3\tBonus Chance\t%.2f%%\n\
      4\tBonus Minimum\t%s\n\
      5\tBonus Maximum\t%s\n\
      6\tExit Delay\t%d second(s)\n\
      7\tFail Delay\t%d second(s)\n\
      8\tSuccess Delay\t%d second(s)\n\
      9\tEarn Per House\t%s\n\
      10\tMax Houses Delivered\t%d\n\
      ", (JobConfig_IsJobEnabled(job) ? "{00FF00}Enabled{FFFFFF}" : "{FF0000}Disabled{FFFFFF}")
      , FormatNumber(JobConfig_GetBaseSalary(job))
      , bonus_chance
      , FormatNumber(JobConfig_GetBonusMinimum(job))
      , FormatNumber(JobConfig_GetBonusMaximum(job))
      , JobConfig_GetExitDelay(job)
      , JobConfig_GetFailDelay(job)
      , JobConfig_GetSuccessDelay(job)
      , FormatNumber(JobConfig_GetEarnPerHouse())
      , JobConfig_GetMaxHousesDelivered());
    }
    case SIDEJOB_BUS_DRIVER:
    {
      static Float:health;
      static Float:max_speed;

      JobConfig_GetBonusChance(job, bonus_chance);
      JobConfig_GetBusMinimumHealth(health);
      JobConfig_GetBusMaxSpeed(max_speed);

      format(BusDriverSummary, sizeof(BusDriverSummary), "\
      #\tConfig\tValue\n\
      1\tStatus\t%s\n\
      2\tBase Salary\t%s\n\
      3\tBonus Chance\t%.2f%%\n\
      4\tBonus Minimum\t%s\n\
      5\tBonus Maximum\t%s\n\
      6\tExit Delay\t%d second(s)\n\
      7\tFail Delay\t%d second(s)\n\
      8\tSuccess Delay\t%d second(s)\n\
      9\tMinimum Health\t%.1f\n\
      10\tMax Speed\t%.1f km/h\
      ", (JobConfig_IsJobEnabled(job) ? "{00FF00}Enabled{FFFFFF}" : "{FF0000}Disabled{FFFFFF}")
      , FormatNumber(JobConfig_GetBaseSalary(job))
      , bonus_chance
      , FormatNumber(JobConfig_GetBonusMinimum(job))
      , FormatNumber(JobConfig_GetBonusMaximum(job))
      , JobConfig_GetExitDelay(job)
      , JobConfig_GetFailDelay(job)
      , JobConfig_GetSuccessDelay(job)
      , health
      , max_speed);
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      static Float:deposit_cash_rate;

      JobConfig_GetBonusChance(job, bonus_chance);
      JobConfig_GetDepositCashRate(deposit_cash_rate);

      format(MoneyTransporterSummary, sizeof(MoneyTransporterSummary), "\
      #\tConfig\tValue\n\
      1\tStatus\t%s\n\
      2\tBase Salary\t%s\n\
      3\tBonus Chance\t%.2f%%\n\
      4\tBonus Minimum\t%s\n\
      5\tBonus Maximum\t%s\n\
      6\tExit Delay\t%d second(s)\n\
      7\tFail Delay\t%d second(s)\n\
      8\tSuccess Delay\t%d second(s)\n\
      9\tMax ATM Cash\t%s\n\
      10\tMax Van Cash\t%s\n\
      11\tDeposit Cash Rate\t%.2f%%\
      ", (JobConfig_IsJobEnabled(job) ? "{00FF00}Enabled{FFFFFF}" : "{FF0000}Disabled{FFFFFF}")
      , FormatNumber(JobConfig_GetBaseSalary(job))
      , bonus_chance
      , FormatNumber(JobConfig_GetBonusMinimum(job))
      , FormatNumber(JobConfig_GetBonusMaximum(job))
      , JobConfig_GetExitDelay(job)
      , JobConfig_GetFailDelay(job)
      , JobConfig_GetSuccessDelay(job)
      , FormatNumber(JobConfig_GetMaxATMCash())
      , FormatNumber(JobConfig_GetMaxVanCash())
      , deposit_cash_rate);
    }
    case SIDEJOB_SWEEPER:
    {
      JobConfig_GetBonusChance(job, bonus_chance);

      format(SweeperSummary, sizeof(SweeperSummary), "\
      #\tConfig\tValue\n\
      1\tStatus\t%s\n\
      2\tBase Salary\t%s\n\
      3\tBonus Chance\t%.2f%%\n\
      4\tBonus Minimum\t%s\n\
      5\tBonus Maximum\t%s\n\
      6\tExit Delay\t%d second(s)\n\
      7\tFail Delay\t%d second(s)\n\
      8\tSuccess Delay\t%d second(s)\
      ", (JobConfig_IsJobEnabled(job) ? "{00FF00}Enabled{FFFFFF}" : "{FF0000}Disabled{FFFFFF}")
      , FormatNumber(JobConfig_GetBaseSalary(job))
      , bonus_chance
      , FormatNumber(JobConfig_GetBonusMinimum(job))
      , FormatNumber(JobConfig_GetBonusMaximum(job))
      , JobConfig_GetExitDelay(job)
      , JobConfig_GetFailDelay(job)
      , JobConfig_GetSuccessDelay(job));
    }
    case SIDEJOB_TRASHMASTER:
    {
      JobConfig_GetBonusChance(job, bonus_chance);

      format(TrashmasterSummary, sizeof(TrashmasterSummary), "\
      #\tConfig\tValue\n\
      1\tStatus\t%s\n\
      2\tBase Salary\t%s\n\
      3\tBonus Chance\t%.2f%%\n\
      4\tBonus Minimum\t%s\n\
      5\tBonus Maximum\t%s\n\
      6\tExit Delay\t%d second(s)\n\
      7\tFail Delay\t%d second(s)\n\
      8\tSuccess Delay\t%d second(s)\n\
      9\tEarn Per Trash\t%s\n\
      10\tMax Trashes\t%d\
      ", (JobConfig_IsJobEnabled(job) ? "{00FF00}Enabled{FFFFFF}" : "{FF0000}Disabled{FFFFFF}")
      , FormatNumber(JobConfig_GetBaseSalary(job))
      , bonus_chance
      , FormatNumber(JobConfig_GetBonusMinimum(job))
      , FormatNumber(JobConfig_GetBonusMaximum(job))
      , JobConfig_GetExitDelay(job)
      , JobConfig_GetFailDelay(job)
      , JobConfig_GetSuccessDelay(job)
      , FormatNumber(JobConfig_GetEarnPerTrash())
      , JobConfig_GetMaxTrashes());
    }
  }

  return 1;
}

JobConfig_ShowSummary(playerid, E_SERVER_JOB:job)
{
  if (!IsPlayerConnected(playerid))
  {
    return 0;
  }

  JobConfig_SetLastJob(playerid, job);

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      Dialog_Show(playerid, AdjustBoxvilleConf, DIALOG_STYLE_TABLIST_HEADERS, "Sidejob - Boxville", BoxvilleSummary, "Edit", "Back");
    }
    case SIDEJOB_BUS_DRIVER:
    {
      Dialog_Show(playerid, AdjustBusDriverConf, DIALOG_STYLE_TABLIST_HEADERS, "Sidejob - Bus Driver", BusDriverSummary, "Edit", "Back");
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      Dialog_Show(playerid, AdjustTransporterConf, DIALOG_STYLE_TABLIST_HEADERS, "Sidejob - Money Transporter", MoneyTransporterSummary, "Edit", "Back");
    }
    case SIDEJOB_SWEEPER:
    {
      Dialog_Show(playerid, AdjustSweeperConf, DIALOG_STYLE_TABLIST_HEADERS, "Sidejob - Sweeper", SweeperSummary, "Edit", "Back");
    }
    case SIDEJOB_TRASHMASTER:
    {
      Dialog_Show(playerid, AdjustTrashmasterConf, DIALOG_STYLE_TABLIST_HEADERS, "Sidejob - Trashmaster", TrashmasterSummary, "Edit", "Back");
    }
  }

  return 1;
}

JobConfig_ShowList(playerid)
{
  JobConfig_ResetLastJob(playerid);

  if (!IsPlayerConnected(playerid))
  {
    return 0;
  }

  Dialog_Show(playerid, ViewJobConfig, DIALOG_STYLE_TABLIST_HEADERS, "Job Config", "\
  #\tName\n\
  1\t(Sidejob) Boxville\n\
  2\t(Sidejob) Bus Driver\n\
  3\t(Sidejob) Money Transporter\n\
  4\t(Sidejob) Sweeper\n\
  5\t(Sidejob) Trashmaster\
  ", "Edit", "Close");
  return 1;
}

Dialog:ViewJobConfig(playerid, response, listitem, inputtext[])
{
  JobConfig_ResetLastConfig(playerid);

  if (!response)
  {
    return 1;
  }

  switch (listitem)
  {
    case 0: // Boxville
    {
      JobConfig_ShowSummary(playerid, SIDEJOB_BOXVILLE);
    }
    case 1: // Bus Driver
    {
      JobConfig_ShowSummary(playerid, SIDEJOB_BUS_DRIVER);
    }
    case 2: // Money Transporter
    {
      JobConfig_ShowSummary(playerid, SIDEJOB_MONEY_TRANSPORTER);
    }
    case 3: // Sweeper
    {
      JobConfig_ShowSummary(playerid, SIDEJOB_SWEEPER);
    }
    case 4: // Trashmaster
    {
      JobConfig_ShowSummary(playerid, SIDEJOB_TRASHMASTER);
    }
    default:
    {
      return 1;
    }
  }

  return 1;
}

Dialog:UpdateGeneralJobConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
    JobConfig_ResetLastConfig(playerid);
    return 1;
  }

  static string:job_name[24];
  static string:str[96];
  JobConfig_GetJobName(JobConfig_GetLastJob(playerid), job_name, sizeof(job_name));

  switch (JobConfig_GetLastConfig(playerid))
  {
    case ENABLED:
    {
      if (listitem == 0)
      {
        JobConfig_SetJobEnabled(JobConfig_GetLastJob(playerid), 1);
      }
      else if (listitem == 1)
      {
        JobConfig_SetJobEnabled(JobConfig_GetLastJob(playerid), 0);
      }
      else
      {
        format(str, sizeof(str), "%s - Set Job Enabled", job_name);
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateTransporterConf, DIALOG_STYLE_INPUT, job_name, "{00FF00}Enabled\n{FF0000}Disabled", "Update", "Close");
        return 1;
      }

      format(str, sizeof(str), "You've updated %s's status.", job_name);
      SendClientMessage(playerid, X11_WHITE, str);
    }
    case BASE_SALARY:
    {
      new value = strval(inputtext);

      if (value < 0 || value > 100_000)
      {
        format(str, sizeof(str), "%s - Set Base Salary", job_name);
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0 - 100,000). 0 means no base salary.", "Update", "Close");
        return 1;
      }

      JobConfig_SetBaseSalary(JobConfig_GetLastJob(playerid), value);
      format(str, sizeof(str), "You've updated %s's base salary.", job_name);
      SendClientMessage(playerid, X11_WHITE, str);
    }
    case BONUS_CHANCE:
    {
      new Float:value = floatstr(inputtext);

      if (value < 0.0 || value > 100.0)
      {
        format(str, sizeof(str), "%s - Set Bonus Chance", job_name);
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0.00 - 100.00). 0 means no chance to get bonus.", "Update", "Close");
        return 1;
      }

      JobConfig_SetBonusChance(JobConfig_GetLastJob(playerid), value);
      format(str, sizeof(str), "You've updated %s's bonus chance.", job_name);
      SendClientMessage(playerid, X11_WHITE, str);
    }
    case BONUS_MINIMUM:
    {
      new value = strval(inputtext);

      if (value < 0 || value > 100_000)
      {
        format(str, sizeof(str), "%s - Set Bonus Minimum", job_name);
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0 - 100,000). 0 means no minimum.", "Update", "Close");
        return 1;
      }

      new bonus_maximum = JobConfig_GetBonusMaximum(JobConfig_GetLastJob(playerid));
      if (bonus_maximum < value)
      {
        format(str, sizeof(str), "%s - Set Bonus Minimum", job_name);
        SendClientMessage(playerid, X11_RED, "Bonus minimum is higher than bonus maximum.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0 - 100,000). 0 means no minimum.", "Update", "Close");
        return 1;
      }

      JobConfig_SetBonusMinimum(JobConfig_GetLastJob(playerid), value);
      format(str, sizeof(str), "You've updated %s's bonus minimum.", job_name);
      SendClientMessage(playerid, X11_WHITE, str);
    }
    case BONUS_MAXIMUM:
    {
      new value = strval(inputtext);

      if (value < 0 || value > 100_000)
      {
        format(str, sizeof(str), "%s - Set Bonus Maximum", job_name);
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0 - 100,000). 0 means no maximum.", "Update", "Close");
        return 1;
      }

      new bonus_minimum = JobConfig_GetBonusMinimum(JobConfig_GetLastJob(playerid));
      if (bonus_minimum > value)
      {
        format(str, sizeof(str), "%s - Set Bonus Maximum", job_name);
        SendClientMessage(playerid, X11_RED, "Bonus maximum is higher than bonus minimum.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0 - 100,000). 0 means no minimum.", "Update", "Close");
        return 1;
      }

      JobConfig_SetBonusMaximum(JobConfig_GetLastJob(playerid), value);
      format(str, sizeof(str), "You've updated %s's bonus maximum.", job_name);
      SendClientMessage(playerid, X11_WHITE, str);
    }
    case EXIT_DELAY:
    {
      new value = strval(inputtext);

      if (value < 0 || value > 100_000)
      {
        format(str, sizeof(str), "%s - Set Exit Delay", job_name);
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
        return 1;
      }

      JobConfig_SetExitDelay(JobConfig_GetLastJob(playerid), value);
      format(str, sizeof(str), "You've updated %s's exit delay.", job_name);
      SendClientMessage(playerid, X11_WHITE, str);
    }
    case FAIL_DELAY:
    {
      new value = strval(inputtext);

      if (value < 0 || value > 100_000)
      {
        format(str, sizeof(str), "%s - Set Fail Delay", job_name);
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
        return 1;
      }

      JobConfig_SetFailDelay(JobConfig_GetLastJob(playerid), value);
      format(str, sizeof(str), "You've updated %s's fail delay.", job_name);
      SendClientMessage(playerid, X11_WHITE, str);
    }
    case SUCCESS_DELAY:
    {
      new value = strval(inputtext);

      if (value < 0 || value > 100_000)
      {
        format(str, sizeof(str), "%s - Set Success Delay", job_name);
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, str, "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
        return 1;
      }

      JobConfig_SetSuccessDelay(JobConfig_GetLastJob(playerid), value);
      format(str, sizeof(str), "You've updated %s's success delay.", job_name);
      SendClientMessage(playerid, X11_WHITE, str);
    }
    default:
    {
      return 1;
    }
  }

  JobConfig_ResetLastConfig(playerid);
  JobConfig_UpdateSummary(JobConfig_GetLastJob(playerid));
  JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
  return 1;
}

// ------------------- Boxville -------------------

Dialog:UpdateBoxvilleConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
    JobConfig_ResetLastConfig(playerid);
    return 1;
  }

  switch (JobConfig_GetLastConfig(playerid))
  {
    case BXVL_EARN_PER_HOUSE:
    {
      new value = strval(inputtext);

      if (value < 0 || value > 100_000)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateBoxvilleConf, DIALOG_STYLE_INPUT, "Boxville - Set Earn Per House", "Input value (0 - 100,000). 0 means no reward.", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated Boxville's earn per house.");
      JobConfig_SetEarnPerHouse(value);
    }
    case BXVL_MAX_HOUSES_DELIVERED:
    {
      new value = strval(inputtext);

      if (value < 10 || value > 1_000)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateBoxvilleConf, DIALOG_STYLE_INPUT, "Boxville - Set Max House Delivered", "Input value (10 - 1,000).", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated Boxville's max house delivered.");
      JobConfig_SetMaxHousesDelivered(value);
    }
    default:
    {
      return 1;
    }
  }

  JobConfig_ResetLastConfig(playerid);
  JobConfig_UpdateSummary(JobConfig_GetLastJob(playerid));
  JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
  return 1;
}

Dialog:AdjustBoxvilleConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowList(playerid);
    return 1;
  }

  if (CheckAdmin(playerid, 8))
  {
    return 1;
  }

  JobConfig_SetLastJob(playerid, SIDEJOB_BOXVILLE);

  switch (listitem)
  {
    case 0: // Status
    {
      JobConfig_SetLastConfig(playerid, ENABLED);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_LIST, "Boxville - Set Sidejob Enabled", "{00FF00}Enabled\n{FF0000}Disabled", "Update", "Close");
    }
    case 1: // Base Salary
    {
      JobConfig_SetLastConfig(playerid, BASE_SALARY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Boxville - Set Base Salary", "Input value (0 - 100,000). 0 means no base salary.", "Update", "Close");
    }
    case 2: // Bonus Chance
    {
      JobConfig_SetLastConfig(playerid, BONUS_CHANCE);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Boxville - Set Bonus Chance", "Input value (0.00 - 100.00). 0 means no chance to get bonus.", "Update", "Close");
    }
    case 3: // Bonus Minimum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MINIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Boxville - Set Bonus Minimum", "Input value (0 - 100,000). 0 means no minimum.", "Update", "Close");
    }
    case 4: // Bonus Maximum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MAXIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Boxville - Set Bonus Maximum", "Input value (0 - 100,000). 0 means remove bonus.", "Update", "Close");
    }
    case 5: // Exit Delay
    {
      JobConfig_SetLastConfig(playerid, EXIT_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Boxville - Set Exit Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 6: // Fail Delay
    {
      JobConfig_SetLastConfig(playerid, FAIL_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Boxville - Set Fail Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 7: // Success Delay
    {
      JobConfig_SetLastConfig(playerid, SUCCESS_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Boxville - Set Success Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 8: // Earn Per House
    {
      JobConfig_SetLastConfig(playerid, BXVL_EARN_PER_HOUSE);
      Dialog_Show(playerid, UpdateBoxvilleConf, DIALOG_STYLE_INPUT, "Boxville - Set Earn Per House", "Input value (0 - 100,000). 0 means no reward.", "Update", "Close");
    }
    case 9: // Max House Delivered
    {
      JobConfig_SetLastConfig(playerid, BXVL_MAX_HOUSES_DELIVERED);
      Dialog_Show(playerid, UpdateBoxvilleConf, DIALOG_STYLE_INPUT, "Boxville - Set Max House Delivered", "Input value (10 - 1,000).", "Update", "Close");
    }
  }
  return 1;
}

// ------------------- Sweeper -------------------

Dialog:AdjustSweeperConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowList(playerid);
    return 1;
  }

  if (CheckAdmin(playerid, 8))
  {
    return 1;
  }

  JobConfig_SetLastJob(playerid, SIDEJOB_SWEEPER);

  switch (listitem)
  {
    case 0: // Status
    {
      JobConfig_SetLastConfig(playerid, ENABLED);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_LIST, "Sweeper - Set Sidejob Enabled", "{00FF00}Enabled\n{FF0000}Disabled", "Update", "Close");
    }
    case 1: // Base Salary
    {
      JobConfig_SetLastConfig(playerid, BASE_SALARY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Base Salary", "Input value (0 - 100,000). 0 means no base salary.", "Update", "Close");
    }
    case 2: // Bonus Chance
    {
      JobConfig_SetLastConfig(playerid, BONUS_CHANCE);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bonus Chance", "Input value (0.00 - 100.00). 0 means no chance to get bonus.", "Update", "Close");
    }
    case 3: // Bonus Minimum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MINIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bonus Minimum", "Input value (0 - 100,000). 0 means no minimum.", "Update", "Close");
    }
    case 4: // Bonus Maximum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MAXIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bonus Maximum", "Input value (0 - 100,000). 0 means remove bonus.", "Update", "Close");
    }
    case 5: // Exit Delay
    {
      JobConfig_SetLastConfig(playerid, EXIT_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Exit Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 6: // Fail Delay
    {
      JobConfig_SetLastConfig(playerid, FAIL_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Fail Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 7: // Success Delay
    {
      JobConfig_SetLastConfig(playerid, SUCCESS_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Success Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
  }
  return 1;
}

// ------------------- Bus Driver -------------------

Dialog:UpdateBusDriverConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
    JobConfig_ResetLastConfig(playerid);
    return 1;
  }

  switch (JobConfig_GetLastConfig(playerid))
  {
    case BUSDRVR_MINIMUM_HEALTH:
    {
      new Float:value = floatstr(inputtext);

      if (value < 0 || value > 1_000.0)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateBusDriverConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bus's Minimum Health", "Input value (0.0 - 1,000.0). 0 means no minimum.", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated Bus's minimum health.");
      JobConfig_SetBusMinimumHealth(value);
    }
    case BUSDRVR_MAX_SPEED:
    {
      new Float:value = floatstr(inputtext);

      if (value < 0.0 || value > 100.0)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateBusDriverConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bus's Max Speed", "Input value (0.0 - 100.0). 0 means no speed limit.", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated Bus's max speed.");
      JobConfig_SetBusMaxSpeed(value);
    }
    default:
    {
      return 1;
    }
  }

  JobConfig_ResetLastConfig(playerid);
  JobConfig_UpdateSummary(JobConfig_GetLastJob(playerid));
  JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
  return 1;
}

Dialog:AdjustBusDriverConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowList(playerid);
    return 1;
  }

  if (CheckAdmin(playerid, 8))
  {
    return 1;
  }

  JobConfig_SetLastJob(playerid, SIDEJOB_BUS_DRIVER);

  switch (listitem)
  {
    case 0: // Status
    {
      JobConfig_SetLastConfig(playerid, ENABLED);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_LIST, "Sweeper - Set Sidejob Enabled", "{00FF00}Enabled\n{FF0000}Disabled", "Update", "Close");
    }
    case 1: // Base Salary
    {
      JobConfig_SetLastConfig(playerid, BASE_SALARY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Base Salary", "Input value (0 - 100,000). 0 means no base salary.", "Update", "Close");
    }
    case 2: // Bonus Chance
    {
      JobConfig_SetLastConfig(playerid, BONUS_CHANCE);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bonus Chance", "Input value (0.00 - 100.00). 0 means no chance to get bonus.", "Update", "Close");
    }
    case 3: // Bonus Minimum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MINIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bonus Minimum", "Input value (0 - 100,000). 0 means no minimum.", "Update", "Close");
    }
    case 4: // Bonus Maximum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MAXIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bonus Maximum", "Input value (0 - 100,000). 0 means remove bonus.", "Update", "Close");
    }
    case 5: // Exit Delay
    {
      JobConfig_SetLastConfig(playerid, EXIT_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Exit Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 6: // Fail Delay
    {
      JobConfig_SetLastConfig(playerid, FAIL_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Fail Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 7: // Success Delay
    {
      JobConfig_SetLastConfig(playerid, SUCCESS_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Sweeper - Set Success Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 8: // Minimum Health
    {
      JobConfig_SetLastConfig(playerid, BUSDRVR_MINIMUM_HEALTH);
      Dialog_Show(playerid, UpdateBusDriverConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bus's Minimum Health", "Input value (0.0 - 1,000.0). 0 means no minimum.", "Update", "Close");
    }
    case 9: // Max Speed
    {
      JobConfig_SetLastConfig(playerid, BUSDRVR_MAX_SPEED);
      Dialog_Show(playerid, UpdateBusDriverConf, DIALOG_STYLE_INPUT, "Sweeper - Set Bus's Max Speed", "Input value (0.0 - 100.0). 0 means no speed limit.", "Update", "Close");
    }
  }
  return 1;
}

// ------------------- Trashmaster -------------------

Dialog:UpdateTrashmasterConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
    JobConfig_ResetLastConfig(playerid);
    return 1;
  }

  switch (JobConfig_GetLastConfig(playerid))
  {
    case TRSHMSTR_EARN_PER_TRASH:
    {
      new value = strval(inputtext);

      if (value < 1 || value > 100_000)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateTrashmasterConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Earn Per Trash", "Input value (1 - 100,000).", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated trashmaster earn per trash.");
      JobConfig_SetEarnPerTrash(value);
    }
    case TRSHMSTR_MAX_TRASHES:
    {
      new value = strval(inputtext);

      if (value < 10 || value > 100_000)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateTrashmasterConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Max Trashes", "Input value (10 - 100,000).", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated trashmaster max trashes.");
      JobConfig_SetMaxTrashes(value);
    }
    default:
    {
      return 1;
    }
  }

  JobConfig_ResetLastConfig(playerid);
  JobConfig_UpdateSummary(JobConfig_GetLastJob(playerid));
  JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
  return 1;
}

Dialog:AdjustTrashmasterConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowList(playerid);
    return 1;
  }

  if (CheckAdmin(playerid, 8))
  {
    return 1;
  }

  JobConfig_SetLastJob(playerid, SIDEJOB_TRASHMASTER);

  switch (listitem)
  {
    case 0: // Status
    {
      JobConfig_SetLastConfig(playerid, ENABLED);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_LIST, "Trashmaster - Set Job Enabled", "{00FF00}Enabled\n{FF0000}Disabled", "Update", "Close");
    }
    case 1: // Base Salary
    {
      JobConfig_SetLastConfig(playerid, BASE_SALARY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Base Salary", "Input value (0 - 100,000). 0 means no base salary.", "Update", "Close");
    }
    case 2: // Bonus Chance
    {
      JobConfig_SetLastConfig(playerid, BONUS_CHANCE);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Bonus Chance", "Input value (0.00 - 100.00). 0 means no chance to get bonus.", "Update", "Close");
    }
    case 3: // Bonus Minimum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MINIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Bonus Minimum", "Input value (0 - 100,000). 0 means no minimum.", "Update", "Close");
    }
    case 4: // Bonus Maximum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MAXIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Bonus Maximum", "Input value (0 - 100,000). 0 means remove bonus.", "Update", "Close");
    }
    case 5: // Exit Delay
    {
      JobConfig_SetLastConfig(playerid, EXIT_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Exit Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 6: // Fail Delay
    {
      JobConfig_SetLastConfig(playerid, FAIL_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Fail Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 7: // Success Delay
    {
      JobConfig_SetLastConfig(playerid, SUCCESS_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Success Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 8: // Earn Per Trash
    {
      JobConfig_SetLastConfig(playerid, TRSHMSTR_EARN_PER_TRASH);
      Dialog_Show(playerid, UpdateTrashmasterConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Earn Per Trash", "Input value (1 - 100,000).", "Update", "Close");
    }
    case 9: // Max Trashes
    {
      JobConfig_SetLastConfig(playerid, TRSHMSTR_MAX_TRASHES);
      Dialog_Show(playerid, UpdateTrashmasterConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Max Trashes", "Input value (10 - 100,000).", "Update", "Close");
    }
  }
  return 1;
}

// ------------------- Money Transporter -------------------

Dialog:UpdateTransporterConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
    JobConfig_ResetLastConfig(playerid);
    return 1;
  }

  switch (JobConfig_GetLastConfig(playerid))
  {
    case MNTRNSPTR_MAX_ATM_CASH:
    {
      new value = strval(inputtext);

      if (value < 1 || value > 100_000)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateTrashmasterConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Earn Per Trash", "Input value (1 - 100,000).", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated trashmaster earn per trash.");
      JobConfig_SetMaxATMCash(value);
    }
    case MNTRNSPTR_MAX_VAN_CASH:
    {
      new value = strval(inputtext);

      if (value < 1 || value > 100_000)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateTrashmasterConf, DIALOG_STYLE_INPUT, "Trashmaster - Set Max Trashes", "Input value (1 - 100,000).", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated trashmaster max trashes.");
      JobConfig_SetMaxVanCash(value);
    }
    case MNTRNSPTR_DEPOSIT_CASH_RATE:
    {
      new Float:value = floatstr(inputtext);

      if (value < 0.0 || value > 100.0)
      {
        SendClientMessage(playerid, X11_RED, "Wrong value.");
        Dialog_Show(playerid, UpdateTransporterConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Deposit Cash Rate", "Input value (0.000 - 100.000). 0 means no earn per deposited cash by rate.", "Update", "Close");
        return 1;
      }

      SendClientMessage(playerid, X11_WHITE, "You've updated money transporter's earn deposit cash by rate.");
      JobConfig_SetDepositCashRate(value);
    }
    default:
    {
      return 1;
    }
  }

  JobConfig_ResetLastConfig(playerid);
  JobConfig_UpdateSummary(JobConfig_GetLastJob(playerid));
  JobConfig_ShowSummary(playerid, JobConfig_GetLastJob(playerid));
  return 1;
}

Dialog:AdjustTransporterConf(playerid, response, listitem, inputtext[])
{
  if (!response)
  {
    JobConfig_ShowList(playerid);
    return 1;
  }

  if (CheckAdmin(playerid, 8))
  {
    return 1;
  }

  JobConfig_SetLastJob(playerid, SIDEJOB_MONEY_TRANSPORTER);

  switch (listitem)
  {
    case 0: // Status
    {
      JobConfig_SetLastConfig(playerid, ENABLED);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_LIST, "Money Transporter - Set Job Enabled", "{00FF00}Enabled\n{FF0000}Disabled", "Update", "Close");
    }
    case 1: // Base Salary
    {
      JobConfig_SetLastConfig(playerid, BASE_SALARY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Base Salary", "Input value (0 - 100,000). 0 means no base salary.", "Update", "Close");
    }
    case 2: // Bonus Chance
    {
      JobConfig_SetLastConfig(playerid, BONUS_CHANCE);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Bonus Chance", "Input value (0.00 - 100.00). 0 means no chance to get bonus.", "Update", "Close");
    }
    case 3: // Bonus Minimum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MINIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Bonus Minimum", "Input value (0 - 100,000).", "Update", "Close");
    }
    case 4: // Bonus Maximum
    {
      JobConfig_SetLastConfig(playerid, BONUS_MAXIMUM);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Bonus Maximum", "Input value (0 - 100,000).", "Update", "Close");
    }
    case 5: // Exit Delay
    {
      JobConfig_SetLastConfig(playerid, EXIT_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Exit Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 6: // Fail Delay
    {
      JobConfig_SetLastConfig(playerid, FAIL_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Fail Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 7: // Success Delay
    {
      JobConfig_SetLastConfig(playerid, SUCCESS_DELAY);
      Dialog_Show(playerid, UpdateGeneralJobConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Success Delay", "Input value (0 - 100,000). 0 means no delay.", "Update", "Close");
    }
    case 8: // Max Cash Per ATM
    {
      JobConfig_SetLastConfig(playerid, MNTRNSPTR_MAX_ATM_CASH);
      Dialog_Show(playerid, UpdateTransporterConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Max Cash Per ATM", "Input value (1 - 100,000).", "Update", "Close");
    }
    case 9: // Max Cash Per Van
    {
      JobConfig_SetLastConfig(playerid, MNTRNSPTR_MAX_VAN_CASH);
      Dialog_Show(playerid, UpdateTransporterConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Max Cash Per Van", "Input value (1 - 100,000).", "Update", "Close");
    }
    case 10: // Deposit Cash Rate
    {
      JobConfig_SetLastConfig(playerid, MNTRNSPTR_DEPOSIT_CASH_RATE);
      Dialog_Show(playerid, UpdateTransporterConf, DIALOG_STYLE_INPUT, "Money Transporter - Set Deposit Cash Rate", "Input value (0.000 - 100.000). 0 means no earn per deposited cash by rate.", "Update", "Close");
    }
  }
  return 1;
}
