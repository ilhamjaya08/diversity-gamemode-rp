#include <YSI\y_hooks>

new report_posted[MAX_PLAYERS] = {false, ...},
	report_time[MAX_PLAYERS] = {0, ...},
	report_message[MAX_PLAYERS][80];

new ask_posted[MAX_PLAYERS] = {false, ...},
	ask_time[MAX_PLAYERS] = {0, ...},
	ask_message[MAX_PLAYERS][128];


ptask Player_ResetAsk[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	if(report_posted{playerid} && report_time[playerid] < gettime())
	{
		Report_Reset(playerid);
		SendServerMessage(playerid, "Laporanmu tidak diproses, kamu dapat menggunakan perintah '"YELLOW"/report"WHITE"' lagi.");
	}

	if(ask_posted{playerid} && ask_time[playerid] < gettime())
	{
		Ask_Reset(playerid);
		SendServerMessage(playerid, "Pertanyaan tidak diproses, kamu dapat menggunakan perintah '"YELLOW"/ask"WHITE"' lagi.");
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(report_posted{playerid})
		Report_Reset(playerid);

	if(ask_posted{playerid})
		Ask_Reset(playerid);
}

Report_Reset(playerid)
{
	report_time[playerid] = 0;
	report_posted{playerid} = false;
	report_message[playerid][0] = EOS;
	return 1;
}

Ask_Reset(playerid)
{
	ask_time[playerid] = 0;
	ask_posted{playerid} = false;
	ask_message[playerid][0] = EOS;
	return 1;
}