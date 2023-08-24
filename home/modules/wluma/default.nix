
{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.wluma.enable = lib.mkEnableOption "";
  config = lib.mkIf config.homeModules.wluma.enable {
    home.packages = with pkgs; [wluma];
    
    xdg.configFile."wluma/config.toml".text = builtins.readFile ./config/laptop;
  };
}