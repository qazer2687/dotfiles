{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.starship.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.starship.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        rust = {
          format = "via [󰒓 $version](red bold) ";
        };
        nix-shell = {
          format = "on [$state nix-shell](bold blue) ";
        };
      };
    };
  };
}
