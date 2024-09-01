{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.vscode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vscode.enable {
    programs.vscode = {
      enable = true;
      #enableUpdateCheck = false;
      #enableExtensionUpdateCheck = false;
      package = pkgs.vscodium-fhs;
      extensions = with inputs.nix-vscode-extensions.extensions."${pkgs.system}".vscode-marketplace; [
        # UI Theme
        #ankitpati.vscodium-amoled

        # Icon Theme
        #wilfriedago.vscode-symbols-icon-theme

        # Nix
        jnoortheen.nix-ide

        # HTML
        yandeu.five-server

        # C#
        ms-dotnettools.csharp
        #muhammad-sammy.csharp

        # Other
        naumovs.color-highlight
        aaron-bond.better-comments
        mkhl.direnv
      ];

      userSettings = {
        # Editor
        "editor.stickyScroll.enabled" = false;
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;
        "editor.cursorBlinking" = "smooth";
        "editor.scrollbar.horizontal" = "hidden";
        "editor.scrollbar.vertical" = "hidden";
        "editor.renderWhitespace" = "none";
        "editor.minimap.renderCharacters" = false;
        "editor.minimap.showSlider" = "always";
        "editor.minimap.enabled" = false;
        "editor.fontFamily" = "Agave, FiraCode Nerd Font";
        "editor.fontSize" = 16;
        "editor.codeLens" = false;

        # Files & Explorer
        "files.autoSave" = "afterDelay";
        "explorer.confirmDelete" = false;
        "symbols.hidesExplorerArrows" = false;
        "breadcrumbs.enabled" = false;

        # Git
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "git.ignoreRebaseWarning" = true;
        "git.openRepositoryInParentFolders" = "always";

        # Terminal
        "terminal.integrated.smoothScrolling" = true;
        "terminal.integrated.scrollback" = 100000;

        # Workbench & UI
        "workbench.colorTheme" = "AMOLED";
        "workbench.iconTheme" = "symbols";
        "workbench.list.smoothScrolling" = true;
        "workbench.statusBar.visible" = false;
        "window.menuBarVisibility" = "toggle";
        "debug.showInlineBreakpointCandidates" = false;
      };
    };
  };
}
