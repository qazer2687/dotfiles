/* 1.6x Scaling */
user_pref("layout.css.devPixelsPerPx", 1.6);
/* Don't sync theme */
user_pref("services.sync.addons.ignoreUserEnabledChanges", true);
/* Limit content processes to reduce RAM usage */
user_pref("dom.ipc.processCount", 4);
user_pref("dom.ipc.processCount.webIsolated", 1);
/* Discard background tabs under memory pressure */
user_pref("browser.tabs.unloadOnLowMemory", true);