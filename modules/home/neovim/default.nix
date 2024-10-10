{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.neovim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neovim.enable {
    home.packages = [
      pkgs.neovide
      # CMP Dependency
      pkgs.ripgrep
    ];

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
            colorscheme = "ayu_dark";
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
          enable = true;
          # This doesn't enable the plugin, it just enables autosaving when the plugin has been enabled. Idk why.
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

        cmp.enable = true;

        obsidian = {
          enable = true;
          settings = {
            workspaces = [
              {
                name = "Vault";
                path = "~/Vault";
              }
            ];
            completion = {
              nvim_cmp = true;
              min_chars = 2;
            };
          };
        };
      };

      colorschemes = {
        ayu.enable = true;
      };

      extraConfigLua =  builtins.readFile ./config/init.lua;
    };
  };
}
