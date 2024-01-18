
new
	eventJoin[MAX_PLAYERS] = {0, ...},
	eventTeams[MAX_PLAYERS] = {0, ...},
	eventWaitingSpawn[MAX_PLAYERS] = {0, ...},
	eventCheckpoint[MAX_PLAYERS] = {0, ...},
	Text:eventTextdraws[8],
	eventMessageText[4][128],
	Timer:haupdate[MAX_PLAYERS],
  	eventScore_DM[MAX_PLAYERS] = {0, ...}
;

#include "event/enumerations.pwn"
#include "event/function.pwn"
#include "event/callback.pwn"
#include "event/command.pwn"
#include "event/dialog.pwn"
