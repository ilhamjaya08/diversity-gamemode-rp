#include <YSI\y_hooks>

#include <a_samp>
#include <streamer>

new Timer:sholatTimer;

// Waktu sholat di WIB (Waktu Indonesia Barat)
new sholatTimes[5] = {5, 12, 15, 18, 19}; // Subuh, Dzuhur, Ashar, Maghrib, Isya

public OnGameModeInit()
{
    // Registrasi timer pada saat inisialisasi
        sholatTimer = SetTimer("CheckSholatTime", 60000, true); // Setiap menit
            return 1;
            }

            public CheckSholatTime(timerid, time)
            {
                new hour, minute;
                    gettime(hour, minute);

                        // Periksa waktu sholat
                            for (new i = 0; i < sizeof(sholatTimes); i++)
                                {
                                        if (hour == sholatTimes[i] && minute == 0)
                                                {
                                                            // Kirim pesan ke semua pemain
                                                                        SendClientMessageToAll(-1, 0xFFFFFFFF, "Sudah waktunya sholat untuk Waktu Indonesia Barat!");
                                                                                    break; // Keluar dari loop setelah mengirim pesan
                                                                                            }
                                                                                                }
                                                                                                    return 1;
                                                                                                    }