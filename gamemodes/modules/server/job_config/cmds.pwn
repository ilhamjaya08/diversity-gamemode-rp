#if defined _inc_cmds
  #undef _inc_cmds
#endif
#if defined SERVER_JOBCONFIG_CMDS
  #endinput
#endif
#define SERVER_JOBCONFIG_CMDS



//



CMD:jobconfig(playerid, params[])
{
  #pragma unused params

  if (CheckAdmin(playerid, 1))
  {
    return 1;
  }

  JobConfig_ShowList(playerid);
  return 1;
}
