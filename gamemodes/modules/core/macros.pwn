/*==============================================================================
    Macros
==============================================================================*/

#define IsPlayerInjured(%0)             PlayerData[%0][pInjured]
#define GetPlayerLastVehicle(%0)        PlayerData[%0][pLastCar]

#define GetAdminLevel(%0)               AccountData[%0][pAdmin]
#define IsAdminOnDuty(%0)               AccountData[%0][pAdminDuty]

#define GetPlayerFaction(%0)            PlayerData[%0][pFaction]
#define GetPlayerFactionID(%0)          PlayerData[%0][pFactionID]
#define IsPlayerDuty(%0)                PlayerData[%0][pOnDuty]

#define SetSweeperDelay(%0,%1)          PlayerData[%0][pSweeperDelay] = %1
#define GetSweeperDelay(%0)             PlayerData[%0][pSweeperDelay]

#define SetBusDelay(%0,%1)              PlayerData[%0][pBusDelay] = %1
#define GetBusDelay(%0)                 PlayerData[%0][pBusDelay]

#define SetTrashmasterDelay(%0,%1)      PlayerData[%0][pTrashmasterDelay] = %1
#define GetTrashmasterDelay(%0)         PlayerData[%0][pTrashmasterDelay]

#define SetMoneytransDelay(%0,%1)       PlayerData[%0][pMoneytransDelay] = %1
#define GetMoneytransDelay(%0)          PlayerData[%0][pMoneytransDelay]

#define SetBoxvilleDelay(%0,%1)         PlayerData[%0][pBoxvilleDelay] = %1
#define GetBoxvilleDelay(%0)            PlayerData[%0][pBoxvilleDelay]

#define GetPlayerJob(%0)                PlayerData[%0][pJob]

#define AddBankMoney(%0,%1)             PlayerData[%0][pBankMoney]+= %1

#define CheckAdmin(%0,%1)               AccountData[%0][pAdmin] < %1
