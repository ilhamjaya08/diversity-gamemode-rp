#define FILTERSCRIPT

#include <a_samp>
#include <env>



static bool:no_redirect_download;
static string:base_url[128];



public OnFilterScriptInit()
{
  new
    bool:has_redirect_url = Env_Has("SERVER_MODEL_CACHE_BASE_URL")
  ;

  if (!has_redirect_url)
  {
    no_redirect_download = true;
    print("[0.3.DL] =====================================================================================");
    printf("[0.3.DL] You're NOT using RedirectDownload feature. The models cache download will be slowly.");
    print("[0.3.DL] =====================================================================================");
  }
  else
  {
    Env_Get("SERVER_MODEL_CACHE_BASE_URL", base_url, sizeof(base_url));
    print("[0.3.DL] =====================================================================================");
    printf("[0.3.DL] You're using RedirectDownload feature. The models cache download will going fast.");
    printf("[0.3.DL] Your base URL: %s", base_url);
    print("[0.3.DL] =====================================================================================");
  }

  return 1;
}

public OnPlayerRequestDownload(playerid, type, crc)
{
  if (IsPlayerNPC(playerid))
  {
    return 0;
  }

  if (!IsPlayerConnected(playerid))
  {
    return 0;
  }

  if (no_redirect_download)
  {
    return 1;
  }

  new
    full_url[256+1],
    file_name[64+1],
    found = 0
  ;

  if (type == DOWNLOAD_REQUEST_TEXTURE_FILE)
  {
    found = FindTextureFileNameFromCRC(crc, file_name, 64);
  }
  else if (type == DOWNLOAD_REQUEST_MODEL_FILE)
  {
    found = FindModelFileNameFromCRC(crc, file_name, 64);
  }

  if (found)
  {
    format(full_url, 256, "%s%s", base_url, file_name);
    RedirectDownload(playerid, full_url);
  }

  return 0;
}
