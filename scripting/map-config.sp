#include <sourcemod>

#define PATH_MAP_CONFIGS_FULL "cfg/sourcemod/maps-configs/"
#define PATH_MAP_CONFIGS_RELATIVE "sourcemod/maps-configs/"
#define PERMISSIONS_USER (FPERM_U_READ | FPERM_U_WRITE | FPERM_U_EXEC)
#define PERMISSIONS_GROUP (FPERM_G_READ | FPERM_G_WRITE | FPERM_G_EXEC)
#define PERMISSIONS_OTHER (FPERM_O_READ | FPERM_O_EXEC | FPERM_O_WRITE)
#define PERMISSIONS (PERMISSIONS_USER | PERMISSIONS_GROUP | PERMISSIONS_OTHER)

public Plugin myinfo = {
    name = "Map config",
    author = "Kalbmar",
    description = "Executes a map config",
    version = "1.0.0",
    url = "https://github.com/kalbmar/map-config"
};

public void OnPluginStart() {
    BuildDirectory();
}

void BuildDirectory() {
    if (!DirExists(PATH_MAP_CONFIGS_FULL)) {
        CreateDirectory(PATH_MAP_CONFIGS_FULL, PERMISSIONS);
    }
}

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
