#if defined _inc_callbacks
  #undef _inc_callbacks
#endif
#if defined ADMIN_CALLBACKS
  #endinput
#endif
#define ADMIN_CALLBACKS



forward OnPlayerLookupCharStats(playerid);
public OnPlayerLookupCharStats(playerid)
{
  if (cache_num_rows() == 0)
  {
    return SendErrorMessage(playerid, "Nama karakter yang kamu masukkan tidak terdaftar di server!.");
  }

  new
    id,
    username[MAX_PLAYER_NAME + 1],
    character[MAX_PLAYER_NAME + 1],
    job,
    virtual,
    money,
    phone,
    gender,
    bank,
    faction,
    interior,
    mask,
    warnings,
    faction_rank,
    register_date,
    playing_hours,
    score_math,
    header[10],
    gameplay_second,
    gameplay_minute,
    gameplay_hour,
    origin[32],
    birth_date[32],
    admin_level,
    vip_type,
    vip_expired,
    coin,
    dialog_string[3072]
  ;

  id = cache_get_field_int(0, "ID");
  cache_get_field_content(0, "Username", username, MAX_PLAYER_NAME + 1);
  cache_get_field_content(0, "Character", character, MAX_PLAYER_NAME + 1);
  job = cache_get_field_int(0, "Job");
  virtual = cache_get_field_int(0, "World");
  money = cache_get_field_int(0, "Money");
  phone = cache_get_field_int(0, "Phone");
  gender = cache_get_field_int(0, "Gender");
  bank = cache_get_field_int(0, "BankMoney");
  faction = cache_get_field_int(0, "Faction");
  interior = cache_get_field_int(0, "Interior");
  mask = cache_get_field_int(0, "MaskID");
  warnings = cache_get_field_int(0, "Warnings");
  faction_rank = cache_get_field_int(0, "FactionRank");
  register_date = cache_get_field_int(0, "RegisterDate");
  playing_hours = cache_get_field_int(0, "PlayingHours");
  score_math = ((cache_get_field_int(0, "pScore") + 1) * 4);
  cache_get_field_content(0, "Played", header, 64);
  sscanf(header, "p<|>ddd", gameplay_second, gameplay_minute, gameplay_hour);
  cache_get_field_content(0, "Origin", origin, 32);
  cache_get_field_content(0, "Birthdate", birth_date, 32);
  admin_level = cache_get_field_int(0, "Admin");

  new Cache:additional_cache = mysql_query(g_iHandle, sprintf("" \
    "SELECT" \
    "  `dc`.`type`," \
    "  `dc`.`expired`," \
    "  `dcl`.`coins`" \
    "FROM" \
    "  `donation_characters` AS `dc`" \
    "LEFT JOIN `donation_coin_list` AS `dcl` ON `dc`.`pid` = `dcl`.`pid`" \
    "WHERE" \
    "  `dc`.`pid` = %d;"
    , id
  ));

  if (cache_num_rows())
  {
    vip_type = cache_get_field_int(0, "type");
    vip_expired = cache_get_field_int(0, "expired");
    coin = cache_get_field_int(0, "coins");
  }

  cache_delete(additional_cache);

  new
    factionid = GetFactionByID(faction)
  ;

  format(dialog_string, sizeof(dialog_string), "" \
    ""TOMATO"In Character\n" \
    ""WHITE"Name: ["LIGHTBLUE"%s"WHITE"] ("YELLOW"%d"WHITE") | Gender: ["LIGHTBLUE"%s"WHITE"] | Birthdate: ["LIGHTBLUE"%s"WHITE"] | Money: ["GREEN"%s"WHITE"] | Bank: ["GREEN"%s"WHITE"]\n" \
    "Origin: ["LIGHTBLUE"%s"WHITE"] | Phone Number: ["LIGHTBLUE"%d"WHITE"] | Job: ["LIGHTBLUE"%s"WHITE"] | Faction: ["LIGHTBLUE"%s"WHITE"] | Faction Rank: ["LIGHTBLUE"%s"WHITE"]\n\n" \
    ""TOMATO"Out of Character\n" \
    ""WHITE"Username: ["LIGHTBLUE"%s"WHITE"] | Registered Email: ["RED"(removed)"WHITE"] | Registration Date: ["LIGHTBLUE"%s"WHITE"]\n" \
    "Time Played: ["LIGHTBLUE"%d hour(s) %d minute(s) %02d second(s)"WHITE"] | Level point(s): ["LIGHTBLUE"%d/%d"WHITE"] | MaskID: ["LIGHTBLUE"Mask_#%d"WHITE"]\n" \
    "Interior: ["LIGHTBLUE"%d"WHITE"] | Virtual World: ["LIGHTBLUE"%d"WHITE"] | Last Vehicle ID: ["LIGHTBLUE"%d"WHITE"] | Warnings: ["ORANGE"%d"WHITE"/"RED"20"WHITE"]\n" \
    "UCoin: ["LIGHTBLUE"%d"WHITE"]\n"
    // In Character
    , character, id, gender == 1 ? ("Male") : ("Female"), birth_date, FormatNumber(money), FormatNumber(bank)
    , origin, phone, (job == JOB_NONE) ? ("None") : (Job_GetName(job)), (factionid == -1) ? ("Civilian") : (GetInitials(FactionData[factionid][factionName])), faction_rank
    // Out of Character
    , username, ConvertTimestamp(Timestamp:register_date)
    , gameplay_hour, gameplay_minute, gameplay_second, playing_hours, score_math, mask
    , interior, virtual, -1, warnings
    , coin
  );

  if (admin_level)
  {
    format(dialog_string, sizeof(dialog_string), "" \
      "%s\n\nAdmin Level: %d"WHITE"\n"
      , dialog_string, admin_level
    );
  }

  if (vip_type)
  {
    format(dialog_string, sizeof(dialog_string), "" \
      "%s\n\nVIP: ["GREEN"%d"WHITE"] | Expired: ["LIGHTBLUE"%s"WHITE"]"WHITE"\n"
      , dialog_string, vip_type, ConvertTimestamp(Timestamp:vip_expired)
    );
  }

  Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_MSGBOX, sprintf("Character Statistics - "LIGHTBLUE"%s", ConvertTimestamp(Timestamp:Now())), dialog_string, "Close", "");
  SendServerMessage(playerid, "Melihat statistik karakter "YELLOW"%s.", username);
  return 1;
}