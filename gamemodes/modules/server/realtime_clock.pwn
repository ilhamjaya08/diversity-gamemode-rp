// built-in include guard removal
// just in case the user has a local dependency with the same file name
#if defined _inc_realtime_clock
	#undef _inc_realtime_clock
#endif
// custom include-guard to ensure we don't duplicate
#if defined _mod_srv_realtime_included
	#endinput
#endif
#define _mod_srv_realtime_included


#include "realtime_clock/func.pwn"
#include "realtime_clock/callbacks.pwn"
