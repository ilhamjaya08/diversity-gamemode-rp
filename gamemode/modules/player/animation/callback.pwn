hook OnScriptInit()
{
	new
		lib[32],                // The library name.
		anim[32],               // The animation name.
		tmplib[32]  = "NULL",   // The current library name to be compared.
		curlib      = -1
	;       // Current library the code writes to.

	for(new i = 1; i < MAX_ANIMS; i++) 
	{
		GetAnimationName(i, lib, 32, anim, 32);
		
		// If the animation library just retrieved does not match the current
		// library, the following animations are in a new library so advance
		// the current library variable.
		if(strcmp(lib, tmplib)) {
			curlib++;
			strcat(gLibList, lib);
			strcat(gLibList, "\n");
			tmplib = lib;
			strcat(gLibIndex[curlib], lib);
		}
		
		strcat(gAnimList[curlib], anim);
		strcat(gAnimList[curlib], "\n");

		gAnimTotal[ curlib ]++; // Increase the total amount of animations in the current library.
	}

	for(new i; i < MAX_PLAYERS; i++) {
		// Default animations to avoid crashes if a user uses
		// /animparams before /animations.
		gCurrentLib[i] = "RUNNINGMAN";
		gCurrentAnim[i] = "DANCE_LOOP";
		gCurrentIdx[i] = 1811;

		// Default speed so the user can use /animations
		// before needing to edit the speed in /animsettings
		gAnimSettings[i][anm_Speed] = 4.1;
		gAnimSettings[i][anm_Loop] = 1;
	}
}