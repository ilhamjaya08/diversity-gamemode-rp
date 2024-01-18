/*	Varible List */
new MySQL:g_iHandle;
new color_string[3256], object_font[200];
new Text3D:vehicle3Dtext[MAX_VEHICLES], newbieschool, playerauction, Text:gServerTextdraws[6];

new 
    mechanic_zone_main, 
    mechanic_zone_repair[2], 
    mechanic_zone_ship, 
    tempatganja[7], 
    prison_zone
;

new 
    safe_zone[18],
    farm_zone[2]
;

//Global Variable
new Seatbelt[MAX_PLAYERS], Helmet[MAX_PLAYERS], TimerVote;
new LuckyMine[MAX_PLAYERS];
new ListedAcc[MAX_PLAYERS][MAX_ACC];