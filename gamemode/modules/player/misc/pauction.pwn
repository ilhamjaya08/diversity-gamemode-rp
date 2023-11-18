IsPlayerInAuctionRoom(playerid)
{
    new
        id = -1;

    if((id = Entrance_Inside(playerid)) != -1 && EntranceData[id][entranceType] == 11)
        return 1;

    return 0;
}
pAuction_Reset()
{
    foreach(new id : Player) if(GetPVarInt(id, "IkutLelang") == 1)
    {
        SetPVarInt(id, "IkutLelang", 0);
    }

    SetGVarInt("AuctionType", 0, GLOBAL_VARTYPE_INT);
    SetGVarInt("AuctionCount", 0, GLOBAL_VARTYPE_INT);
    SetGVarInt("AuctionStart", 0, GLOBAL_VARTYPE_INT);
    SetGVarInt("AuctionDiff", 0, GLOBAL_VARTYPE_INT);
    SetGVarString("AuctionLelang", "none", GLOBAL_VARTYPE_STRING);
    SetGVarString("AuctionHighest", "none", GLOBAL_VARTYPE_STRING);
    KillTimer(Auction);
    return 1;
}

Function:PAuctionTime()
{
    new text[255], property[128],name[MAX_PLAYER_NAME];
    GetGVarString("AuctionLelang", property, sizeof(property), GLOBAL_VARTYPE_STRING);
    GetGVarString("AuctionHighest", name, sizeof(name), GLOBAL_VARTYPE_STRING);

    switch(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT))
    {
        case 1:
        {
            SetGVarInt("PAuctionTime", GetGVarInt("PAuctionTime", GLOBAL_VARTYPE_INT)-1, GLOBAL_VARTYPE_INT);
            format(text,sizeof(text),"{00FFFF}%s\n"COL_GREEN"Start: "WHITE"%s\n"COL_GREEN"Diff: "WHITE"%s\n"COL_GREEN"Participants: "WHITE"%d\nStart in: %d", property, FormatNumber(GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT)), FormatNumber(GetGVarInt("AuctionDiff", GLOBAL_VARTYPE_INT)), GetGVarInt("AuctionCount", GLOBAL_VARTYPE_INT), GetGVarInt("PAuctionTime", GLOBAL_VARTYPE_INT));

            if(GetGVarInt("PAuctionTime", GLOBAL_VARTYPE_INT) == 0)
            {
                if(!GetGVarInt("AuctionCount", GLOBAL_VARTYPE_INT))
                {
                    SetDynamicObjectMaterialText(playerauction, 0, "No one join this auction.", 130, "Ariel", 27, 1, -1, -16777216, 1);
                    Auction_Reset();
                }
                else
                {
                    SetGVarInt("AuctionType", 2, GLOBAL_VARTYPE_INT);
                    SetGVarInt("PAuctionTime", 10, GLOBAL_VARTYPE_INT);
                }
            }
        }
        case 2:
        {
            SetGVarInt("PAuctionTime", GetGVarInt("PAuctionTime", GLOBAL_VARTYPE_INT)-1, GLOBAL_VARTYPE_INT);
            format(text,sizeof(text),"{00FFFF}%s\n"COL_GREEN"Highest bidder: "WHITE"%s\n"COL_GREEN"Offer: "WHITE"%s\nCountdown: %d", property, name, FormatNumber(GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT)), GetGVarInt("PAuctionTime", GLOBAL_VARTYPE_INT));

            if(GetGVarInt("PAuctionTime", GLOBAL_VARTYPE_INT) == 0)
            {
                format(text,sizeof(text),"{00FFFF}%s\n"WHITE"%s - "COL_GREEN"%s", property, name, FormatNumber(GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT)));

                foreach(new id : Player) if(IsPlayerInAuctionRoom(id))
                {
                    SetPVarInt(id, "IkutLelang", 0);
                    SendClientMessageEx(id, X11_TURQUOISE_1, "AUCTION: "WHITE"%s: %s - "COL_GREEN"%s.", property, name, FormatNumber(GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT)));

                    if(!strcmp(name,ReturnName(id), true))
                    {
                        SendClientMessageEx(id, X11_TURQUOISE_1, "AUCTION: "WHITE"Anda telah memenangkan %s - "COL_GREEN"%s", property,FormatNumber(GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT)));
                        GiveMoney(id, -GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT), ECONOMY_ADD_SUPPLY, "won auction");
                    }
                }
                for(new i = 0; i != MAX_FACTIONS; i++) if(FactionData[i][factionExists] && FactionData[i][factionType] == FACTION_GOV) {
                        FactionData[i][factionMoney] += GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT);
                }

                Auction_Reset();
            }
        }
    }
    SetDynamicObjectMaterialText(playerauction, 0, text, 130, "Ariel", 27, 1, -1, -16777216, 1);
    return 1;
}

CMD:pauction(playerid, params[])
{
    new option[32], string[128], property[128];

    if(!IsPlayerInAuctionRoom(playerid))
        return SendErrorMessage(playerid, "You're not in auction rooms.");

    if(sscanf(params, "s[32]S()[128]", option, string))
        return SendSyntaxMessage(playerid, "/pauction [create/join/bid/cancel]");

    if(!strcmp(option,"create", true))
    {
        new lelang[128], start, bid;

        if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) != 0)
            return SendErrorMessage(playerid, "Auction sedang berjalan, /pauction cancel tuntuk menunda.");

        if(sscanf(string, "dds[128]", start, bid, lelang))
            return SendSyntaxMessage(playerid, "/pauction create [start money] [diff] [property name]");

        if(start < 0)
            return SendErrorMessage(playerid, "Jangan memasukkan uang awal di bawah 0.");

        if(bid < 0)
        return SendErrorMessage(playerid, "Jangan memasukkan jumlah diff di bawah 0.");

        SetGVarInt("AuctionType", 1, GLOBAL_VARTYPE_INT);
        SetGVarInt("PAuctionTime", 15, GLOBAL_VARTYPE_INT);
        SetGVarInt("AuctionCount", 0, GLOBAL_VARTYPE_INT);
        SetGVarInt("AuctionStart", start, GLOBAL_VARTYPE_INT);
        SetGVarInt("AuctionDiff", bid, GLOBAL_VARTYPE_INT);
        SetGVarString("AuctionLelang", lelang, GLOBAL_VARTYPE_STRING);
        SetGVarString("AuctionHighest", "none", GLOBAL_VARTYPE_STRING);

        foreach(new id : Player) if(IsPlayerInAuctionRoom(id))
        {
            SendClientMessageEx(id, X11_TURQUOISE_1, "AUCTION: "YELLOW"Item: "WHITE"%s | "YELLOW"Start price: "COL_GREEN"%s | "YELLOW"Diff: "COL_GREEN"%s", lelang, FormatNumber(start), FormatNumber(bid));
            SendClientMessageEx(id, X11_TURQUOISE_1, "AUCTION: "WHITE"Use command "YELLOW"'/pauction join' "WHITE"to join auction.");
        }
        Auction = SetTimer("PAuctionTime", 1000, true);
        new text[255];
        format(text,sizeof(text),"{00FFFF}%s\n"COL_GREEN"Start: "WHITE"%s\n"COL_GREEN"Diff: "WHITE"%s\n"COL_GREEN"Participants: "WHITE"%d\nSeart in: %d", lelang, FormatNumber(start), FormatNumber(bid), GetGVarInt("AuctionCount", GLOBAL_VARTYPE_INT), GetGVarInt("PAuctionTime", GLOBAL_VARTYPE_INT));
        SetDynamicObjectMaterialText(playerauction, 0, text, 130, "Ariel", 27, 1, -1, -16777216, 1);

        SendAdminMessage(X11_TOMATO_1, "AdmWarn: %s start the auction, start: [%s] diff: [%s]", ReturnName(playerid, 0), FormatNumber(start), FormatNumber(bid));
    }
    else if(!strcmp(option, "join", true))
    {
        if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) != 1) return SendErrorMessage(playerid, "Auction belum di mulai.");
        if(GetPVarInt(playerid, "IkutLelang")) return SendErrorMessage(playerid, "Anda sedang mengikuti auction ini.!");
        if(GetMoney(playerid) < 100) return SendErrorMessage(playerid, "Anda tidak memiliki modal uang $100 untuk mengikuti auction ini.");

        GetGVarString("AuctionLelang", property, sizeof(property), GLOBAL_VARTYPE_STRING);

        GiveMoney(playerid, -100, ECONOMY_ADD_SUPPLY, "enter auction");
        SendClientMessageEx(playerid, X11_TURQUOISE_1, "AUCTION: "WHITE"Gunakan perintah "YELLOW"'/pauction bid' "WHITE"untuk memenangkan auction.");

        for(new i = 0; i != MAX_FACTIONS; i++) if(FactionData[i][factionExists] && FactionData[i][factionType] == FACTION_GOV) {
            FactionData[i][factionMoney] += 5;
        }
        SetPVarInt(playerid, "IkutLelang", 1);
        SetGVarInt("AuctionCount", GetGVarInt("AuctionCount", GLOBAL_VARTYPE_INT)+1, GLOBAL_VARTYPE_INT);

    }
    else if(!strcmp(option, "bid", true))
    {
        new money = (GetGVarInt("AuctionStart", GLOBAL_VARTYPE_INT)+GetGVarInt("AuctionDiff", GLOBAL_VARTYPE_INT)),
            name[MAX_PLAYER_NAME];

        GetGVarString("AuctionHighest", name, sizeof(name), GLOBAL_VARTYPE_STRING);

        if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) == 1)
        return SendErrorMessage(playerid, "Auction belum di mulai.");

        if(!strcmp(name, ReturnName(playerid), true))
        return SendErrorMessage(playerid, "Anda masih berada di peringkat teratas auction ini!.");

        if(!GetPVarInt(playerid, "IkutLelang"))
        return SendErrorMessage(playerid, "Anda tidak mengikuti auction ini.");

        if(GetMoney(playerid) < money)
        return SendErrorMessage(playerid, "Anda tidak memiliki uang sebesar %s untuk mengikuti auction ini.", FormatNumber(money));

        SetGVarInt("AuctionStart", money, GLOBAL_VARTYPE_INT);
        SetGVarString("AuctionHighest", ReturnName(playerid), GLOBAL_VARTYPE_STRING);
        SetGVarInt("PAuctionTime", 10, GLOBAL_VARTYPE_INT);
    }
    else if(!strcmp(option, "cancel", true))
    {
        if (CheckAdmin(playerid, 6))
            return PermissionError(playerid);
        if(GetGVarInt("AuctionType", GLOBAL_VARTYPE_INT) == 0)
        return SendErrorMessage(playerid, "Auction sedang tidak berlangsung!.");

        foreach(new id : Player) if(IsPlayerInAuctionRoom(id))
        {
            SendClientMessageEx(id, X11_TURQUOISE_1, "AUCTION: "YELLOW"%s "WHITE"menunda auction.", ReturnName(playerid));
        }
        pAuction_Reset();
        SetDynamicObjectMaterialText(playerauction, 0, "Auction di tunda.", 130, "Ariel", 27, 1, -1, -16777216, 1);
    }
    else
        SendSyntaxMessage(playerid, "/pauction [create/join/bid/cancel]");

    return 1;
}