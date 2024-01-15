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
    };
    environment.systemPackages = with pkgs; [
      dmenu
      scrot
      feh
    ];
    environment.etc."xdg/herbstluftwm/autostart".text = ''
      #!/usr/bin/env bash

      # Shorten Name
      function hc() {
        herbstclient "$@"
      }
    
      # Reload
      hc emit_hook reload

      # Unbind Keys
      hc keyunbind --all
      hc mouseunbind --all

      # Keyboard
      Mod=Super
      hc keybind $Mod-q close
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


      for i in ''${!TAG_NAMES[@]} ; do
        hc add "''${TAG_NAMES[$i]}"
        key="''${TAG_KEYS[$i]}"
        if ! [ -z "$key" ] ; then
          hc keybind "$Mod-$key" use_index "$i"
          hc keybind "$Mod-Shift-$key" move_index "$i"
        fi
      done

      # Tiling
      hc set_layout horizontal
      hc keybind $Mod-Left shift left
      hc keybind $Mod-Down shift down
      hc keybind $Mod-Up shift up
      hc keybind $Mod-Right shift right

      # Gaps/Borders
      hc set frame_border_width 0
      hc set frame_bg_transparent 1
      hc set window_border_width 0
      hc set frame_padding 0
      hc set window_gap 8
      hc set frame_gap 0
      hc set always_show_frame 0
      hc set show_frame_decorations none

      hc attr theme.title_height 0

      #Autostart Programs
      feh --bg-fill /home/alex/.config/wallpaper/wallpaper.png &
      polybar -c /etc/polybar/config.ini main &

      # Unlock
      hc unlock
    '';
  };
}