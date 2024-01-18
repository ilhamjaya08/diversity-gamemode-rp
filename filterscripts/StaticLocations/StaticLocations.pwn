// Macros
#define FILTERSCRIPT
#define AREA_EXTRAID_OFFSET   1_000_000
#define MAX_STATIC_LOCATIONS  101
#define INVALID_AREA_ID       -1



// Includes
#include <a_samp>
#include <streamer>
#include <YSI_Server\y_colors>



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
  LOCATION_UNDRAG,
  LOCATION_BOXVILLE
};

enum E_STATIC_LOCATION_DATA
{
  ID,
  E_STATIC_LOCATION_TYPE:LOCATION_TYPE,
  Float:POS_X,
  Float:POS_Y,
  Float:POS_Z,
  WORLD_ID,
  INTERIOR_ID,
  // Related to streamer.
  AREA_ID,
  MAPICON_ID,
  Text3D:TEXT3D_ID,
  PICKUP_ID,
  PICKUP_MODEL_ID
};



// Variables
static gLastStaticLocationID;
static gStaticLocations[MAX_STATIC_LOCATIONS][E_STATIC_LOCATION_DATA];
static gPlayerStaticLocation[MAX_PLAYERS + 1];



// Forwards
forward SL_IsPlayerAtLocation(playerid, E_STATIC_LOCATION_TYPE:type);
forward SL_UpdateLocationLabelsByType(E_STATIC_LOCATION_TYPE:type, const text[]);



// Static functions
static IsValidStaticLocationType(E_STATIC_LOCATION_TYPE:type)
{
  if (
    type != LOCATION_BLACKMARKET
    && type != LOCATION_MATERIAL_STORE
    && type != LOCATION_SEEDS_SHOP
    && type != LOCATION_ADVERTISEMENT
    && type != LOCATION_INSURANCE
    && type != LOCATION_TAKEPILLS
    && type != LOCATION_TREATMENT
    && type != LOCATION_UNDRAG
  ) {
    return 0;
  }

  return 1;
}

static AddStaticLocation(E_STATIC_LOCATION_TYPE:type, const text[], Float:x, Float:y, Float:z, pickup_model_id, mapicon_model_id = -1, worldid = 0, interiorid = 0)
{
  if (gLastStaticLocationID >= (MAX_STATIC_LOCATIONS - 1))
  {
    printf("[ERROR] Cannot add static location anymore.");
    return 0;
  }

  if (!IsValidStaticLocationType(type))
  {
    printf("[ERROR] Invalid static location type. Found: %d", _:type);
    return 0;
  }

  gStaticLocations[gLastStaticLocationID][LOCATION_TYPE] = type;
  gStaticLocations[gLastStaticLocationID][AREA_ID] = CreateDynamicSphere(x, y, z, 3.0, worldid, interiorid);
  gStaticLocations[gLastStaticLocationID][PICKUP_ID] = CreateDynamicPickup(pickup_model_id, 1, x, y, z, worldid, interiorid);
  gStaticLocations[gLastStaticLocationID][TEXT3D_ID] = CreateDynamic3DTextLabel(text, 0xFFFFFFFF, x, y, z, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, worldid, interiorid);
  Streamer_SetIntData(STREAMER_TYPE_AREA, gStaticLocations[gLastStaticLocationID][AREA_ID], E_STREAMER_EXTRA_ID, AREA_EXTRAID_OFFSET + gLastStaticLocationID);

  if (mapicon_model_id > -1)
  {
    gStaticLocations[gLastStaticLocationID][MAPICON_ID] = CreateDynamicMapIcon(x, y, z, mapicon_model_id, -1, worldid, interiorid, -1, STREAMER_MAP_ICON_SD, MAPICON_LOCAL);
  }

  printf("text: %s, x: %.2f, y: %.2f, z: %.2f, worldid: %d, interiorid: %d", text, x, y, z, worldid, interiorid);
  gLastStaticLocationID += 1;
  return 1;
}



// Public functions
public SL_IsPlayerAtLocation(playerid, E_STATIC_LOCATION_TYPE:type)
{
  if (playerid < 0 || playerid >= MAX_PLAYERS)
  {
    return -1;
  }

  new
    player_static_location = gPlayerStaticLocation[playerid]
  ;

  if (player_static_location < 1 || player_static_location > (MAX_STATIC_LOCATIONS - 1))
  {
    return -1;
  }

  new
    E_STATIC_LOCATION_TYPE:static_location_type = gStaticLocations[player_static_location][LOCATION_TYPE]
  ;

  if (static_location_type != type)
  {
    return -1;
  }

  return 1;
}

public SL_UpdateLocationLabelsByType(E_STATIC_LOCATION_TYPE:type, const text[])
{
  if (!IsValidStaticLocationType(type))
  {
    return -1;
  }

  for (new i = 0; i < MAX_STATIC_LOCATIONS; i++)
  {
    if (gStaticLocations[i][LOCATION_TYPE] == type)
    {
      UpdateDynamic3DTextLabelText(gStaticLocations[i][TEXT3D_ID], 0xFFFFFFFF, text);
    }
  }

  return 1;
}



// Callbacks
public OnFilterScriptInit()
{
  gLastStaticLocationID = 1;

  for (new i = 0; i < MAX_PLAYERS; i++)
  {
    gPlayerStaticLocation[i] = INVALID_AREA_ID;
  }

  // Blackmarket
  AddStaticLocation(LOCATION_BLACKMARKET, "[Black Market]\n\
  "WHITE"Type "YELLOW"/creategun"WHITE" to create illegal items\n\
  "WHITE"Type "YELLOW"/createammo"WHITE" to create ammmo\n\
  "WHITE"Type "YELLOW"/repairgun"WHITE" to repair gun's durability\n\
  "WHITE"Type "YELLOW"/craft"WHITE" to craft illegal items\
  ", -50.3808, -232.8592, 6.7646, 1239);
  // Material store
  // Seeds shop
  AddStaticLocation(LOCATION_SEEDS_SHOP, "[Seeds Shop]\n\
  "WHITE"Type "YELLOW"/buyseeds"WHITE" to buy seeds\n\
  "GREEN"$999/seed\
  ", 870.3907, -25.1175, 63.9701, 1239);
  // Advertisement
  AddStaticLocation(LOCATION_ADVERTISEMENT, "[Advertisement]\n\
  "WHITE"Type "YELLOW"/ad"WHITE" to make advertisement\
  ", 665.549011,-1396.465087,801.358764, 1239, .interiorid = 7, .worldid = 7174);
  // Insurance
  AddStaticLocation(LOCATION_INSURANCE, "[Insurance Center]\n\
  "WHITE"Type "YELLOW"/buyinsurance"WHITE" to buy insurance\n\
  "WHITE"Type "YELLOW"/claiminsurance"WHITE" to release vehicle\
  ", 1111.6217, -1795.6040, 16.5938, 1239);
  // Take pill
  AddStaticLocation(LOCATION_TAKEPILLS, "[Medical Treatment]\n\
  "WHITE"Type "YELLOW"/takepills"WHITE" to get the pills\
  ", 1833.0256, -1077.9353, 41.6537, 1239, .interiorid = 110, .worldid = 100_000);
  // Treatment
  AddStaticLocation(LOCATION_TREATMENT, "[Medical Treatment]\n\
  "WHITE"Type "YELLOW"/treatment"WHITE" to get medical treatment\n\
  "GREEN"$1,000\
  ", 1855.3845, -1079.0844, 41.6537, 1239, .interiorid = 110, .worldid = 100_000);
  // Undrag
  AddStaticLocation(LOCATION_UNDRAG, "[Medical Treatment]\n\
  "WHITE"Type "YELLOW"/undrag"WHITE" to drop injured body to get treated\n\
  "GREEN"$500\
  ", 1839.1530, -1102.4099, 41.6537, 1239, .interiorid = 110, .worldid = 100_000);

  return 1;
}

public OnFilterScriptExit()
{
  for (new i = 0; i < MAX_PLAYERS; i++)
  {
    gPlayerStaticLocation[i] = INVALID_AREA_ID;
  }

  return 1;
}

public OnPlayerConnect(playerid)
{
  gPlayerStaticLocation[playerid] = INVALID_AREA_ID;
  return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
  new extraid = Streamer_GetIntData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID);

  if (extraid < 1)
  {
    return 1;
  }

  gPlayerStaticLocation[playerid] = (extraid - AREA_EXTRAID_OFFSET);
  return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
  gPlayerStaticLocation[playerid] = INVALID_AREA_ID;
  return 1;
}
