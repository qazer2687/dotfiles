{
  lib,
  config,
  inputs,
  ...
}: {
  options.modules.neovim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neovim.enable {
    programs.nixvim = {
      enable = true;

      opts = {
        relativenumber = false;
        number = false;
        updatetime = 100;

        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        softtabstop = 2;
      };

      plugins = {
        lightline = {
          enable = true;
          settings = {
            colorscheme = "material";
          };
        };

        nvim-tree = {
          enable = true;
          autoReloadOnWrite = true;
        };

        auto-save = {
          enable = false;
          # This doesn't enable the plugin, it just enables autosaving when the plugin has been enabled.
          settings = {
            enabled = true;
          };
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
