#define MAX_PLAYER_TICKET  20


enum E_TICKET
{
    ticketFine,
    ticketReason[128]
};


new playerTicket[MAX_PLAYERS][MAX_PLAYER_TICKET][E_TICKET],
	listedTicket[MAX_PLAYERS][MAX_PLAYER_TICKET];



CMD:addticket(playerid, params[])
{
	new userid, denda, alasan[128];

	if(sscanf(params, "uds[128]", userid, denda, alasan))
		return SendClientMessage(playerid, -1, "/addticket [playerid] [denda] [alasan]");

	if(denda < 0)
		return SendClientMessage(playerid, -1, "Denda harus di atas $0.");

	for(new i = 0; i != MAX_PLAYER_TICKET; i++) if(!playerTicket[userid][i][ticketFine]) {
		playerTicket[userid][i][ticketFine] = denda;
		format(playerTicket[userid][i][ticketReason], 128, alasan);

		SendClientMessage(playerid, -1, "Sukses memberi ticket");
		return 1;
	}
	SendClientMessage(playerid, -1, "Player tersebut memiliki hutang yang banyak.");
	return 1;
}



CMD:viewticket(playerid, params[])
{
    new 
        count = 0,
    	ticket_dialog[64 * MAX_PLAYER_TICKET]
    ;

    format(ticket_dialog, sizeof(ticket_dialog), "Number\tReason\tFine\n");

    for(new i = 0; i != MAX_PLAYER_TICKET; i++) if(playerTicket[playerid][i][ticketFine]) {
        format(ticket_dialog, sizeof(ticket_dialog), "%s#%d\t%s\t"GREEN"$%d"WHITE"\n", ticket_dialog, count, playerTicket[playerid][i][ticketReason],playerTicket[playerid][i][ticketFine]);

        listedTicket[playerid][count++] = i;
    }

    if(count) Dialog_Show(playerid, TicketList, DIALOG_STYLE_TABLIST_HEADERS, "My Tickets", ticket_dialog, "Check", "Close");
    else SendServerMessage(playerid, "You don't have active ticket.");
    return 1;
}


Dialog:TicketList(playerid, response, listitem, inputtext[])
{
	if(response) {
		new 
			id = listedTicket[playerid][listitem]
		;
	    SendClientMessageEx(playerid, X11_WHITE, "List ID: "YELLOW"%d", id);
	    SendClientMessageEx(playerid, X11_WHITE, "Fine   : "GREEN"%s", FormatNumber(playerTicket[playerid][id][ticketFine]));
	    SendClientMessageEx(playerid, X11_WHITE, "Reason : "YELLOW"%s", FormatNumber(playerTicket[playerid][id][ticketReason]));	    
	}
	return 1;
}