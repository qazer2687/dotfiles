{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.vscode.jade.enable = lib.mkEnableOption "";
  options.homeModules.vscode.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.vscode.jade.enable {
      # Installation & Configuration
      programs.vscode = {
        enable = true;
        #        package = pkgs.vscode-fhs;
        extensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          pkief.material-icon-theme
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          naumovs.color-highlight
          tamasfe.even-better-toml
          ms-dotnettools.csharp
        ];
        #        userSettings = {
        #          "files.autoSave" = "on";
        #          "editor.tabSize" = 2;
        #        };
      };
    })

    (lib.mkIf config.homeModules.vscode.ruby.enable {
      # Installation & Configuration
      programs.vscode = {
        enable = true;
        #        package = pkgs.vscode-fhs;
        extensions = with pkgs.vscode-extensions; [
          pkief.material-icon-theme
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          naumovs.color-highlight
          tamasfe.even-better-toml
          ms-dotnettools.csharp
          zhuangtongfa.material-theme
        ];
        #        userSettings = {
        #          "files.autoSave" = "on";
        #          "editor.tabSize" = 2;
        #        };
      };
    })
  ];
}
