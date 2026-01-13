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
        set fish_greeting  # disable greeting
        fish_vi_key_bindings  # enable vi mode
      '';

      functions = {
        fish_prompt = ''
          # Nix-shell info
          set -l nix_shell_info (
            if test -n "$IN_NIX_SHELL"
              echo -n -s (set_color yellow) "<nix-shell> " (set_color normal)
            end
          )

          # Get user and hostname
          set -l current_user (whoami)
          set -l host_name (hostname -s)

          # Build main prompt
          echo -n -s "$nix_shell_info" \
            (set_color green) "$current_user" \
            (set_color normal) "@" \
            (set_color blue) "$host_name" \
            (set_color normal) " " \
            (set_color cyan) (prompt_pwd) \
            (set_color normal) "> "
        '';

        fish_right_prompt = ''
          # Show vi mode indicator on the right
          if test $fish_key_bindings = "fish_vi_key_bindings"
            if commandline -M | string match -q '*'
              echo -n (set_color red) "NORMAL" (set_color normal)
            else
              echo -n (set_color green) "INSERT" (set_color normal)
            end
          end
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
