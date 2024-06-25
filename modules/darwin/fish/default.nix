{
  lib,
  config,
  pkgs,
  ...
}: let
  aliases = {
    "rebuild" = "darwin-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";
  };
in {
  options.modules.fish.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fish.enable {
    programs.fish = {
      enable = true;
      shellAliases = aliases;
    };
  };
}
