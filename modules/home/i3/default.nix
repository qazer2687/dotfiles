{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.i3.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.i3.enable {

    xsession = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-rounded;
        extraConfig = builtins.readFile ./config/default;
      };
    };

    home.packages = with pkgs; [
      dmenu
      scrot
      feh
      gnome.nautilus
      redshift
    ];
  };
}
