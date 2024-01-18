new DCC_Channel:channel_variable;

#define JOINLOG         "1020530637079322714"
#define LEAVELOG        "1020530888410398791"

#define PAYLOGLOG		"1020310614884757596"
#define TRANSFERLOG		"1020311589724880936"
#define DEPOSITLOG		"1020311630556430386"
#define WITHDRAWLOG		"1020311671794847796"
#define SETNAMELOG		"1020311713058390026"
#define HOUSESAFELOG	"1020311758419808278"
#define HOUSEITEMSLOG	"1020311811834265641"
#define GIVEWEAPON_LOG  "1020527721467613214"
// ADMIN LOG
#define SETITEMLOG      "1020524749903900713"
#define SETPLAYERLOG    "1020525413564416093"
#define PMLOG           "1020525914502733884"
#define ADMINWEAP_LOG   "1020527456387604513"

Discord_Log(const channel_id[], const log_text[])
{
	static date[6];

    getdate(date[2], date[1], date[0]);
    gettime(date[3], date[4], date[5]);

	channel_variable = DCC_FindChannelById(channel_id);
	DCC_SendChannelMessage(channel_variable, sprintf("```[%02d:%02d:%d, %02d:%02d]: %s```", date[0], date[1], date[2], date[3], date[4], log_text));
	return 1;
}