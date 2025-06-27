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
      '';
      
      
      functions = {
        fish_prompt = ''
          set -l nix_shell_info (
            if test -n "$IN_NIX_SHELL"
              echo -n -s (set_color yellow) "<nix-shell> " (set_color normal)
            end
          )
          
          # Get user and hostname with default colors
          set -l user (whoami)
          set -l hostname (hostname -s)
          
          # Default fish prompt styling
          echo -n -s "$nix_shell_info" \
            (set_color green) "$user" \
            (set_color normal) "@" \
            (set_color blue) "$hostname" \
            (set_color normal) " " \
            (set_color cyan) (prompt_pwd) \
            (set_color normal) "> "
        '';
        
        nix-shell = ''
          command nix-shell --run fish $argv
        '';
      };
    };
    
    home.shellAliases = {
      "check" = ''nix-shell -p alejandra -p deadnix -p statix --command "alejandra -q . && deadnix -e && statix fix"'';
      "rebuild" = "nh os switch github:qazer2687/dotfiles -H $(hostname) -- --refresh --option eval-cache false";
      "reboot" = ''printf "Are you sure you want to reboot? [N/y]\n"; read -n 1 confirm; test "$confirm" = y && sudo reboot'';
    };
  };
}