#if defined _inc_cmds
  #undef _inc_cmds
#endif
#if defined SERVER_ECONOMY_CMDS
  #endinput
#endif
#define SERVER_ECONOMY_CMDS



//



CMD:economy(playerid, params[])
{
  #pragma unused params

  if (CheckAdmin(playerid, 1))
  {
    return 1;
  }

  Economy_ShowSummary(playerid);
  return 1;
}
