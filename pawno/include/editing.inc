#include <a_samp>

enum EDITPOINTDATA
{
	pEditObject,
	Float:pEditX,
	Float:pEditY,
	Float:pEditZ,
	Float:pEditRX,
	Float:pEditRY,
	Float:pEditRZ,
	
	Float:pSaveX,
	Float:pSaveY,
	Float:pSaveZ,
	Float:pSaveRX,
	Float:pSaveRY,
	Float:pSaveRZ,
	
	pEditObjectSel,
	pEditCallBack[32],
}

static pEditPoint[MAX_PLAYERS][EDITPOINTDATA];

stock PlayerEditPoint(playerid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, callback[], objectid = -1)
{
	if(pEditPoint[playerid][pEditObject] > -1)
		DestroyDynamicObject(pEditPoint[playerid][pEditObject]);

	if(objectid == -1)
	{
		pEditPoint[playerid][pEditObject] = CreateDynamicObject(1974,
					x,
					y,
					z,
					rx,
					ry,
					rz,
					-1, -1, playerid, .priority = 1);
	    SetDynamicObjectMaterial(pEditPoint[playerid][pEditObject], 0, 10765, "airportgnd_sfse", "white", -256);
	    format(pEditPoint[playerid][pEditCallBack], 32, "%s", callback);

	    pEditPoint[playerid][pEditX] = x;
	    pEditPoint[playerid][pEditY] = y;
	    pEditPoint[playerid][pEditZ] = z;
	    pEditPoint[playerid][pEditRX] = rx;
	    pEditPoint[playerid][pEditRY] = ry;
	    pEditPoint[playerid][pEditRZ] = rz;

	    pEditPoint[playerid][pSaveX] = x;
	    pEditPoint[playerid][pSaveY] = y;
	    pEditPoint[playerid][pSaveZ] = z;
	    pEditPoint[playerid][pSaveRX] = rx;
	    pEditPoint[playerid][pSaveRY] = ry;
	    pEditPoint[playerid][pSaveRZ] = rz;

		Streamer_Update(playerid);

		EditDynamicObject(playerid, pEditPoint[playerid][pEditObject]);
	}
	else
	{
		pEditPoint[playerid][pEditObjectSel] = objectid;

		format(pEditPoint[playerid][pEditCallBack], 32, "%s", callback);
		
		pEditPoint[playerid][pEditX] = x;
	    pEditPoint[playerid][pEditY] = y;
	    pEditPoint[playerid][pEditZ] = z;
	    pEditPoint[playerid][pEditRX] = rx;
	    pEditPoint[playerid][pEditRY] = ry;
	    pEditPoint[playerid][pEditRZ] = rz;

	    pEditPoint[playerid][pSaveX] = x;
	    pEditPoint[playerid][pSaveY] = y;
	    pEditPoint[playerid][pSaveZ] = z;
	    pEditPoint[playerid][pSaveRX] = rx;
	    pEditPoint[playerid][pSaveRY] = ry;
	    pEditPoint[playerid][pSaveRZ] = rz;

	    Streamer_Update(playerid);

        EditDynamicObject(playerid, pEditPoint[playerid][pEditObjectSel]);
	}
	
	return 1;
}

stock DestroyEditPoint(playerid)
{
	if(pEditPoint[playerid][pEditObject] != -1)
	{
		DestroyDynamicObject(pEditPoint[playerid][pEditObject]);
		pEditPoint[playerid][pEditObject] = -1;
	}
	return 1;
}

public OnGameModeInit()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    pEditPoint[i][pEditObject] = -1;
	    pEditPoint[i][pEditObjectSel] = -1;
	}
	#if defined edit_OnGameModeInit
		return edit_OnGameModeInit();
	#else
		return 1;
	#endif
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit edit_OnGameModeInit
#if defined edit_OnGameModeInit
	forward edit_OnGameModeInit();
#endif

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(objectid == pEditPoint[playerid][pEditObject] || objectid == pEditPoint[playerid][pEditObjectSel])
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
		    if(pEditPoint[playerid][pEditObjectSel])
		    {
			    CallLocalFunction(pEditPoint[playerid][pEditCallBack], "iiifffffffff",
			        playerid, objectid, response,
					x,
					y,
					z,
					rx,
					ry,
					rz,
					x - pEditPoint[playerid][pSaveX],
					y - pEditPoint[playerid][pSaveY],
					z - pEditPoint[playerid][pSaveZ]);
	            DestroyEditPoint(playerid);
		    }
		    else
		    {
			    CallLocalFunction(pEditPoint[playerid][pEditCallBack], "iiifffffffff",
			        playerid, objectid, response,
					pEditPoint[playerid][pEditX],
					pEditPoint[playerid][pEditY],
					pEditPoint[playerid][pEditZ],
					pEditPoint[playerid][pEditRX],
					pEditPoint[playerid][pEditRY],
					pEditPoint[playerid][pEditRZ],
					pEditPoint[playerid][pEditX] - pEditPoint[playerid][pSaveX],
					pEditPoint[playerid][pEditY] - pEditPoint[playerid][pSaveY],
					pEditPoint[playerid][pEditZ] - pEditPoint[playerid][pSaveZ]
				);
	            DestroyEditPoint(playerid);
			}
		}
		else if(response == EDIT_RESPONSE_UPDATE)
		{
		    pEditPoint[playerid][pEditX] = x;
		    pEditPoint[playerid][pEditY] = y;
		    pEditPoint[playerid][pEditZ] = z;
		    pEditPoint[playerid][pEditRX] = rx;
		    pEditPoint[playerid][pEditRY] = ry;
		    pEditPoint[playerid][pEditRZ] = rz;

		    CallLocalFunction(pEditPoint[playerid][pEditCallBack], "iiifffffffff",
		        playerid, objectid, response, x, y, z, rx, ry, rz,
				pEditPoint[playerid][pEditX] - pEditPoint[playerid][pSaveX],
				pEditPoint[playerid][pEditY] - pEditPoint[playerid][pSaveY],
				pEditPoint[playerid][pEditZ] - pEditPoint[playerid][pSaveZ]
			);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
		    CallLocalFunction(pEditPoint[playerid][pEditCallBack], "iiifffffffff",
		        playerid, objectid, response,
				pEditPoint[playerid][pSaveX],
				pEditPoint[playerid][pSaveY],
				pEditPoint[playerid][pSaveZ],
				pEditPoint[playerid][pSaveRX],
				pEditPoint[playerid][pSaveRY],
				pEditPoint[playerid][pSaveRZ],
				0.0, 0.0, 0.0
			);
            DestroyEditPoint(playerid);
		}
	}
	#if defined edit_OnPlayerEditDynamicObject
		return edit_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerEditDynamicObject
	#undef OnPlayerEditDynamicObject
#else
	#define _ALS_OnPlayerEditDynamicObject
#endif

#define OnPlayerEditDynamicObject edit_OnPlayerEditDynamicObject
#if defined edit_OnPlayerEditDynamicObject
	forward edit_OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
#endif

public OnPlayerDisconnect(playerid, reason)
{
	DestroyEditPoint(playerid);

	#if defined edit_OnPlayerDisconnect
		return edit_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect edit_OnPlayerDisconnect
#if defined edit_OnPlayerDisconnect
	forward edit_OnPlayerDisconnect(playerid, reason);
#endif