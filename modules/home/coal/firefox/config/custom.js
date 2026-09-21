/* 1.6x Scaling */
user_pref("layout.css.devPixelsPerPx", 1.2);

/* Don't sync theme */
user_pref("services.sync.addons.ignoreUserEnabledChanges", true);

/* Re-enable GPU rendering (overrides stale prefs.js entries forcing software WebRender) */
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.software", false);
user_pref("gfx.canvas.azure.accelerated", true);