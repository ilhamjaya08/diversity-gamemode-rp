#include <YSI\y_hooks>

new listening_boombox[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};

new listening_channel[][][128] = {
    {"Delta FM", "http://202.137.23.69:9300/djkt"},
    {"BBC Radio 1", "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1_mf_p"},
    {"BBC Radio 6", "http://bbcmedia.ic.llnwd.net/stream/bbcmedia_6music_mf_p"},
    {"Prambors FM", "http://masima.rastream.com/masima-pramborsjakarta?"},
    {"Female Radio", "http://masima.rastream.com/masima-femaleradio"},
    {"Virgin Radio", "http://playerservices.streamtheworld.com/api/livestream-redirect/VIRGINRAD_SC"},
    {"Hard Rock FM", "http://cloudstreaming.mramedia.com:8012/live"}
};

enum E_BOOMBOX_DATA 
{
    boomboxPlaced,
 
    Float:boomboxPos[3],
    boomboxInterior,
    boomboxWorld,
    boomboxURL[128 char],

    // property
    boomboxObject,
    Text3D:boomboxText3D
};

new BoomboxData[MAX_PLAYERS][E_BOOMBOX_DATA];


// Events
hook OnPlayerDisconnect(playerid, reason)
{
	Boombox_Destroy(playerid);
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
        if(listening_boombox[playerid] != INVALID_PLAYER_ID)
        {
            listening_boombox[playerid] = INVALID_PLAYER_ID;
            StopAudioStreamForPlayer(playerid);
        }
    }
}
SameBoomboxIntVW(playerid, boomboxid)
{
    new 
        vw = GetPlayerVirtualWorld(playerid),
        int = GetPlayerInterior(playerid)
    ;

    if(BoomboxData[boomboxid][boomboxInterior] == int && BoomboxData[boomboxid][boomboxWorld] == vw)
        return 1;

    return 0;
}
ptask Player_BoomboxUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
		
	new 
		boombox_id;

	if((boombox_id = Boombox_Nearest(playerid)) != INVALID_PLAYER_ID && listening_boombox[playerid] != boombox_id && strlen(BoomboxData[boombox_id][boomboxURL]) && SameBoomboxIntVW(playerid, boombox_id) && !IsPlayerInAnyVehicle(playerid) && !ListenToMusic(playerid))
    {
        new str[128];
        strunpack(str, BoomboxData[boombox_id][boomboxURL]);
        listening_boombox[playerid] = boombox_id;

        StopAudioStreamForPlayer(playerid);
        PlayAudioStreamForPlayer(playerid, str, BoomboxData[boombox_id][boomboxPos][0], BoomboxData[boombox_id][boomboxPos][1], BoomboxData[boombox_id][boomboxPos][2], 30.0, 1);

    }
    else if(listening_boombox[playerid] != INVALID_PLAYER_ID && !IsPlayerInRangeOfPoint(playerid, 30.0, BoomboxData[listening_boombox[playerid]][boomboxPos][0], BoomboxData[listening_boombox[playerid]][boomboxPos][1], BoomboxData[listening_boombox[playerid]][boomboxPos][2]))
    {
        if(ListenToMusic(playerid) || !SameBoomboxIntVW(playerid, listening_boombox[playerid]))
        { 
            listening_boombox[playerid] = INVALID_PLAYER_ID;
            StopAudioStreamForPlayer(playerid);
        }
        listening_boombox[playerid] = INVALID_PLAYER_ID;
        StopAudioStreamForPlayer(playerid);
    }
    return 1;
}


// Function
Boombox_Place(playerid)
{
    new Float:angle, string[255];

    GetPlayerFacingAngle(playerid, angle);

    strpack(BoomboxData[playerid][boomboxURL], "", 128 char);
    GetPlayerPos(playerid, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]);

    BoomboxData[playerid][boomboxPlaced] = true;
    BoomboxData[playerid][boomboxInterior] = GetPlayerInterior(playerid);
    BoomboxData[playerid][boomboxWorld] = GetPlayerVirtualWorld(playerid);

    if(BoomboxData[playerid][boomboxObject] != INVALID_STREAMER_ID)
		DestroyDynamicObject(BoomboxData[playerid][boomboxObject]);

	if(BoomboxData[playerid][boomboxText3D] != Text3D:INVALID_STREAMER_ID)
		DestroyDynamic3DTextLabel(BoomboxData[playerid][boomboxText3D]);

    BoomboxData[playerid][boomboxObject] = CreateDynamicObject(2226, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.9, 0.0, 0.0, angle, BoomboxData[playerid][boomboxWorld], BoomboxData[playerid][boomboxInterior]);

    format(string, sizeof(string), "[ID: %d]\n[Boombox]\n"WHITE"/boombox untuk perintah boombox.", PlayerData[playerid][pID]);
    BoomboxData[playerid][boomboxText3D] = CreateDynamic3DTextLabel(string, COLOR_CLIENT, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BoomboxData[playerid][boomboxWorld], BoomboxData[playerid][boomboxInterior]);
    return 1;
}

Boombox_Destroy(playerid)
{
    if(BoomboxData[playerid][boomboxPlaced])
    {
        if(BoomboxData[playerid][boomboxObject] != INVALID_STREAMER_ID)
    		DestroyDynamicObject(BoomboxData[playerid][boomboxObject]);

    	if(BoomboxData[playerid][boomboxText3D] != Text3D:INVALID_STREAMER_ID)
    		DestroyDynamic3DTextLabel(BoomboxData[playerid][boomboxText3D]);

        foreach (new i : Player) if(listening_boombox[i] == playerid) {
        	listening_boombox[i] = INVALID_PLAYER_ID;
            StopAudioStreamForPlayer(i);
        }

        BoomboxData[playerid][boomboxPlaced] = false;
        BoomboxData[playerid][boomboxInterior] = 0;
        BoomboxData[playerid][boomboxWorld] = 0;

        BoomboxData[playerid][boomboxObject] = INVALID_STREAMER_ID;
        BoomboxData[playerid][boomboxText3D] = Text3D:INVALID_STREAMER_ID;
    }
    return 1;
}

Boombox_Nearest(playerid)
{
    foreach (new i : Player) if(BoomboxData[i][boomboxPlaced] && GetPlayerInterior(playerid) == BoomboxData[i][boomboxInterior] && GetPlayerVirtualWorld(playerid) == BoomboxData[i][boomboxWorld] && IsPlayerInRangeOfPoint(playerid, 30.0, BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2])) {
        return i;
    }
    return INVALID_PLAYER_ID;
}

Boombox_SetURL(playerid, url[])
{
    if(BoomboxData[playerid][boomboxPlaced])
    {
        strpack(BoomboxData[playerid][boomboxURL], url, 128 char);

        foreach (new i : Player) if(listening_boombox[i] == playerid) {
            StopAudioStreamForPlayer(i);
            PlayAudioStreamForPlayer(i, url, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2], 30.0, 1);
        }
    }
    return 1;
}


// Commands
CMD:boombox(playerid, params[])
{
    new type[24], string[128];

    if(!IsPlayerVIP(playerid))
        return SendErrorMessage(playerid, "Hanya member donatur yang dapat menggunakan perintah ini!");

    if(sscanf(params, "s[24]S()[128]", type, string))
    {
        SendSyntaxMessage(playerid, "/boombox [menu]");
        SendClientMessage(playerid, X11_YELLOW_2, "[MENUS]:"WHITE" place, pickup, url, channel");
        return 1;
    }

    if(!strcmp(type, "place", true))
    {
        if(IsPlayerInAnyVehicle(playerid))
            return SendErrorMessage(playerid, "Kaluar dari kendaraan terlebih dahulu.");

        if(BoomboxData[playerid][boomboxPlaced])
            return SendErrorMessage(playerid, "Kamu sudah meletakkan boombox sebelumnya.");

        if(Boombox_Nearest(playerid) != INVALID_PLAYER_ID)
            return SendErrorMessage(playerid, "Kamu berada berdekatan dengan boombox orang lain.");

        Boombox_Place(playerid);
    	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
        SendServerMessage(playerid, "Kamu telah meletakkan boombox, gunakan perintah /boombox untuk perintah lainnya.");
    }
    else if(!strcmp(type, "pickup", true))
    {
        if(!BoomboxData[playerid][boomboxPlaced])
            return SendErrorMessage(playerid, "Kamu tidak meletakkan boombox sebelumnya.");

        if(!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
            return SendErrorMessage(playerid, "Kamu tidak berada dekat dengan boombox milikmu.");

        Boombox_Destroy(playerid);
    	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
    }
    else if(!strcmp(type, "url", true))
    {
        if(sscanf(string, "s[128]", string))
            return SendSyntaxMessage(playerid, "/boombox url <url lagu>");

        if(!BoomboxData[playerid][boomboxPlaced])
            return SendErrorMessage(playerid, "Letakkan boombox terlebih dahulu (/boombox place).");

        if(!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
            return SendErrorMessage(playerid, "Kamu tidak berada dekat dengan boombox milikmu.");

        Boombox_SetURL(playerid, string);
        SendServerMessage(playerid, "Kamu telah mengaktifkan musik pada boombox, jika tidak bersuara coba dengan url lain.");
    }
    else if(!strcmp(type, "channel", true))
    {
        if(!BoomboxData[playerid][boomboxPlaced])
            return SendErrorMessage(playerid, "Letakkan boombox terlebih dahulu (/boombox place).");

        if(!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
            return SendErrorMessage(playerid, "Kamu tidak berada dekat dengan boombox milikmu.");

        new boombox_channel[128];

        for(new i = 0; i < sizeof(listening_channel); i++) {
            strcat(boombox_channel, sprintf("%s\n", listening_channel[i][0]));
        }
        Dialog_Show(playerid, BoomboxChannel, DIALOG_STYLE_LIST, "Boombox Channel", boombox_channel, "Play", "Cancel");        
    }
    return 1;
}

CMD:destroyboombox(playerid, params[])
{
    if (CheckAdmin(playerid, 3))
        return PermissionError(playerid);

    foreach (new i : Player) if(BoomboxData[i][boomboxPlaced] && IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2])) {
        Boombox_Destroy(i);

        SendServerMessage(playerid, "Boombox milik %s telah dihapus", ReturnName(i, 0));
        return SendServerMessage(i, "%s telah menghapus boombox yang kamu letakkan.", ReturnName(playerid, 0));
    }
    SendErrorMessage(playerid, "Kamu tidak berada dekat dengan boombox orang lain.");
    return 1;
}


// Dialog response
Dialog:BoomboxChannel(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        Boombox_SetURL(playerid, listening_channel[listitem][1]);
        SendServerMessage(playerid, "Kamu telah mengaktifkan channel "CYAN"%s "WHITE"pada boombox, jika tidak bersuara coba dengan channel lainnya.", inputtext);
    }
    return 1;
}