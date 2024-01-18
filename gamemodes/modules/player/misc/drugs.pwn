#include <YSI\y_hooks>


#define GetPlayerConsumeDrug(%0)                   playerConsumeDrug[%0]
#define SetPlayerConsumeDrug(%0,%1)                playerConsumeDrug[%0]=%1

#define GetPlayerDrugType(%0)                      playerUseDrugType[%0]
#define SetPlayerDrugType(%0,%1)                   playerUseDrugType[%0]=%1

#define GetPlayerDrugTime(%0)                      playerUseDrugTime[%0]
#define SetPlayerDrugTime(%0,%1)                   playerUseDrugTime[%0]=%1

#define GetPlayerDrugHeroin(%0)                    playerUseDrugHeroin[%0]
#define GetPlayerDrugCocaine(%0)                   playerUseDrugCocaine[%0]
#define GetPlayerDrugeEffect(%0)                   playerDrugDyingEffect[%0]
#define GetPlayerDrugLSD(%0)                       playerUseDrugLSD[%0]
#define GetPlayerDrugEcstasy(%0)                   playerUseDrugEcstasy[%0]

#define GetPlayerDrugeDyingTime(%0)                playerDrugDyingTime[%0]
#define SetPlayerDrugeDyingTime(%0,%1)             playerDrugDyingTime[%0]=%1


enum
{
    e_DRUG_NONE = 0,
    e_DRUG_MARIJUANA,
    e_DRUG_HEROIN,
    e_DRUG_COCAINE,
    e_DRUG_LSD,
    e_DRUG_ECS,
};

new
    playerUseDrugType[MAX_PLAYERS] = {0, ...},
    playerUseDrugTime[MAX_PLAYERS] = {0, ...},
    playerUseDrugHeroin[MAX_PLAYERS] = {0, ...},
    playerUseDrugCocaine[MAX_PLAYERS] = {0, ...},
    playerUseDrugLSD[MAX_PLAYERS] = {0, ...},
    playerUseDrugEcstasy[MAX_PLAYERS] = {0, ...},
    bool:playerConsumeDrug[MAX_PLAYERS] = false;

new
    playerDrugDyingTime[MAX_PLAYERS] = {0, ...},
    playerDrugDyingEffect[MAX_PLAYERS] = {0, ...};


CMD:usedrug(playerid, params[])
{
    if(PlayerData[playerid][pScore] < 5) 
        return SendErrorMessage(playerid, "Harus level 5 untuk menggunakan perintah ini!");

    if(isnull(params))
    {
        SendSyntaxMessage(playerid, "/usedrug [name]");
        SendClientMessage(playerid, X11_YELLOW_2, "[NAMES]:"WHITE" marijuana, cocaine, heroin, lsd, ecs");
        return 1;
    }

    if(GetPlayerDrugeEffect(playerid))
        return SendErrorMessage(playerid, "Tidak bisa menggunakan perintah dalam kondisi efek obat-obatan.");

    if(GetPlayerConsumeDrug(playerid))
        return SendErrorMessage(playerid, "Tunggu proses penggunaan obat-obatan selesai untuk menggunakan perintah ini kembali!.");

    if(!strcmp(params, "marijuana", true))
    {
        if(PlayerData[playerid][pCough] >= 15)
            return SendErrorMessage(playerid, "Anda memiliki penyakit berat, tidak dapat mengkonsumsi marijuana berlebihan!.");

        if(Inventory_Count(playerid, "Marijuana") < 5)
            return SendErrorMessage(playerid, "You need at least 5 grams of marijuana.");

        if(Drug_Checking(playerid, true) == -1)
            return 1;

        SetPlayerDrugTime(playerid, 5);
        SetPlayerConsumeDrug(playerid, true);
        SetPlayerDrugType(playerid, e_DRUG_MARIJUANA);

        Inventory_Remove(playerid, "Marijuana", 5);

        PlayerData[playerid][pCough]++;
        ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 1, 0, 0, 0, 0, 1);
    }
    else if(!strcmp(params, "cocaine", true))
    {
        if(Inventory_Count(playerid, "Cocaine") < 1)
            return SendErrorMessage(playerid, "You need at least 1 grams of cocaine.");

        if(Drug_Checking(playerid) == -1)
            return 1;

        SetPlayerDrugTime(playerid, 5);
        SetPlayerConsumeDrug(playerid, true);
        SetPlayerDrugType(playerid, e_DRUG_COCAINE);

        Inventory_Remove(playerid, "Cocaine", 1);

        ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 1, 0, 0, 0, 0, 1);
    }
    else if(!strcmp(params, "heroin", true))
    {
        if(Inventory_Count(playerid, "Heroin") < 1)
            return SendErrorMessage(playerid, "You need at least 1 grams of heroin.");

        if(Drug_Checking(playerid) == -1)
            return 1;

        SetPlayerDrugTime(playerid, 5);
        SetPlayerConsumeDrug(playerid, true);
        SetPlayerDrugType(playerid, e_DRUG_HEROIN);

        Inventory_Remove(playerid, "Heroin", 1);

        ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 1, 0, 0, 0, 0, 1);
    }
    else if(!strcmp(params, "lsd", true))
    {
        if(PlayerData[playerid][pSpecialEffect] > 0)
            return SendErrorMessage(playerid, "You can use this drugs after %d minutes", PlayerData[playerid][pSpecialEffect]);

        if(Inventory_Count(playerid, "LSD") < 1)
            return SendErrorMessage(playerid, "You need at least 1 grams of LSD.");

        if(Drug_Checking(playerid) == -1)
            return 1;

        SetPlayerDrugTime(playerid, 5);
        SetPlayerConsumeDrug(playerid, true);
        SetPlayerDrugType(playerid, e_DRUG_LSD);

        Inventory_Remove(playerid, "LSD", 1);

        ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 1, 0, 0, 0, 0, 1);
    }
    else if(!strcmp(params, "ecs", true))
    {
        if(PlayerData[playerid][pSpecialEffect] > 0)
            return SendErrorMessage(playerid, "You can use this drugs after %d minutes", PlayerData[playerid][pSpecialEffect]);
            
        if(Inventory_Count(playerid, "Ecstasy") < 1)
            return SendErrorMessage(playerid, "You need at least 1 grams of ecstasy.");

        if(Drug_Checking(playerid) == -1)
            return 1;

        SetPlayerDrugTime(playerid, 5);
        SetPlayerConsumeDrug(playerid, true);
        SetPlayerDrugType(playerid, e_DRUG_ECS);

        Inventory_Remove(playerid, "Ecstasy", 1);

        ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:forcedrug(playerid, params[])
{
    new targetid;

    if (CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    if(sscanf(params, "u", targetid))
        return SendSyntaxMessage(playerid, "/forcedrug [playerid/name]");

    if(targetid == INVALID_PLAYER_ID)
        return SendErrorMessage(playerid, "ID player tidak valid!");

    if(!GetPlayerDrugeEffect(targetid))
        return SendErrorMessage(playerid, "Player tidak dalam efek obat-obatan!");

    ClearAnimations(targetid);

    SetPlayerDrunkLevel(targetid, 0);
    SetPlayerDrugeEffect(targetid, false);

    RealTime_SyncPlayerWorldTime(playerid);

    SetPlayerWeather(targetid, current_weather);
    ApplyAnimation(targetid, "ped", "getup_front", 4.1, 0, 0, 0, 0, 0, 1);

    SendServerMessage(playerid, "Efek obat-obatan "YELLOW"%s "WHITE"telah direset!", ReturnName(targetid, 0));
    return 1;
}

// Events
ptask Player_DrugMinuteUpdate[60000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;
    if(PlayerData[playerid][pSpecialEffect] > 0)
        SetPlayerDrugSpecial(playerid, PlayerData[playerid][pSpecialEffect]-1);

    if(GetPlayerDrugeEffect(playerid))
    {
        if(GetPlayerDrugeDyingTime(playerid))
        {
            SetPlayerDrugeDyingTime(playerid, GetPlayerDrugeDyingTime(playerid) - 1);

            if(!GetPlayerDrugeDyingTime(playerid))
            {
                ClearAnimations(playerid);

                SetPlayerDrunkLevel(playerid, 0);
                SetPlayerDrugeEffect(playerid, false);

                RealTime_SyncPlayerWorldTime(playerid);

                SetPlayerWeather(playerid, current_weather);

                ApplyAnimation(playerid, "ped", "getup_front", 4.1, 0, 0, 0, 0, 0, 1);
                SendServerMessage(playerid, "Efek dari obat-obatan telah pulih, kamu dapat beraktifitas kembali!");
            }
        }
    }
    return 1;
}
ptask Player_DrugUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;    
            
    if(GetPlayerDrugeEffect(playerid) && GetPlayerDrunkLevel(playerid) < 20000) {
        SetPlayerDrunkLevel(playerid, 30000);

        if(!GetPlayerAnimation(playerid, "CRACK", "crckdeth4")) {
            ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
        }
    }

    if(GetPlayerConsumeDrug(playerid))
    {
        if(!GetPlayerDrugTime(playerid))
        {
            ClearAnimations(playerid);

            switch(GetPlayerDrugType(playerid))
            {
                case e_DRUG_MARIJUANA:
                {
                    Drug_Effect(playerid);
                }
                case e_DRUG_HEROIN:
                {
                    SetPlayerDrugHeroin(playerid, GetPlayerDrugHeroin(playerid) + 1);

                    if(GetPlayerDrugHeroin(playerid) >= 5)
                    {
                        Drug_Effect(playerid);
                        SetPlayerDrugHeroin(playerid, 0);
                    }
                }
                case e_DRUG_COCAINE:
                {
                    SetPlayerDrugCocaine(playerid, GetPlayerDrugCocaine(playerid) + 1);

                    if(GetPlayerDrugCocaine(playerid) >= 5)
                    {
                        Drug_Effect(playerid);
                        SetPlayerDrugCocaine(playerid, 0);
                    }
                }
                case e_DRUG_LSD:
                {
                    SetPlayerDrugLSD(playerid, GetPlayerDrugLSD(playerid) + 1);

                    if(GetPlayerDrugLSD(playerid) >= 1)
                    {
                        Drug_Effect(playerid, true, false);
                        SetPlayerDrugLSD(playerid, 0);
                    }
                }
                case e_DRUG_ECS:
                {
                    SetPlayerDrugECS(playerid, GetPlayerDrugEcstasy(playerid) + 1);

                    if(GetPlayerDrugEcstasy(playerid) >= 1)
                    {
                        Drug_Effect(playerid, false, true);
                        SetPlayerDrugECS(playerid, 0);
                    }
                }
            }

            SetPlayerConsumeDrug(playerid, false);
            SetPlayerDrugType(playerid, e_DRUG_NONE);

            ShowPlayerFooter(playerid, "Efek dari obat-obatan telah selesai ...");
        }
        else
        {
            SetPlayerDrugTime(playerid, GetPlayerDrugTime(playerid) - 1);

            if((GetPlayerDrugType(playerid) == e_DRUG_HEROIN || GetPlayerDrugType(playerid) == e_DRUG_COCAINE || GetPlayerDrugType(playerid) == e_DRUG_LSD || GetPlayerDrugType(playerid) == e_DRUG_ECS) && GetHealth(playerid) <= 90) {
                SetHealth(playerid, GetHealth(playerid) + 3.0);
            }

            ShowPlayerFooter(playerid, "Kamu sedang menikmati konsumsi obat-obatan ...");
        }
    }
    return 1;
}

// hook OnPlayerLogin(playerid)
// {
//     if(GetPlayerDrugeEffect(playerid)) 
//     {
//         Drug_Effect(playerid);
//     }
// }

// Functions
SetPlayerDrugeEffect(playerid, value)
{
    playerDrugDyingEffect[playerid] = value;
    UpdateCharacterInt(playerid, "DrugEffect", value);
    return 1;
}

SetPlayerDrugHeroin(playerid, value)
{
    playerUseDrugHeroin[playerid] = value;
    UpdateCharacterInt(playerid, "DrugHeroin", value);
    return 1;
}

SetPlayerDrugCocaine(playerid, value)
{
    playerUseDrugCocaine[playerid] = value;
    UpdateCharacterInt(playerid, "DrugCocaine", value);
    return 1;
}


SetPlayerDrugLSD(playerid, value)
{
    playerUseDrugLSD[playerid] = value;
    UpdateCharacterInt(playerid, "DrugLSD", value);
    return 1;
}

SetPlayerDrugECS(playerid, value)
{
    playerUseDrugEcstasy[playerid] = value;
    UpdateCharacterInt(playerid, "DrugEcstasy", value);
    return 1;
}

SetPlayerDrugSpecial(playerid, value)
{
    PlayerData[playerid][pSpecialEffect] = value;
    UpdateCharacterInt(playerid, "DrugSpecialEffect", value);
    return 1;
}

Drug_Effect(playerid, bool:lsd = false, bool:ecs = false)
{
    if(!lsd && !ecs)
    {
        SetPlayerDrugeEffect(playerid, true);
        SetPlayerDrugeDyingTime(playerid, 1);

        SetPlayerDrunkLevel(playerid, 30000);

        ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

        SetPlayerWeather(playerid, 68);
        SetPlayerTime(playerid, 12, 12);

        SendServerMessage(playerid, "Kamu kena efek obat-obatan, ini akan terjadi selama "YELLOW"1 menit "WHITE"kedepan!");
    }

    if(lsd)
    {
        SetPlayerDrugeEffect(playerid, true);
        SetPlayerDrugeDyingTime(playerid, 1);

        SetPlayerDrunkLevel(playerid, 30000);

        ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

        SetPlayerWeather(playerid, 68);
        SetPlayerTime(playerid, 12, 12);

        SetPlayerDrugSpecial(playerid, 15);

        SendServerMessage(playerid, "Kamu kena efek obat-obatan, ini akan terjadi selama "YELLOW"1 menit "WHITE"kedepan!, efek samping berlangsung 15 menit");
    }

    if(ecs)
    {
        SetPlayerDrugeEffect(playerid, true);
        SetPlayerDrugeDyingTime(playerid, 1);

        SetPlayerDrunkLevel(playerid, 30000);

        ApplyAnimation(playerid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

        SetPlayerWeather(playerid, 68);
        SetPlayerTime(playerid, 12, 12);

        SetPlayerDrugSpecial(playerid, 30);

        SendServerMessage(playerid, "Kamu kena efek obat-obatan, ini akan terjadi selama "YELLOW"1 menit "WHITE"kedepan!, efek samping berlangsung 30 menit");
    }
    return 1;
}

Drug_Checking(playerid, bool:marijuana = false)
{
    new Float:armour = GetArmour(playerid);

    if(armour >= 50) {

        ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P" , 4.1, 0, 0, 0, 0, 0, 1);
        PlayerPlaySoundEx(playerid, 7879);
        SetArmour(playerid, 50);

        SetPlayerHunger(playerid, PlayerData[playerid][pHunger] - 10);
        SendServerMessage(playerid, "Kamu muntah akibat overdosis penggunaan obat-obatan, energi berkurang "ORANGE"10 persen!");
        return -1;
    }

    SetArmour(playerid, (armour + (marijuana ? (20) : (10))));

    if(armour >= 50) SetArmour(playerid, 50);
    return 1;
}