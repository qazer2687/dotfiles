{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.wluma.ruby.enable = lib.mkEnableOption "";
  config = lib.mkIf config.homeModules.wluma.ruby.enable {
    home.packages = with pkgs; [wluma];

    xdg.configFile."wluma/config.toml".text = builtins.readFile ./config/laptop;
  };
}
