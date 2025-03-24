{
  lib,
  config,
  pkgs,
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
      "rebuild" = "sudo nixos-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";

      "nvim" = "nix run $HOME/.config/nvim#neovim";
    };
    # Do not use fish as the login shell as it is not posix compliant.
    programs.bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };
}
