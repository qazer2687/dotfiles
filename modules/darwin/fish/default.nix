{
  lib,
  config,
  pkgs,
  ...
}: let
  aliases = {
    "rebuild" = "darwin-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";
    "check" = ''nix-shell -p alejandra -p deadnix -p statix --command "alejandra -q **/* && deadnix -e && statix fix"'';
  };
in {
  options.modules.fish.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fish.enable {
    programs.fish = {
      enable = true;
      shellAliases = aliases;
      interactiveShellInit = ''
        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      '';
    };
  };
}
