#include <mapandreas>
#include <Pawn.RakNet>
#include <YSI\y_timers>

// Ini untuk define waktu yang ditolerir ketika ada RPC VehicleDeath masuk.
#define ANTICHEAT_VEHICLE_TOLERANCE_TIME (2000)
// Nilai minimum kedalaman untuk kendaraan dianggap telah tenggelam.
#define MIN_DEPTH_VEHICLE_DROWNED        (0.5)

new
    countNotification[MAX_PLAYERS],
    countNotificationLastCheck[MAX_PLAYERS]
;

hook OnGameModeInit()
{
    MapAndreas_Init(MAP_ANDREAS_MODE_NOBUFFER, "scriptfiles/SAfull.hmap");
    return 1;
}

hook OnGameModeExit()
{
    MapAndreas_Unload();
    return 1;
}

hook OnPlayerConnect(playerid)
{
    countNotification[playerid] = 0;
}
hook OnPlayerDisconnect(playerid, reason)
{
    countNotification[playerid] = 0;
}

task ResetNotification[1000]()
{
    foreach(new i : Player)
    {
        if ((GetTickCount() - countNotificationLastCheck[i]) >= ANTICHEAT_VEHICLE_TOLERANCE_TIME)
        {
            countNotification[i] = 0;
        }
    }
}

timer Anticheat_RespawnVehicle[1000](vehicleid)
{
    SetVehicleToRespawn(vehicleid);
    return 1;
}

timer Anticheat_IsVehicleDrown[1000](playerid, vehicleid)
{
    // 
    // playerid harus ter-connect.
    if (!IsPlayerConnected(playerid))
    {
        return 1;
    }

    // vehicleid harus valid (alias harus ada di server).
    if (!IsValidVehicle(vehicleid))
    {
        return 1;
    }

    new
        Float:x,
        Float:y,
        Float:z_samp, // Untuk menyimpan ketinggian berdasarkan koordinat dari SA-MP
        Float:z_mapandreas, // Untuk menyimpan ketinggian berdasarkan koordinat dari MapAndreas
        Float:vehiclehealth,
        name[MAX_PLAYER_NAME+1],
        ip[20]
    ;

    // Mendapatkan posisi 3 dimensi berdasarkan SA-MP.
    GetVehiclePos(vehicleid, x, y, z_samp);
    // Mendapatkan ketinggian berdasarkan MapAndreas.
    MapAndreas_FindZ_For2DCoord(x, y, z_mapandreas);

    // Mendapatkan nama player yang melaporkan kendaraan tersebut telah rusak.
    GetPlayerName(playerid, name, sizeof(name));
    // Mendapatkan alamat IP player yang melaporkan kendaraan tersebut telah rusak.
    GetPlayerIp(playerid, ip, sizeof(ip));
    GetVehicleHealth(vehicleid, vehiclehealth);

    if (z_mapandreas > 0.00)
    {
        if(countNotification[playerid] < 5)
        {
            SendAdminMessage(X11_TOMATO_1, "[ADMIN WARN]: (%d) %s (IP: %s) melaporkan kendaraan ID [%d] telah rusak, namun vehicle tersebut belum meledak.",  playerid, name, ip, vehicleid); 
            printf("Vehicleid [%d] is not dead. current vehicle health: %.2f | playerid reported: %d | IP : %s", vehicleid, vehiclehealth, playerid, ip);
            // Tambah hitungan bahwa player ini memanggil RPC dengan tidak wajar.
            countNotification[playerid]++;
            // Waktu terakhir ketika terjadinya pemanggilan RPC.
            countNotificationLastCheck[playerid] = GetTickCount();
        }
        else
        {
            Kick(playerid);
        }

        return 1;
    }

    // Jika kendaraannya adalah perahu, maka tidak perlu pemeriksaan ini (karena hampir tidak mungkin tenggelam)
    if (IsABoat(vehicleid))
    {
        return 1;
    }

    // Mendapatkan nilai absolut dari posisi kendaraan.
    new Float:delta = floatabs(z_samp);

    // Jika sudah tercapai kedalaman minimum, maka kendaraan dihancurkan melalui callback OnVehicleDeath.
    if (delta > MIN_DEPTH_VEHICLE_DROWNED)
    {
        CallRemoteFunction("OnVehicleDeath", "dd", vehicleid, playerid);
        // SendAdminMessage(X11_TOMATO_1, "[ADMIN WARN]: (%d) %s (IP: %s) melaporkan kendaraan ID [%d] tenggelam.",  playerid, name, ip, vehicleid); 
        printf("Vehicleid [%d] is drowned. current vehicle health: %.2f | x: %.2f | y: %.2f | z Vehicle Pos: %.2f | z MapAndreas: %.2f | playerid reported: %d | IP : %s", vehicleid, vehiclehealth, x, y, z_samp, z_mapandreas, playerid, ip);

        defer Anticheat_RespawnVehicle(vehicleid);
    }
    else
    {
        defer Anticheat_IsVehicleDrown(playerid, vehicleid);
    }

    return 1;
}


// Disable oleh ananta
// forward OnIncomingRPC(playerid, rpcid, BitStream:bs);
// public OnIncomingRPC(playerid, rpcid, BitStream:bs)
// {
//     if (rpcid != 136)
//     {
//         return 1;
//     }

//     new
//         vehicleid,
//         Float:vehiclehealth
//     ;

//     // BS_IgnoreBits(bs, 8); // ignore packetid (byte)
// //    BS_ReadUint8(bs, vehicleid);
//     BS_ReadUint16(bs, vehicleid);
// //    printf("BS_ReadInt8 -> vehicleid: %d", vehicleid);
//     printf("BS_ReadInt16 -> vehicleid: %d", vehicleid);

//     GetVehicleHealth(vehicleid, vehiclehealth);
//     printf("playerid: %d | rpcid: %d | vehicleid: %d | health: %.2f", playerid, rpcid, vehicleid, vehiclehealth);
//     if (vehiclehealth >= 250.0)
//     {
//         defer Anticheat_IsVehicleDrown(playerid, vehicleid);
//         return 0;
//     }

//     return 1;
// }

