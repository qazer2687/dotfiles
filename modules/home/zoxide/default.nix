{
  lib,
  config,
  ...
}: {
  options.modules.zoxide.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    home.shellAliases = {
      "cd" = "z";
      "rebuild" = "sudo nixos-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";

      #"nvim" = "nix run $HOME/.config/nvim#neovim";
    };
  };
}
