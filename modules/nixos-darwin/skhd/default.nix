{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.skhd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.skhd.enable {
    services.skhd = {
      enable = true;
      skhdConfig = ''
        cmd - return : /Applications/Alacritty.app/Contents/MacOS/alacritty --working-directory ~

        cmd - left : yabai -m window --focus west
        cmd - right : yabai -m window --focus east
        cmd - up : yabai -m window --focus north
        cmd - down : yabai -m window --focus south

        cmd + shift - left : yabai -m window --swap west
        cmd + shift - right : yabai -m window --swap east
        cmd + shift - up : yabai -m window --swap north
        cmd + shift - down : yabai -m window --swap south

        cmd - 1 : yabai -m display --focus 1
        cmd - 2 : yabai -m display --focus 2
        cmd - 3 : yabai -m display --focus 3
        cmd - 4 : yabai -m display --focus 4
        cmd - 5 : yabai -m display --focus 5
        cmd - 6 : yabai -m display --focus 6
        cmd - 7 : yabai -m display --focus 7
        cmd - 8 : yabai -m display --focus 8
        cmd - 9 : yabai -m display --focus 9
        cmd - 0 : yabai -m display --focus 10

        cmd + shift - 1 : yabai -m window --display 1; yabai -m display --focus 1
        cmd + shift - 2 : yabai -m window --display 2; yabai -m display --focus 2
        cmd + shift - 3 : yabai -m window --display 3; yabai -m display --focus 3
        cmd + shift - 4 : yabai -m window --display 4; yabai -m display --focus 4
        cmd + shift - 5 : yabai -m window --display 5; yabai -m display --focus 5
        cmd + shift - 6 : yabai -m window --display 6; yabai -m display --focus 6
        cmd + shift - 7 : yabai -m window --display 7; yabai -m display --focus 7
        cmd + shift - 8 : yabai -m window --display 8; yabai -m display --focus 8
        cmd + shift - 9 : yabai -m window --display 9; yabai -m display --focus 9
        cmd + shift - 0 : yabai -m window --display 10; yabai -m display --focus 10
      '';
    };
  };
}
