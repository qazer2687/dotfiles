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
      "rebuild" = "sudo nh os switch github:qazer2687/dotfiles#$(hostname) -H $(hostname) -- --refresh --option eval-cache false";
      #"nvim" = "nix run $HOME/.config/nvim#neovim";
    };
  };
}
