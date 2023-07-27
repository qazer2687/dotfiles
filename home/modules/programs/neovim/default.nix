{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.neovim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.neovim.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        lualine-nvim
        nvim-cmp
        nvim-tree-lua
      ];
    };
  };
}
