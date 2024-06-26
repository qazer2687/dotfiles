{
  lib,
  config,
  ...
}: {
  options.modules.skhd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.skhd.enable {
    services.skhd = {
      enable = true;
      skhdConfig = ''
        cmd - return : alacritty

        cmd - left : yabai -m window --swap west
        cmd - right : yabai -m window --swap east
        cmd - up : yabai -m window --swap north
        cmd - down : yabai -m window --swap south

        cmd + shift - left : yabai -m window west --resize right:-20:0 2> /dev/null || yabai -m window --resize right:-20:0
        cmd + shift - right : yabai -m window east --resize bottom:0:20 2> /dev/null || yabai -m window --resize bottom:0:20
        cmd + shift - up : yabai -m window north --resize top:0:-20 2> /dev/null || yabai -m window --resize top:0:-20
        cmd + shift - down : yabai -m window south --resize left:20:0 2> /dev/null || yabai -m window --resize left:20:0

        cmd - 1 : yabai -m space --focus 1
        cmd - 2 : yabai -m space --focus 2
        cmd - 3 : yabai -m space --focus 3
        cmd - 4 : yabai -m space --focus 4
        cmd - 5 : yabai -m space --focus 5
        cmd - 6 : yabai -m space --focus 6
        cmd - 7 : yabai -m space --focus 7
        cmd - 8 : yabai -m space --focus 8
        cmd - 9 : yabai -m space --focus 9
        cmd - 0 : yabai -m space --focus 10

        cmd + shift - 1 : yabai -m window --space 1; yabai -m space --focus 1
        cmd + shift - 2 : yabai -m window --space 2; yabai -m space --focus 2
        cmd + shift - 3 : yabai -m window --space 3; yabai -m space --focus 3
        cmd + shift - 4 : yabai -m window --space 4; yabai -m space --focus 4
        cmd + shift - 5 : yabai -m window --space 5; yabai -m space --focus 5
        cmd + shift - 6 : yabai -m window --space 6; yabai -m space --focus 6
        cmd + shift - 7 : yabai -m window --space 7; yabai -m space --focus 7
        cmd + shift - 8 : yabai -m window --space 8; yabai -m space --focus 8
        cmd + shift - 9 : yabai -m window --space 9; yabai -m space --focus 9
        cmd + shift - 0 : yabai -m window --space 10; yabai -m space --focus 10
      '';
    };
  };
}
