#if defined _inc_StaticLocations
  #endinput
#endif

// Enumerations
enum E_STATIC_LOCATION_TYPE
{
  LOCATION_NONE = 0,
  LOCATION_BLACKMARKET,
  LOCATION_MATERIAL_STORE,
  LOCATION_SEEDS_SHOP,
  LOCATION_ADVERTISEMENT,
  LOCATION_INSURANCE,
  LOCATION_TAKEPILLS,
  LOCATION_TREATMENT,
  LOCATION_UNDRAG
};


Location_IsPlayerAt(playerid, E_STATIC_LOCATION_TYPE:type)
{
  return CallRemoteFunction("SL_IsPlayerAtLocation", "dd", playerid, _:type);
}

Location_UpdateLabelsByType(E_STATIC_LOCATION_TYPE:type, string:text[])
{
  if (strlen(text) == 0)
  {
    return -1;
  }

  if (isnull(text))
  {
    return -1;
  }

  return CallRemoteFunction("SL_UpdateLocationLabelsByType", "ds", _:type, text);
}
