{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.herbstluftwm.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.herbstluftwm.enable {
    services.xserver.windowManager.herbstluftwm = {
      enable = true;
      configFile = "/home/alex/.config/herbstluftwm/autostart";
    };
    environment.systemPackages = with pkgs; [
      dmenu
      scrot
      feh
    ];
    environment.etc."xdg/herbstluftwm/autostart".text = ''
      #!/usr/bin/env bash

      function hc() {
          herbstclient "$@"
      }

      hc emit_hook reload

      # Unbind Keys
      hc keyunbind --all
      hc mouseunbind --all

      # Keyboard
      Mod=Super
      hc keybind $Mod-q quit
      hc keybind $Mod-Shift-r reload
      hc keybind $Mod-Return spawn alacritty
      hc keybind $Mod-e spawn dmenu_run -i -b -nb "#111111" -sb "#ffffff" -nf "#ffffff" -sf "#000000" -fn "FiraCode Nerd Font"

      # Mouse
      hc mouseunbind --all
      hc mousebind $Mod-Button1 move
      hc mousebind $Mod-Button2 resize

      # Tags
      TAG_NAMES=( {1..6} )
      TAG_KEYS=( {1..6} 0 )

      hc rename default "''${TAG_NAMES[0]}" || true
      for i in ''${!TAG_NAMES[@]} ; do
        hc add "''${TAG_NAMES[$i]}"
        key="''${TAG_KEYS[$i]}"
        if ! [ -z "$key" ] ; then
          hc keybind "$Mod-$key" use_index "$i"
          hc keybind "$Mod-Shift-$key" move_index "$i"
        fi
      done

      # Gaps/Borders
      hc set frame_border_width 0
      hc set window_border_width 0
      hc set window_gap 4

      #Autostart Programs
      feh --bg-fill /home/alex/.config/wallpaper/wallpaper.png &
      polybar -c /etc/polybar/config.ini main &

      # Unlock
      hc unlock
    '';
  };
}