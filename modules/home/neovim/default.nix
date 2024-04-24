{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.neovim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neovim.enable {
    programs.nixvim = {
      enable = true;
    };
  };
}
