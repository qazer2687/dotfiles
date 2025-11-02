{
  lib,
  config,
  pkgs,
  base16,
  ...
}: let
  scheme = base16 "mountain";
in {
  options.modules.vscode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium-fhs;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
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

          "workbench.colorCustomizations" = {
            "editor.background" = "#${scheme.base00}";
            "editor.foreground" = "#${scheme.base05}";
            "editorGroup.background" = "#${scheme.base00}";
            "editorGroupHeader.tabsBackground" = "#${scheme.base00}";
            "editorGroup.emptyBackground" = "#${scheme.base00}";
            "editorWidget.background" = "#${scheme.base00}";
            "editorHoverWidget.background" = "#${scheme.base00}";
            "editor.lineHighlightBackground" = "#${scheme.base01}";
            "editor.selectionBackground" = "#${scheme.base02}";
            "editor.selectionHighlightBackground" = "#${scheme.base01}";
            "editorCursor.foreground" = "#${scheme.base05}";
            "editorLineNumber.foreground" = "#${scheme.base04}";
            "editorLineNumber.activeForeground" = "#${scheme.base05}";
            "editorWhitespace.foreground" = "#${scheme.base04}";
            "editorIndentGuide.background" = "#${scheme.base01}";
            "editorIndentGuide.activeBackground" = "#${scheme.base03}";
            "editorBracketMatch.border" = "#${scheme.base04}";
            "editorBracketMatch.background" = "#${scheme.base01}";
            "sideBar.background" = "#${scheme.base01}";
            "sideBar.foreground" = "#${scheme.base05}";
            "activityBar.background" = "#${scheme.base00}";
            "activityBar.foreground" = "#${scheme.base05}";
            "statusBar.background" = "#${scheme.base00}";
            "statusBar.foreground" = "#${scheme.base05}";
            "titleBar.activeBackground" = "#${scheme.base00}";
            "titleBar.activeForeground" = "#${scheme.base05}";
            "tab.activeBackground" = "#${scheme.base00}";
            "tab.inactiveBackground" = "#${scheme.base01}";
            "tab.activeForeground" = "#${scheme.base05}";
            "tab.inactiveForeground" = "#${scheme.base05}";
            "panel.background" = "#${scheme.base00}";
            "panel.border" = "#${scheme.base01}";
            "terminal.background" = "#${scheme.base00}";
            "minimap.background" = "#${scheme.base00}";
          };

          "editor.tokenColorCustomizations" = {
            textMateRules = [
              {
                scope = "comment";
                settings.foreground = "#${scheme.base05}";
                settings.fontStyle = "italic";
              }
              {
                scope = "keyword";
                settings.foreground = "#${scheme.base0E}";
              }
              {
                scope = "storage.type";
                settings.foreground = "#${scheme.base0A}";
              }
              {
                scope = "variable";
                settings.foreground = "#${scheme.base08}";
              }
              {
                scope = "variable.parameter";
                settings.foreground = "#${scheme.base08}";
              }
              {
                scope = "entity.name.function";
                settings.foreground = "#${scheme.base0D}";
              }
              {
                scope = "entity.name.class";
                settings.foreground = "#${scheme.base0A}";
              }
              {
                scope = "entity.name.tag";
                settings.foreground = "#${scheme.base08}";
              }
              {
                scope = "string";
                settings.foreground = "#${scheme.base0B}";
              }
              {
                scope = "constant.numeric";
                settings.foreground = "#${scheme.base09}";
              }
              {
                scope = "support.constant";
                settings.foreground = "#${scheme.base0C}";
              }
              {
                scope = "punctuation";
                settings.foreground = "#${scheme.base05}";
              }
              {
                scope = "keyword.operator";
                settings.foreground = "#${scheme.base0C}";
              }
              {
                scope = "meta.decorator";
                settings.foreground = "#${scheme.base0F}";
              }
              {
                scope = "invalid";
                settings.foreground = "#${scheme.base08}";
                settings.background = "#${scheme.base00}";
              }
              {
                scope = "markup.diff.deleted";
                settings.foreground = "#${scheme.base08}";
              }
              {
                scope = "markup.diff.inserted";
                settings.foreground = "#${scheme.base0B}";
              }
            ];
          };
        };
      };
    };
  };
}
