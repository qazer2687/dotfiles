{
  lib,
  config,
  pkgs,
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
        treesitter = {
          enable = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            bash
            json
            lua
            make
            markdown
            nix
            regex
            toml
            vim
            vimdoc
            xml
            yaml
          ];
        };


        lightline = {
          enable = true;
          settings = {
            colorscheme = "material";
          };
        };

        telescope = {
          enable = true;
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
