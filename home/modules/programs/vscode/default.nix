{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.vscode.desktopConfig.enable = lib.mkEnableOption "";
  options.homeModules.programs.vscode.laptopConfig.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.vscode.desktopConfig.enable {
      
      # Installation & Configuration
      programs.vscode = {
        enable = true;
        package = pkgs.vscode-fhs;
        extensions = with pkgs.vscode-extensions; [
          ms-dotnettools.csharp
          catppuccin.catppuccin-vsc
          pkief.material-icon-theme
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          naumovs.color-highlight
        ];
        userSettings = {
          "files.autoSave" = "on";
          "editor.tabSize" = 2;
        };
      };
    })

    (lib.mkIf config.homeModules.programs.vscode.laptopConfig.enable {

      # Installation & Configuration
      programs.vscode = {
        enable = true;
        package = pkgs.vscode-fhs;
        extensions = with pkgs.vscode-extensions; [
          ms-dotnettools.csharp
          catppuccin.catppuccin-vsc
          pkief.material-icon-theme
          jnoortheen.nix-ide
          rust-lang.rust-analyzer
          naumovs.color-highlight
        ];
        userSettings = {
          "files.autoSave" = "on";
          "editor.tabSize" = 2;
        };
      };
    })
  ];
}