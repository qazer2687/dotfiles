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
          if set -q IN_NIX_SHELL
            set_color yellow
            echo -n "<nix-shell> "
            set_color normal
          end

          # Build main prompt
          set_color green
          echo -n "$USER"
          set_color normal
          echo -n "@"
          set_color blue
          echo -n "$hostname"
          set_color normal
          echo -n " "
          set_color cyan
          echo -n (prompt_pwd)
          set_color normal
          echo -n "> "
        '';

        # Run fish inside nix-shell.
        nix-shell = ''
          command nix-shell --run fish $argv
        '';
      };
    };

    home.shellAliases = {
      "check" = ''nix-shell -p alejandra -p deadnix -p statix --command "alejandra -q . && deadnix -e && statix fix"'';
      # Add --show-activation-hints in version 4.3.0+.
      # https://github.com/nix-community/nh/issues/500
      "rebuild" = "nh os switch github:qazer2687/dotfiles -H $(hostname) -- --refresh --option eval-cache false";
      "reboot" = ''printf "Are you sure you want to reboot? [N/y]\n"; read -n 1 confirm; test "$confirm" = y && sudo reboot'';
    };
  };
}
