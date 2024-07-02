{
  lib,
  config,
  inputs,
  ...
}: {
  options.modules.neovim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neovim.enable {
    inputs.nixvim.programs.nixvim = {
      enable = true;

      opts = {
        shiftwidth = 2;
        relativenumber = false;
        number = true;
        updatetime = 100;
      };

      plugins = {
        lightline = {
          enable = true;
        };

        nvim-tree = {
          enable = true;
          autoReloadOnWrite = true;
        };

        auto-save = {
          enable = false;
          enableAutoSave = true;
        };

        lsp = {
          enable = true;
          servers = {
            nixd.enable = true;
          };
        };
      };

      colorschemes = {
        catppuccin.enable = true;
      };
    };
  };
}
