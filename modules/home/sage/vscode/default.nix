{
  lib,
  config,
  pkgs,
  base16,
  ...
}: let
  scheme = base16 "black-metal";
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
            # Editor
            "editor.background" = "#${scheme.base00}";
            "editor.foreground" = "#${scheme.base05}";
            "editorLineNumber.foreground" = "#${scheme.base03}";
            "editorLineNumber.activeForeground" = "#${scheme.base04}";
            "editorCursor.foreground" = "#${scheme.base05}";
            
            # Selection
            "editor.selectionBackground" = "#${scheme.base02}";
            "editor.selectionHighlightBackground" = "#${scheme.base02}80"; # with transparency
            "editor.inactiveSelectionBackground" = "#${scheme.base02}60";
            "editor.wordHighlightBackground" = "#${scheme.base03}80";
            "editor.wordHighlightStrongBackground" = "#${scheme.base03}";
            
            # Line highlighting
            "editor.lineHighlightBackground" = "#${scheme.base01}";
            "editor.lineHighlightBorder" = "#${scheme.base01}";
            
            # Whitespace and guides
            "editorWhitespace.foreground" = "#${scheme.base03}";
            "editorIndentGuide.background" = "#${scheme.base02}";
            "editorIndentGuide.activeBackground" = "#${scheme.base03}";
            "editorRuler.foreground" = "#${scheme.base02}";
            
            # Bracket matching
            "editorBracketMatch.border" = "#${scheme.base03}";
            "editorBracketMatch.background" = "#${scheme.base01}";
            
            # Gutter
            "editorGutter.background" = "#${scheme.base00}";
            "editorGutter.addedBackground" = "#${scheme.base0B}";
            "editorGutter.deletedBackground" = "#${scheme.base08}";
            "editorGutter.modifiedBackground" = "#${scheme.base0E}";
            
            # Widgets
            "editorWidget.background" = "#${scheme.base01}";
            "editorWidget.border" = "#${scheme.base03}";
            "editorSuggestWidget.background" = "#${scheme.base01}";
            "editorSuggestWidget.border" = "#${scheme.base03}";
            "editorSuggestWidget.selectedBackground" = "#${scheme.base02}";
            "editorHoverWidget.background" = "#${scheme.base01}";
            "editorHoverWidget.border" = "#${scheme.base03}";
            
            # Find/Replace
            "editor.findMatchBackground" = "#${scheme.base0A}60";
            "editor.findMatchHighlightBackground" = "#${scheme.base0A}40";
            "editor.findRangeHighlightBackground" = "#${scheme.base02}";
            
            # Errors and warnings
            "editorError.foreground" = "#${scheme.base08}";
            "editorWarning.foreground" = "#${scheme.base09}";
            "editorInfo.foreground" = "#${scheme.base0D}";
            
            # Editor groups
            "editorGroup.border" = "#${scheme.base02}";
            "editorGroup.background" = "#${scheme.base00}";
            "editorGroup.emptyBackground" = "#${scheme.base00}";
            "editorGroupHeader.tabsBackground" = "#${scheme.base01}";
            "editorGroupHeader.noTabsBackground" = "#${scheme.base00}";
            
            # Tabs
            "tab.activeBackground" = "#${scheme.base00}";
            "tab.activeForeground" = "#${scheme.base05}";
            "tab.inactiveBackground" = "#${scheme.base01}";
            "tab.inactiveForeground" = "#${scheme.base04}";
            "tab.border" = "#${scheme.base00}";
            "tab.activeBorder" = "#${scheme.base0D}";
            "tab.unfocusedActiveBorder" = "#${scheme.base03}";
            "tab.activeBorderTop" = "#${scheme.base0D}";
            "tab.unfocusedActiveBorderTop" = "#${scheme.base03}";
            "tab.hoverBackground" = "#${scheme.base02}";
            "tab.unfocusedHoverBackground" = "#${scheme.base01}";
            
            # Activity Bar
            "activityBar.background" = "#${scheme.base01}";
            "activityBar.foreground" = "#${scheme.base05}";
            "activityBar.inactiveForeground" = "#${scheme.base04}";
            "activityBar.border" = "#${scheme.base02}";
            "activityBarBadge.background" = "#${scheme.base0D}";
            "activityBarBadge.foreground" = "#${scheme.base00}";
            
            # Side Bar
            "sideBar.background" = "#${scheme.base00}";
            "sideBar.foreground" = "#${scheme.base05}";
            "sideBar.border" = "#${scheme.base02}";
            "sideBarTitle.foreground" = "#${scheme.base05}";
            "sideBarSectionHeader.background" = "#${scheme.base00}";
            "sideBarSectionHeader.foreground" = "#${scheme.base05}";
            "sideBarSectionHeader.border" = "#${scheme.base02}";
            
            # List and trees
            "list.activeSelectionBackground" = "#${scheme.base02}";
            "list.activeSelectionForeground" = "#${scheme.base05}";
            "list.inactiveSelectionBackground" = "#${scheme.base02}80";
            "list.inactiveSelectionForeground" = "#${scheme.base05}";
            "list.hoverBackground" = "#${scheme.base02}60";
            "list.hoverForeground" = "#${scheme.base05}";
            "list.focusBackground" = "#${scheme.base02}";
            "list.focusForeground" = "#${scheme.base05}";
            "list.highlightForeground" = "#${scheme.base0D}";
            
            # Status Bar
            "statusBar.background" = "#${scheme.base01}";
            "statusBar.foreground" = "#${scheme.base04}";
            "statusBar.border" = "#${scheme.base02}";
            "statusBar.debuggingBackground" = "#${scheme.base08}";
            "statusBar.debuggingForeground" = "#${scheme.base00}";
            "statusBar.noFolderBackground" = "#${scheme.base01}";
            "statusBar.noFolderForeground" = "#${scheme.base04}";
            "statusBarItem.activeBackground" = "#${scheme.base02}";
            "statusBarItem.hoverBackground" = "#${scheme.base02}";
            
            # Title Bar
            "titleBar.activeBackground" = "#${scheme.base01}";
            "titleBar.activeForeground" = "#${scheme.base05}";
            "titleBar.inactiveBackground" = "#${scheme.base01}";
            "titleBar.inactiveForeground" = "#${scheme.base04}";
            "titleBar.border" = "#${scheme.base02}";
            
            # Panel (Terminal, Output, etc.)
            "panel.background" = "#${scheme.base00}";
            "panel.border" = "#${scheme.base02}";
            "panelTitle.activeBorder" = "#${scheme.base0D}";
            "panelTitle.activeForeground" = "#${scheme.base05}";
            "panelTitle.inactiveForeground" = "#${scheme.base04}";
            
            # Terminal
            "terminal.background" = "#${scheme.base00}";
            "terminal.foreground" = "#${scheme.base05}";
            "terminal.ansiBlack" = "#${scheme.base00}";
            "terminal.ansiRed" = "#${scheme.base08}";
            "terminal.ansiGreen" = "#${scheme.base0B}";
            "terminal.ansiYellow" = "#${scheme.base0A}";
            "terminal.ansiBlue" = "#${scheme.base0D}";
            "terminal.ansiMagenta" = "#${scheme.base0E}";
            "terminal.ansiCyan" = "#${scheme.base0C}";
            "terminal.ansiWhite" = "#${scheme.base05}";
            "terminal.ansiBrightBlack" = "#${scheme.base03}";
            "terminal.ansiBrightRed" = "#${scheme.base08}";
            "terminal.ansiBrightGreen" = "#${scheme.base0B}";
            "terminal.ansiBrightYellow" = "#${scheme.base0A}";
            "terminal.ansiBrightBlue" = "#${scheme.base0D}";
            "terminal.ansiBrightMagenta" = "#${scheme.base0E}";
            "terminal.ansiBrightCyan" = "#${scheme.base0C}";
            "terminal.ansiBrightWhite" = "#${scheme.base07}";
            "terminal.selectionBackground" = "#${scheme.base02}";
            
            # Notifications
            "notificationCenter.border" = "#${scheme.base02}";
            "notificationCenterHeader.background" = "#${scheme.base01}";
            "notifications.background" = "#${scheme.base01}";
            "notifications.border" = "#${scheme.base02}";
            
            # Buttons
            "button.background" = "#${scheme.base0D}";
            "button.foreground" = "#${scheme.base00}";
            "button.hoverBackground" = "#${scheme.base0D}C0";
            
            # Input fields
            "input.background" = "#${scheme.base00}";
            "input.foreground" = "#${scheme.base05}";
            "input.border" = "#${scheme.base02}";
            "input.placeholderForeground" = "#${scheme.base03}";
            "inputOption.activeBorder" = "#${scheme.base0D}";
            
            # Dropdown
            "dropdown.background" = "#${scheme.base01}";
            "dropdown.foreground" = "#${scheme.base05}";
            "dropdown.border" = "#${scheme.base02}";
            
            # Scrollbar
            "scrollbarSlider.background" = "#${scheme.base03}80";
            "scrollbarSlider.hoverBackground" = "#${scheme.base03}C0";
            "scrollbarSlider.activeBackground" = "#${scheme.base03}";
            
            # Minimap
            "minimap.background" = "#${scheme.base00}";
            "minimap.findMatchHighlight" = "#${scheme.base0A}";
            "minimap.selectionHighlight" = "#${scheme.base02}";
            
            # Git decoration colors
            "gitDecoration.addedResourceForeground" = "#${scheme.base0B}";
            "gitDecoration.modifiedResourceForeground" = "#${scheme.base0E}";
            "gitDecoration.deletedResourceForeground" = "#${scheme.base08}";
            "gitDecoration.untrackedResourceForeground" = "#${scheme.base0C}";
            "gitDecoration.ignoredResourceForeground" = "#${scheme.base03}";
            "gitDecoration.conflictingResourceForeground" = "#${scheme.base09}";
          };

          "editor.tokenColorCustomizations" = {
            textMateRules = [
              # Comments - base03 (Comments, Invisibles, Line Highlighting)
              {
                scope = [
                  "comment"
                  "punctuation.definition.comment"
                ];
                settings = {
                  foreground = "#${scheme.base03}";
                  fontStyle = "italic";
                };
              }
              
              # Keywords - base0E (Keywords, Storage, Selector, Markup Italic, Diff Changed)
              {
                scope = [
                  "keyword"
                  "storage"
                  "storage.type"
                  "storage.modifier"
                ];
                settings.foreground = "#${scheme.base0E}";
              }
              
              # Operators - base05 (Default Foreground, Caret, Delimiters, Operators)
              {
                scope = [
                  "keyword.operator"
                  "keyword.operator.logical"
                  "keyword.operator.arithmetic"
                  "keyword.operator.assignment"
                  "keyword.operator.bitwise"
                ];
                settings.foreground = "#${scheme.base05}";
              }
              
              # Variables - base08 (Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted)
              {
                scope = [
                  "variable"
                  "variable.other"
                  "variable.language"
                ];
                settings.foreground = "#${scheme.base08}";
              }
              
              # Parameters - base08
              {
                scope = [
                  "variable.parameter"
                  "meta.function.parameters"
                ];
                settings.foreground = "#${scheme.base08}";
              }
              
              # Functions - base0D (Functions, Methods, Attribute IDs, Headings)
              {
                scope = [
                  "entity.name.function"
                  "meta.function-call"
                  "support.function"
                ];
                settings.foreground = "#${scheme.base0D}";
              }
              
              # Classes - base0A (Classes, Markup Bold, Search Text Background)
              {
                scope = [
                  "entity.name.class"
                  "entity.name.type.class"
                  "support.class"
                ];
                settings.foreground = "#${scheme.base0A}";
              }
              
              # Types - base0A
              {
                scope = [
                  "entity.name.type"
                  "support.type"
                ];
                settings.foreground = "#${scheme.base0A}";
              }
              
              # HTML/XML Tags - base08
              {
                scope = [
                  "entity.name.tag"
                  "meta.tag"
                  "punctuation.definition.tag"
                ];
                settings.foreground = "#${scheme.base08}";
              }
              
              # HTML/XML Attributes - base09 (Integers, Boolean, Constants, XML Attributes, Markup Link Url)
              {
                scope = [
                  "entity.other.attribute-name"
                ];
                settings.foreground = "#${scheme.base09}";
              }
              
              # Strings - base0B (Strings, Inherited Class, Markup Code, Diff Inserted)
              {
                scope = [
                  "string"
                  "string.quoted"
                  "string.template"
                ];
                settings.foreground = "#${scheme.base0B}";
              }
              
              # Numbers - base09
              {
                scope = [
                  "constant.numeric"
                  "constant.numeric.integer"
                  "constant.numeric.float"
                ];
                settings.foreground = "#${scheme.base09}";
              }
              
              # Booleans and Constants - base09
              {
                scope = [
                  "constant.language.boolean"
                  "constant.language.null"
                  "constant.language.undefined"
                  "constant.language"
                ];
                settings.foreground = "#${scheme.base09}";
              }
              
              # Other Constants - base09
              {
                scope = [
                  "support.constant"
                  "constant.other"
                ];
                settings.foreground = "#${scheme.base09}";
              }
              
              # Regular Expressions - base0C (Support, Regular Expressions, Escape Characters, Markup Quotes)
              {
                scope = [
                  "string.regexp"
                ];
                settings.foreground = "#${scheme.base0C}";
              }
              
              # Escape Characters - base0C
              {
                scope = [
                  "constant.character.escape"
                ];
                settings.foreground = "#${scheme.base0C}";
              }
              
              # Embedded - base0F (Deprecated, Opening/Closing Embedded Language Tags)
              {
                scope = [
                  "punctuation.section.embedded"
                  "variable.interpolation"
                ];
                settings.foreground = "#${scheme.base0F}";
              }
              
              # Decorators - base0F
              {
                scope = [
                  "meta.decorator"
                  "punctuation.decorator"
                ];
                settings.foreground = "#${scheme.base0F}";
              }
              
              # Punctuation - base05
              {
                scope = [
                  "punctuation"
                  "punctuation.separator"
                  "punctuation.terminator"
                ];
                settings.foreground = "#${scheme.base05}";
              }
              
              # Invalid - base08 with base00 background
              {
                scope = [
                  "invalid"
                  "invalid.illegal"
                ];
                settings = {
                  foreground = "#${scheme.base08}";
                  background = "#${scheme.base00}";
                };
              }
              
              # Deprecated - base0F
              {
                scope = [
                  "invalid.deprecated"
                ];
                settings = {
                  foreground = "#${scheme.base0F}";
                  fontStyle = "strikethrough";
                };
              }
              
              # Markup: Headings - base0D
              {
                scope = [
                  "markup.heading"
                  "entity.name.section"
                ];
                settings = {
                  foreground = "#${scheme.base0D}";
                  fontStyle = "bold";
                };
              }
              
              # Markup: Bold - base0A
              {
                scope = [
                  "markup.bold"
                ];
                settings = {
                  foreground = "#${scheme.base0A}";
                  fontStyle = "bold";
                };
              }
              
              # Markup: Italic - base0E
              {
                scope = [
                  "markup.italic"
                ];
                settings = {
                  foreground = "#${scheme.base0E}";
                  fontStyle = "italic";
                };
              }
              
              # Markup: Code - base0B
              {
                scope = [
                  "markup.inline.raw"
                  "markup.fenced_code"
                ];
                settings.foreground = "#${scheme.base0B}";
              }
              
              # Markup: Link Text - base08
              {
                scope = [
                  "markup.underline.link"
                  "string.other.link"
                ];
                settings.foreground = "#${scheme.base08}";
              }
              
              # Markup: Link URL - base09
              {
                scope = [
                  "meta.link"
                ];
                settings.foreground = "#${scheme.base09}";
              }
              
              # Markup: Lists - base08
              {
                scope = [
                  "markup.list"
                  "punctuation.definition.list.begin"
                ];
                settings.foreground = "#${scheme.base08}";
              }
              
              # Markup: Quote - base0C
              {
                scope = [
                  "markup.quote"
                ];
                settings.foreground = "#${scheme.base0C}";
              }
              
              # Diff: Inserted - base0B
              {
                scope = [
                  "markup.inserted"
                  "meta.diff.header.to-file"
                  "punctuation.definition.inserted"
                ];
                settings.foreground = "#${scheme.base0B}";
              }
              
              # Diff: Deleted - base08
              {
                scope = [
                  "markup.deleted"
                  "meta.diff.header.from-file"
                  "punctuation.definition.deleted"
                ];
                settings.foreground = "#${scheme.base08}";
              }
              
              # Diff: Changed - base0E
              {
                scope = [
                  "markup.changed"
                  "punctuation.definition.changed"
                ];
                settings.foreground = "#${scheme.base0E}";
              }
              
              # JSON: Keys - base0D
              {
                scope = [
                  "support.type.property-name.json"
                  "meta.structure.dictionary.key.json"
                ];
                settings.foreground = "#${scheme.base0D}";
              }
              
              # CSS: Selectors - base0E
              {
                scope = [
                  "entity.name.tag.css"
                  "entity.other.attribute-name.class.css"
                  "entity.other.attribute-name.id.css"
                ];
                settings.foreground = "#${scheme.base0E}";
              }
              
              # CSS: Properties - base0D
              {
                scope = [
                  "support.type.property-name.css"
                ];
                settings.foreground = "#${scheme.base0D}";
              }
            ];
          };
        };
      };
    };
  };
}
