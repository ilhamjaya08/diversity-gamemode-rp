#define TAXI_FARE_PER_DISTANCE 2

/*==============================================================================
    Timer 
==============================================================================*/
ptask Player_VehicleSpeedUpgraded[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
    {
        new 
            index = -1,
            i = GetPlayerVehicleID(playerid)
        ;
        if((index = Vehicle_ReturnID(i)) != -1)
        {
            // Turbo hanya berlaku untuk mileage yang tidak overused.
            // if(!Vehicle_IsMileageOverused(i))
            // {
                // Mendapatkan mileage yang terpakai (tanpa akumulasi).
                // new
                //     current_mileage = Vehicle_GetCurrentMileage(i)
                // ;

                if(GetVehicleSpeed(i) > 100 && GetVehicleSpeed(i) < 250 && !DisableTurbo[i])//&& !DisableTurbo[i]
                {
                    if(GetVehicleSpeed(i) > 110 && GetVehicleSpeed(i) < 145 && VehicleData[index][vehTurbo] >= 1 && ChangeTurboOne[i])
                    {
                        SetVehicleSpeed(i, GetVehicleSpeed(i)+15, true, false);
                    }
                    else if(GetVehicleSpeed(i) > 140 && GetVehicleSpeed(i) < 170 && VehicleData[index][vehTurbo] >= 2 && ChangeTurboTwo[i])
                    {
                        SetVehicleSpeed(i, GetVehicleSpeed(i)+15, true, false);
                    }
                    else if(GetVehicleSpeed(i) > 160 && GetVehicleSpeed(i) < 250 && VehicleData[index][vehTurbo] >= 3 && ChangeTurboThree[i])
                    {
                        SetVehicleSpeed(i, GetVehicleSpeed(i)+15, true, false);
                    }
                    else if(GetVehicleSpeed(i) > 250 && VehicleData[index][vehTurbo] >= 3)
                    {
                        SetVehicleSpeed(i, GetVehicleSpeed(i)-15, true, false);
                    }

                    // // Menurunkan kecepatan kendaraan jika mileage-nya melebihi durability.
                    // if (Vehicle_IsMileageOverused(i) && (current_mileage >= (SAFE_MILEAGE + 20)))
                    // {
                    //     SetVehicleSpeed(i, GetVehicleSpeed(i) - 20, true, false);
                    // }
                }
            // }
        }
	}
	return 1;
}
ptask Player_YellowpageSalary[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(PlayerData[playerid][pBizJobDuty] != -1 && IsPlayerSpawned(playerid))
    {
        PlayerData[playerid][pBizDutyHour]++;
        if(PlayerData[playerid][pBizDutyHour] > 3600)//3600
        {
            new 
                bizid,
                bizname[100],
                salary
            ;
            
            bizid = PlayerData[playerid][pBizJobDuty];
            PlayerData[playerid][pBizDutyHour] = 0;
            salary = 3000+random(100);
            format(bizname, sizeof(bizname), "%s", BusinessData[bizid][bizName]);
            AddPlayerSalary(playerid, salary, bizname);
            Business_UpdateHour(playerid, bizid, 1);     
        }
    }
    return 1;
}
ptask Player_FactionSalary[1000](playerid) // Ini untuk nambah variabel factionduty perdetik sampai 3600 untuk di hitung 1 jam, harus di save dan akan nambah faction salary ketika sudah lebih 3600
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(IsPlayerDuty(playerid) && IsPlayerSpawned(playerid))
    {
        PlayerData[playerid][pFactionDuty]++; //markhere
        PlayerData[playerid][pFactionHour]++;
        if(PlayerData[playerid][pFactionDuty] > 3600) //3600 = 1 Jam. , 60 detik testing.
        {
            if (Player_IsFactionSalaryExceeded(playerid))
            {
                return 1;
            }

            new 
                factionid = PlayerData[playerid][pFaction],
                rank = PlayerData[playerid][pFactionRank],
                salary = FactionData[factionid][factionSalary][rank-1],
                factionname[32]
            ;
            format(factionname, 68, "%s", FactionData[factionid][factionName]);
            PlayerData[playerid][pFactionDuty] = 0;
            PlayerData[playerid][pFactionSalaryCollected] += salary;
            AddPlayerSalary(playerid, salary, factionname);
        }
    }
    return 1;
}
ptask Player_SystemUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
        //Flyhack anti cheat

    if(PlayerData[playerid][pMining] > 0 || PlayerData[playerid][pJailTime] > 0)
        SetPlayerArmedWeapon(playerid, 0);

    if (PlayerData[playerid][pFactionSalaryResettedAt] > 0 && PlayerData[playerid][pFactionSalaryResettedAt] <= gettime())
    {
        SendClientMessage(playerid, COLOR_WHITE, "[FACTION] Now you're able to receive salary.");
        PlayerData[playerid][pFactionDuty] = 0;
        PlayerData[playerid][pFactionSalaryCollected] = 0;
        PlayerData[playerid][pFactionSalaryResettedAt] = 0;
    }

    if(IsPlayerInAnyVehicle(playerid))
    {
        if(!IsDriveByWeapon(playerid))
        {
            SetPlayerArmedWeapon(playerid, 0);
        }
        if(PlayerData[playerid][pInjured])
        {
            SetPlayerArmedWeapon(playerid, 0);
        }
    }
    if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK && !PlayerData[playerid][pJetpack])
    {
        SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by BOT. Reason: using jetpack hack.", ReturnName(playerid, 0));
        KickEx(playerid);
        Log_Write("logs/cheat_log.txt", "[%s] %s has spawned a jetpack using hacks.", ReturnDate(), ReturnName(playerid, 0));
    }

    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        switch(GetPlayerAnimationIndex(playerid))
        {
            case 958, 959, 1538, 1539, 1543, 373:
            {
                new
                    Float:z,
                    Float:vx,
                    Float:vy,
                    Float:vz;

                GetPlayerPos(playerid, z, z, z);
                GetPlayerVelocity(playerid, vx, vy, vz);

                if((z > 20.0) && (0.9 <= floatsqroot((vx * vx) + (vy * vy) + (vz * vz)) <= 1.9) && AccountData[playerid][pAdmin] < 5)
                {
                    SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s was kicked by BOT, reason: Flying hacks", ReturnName(playerid, 0));
                    KickEx(playerid);
                }
            }
        }
    }

    if(GetPlayerPing(playerid) >= 800) {
        if(AccountData[playerid][pAdmin] < 1) {
            SendClientMessageToAllEx(X11_TOMATO_1, "BotCmd: %s have been kick for high ping: (%d/800)", ReturnName(playerid), GetPlayerPing(playerid));
            SendClientMessageEx(playerid, X11_TURQUOISE_1,"Anda telah di kick karena ping melebihi matas maksimal: (%d/800)", GetPlayerPing(playerid));
            KickEx(playerid);
        }
    }
    return 1;
}
ptask Player_Paycheck[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(!PlayerData[playerid][pCanPaycheck])
    {
        if(IsPlayerPaused(playerid))
            return 0;

        if(++PlayerData[playerid][pMinutes] >= 3600)
        {
            PlayerData[playerid][pCanPaycheck] = 1;
            PlayerData[playerid][pMinutes] = 3600;
            SendServerMessage(playerid, "Paycheck sudah dapat anda ambil di Bank atau ATM (/paycheck).");
        }
    }
    return 1;
}
ptask Player_CreditsCounter[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(PlayerData[playerid][pCallLine] != INVALID_PLAYER_ID)
    {
        kuranginCredits[playerid]++;
        if(makeCall[playerid] && PlayerData[playerid][pCredits] < kuranginCredits[playerid])
        {
            CancelCall(playerid);
        }
    }
    return 1;
}
ptask Player_JobTimer[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(PlayerData[playerid][pWoodDelay]) {
        PlayerData[playerid][pWoodDelay] --;

        if(!PlayerData[playerid][pWoodDelay]) {
            SendServerMessage(playerid, "Sekarang anda sudah bisa bekerja lagi sebagai Wood Courier");
        }
    }
    if(PlayerData[playerid][pLumberDelay]) {
        PlayerData[playerid][pLumberDelay] --;

        if(!PlayerData[playerid][pLumberDelay]) {
            SendServerMessage(playerid, "Sekarang anda sudah bisa menjual pohon lagi.");
        }
    }
    if(PlayerData[playerid][pDelayFishing])
    {
        if(--PlayerData[playerid][pDelayFishing] == 0)
            SendCustomMessage(playerid, "FISHING:","Anda bisa memancing ikan lagi.");
    }
    if(PlayerData[playerid][pDelayTruck])
    {
        if(--PlayerData[playerid][pDelayTruck] == 0)
            SendClientMessageEx(playerid, X11_TURQUOISE_1, "COURIER: "WHITE"Anda bisa bekerja courier kembali.");
    }
    if(PlayerData[playerid][pReportTime])
    {
        if(--PlayerData[playerid][pReportTime] == 0)
            SendCustomMessage(playerid, "REPORT", "Anda bisa melakukan "YELLOW"/report"WHITE" ulang untuk melaporkan sesuatu.");
    }

    if(IsPlayerVIP(playerid) && GetPlayerVIPLevel(playerid) >= 3)
    {
        PlayerData[playerid][pDelayFishing] = 0;
        PlayerData[playerid][pSweeperDelay] = 0;
        PlayerData[playerid][pBusDelay] = 0;
        PlayerData[playerid][pDelayTruck] = 0;
        PlayerData[playerid][pTrashmasterDelay] = 0;
        PlayerData[playerid][pMoneytransDelay] = 0;
        PlayerData[playerid][pBoxvilleDelay] = 0;
        PlayerData[playerid][pWoodDelay] = 0;
    }
    if(IsPlayerVIP(playerid) && GetPlayerVIPLevel(playerid) == 2)
    {
        PlayerData[playerid][pSweeperDelay] = 0;
        PlayerData[playerid][pBusDelay] = 0;
        PlayerData[playerid][pTrashmasterDelay] = 0;
    }
    return 1;
}
ptask Player_DrunkTimer[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(GetPlayerDrunkLevel(playerid) > 0 && PlayerData[playerid][pDrunkTime] > 0)
    {
        PlayerData[playerid][pDrunkTime]--;
        SetPlayerDrunkLevelEx(playerid, PlayerData[playerid][pDrunk], false, false);
    }
    else if(!IsPlayerDrugOrCrash(playerid) && PlayerData[playerid][pDrunkTime] <= 0 && !PlayerData[playerid][pLaginembak])
    {
        PlayerData[playerid][pDrunk] = 0;
        PlayerData[playerid][pDrunkTime] = 0;
        SetPlayerDrunkLevelEx(playerid, 0, false, false);
    }
    return 1;
}
ptask Player_ChargingTimer[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
        
    new 
        vw = GetPlayerVirtualWorld(playerid),
        hid = House_Inside(playerid),
        apartid = PlayerData[playerid][pApartment]
    ;
    if(hid != -1 || IsPlayerInAnyVehicle(playerid) || vw > MIN_VIRTUAL_WORLD || apartid != -1)
    {
        if(PlayerData[playerid][pPhoneBattery] >= 0 && ChargePhone[playerid] >= 1)
        {
            if(ChargePhone[playerid] > 30)
            {
                PlayerData[playerid][pPhoneBattery] += 10;
                ChargePhone[playerid] = 1;
            }
            else
            {
                ChargePhone[playerid] ++;
            }
        }

        if(PlayerData[playerid][pPhoneBattery] >= 100 && ChargePhone[playerid] >= 1)
        {
            PlayerData[playerid][pPhoneBattery] = 100;
            ChargePhone[playerid] = 0;
            SendClientMessage(playerid, COLOR_WHITE, "Your phone battery is full it will stop charging the battery!");
            SendNearbyMessage(playerid, 15.0, X11_PLUM, "** %s removes charge from his phone and stop charging their phone.", ReturnName(playerid, 0));

        }
    }

    if(Inventory_HasItem(playerid, "Cellphone") && PlayerData[playerid][pPhoneBattery] > 0  && !PlayerData[playerid][pPhoneOff] && ChargePhone[playerid] <= 0)
    {
        if(BatteryCounter[playerid] > 120) // Must be 120
        {
            PlayerData[playerid][pPhoneBattery] -= 0.5;
            BatteryCounter[playerid] = 0;
        }
        else
        {
            BatteryCounter[playerid]++;
        }

        if(PlayerData[playerid][pPhoneBattery] <= 0)
        {
            PlayerData[playerid][pPhoneBattery] = 0;
            PlayerData[playerid][pPhoneOff] = 1;
        }
    }
    return 1;
}
ptask Player_TaxiUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    new earned = 0;

    //Taxi GUI display
    if(PlayerData[playerid][pJob] == JOB_TAXI && PlayerData[playerid][pJobDuty])
    {
        new penumpang[75];

        foreach(new i : Player) if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)))
        {
            if(PlayerData[i][pTaxiPlayer] == playerid)
            {
                earned += PlayerData[i][pTaxiFee];
                format(penumpang, sizeof(penumpang), "%s%s~n~", penumpang, ReturnName(i, 0, 1));
            }
        }

        if (strlen(penumpang) > 0)
        {
            PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_taxi][3], sprintf("Total pendapatan: ~g~%s~n~~w~Penumpang:~n~%s", FormatNumber(earned), penumpang));
        }
        else
        {
            PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_taxi][3], "Total pendapatan: ~g~$0~n~~w~Penumpang:~n~ -");
        }
    }

    if(IsPlayerInsideTaxi(playerid))
    {
        new
            Float:x,
            Float:y,
            Float:z;

        GetPlayerPos(playerid, x,y,z);

        new Float:distance = GetDistanceBetweenPoints(PlayerData[playerid][tPos][0], PlayerData[playerid][tPos][1], PlayerData[playerid][tPos][2], x,y,z);

        if(distance > 100.0)
        {
            if(GetMoney(playerid) < PlayerData[playerid][pTaxiFee])
            {
                RemovePlayerFromVehicle(playerid);
                SendCustomMessage(playerid, "TAXI DRIVER", "Keluar dari taxi, uang yang anda miliki tidak mencukupi.");
                return 1;
            }
            GetPlayerPos(playerid, PlayerData[playerid][tPos][0], PlayerData[playerid][tPos][1], PlayerData[playerid][tPos][2]);
            PlayerData[playerid][pTaxiFee] += TAXI_FARE_PER_DISTANCE;

            if(++PlayerData[playerid][pTaxiRunDistance] == 10)
            {
                GiveMoney(PlayerData[playerid][pTaxiPlayer], 5, ECONOMY_TAKE_SUPPLY, "taxi driver bonus per 1 km");
                SendServerMessage(PlayerData[playerid][pTaxiPlayer], "Anda mendapat bonus $5 dari server untuk 1000 meter perjalanan.");
                PlayerData[playerid][pTaxiRunDistance] = 0;
            }

        }
        GameTextForPlayer(playerid, sprintf("~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~Taxi_Argo~n~~r~~h~$%d", PlayerData[playerid][pTaxiFee]), 1100, 3);
    }
    return 1;
}

ptask Player_SpectateUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(PlayerData[playerid][pSpectator] != INVALID_PLAYER_ID && SQL_IsCharacterLogged(PlayerData[playerid][pSpectator])) 
    {
        new 
            userid = PlayerData[playerid][pSpectator], 
            Float:healthp = GetHealth(userid), 
            Float:armor = GetArmour(userid), 
            keys, 
            updown, 
            leftright
        ;

        GetPlayerKeys(userid, keys, updown, leftright);

        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_spectate][0], sprintf("~g~%s (%d)~n~~w~Money: ~b~%s~n~~w~Health: ~b~%.1f~n~~w~AP: ~b~%.1f~n~~w~Int: ~b~%d~n~~w~Vw: ~b~%d~n~~w~Keys: ~b~%d", ReturnName(userid, 0), userid, FormatNumber(GetMoney(userid)), healthp, armor, GetPlayerInterior(userid), GetPlayerVirtualWorld(userid), keys));
    }
    return 1;
}
ptask Player_UpdateStatus[500](playerid)
{
    if(PlayerData[playerid][pInjured] == 1 && !PlayerData[playerid][pFirstAid])
    {
        if(!IsPlayerInAnyVehicle(playerid) && GetPlayerAnimationIndex(playerid) != 1701)
        {
            ApplyAnimation(playerid, "WUZI", "CS_DEAD_GUY", 4.0, 0, 0, 0, 1, 0, 1);
            ApplyAnimation(playerid, "WUZI", "CS_DEAD_GUY", 4.0, 0, 0, 0, 1, 0, 1);
        }
    }
    return 1;
}
ptask Player_UpdateStats[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(IsPlayerInEvent(playerid))
        return 0;

    new 
        Float:server_health = GetHealth(playerid),
        Float:client_health,
        Float:server_armour = GetArmour(playerid),
        Float:client_armour
    ;

    GetPlayerHealth(playerid, client_health);
    GetPlayerArmour(playerid, client_armour);

    if(client_health != server_health)
    {
        SetHealth(playerid, server_health);
    }
    else if(client_armour != server_armour)
    {
        SetArmour(playerid, server_armour);
    }

    if(GetPlayerMoney(playerid) != PlayerData[playerid][pMoney]) {
        ResetPlayerMoney(playerid);
        GivePlayerMoney(playerid, PlayerData[playerid][pMoney]);
    }

    if(!IsPlayerPaused(playerid))
    {
        if(++PlayerData[playerid][pSecond] >= 60)
        {
            PlayerData[playerid][pSecond] = 0;

            if(++PlayerData[playerid][pMinute] >= 60)
            {
                PlayerData[playerid][pMinute] = 0;
                PlayerData[playerid][pHour]++;

                new scoremath = ((PlayerData[playerid][pScore] + 1) * 4);

                if(++PlayerData[playerid][pPlayingHours] >= scoremath)
                {
                    PlayerData[playerid][pPlayingHours] = 0;
                    PlayerData[playerid][pScore] ++;
                    SetPlayerScore(playerid, PlayerData[playerid][pScore]);

                    GameTextForPlayer(playerid, sprintf("~g~New level unlocked~n~~w~Now you're level ~r~%d", PlayerData[playerid][pScore]), 6000, 1);
                }
            }
        }
    }
    return 1;
}
ptask Player_HospitalTimer[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(!PlayerData[playerid][pKilled] && PlayerData[playerid][pHospital] != -1)
    {
        if(!IsPlayerPaused(playerid))
        {
            if(++PlayerData[playerid][pHospitalTime] >= 120)
            {
                SetPlayerPos(playerid, 1182.8778,-1324.2023,13.5784);
                SetPlayerFacingAngle(playerid, 269.8747);

                SetPlayerVirtualWorld(playerid, 0);
                SetPlayerInterior(playerid, 0);

                TogglePlayerControllable(playerid, 1);
                SetCameraBehindPlayer(playerid);

                Damage_Reset(playerid);

                if(IsPlayerDuty(playerid)) ResetFactionWeapon(playerid);
                else ResetWeapons(playerid);

                if(GetPVarInt(playerid, "ForceHospital") == 1)
                {
                    ClearPlayerChat(playerid, 20);

                    SendClientMessage(playerid, X11_GREY_60, "--------------------------------------------------------------------------------------------------------");
                    SendClientMessage(playerid, X11_WHITE, "Anda telah keluar dari rumah sakit, dan membayar "GREEN"$150"WHITE". Selamat beraktivitas kembali.");
                    SendClientMessage(playerid, X11_WHITE, "(( Semua senjata yang anda punya, otomatis di hilangkan karna dalam kadaan death, tidak ada refund untuk ini. ))");
                    SendClientMessage(playerid, X11_GREY_60, "--------------------------------------------------------------------------------------------------------");

                    GiveMoney(playerid, -150, ECONOMY_ADD_SUPPLY, "medical cost");
                }
                DeletePVar(playerid, "ForceHospital");

                PlayerData[playerid][pHospitalTime] = 0;
                PlayerData[playerid][pHospital] = -1;

                for(new i = 0; i != MAX_FACTIONS; i++) if(FactionData[i][factionExists] && FactionData[i][factionType] == FACTION_MEDIC) {
                    FactionData[i][factionMoney] += 75;
                }
                return 1;
            }
            ApplyAnimation(playerid, "CRACK", "crckidle2", 4.0, 1, 0, 0, 0, 0);
            GameTextForPlayer(playerid, sprintf("~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Recovering... ~g~~h~%d", 120 - PlayerData[playerid][pHospitalTime]), 1000, 3);
        }
    }
    return 1;
}
ptask Player_InjuredTimer[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(PlayerData[playerid][pInjured])
    {
        if(PlayerData[playerid][pDead] <= 20.0 && !PlayerDeath[playerid])
        {
            PlayerDeath[playerid] = 1;
            InjuredTag(playerid, false, true);
        }
        if(PlayerData[playerid][pGiveupTime])
        {
            PlayerData[playerid][pGiveupTime] --;

            if(!PlayerData[playerid][pGiveupTime])
                SendServerMessage(playerid, "Sekarang kamu bisa gunakan perintah '"YELLOW"/giveup"WHITE"' untuk spawn ke rumah sakit!.");

        }
        return 1;
    }
    return 1;
}
ptask Player_CookingTimer[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(PlayerData[playerid][pCooking] && IsPlayerSpawned(playerid))
    {
        if(!IsPlayerCookingInsideHouse(playerid) && !IsPlayerCookingInsideRV(playerid) && !IsPlayerCookingNearCampfire(playerid) && !IsPlayerCookingInsideApartment(playerid))
            return SendServerMessage(playerid, "Gagal memasak, kamu terlalu jauh dari tempat memasak."), ResetCooking(playerid);

        if(--PlayerData[playerid][pCookingTime] < 1)
        {
            switch (PlayerData[playerid][pCooking])
            {
                case 1:
                {
                    if(Inventory_Add(playerid, "Cooked Burger", 2703, 1) != -1)
                    {
                        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** The food is done, you can smell a burger! (( %s ))", ReturnName(playerid, 0));
                        SendServerMessage(playerid, "The "YELLOW"cooked burger "WHITE"was added to your inventory.");
                    }
                }
                case 2:
                {
                    if(Inventory_Add(playerid, "Cooked Pizza", 2702, 1) != -1)
                    {
                        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** The food is done, you can smell pizza! (( %s ))", ReturnName(playerid, 0));
                        SendServerMessage(playerid, "The "YELLOW"cooked pizza "WHITE"was added to your inventory.");
                    }
                }
                case 3:
                {
                    if(Inventory_Add(playerid, "Cooked Fish", 19630, 1) != -1)
                    {
                        SendNearbyMessage(playerid, 15.0, X11_PLUM, "** The food is done, you can smell fish! (( %s ))", ReturnName(playerid, 0));
                        SendServerMessage(playerid, "The "YELLOW"cooked fish "WHITE"was added to your inventory.");
                    }
                }
            }
            new 
                rand = random(500)+random(50)
            ;
            if(rand <= 10)
            {
                new houseid = PlayerData[playerid][pCookingHouse];
                if(houseid != -1)
                {
                    SetHouseOnFire(playerid, houseid);
                    SendServerMessage(playerid, "Your house exploded and on fire after your finish cooking!");
                }
            }
            ResetCooking(playerid);
        }
        else GameTextForPlayer(playerid, sprintf("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~b~~h~Memasak...~w~ %d seconds", PlayerData[playerid][pCookingTime]), 1200, 3);
    }
    return 1;
}
ptask Player_TextdrawUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(!PlayerData[playerid][pTogHud])
    {
        new Float:x, Float:y, Float:z;

        GetPlayerPos(playerid, x, y, z);

        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_map], sprintf("%s", GetLocation(x, y, z)));

        // Untuk mengambil waktu saat ini.
        new
            Timestamp:now = Now() + Hours:7,
            outputDate[32],
            outputTime[32],
            datestring[64],
            days,
            months,
            years;

        TimeFormat(now, "%d/%m/%Y", outputDate);
        TimeFormat(now, "%H:%M:%S", outputTime);

	    getdate(years, months, days);
	    format(datestring, sizeof datestring, "%s%d %s %s%d", ((days < 10) ? ("0") : ("")), days, GetMonthName(months), (years < 10) ? ("0") : (""), years);

        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_timegui][0], outputTime);
        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_timegui][1], datestring);
    }
    return 1;
}
ptask Player_FishSignalUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(IsPlayerInAnyVehicle(playerid) && IsABoat(GetPlayerVehicleID(playerid)))
    {
        for (new zone = 0; zone < FISH_ZONE; zone++) if(IsPlayerInDynamicArea(playerid, fishzone[zone])) {
            GameTextForPlayer(playerid, sprintf("~w~Boat signal~n~~r~~h~%s", zones_text[zone]), 1000, 4);
        }
    }
    return 1;
}
ptask Player_HouseLightUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    new id;
    switch (PlayerData[playerid][pHouseLights])
    {
        case 0:
        {
            if((id = House_Inside(playerid)) != -1 && !HouseData[id][houseLights])
            {
                PlayerData[playerid][pHouseLights] = true;
                PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][textdraw_switch]);
            }
            else PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][textdraw_switch]);
        }
        case 1:
        {
            if((id = House_Inside(playerid)) == -1 || (id != -1 && HouseData[id][houseLights]))
            {
                PlayerData[playerid][pHouseLights] = false;
                PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][textdraw_switch]);
            }
        }
    }
    return 1;
}

ptask Player_TazerUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;   

    if(PlayerData[playerid][pStunned] > 0)
    {
        PlayerData[playerid][pStunned]--;

        if(GetPlayerAnimationIndex(playerid) != 388)
            ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

        if(!PlayerData[playerid][pStunned])
        {
            TogglePlayerControllable(playerid, 1);
            ShowPlayerFooter(playerid, "You are no longer ~r~stunned.");
        }
    }
    return 1;
}
ptask Player_FeatureUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;   

    if(PlayerData[playerid][pMuted] && PlayerData[playerid][pMuteTime] > 0)
    {
        PlayerData[playerid][pMuteTime]--;

        if(!PlayerData[playerid][pMuteTime])
        {
            PlayerData[playerid][pMuted] = 0;
            PlayerData[playerid][pMuteTime] = 0;
        }
    }
    if(PlayerData[playerid][pVendorTime] > 0)
    {
        PlayerData[playerid][pVendorTime]--;
    }
    if(PlayerData[playerid][pSpeedTime] > 0)
    {
        PlayerData[playerid][pSpeedTime]--;
    }
    if(PlayerData[playerid][pFingerTime] > 0)
    {
        PlayerData[playerid][pFingerTime]--;

        if(!PlayerData[playerid][pFingerTime] && DroppedItems[PlayerData[playerid][pFingerItem]][droppedModel] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedItems[PlayerData[playerid][pFingerItem]][droppedPos][0], DroppedItems[PlayerData[playerid][pFingerItem]][droppedPos][1], DroppedItems[PlayerData[playerid][pFingerItem]][droppedPos][2]))
        {
            SendServerMessage(playerid, "The fingerprint scanner has detected a match: %s.", DroppedItems[PlayerData[playerid][pFingerItem]][droppedPlayer]);
            PlayerData[playerid][pFingerItem] = -1;
        }
    }
    return 1;
}
ptask Player_JailUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;    

    if(PlayerData[playerid][pJailTime] > 0)
    {
        static
            hours,
            minutes,
            seconds;

        if(--PlayerData[playerid][pJailTime] <= 0)
        {
            if(PlayerData[playerid][pPrisoned])
                PlayerData[playerid][pPrisoned] = 0;

            new stamps = Inventory_Count(playerid, "Stamps");

            SetPlayerPos(playerid,1545.7598,-1675.6178,13.5610);
            SetPlayerFacingAngle(playerid, 88.6950);
            ApplyAnimation(playerid, "STRIP", "none", 4.1, 0, 0, 0, 0, 0, 1);
            ApplyAnimation(playerid, "STRIP", "PUN_HOLLER", 4.1, 0, 0, 0, 0, 0, 1);
            SetPlayerInterior(playerid,0);
            SetPlayerVirtualWorld(playerid, 0);
            SendServerMessage(playerid, "You have been released from prison, now you're free to go.");
            SendServerMessage(playerid, "Stamps kamu sudah di ambil dan di tukarkan menjadi uang senilai $%d !.", stamps);
            SetCameraBehindPlayer(playerid);
            PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][textdraw_prison]);
            GiveMoney(playerid, stamps, ECONOMY_TAKE_SUPPLY, "redeem stamps");
            Inventory_Remove(playerid, "Stamps", -1);
            
        }
        GetElapsedTime(PlayerData[playerid][pJailTime], hours, minutes, seconds);
        PlayerTextDrawSetString(playerid, PlayerTextdraws[playerid][textdraw_prison], PlayerData[playerid][pPrisoned] ? (sprintf("~g~Prison Time:~w~ %02d:%02d:%02d", hours, minutes, seconds)) : (sprintf("~g~Reason  : ~w~%s~n~~g~Jail Time:~w~ %02d:%02d:%02d (/myjail)", PlayerData[playerid][pJailReason], hours, minutes, seconds)));
    }
    return 1;
}
ptask Player_TrackingUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    new id;
    if(PlayerData[playerid][pTrackTime] > 0 && IsPlayerConnected(PlayerData[playerid][pMDCPlayer]) && GetFactionType(playerid) == FACTION_POLICE)
    {
        PlayerData[playerid][pTrackTime]--;

        if(!PlayerData[playerid][pTrackTime])
        {
            if((id = House_Inside(PlayerData[playerid][pMDCPlayer])) != -1)
            {
                PlayerData[playerid][pCP] = 1;

                SetPlayerCheckpoint(playerid, HouseData[id][housePos][0], HouseData[id][housePos][1], HouseData[id][housePos][2], 3.0);
                SendServerMessage(playerid, "%s's last reported location was at \"%s\" (marked on radar).", ReturnName(PlayerData[playerid][pMDCPlayer], 0), HouseData[id][houseAddress]);
            }
            else if((id = Business_Inside(PlayerData[playerid][pMDCPlayer])) != -1)
            {
                PlayerData[playerid][pCP] = 1;

                SetPlayerCheckpoint(playerid, BusinessData[id][bizPos][0], BusinessData[id][bizPos][1], BusinessData[id][bizPos][2], 3.0);
                SendServerMessage(playerid, "%s's last reported location was at \"%s\" (marked on radar).", ReturnName(PlayerData[playerid][pMDCPlayer], 0), BusinessData[id][bizName]);
            }
            else if(GetPlayerInterior(PlayerData[playerid][pMDCPlayer]) == 0)
            {
                static
                    Float:fX,
                    Float:fY,
                    Float:fZ;

                GetPlayerPos(PlayerData[playerid][pMDCPlayer], fX, fY, fZ);
                PlayerData[playerid][pCP] = 1;

                SetPlayerCheckpoint(playerid, fX, fY, fZ, 3.0);
                SendServerMessage(playerid, "%s's last reported location was at \"%s\" (marked on radar).", ReturnName(PlayerData[playerid][pMDCPlayer], 0), GetLocation(fX, fY, fZ));
            }
            else
            {
                SendServerMessage(playerid, "Unable to locate %s; the target is out of range (inside an interior).", ReturnName(PlayerData[playerid][pMDCPlayer], 0));
            }
        }
    }
    return 1;
}
//Character Bodystatus Update
ptask Player_UsePillsUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(CharacterUpdateCheck(playerid))
    {
        if(PlayerData[playerid][pUsePills] > 0)
        {
            if(--PlayerData[playerid][pUsePills] == 0) {
                SendServerMessage(playerid, "Anda bisa mengkonsumsi obat lagi sekarang.");
            }
        }
    }
    return 1;
}
ptask Player_BodyStatusUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(CharacterUpdateCheck(playerid))
    {
        if(!AccountData[playerid][pAdminDuty] && !IsPlayerInNewbieSchool(playerid))
        {
            new
                animidx = GetPlayerAnimationIndex(playerid),
                k,
                ud,
                lr,
                Float:adjustment,
                Float:adjustment1
            ;
            if(PlayerData[playerid][pSpecialEffect] <= 0)
            {                
                GetPlayerKeys(playerid, k, ud, lr);

                if(animidx == 43) {
                    adjustment = (0.06 * 0.4);
                    adjustment1 = (0.06 * 0.3); // Sitting
                } else if(animidx == 1159) {
                    adjustment = (0.06 * 0.7);
                    adjustment1 = (0.06 * 0.7); // Crouching
                } else if(animidx == 1195) {
                    adjustment = (0.06 * 1.9);
                    adjustment1 = (0.06 * 1.5); // Jumping
                } else if(animidx == 1231) {
                    if(k & KEY_WALK) {
                        adjustment = (0.06 * 0.08);
                        adjustment1 = (0.06 * 0.07); // Walking
                    } else if(k & KEY_SPRINT) {
                        adjustment = (0.06 * 1.5);
                        adjustment1 = (0.06 * 1.2); // Sprinting
                    } else if(k & KEY_JUMP) {
                        adjustment = (0.06 * 1.8);
                        adjustment1 = (0.06 * 1.7); // Jumping
                    } else {
                        adjustment = (0.06 * 0.8);
                        adjustment1 = (0.06 * 0.4); // Jogging
                    }
                } else {
                    adjustment = 0.05;
                    adjustment1 = 0.04;
                }
            }
            else if(PlayerData[playerid][pSpecialEffect] > 0)
            {
                adjustment = 0.02;
                adjustment1 = 0.02;
            }

            adjustment *= 0.2;
            adjustment1 *= 0.2;

            SetPlayerHunger(playerid, PlayerData[playerid][pHunger]-adjustment);
            SetPlayerEnergy(playerid, PlayerData[playerid][pEnergy]-adjustment1);
            SetPlayerRate(playerid, PlayerData[playerid][pDead]);
        }
    }
    return 1;
}
ptask Player_CharacterSick[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(CharacterUpdateCheck(playerid))
    {
        if(PlayerData[playerid][pHunger] <= 10 || PlayerData[playerid][pEnergy] <= 10 || PlayerData[playerid][pMigrainRate] != 0 || PlayerData[playerid][pFever] != 0)
        {
            if(PlayerData[playerid][pMigrainRate] > 1 || PlayerData[playerid][pFever] > 0) {
                FlashTextDraw(playerid, PlayerTextdraws[playerid][textdraw_sick], 2000);
                PlayerTextDrawShow(playerid, PlayerTextdraws[playerid][textdraw_sick]);
                // SetPlayerDrunkLevel(playerid, 5000*(PlayerData[playerid][pFever]+1));
            }

            if(PlayerData[playerid][pFever])
            {
                if(++PlayerData[playerid][pFeverTime] >= 600)
                {
                    //new pengurangan;

                    // switch(PlayerData[playerid][pFever])
                    // {
                    //     case 1: SetPlayerDrunkLevel(playerid, 5000*(PlayerData[playerid][pFever]+1));
                    //     case 2: SetPlayerDrunkLevel(playerid, 5000*(PlayerData[playerid][pFever]+1));
                    //     case 3: SetPlayerDrunkLevel(playerid, 5000*(PlayerData[playerid][pFever]+1));
                    // }
                    PlayerData[playerid][pFeverTime] = 0;
                }
            }
            //Pengecheckan
            if(++PlayerData[playerid][pMigrainTime] >= 600)
            {
                if(PlayerData[playerid][pFever])
                {
                    if(PlayerData[playerid][pFever] <= 2)
                    {
                        SendServerMessage(playerid, "You got High Fever, this is dangerous disease you should go to doctor now!");
                        PlayerData[playerid][pFever] ++;
                    }
                }

                if(!PlayerData[playerid][pFever] && PlayerData[playerid][pMigrainRate] < 4)
                {
                    PlayerData[playerid][pMigrainRate] ++;

                    if(PlayerData[playerid][pMigrainRate] < 3)
                        SendServerMessage(playerid, "You got headache, go check to the doctor for cure your diseases.");

                    if(PlayerData[playerid][pMigrainRate] >= 4) {
                        SendServerMessage(playerid, "You got High Fever, this is dangerous disease you should go to doctor now!");
                        PlayerData[playerid][pFever] ++;
                        PlayerData[playerid][pMigrainRate] = 0;
                    }
                }
                PlayerData[playerid][pMigrainTime] = 0;
            }
        }
        else 
        {
            PlayerTextDrawHide(playerid, PlayerTextdraws[playerid][textdraw_sick]);

            if(GetPlayerDrunkLevel(playerid) >= 1 && !GetPlayerDrugeEffect(playerid) && !IsPlayerDrunkOrCrash(playerid))
                SetPlayerDrunkLevel(playerid, 0);
        }
    }
    return 1;
}
ptask Player_CharacterCough[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(CharacterUpdateCheck(playerid))
    {
        if(PlayerData[playerid][pCough] >= 5)
        {
            new waktu;

            switch(PlayerData[playerid][pCough]/5)
            {
                case 1: waktu=150;
                case 2: waktu=120;
                case 3: waktu=90;
            }
            if(++PlayerData[playerid][pCoughTime] > waktu)
            {
                cmd_ame(playerid, "is cough.");
                PlayerData[playerid][pCoughTime] = 0;
            }
        }
    }
    return 1;
}

ptask Player_Injured[60000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(PlayerData[playerid][pInjured] && !PlayerData[playerid][pBandage])
    {
        SetPlayerRate(playerid, PlayerData[playerid][pDead] - 10.0);
    }
    return 1;
}
ptask Player_MinuteUpdate[60000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    if(IsAdminOnDuty(playerid) && !IsPlayerPaused(playerid))
        AccountData[playerid][pAdminDutyTime]++;

    static save_counter;

    if(save_counter++ >= SAVE_CHARACTERS_INTERVAL)
    {
        SQL_SaveCharacter(playerid);
        // SendServerMessage(playerid, "Data karaktermu telah diperbaharui!");        
        save_counter = 0;
    }
    return 1;
}
ptask Player_ExpiredTimer[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
    
    if(PlayerData[playerid][pDMVTime])
    {
        PlayerData[playerid][pDMVTime]--;

        if(!PlayerData[playerid][pDMVTime])
        {
            PlayerData[playerid][pDMVTime] =  0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "LICENSE: "WHITE"Now you can go to DMV to get test again.");
        }
    }
    if(PlayerData[playerid][pIDCardExpired] > 0)
    {
        if(gettime() >= PlayerData[playerid][pIDCardExpired]){
            PlayerData[playerid][pIDCardExpired] = 0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "ID-CARD: "WHITE"Your id card now is expired!");
        }
    }
    if(PlayerData[playerid][pDrivingLicense] == 1 && PlayerData[playerid][pDrivingLicenseExpired] > 0)
    {
        if(gettime() >= PlayerData[playerid][pDrivingLicenseExpired]) {
            PlayerData[playerid][pDrivingLicenseExpired] =  0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "LICENSE: "WHITE"Your driving license now is expired.");
        }
    }
    if(PlayerData[playerid][pFirearmLicense] == 1 && PlayerData[playerid][pFirearmLicenseExpired] > 0)
    {
        if(gettime() >= PlayerData[playerid][pFirearmLicenseExpired]) {
            PlayerData[playerid][pFirearmLicenseExpired] =  0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "LICENSE: "WHITE"Your firearm license now is expired.");
        }
    }
    if(PlayerData[playerid][pBusinessLicense] == 1 && PlayerData[playerid][pBusinessLicenseExpired] > 0)
    {
        if(gettime() >= PlayerData[playerid][pBusinessLicenseExpired]) {
            PlayerData[playerid][pBusinessLicenseExpired] =  0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "LICENSE: "WHITE"Your business license now is expired.");
        }
    }
    if(PlayerData[playerid][pWorkshopLicense] == 1 && PlayerData[playerid][pWorkshopLicenseExpired] > 0)
    {
        if(gettime() >= PlayerData[playerid][pWorkshopLicenseExpired]) {
            PlayerData[playerid][pWorkshopLicenseExpired] =  0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "LICENSE: "WHITE"Your workshop license now is expired.");
        }
    }
    if(PlayerData[playerid][pLumberLicense] == 1 && PlayerData[playerid][pLumberLicenseExpired] > 0)
    {
        if(gettime() >= PlayerData[playerid][pLumberLicenseExpired]) {
            PlayerData[playerid][pLumberLicenseExpired] =  0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "LICENSE: "WHITE"Your lumber license now is expired.");
        }
    }
    if(PlayerData[playerid][pTruckLicense] == 1 && PlayerData[playerid][pTruckLicenseExpired] > 0)
    {
        if(gettime() >= PlayerData[playerid][pTruckLicenseExpired]) {
            PlayerData[playerid][pTruckLicenseExpired] =  0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "LICENSE: "WHITE"Your trucker license now is expired.");
        }
    }
    if(PlayerData[playerid][pBLSLicense] == 1 && PlayerData[playerid][pBLSLicenseExpired] > 0)
    {
        if(gettime() >= PlayerData[playerid][pBLSLicenseExpired]) {
            PlayerData[playerid][pBLSLicenseExpired] =  0;
            SendClientMessage(playerid, X11_TURQUOISE_1, "CERTIFICATE: "WHITE"Your BLS certificate now is expired.");
        }
    }
    return 1;
}

// ptask Player_BleedingTimer[1000](playerid)
// {
//     if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
//         return 0;

//     if(PlayerData[playerid][pBleeding] && PlayerData[playerid][pBleedTime])
//     {
//         BleedingTimer[playerid]++;
//         PlayerData[playerid][pBandage]--;
//         if(PlayerData[playerid][pBandage] <= 0) 
//         {
//             PlayerData[playerid][pBandage] = 0;
//         }
//         if(PlayerData[playerid][pBandage] <= 0 && BleedingTimer[playerid] >= 5)
//         {
//             new
//                 Float:health = GetHealth(playerid)
//             ;
//             if(BleedingNotification[playerid])
//             {
//                 SendClientMessageEx(playerid, COLOR_WHITE, "You're "RED"bleeding "WHITE"there are "YELLOW"several wounds"WHITE" on your body, get some surgery or /treatment to stop the bleeding!");
//                 PlayerData[playerid][pFirstAid] = false;
//                 BleedingNotification[playerid] = 0;
//             }
//             BleedingTimer[playerid] = 0;
//             SetHealth(playerid, health-1.5);
//         }
//     }
//     return 1;
// }

ptask Player_TabbingOut[500](playerid)
{
    new Text3D:tab_out = PlayerData[playerid][pTabOut];
    if(IsPlayerPaused(playerid))
    {
        if(!IsValidDynamic3DTextLabel(tab_out))
        {
            PlayerData[playerid][pTabOut] = CreateDynamic3DTextLabel("(( TABBING OUT ))", COLOR_LIGHTRED, 0.0, 0.0, 0.3, 8.0, playerid, INVALID_VEHICLE_ID, 1);
        }
    }
    else
    {
        if(IsValidDynamic3DTextLabel(tab_out))
        {
            DestroyDynamic3DTextLabel(tab_out);
            PlayerData[playerid][pTabOut] = Text3D:INVALID_STREAMER_ID;
        }
    }
    return 1;
}
ptask Player_Fishing[100](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if((keys & KEY_SPRINT) && (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) && BaitEaten[playerid])
    {
        if(!FishClickedReduce[playerid])
        {
            FishClicked[playerid]+= RandomEx(1, 10);
            if(FishClicked[playerid] >= 100)
            {
                FishClicked[playerid] = 100;
                FishClickedReduce[playerid] = 1;
            }
        }
        else
        {
            FishClicked[playerid]-= RandomEx(1, 10);
            if(FishClicked[playerid] <= 0)
            {
                FishClicked[playerid] = 0;
                FishClickedReduce[playerid] = 0;
            }
        }
        SetPlayerProgressBarValue(playerid, FishingProgressBar[playerid], FishClicked[playerid]);
        SetPlayerProgressBarColour(playerid, FishingProgressBar[playerid], ConvertHBEColor(FishClicked[playerid]));
    }
    return 1;
}
