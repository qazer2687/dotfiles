// config.h

// Gaps & Borders
static const int sloppyfocus = 1; /* focus follows mouse */
static const int smartgaps                 = 0;  /* 1 means no outer gap when there is only one window */
static const int monoclegaps               = 0;  /* 1 means outer gaps in monocle layout */
static const int bypass_surface_visibility = 0;  /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
static const unsigned int borderpx         = 2;  /* border pixel of windows */

static const unsigned int gappih    = 6;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 6;       /* vert inner gap between windows */
static const unsigned int gappoh    = 6;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 6;       /* vert outer gap between windows and screen edge */

// Colours
#define COLOR(RGBA) {((RGBA >> 24) & 0xFF) / 255.0f, \
                     ((RGBA >> 16) & 0xFF) / 255.0f, \
                     ((RGBA >> 8) & 0xFF) / 255.0f,  \
                     ((RGBA >> 0) & 0xFF) / 255.0f}

static const float rootcolor[] = COLOR(0x222222ff);
static const float fullscreen_bg[] = {0.1f, 0.1f, 0.1f, 1.0f};
static uint32_t colors[][3] = {
	/* fg         bg         border   */
	[SchemeNorm] = { 0xbbbbbbff, 0x222222ff, 0xaaaaaaff },
	[SchemeSel]  = { 0xeeeeeeff, 0x005577ff, 0xffffffff },
	[SchemeUrg]  = { 0,          0,          0xffffffff },
};

// Bar
static const int showbar = 1; /* 0 means no bar */
static const int topbar = 1;  /* 0 means bottom bar */
static const char *fonts[] = {"Departure Mono:size=12"};

// Tags
//#define TAGCOUNT (9)
// Used by bar-0.7.patch
static char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

// Logs
static int log_level = WLR_ERROR;

// Autostart
static const char *const autostart[] = {
    "sh", "-c", "waybar", NULL,
    "sh", "-c", "swaybg -i /home/alex/.config/wallpaper/wallpaper.png -m fill", NULL,
    NULL /* terminate */
};

/* NOTE: ALWAYS keep a rule declared even if you don't use rules (e.g leave at least one example) */
static const Rule rules[] = {
	/* app_id             title       tags mask     isfloating   monitor */
	/* examples: */
	{ "Gimp_EXAMPLE",     NULL,       0,            1,           -1 }, /* Start on currently visible tags floating, not tiled */
};

// Layout
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* monitors */
/* (x=-1, y=-1) is reserved as an "autoconfigure" monitor position indicator
 * WARNING: negative values other than (-1, -1) cause problems with Xwayland clients
 * https://gitlab.freedesktop.org/xorg/xserver/-/issues/899
*/
/* NOTE: ALWAYS add a fallback rule, even if you are completely sure it won't be used */
static const MonitorRule monrules[] = {
	/* name       mfact  nmaster scale layout       rotate/reflect                x    y */
	/* example of a HiDPI laptop monitor:
	{ "eDP-1",    0.5f,  1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
	*/
	/* defaults */
	{ NULL,       0.55f, 1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
};

// Keyboard
static const struct xkb_rule_names xkb_rules = {
    /* can specify fields: rules, model, layout, variant, options */
    /* example:
    .options = "ctrl:nocaps",
    */
    .options = NULL,
    .layout = "gb",
    .variant = "colemak",
};

static const int repeat_rate = 25;
static const int repeat_delay = 600;

// Trackpad
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 1;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 1;

/* You can choose between:
LIBINPUT_CONFIG_SCROLL_NO_SCROLL
LIBINPUT_CONFIG_SCROLL_2FG
LIBINPUT_CONFIG_SCROLL_EDGE
LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
*/
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;

/* You can choose between:
LIBINPUT_CONFIG_CLICK_METHOD_NONE
LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS
LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER
*/
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

/* You can choose between:
LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
*/
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

/* You can choose between:
LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
*/
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT;
static const double accel_speed = 0.0;

/* You can choose between:
LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
*/
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LMR;

/* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
#define MODKEY WLR_MODIFIER_LOGO

#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, SKEY,           tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,SKEY,toggletag, {.ui = 1 << TAG} }

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// Keybinds
static const Key keys[] = {
    /* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
    /* modifier-key-function-argument */
    
    // Launcher
    {MODKEY, XKB_KEY_e, spawn, SHCMD("tofi-run | sh")},
    
    // Terminal
    {MODKEY, XKB_KEY_Return, spawn, SHCMD("foot")},
    
    // Volume Control
    {0, XKB_KEY_XF86AudioRaiseVolume, spawn, SHCMD("pamixer -i 5")},
    {0, XKB_KEY_XF86AudioLowerVolume, spawn, SHCMD("pamixer -d 5")},
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
    {MODKEY, XKB_KEY_Left, movestack, {.i = -1}},
    {MODKEY, XKB_KEY_Right, movestack, {.i = +1}},

    {MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Q, quit, {0}},

	/* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_Terminate_Server, quit, {0} },
	/* Ctrl-Alt-Fx is used to switch to another VT, if you don't know what a VT is
	 * do not remove them.
	 */
#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

// Mouse Binds
static const Button buttons[] = {
  // Add a single, harmless entry to prevent "zero or negative size array" error.
	// This entry won't do anything as it has a NULL function pointer.
	{ 0, 0, 0, NULL, {0} }
};
