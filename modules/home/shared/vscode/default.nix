{
  lib,
  config,
  pkgs,
  base16,
  ...
}: let
  scheme = base16 "gruvbox";
in {
  options.modules.vscode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vscode.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      package = pkgs.vscodium-fhs;
      
      userSettings = {
        # Editor
        "editor.fontFamily" = "TX02";
        "editor.scrollbar.horizontal" = "hidden";
        "editor.scrollbar.vertical" = "hidden";
        "editor.renderWhitespace" = "none";
        "editor.minimap.enabled" = false;
        "editor.minimap.renderCharacters" = false;
        "editor.minimap.showSlider" = "always";
        "editor.codeLens" = false;
        "editor.glyphMargin" = false;
        "editor.stickyScroll.enabled" = false;
        "editor.stickyScroll.defaultModel" = "indentationModel";
        "[nix].editor.defaultFormatter" = "jnoortheen.nix-ide";

        # Git
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "git.ignoreRebaseWarning" = true;
        "git.openRepositoryInParentFolders" = "always";

        # File & Explorer
        "files.autoSave" = "afterDelay";
        "files.exclude" = {
          "**/__pycache__" = true;
          "**/.direnv" = true;
        };
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.compactFolders" = false;
        "symbols.hidesExplorerArrows" = false;

        # Workbench / UI
        "workbench.iconTheme" = "symbols";
        "workbench.panel.showLabels" = false;
        "workbench.editor.enablePreview" = false;
        "workbench.editor.tabSizingFixedMinWidth" = 40;
        "workbench.layoutControl.enabled" = false;
        "workbench.navigationControl.enabled" = false;
        "breadcrumbs.enabled" = false;
        "window.titleBarStyle" = "native";
        "window.menuBarVisibility" = "toggle";
        "window.commandCenter" = false;

        # Terminal
        "terminal.external.linuxExec" = "foot";
        "terminal.integrated.tabs.enabled" = false;

        # Diff Editor
        "diffEditor.ignoreTrimWhitespace" = false;

        # Remote / Nix
        "remote.autoForwardPortsSource" = "hybrid";
        "nix.enableLanguageServer" = true;

        # TypeScript
        "typescript.tsserver.web.projectWideIntellisense.enabled" = false;

        # Direnv
        "direnv.restart.automatic" = true;

        # Base16 UI
        "workbench.colorCustomizations" = {
          "editor.background" = "#${scheme.base00}";
          "editor.foreground" = "#${scheme.base05}";
          "editorLineNumber.foreground" = "#${scheme.base03}";
          "editorLineNumber.activeForeground" = "#${scheme.base05}";
          "editor.selectionBackground" = "#${scheme.base02}";
          "editorCursor.foreground" = "#${scheme.base05}";
          "editorWhitespace.foreground" = "#${scheme.base03}";
          "editorIndentGuide.background" = "#${scheme.base01}";
          "editorIndentGuide.activeBackground" = "#${scheme.base03}";
          "activityBar.background" = "#${scheme.base00}";
          "sideBar.background" = "#${scheme.base01}";
          "statusBar.background" = "#${scheme.base00}";
          "statusBar.foreground" = "#${scheme.base05}";
          "titleBar.activeBackground" = "#${scheme.base00}";
          "titleBar.activeForeground" = "#${scheme.base05}";
          "editorBracketMatch.background" = "#${scheme.base02}";
          "editorBracketMatch.border" = "#${scheme.base04}";
          "editor.selectionHighlightBackground" = "#${scheme.base01}";
        };

        # Base16 Syntax
        "editor.tokenColorCustomizations" = {
          "comments" = "#${scheme.base03}";
          "keywords" = "#${scheme.base0E}";
          "functions" = "#${scheme.base0D}";
          "strings" = "#${scheme.base0B}";
          "numbers" = "#${scheme.base09}";
          "types" = "#${scheme.base0A}";
          "variables" = "#${scheme.base08}";
          "constants" = "#${scheme.base0C}";
          "classes" = "#${scheme.base0E}";
          "interfaces" = "#${scheme.base0A}";
          "properties" = "#${scheme.base08}";
          "punctuation" = "#${scheme.base05}";
          "operators" = "#${scheme.base0C}";
          "decorators" = "#${scheme.base0F}";
        };
      };
      
    };
  };
}
