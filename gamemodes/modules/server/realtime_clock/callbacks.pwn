// built-in include guard removal
// just in case the user has a local dependency with the same file name
#if defined _inc_callbacks
	#undef _inc_callbacks
#endif
// custom include-guard to ensure we don't duplicate
#if defined _cb_srv_realtime_included
	#endinput
#endif
#define _cb_srv_realtime_included


#include <realtime-clock>
#include <YSI\y_hooks>


hook OnGameModeInitEx()
{
  print("[SERVER REALTIME] Module initialized.");
  RealTime_SetInterval(60_000);

  ServerData[IsRealTimeEnabled] = true;
}

hook OnPlayerConnect(playerid)
{
  RealTime_SyncPlayerWorldTime(playerid);
}

public OnWorldTimeUpdate(hour, minute)
{
  ServerData[ServerTime] = hour;
  ServerData[ServerTimeMinute] = minute;

  // Update the server info's worldtime.
  SendRconCommand(sprintf("worldtime %02d:%02d", hour, minute));

  // Update the phone time.
  // Phone_UpdateClock();
  return 1;
}
