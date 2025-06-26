{
  lib,
  config,
  ...
}: {
  options.modules.fish.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # disable greeting
        #fish_add_path /opt/homebrew/bin # add brew binaries to path
      '';
    };
    home.shellAliases = {
      "check" = ''nix-shell -p alejandra -p deadnix -p statix --command "alejandra -q . && deadnix -e && statix fix"'';
      "rebuild" = "nh os switch github:qazer2687/dotfiles -H $(hostname) -- --refresh --option eval-cache false";
      "reboot" = ''printf "Are you sure you want to reboot? [N/y]\n"; read -n 1 confirm; test "$confirm" = y && sudo reboot'';
    };
  };
}
