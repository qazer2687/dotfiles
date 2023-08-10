{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.i3.desktopConfig.enable = lib.mkEnableOption "";
  options.homeModules.programs.i3.laptopConfig.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.i3.desktopConfig.enable {

      # Configuration
      xdg.configFile."i3/config".text = builtins.readFile ./config/desktop;
    })

    (lib.mkIf config.homeModules.programs.i3.laptopConfig.enable {

      # Configuration
      xdg.configFile."i3/config".text = builtins.readFile ./config/laptop;
    })
  ];
}
