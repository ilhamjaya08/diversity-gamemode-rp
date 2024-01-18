PreloadPlayerAnims(playerid) {
	PreloadAnimLib(playerid,"BOMBER");
	PreloadAnimLib(playerid,"RAPPING");
	PreloadAnimLib(playerid,"SHOP");
	PreloadAnimLib(playerid,"BEACH");
	PreloadAnimLib(playerid,"SMOKING");
	PreloadAnimLib(playerid,"FOOD");
	PreloadAnimLib(playerid,"ON_LOOKERS");
	PreloadAnimLib(playerid,"DEALER");
	PreloadAnimLib(playerid,"CRACK");
	PreloadAnimLib(playerid,"CARRY");
	PreloadAnimLib(playerid,"COP_AMBIENT");
	PreloadAnimLib(playerid,"PARK");
	PreloadAnimLib(playerid,"INT_HOUSE");
	PreloadAnimLib(playerid,"FOOD");
	PreloadAnimLib(playerid,"PED");
}

PlayCurrentAnimation(playerid) {
	ClearAnimations(playerid);
	ApplyAnimationEx(playerid,
		gCurrentLib[playerid],
		gCurrentAnim[playerid],
		gAnimSettings[playerid][anm_Speed],
		gAnimSettings[playerid][anm_Loop],
		gAnimSettings[playerid][anm_LockX],
		gAnimSettings[playerid][anm_LockY],
		gAnimSettings[playerid][anm_Freeze],
		gAnimSettings[playerid][anm_Time],
		1);
}