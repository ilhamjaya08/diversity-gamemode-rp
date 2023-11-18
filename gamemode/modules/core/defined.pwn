 /*
	Script Defined List
*/

//============================== SERVER CONFIGURATION =============================

#define SERVER_NAME                     "LIFEZONE ROLEPLAY"
#define SERVER_URL                      "ANANTA-ROLEPLAY.org"
#define SERVER_DISCORD					"https://discord.gg/Cc24SxaxGV"
#define SERVER_REVISION                 "F:RP v1.2a Native"

//==============================   SERVER MACROS 	=============================

#define Function:%0(%1)                 forward %0(%1); public %0(%1)
#define posArr{%0}                      %0[0], %0[1], %0[2]
#define posArrEx{%0}                    %0[0], %0 [1], %0[2], %0[3]

#define SpeedCheck(%0,%1,%2,%3,%4)      floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1) ) *%3*1.6)
#define RGBAToInt(%0,%1,%2,%3)          ((16777216 * (%0)) + (65536 * (%1)) + (256 * (%2)) + (%3))
#define PRESSED(%0)                     (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0)                     ((newkeys & (%0)) == (%0))

#define RELEASED(%0)				    (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define SendServerMessage(%0,%1)        SendClientMessageEx(%0, X11_LIGHT_SKY_BLUE_1, "SERVER: "WHITE""%1)
#define SendCustomMessage(%0,%1,%2)     SendClientMessageEx(%0, X11_LIGHT_SKY_BLUE_1, %1": "WHITE""%2)
#define SendSyntaxMessage(%0,%1)        SendClientMessageEx(%0, X11_GRAY, "KEGUNAAN: "%1)
#define SendErrorMessage(%0,%1)         SendClientMessageEx(%0, X11_GREY, "ERROR: "%1)
#define SendAdminAction(%0,%1)          SendClientMessageEx(%0, X11_TOMATO, "ADMIN: "%1)
	
#define PermissionError(%0)				SendClientMessageEx(%0, X11_GREY, "ERROR: Kamu tidak diizinkan menggunakan perintah ini!")

//================================ DYNAMIC SYSTEM ===============================
#define UTC_07							(25200)

#define MAX_ACC                         (4)
#define MAX_CHARACTERS                  (4)
#define MAX_WORKSHOP										(15)
#define MAX_DYNAMIC_JOBS                (25)
#define MAX_IMPOUND_LOTS                (20)
#define MAX_FACTIONS                    (15)
#define MAX_BILLBOARDS                  (50)
#define MAX_GARBAGE_BINS                (50)
#define MAX_ENTRANCES                   (100)
#define MAX_CRATES                      (200)
#define MAX_TEXTOBJECT                  (200)
#define MAX_BUSINESSES                  (100)
#define MAX_HOUSES                      (1000)
#define MAX_HOUSE_FURNITURE             (100)
#define SAVE_CHARACTERS_INTERVAL				(5) // Menyimpan data player setiap 5 menit
#define ENTRANCE_RECENT_TELEPORTED			(4) // Waktu minimum sebelum player bisa teleport lagi (dalam detik)
	
//#define MAX_RENT_POINT					(100)
//#define MAX_RENT_LIST					(5)

// Account and character variables
#define GetPlayerSQLID(%0)              PlayerData[%0][pID]
#define GetMoney(%0)                    PlayerData[%0][pMoney]
#define GetBank(%0)                     PlayerData[%0][pBankMoney]

#define ReturnAdminName(%0)             AccountData[%0][pUsername]
#define ReturnAdminRankName(%0)         AccountData[%0][pAdminRankName]
#define GetUCPSQLID(%0)                 AccountData[%0][pID]

#define NormalName(%0)                  CharacterList[%0][PlayerData[%0][pCharacter]]

#define MAX_ADS 						(100)

#define MIN_VIRTUAL_WORLD				(1000000)
#define MAX_VIRTUAL_WORLD				(1200000)

#define JOB_STOCK_LIMIT					(15000)

#define MAX_EMPLOYEE					(3) // 0 = Empty, 1, 2, 3 Filled

#define MAX_FREQ						(6)

#define MINIMUM_MILEAGE	 (20) // Batas minimum bisa melakukan maintenance kendaraan.
#define SAFE_MILEAGE		(100) // Rentang aman mileage kendaraan.

#define X_PHONE	(230)
