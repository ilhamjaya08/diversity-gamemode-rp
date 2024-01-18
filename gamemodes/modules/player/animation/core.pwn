#define MAX_ANIMS				1812					// Total amount of animations (No brackets, because it's embedded in strings)
#define MAX_LIBRARY				(132)					// Total amount of libraries
#define MAX_LIBANIMS			(294)					// Largest library
#define MAX_LIB_NAME			(32)
#define MAX_ANIM_NAME			(32)					// Same as LIBNAME but just for completion!
#define MAX_SEARCH_RESULTS		(20)					// The max amount of search results that can be shown
#define MAX_SEARCH_RESULT_LEN	(MAX_SEARCH_RESULTS * (MAX_LIB_NAME + 1 + MAX_ANIM_NAME))
#define PreloadAnimLib(%1,%2)	ApplyAnimation(%1,%2,"null",0.0,0,0,0,0,0,1)

enum E_ANIM_SETTINGS {
	Float:anm_Speed,
	anm_Loop,
	anm_LockX,
	anm_LockY,
	anm_Freeze,
	anm_Time
}

new
	gAnimTotal[MAX_LIBRARY],
	
	gLibIndex[MAX_LIBRARY][MAX_LIB_NAME],

	gLibList[MAX_LIBRARY * (MAX_LIB_NAME+1)],
	gAnimList[MAX_LIBRARY][MAX_LIBANIMS * (MAX_ANIM_NAME+1)],

	gCurrentIdx[MAX_PLAYERS],
	gCurrentLib[MAX_PLAYERS][MAX_LIB_NAME],
	gCurrentAnim[MAX_PLAYERS][MAX_ANIM_NAME],
    gAnimSettings[MAX_PLAYERS][E_ANIM_SETTINGS]
;

