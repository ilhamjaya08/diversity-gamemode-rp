SSCANF:LumberMenu(string[]) 
{
    if(!strcmp(string,"create",true)) return 1;
    else if(!strcmp(string,"delete",true)) return 2;
    else if(!strcmp(string,"position",true)) return 3;
    else if(!strcmp(string,"time",true)) return 4;
    return 0;
}

CMD:lm(playerid, params[])
    return cmd_lumbermenu(playerid, params);

CMD:lumbermenu(playerid, params[])
{
    if (CheckAdmin(playerid, 8))
        return PermissionError(playerid);

    new
        lumber_id, action, nextParams[128]
    ;

    if(sscanf(params, "k<LumberMenu>S()[128]", action, nextParams))
        return SendSyntaxMessage(playerid, "/lumbermenu [create/delete/position/time]");

    switch(action)
    {
        case 1: // Create
        {
            new Float:x, Float:y, Float:z;

            GetXYInFrontOfPlayer(playerid, x, y, 2.0);
            GetPlayerPos(playerid, z, z, z);

            if((lumber_id = Lumber_Create(x, y, z)) != INVALID_ITERATOR_SLOT) {
                return SendServerMessage(playerid, "Sukses membuat lumber dengan id: %d", lumber_id);
            }
            SendErrorMessage(playerid, "Slot lumber sudah mencapai batas maksimal (%d lumber), hubungi scripter segera!.", MAX_DYNAMIC_LUMBER);
        }
        case 2: // Delete
        {
            if(sscanf(nextParams, "d", lumber_id))
                return SendSyntaxMessage(playerid, "/lumbermenu delete <lumber id>");

            if(!Lumber_Exists(lumber_id))
                return SendErrorMessage(playerid, "Id lumber tidak terdaftar diserver.");

            if(Lumber_Delete(lumber_id)) {
                SendServerMessage(playerid, "Lumber id "YELLOW"%d "WHITE"telah dihapus dari server!", lumber_id);
                return 1;
            }
            SendErrorMessage(playerid, "Id lumber tidak terdaftar diserver.", lumber_id);
        }
        case 3: // Position
        {
            if(sscanf(nextParams, "d", lumber_id))
                return SendSyntaxMessage(playerid, "/lumbermenu position <lumber id>");

            if(!Lumber_Exists(lumber_id))
                return SendErrorMessage(playerid, "Id lumber tidak terdaftar diserver.");

            new Float:x, Float:y, Float:z;

            GetXYInFrontOfPlayer(playerid, x, y, 2.0);
            GetPlayerPos(playerid, z, z, z);

            Lumber_SetPosition(lumber_id, x, y, z);
            Lumber_Sync(lumber_id);
            Lumber_Save(lumber_id, SAVE_LUMBER_POS);
            SendServerMessage(playerid, "Posisi lumber id "YELLOW"%d"WHITE" telah diperbaharui!", lumber_id);
        }
        case 4: // Time
        {
            new time;

            if(sscanf(nextParams, "dd", lumber_id, time))
                return SendSyntaxMessage(playerid, "/lumbermenu time <lumber id> <time>");

            if(!Lumber_Exists(lumber_id))
                return SendErrorMessage(playerid, "Id lumber tidak terdaftar diserver.");

            if(time < 0)
                return SendErrorMessage(playerid, "Masukkan angka lebih dari nol!.");

            Lumber_SetTime(lumber_id, time);
            Lumber_Sync(lumber_id);
            Lumber_Save(lumber_id, SAVE_LUMBER_TIME);

            SendServerMessage(playerid, "Waktu spawn lumber id "YELLOW"%d"WHITE" telah diperbaharui menjadi "GREEN"%d detik!", lumber_id, time);
        }
        default: SendSyntaxMessage(playerid, "/lumbermenu [create/delete/position/time]");
    }
    return 1;
}


// Job commands
CMD:loadtree(playerid, params[])
{
    if(GetPlayerJob(playerid) != JOB_LUMBERJACK)
        return SendErrorMessage(playerid, "Kamu tidak seorang lumberjack.");

    new lumber_id, vehicleid, vehicle_index, kapasitas;

    if((lumber_id = Lumber_Nearest(playerid, 3.0)) != -1)
    {
        if(!LumberData[lumber_id][lumberCut])
            return SendErrorMessage(playerid, "Tebang terlebih dahulu pohon yang akan diangkut.");

        if((vehicleid = Vehicle_Nearest(playerid, 5.0)) != -1)
        {
            if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
            {
                if(GetVehicleModel(vehicleid) != 543 && GetVehicleModel(vehicleid) != 554 && GetVehicleModel(vehicleid) != 422) 
                    return SendErrorMessage(playerid, "Ini bukan kendaraan pickup (Bobcat, Sadler, Yosemite).");

                if(!GetTrunkStatus(vehicleid))
                    return SendErrorMessage(playerid, "Buka terlebih penutup bagasi pickup.");

                new level = GetLumberLevel(playerid);
                switch(level)
                {
                    case 1:
                    {
                        switch(GetVehicleModel(vehicleid))
                        {
                            case 543: kapasitas = 3;
                            case 422: kapasitas = 3;
                            case 600: kapasitas = 4;
                            case 554: kapasitas = 5;
                        }
                    }
                    case 2:
                    {
                        switch(GetVehicleModel(vehicleid))
                        {
                            case 543: kapasitas = 6;
                            case 422: kapasitas = 6;
                            case 600: kapasitas = 8;
                            case 554: kapasitas = 10;
                        }
                    }
                    case 3:
                    {
                        switch(GetVehicleModel(vehicleid))
                        {
                            case 543: kapasitas = 10;
                            case 422: kapasitas = 10;
                            case 600: kapasitas = 13;
                            case 554: kapasitas = 15;
                        }
                    }
                    default:
                    {
                       switch(GetVehicleModel(vehicleid))
                        {
                            case 543: kapasitas = 15;
                            case 422: kapasitas = 15;
                            case 600: kapasitas = 20;
                            case 554: kapasitas = 25;
                        } 
                    }
                }
                

                if(VehicleData[vehicle_index][vehLumber] >= kapasitas)
                    return SendErrorMessage(playerid, "Kapasitas penyimpanan untuk mobil %s hanya menampung %d pohon.", GetVehicleNameByVehicle(vehicleid), kapasitas);

                VehicleData[vehicle_index][vehLumber]++;
                Vehicle_ExecuteInt(vehicle_index, "lumber", VehicleData[vehicle_index][vehLumber]);

                LumberData[lumber_id][lumberCut]   = 0;
                LumberData[lumber_id][lumberTime]  = 3600;

                Lumber_Sync(lumber_id);
                Lumber_Save(lumber_id, SAVE_LUMBER_TIME);
                Lumber_Save(lumber_id, SAVE_LUMBER_CUTTING);
                SetLumberSkill(playerid, 1.0);

                SendServerMessage(playerid, "Sukses meletakkan kayu ke bak mobil %s "YELLOW"(%d/%d).", GetVehicleNameByVehicle(vehicleid), VehicleData[vehicle_index][vehLumber], kapasitas);
                ApplyAnimation(playerid, "CARRY", "putdwn105", 4.1, 0, 0, 0, 0, 0, 1);
            }
            else SendErrorMessage(playerid, "Tidak bisa memuat dikendaraan ini!");
        }
        else SendErrorMessage(playerid, "Tidak ada kendaraan jarak 5 meter didekatmu!.");
    }
    else SendErrorMessage(playerid, "Kamu tidak berada 3 meter didekat pohon.");
    return 1;
}

CMD:unloadtree(playerid, params[])
{
    new id, vehicleid, total;

    if((id = Job_NearestPoint(playerid)) != -1 && JobData[id][jobType] == JOB_LUMBERJACK)
    {
        if(PlayerData[playerid][pLumberDelay] > 0 && GetPlayerVIPLevel(playerid) < 3) 
            return SendErrorMessage(playerid, "Kamu memiliki waktu jeda "YELLOW"%d "WHITE"menit untuk menjual pohon kembali.", (PlayerData[playerid][pLumberDelay]/60));

        if(PlayerData[playerid][pJob] != JOB_LUMBERJACK) 
            return SendErrorMessage(playerid, "Anda bukan pekerja lumberjack.");

        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
            return SendErrorMessage(playerid, "Kamudikan kendaraan untuk menggunakan perintah ini.");

        if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 543 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 554 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 422) 
            return SendErrorMessage(playerid, "Ini bukan kendaraan pickup (Bobcat, Sadler, Yosemite).");

        if(!GetTrunkStatus(GetPlayerVehicleID(playerid))) 
            return SendErrorMessage(playerid, "Buka terlebih dahulu penutup pickup.");

        if((vehicleid = Vehicle_ReturnID(GetPlayerVehicleID(playerid))) != RETURN_INVALID_VEHICLE_ID)
        {
            if(!VehicleData[vehicleid][vehLumber]) 
                return SendErrorMessage(playerid, "Pickup tidak memuat pohon!.");

            if(JobData[id][jobStock] >= 15000) 
                return SendErrorMessage(playerid, "Stock gudang penuh, tidak dapat menjual pohon sementara waktu.");

            PlayerData[playerid][pLumberDelay] = 900; 
            total = VehicleData[vehicleid][vehLumber] * 500;
            AddPlayerSalary(playerid, total, "Lumberjack");

            SendServerMessage(playerid, "Sukses menjual "YELLOW"%d "WHITE"pohon dengan mendapat upah "GREEN"%s.", VehicleData[vehicleid][vehLumber], FormatNumber((VehicleData[vehicleid][vehLumber] * 100)));
            
            JobData[id][jobStock] += (VehicleData[vehicleid][vehLumber]*100);

            if(JobData[id][jobStock] > 15000)
                JobData[id][jobStock] = 15000;

            Job_Refresh(id);

            VehicleData[vehicleid][vehLumber] = 0;
            Vehicle_ExecuteInt(vehicleid, "lumber", 0);
        }
        else SendErrorMessage(playerid, "Tidak bisa menjual menggunakan kendaraan ini!");
    }
    else SendErrorMessage(playerid, "Kamu tidak berada di lumberjack point.");

    return 1;
}

CMD:buychainsaw(playerid, params[])
{
    if(IsPlayerDuty(playerid))
        return SendErrorMessage(playerid, "You're on duty faction.");

    new id;

    if((id = Job_NearestPoint(playerid)) != -1 && JobData[id][jobType] == JOB_LUMBERJACK) 
    {   
        if(PlayerData[playerid][pJob] != JOB_LUMBERJACK) 
            return SendErrorMessage(playerid, "Anda bukan pekerja lumberjack.");
        
        if(GetMoney(playerid) < 50) 
            return SendErrorMessage(playerid, "Uang kamu tidak cukup, butuh ($50) untuk membeli.");

        if(PlayerHasWeaponInSlot(playerid, 9))
            return SendErrorMessage(playerid, "Kamu memiliki item senjata lain dislot yang sama dengan chainsaw.");

        GiveMoney(playerid, -50, ECONOMY_ADD_SUPPLY, "bought chainsaw");
        GivePlayerWeaponEx(playerid, 9, 1);
        SendServerMessage(playerid, "Anda membeli "RED"Chainsaw "WHITE"dengan harga "GREEN"$50.");
    }
    else SendServerMessage(playerid, "Kamu tidak berada di lumberjack point.");

    return 1;
}