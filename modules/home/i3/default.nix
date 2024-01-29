{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.i3.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.i3.enable {

    home.packages = with pkgs; [
      dmenu
      scrot
      feh
      gnome.nautilus
      redshift
    ];
    xdg.configFile."i3/config".text = builtins.readFile ./config/default;
  };
}
