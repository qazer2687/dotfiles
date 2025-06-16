// config.h

// Gaps & Borders
static const int sloppyfocus = 1; /* focus follows mouse */
static const int smartgaps = 0;  /* 1 means no outer gap when there is only one window */
static const int monoclegaps = 0;  /* 1 means outer gaps in monocle layout */
static const int bypass_surface_visibility = 0;  /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
static const unsigned int borderpx = 2;  /* border pixel of windows */

static const unsigned int gappih = 6;       /* horiz inner gap between windows */
static const unsigned int gappiv = 6;       /* vert inner gap between windows */
static const unsigned int gappoh = 6;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov = 6;       /* vert outer gap between windows and screen edge */

// Colours
#define COLOR(hex) {((hex >> 24) & 0xFF) / 255.0f, \
                    ((hex >> 16) & 0xFF) / 255.0f, \
                    ((hex >> 8) & 0xFF) / 255.0f, \
                    (hex & 0xFF) / 255.0f }
static const float rootcolor[] = COLOR(0xaaaaaaff);
static const float bordercolor[] = COLOR(0xaaaaaaff);
static const float focuscolor[] = COLOR(0xffffffff);
static const float urgentcolor[] = COLOR(0xffffffff);
static const float fullscreen_bg[] = {0.1f, 0.1f, 0.1f, 1.0f};

// Tags
#define TAGCOUNT (9)

// Logs
static int log_level = WLR_ERROR;

// Autostart
static const char *const autostart[] = {
    "/bin/sh", "-c", "waybar", NULL,
    "/bin/sh", "-c", "wbg /home/alex/.config/wallpaper/wallpaper.png", NULL,
    "/bin/sh", "-c", "gnome-keyring-daemon --start --components=secrets", NULL,
    NULL
};

// Window Rules
static const Rule rules[] = {
	{ "EXAMPLE",     NULL,       0,            0,           -1 },
};

// Layout
static const Layout layouts[] = {
	{ "[]=",      tile },
};

// Display
static const MonitorRule monrules[] = {
	{ NULL,       0.75f, 1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
};

// Keyboard
static const struct xkb_rule_names xkb_rules = {
  .options = NULL,
  .layout = "gb",
  .variant = "colemak",
};
static const int repeat_rate = 25;
static const int repeat_delay = 600;

// Trackpad - Refer to config.def.h for available options.
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 1;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 1;
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT;
static const double accel_speed = 0.0;
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LMR;

#define MODKEY WLR_MODIFIER_LOGO

#define TAGKEYS(KEY,SKEY,TAG) \
	{MODKEY,                    KEY,            view,            {.ui = 1 << TAG}}, \
	{MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG}}, \
	{MODKEY|WLR_MODIFIER_SHIFT, SKEY,           tag,             {.ui = 1 << TAG}}, \
	{MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,SKEY,toggletag, {.ui = 1 << TAG}}

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// Keybinds
static const Key keys[] = {
  // Launcher
  {MODKEY, XKB_KEY_e, spawn, SHCMD("tofi-run | sh")},
  
  // Terminal
  {MODKEY, XKB_KEY_Return, spawn, SHCMD("foot")},
  
  // Volume Control
  {0, XKB_KEY_XF86AudioRaiseVolume, spawn, SHCMD("pamixer -i 2")},
  {0, XKB_KEY_XF86AudioLowerVolume, spawn, SHCMD("pamixer -d 2")},
  {0, XKB_KEY_XF86AudioMute, spawn, SHCMD("pamixer -t")},
  
  // Brightness Control
  {0, XKB_KEY_XF86MonBrightnessUp, spawn, SHCMD("brightnessctl set 1%+")},
  {0, XKB_KEY_XF86MonBrightnessDown, spawn, SHCMD("brightnessctl set 1%-")},
  
  // Backlight Control
  {MODKEY, XKB_KEY_XF86MonBrightnessUp, spawn, SHCMD("brightnessctl --class leds --device kbd_backlight set 10%+")},
  {MODKEY, XKB_KEY_XF86MonBrightnessDown, spawn, SHCMD("brightnessctl --class leds --device kbd_backlight set 10%-")},

  {MODKEY, XKB_KEY_q, killclient, {0}},
  {MODKEY, XKB_KEY_f, togglefullscreen, {0}},

  // Tag Navigation & Manipulation
  TAGKEYS(XKB_KEY_1, XKB_KEY_exclam, 0),
  TAGKEYS(XKB_KEY_2, XKB_KEY_quotedbl, 1),
  TAGKEYS(XKB_KEY_3, XKB_KEY_sterling, 2),
  TAGKEYS(XKB_KEY_4, XKB_KEY_dollar, 3),
  TAGKEYS(XKB_KEY_5, XKB_KEY_percent, 4),
  TAGKEYS(XKB_KEY_6, XKB_KEY_asciicircum, 5),
  TAGKEYS(XKB_KEY_7, XKB_KEY_ampersand, 6),
  TAGKEYS(XKB_KEY_8, XKB_KEY_asterisk, 7),
  TAGKEYS(XKB_KEY_9, XKB_KEY_parenleft, 8),

  // Window Manipulation
  {MODKEY,                       XKB_KEY_Left,       focusstack,     {.i = -1}},
  {MODKEY,                       XKB_KEY_Right,      focusstack,     {.i = +1}},
  {MODKEY,                       XKB_KEY_Up,         focusstack,     {.i = -1}},
  {MODKEY,                       XKB_KEY_Down,       focusstack,     {.i = +1}},

  {MODKEY,                       XKB_KEY_space,      zoom,           {0}},

  {MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_Left,       setmfact,       {.f = -0.0125}},
  {MODKEY|WLR_MODIFIER_SHIFT,    XKB_KEY_Right,      setmfact,       {.f = +0.0125}},

  {MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Q, quit, {0}},

  {WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_Terminate_Server, quit, {0}},

#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

// Mouse Binds
static const Button buttons[] = {
  {MODKEY, BTN_LEFT, NULL, {0} },
};
