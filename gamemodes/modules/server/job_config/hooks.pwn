#if defined _inc_hooks
  #undef _inc_hooks
#endif
#if defined SERVER_JOBCONFIG_HOOKS
  #endinput
#endif
#define SERVER_JOBCONFIG_HOOKS



#include <YSI_Coding\y_hooks>



hook OnScriptInit()
{
  JobConfig_InitEnum();
}

hook OnDBConnReady()
{
  printf("[JOB CONFIG] Initialization called.");

  JobConfig_InitORM(SIDEJOB_BOXVILLE);
  JobConfig_InitORM(SIDEJOB_BUS_DRIVER);
  JobConfig_InitORM(SIDEJOB_MONEY_TRANSPORTER);
  JobConfig_InitORM(SIDEJOB_SWEEPER);
  JobConfig_InitORM(SIDEJOB_TRASHMASTER);
  
  JobConfig_InitLoad(SIDEJOB_BOXVILLE);
  JobConfig_InitLoad(SIDEJOB_BUS_DRIVER);
  JobConfig_InitLoad(SIDEJOB_MONEY_TRANSPORTER);
  JobConfig_InitLoad(SIDEJOB_SWEEPER);
  JobConfig_InitLoad(SIDEJOB_TRASHMASTER);
}

hook OnScriptExit()
{
  JobConfig_Save(SIDEJOB_BOXVILLE);
  JobConfig_Save(SIDEJOB_BUS_DRIVER);
  JobConfig_Save(SIDEJOB_MONEY_TRANSPORTER);
  JobConfig_Save(SIDEJOB_SWEEPER);
  JobConfig_Save(SIDEJOB_TRASHMASTER);
}

hook OnPlayerConnect(playerid)
{
  JobConfig_ResetLastJob(playerid);
  JobConfig_ResetLastConfig(playerid);
  return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
  #pragma unused reason

  JobConfig_ResetLastJob(playerid);
  JobConfig_ResetLastConfig(playerid);
  return 1;
}

hook OnJobConfigInitLoaded(E_SERVER_JOB:job)
{
  if (cache_num_rows() == 0)
  {
    static job_name[24];
    JobConfig_GetJobName(job, job_name, sizeof(job_name));

    printf("[JOB CONFIG] Job config \"%s\" not detected. Creating new one ...", job_name);

    JobConfig_InitEnum(job, false);
    JobConfig_CreateConfig(job);
    return 1;
  }

  static config_id;
  cache_get_value_name_int(0, "id", config_id);
  JobConfig_Load(job, config_id);
  return 1;
}

hook OnJobConfigLoaded(E_SERVER_JOB:job, job_id)
{
  #pragma unused job_id
  
  static job_name[24];
  JobConfig_GetJobName(job, job_name, sizeof(job_name));

  switch (job)
  {
    case SIDEJOB_BOXVILLE:
    {
      printf("[JOB CONFIG] Job config \"%s\" loaded. [SQL ID: %d | Base Salary: %s | Bonus Minimum: %s | Bonus Maximum: %s | Exit delay: %d second(s) | Fail delay: %d second(s) | Success delay: %d second(s) | Earn Per House: %s | Max Houses Delivered: %d]"
        , job_name
        , JobConfig_GetSQLID(job)
        , FormatNumber(JobConfig_GetBaseSalary(job))
        , FormatNumber(JobConfig_GetBonusMinimum(job))
        , FormatNumber(JobConfig_GetBonusMaximum(job))
        , JobConfig_GetExitDelay(job)
        , JobConfig_GetFailDelay(job)
        , JobConfig_GetSuccessDelay(job)
        , FormatNumber(JobConfig_GetEarnPerHouse())
        , JobConfig_GetMaxHousesDelivered()
      );
    }
    case SIDEJOB_BUS_DRIVER:
    {
      static Float:hp;
      static Float:speed;

      JobConfig_GetBusMinimumHealth(hp);
      JobConfig_GetBusMaxSpeed(speed);

      printf("[JOB CONFIG] Job config \"%s\" loaded. [SQL ID: %d | Base Salary: %s | Bonus Minimum: %s | Bonus Maximum: %s | Exit delay: %d second(s) | Fail delay: %d second(s) | Success delay: %d second(s) | Minimum Health: %.2f | Max Speed: %.2f]"
        , job_name
        , JobConfig_GetSQLID(job)
        , FormatNumber(JobConfig_GetBaseSalary(job))
        , FormatNumber(JobConfig_GetBonusMinimum(job))
        , FormatNumber(JobConfig_GetBonusMaximum(job))
        , JobConfig_GetExitDelay(job)
        , JobConfig_GetFailDelay(job)
        , JobConfig_GetSuccessDelay(job)
        , hp
        , speed
      );
    }
    case SIDEJOB_MONEY_TRANSPORTER:
    {
      printf("[JOB CONFIG] Job config \"%s\" loaded. [SQL ID: %d | Base Salary: %s | Bonus Minimum: %s | Bonus Maximum: %s | Exit delay: %d second(s) | Fail delay: %d second(s) | Success delay: %d second(s) | Enabled: %d | Max ATM Cash: %s | Max Van Cash: %s]"
        , job_name
        , JobConfig_GetSQLID(job)
        , FormatNumber(JobConfig_GetBaseSalary(job))
        , FormatNumber(JobConfig_GetBonusMinimum(job))
        , FormatNumber(JobConfig_GetBonusMaximum(job))
        , JobConfig_GetExitDelay(job)
        , JobConfig_GetFailDelay(job)
        , JobConfig_GetSuccessDelay(job)
        , JobConfig_IsJobEnabled(job)
        , FormatNumber(JobConfig_GetMaxATMCash())
        , FormatNumber(JobConfig_GetMaxVanCash())
      );
    }
    case SIDEJOB_SWEEPER:
    {
      printf("[JOB CONFIG] Job config \"%s\" loaded. [SQL ID: %d | Base Salary: %s | Bonus Minimum: %s | Bonus Maximum: %s | Exit delay: %d second(s) | Fail delay: %d second(s) | Success delay: %d second(s)]"
        , job_name
        , JobConfig_GetSQLID(job)
        , FormatNumber(JobConfig_GetBaseSalary(job))
        , FormatNumber(JobConfig_GetBonusMinimum(job))
        , FormatNumber(JobConfig_GetBonusMaximum(job))
        , JobConfig_GetExitDelay(job)
        , JobConfig_GetFailDelay(job)
        , JobConfig_GetSuccessDelay(job)
      );
    }
    case SIDEJOB_TRASHMASTER:
    {
      printf("[JOB CONFIG] Job config \"%s\" loaded. [SQL ID: %d | Base Salary: %s | Bonus Minimum: %s | Bonus Maximum: %s | Exit delay: %d second(s) | Fail delay: %d second(s) | Success delay: %d second(s) | Earn Per Trash: %s | Max Trashes: %d]"
        , job_name
        , JobConfig_GetSQLID(job)
        , FormatNumber(JobConfig_GetBaseSalary(job))
        , FormatNumber(JobConfig_GetBonusMinimum(job))
        , FormatNumber(JobConfig_GetBonusMaximum(job))
        , JobConfig_GetExitDelay(job)
        , JobConfig_GetFailDelay(job)
        , JobConfig_GetSuccessDelay(job)
        , FormatNumber(JobConfig_GetEarnPerTrash())
        , JobConfig_GetMaxTrashes()
      );
    }
  }

  JobConfig_UpdateSummary(job);
  return 1;
}

hook OnJobConfigCreated(E_SERVER_JOB:job)
{
  JobConfig_InitLoad(job);
  return 1;
}

hook OnJobConfigSaved(E_SERVER_JOB:job)
{
  JobConfig_UpdateSummary(job);
  return 1;
}
