{
  lib,
  config,
  pkgs,
  base16,
  ...
}: let
  scheme = base16 "catppuccin-mocha";
in {
  options.modules.river.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.river.enable {
    home.packages = with pkgs; [
      wbg
      brightnessctl
      pamixer
      wlr-randr
    ];

    wayland.windowManager.river = {
      enable = true;
      xwayland.enable = false;

      extraConfig = ''
        ${pkgs.wlr-randr}/bin/wlr-randr --output eDP-1 --preferred --scale 2

        rivertile -view-padding 2 -outer-padding 4 -main-ratio 0.60 -main-location left &

        riverctl border-width 1
        riverctl border-color-focused 0x${scheme.base0E}ff
        riverctl border-color-unfocused 0x${scheme.base02}ff

        riverctl allow-tearing disabled

        riverctl keyboard-layout gb colemak -options ctrl:nocaps

        riverctl focus-follows-cursor never
        riverctl set-cursor-warp disabled
        riverctl hide-cursor when-typing

        riverctl input "type:touchpad" tap disabled
        riverctl input "type:touchpad" natural-scroll enabled
        riverctl input "type:touchpad" click-method clickfinger
        riverctl input "type:touchpad" middle-emulation enabled
        riverctl input "type:touchpad" disable-while-typing enabled

        riverctl map normal Super Return spawn 'kitty'
        riverctl map normal Super E spawn 'tofi-run | sh'
        riverctl map normal Super Q close
        riverctl map normal Super F toggle-fullscreen

        riverctl map normal Super 1 set-focused-tags $((1 << 0))
        riverctl map normal Super 2 set-focused-tags $((1 << 1))
        riverctl map normal Super 3 set-focused-tags $((1 << 2))
        riverctl map normal Super 4 set-focused-tags $((1 << 3))
        riverctl map normal Super 5 set-focused-tags $((1 << 4))
        riverctl map normal Super 6 set-focused-tags $((1 << 5))
        riverctl map normal Super 7 set-focused-tags $((1 << 6))
        riverctl map normal Super 8 set-focused-tags $((1 << 7))
        riverctl map normal Super 9 set-focused-tags $((1 << 8))
        riverctl map normal Super 0 set-focused-tags $((1 << 9))

        riverctl map normal Super+Shift 1 set-view-tags $((1 << 0))
        riverctl map normal Super+Shift 2 set-view-tags $((1 << 1))
        riverctl map normal Super+Shift 3 set-view-tags $((1 << 2))
        riverctl map normal Super+Shift 4 set-view-tags $((1 << 3))
        riverctl map normal Super+Shift 5 set-view-tags $((1 << 4))
        riverctl map normal Super+Shift 6 set-view-tags $((1 << 5))
        riverctl map normal Super+Shift 7 set-view-tags $((1 << 6))
        riverctl map normal Super+Shift 8 set-view-tags $((1 << 7))
        riverctl map normal Super+Shift 9 set-view-tags $((1 << 8))
        riverctl map normal Super+Shift 0 set-view-tags $((1 << 9))

        riverctl map normal Super Left focus-view previous
        riverctl map normal Super Right focus-view next
        riverctl map normal Super Up focus-view previous
        riverctl map normal Super Down focus-view next
        riverctl map normal Super H focus-view previous
        riverctl map normal Super L focus-view next

        riverctl map normal Super Space send-layout-cmd rivertile 'swap'

        riverctl map normal Super+Shift Left send-layout-cmd rivertile 'main-ratio -0.05'
        riverctl map normal Super+Shift Right send-layout-cmd rivertile 'main-ratio +0.05'

        riverctl map normal Super+Shift F toggle-float
        riverctl map normal Super+Shift Q exit

        riverctl map -repeat normal None XF86AudioRaiseVolume spawn '${pkgs.pamixer}/bin/pamixer -i 2'
        riverctl map -repeat normal None XF86AudioLowerVolume spawn '${pkgs.pamixer}/bin/pamixer -d 2'
        riverctl map -repeat normal None XF86AudioMute spawn '${pkgs.pamixer}/bin/pamixer -t'
        riverctl map -repeat normal None XF86AudioMicMute spawn '${pkgs.pamixer}/bin/pamixer --default-source -t'

        riverctl map -repeat normal None XF86MonBrightnessUp spawn '${pkgs.brightnessctl}/bin/brightnessctl set 1%+'
        riverctl map -repeat normal None XF86MonBrightnessDown spawn '${pkgs.brightnessctl}/bin/brightnessctl set 1%-'

        riverctl map -repeat normal Super XF86MonBrightnessUp spawn '${pkgs.brightnessctl}/bin/brightnessctl --class leds --device kbd_backlight set 1%+'
        riverctl map -repeat normal Super XF86MonBrightnessDown spawn '${pkgs.brightnessctl}/bin/brightnessctl --class leds --device kbd_backlight set 1%-'

        riverctl map-pointer normal Super BTN_RIGHT resize-view
        riverctl map-pointer normal Super BTN_MIDDLE move-view

        ${pkgs.wbg}/bin/wbg -s /home/alex/.config/wallpaper/wallpaper.png &
        waybar &
      '';
    };
  };
}
