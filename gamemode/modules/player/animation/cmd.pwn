CMD:animlibs(playerid, params[]) 
{
	if(!AnimationCheck(playerid))
		return SendErrorMessage(playerid, "You can't perform animation at the moment.");

	PreloadPlayerAnims(playerid);

	Dialog_Show(playerid, D_ANIM_LIBRARIES, DIALOG_STYLE_LIST, "Animation List", gLibList, "Select", "Close");
    return 1;
}

CMD:anim(playerid, params[])
{
	if(!AnimationCheck(playerid))
		return SendErrorMessage(playerid, "You can't perform animation at the moment.");

	new slot, string[1024];
    if(sscanf(params, "d", slot)) 
        return SendSyntaxMessage(playerid, "/anim [0-299]");

    if(slot < 0 || slot > 299)
        return SendErrorMessage(playerid, "The animation slot can't be below 0 or above 299.");

    if(!Anim_IsExists(playerid, slot))
        return SendErrorMessage(playerid, "You have not set this animation slot yet, use /animlibs to input animation to this slot!");

	SetPVarInt(playerid, "AnimSlot", slot);
	format(string, sizeof(string), ""WHITE">> "YELLOW"Normal Play\n"WHITE">> "YELLOW"Loop Play\n"WHITE">> "YELLOW"Play and Freeze after");
	Dialog_Show(playerid, ANIMATION_PLAY, DIALOG_STYLE_LIST, "Animation Style", string, "Play", "Close");
	return 1;
}