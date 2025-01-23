{
  lib,
  config,
  ...
}: let
  aliases = {
    "check" = ''nix-shell -p alejandra -p deadnix -p statix --command "alejandra -q . && deadnix -e && statix fix"'';
    "rebuild" = "sudo nixos-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";
  };
in {
  options.modules.fish.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # disable greeting
        fish_add_path /opt/homebrew/bin # add brew binaries to path
      '';
    };
    home.shellAliases = aliases;
  };
}
