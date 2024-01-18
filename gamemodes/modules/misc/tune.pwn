CMD:apaintjob(playerid, params[])
{
    if (CheckAdmin(playerid, 7))
        return PermissionError(playerid);

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 
        return SendErrorMessage(playerid, "You need to be driver to use this command.");

    new modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

    switch (modelid)
    {
        case 483: Dialog_Show(playerid, Paintjob, DIALOG_STYLE_LIST, "Available Paintjobs", "Paintjob ID: 0\nRemove Paintjob", "Select", "Cancel");
        case 575: Dialog_Show(playerid, Paintjob, DIALOG_STYLE_LIST, "Available Paintjobs", "Paintjob ID: 0\nPaintjob ID: 1\nRemove Paintjob", "Select", "Cancel");
        case 534 .. 536, 558 .. 562, 565, 567, 576: Dialog_Show(playerid, Paintjob, DIALOG_STYLE_LIST, "Available Paintjobs", "Paintjob ID: 0\nPaintjob ID: 1\nPaintjob ID: 2\nRemove Paintjob", "Select", "Cancel");
        default: SendErrorMessage(playerid, "This vehicle does not support any paintjob.");
    }
    return 1;
}

CMD:atune(playerid, params[])
{
    if (CheckAdmin(playerid, 7))
        return PermissionError(playerid);

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "You need to be driver to use this command.");
    

    new
        vehicleid = GetPlayerVehicleID(playerid),
        section_list[256]
    ;

    // Mendapatkan list section yang bisa di-mod.
    Vehicle_GetModableSection(vehicleid, section_list);

    if (!Vehicle_HasAnyModableComponent(vehicleid))
    {
        ShowPlayerFooter(playerid, "Kendaraan ini tidak bisa dimodifikasi!");
        return 1;
    }

    Dialog_Show(playerid, AdmTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
    return 1;
}

CMD:colorlist(playerid, params[])
{
    Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, "Available Color List", color_string, "Close", "");
    return 1;
}

Dialog:AdmTune_ChooseComponent(playerid, response, listitem, inputtext[])
{
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        ShowPlayerFooter(playerid, "Anda harus berada di kendaraan sebagai pengemudi untuk memodif!");
        return 1;
    }

    new
		// Mendapatkan ID vehicle yang ingin dimodif.
		vehicleid = GetPlayerVehicleID(playerid),
		// Mendapatkan ID component mod yang dipilih
		componentid = strval(inputtext),
		// Untuk menyimpan section yang bisa di-mod
		section_list[256]
	;

	// Mendapatkan list section yang bisa di-mod.
	Vehicle_GetModableSection(vehicleid, section_list);

	if (!response)
	{
		Dialog_Show(playerid, AdmTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
		return 1;
	}

	if (strlen(inputtext) < 1)
	{
		ShowPlayerFooter(playerid, "Anda belum memilih component!");
		Dialog_Show(playerid, AdmTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
		return 1;
	}

	if (!IsModValid(vehicleid, componentid))
	{
		ShowPlayerFooter(playerid, "Component ini tidak dapat dipasang di kendaraan ini!");
		Dialog_Show(playerid, AdmTune_ChooseSection, DIALOG_STYLE_TABLIST_HEADERS, "Available Sections", section_list, "Select", "Cancel");
		return 1;
	}

    Vehicle_AddComponent(vehicleid, componentid);
    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
    return 1;
}

Dialog:AdmTune_ChooseSection(playerid, response, listitem, inputtext[])
{
    if (!response)
	{
		return 1;
	}

	if (strlen(inputtext) < 1)
	{
		return 1;
	}

	new
		// Mendapatkan ID vehicle yang ingin dimodif.
		vehicleid = GetPlayerVehicleID(playerid),
		// Mendapatkan section mod yang dipilih
		section = strval(inputtext)
	;

	if (!Vehicle_IsModSectionModable(vehicleid, section))
	{
		ShowPlayerFooter(playerid, "Kendaraan ini tidak bisa dimodifikasi!");
		return 1;
	}

	new modable_components[512];
	Vehicle_GetModableComponent(vehicleid, section, false, modable_components);
    Dialog_Show(playerid, AdmTune_ChooseComponent, DIALOG_STYLE_TABLIST_HEADERS, "Available Components", modable_components, "Select", "Cancel");

    return 1;
}

Dialog:Tune(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "You need to be driver to tune a vehicle.");

        new
            modelid = GetVehicleModel(GetPlayerVehicleID(playerid)),
            Query[128]
        ;

        switch (modelid)
        {
            case 534 .. 536, 558 .. 562, 565, 567, 575, 576:
            {
                if (!strcmp(inputtext, "Wheels") || !strcmp(inputtext, "Hydraulics"))
                {
                    mysql_format(g_iHandle, Query, sizeof Query, "SELECT componentid,type FROM vehicle_components WHERE part='%e' ORDER BY type", inputtext);
                    mysql_tquery(g_iHandle, Query, "OnTuneLoad", "ii", playerid, 2);
                }
                else
                {
                    mysql_format(g_iHandle, Query, sizeof Query, "SELECT componentid,type FROM vehicle_components WHERE cars=%i AND part='%e' ORDER BY type", modelid, inputtext);
                    mysql_tquery(g_iHandle, Query, "OnTuneLoad", "ii", playerid, 2);
                }
            }
            default:
            {
                mysql_format(g_iHandle, Query, sizeof Query, "SELECT componentid,type FROM vehicle_components WHERE cars<=0 AND part='%e' ORDER BY type", inputtext);
                mysql_tquery(g_iHandle, Query, "OnTuneLoad", "ii", playerid, 2);
            }
        }
    }
    return 1;
}

Dialog:TuneTwo(playerid, response, listitem, inputtext[])        
{
    if (!response) return cmd_atune(playerid, "");
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "You need to be driver to tune a vehicle.");

    new vehicleid = GetPlayerVehicleID(playerid), componentid;
    
    if (!sscanf(inputtext, "i", componentid)) 
    {
        if(!IsModValid(vehicleid, componentid)) return SendErrorMessage(playerid, "Komponen kendaraan tidak valid, coba komponen yang lain!");
        Vehicle_AddComponent(vehicleid, componentid);
        // sideskirts and vents that have left and right side should be applied twice
        switch (componentid)
        {
            case 1007, 1027, 1030, 1039, 1040, 1051, 1052, 1062, 1063, 1071, 1072, 1094, 1099, 1101, 1102, 1107, 1120, 1121, 1124, 1137, 1142 .. 1145: Vehicle_AddComponent(vehicleid, componentid);
        }
    }
    else return RemoveVehicleComponent(vehicleid, 1087);

    return 1;
}

Dialog:Paintjob(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "You need to be driver to tune a vehicle.");

        new paintjobid;
	
        if (!sscanf(inputtext, "'Paintjob ID:'i", paintjobid)) 
        {
            Vehicle_SetPaintjob(GetPlayerVehicleID(playerid), paintjobid);
        }
        else 
        {
            Vehicle_SetPaintjob(GetPlayerVehicleID(playerid), 3);
        }
    }
    return 1;
}

//-----------------------------------------------------

forward OnTuneLoad(playerid, idx);
public OnTuneLoad(playerid, idx)
{
    static rows, fields;
    switch (idx)
    {
        case 0:
        {
            new dialog_info[79], part_name[14];

            cache_get_data(rows, fields);
            for (new i; i != rows; i++)
            {
                cache_get_value_index(i, 0, part_name);

                strcat(dialog_info, part_name);
                strcat(dialog_info, "\n");
            }
			Dialog_Show(playerid, Tune, DIALOG_STYLE_LIST, "Available Parts", dialog_info, "Select", "Cancle");
        }
        case 1:
        {            
            cache_get_data(rows, fields);		
            if (rows)
            {
                new dialog_info[80], part_name[13];
                //static rows, fields;
 
                for (new i; i != rows; i++)
                {
                    cache_get_value_index(i, 0, part_name);

                    if (!isnull(part_name))
                    {
                        strcat(dialog_info, part_name);
                        strcat(dialog_info, "\n");
                    }
                }
				
                Dialog_Show(playerid, Tune, DIALOG_STYLE_LIST, "Available Parts", dialog_info, "Select", "Cancle");
            }
            else SendErrorMessage(playerid, "You cannot tune this vehicle.");
        }
        case 2:
        {
            static dialog_info[716];
            new componentid, type[32];

            dialog_info = "{FF0000}Component ID\t{FF8000}Type\n";
	        cache_get_data(rows, fields);
            for (new i; i != rows; i++)
            {
                componentid = cache_get_row_int(i, 0);
                cache_get_value_index(i, 1, type);
                
                format(dialog_info, sizeof dialog_info, "%s%i\t%s\n", dialog_info, componentid, type);
            }
	        
            if (componentid == 1087) strcat(dialog_info, " ----\tRemove Hydraulics");
            
            Dialog_Show(playerid, TuneTwo, DIALOG_STYLE_TABLIST_HEADERS, "Available Parts", dialog_info, "Install", "Back");
        }
    }
}
