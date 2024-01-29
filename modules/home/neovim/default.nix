{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.neovim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neovim.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        lualine-nvim
        nvim-cmp
        nvim-tree-lua
        vim-colemak
      ];
    };
  };
}
