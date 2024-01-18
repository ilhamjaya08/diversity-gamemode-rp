/*

Easy-to-use interactive clickable textdraw keypad
by Mike (MP2)
© 2012

*/

/*https://sampforum.blast.hk/showthread.php?tid=329097&highlight=phone*/
/* >= CHANGELOG <= */
/*
1.0 (27th of March 2011)
- Initial release

1.1 (7th of April 2011)
- Textdraws only created when needed, and not per-player (only ever creates 25 textdraws)
- Improved variable names


### TO-DO ###

- Add 'retry' parameter to ShowPlayerKeypad to allow multiple attempts (+ 'attempts' in OnPlayerKeypadInput)

*/

/* ===[CONFIG]=== */

#define MAX_KEYPAD_KEY_LENGTH 10 // Max length for keypad key
#define KEYPAD_STAY_TIME 1000 // Time in miliseconds the keypad should stay on screen for after input (to show green/red light)

// Input types (for OnPlayerKeypadInput)
#define KEYPAD_INPUT_BAD 0 // Failed authorization
#define KEYPAD_INPUT_GOOD 1 // Successful authorization
#define KEYPAD_INPUT_CANCEL 2 // Called when ESC press to cancel keypad

// Macros
#define GetPlayerKeypad(%0) KEYPAD_pKeypad[%0][keypad_id]


/* ===[VARIABLES, ARRAYS ETC.]=== */

enum E_PLAYER_KEYPAD
{
keypad_id,
keypad_state,
keypad_string[MAX_KEYPAD_KEY_LENGTH+1],
keypad_key[MAX_KEYPAD_KEY_LENGTH+1]
}

new KEYPAD_pKeypad[MAX_PLAYERS][E_PLAYER_KEYPAD]; // The keypad data for a player

enum E_KEYPAD_TD
{
Text:keypad_textdraw_num[10],
Text:keypad_textdraw_box[14], // 10 numbers, RED_OFF, GREEN_OFF, RED_ON, GREEN_ON
Text:keypad_textdraw_bg // The grey background box
}

new KEYPAD_gKeypadTextdraws[E_KEYPAD_TD]; // An enum array to store the textdraw IDs in

#define KEYPAD_TD_GREEN_OFF 10
#define KEYPAD_TD_RED_OFF 11
#define KEYPAD_TD_GREEN_ON 12
#define KEYPAD_TD_RED_ON 13

new bool:KEYPAD_gTextDrawsCreated; // Are the textdraws for the keypad created?


// Return codes for ShowPlayerKeypad
#define CREATEKEYPAD_RETURN_INVALID_ID 0 // ID must be 1+
#define CREATEKEYPAD_RETURN_NUM -1 // String is not a number sequence
#define CREATEKEYPAD_RETURN_INVALID_PLAYER -2 // 'playerid' not connected

/*
native ShowPlayerKeypad(playerid, keypadID, key[]);
native HideKeypad(playerid);
*/

// Forwards
forward OnPlayerKeypadInput(playerid, keypadID, type, key);

stock DestroyKeypadTextdraws()
{
	if(!KEYPAD_gTextDrawsCreated) return 1;
	KEYPAD_gTextDrawsCreated = false;
	
	TextDrawDestroy(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg]);
	
	for(new i=0; i<14; i++) // Destroy the 14 boxes (10 numbers, 4 green/red boxes (two lit up two not))
	{
		TextDrawDestroy(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i]);
	}
	for(new i=0; i<10; i++) // Destroy the numbers
	{
		TextDrawDestroy(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i]);
	}
	return 1;
}

stock CreateKeypadTextdraws()
{
	if(KEYPAD_gTextDrawsCreated) return 1; // If the textdraws are already created, don't continue
	KEYPAD_gTextDrawsCreated = true; // Signify that the textdraws have been created

	// Create the grey background box
	KEYPAD_gKeypadTextdraws[keypad_textdraw_bg] = TextDrawCreate(570.000000, 280.000000, "_");
	TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 2);
	TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 255);
	TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 2);
	TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0.319999, 14.799995);
	TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], -1);
	TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0);
	TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 1);
	TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0);
	TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 1);
	TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], -1852730422);
	TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_bg], 0.000000, 113.000000);
	
	// The coordinates for the boxes
	new keypad_box_coords[][] = {
	{540, 290},
	{570, 320},
	{570, 290},
	{600, 290},
	{540, 320},
	{600, 320},
	{600, 350},
	{570, 350},
	{540, 350},
	{570, 380}
	};

	for(new i=0; i<10; i++) // Create the black boxes for the numbers
	{
		KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i] = TextDrawCreate(keypad_box_coords[i][0], keypad_box_coords[i][1], "~N~~N~~N~");
		TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 2);
		TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 255);
		TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 2);
		TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 0.319999, 0.899999);
		TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], -1);
		TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 0);
		TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 1);
		TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 0);
		TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 1);
		TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 255);
		TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i], 100.000000, 23.000000);
	}
	
	// The coordinates for the numbers
	new keypad_num_coords[][] = {
	{570, 379},
	{540, 289},
	{570, 289},
	{600, 289},
	{540, 319},
	{570, 319},
	{600, 319},
	{540, 349},
	{570, 349},
	{600, 349}
	};

	for(new i=0; i<10; i++) // Create the number textdraws
	{
		new numstr[2];
		format(numstr, 2, "%i", i);
		KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i] = TextDrawCreate(keypad_num_coords[i][0], keypad_num_coords[i][1], numstr);
		TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 2);
		TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 255);
		TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 2);
		TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 0.550000, 2.599998);
		TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], -1);
		TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 0);
		TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 1);
		TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 0);
		TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 23.000000, 23.000000);
		TextDrawSetSelectable(KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i], 1);
	}
	
	// Green Off
	KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF] = TextDrawCreate(600.000000, 380.000000, "~N~~N~~N~");
	TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 2);
	TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 255);
	TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 2);
	TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 0.319999, 0.899999);
	TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], -1);
	TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 0);
	TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 1);
	TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 0);
	TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 1);
	TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 5374207);
	TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF], 23.000000, 23.000000);
	
	// Red Off
	KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF] = TextDrawCreate(540.000000, 380.000000, "~N~~N~~N~");
	TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 2);
	TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 255);
	TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 2);
	TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 0.319999, 0.899999);
	TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], -1);
	TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 0);
	TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 1);
	TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 0);
	TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 1);
	TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 1375731967);
	TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF], 0.000000, 23.000000);
	
	// Green On
	KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON] = TextDrawCreate(600.000000, 380.000000, "~N~~N~~N~");
	TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 2);
	TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 255);
	TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 2);
	TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 0.319999, 0.899999);
	TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], -1);
	TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 0);
	TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 1);
	TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 0);
	TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 1);
	TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 0x00FF00FF);
	TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON], 23.000000, 23.000000);
	
	// Red On
	KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON] = TextDrawCreate(540.000000, 380.000000, "~N~~N~~N~");
	TextDrawAlignment(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 2);
	TextDrawBackgroundColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 255);
	TextDrawFont(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 2);
	TextDrawLetterSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 0.319999, 0.899999);
	TextDrawColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], -1);
	TextDrawSetOutline(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 0);
	TextDrawSetProportional(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 1);
	TextDrawSetShadow(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 0);
	TextDrawUseBox(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 1);
	TextDrawTextSize(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 0.000000, 23.000000);
	TextDrawBoxColor(KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON], 0xFF0000FF);
	return 1;
}

stock ShowPlayerKeypad(playerid, keypadID, key[]) // Show the keypad to a player. keypadID should be a unique ID like for dialogs to handle response code. key[] is the key they must enter to pass.
{
	if(!IsPlayerConnected(playerid)) return CREATEKEYPAD_RETURN_INVALID_PLAYER; // Just in-case the player isn't connected

	if(keypadID < 1) return CREATEKEYPAD_RETURN_INVALID_ID; // Returns CREATEKEYPAD_RETURN_INVALID_ID if invalid keypad ID. Must be 1+
	if(!keypad_IsNumeric(key)) return CREATEKEYPAD_RETURN_NUM; // Returns CREATEKEYPAD_RETURN_NUM if invalid key. Must be numbers only
	
	if(!KEYPAD_gTextDrawsCreated) CreateKeypadTextdraws(); // If textdraws aren't created, create them now

	format(KEYPAD_pKeypad[playerid][keypad_key], MAX_KEYPAD_KEY_LENGTH, "%s", key); // Save the key[] in to the player's variable
	KEYPAD_pKeypad[playerid][keypad_id] = keypadID; // Store which keypad the player has open
	
	for(new i=0; i<10; i++) // Show boxes
	{
		TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][i]);
	}
	for(new i=0; i<10; i++) // Show numbers
	{
		TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i]);
	}
	
	TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF]); // Show the dark red light
	TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF]); // Show the dark green light
	TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_bg]); // Show the grey background box
	SelectTextDraw(playerid, 0x00FF00FF); // Allow the player to select textdraws with the mouse cursor
	
	KEYPAD_pKeypad[playerid][keypad_state] = 1; // State 1 means they are inputting a code

	strdel(KEYPAD_pKeypad[playerid][keypad_string], 0, strlen(KEYPAD_pKeypad[playerid][keypad_string])); // Wipe the string that stores what they have entered so far
	return 1;
}

stock HideKeypad(playerid) // Hide the keypad for a player.
{
	if(!IsPlayerConnected(playerid)) return CREATEKEYPAD_RETURN_INVALID_PLAYER; // Just in-case they aren't connected
	
	KEYPAD_pKeypad[playerid][keypad_state] = 0; // State 0 means they have no keypad open
	
	if(!KEYPAD_gTextDrawsCreated) return 0; // Textdraws aren't even created, so stop.
	
	new KEYPAD_playersWithKeypadOpen; // A variable to store whether anyone else has a keypad open
	for(new i=0; i<MAX_PLAYERS; i++) // Loop through all players
	{
		if(KEYPAD_pKeypad[i][keypad_state] && i != playerid) KEYPAD_playersWithKeypadOpen = 1; // If any other players have a keypad open, set KEYPAD_playersWithKeypadOpen to 1.
	}
	if(!KEYPAD_playersWithKeypadOpen) return DestroyKeypadTextdraws(); // If nobody else has a keypad open, we can destroy the textdraws instead of just hiding them
	
	// Other players have keypads open, just hide the textdraws for this player
	TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_bg]); // Hide the grey background box
	for(new e=0; e<10; e++) TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_num][e]); // Hide numbers
	for(new e=0; e<14; e++) TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][e]); // Hide boxes
	CancelSelectTextDraw(playerid); // Hide the player's mouse cursor
	return 1;
}

public OnPlayerConnect(playerid) // When a player connects
{
	KEYPAD_pKeypad[playerid][keypad_state] = 0; // Make sure the script doesn't think they have a keypad open
	return CallLocalFunction("keypad_OnPlayerConnect", "i", playerid); // Hooking method
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect keypad_OnPlayerConnect
forward keypad_OnPlayerConnect(playerid);

public OnPlayerDisconnect(playerid, reason) // When a player disconnects
{
	if(KEYPAD_pKeypad[playerid][keypad_state]) HideKeypad(playerid); // If they have a keypad open, close it
	return CallLocalFunction("keypad_OnPlayerDisconnect", "ii", playerid, reason);
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect keypad_OnPlayerDisconnect
forward keypad_OnPlayerDisconnect(playerid, reason);

public OnPlayerClickTextDraw(playerid, Text:clickedid) // When a player clicks a textdraw
{
	if(KEYPAD_pKeypad[playerid][keypad_state] == 1) // If they are inputting a code in a keypad, check if they clicked one of the numbers
	{
	    if(clickedid == Text:INVALID_TEXT_DRAW) // They pressed ESC to cancel the keypad, so close it and call OnPlayerKeypadInput with 'type'  KEYPAD_INPUT_CANCEL
		{
		    PlayerPlaySound(playerid, 21001, 0, 0, 0);
			CallLocalFunction("OnPlayerKeypadInput", "iiii", playerid, KEYPAD_pKeypad[playerid][keypad_id], KEYPAD_INPUT_CANCEL, strval(KEYPAD_pKeypad[playerid][keypad_key]));
			return HideKeypad(playerid);
		}
	    for(new i=0; i<10; i++) // Loop through the 10 numbers, see if they clicked one
	    {
	        if(clickedid == KEYPAD_gKeypadTextdraws[keypad_textdraw_num][i]) // We found the number they clicked.
	        {
	            new numstr[2]; // Store the number in a string
	            format(numstr, 2, "%i", i);
	            strins(KEYPAD_pKeypad[playerid][keypad_string], numstr, strlen(KEYPAD_pKeypad[playerid][keypad_string])); // Add the number to the end of the string that stores what they have entered so far
	            if(strlen(KEYPAD_pKeypad[playerid][keypad_string]) == strlen(KEYPAD_pKeypad[playerid][keypad_key])) // Reached length of required key, check if it is correct
	            {
	                if(strcmp(KEYPAD_pKeypad[playerid][keypad_string], KEYPAD_pKeypad[playerid][keypad_key]) != 0) // Not the correct key
	                {
			    		PlayerPlaySound(playerid, 21001, 0, 0, 0); // Play the 'fail' sound
						
						new keypad_memory = KEYPAD_pKeypad[playerid][keypad_id]; // Store what keypad they have open, because we need to reset it before calling OnPlayerKeypadInput
						KEYPAD_pKeypad[playerid][keypad_id] = 0; // Reset what keypad they have open
						
	        			TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_OFF]); // Hide the DARK red box
						TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_RED_ON]);  // and show the LIT UP red box
	        			KEYPAD_pKeypad[playerid][keypad_state] = 2; // State 2 means they have entered a key, and this will not allow them to click more numbers
	        			CancelSelectTextDraw(playerid); // Hide the mouse cursor
			    		
			    		SetTimerEx("keypad_hide", KEYPAD_STAY_TIME, false, "i", playerid); // Hide the keypad after so long. This is defined by KEYPAD_STAY_TIME at the top of this include. You should leave time for them to see the red/green box light up.
						CallLocalFunction("OnPlayerKeypadInput", "iiii", playerid, keypad_memory, KEYPAD_INPUT_BAD, strval(KEYPAD_pKeypad[playerid][keypad_string])); // Call OnPlayerKeypadInput with 'type' KEYPAD_INPUT_BAD
						return 1;
					}
					else // Success, they entered the correct key
					{
	        			PlayerPlaySound(playerid, 21002, 0, 0, 0); // Play the 'success' sound
	        			TextDrawHideForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_OFF]); // Hide the DARK green box
						TextDrawShowForPlayer(playerid, KEYPAD_gKeypadTextdraws[keypad_textdraw_box][KEYPAD_TD_GREEN_ON]);  // and show the LIT UP green box
	        			KEYPAD_pKeypad[playerid][keypad_state] = 2; // State 2 means they have entered a key, and this will not allow them to click more numbers
	        			CancelSelectTextDraw(playerid); // Hide the mouse cursor
						new keypad_memory = KEYPAD_pKeypad[playerid][keypad_id]; // Store what keypad they have open, because we need to reset it before calling OnPlayerKeypadInput
						KEYPAD_pKeypad[playerid][keypad_id] = 0; // Reset what keypad they have open
	        			SetTimerEx("keypad_hide", KEYPAD_STAY_TIME, false, "i", playerid); // Hide the keypad after so long. This is defined by KEYPAD_STAY_TIME at the top of this include. You should leave time for them to see the red/green box light up.
	        			CallLocalFunction("OnPlayerKeypadInput", "iiii", playerid, keypad_memory, KEYPAD_INPUT_GOOD, strval(KEYPAD_pKeypad[playerid][keypad_string])); // Call OnPlayerKeypadInput with 'type' KEYPAD_INPUT_BAD
						return 1;
					}
				}
	            PlayerPlaySound(playerid, 21000, 0, 0, 0); // This is the beep sound which will be played when they click a number
	            return 1;
	        }
	    }
	}
	return CallLocalFunction("myinc_OnPlayerClickTextDraw", "ii", playerid, _:clickedid); // Hooking method
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw myinc_OnPlayerClickTextDraw
forward myinc_OnPlayerClickTextDraw(playerid, Text:clickedid);

// keypad_hide is called after so long, and will hide the keypad
forward keypad_hide(playerid);
public keypad_hide(playerid)
{
	HideKeypad(playerid); // Hide the keypad for the player
	return 1;
}

// This is used to determine whether a string is just numbers, as there are no letters on the keypad so the string MUST be all numbers!
stock keypad_IsNumeric(const isthisnumeric[])
{
	if(!strlen(isthisnumeric)) return 0;
	for(new i = 0; i < strlen(isthisnumeric); i++)
	{
		if(isthisnumeric[i] > '9' || isthisnumeric[i] < '0') return 0;
	}
	return 1;
}