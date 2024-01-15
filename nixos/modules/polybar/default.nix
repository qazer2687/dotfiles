{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.polybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.polybar.enable {
    environment.systemPackages = with pkgs; [
      polybarFull
    ];
    environment.etc."polybar/config.ini".text = ''
      [colors]
      background = #000000
      mantle = #000000
      crust = #000000

      white = #ffffff
      subtext0 = #ffffff
      subtext1 = #ffffff

      surface0 = #ffffff
      surface1 = #ffffff
      surface2 = #ffffff

      overlay0 = #ffffff
      overlay1 = #ffffff
      overlay2 = #ffffff


      blue = #ffffff
      lavender = #ffffff
      sapphire = #ffffff
      sky = #ffffffi show
      teal = #ffffff
      green = #ffffff
      yellow = #ffffff
      peach = #ffffff
      maroon = #ffffff
      red = #ffffff
      mauve = #ffffff
      pink = #ffffff
      flamingo = #ffffff
      foreground = #ffffff

      transparent = #FF00000

      [bar/main]
      monitor = ''${env:MONITOR:}
      width = 100%
      offset-x = 0
      offset-y = 8

      height = 50
      radius = 6.0
      bottom = false

      override-redirect = true

      background = ''${colors.background}
      foreground = ''${colors.foreground}

      padding-left = 2
      padding-right = 3
      module-margin-left = 2
      module-margin-right = 1

      font-0 = FiraCode Nerd Font:pixelsize=13:antialias=true;3
      font-1 = FiraCode Nerd Font:style=Regular:pixelsize=21:antialias=true;4.5
      font-2 = FiraCode Nerd Font:style=Regular:pixelsize=15:antialias=true;3

      modules-left = ewmh
      modules-center =
      modules-right = date

      cursor-click = pointer
      cursor-scroll = ns-resize

      [module/xwindow]
      type = internal/xwindow
      label = %title:0:25:...%

      [module/ewmh]
      type = internal/xworkspaces
      enable-scroll = false
      format-padding = 0
      format-background = #000000
      format = <label-state>

      label-active = " "
      label-active-foreground = #ffffff
      label-occupied = " "
      label-occupied-foreground = #ffffff
      label-urgent = " "
      label-urgent-foreground = #ff0000
      label-empty = " "
      label-empty-foreground = #000000

      [module/date]
      type = internal/date
      interval = 1

      date =
      date-alt = "%b %d, %Y  "
      time = "%I:%M"
      time-alt = "%H:%M:%S"

      format-prefix-foreground = ''${colors.foreground}
      format-underline = #0a6cf5
      label = %date%%time%

      [module/audio]
      type = internal/pipewire

      format-volume = <ramp-volume>
      label-volume-foreground = ''${colors.teal}
      ramp-volume-foreground = ''${colors.teal}
      label-volume =

      ramp-volume-0 = 
      ramp-volume-1 = 
      ramp-volume-2 = 

      label-muted = ﱝ
      label-muted-foreground = #ffffff

      [settings]
      screenchange-reload = true
      ;compositing-background = xor
      ;compositing-background = screen
      ;compositing-foreground = source
      ;compositing-border = over
      ;pseudo-transparency =true

      [global/wm]
      margin-bottom = 20
    '';
  };
}