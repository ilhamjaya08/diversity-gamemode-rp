// built-in include guard removal
// just in case the user has a local dependency with the same file name
#if defined _inc_func
	#undef _inc_func
#endif
// custom include-guard to ensure we don't duplicate
#if defined _func_srv_realtime_included
	#endinput
#endif
#define _func_srv_realtime_included


#include <realtime-clock>


// Phone_UpdatePlayerClock(playerid)
// {
//   if (!IsPlayerConnected(playerid))
//   {
//     return 0;
//   }

//   PlayerTextDrawSetString(
//     playerid,
//     PhoneTimeMaximize[playerid],
//     sprintf("%02d:%02d", ServerData[ServerTime], ServerData[ServerTimeMinute])
//   );
//   PlayerTextDrawSetString(
//     playerid,
//     PhoneTimeMinimize[playerid],
//     sprintf("%02d:%02d", ServerData[ServerTime], ServerData[ServerTimeMinute])
//   );
//   return 1;
// }

// void:Phone_UpdateClock()
// {
//   foreach (new p : Player)
//   {
//     Phone_UpdatePlayerClock(p);
//   }
// }
