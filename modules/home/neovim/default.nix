{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.neovim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neovim.enable {
    home.packages = with pkgs; [
      # CMP Dependency
      gnumake
      unzip
      gcc
      ripgrep
    ];

    programs.nixvim = {
      enable = true;

      plugins = {
        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
            csharp_ls.enable = true;
            lua_ls.enable = true;
          };
        };

        cmp.enable = true;
      };
    };
  };
}
