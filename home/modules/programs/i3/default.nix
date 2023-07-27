{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.i3.desktopConfig.enable = lib.mkEnableOption "";
  options.homeModules.programs.i3.laptopConfig.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.i3.desktopConfig.enable {
      # Installation
      ## DONE VIA SYSTEM MODULE

      # Configuration
      xdg.configFile."i3/config".text = builtins.readFile ./config_desktop;
    })

    (lib.mkIf config.homeModules.programs.i3.laptopConfig.enable {
      # Installation
      ## DONE VIA SYSTEM MODULE

      # Configuration
      xdg.configFile."i3/config".text = builtins.readFile ./config_laptop;
    })
  ];
}
