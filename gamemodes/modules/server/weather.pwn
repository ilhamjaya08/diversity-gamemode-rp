new current_hour, current_weather;
new fine_weather_ids[] = {2,3,4,5,6,7,12,13,14,15,17};
new wet_weather_ids[] = {8};

hook OnGameModeInit() {
    gettime(current_hour, _);
}


CMD:setweather(playerid, params[])
{
    new weatherid;

    if (CheckAdmin(playerid, 5))
        return PermissionError(playerid);

    if(sscanf(params, "d", weatherid))
        return SendSyntaxMessage(playerid, "/setweather [weather ID]");

    current_weather = weatherid;

    foreach(new x : Player) if(!GetPlayerInterior(playerid)) {
        SetPlayerWeather(x, current_weather);
    }
    SendClientMessageToAllEx(X11_WHITE,"[ADMIN] "COL_LIGHTBLUE"%s "WHITE"have changed the weather ID",ReturnName2(playerid,0));
    SendServerMessage(playerid, "You have changed the weather to ID: %d.", weatherid);
    return 1;
}


task UpdateWeatherAndTime[3600000]()
{
    gettime(current_hour, _);

    new next_weather_prob = random(91);

    if(next_weather_prob < 70)      current_weather = fine_weather_ids[random(sizeof(fine_weather_ids))];
    else                            current_weather = wet_weather_ids[0];

    foreach(new i : Player) if(!GetPlayerInterior(i)) {
        SetPlayerWeather(i, current_weather);
        RealTime_SyncPlayerWorldTime(i);
    }
}