
#include "generated_plugin_registrant.h"

#include <firebase_core/firebase_core_plugin_c_api.h>
#include <geolocator_windows/geolocator_windows.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>

void RegisterPlugins(flutter::PluginRegistry *registry)
{
    FirebaseCorePluginCApiRegisterWithRegistrar(
        registry->GetRegistrarForPlugin("FirebaseCorePluginCApi"));
    GeolocatorWindowsRegisterWithRegistrar(
        registry->GetRegistrarForPlugin("GeolocatorWindows"));
    PermissionHandlerWindowsPluginRegisterWithRegistrar(
        registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
}