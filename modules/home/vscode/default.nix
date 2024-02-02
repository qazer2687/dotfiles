{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.vscode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vscode.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      package = pkgs.vscodium-fhs;
      extensions = with pkgs.vscode-extensions; [
        # UI Theme
        jdinhlife.gruvbox

        # Icon Theme
        pkief.material-icon-theme

        # Nix
        jnoortheen.nix-ide
        
        # C#
        ms-dotnettools.csharp

        # Rust
        rust-lang.rust-analyzer
        serayuzgur.crates

        # Other
        naumovs.color-highlight
        tamasfe.even-better-toml
        mkhl.direnv
      ];
      userSettings = {
        "window.menuBarVisibility" = "toggle";
        "workbench.startupEditor" = "none";
        "workbench.iconTheme" = "material-icon-theme";
        "files.autoSave" = "afterDelay";
        "haskell.manageHLS" = "GHCup";
        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.tabSize" = 2;
        "editor.detectIndentation" = false;
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "editor.fontFamily" = "'FiraCode Nerd Font'";
        "workbench.statusBar.visible" = false;
        "editor.minimap.enabled" = false;
        "breadcrumbs.enabled" = false;
        "window.zoomLevel" = 2;
      };
    };
  };
}
