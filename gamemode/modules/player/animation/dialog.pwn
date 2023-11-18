Dialog:D_ANIM_LIBRARIES(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		// Blank the string because strcat is used.
		gCurrentLib[playerid][0] = EOS;
		// Fortunately, inputtext will return the text of the line,
		// So this can just be saved as the player's current library.
		strcat(gCurrentLib[playerid], inputtext);
		// Show the right list of animations from the chosen library.
		Dialog_Show(playerid, D_ANIM_LIST, DIALOG_STYLE_LIST, "Animation List", gAnimList[listitem], "Select", "Close");
		// Preload the animations for that library
		PreloadAnimLib(playerid, inputtext);
	}
	return 1;
}

Dialog:D_ANIM_LIST(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new string[1024];
		// Blank the string because strcat is used
		gCurrentAnim[playerid][0] = EOS;
		// Save the animation name to the variable (For saving)
		strcat(gCurrentAnim[playerid], inputtext);

		format(string, sizeof(string), ""WHITE">> "YELLOW"Normal Play\n"WHITE">> "YELLOW"Loop Play\n"WHITE">> "YELLOW"Play and Freeze after\n"WHITE">> "RED"Save Animation");
		Dialog_Show(playerid, D_ANIM_STYLE, DIALOG_STYLE_LIST, "Animation List", string, "Play", "Close");
	}
	else Dialog_Show(playerid, D_ANIM_LIBRARIES, DIALOG_STYLE_LIST, "Animation List", gLibList, "Select", "Close");

	return 1;
}

Dialog:D_ANIM_STYLE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		switch(listitem)
		{
			case 0:
			{
				gAnimSettings[playerid][anm_Loop] = 0;
				gAnimSettings[playerid][anm_Freeze] = 0;
			}
			case 1:
			{
				gAnimSettings[playerid][anm_Loop] = 1;
				gAnimSettings[playerid][anm_Freeze] = 0;
			}
			case 2:
			{
				gAnimSettings[playerid][anm_Loop] = 0;
				gAnimSettings[playerid][anm_Freeze] = 1;
			}
			case 3:
			{
				Dialog_Show(playerid, D_ANIM_SAVE, DIALOG_STYLE_INPUT, "Animation Save", "Input your animation slot ( 0 - 299 )", "Save", "Close");
			}
		}
		PlayCurrentAnimation(playerid);
	}
	return 1;
}

Dialog:D_ANIM_SAVE(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new 
			slot = strval(inputtext)
		;
		if(slot < 0 || slot > 299)
			return Dialog_Show(playerid, D_ANIM_SAVE, DIALOG_STYLE_INPUT, "Animation Save", "ERROR : Animation Slot only (0 - 299)\n\nInput your animation slot ( 0 - 299 )", "Save", "Close");

		format(AnimData[playerid][slot][AnimLib], 32, "%s", gCurrentLib[playerid]);
		format(AnimData[playerid][slot][AnimName], 32, "%s", gCurrentAnim[playerid]);

		if(Anim_IsExists(playerid, slot))
		{
			Anim_Save(playerid, slot);
		}
		else
		{
			AnimData[playerid][slot][AnimExists] = true;
			Anim_Insert(playerid, slot);
		}
		SendServerMessage(playerid, "Kamu telah menyimpan animasi ini di slot %d", slot);
	}
	return 1;
}

Dialog:ANIMATION_PLAY(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new slot = GetPVarInt(playerid, "AnimSlot");
		switch(listitem)
		{
			case 0:
			{
				ApplyAnimationEx(playerid, 
					AnimData[playerid][slot][AnimLib], // Lib
					AnimData[playerid][slot][AnimName], // Name
					4.1, // Delta
					0, 
					0, 
					0, 
					0, 
					0, 
					1
				);
			}
			case 1:
			{
				ApplyAnimationEx(playerid, 
					AnimData[playerid][slot][AnimLib], 
					AnimData[playerid][slot][AnimName], 
					4.1, 
					1, 
					0, 
					0, 
					0, 
					0, 
					1
				);
			}
			case 2:
			{
				ApplyAnimationEx(playerid, 
					AnimData[playerid][slot][AnimLib], 
					AnimData[playerid][slot][AnimName], 
					4.1, 
					0, 
					0, 
					0, 
					1, 
					0, 
					1
				);
			}
		}
	}
	return 1;
}