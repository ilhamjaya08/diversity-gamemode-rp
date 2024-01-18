new DCC_Channel:channel_variable;

#define PAYLOGLOG		"726682546049384489"
#define TRANSFERLOG		"726682579268403221"
#define DEPOSITLOG		"726682626991194152"
#define WITHDRAWLOG		"726682716057108560"
#define SETNAMELOG		"726715085703086120"
#define HOUSESAFELOG	"726702773860696117"
#define HOUSEITEMSLOG	"726704484901716020"

Discord_Log(const channel_id[], const log_text[])
{
	static date[6];

    getdate(date[2], date[1], date[0]);
    gettime(date[3], date[4], date[5]);

	channel_variable = DCC_FindChannelById(channel_id);
	DCC_SendChannelMessage(channel_variable, sprintf("```[%02d:%02d:%d, %02d:%02d]: %s```", date[0], date[1], date[2], date[3], date[4], log_text));
	return 1;
}