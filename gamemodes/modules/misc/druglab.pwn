#define SetCookingTime(%0,%1)		SetPVarInt(%0, "CookingTime", %1)
#define GetCookingTime(%0)			GetPVarInt(%0, "CookingTime")

#define IsCookingDrug(%0)		    GetPVarInt(%0, "CookingStart")
#define SetCookingDrug(%0,%1)	    SetPVarInt(%0, "CookingStart", %1)

#define SetCookingType(%0,%1)		SetPVarInt(%0, "CookingType", %1)
#define GetCookingType(%0)			GetPVarInt(%0, "CookingType")

#define RANDOM_PRICE 4
#define MAX_LAB (3)

new drugSellType[MAX_PLAYERS];

new Player_InsideLab[MAX_PLAYERS] = {-1, ...};

enum E_DRUGLAB
{
    LabStatus,
    LabArea,
    Float:LabHealth,
    LabRespawnTime,
    Text3D:LabText,
    LabPickup,
    LabDestroyed,
};
new DrugLab[MAX_LAB][E_DRUGLAB];

enum E_DRUGLAB_LOC
{
    Float:LabPosX,
    Float:LabPosY,
    Float:LabPosZ
};
new DrugLabLoc[MAX_LAB][E_DRUGLAB_LOC] = {
    {2350.9465,-648.0103,128.0547},
    {-1630.2352,-2238.9636,31.4766},
    {-753.9861,-132.3419,65.8281}
};
enum
{
	COOKING_NONE = 0,
	COOKING_LSD,
    COOKING_ECS
}

LoadStaticLab()
{
    new count = 0;
    for(new i = 0; i < MAX_LAB; i++)
    {
        new string[1024];
        DrugLab[i][LabHealth] = 1000.00;
        DrugLab[i][LabRespawnTime] = 0;
        DrugLab[i][LabDestroyed] = 0;
        DrugLab[i][LabPickup] = CreateDynamicPickup(1239, 23, DrugLabLoc[i][LabPosX], DrugLabLoc[i][LabPosY], DrugLabLoc[i][LabPosZ], 0, 0);
        format(string, sizeof(string), "[Drug Lab]\n[Table Health : %.2f]\n"WHITE"Gunakan "YELLOW"/cookdrugs"WHITE" untuk memulai membuat drug", DrugLab[i][LabHealth]);
        DrugLab[i][LabText] = CreateDynamic3DTextLabel(string, COLOR_CLIENT, DrugLabLoc[i][LabPosX], DrugLabLoc[i][LabPosY], DrugLabLoc[i][LabPosZ]+0.5, 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
        DrugLab[i][LabArea] = CreateDynamicCylinder(DrugLabLoc[i][LabPosX], DrugLabLoc[i][LabPosY], DrugLabLoc[i][LabPosZ] - 1.0, DrugLabLoc[i][LabPosZ] + 3.0, 10.0);
        

        new Druglab_Streamer[2]; 
        Druglab_Streamer[0] = DRUGLAB_AREA_INDEX;
        Druglab_Streamer[1] = i;
        Streamer_SetArrayData(STREAMER_TYPE_AREA, DrugLab[i][LabArea], E_STREAMER_EXTRA_ID, Druglab_Streamer);
        count++;
    }
    printf("Created %d drug lab", count);
}

UpdateStaticLab(index)
{
    new string[1024];
    if(IsValidDynamic3DTextLabel(DrugLab[index][LabText]))
    {
        new minute = DrugLab[index][LabRespawnTime]/60;
        if(DrugLab[index][LabHealth] > 0) format(string, sizeof(string), "[Drug Lab]\n[Table Health : %.2f]\n"WHITE"Gunakan "YELLOW"/cookdrugs"WHITE" untuk memulai membuat drug", DrugLab[index][LabHealth]);
        else if(DrugLab[index][LabHealth] <= 0) format(string, sizeof(string), "[Drug Lab]\n\n"RED"Destroyed\nRespawn in %d Minute", minute);
        UpdateDynamic3DTextLabelText(DrugLab[index][LabText], COLOR_CLIENT, string);
    }
    return 1;
}

ResetStaticDrugLab(index)
{
    DrugLab[index][LabHealth] = 1000;
    DrugLab[index][LabDestroyed] = 0;
    DrugLab[index][LabRespawnTime] = 0;
    UpdateStaticLab(index);
    return 1;
}

ptask Player_ShootingLab[500](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;

    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if((keys & KEY_FIRE))
    {
        new index = Lab_GetInside(playerid);
        if(index != -1)
        {
            if(GetPlayerWeapon(playerid) >= 22 && GetPlayerWeapon(playerid) <= 34)
            {
                if(IsPlayerInRangeOfPoint(playerid, 5.0, DrugLabLoc[index][LabPosX], DrugLabLoc[index][LabPosY], DrugLabLoc[index][LabPosZ]))
                {
                    if(!DrugLab[index][LabDestroyed])
                    {
                        DrugLab[index][LabHealth] -= 25.0;
                        if(DrugLab[index][LabHealth] <= 0)
                        {
                            DrugLab[index][LabHealth] = 0;
                            DrugLab[index][LabRespawnTime] = 14400; // 14400
                            DrugLab[index][LabDestroyed] = 1;
                            Fire_Create(18690, DrugLabLoc[index][LabPosX], DrugLabLoc[index][LabPosY], DrugLabLoc[index][LabPosZ], 0, 0);
                        }
                        UpdateStaticLab(index);
                    }
                }
            }
        }
    }
    return 1;
}

hook OnGameModeInitEx()
{
    LoadStaticLab();
}

Near_DropOff()
{
    // if(IsPlayerInRangeOfPoint(playerid, 5.0, 1028.7078,-1103.4530,23.8281) || IsPlayerInRangeOfPoint(playerid, 5.0, 1095.4104,-1875.3322,13.5469) || IsPlayerInRangeOfPoint(playerid, 5.0, 386.8400,-1879.9895,2.6761) || IsPlayerInRangeOfPoint(playerid, 5.0, -31.2202,-1118.0354,1.0781))
    // {
    //     return 1;
    // }
    return 0;
}
hook OnPlayerEnterDynArea(playerid, areaid)
{
    new Druglab_Streamer[2];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, Druglab_Streamer);

    if(Druglab_Streamer[0] == DRUGLAB_AREA_INDEX)
    {
        new i = Druglab_Streamer[1];
       	Lab_SetInside(playerid, i);
    }
}

hook OnPlayerLeaveDynArea(playerid, areaid)
{
	new Druglab_Streamer[1];
    Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, Druglab_Streamer);

    if(Druglab_Streamer[0] == DRUGLAB_AREA_INDEX) 
    {
    	if(IsCookingDrug(playerid))
        {
            Cooking_Reset(playerid);
        }
    	Lab_SetInside(playerid, -1);
    }
}

Lab_GetInside(playerid)
{
    return Player_InsideLab[playerid];
}

Lab_SetInside(playerid, index)
{
    Player_InsideLab[playerid] = index;
    return 1;
}

Cooking_Reset(playerid, bool:anim = true)
{
    new index = Lab_GetInside(playerid);
	SetCookingDrug(playerid, 0);
	SetCookingTime(playerid, 0);
	SetCookingType(playerid, 0);
    ReduceCooker(index);
	if(anim) ClearAnimations(playerid);
    return 1;
}

ReduceCooker(index)
{
    if(index != -1)
    {
        DrugLab[index][LabStatus]--;
        if(DrugLab[index][LabStatus] <= 0)
        {
            DrugLab[index][LabStatus] = 0;
        }
        return 1;
    }
    return 0;
}

Near_DrugLab(playerid, index)
{
    if(index != -1)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, DrugLabLoc[index][LabPosX], DrugLabLoc[index][LabPosY], DrugLabLoc[index][LabPosZ]))
        {      
            if(DrugLab[index][LabStatus] != 3)
            {
                DrugLab[index][LabStatus]++;
                return 1;
            }
            else
            {
                SendErrorMessage(playerid, "There is a person using the table currently!");
                return 0;
            }
        }
    }
    return 0;
}
CMD:selldrugs(playerid, params[])
{
    if(Near_DropOff()) //Cari kordinat dulu
    {
        new 
            string[128],
            npc_lsd_price,
            npc_ecs_price
        ;
        if(GetFactionType(playerid) == FACTION_GANG)
        {
            npc_lsd_price = ServerData[lsd_price];
            npc_ecs_price = ServerData[ecs_price];
        }
        else
        {
            npc_lsd_price = (ServerData[lsd_price]*50)/100;
            npc_ecs_price = (ServerData[ecs_price]*50)/100;
        }
        strcat(string, "Drug Name\tSell Price\n");
        strcat(string, sprintf("LSD\t$%d\n", npc_lsd_price));
        strcat(string, sprintf("Ecstasy\t$%d\n", npc_ecs_price));
        
        Dialog_Show(playerid, SellDrugs, DIALOG_STYLE_TABLIST_HEADERS, "Drugs Dealer", string, "Sell", "Close");
    }
    else SendErrorMessage(playerid, "You're not near drugs dealer!");
    return 1;
}

CMD:stopcooking(playerid, params[])
{
    if(IsCookingDrug(playerid))
    {
        Cooking_Reset(playerid);
    }
    else
    {
        SendErrorMessage(playerid, "You're not cooking any drugs!");
    }
    return 1;
}
CMD:cookdrugs(playerid, params[])
{
    new playerState = GetPlayerState(playerid);
    new index = Lab_GetInside(playerid);

    if(playerState != PLAYER_STATE_ONFOOT)
        return SendErrorMessage(playerid, "You need to stand on foot to use this command");

    if(index == -1)
        return SendErrorMessage(playerid, "You are not near any druglab!");

    new minute = DrugLab[index][LabRespawnTime]/60;
    if(DrugLab[index][LabDestroyed])
        return SendErrorMessage(playerid, "Lab is destroyed!, wait %d minutes until it respawn", minute);

    if(Near_DrugLab(playerid, index)) //Ngecheck posisi player, kalo di lokasi di count ++ ketika buka dialog.
    { 
        if(IsCookingDrug(playerid)) 
        {
            Cooking_Reset(playerid);
        }
        new string[128];
        strcat(string, "Drug Name\tRequirement\n");
        strcat(string, sprintf("LSD\t3 Marijuana\n"));
        strcat(string, sprintf("Ecstasy\t5 Cocaine\n"));
        Dialog_Show(playerid, CookDrugs, DIALOG_STYLE_TABLIST_HEADERS, "Drug Table", string, "Cook", "Close");
        cmd_ame(playerid, "is accessing drugs table.");
    }
    return 1;
}
Dialog:SellDrugs(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                drugSellType[playerid] = 0;
                Dialog_Show(playerid, SellDrugsConfirm, DIALOG_STYLE_INPUT, "Drugs Dealer", "Berapa jumlah yang ingin kamu jual ? ", "Sell", "Close");
                
            }
            case 1:
            {
                drugSellType[playerid] = 1;
                Dialog_Show(playerid, SellDrugsConfirm, DIALOG_STYLE_INPUT, "Drugs Dealer", "Berapa jumlah yang ingin kamu jual ? ", "Sell", "Close");
                
            }
        }
    }
    return 1;
}
Dialog:SellDrugsConfirm(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(drugSellType[playerid])
        {
            case 0:
            {
                new price;

                if(GetFactionType(playerid) == FACTION_GANG) price = ServerData[lsd_price];
                else price = (ServerData[lsd_price]*50)/100;

                if(strval(inputtext) < 0 || strval(inputtext) > 100000) return Dialog_Show(playerid, SellDrugsConfirm, DIALOG_STYLE_INPUT, "Drugs Dealer", "Berapa jumlah yang ingin kamu jual ? ", "Sell", "Close");
                if(Inventory_Count(playerid, "LSD") < strval(inputtext))
                    return SendErrorMessage(playerid, "Anda tidak mempunyai drugs sebanyak itu !"); 

                Inventory_Remove(playerid, "LSD", strval(inputtext));
                SendClientMessageEx(playerid, COLOR_WHITE, "Kamu telah menjual LSD sebanyak %d dengan harga total "GREEN"%s", strval(inputtext), FormatNumber(price*strval(inputtext)));
                GiveMoney(playerid, price*strval(inputtext), ECONOMY_TAKE_SUPPLY, "sell LSD");
            }
            case 1:
            {
                new price;
                if(GetFactionType(playerid) == FACTION_GANG) price = ServerData[ecs_price];
                else price = (ServerData[ecs_price]*50)/100;

                if(strval(inputtext) < 0 || strval(inputtext) > 100000) return Dialog_Show(playerid, SellDrugsConfirm, DIALOG_STYLE_INPUT, "Drugs Dealer", "Berapa jumlah yang ingin kamu jual ? ", "Sell", "Close");
                if(Inventory_Count(playerid, "Ecstasy") < strval(inputtext))
                    return SendErrorMessage(playerid, "Anda tidak mempunyai drugs sebanyak itu !");

                Inventory_Remove(playerid, "Ecstasy", strval(inputtext));
                SendClientMessageEx(playerid, COLOR_WHITE, "Kamu telah menjual Ecstasy sebanyak %d dengan harga total "GREEN"%s", strval(inputtext), FormatNumber(price*strval(inputtext)));
                GiveMoney(playerid, price*strval(inputtext), ECONOMY_TAKE_SUPPLY, "sell ecstasy");
            }
        }
    }
    return 1;
}
Dialog:CookDrugs(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                new time = 60;
                if(Inventory_Count(playerid, "Marijuana") < 3)
                    return SendErrorMessage(playerid, "You need at least 3 grams of marijuana."), Cooking_Reset(playerid);

                SetCookingTime(playerid, time);

                SetCookingDrug(playerid, 1);
                SetCookingType(playerid, COOKING_LSD);
                SendServerMessage(playerid, "Mulai membuat drugs jenis LSD");
                ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
				ShowPlayerFooter(playerid, sprintf("Membuat drugs jenis ~y~LSD ~g~%d detik ~w~lagi... (/stopcooking untuk berhenti)", GetCookingTime(playerid)), 1000);
                GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
            }
            case 1:
            {
                new time = 60;
                if(Inventory_Count(playerid, "Cocaine") < 5)
                    return SendErrorMessage(playerid, "You need at least 5 grams of cocaine."), Cooking_Reset(playerid);

                SetCookingTime(playerid, time);
                SetCookingDrug(playerid, 1);
                SetCookingType(playerid, COOKING_ECS);
                SendServerMessage(playerid, "Mulai membuat drugs jenis Ecstasy");
                ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
				ShowPlayerFooter(playerid, sprintf("Membuat drugs jenis ~y~Ecstasy ~g~%d detik ~w~lagi... (/stopcooking untuk berhenti)", GetCookingTime(playerid)), 1000);
                GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);
            }
        }
    }
    else Cooking_Reset(playerid);
    return 1;
}
hook OnPlayerConnect(playerid)
{
    drugSellType[playerid] = -1;
}
hook OnPlayerDisconnect(playerid, reason)
{
    drugSellType[playerid] = -1;
    if(IsCookingDrug(playerid))
    {
        Cooking_Reset(playerid);
    }
}
ptask Player_DruglabUpdate[1000](playerid)
{
    if((!PlayerData[playerid][pLogged]) || !PlayerData[playerid][pCreated] || PlayerData[playerid][pKicked])
        return 0;    
            
	if(IsCookingDrug(playerid))
	{
		switch(GetCookingType(playerid))
		{
			case COOKING_LSD:
			{
				if(GetCookingTime(playerid))
				{
					SetCookingTime(playerid, GetCookingTime(playerid) - 1);
					if(GetCookingTime(playerid))
					{
                        new playerState = GetPlayerState(playerid);
                        if(playerState != PLAYER_STATE_ONFOOT)
                            return ShowPlayerFooter(playerid, "Gagal membuat drugs, kamu tidak sedang berdiri!", 3000, 1), Cooking_Reset(playerid);

                        if(!IsPlayerInRangeOfPoint(playerid, 0.5, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]))
							return ShowPlayerFooter(playerid, "Gagal membuat drugs, karna kamu bergerak ketika memasak!", 3000, 1), Cooking_Reset(playerid);
                        
                        ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Membuat drugs jenis ~y~LSD ~g~%d detik ~w~lagi... (/stopcooking untuk berhenti)", GetCookingTime(playerid)), 1000);
                    }
                    else
                    {
                        if(Inventory_Count(playerid, "Marijuana") < 3)
                            return SendErrorMessage(playerid, "You need at least 5 grams of Marijuana."), Cooking_Reset(playerid);

                        Inventory_Remove(playerid, "Marijuana", 3);
                        Inventory_Add(playerid, "LSD", 1);

                        GameTextForPlayer(playerid, "~w~Cooking ~g~Finished!", 3000, 6);
						SendServerMessage(playerid, "Sukses membuat "YELLOW"LSD "WHITE"drugs type!");
						
						Cooking_Reset(playerid);
                    }
                }

            }
            case COOKING_ECS:
            {
				if(GetCookingTime(playerid))
				{
					SetCookingTime(playerid, GetCookingTime(playerid) - 1);
					if(GetCookingTime(playerid))
					{
                        new playerState = GetPlayerState(playerid);
                        if(playerState != PLAYER_STATE_ONFOOT)
                            return ShowPlayerFooter(playerid, "Gagal membuat drugs, kamu tidak sedang berdiri!", 3000, 1), Cooking_Reset(playerid);

                        if(!IsPlayerInRangeOfPoint(playerid, 0.5, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]))
							return ShowPlayerFooter(playerid, "Gagal membuat drugs, karna kamu bergerak ketika memasak!", 3000, 1), Cooking_Reset(playerid);

                        ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 1, 0, 1);
						ShowPlayerFooter(playerid, sprintf("Membuat drugs jenis ~y~Ecstasy ~g~%d detik ~w~lagi... (/stopcooking untuk berhenti)", GetCookingTime(playerid)), 1000);
                    }
                    else
                    {
                        if(Inventory_Count(playerid, "Cocaine") < 5)
                            return SendErrorMessage(playerid, "You need at least 5 grams of cocaine."), Cooking_Reset(playerid);

                        Inventory_Remove(playerid, "Cocaine", 5);
                        Inventory_Add(playerid, "Ecstasy", 1);

                        GameTextForPlayer(playerid, "~w~Cooking ~g~Finished!", 3000, 6);
						SendServerMessage(playerid, "Sukses membuat "YELLOW"Ecstasy "WHITE"drugs type!");
						
						Cooking_Reset(playerid);
                    }
                }
            }
        }
    }
    return 1;
}
task Druglab_Reset[3600000]()
{
    for(new i = 0; i<MAX_LAB; i++)
    {
        if(DrugLab[i][LabStatus] >= 3)
        {
            DrugLab[i][LabStatus] = 0;
        }
    }
    return 1;
}

CMD:resetdruglab(playerid, params[])
{
    if(CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    for(new i = 0; i<MAX_LAB; i++)
    {
        DrugLab[i][LabStatus] = 0;
        ResetStaticDrugLab(i);
        // DrugLab[i][LabDestroyed] = 0;
        // DrugLab[i][LabHealth] = 1000.0;
        // DrugLab[i][LabRespawnTime] = 0;
        // UpdateStaticLab(i);
    }

    SendAdminMessage(X11_TOMATO_1, "Admin: %s has reset drug lab amount of drug lab user!", ReturnName(playerid));
    SendAdminMessage(X11_TOMATO_1, "Current Drug-Lab User (( LAB-1 : %d || LAB-2 : %d || LAB-3 : %d ))", DrugLab[0][LabStatus], DrugLab[2][LabStatus], DrugLab[1][LabStatus]);
    return 1;
}

task DrugLab_Respawn[1000]()
{
    for(new i = 0; i<MAX_LAB; i++)
    {
        if(DrugLab[i][LabDestroyed])
        {
            DrugLab[i][LabRespawnTime]--;
            UpdateStaticLab(i);
            if(DrugLab[i][LabRespawnTime] <= 0)
            {
                DrugLab[i][LabRespawnTime] = 0;
                ResetStaticDrugLab(i);
            }
        }
    }
    return 1;
}
