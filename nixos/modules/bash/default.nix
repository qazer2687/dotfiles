{
  lib,
  config,
  ...
}: let
  aliases = {
    "check" = "alejandra -q **/* && deadnix -e && statix fix";
    "rebuild" = "sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles#$(hostname) --refresh --option eval-cache false";
    "rebuild-local" = "sudo nixos-rebuild switch --flake .#$(hostname)";
  };
in {
  options.modules.bash.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.bash.enable {
    programs.bash = {
      shellAliases = aliases;
    };
  };
}
