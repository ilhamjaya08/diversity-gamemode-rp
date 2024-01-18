#include <YSI\y_hooks>

new
		tick_CrouchKey[MAX_PLAYERS],
Timer:	SitDownTimer[MAX_PLAYERS];

forward Float:GetPlayerTotalVelocity(playerid);
Float:GetPlayerTotalVelocity(playerid)
{
    if(!SQL_IsLogged(playerid))
        return 0.0;

    new Float:velocity,
        Float:vx,
        Float:vy,
        Float:vz;

    GetPlayerVelocity(playerid, vx, vy, vz);
    velocity = floatsqroot( (vx*vx)+(vy*vy)+(vz*vz) ) * 150.0;

    return velocity;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

	if(!IsPlayerInAnyVehicle(playerid))
	{
		if(GetPlayerTotalVelocity(playerid) == 0.0)
		{
			if(newkeys == KEY_CROUCH)
			{
				tick_CrouchKey[playerid] = GetTickCount();
				SitDownTimer[playerid] = defer SitDown(playerid);
			}

			if(oldkeys == KEY_CROUCH)
			{
				if(GetTickCountDifference(GetTickCount(), tick_CrouchKey[playerid]) < 250)
				{
					stop SitDownTimer[playerid];
				}
			}

			if(newkeys & KEY_SPRINT && newkeys & KEY_CROUCH)
			{
				if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_HANDSUP)
				{
					ClearAnimations(playerid);
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				}
				else
				{
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
				}
			}
		}
		if(newkeys & KEY_CROUCH || newkeys & KEY_SPRINT || newkeys & KEY_JUMP)
		{
			if(GetPlayerAnimationIndex(playerid) == 43 || GetPlayerAnimationIndex(playerid) == 1497)
			{
				ApplyAnimation(playerid, "SUNBATHE", "PARKSIT_M_OUT", 4.0, 0, 0, 0, 0, 0);
			}
		}
		if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
		{
			if(random(100) < 60)
				ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
		}
	}
}

timer SitDown[800](playerid)
{
	ApplyAnimation(playerid, "SUNBATHE", "PARKSIT_M_IN", 4.0, 0, 0, 0, 0, 0);
	defer SitLoop(playerid);
}

timer SitLoop[1900](playerid)
{
	ApplyAnimation(playerid, "BEACH", "PARKSIT_M_LOOP", 4.0, 1, 0, 0, 0, 0);
}

CMD:animlist(playerid, params[]) {
    return cmd_animhelp(playerid, "");
}

CMD:animhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_CLIENT, "ANIMATION:"WHITE" /dance, /handsup, /bat, /slap, /bar, /wash, /lay, /workout, /blowjob, /bomb.");
    SendClientMessage(playerid, COLOR_CLIENT, "ANIMATION:"WHITE" /carry, /crack, /sleep, /jump, /deal, /dancing, /eating, /puke, /gsign, /chat.");
    SendClientMessage(playerid, COLOR_CLIENT, "ANIMATION:"WHITE" /goggles, /spray, /throw, /swipe, /office, /kiss, /knife, /cpr, /scratch, /point.");
    SendClientMessage(playerid, COLOR_CLIENT, "ANIMATION:"WHITE" /cheer, /wave, /strip, /smoke, /reload, /taichi, /wank, /cower, /drunk.");
    SendClientMessage(playerid, COLOR_CLIENT, "ANIMATION:"WHITE" /cry, /tired, /sit, /crossarms, /fucku, /walk, /piss, /slapass, /flap, /anim [1-167].");
	SendClientMessage(playerid, COLOR_CLIENT, "ANIMATION:"WHITE" /fall, /fallfront, /stopanim.");
    return 1;
}
// CMD:anim(playerid, params[])
// {
// 	new type;

// 	if(!AnimationCheck(playerid))
// 		return SendErrorMessage(playerid, "You can't perform animation at the moment.");

// 	if(sscanf(params, "d", type))
// 		return SendSyntaxMessage(playerid, "/anim [1-167]");

// 	if(type < 1 || type > 167)
// 		return SendSyntaxMessage(playerid, "Invalid type specified");

// 	switch(type)
// 	{			
// 		case 1	  : ApplyAnimationEx(playerid, "COP_AMBIENT", "COPLOOK_WATCH", 4.0, 1, 0, 0, 0, 0, 1); // watch							
// 		case 2	  : ApplyAnimationEx(playerid, "COP_AMBIENT", "COPLOOK_THINK", 4.0, 1, 0, 0, 0, 0, 1); // think							
// 		case 3	  : ApplyAnimationEx(playerid, "ATTRACTORS", "STEPSIT_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // 							
// 		case 4	  : ApplyAnimationEx(playerid, "ATTRACTORS", "STEPSIT_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // /sit							
// 		case 5	  : ApplyAnimationEx(playerid, "ATTRACTORS", "STEPSIT_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // /sit 7							
// 		case 6	  : ApplyAnimationEx(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // Bom							
// 		case 7	  : ApplyAnimationEx(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // 							
// 		case 8	  : ApplyAnimationEx(playerid, "BOMBER", "BOM_PLANT_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // Tire							
// 		case 9	  : ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_DEF_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // Basket 1							
// 		case 10	  : ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_IDLE", 4.0, 1, 0, 0, 0, 0, 1); // Basket 2							
// 		case 11	  : ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_IDLE2", 4.0, 1, 0, 0, 0, 0, 1); // Basket 3							
// 		case 12	  : ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_IDLELOOP", 4.0, 1, 0, 0, 0, 0, 1); // basketball 5							
// 		case 13	  : ApplyAnimationEx(playerid, "BSKTBALL", "BBALL_REACT_SCORE", 4.0, 1, 0, 0, 0, 0, 1); // basketball 6							
// 		case 14	  : ApplyAnimationEx(playerid, "CAMERA", "CAMCRCH_IDLELOOP", 4.0, 1, 0, 0, 0, 0, 1); // camera 1							
// 		case 15	  : ApplyAnimationEx(playerid, "CAMERA", "CAMSTND_CMON", 4.0, 1, 0, 0, 0, 0, 1); // camera 2							
// 		case 16	  : ApplyAnimationEx(playerid, "CAMERA", "CAMSTND_IDLELOOP", 4.0, 1, 0, 0, 0, 0, 1); // camera 3							
// 		case 17	  : ApplyAnimationEx(playerid, "CAMERA", "CAMSTND_LKABT", 4.0, 1, 0, 0, 0, 0, 1); // camera 4							
// 		case 18	  : ApplyAnimationEx(playerid, "CAMERA", "PICCRCH_TAKE", 4.0, 1, 0, 0, 0, 0, 1); // camera 5							
// 		case 19	  : ApplyAnimationEx(playerid, "CAMERA", "PICSTND_TAKE", 4.0, 1, 0, 0, 0, 0, 1); // camera 6							
// 		case 20	  : ApplyAnimationEx(playerid, "CASINO", "MANWIND", 4.0, 1, 0, 0, 0, 0, 1); // win 1							
// 		case 21	  : ApplyAnimationEx(playerid, "CASINO", "MANWINB", 4.0, 1, 0, 0, 0, 0, 1); // win 2							
// 		case 22	  : ApplyAnimationEx(playerid, "CASINO", "ROULETTE_BET", 4.0, 1, 0, 0, 0, 0, 1); // table 1							
// 		case 23	  : ApplyAnimationEx(playerid, "CASINO", "ROULETTE_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // table 2							
// 		case 24	  : ApplyAnimationEx(playerid, "CASINO", "ROULETTE_LOSE", 4.0, 1, 0, 0, 0, 0, 1); // table 3							
// 		case 25	  : ApplyAnimationEx(playerid, "GRENADE", "WEAPON_THROW", 4.0, 1, 0, 0, 0, 0, 1); // Throw							
// 		case 26	  : ApplyAnimationEx(playerid, "COP_AMBIENT", "COPBROWSE_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // cop 1							
// 		case 27	  : ApplyAnimationEx(playerid, "COP_AMBIENT", "COPBROWSE_NOD", 4.0, 1, 0, 0, 0, 0, 1); // cop 2							
// 		case 28	  : ApplyAnimationEx(playerid, "COP_AMBIENT", "COPLOOK_WATCH", 4.0, 1, 0, 0, 0, 0, 1); // watch 1							
// 		case 29	  : ApplyAnimationEx(playerid, "COP_AMBIENT", "COPLOOK_NOD", 4.0, 1, 0, 0, 0, 0, 1); // watch 2							
// 		case 30	  : ApplyAnimationEx(playerid, "CRACK", "BBALBAT_IDLE_01", 4.0, 1, 0, 0, 0, 0, 1); // bat stand 1							
// 		case 31	  : ApplyAnimationEx(playerid, "CRACK", "BBALBAT_IDLE_02", 4.0, 1, 0, 0, 0, 0, 1); // bat stand 2							
// 		case 32	  : ApplyAnimationEx(playerid, "DILDO", "DILDO_IDLE", 4.0, 1, 0, 0, 0, 0, 1); // dildo stand							
// 		case 33	  : ApplyAnimationEx(playerid, "FAT", "FATIDLE_ROCKET", 4.0, 1, 0, 0, 0, 0, 1); // rocket stand							
// 		case 34	  : ApplyAnimationEx(playerid, "FAT", "FATIDLE_CSAW", 4.0, 1, 0, 0, 0, 0, 1); // chainsaw stand							
// 		case 35	  : ApplyAnimationEx(playerid, "FIGHT_C", "FIGHTC_IDLE", 4.0, 1, 0, 0, 0, 0, 1); // fight stand							
// 		case 36	  : ApplyAnimationEx(playerid, "FIGHT_B", "FIGHTB_IDLE", 4.0, 1, 0, 0, 0, 0, 1); // fight 1 stand							
// 		case 37	  : ApplyAnimationEx(playerid, "FIGHT_D", "FIGHTD_IDLE", 4.0, 1, 0, 0, 0, 0, 1); // fight 2 stand							
// 		case 38	  : ApplyAnimationEx(playerid, "FIGHT_C", "FIGHTC_IDLE", 4.0, 1, 0, 0, 0, 0, 1); // fight 3 stand							
// 		case 39	  : ApplyAnimationEx(playerid, "AIRPORT", "THRW_BARL_THRW", 4.0, 1, 0, 0, 0, 0, 1); // 							
// 		case 40	  : ApplyAnimationEx(playerid, "ATTRACTORS", "STEPSIT_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // sit 7							
// 		case 41	  : ApplyAnimationEx(playerid, "BAR", "BARCUSTOM_ORDER", 4.0, 1, 0, 0, 0, 0, 1); // bar8							
// 		case 42	  : ApplyAnimationEx(playerid, "JST_BUISNESS", "GIRL_02", 4.0, 1, 0, 0, 0, 0, 1); // leadis sit							
// 		case 43	  : ApplyAnimationEx(playerid, "LOWRIDER", "F_SMKLEAN_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // lean 1							
// 		case 44	  : ApplyAnimationEx(playerid, "BD_FIRE", "BD_PANIC_01", 4.0, 1, 0, 0, 0, 0, 1); // panic1							
// 		case 45	  : ApplyAnimationEx(playerid, "BD_FIRE", "BD_PANIC_02", 4.0, 1, 0, 0, 0, 0, 1); // panic2							
// 		case 46	  : ApplyAnimationEx(playerid, "BD_FIRE", "BD_PANIC_03", 4.0, 1, 0, 0, 0, 0, 1); // panic3							
// 		case 47	  : ApplyAnimationEx(playerid, "LOWRIDER", "RAP_A_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // rapper 1							
// 		case 48	  : ApplyAnimationEx(playerid, "LOWRIDER", "RAP_B_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // rapper 2							
// 		case 49	  : ApplyAnimationEx(playerid, "LOWRIDER", "RAP_C_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // rapper 3							
// 		case 50	  : ApplyAnimationEx(playerid, "MISC", "PLYRLEAN_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // lean 2							
// 		case 51	  : ApplyAnimationEx(playerid, "MISC", "PLYR_SHKHEAD", 4.0, 1, 0, 0, 0, 0, 1); // shake head							
// 		case 52	  : ApplyAnimationEx(playerid, "ON_LOOKERS", "LKAROUND_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // look 1							
// 		case 53	  : ApplyAnimationEx(playerid, "ON_LOOKERS", "LKUP_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // look 2							
// 		case 54	  : ApplyAnimationEx(playerid, "ON_LOOKERS", "PANIC_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // look 3							
// 		case 55	  : ApplyAnimationEx(playerid, "AIRPORT", "THRW_BARL_THRW", 4.0, 1, 0, 0, 0, 0, 1); // Geser							
// 		case 56	  : ApplyAnimationEx(playerid, "OTB", "WTCHRACE_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // race crossarms							
// 		case 57	  : ApplyAnimationEx(playerid, "OTB", "BETSLP_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // write stand							
// 		case 58	  : ApplyAnimationEx(playerid, "SWIM", "SWIM_JUMPOUT", 4.0, 1, 0, 0, 0, 0, 1); // /anim 1							
// 		case 59	  : ApplyAnimationEx(playerid, "ATTRACTORS", "THRW_BARL_THRW", 4.0, 1, 0, 0, 0, 0, 1); // 							
// 		case 60	  : ApplyAnimationEx(playerid, "SWIM", "SWIM_UNDER", 4.0, 1, 0, 0, 0, 0, 1); // /anim 2							
// 		case 61	  : ApplyAnimationEx(playerid, "BIKES", "BIKES_FWD", 4.0, 1, 0, 0, 0, 0, 1); // [keterangan]							
// 		case 62	  : ApplyAnimationEx(playerid, "PAULNMAC", "PNM_LOOP_A", 4.0, 1, 0, 0, 0, 0, 1); // drunk 1							
// 		case 63	  : ApplyAnimationEx(playerid, "PAULNMAC", "PNM_LOOP_B", 4.0, 1, 0, 0, 0, 0, 1); // drunk 2							
// 		case 64	  : ApplyAnimationEx(playerid, "AIRPORT", "THRW_BARL_THRW", 4.0, 1, 0, 0, 0, 0, 1); // THRW_BARL_THRW							
// 		case 65	  : ApplyAnimationEx(playerid, "PED", "FACANGER", 4.0, 1, 0, 0, 0, 0, 1); // face 1							
// 		case 66	  : ApplyAnimationEx(playerid, "PED", "FACGUM", 4.0, 1, 0, 0, 0, 0, 1); // face 2							
// 		case 67	  : ApplyAnimationEx(playerid, "PED", "FACSfrp", 4.0, 1, 0, 0, 0, 0, 1); // face 3							
// 		case 68	  : ApplyAnimationEx(playerid, "PED", "FACSfrpM", 4.0, 1, 0, 0, 0, 0, 1); // face 4							
// 		case 69	  : ApplyAnimationEx(playerid, "PED", "FACTALK", 4.0, 1, 0, 0, 0, 0, 1); // face 5							
// 		case 70	  : ApplyAnimationEx(playerid, "PED", "FACURIOS", 4.0, 1, 0, 0, 0, 0, 1); // face 6							
// 		case 71	  : ApplyAnimationEx(playerid, "PED", "IDLESTANCE_FAT", 4.0, 1, 0, 0, 0, 0, 1); // stance 1							
// 		case 72	  : ApplyAnimationEx(playerid, "PED", "IDLESTANCE_OLD", 4.0, 1, 0, 0, 0, 0, 1); // stance 2							
// 		case 73	  : ApplyAnimationEx(playerid, "PED", "IDLE_ARMED", 4.0, 1, 0, 0, 0, 0, 1); // stance 3							
// 		case 74	  : ApplyAnimationEx(playerid, "PED", "IDLE_GANG1", 4.0, 1, 0, 0, 0, 0, 1); // stance 4							
// 		case 75	  : ApplyAnimationEx(playerid, "PED", "IDLE_HBHB", 4.0, 1, 0, 0, 0, 0, 1); // stance 5							
// 		case 76	  : ApplyAnimationEx(playerid, "PED", "IDLE_STANCE", 4.0, 1, 0, 0, 0, 0, 1); // stance 6							
// 		case 77	  : ApplyAnimationEx(playerid, "PED", "IDLE_TAXI", 4.0, 1, 0, 0, 0, 0, 1); // taxi							
// 		case 78	  : ApplyAnimationEx(playerid, "CAMERA", "CAMCRCH_CMON", 4.0, 1, 0, 0, 0, 0, 1); // camera1							
// 		case 79	  : ApplyAnimationEx(playerid, "CAMERA", "CAMCRCH_IDLELOOP", 4.0, 1, 0, 0, 0, 0, 1); // camera2							
// 		case 80	  : ApplyAnimationEx(playerid, "PED", "ROADCROSS", 4.0, 1, 0, 0, 0, 0, 1); // roadcross							
// 		case 81	  : ApplyAnimationEx(playerid, "PED", "ROADCROSS", 4.0, 1, 0, 0, 0, 0, 1); // roadcross 1							
// 		case 82	  : ApplyAnimationEx(playerid, "PED", "ROADCROSS_FEMALE", 4.0, 1, 0, 0, 0, 0, 1); // roadcross 2							
// 		case 83	  : ApplyAnimationEx(playerid, "PED", "ROADCROSS_GANG", 4.0, 1, 0, 0, 0, 0, 1); // roadcross 3							
// 		case 84	  : ApplyAnimationEx(playerid, "PED", "ROADCROSS_OLD", 4.0, 1, 0, 0, 0, 0, 1); // roadcross 4							
// 		case 85	  : ApplyAnimationEx(playerid, "CAMERA", "CAMSTND_CMON", 4.0, 1, 0, 0, 0, 0, 1); // camera3							
// 		case 86	  : ApplyAnimationEx(playerid, "CAMERA", "PICSTND_TAKE", 4.0, 1, 0, 0, 0, 0, 1); // camera4							
// 		case 87	  : ApplyAnimationEx(playerid, "PED", "XPRESSSCRATCH", 4.0, 1, 0, 0, 0, 0, 1); // roadcross 5							
// 		case 88	  : ApplyAnimationEx(playerid, "CAR", "FIXN_CAR_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // car1							
// 		case 89	  : ApplyAnimationEx(playerid, "PLAYIDLES", "SHIFT", 4.0, 1, 0, 0, 0, 0, 1); // idle							
// 		case 90	  : ApplyAnimationEx(playerid, "PLAYIDLES", "SHIFT", 4.0, 1, 0, 0, 0, 0, 1); // idle 1							
// 		case 91	  : ApplyAnimationEx(playerid, "PLAYIDLES", "SHLDR", 4.0, 1, 0, 0, 0, 0, 1); // idle 2							
// 		case 92	  : ApplyAnimationEx(playerid, "PLAYIDLES", "STRETCH", 4.0, 1, 0, 0, 0, 0, 1); // idle 3							
// 		case 93	  : ApplyAnimationEx(playerid, "PLAYIDLES", "STRLEG", 4.0, 1, 0, 0, 0, 0, 1); // idle 4							
// 		case 94	  : ApplyAnimationEx(playerid, "PLAYIDLES", "TIME", 4.0, 1, 0, 0, 0, 0, 1); // idle 5							
// 		case 95	  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_AWAY", 4.0, 1, 0, 0, 0, 0, 1); // parkir 1							
// 		case 96	  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_COME", 4.0, 1, 0, 0, 0, 0, 1); // parkir 2							
// 		case 97	  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_LEFT", 4.0, 1, 0, 0, 0, 0, 1); // parkir 3							
// 		case 98	  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_STOP", 4.0, 1, 0, 0, 0, 0, 1); // parkir 4							
// 		case 99	  : ApplyAnimationEx(playerid, "POLICE", "CRM_DRGBST_01", 4.0, 1, 0, 0, 0, 0, 1); // frisk cop							
// 		case 100  : ApplyAnimationEx(playerid, "RAPPING", "LAUGH_01", 4.0, 1, 0, 0, 0, 0, 1); // laugh							
// 		case 101  : ApplyAnimationEx(playerid, "ROB_BANK", "CAT_SAFE_ROB", 4.0, 1, 0, 0, 0, 0, 1); // rob bank							
// 		case 102  : ApplyAnimationEx(playerid, "RYDER", "VAN_STAND", 4.0, 1, 0, 0, 0, 0, 1); // crate stand							
// 		case 103  : ApplyAnimationEx(playerid, "RYDER", "VAN_STAND_CRATE", 4.0, 1, 0, 0, 0, 0, 1); // crate stand 2							
// 		case 104  : ApplyAnimationEx(playerid, "RYDER", "VAN_STAND", 4.0, 1, 0, 0, 0, 0, 1); // crate stand 1							
// 		case 105  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_AWAY", 4.0, 1, 0, 0, 0, 0, 1); // 							
// 		case 106  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_AWAY", 4.0, 1, 0, 0, 0, 0, 1); // Police Go Away							
// 		case 107  : ApplyAnimationEx(playerid, "SPRAYCAN", "SPRAYCAN_FULL", 4.0, 1, 0, 0, 0, 0, 1); // spraycan pull							
// 		case 108  : ApplyAnimationEx(playerid, "COP_AMBIENT", "COPBROWSE_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // cop1							
// 		case 109  : ApplyAnimationEx(playerid, "STRIP", "PLY_CASH", 4.0, 1, 0, 0, 0, 0, 1); // slap table							
// 		case 110  : ApplyAnimationEx(playerid, "STRIP", "PLY_CASH", 4.0, 1, 0, 0, 0, 0, 1); // slap cash 1							
// 		case 111  : ApplyAnimationEx(playerid, "STRIP", "PUN_CASH", 4.0, 1, 0, 0, 0, 0, 1); // slap cash 2							
// 		case 112  : ApplyAnimationEx(playerid, "STRIP", "STR_LOOP_A", 4.0, 1, 0, 0, 0, 0, 1); // new strip 1							
// 		case 113  : ApplyAnimationEx(playerid, "STRIP", "STR_LOOP_B", 4.0, 1, 0, 0, 0, 0, 1); // new strip 2							
// 		case 114  : ApplyAnimationEx(playerid, "STRIP", "STR_LOOP_C", 4.0, 1, 0, 0, 0, 0, 1); // new strip 3							
// 		case 115  : ApplyAnimationEx(playerid, "SUNBATHE", "PARKSIT_M_IDLEA", 4.0, 1, 0, 0, 0, 0, 1); // new lay 1							
// 		case 116  : ApplyAnimationEx(playerid, "SUNBATHE", "PARKSIT_M_IDLEB", 4.0, 1, 0, 0, 0, 0, 1); // new lay 2							
// 		case 117  : ApplyAnimationEx(playerid, "SUNBATHE", "PARKSIT_M_IDLEC", 4.0, 1, 0, 0, 0, 0, 1); // new lay 3							
// 		case 118  : ApplyAnimationEx(playerid, "SUNBATHE", "PARKSIT_W_IDLEA", 4.0, 1, 0, 0, 0, 0, 1); // new lay 4							
// 		case 119  : ApplyAnimationEx(playerid, "AIRPORT", "THRW_BARL_THRW", 4.0, 1, 0, 0, 0, 0, 1); // benerin body mobil							
// 		case 120  : ApplyAnimationEx(playerid, "SUNBATHE", "PARKSIT_W_IDLEB", 4.0, 1, 0, 0, 0, 0, 1); // new lay 5							
// 		case 121  : ApplyAnimationEx(playerid, "SUNBATHE", "PARKSIT_W_IDLEC", 4.0, 1, 0, 0, 0, 0, 1); // new lay 6							
// 		case 122  : ApplyAnimationEx(playerid, "SWEET", "SWEET_ASS_SLAP", 4.0, 1, 0, 0, 0, 0, 1); // ass slap							
// 		case 123  : ApplyAnimationEx(playerid, "SWEET", "PLYR_HNDSHLDR_01", 4.0, 1, 0, 0, 0, 0, 1); // sweet stand							
// 		case 124  : ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_BUY", 4.0, 1, 0, 0, 0, 0, 1); // 							
// 		case 125  : ApplyAnimationEx(playerid, "HAIRCUTS", "BRB_BUY", 4.0, 1, 0, 0, 0, 0, 1); // Milih milih							
// 		case 126  : ApplyAnimationEx(playerid, "HEIST9", "USE_SWIPECARD", 4.0, 1, 0, 0, 0, 0, 1); // Gesek kartu							
// 		case 127  : ApplyAnimationEx(playerid, "SWORD", "SWORD_IDLE", 4.0, 1, 0, 0, 0, 0, 1); // sword stand							
// 		case 128  : ApplyAnimationEx(playerid, "CAMERA", "CAMCRCH_CMON", 4.0, 1, 0, 0, 0, 0, 1); // go away jongkok							
// 		case 129  : ApplyAnimationEx(playerid, "INT_SHOP", "SHOP_SHELF", 4.0, 1, 0, 0, 0, 0, 1); // Ambil barang							
// 		case 130  : ApplyAnimationEx(playerid, "CAMERA", "CAMCRCH_IDLELOOP", 4.0, 1, 0, 0, 0, 0, 1); // duduk sila							
// 		case 131  : ApplyAnimationEx(playerid, "WUZI", "WUZI_STAND_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // wuzi stand							
// 		case 132  : ApplyAnimationEx(playerid, "INT_SHOP", "SHOP_LOOKA", 4.0, 1, 0, 0, 0, 0, 1); // Operasi							
// 		case 133  : ApplyAnimationEx(playerid, "INT_SHOP", "SHOP_LOOKB", 4.0, 1, 0, 0, 0, 0, 1); // Operasi2							
// 		case 134  : ApplyAnimationEx(playerid, "INT_SHOP", "SHOP_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // Operasi3							
// 		case 135  : ApplyAnimationEx(playerid, "CAR", "FIXN_CAR_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // benerin kolong mobil							
// 		case 136  : ApplyAnimationEx(playerid, "INT_SHOP", "SHOP_LOOKB", 4.0, 1, 0, 0, 0, 0, 1); // /anim 3							
// 		case 137  : ApplyAnimationEx(playerid, "ON_LOOKERS", "PANIC_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // Kaget							
// 		case 138  : ApplyAnimationEx(playerid, "PYTHON", "PYTHON_FIRE", 4.0, 1, 0, 0, 0, 0, 1); // /anim 4							
// 		case 139  : ApplyAnimationEx(playerid, "OTB", "WTCHRACE_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // /crossarms baru							
// 		case 140  : ApplyAnimationEx(playerid, "PYTHON", "PYTHON_CROUCHFIRE", 4.0, 1, 0, 0, 0, 0, 1); // /anim 5							
// 		case 141  : ApplyAnimationEx(playerid, "RIOT", "RIOT_FUKU", 4.0, 1, 0, 0, 0, 0, 1); // /anim 6							
// 		case 142  : ApplyAnimationEx(playerid, "SWEET", "SWEET_ASS_SLAP", 4.0, 1, 0, 0, 0, 0, 1); // /anim 7							
// 		case 143  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_LEFT", 4.0, 1, 0, 0, 0, 0, 1); // /anim 8							
// 		case 144  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_STOP", 4.0, 1, 0, 0, 0, 0, 1); // /anim 9							
// 		case 145  : ApplyAnimationEx(playerid, "PLAYIDLES", "TIME", 4.0, 1, 0, 0, 0, 0, 1); // /anim 10							
// 		case 146  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_LEFT", 4.0, 1, 0, 0, 0, 0, 1); // police jalur kanan							
// 		case 147  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_STOP", 4.0, 1, 0, 0, 0, 0, 1); // police stop							
// 		case 148  : ApplyAnimationEx(playerid, "POLICE", "COPTRAF_COME", 4.0, 1, 0, 0, 0, 0, 1); // police ayo maju bang							
// 		case 149  : ApplyAnimationEx(playerid, "SMOKING", "F_SMKLEAN_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // /anim 11							
// 		case 150  : ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY", 4.0, 1, 0, 0, 0, 0, 1); // Gaya semisal udah menang							
// 		case 151  : ApplyAnimationEx(playerid, "POLICE", "DOOR_KICK", 4.0, 1, 0, 0, 0, 0, 1); // police dobrak pintu							
// 		case 152  : ApplyAnimationEx(playerid, "SWORD", "SWORD_IDLE", 4.0, 1, 0, 0, 0, 0, 1); // /anim 12							
// 		case 153  : ApplyAnimationEx(playerid, "MISC", "CPR", 4.0, 1, 0, 0, 0, 0, 1); // /anim 13							
// 		case 154  : ApplyAnimationEx(playerid, "INT_SHOP", "SHOP_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // /anim 14							
// 		case 155  : ApplyAnimationEx(playerid, "INT_SHOP", "SHOP_LOOKB", 4.0, 1, 0, 0, 0, 0, 1); // /anim 15							
// 		case 156  : ApplyAnimationEx(playerid, "INT_SHOP", "SHOP_LOOKA", 4.0, 1, 0, 0, 0, 0, 1); // /anim 16							
// 		case 157  : ApplyAnimationEx(playerid, "JST_BUISNESS", "GIRL_02", 4.0, 1, 0, 0, 0, 0, 1); // /anim 17							
// 		case 158  : ApplyAnimationEx(playerid, "OTB", "WTCHRACE_WIN", 4.0, 1, 0, 0, 0, 0, 1); // /anim 18							
// 		case 159  : ApplyAnimationEx(playerid, "SPRAYCAN", "SPRAYCAN_FULL", 4.0, 1, 0, 0, 0, 0, 1); // Anim /tag create diganti ini aja bang 							
// 		case 160  : ApplyAnimationEx(playerid, "PLAYIDLES", "SHIFT", 4.0, 1, 0, 0, 0, 0, 1); // /anim 19							
// 		case 161  : ApplyAnimationEx(playerid, "SWEET", "SWEET_INJUREDLOOP", 4.0, 1, 0, 0, 0, 0, 1); // /anim 20							
// 		case 162  : ApplyAnimationEx(playerid, "LOWRIDER", "F_SMKLEAN_LOOP", 4.0, 1, 0, 0, 0, 0, 1); // Nyender							
// 		case 163  : ApplyAnimationEx(playerid, "SUNBATHE", "PARKSIT_M_IDLEA", 4.0, 1, 0, 0, 0, 0, 1); // /anim 21							
// 		case 164  : ApplyAnimationEx(playerid, "SUNBATHE", "PARKSIT_M_IDLEC", 4.0, 1, 0, 0, 0, 0, 1); // /anim 22							
// 		case 165  : ApplyAnimationEx(playerid, "SWORD", "SWORD_BLOCK", 4.0, 1, 0, 0, 0, 0, 1); // /anim 23							
// 		case 166  : ApplyAnimationEx(playerid, "MISC", "HIKER_POSE", 4.0, 1, 0, 0, 0, 0, 1); // minta nebeng om							
// 		case 167  : ApplyAnimationEx(playerid, "RAPPING", "LAUGH_01", 4.0, 1, 0, 0, 0, 0, 1); // ketawa lucu
// 	}
// 	return 1;
// }

CMD:dance(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");


    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/dance [1-4]");

    if(type < 1 || type > 4)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
        case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
        case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
        case 4: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
    }
    return 1;
}

CMD:handsup(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
    return 1;
}
CMD:bat(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/bat [1-5]");

    if(type < 1 || type > 5)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "BASEBALL", "Bat_1", 4.1, 0, 1, 1, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "BASEBALL", "Bat_2", 4.1, 0, 1, 1, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "BASEBALL", "Bat_3", 4.1, 0, 1, 1, 0, 0, 1);
        case 4: ApplyAnimation(playerid, "BASEBALL", "Bat_4", 4.1, 0, 0, 0, 0, 0, 1);
        case 5: ApplyAnimationEx(playerid, "BASEBALL", "Bat_IDLE", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:slapass(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimationEx(playerid, "SWEET", "SWEET_ASS_SLAP", 4.0, 0, 0, 0, 0, 0, 1);

    return 1;
}
CMD:flag(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animation at the moment");

    ApplyAnimationEx(playerid, "CAR", "FLAG_DROP", 4.0, 0, 0, 0, 0, 1); // flagdrop

    return 1;
}


CMD:slap(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    new targetid = IsPlayerNearPartner(playerid);
    if(targetid == -1)
        return ApplyAnimation(playerid, "BASEBALL", "Bat_M", 4.1, 0, 0, 0, 0, 0, 1);

    SetPlayerLove(playerid, PlayerData[playerid][pLove]-5);
    SetPlayerLove(targetid, PlayerData[targetid][pLove]-5);
    ApplyAnimation(playerid, "BASEBALL", "Bat_M", 4.1, 0, 0, 0, 0, 0, 1);

    return 1;
}

CMD:bar(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/bar [1-8]");

    if(type < 1 || type > 8)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "BAR", "Barserve_give", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "BAR", "Barserve_glass", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimation(playerid, "BAR", "Barserve_in", 4.1, 0, 0, 0, 0, 0, 1);
        case 5: ApplyAnimation(playerid, "BAR", "Barserve_order", 4.1, 0, 0, 0, 0, 0, 1);
        case 6: ApplyAnimationEx(playerid, "BAR", "BARman_idle", 4.1, 1, 0, 0, 0, 0, 1);
        case 7: ApplyAnimationEx(playerid, "BAR", "dnk_stndM_loop", 4.1, 0, 0, 0, 0, 0, 1);
        case 8: ApplyAnimationEx(playerid, "BAR", "dnk_stndF_loop", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:wash(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:lay(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/lay [1-5]");

    if(type < 1 || type > 5)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "BEACH", "bather", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "BEACH", "Lay_Bac_Loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "BEACH", "ParkSit_M_loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "BEACH", "ParkSit_W_loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 5: ApplyAnimationEx(playerid, "BEACH", "SitnWait_loop_W", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:workout(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/workout [1-7]");

    if(type < 1 || type > 7)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "benchpress", "gym_bp_celebrate", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "benchpress", "gym_bp_down", 4.1, 0, 0, 0, 1, 0, 1);
        case 3: ApplyAnimation(playerid, "benchpress", "gym_bp_getoff", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "benchpress", "gym_bp_geton", 4.1, 0, 0, 0, 1, 0, 1);
        case 5: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_A", 4.1, 0, 0, 0, 1, 0, 1);
        case 6: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_B", 4.1, 0, 0, 0, 1, 0, 1);
        case 7: ApplyAnimationEx(playerid, "benchpress", "gym_bp_up_smooth", 4.1, 0, 0, 0, 1, 0, 1);
    }
    return 1;
}

CMD:blowjob(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/blowjob [1-4]");

    if(type < 1 || type > 4)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_W", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:bomb(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:carry(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/carry [1-6]");

    if(type < 1 || type > 6)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "CARRY", "liftup", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "CARRY", "liftup05", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimation(playerid, "CARRY", "putdwn", 4.1, 0, 0, 0, 0, 0, 1);
        case 5: ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 0, 0, 0, 0, 1);
        case 6: ApplyAnimation(playerid, "CARRY", "putdwn105", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:crack(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/crack [1-6]");

    if(type < 1 || type > 6)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth1", 4.1, 0, 0, 0, 1, 0, 1);
        case 2: ApplyAnimationEx(playerid, "CRACK", "crckdeth2", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "CRACK", "crckdeth3", 4.1, 0, 0, 0, 1, 0, 1);
        case 4: ApplyAnimationEx(playerid, "CRACK", "crckidle1", 4.1, 0, 0, 0, 1, 0, 1);
        case 5: ApplyAnimationEx(playerid, "CRACK", "crckidle2", 4.1, 0, 0, 0, 1, 0, 1);
        case 6: ApplyAnimationEx(playerid, "CRACK", "crckidle3", 4.1, 0, 0, 0, 1, 0, 1);
    }
    return 1;
}

CMD:sleep(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/sleep [1-2]");

    if(type < 1 || type > 2)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "CRACK", "crckdeth4", 4.1, 0, 0, 0, 1, 0, 1);
        case 2: ApplyAnimationEx(playerid, "CRACK", "crckidle4", 4.1, 0, 0, 0, 1, 0, 1);
    }
    return 1;
}

CMD:jump(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "DODGE", "Crush_Jump", 4.1, 0, 1, 1, 0, 0, 1);
    return 1;
}

CMD:deal(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/deal [1-6]");

    if(type < 1 || type > 6)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "DEALER", "DRUGS_BUY", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "DEALER", "shop_pay", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_01", 4.1, 1, 0, 0, 0, 0, 1);
        case 5: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_02", 4.1, 1, 0, 0, 0, 0, 1);
        case 6: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE_03", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:dancing(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/dancing [1-10]");

    if(type < 1 || type > 10)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "DANCING", "dance_loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "DANCING", "DAN_Left_A", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "DANCING", "DAN_Right_A", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "DANCING", "DAN_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
        case 5: ApplyAnimationEx(playerid, "DANCING", "DAN_Up_A", 4.1, 1, 0, 0, 0, 0, 1);
        case 6: ApplyAnimationEx(playerid, "DANCING", "DAN_Down_A", 4.1, 1, 0, 0, 0, 0, 1);
        case 7: ApplyAnimationEx(playerid, "DANCING", "dnce_M_a", 4.1, 1, 0, 0, 0, 0, 1);
        case 8: ApplyAnimationEx(playerid, "DANCING", "dnce_M_e", 4.1, 1, 0, 0, 0, 0, 1);
        case 9: ApplyAnimationEx(playerid, "DANCING", "dnce_M_b", 4.1, 1, 0, 0, 0, 0, 1);
        case 10: ApplyAnimationEx(playerid, "DANCING", "dnce_M_c", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}
CMD:eating(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/eating [1-3]");

    if(type < 1 || type > 3)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:puke(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:gsign(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/gsign [1-15]");

    if(type < 1 || type > 15)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "GHANDS", "gsign1", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "GHANDS", "gsign1LH", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "GHANDS", "gsign2", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimation(playerid, "GHANDS", "gsign2LH", 4.1, 0, 0, 0, 0, 0, 1);
        case 5: ApplyAnimation(playerid, "GHANDS", "gsign3", 4.1, 0, 0, 0, 0, 0, 1);
        case 6: ApplyAnimation(playerid, "GHANDS", "gsign3LH", 4.1, 0, 0, 0, 0, 0, 1);
        case 7: ApplyAnimation(playerid, "GHANDS", "gsign4", 4.1, 0, 0, 0, 0, 0, 1);
        case 8: ApplyAnimation(playerid, "GHANDS", "gsign4LH", 4.1, 0, 0, 0, 0, 0, 1);
        case 9: ApplyAnimation(playerid, "GHANDS", "gsign5", 4.1, 0, 0, 0, 0, 0, 1);
        case 10: ApplyAnimation(playerid, "GHANDS", "gsign5", 4.1, 0, 0, 0, 0, 0, 1);
        case 11: ApplyAnimation(playerid, "GHANDS", "gsign5LH", 4.1, 0, 0, 0, 0, 0, 1);
        case 12: ApplyAnimation(playerid, "GANGS", "Invite_No", 4.1, 0, 0, 0, 0, 0, 1);
        case 13: ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.1, 0, 0, 0, 0, 0, 1);
        case 14: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 4.1, 0, 0, 0, 0, 0, 1);
        case 15: ApplyAnimation(playerid, "GANGS", "smkcig_prtl", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:chat(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/chat [1-6]");

    if(type < 1 || type > 6)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkE", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkF", 4.1, 0, 0, 0, 0, 0, 1);
        case 5: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkG", 4.1, 0, 0, 0, 0, 0, 1);
        case 6: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkH", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:goggles(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "goggles", "goggles_put_on", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:spray(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimationEx(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:throw(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "GRENADE", "WEAPON_throw", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:swipe(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:office(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/office [1-6]");

    if(type < 1 || type > 6)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Bored_Loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Crash", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Drink", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Read", 4.1, 1, 0, 0, 0, 0, 1);
        case 5: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Type_Loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 6: ApplyAnimationEx(playerid, "INT_OFFICE", "OFF_Sit_Watch", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:kiss(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/kiss [1-6]");

    if(type < 1 || type > 6)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
        case 5: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
        case 6: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:knife(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/knife [1-8]");

    if(type < 1 || type > 8)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "KNIFE", "knife_1", 4.1, 0, 1, 1, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "KNIFE", "knife_2", 4.1, 0, 1, 1, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "KNIFE", "knife_3", 4.1, 0, 1, 1, 0, 0, 1);
        case 4: ApplyAnimation(playerid, "KNIFE", "knife_4", 4.1, 0, 1, 1, 0, 0, 1);
        case 5: ApplyAnimationEx(playerid, "KNIFE", "WEAPON_knifeidle", 4.1, 1, 0, 0, 0, 0, 1);
        case 6: ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Player", 4.1, 0, 0, 0, 0, 0, 1);
        case 7: ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Damage", 4.1, 0, 0, 0, 0, 0, 1);
        case 8: ApplyAnimation(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:cpr(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "MEDIC", "CPR", 4.1, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:scratch(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/scratch [1-4]");

    if(type < 1 || type > 4)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "SCRATCHING", "scdldlp", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "SCRATCHING", "scdlulp", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "SCRATCHING", "scdrdlp", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "SCRATCHING", "scdrulp", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:point(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/point [1-4]");

    if(type < 1 || type > 4)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "PED", "ARRESTgun", 4.1, 0, 0, 0, 1, 0, 1);
        case 2: ApplyAnimationEx(playerid, "SHOP", "ROB_Loop_Threat", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "point_loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:cheer(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/cheer [1-8]");

    if(type < 1 || type > 8)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "ON_LOOKERS", "shout_02", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "ON_LOOKERS", "shout_in", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.1, 1, 0, 0, 0, 0, 1);
        case 5: ApplyAnimation(playerid, "RIOT", "RIOT_CHANT", 4.1, 0, 0, 0, 0, 0, 1);
        case 6: ApplyAnimation(playerid, "RIOT", "RIOT_shout", 4.1, 0, 0, 0, 0, 0, 1);
        case 7: ApplyAnimation(playerid, "STRIP", "PUN_HOLLER", 4.1, 0, 0, 0, 0, 0, 1);
        case 8: ApplyAnimation(playerid, "OTB", "wtchrace_win", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:strip(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/strip [1-7]");

    if(type < 1 || type > 7)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "STRIP", "strip_A", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "STRIP", "strip_B", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "STRIP", "strip_C", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "STRIP", "strip_D", 4.1, 1, 0, 0, 0, 0, 1);
        case 5: ApplyAnimationEx(playerid, "STRIP", "strip_E", 4.1, 1, 0, 0, 0, 0, 1);
        case 6: ApplyAnimationEx(playerid, "STRIP", "strip_F", 4.1, 1, 0, 0, 0, 0, 1);
        case 7: ApplyAnimationEx(playerid, "STRIP", "strip_G", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:wave(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/wave [1-3]");

    if(type < 1 || type > 3)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "PED", "endchat_03", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "KISSING", "gfwave2", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "ON_LOOKERS", "wave_loop", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:smoke(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/smoke [1-3]");

    if(type < 1 || type > 3)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "SMOKING", "M_smk_drag", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "SMOKING", "M_smklean_loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:reload(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/reload [1-4]");

    if(type < 1 || type > 4)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.1, 0, 0, 0, 0, 0, 1); 
        case 2: ApplyAnimation(playerid, "UZI", "UZI_reload", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: ApplyAnimation(playerid, "RIFLE", "rifle_load", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:taichi(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimationEx(playerid, "PARK", "Tai_Chi_Loop", 4.1, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:wank(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/wank [1-3]");

    if(type < 1 || type > 3)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "PAULNMAC", "wank_loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimation(playerid, "PAULNMAC", "wank_in", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.1, 0, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:cower(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimationEx(playerid, "PED", "cower", 4.1, 0, 0, 0, 1, 0, 1);
    return 1;
}

CMD:drunk(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimationEx(playerid, "PED", "WALK_drunk", 4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}

CMD:cry(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimationEx(playerid, "GRAVEYARD", "mrnF_loop", 4.1, 1, 0, 0, 0, 0, 1);
    return 1;
}



CMD:tired(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/tired [1-2]");

    if(type < 1 || type > 2)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "PED", "IDLE_tired", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: ApplyAnimationEx(playerid, "FAT", "IDLE_tired", 4.1, 1, 0, 0, 0, 0, 1);
    }
    return 1;
}

CMD:sit(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/sit [1-6]");

    if(type < 1 || type > 6)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "CRIB", "PED_Console_Loop", 4.1, 1, 0, 0, 0, 0);
        case 2: ApplyAnimationEx(playerid, "INT_HOUSE", "LOU_In", 4.1, 0, 0, 0, 1, 0);
        case 3: ApplyAnimationEx(playerid, "MISC", "SEAT_LR", 4.1, 1, 0, 0, 0, 0);
        case 4: ApplyAnimationEx(playerid, "MISC", "Seat_talk_01", 4.1, 1, 0, 0, 0, 0);
        case 5: ApplyAnimationEx(playerid, "MISC", "Seat_talk_02", 4.1, 1, 0, 0, 0, 0);
        case 6: ApplyAnimationEx(playerid, "ped", "SEAT_down", 4.1, 0, 0, 0, 1, 0);
    }
    return 1;
}

CMD:crossarms(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/crossarms [1-4]");

    if(type < 1 || type > 4)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 0, 1, 1, 1, 0, 1);
        case 2: ApplyAnimationEx(playerid, "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: ApplyAnimationEx(playerid, "GRAVEYARD", "mrnM_loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: ApplyAnimationEx(playerid, "DEALER", "DEALER_IDLE", 4.1, 0, 1, 1, 1, 0, 1);
    }
    return 1;
}

CMD:fall(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "PED", "ko_skid_back", 4.1, 0, 0, 0, 1, 0, 1);
    return 1;
}

CMD:fallfront(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "PED", "ko_skid_front", 4.1, 0, 0, 0, 1, 0, 1);
    return 1;
}

CMD:fucku(playerid, params[])
{
    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    ApplyAnimation(playerid, "PED", "fucku", 4.1, 0, 0, 0, 0, 0);
    return 1;
}

CMD:walk(playerid, params[])
{
    new type;

    if(!AnimationCheck(playerid))
        return SendErrorMessage(playerid, "You can't perform animations at the moment.");

    if(sscanf(params, "d", type))
        return SendSyntaxMessage(playerid, "/walk [1-16]");

    if(type < 1 || type > 17)
        return SendErrorMessage(playerid, "Invalid type specified.");

    switch (type) {
        case 1: ApplyAnimationEx(playerid, "FAT", "FatWalk", 4.1, 1, 1, 1, 1, 1, 1);
        case 2: ApplyAnimationEx(playerid, "MUSCULAR", "MuscleWalk", 4.1, 1, 1, 1, 1, 1, 1);
        case 3: ApplyAnimationEx(playerid, "PED", "WALK_armed", 4.1, 1, 1, 1, 1, 1, 1);
        case 4: ApplyAnimationEx(playerid, "PED", "WALK_civi", 4.1, 1, 1, 1, 1, 1, 1);
        case 5: ApplyAnimationEx(playerid, "PED", "WALK_fat", 4.1, 1, 1, 1, 1, 1, 1);
        case 6: ApplyAnimationEx(playerid, "PED", "WALK_fatold", 4.1, 1, 1, 1, 1, 1, 1);
        case 7: ApplyAnimationEx(playerid, "PED", "WALK_gang1", 4.1, 1, 1, 1, 1, 1, 1);
        case 8: ApplyAnimationEx(playerid, "PED", "WALK_gang2", 4.1, 1, 1, 1, 1, 1, 1);
        case 9: ApplyAnimationEx(playerid, "PED", "WALK_player", 4.1, 1, 1, 1, 1, 1, 1);
        case 10: ApplyAnimationEx(playerid, "PED", "WALK_old", 4.1, 1, 1, 1, 1, 1, 1);
        case 11: ApplyAnimationEx(playerid, "PED", "WALK_wuzi", 4.1, 1, 1, 1, 1, 1, 1);
        case 12: ApplyAnimationEx(playerid, "PED", "WOMAN_walkbusy", 4.1, 1, 1, 1, 1, 1, 1);
        case 13: ApplyAnimationEx(playerid, "PED", "WOMAN_walkfatold", 4.1, 1, 1, 1, 1, 1, 1);
        case 14: ApplyAnimationEx(playerid, "PED", "WOMAN_walknorm", 4.1, 1, 1, 1, 1, 1, 1);
        case 15: ApplyAnimationEx(playerid, "PED", "WOMAN_walksexy", 4.1, 1, 1, 1, 1, 1, 1);
        case 16: ApplyAnimationEx(playerid, "PED", "WOMAN_walkshop", 4.1, 1, 1, 1, 1, 1, 1);
    }
    return 1;
}