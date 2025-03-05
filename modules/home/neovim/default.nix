{
  lib,
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: let
  inherit (pkgs) lib;
  neovim = pkgs.tolerable-nvim.makeNeovimConfig "tolerable" {
    inherit pkgs;

    config = {
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        lazy-nvim
      ];
    };
    path = with pkgs; [
      lua-language-server
      nixd
      dotnet-sdk
    ];
};
in {
  options.modules.neovim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neovim.enable {
    home.packages = [
        neovim
    ];
  };
}
