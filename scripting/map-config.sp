#include <sourcemod>

#define PATH_MAP_CONFIGS_FULL "cfg/sourcemod/maps-configs/"
#define PATH_MAP_CONFIGS_RELATIVE "sourcemod/maps-configs/"

public Plugin myinfo = {
    name = "Map config",
    author = "Kalbmar",
    description = "Executes a map config",
    version = "1.0.0",
    url = "https://github.com/kalbmar/map-config"
};

public void OnAutoConfigsBuffered() {
    LoadMapConfig();
}

void LoadMapConfig() {
    char mapName[PLATFORM_MAX_PATH];
    char mapConfigPath[PLATFORM_MAX_PATH];

    GetCurrentMap(mapName, sizeof(mapName));
    Format(mapConfigPath, sizeof(mapConfigPath), "%s%s.cfg", PATH_MAP_CONFIGS_FULL, mapName);

    if (!FileExists(mapConfigPath)) {
        LogMessage("No config for map: %s", mapName);
        return;
    }

    ServerCommand("exec %s%s", PATH_MAP_CONFIGS_RELATIVE, mapName);
    LogMessage("Loaded map config: %s.cfg", mapName);
}
