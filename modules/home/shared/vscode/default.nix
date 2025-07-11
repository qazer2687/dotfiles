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
      #enableUpdateCheck = false;
      #enableExtensionUpdateCheck = false;
      package = pkgs.vscodium-fhs;
      # The extensions folder is mutable by default as far as
      # I'm aware. I don't know whether this is for installations
      # or just updates, but as long as updates work I'm happy
      # keeping this here.

      # There seems to be an issue with applications that haven't been previously
      # configured having no directory in .vscode-oss when "installed" through nix's
      # build system. stupid shit, maybe FHS being stupid, stupid
      /*
         Disabled as this is broken in latest. Refuses to build because of
         unfree packages even though they are allowed.
      extensions = [
        # UI Theme
        ext.open-vsx.ankitpati.vscodium-amoled

        # Icon Theme
        ext.open-vsx.wilfriedago.vscode-symbols-icon-theme

        # Nix
        ext.vscode-marketplace.jnoortheen.nix-ide

        # HTML
        ext.vscode-marketplace.yandeu.five-server

        # C#
        ext.vscode-marketplace.ms-dotnettools.csharp

        # C
        ext.vscode-marketplace.llvm-vs-code-extensions.vscode-clangd

        # ESP32
        #ext.vscode-marketplace.platformio.platformio-ide
        #pkgs.vscode-extensions.ms-vscode.cpptools

        # Other
        ext.vscode-marketplace.naumovs.color-highlight
        ext.vscode-marketplace.aaron-bond.better-comments
        ext.vscode-marketplace.mkhl.direnv

        ext.vscode-marketplace.ms-vscode-remote.remote-containers
      ];
      */

      # Not in use because this is a very impractical option.
      # My configuration has to be perfect otherwise I have to
      # go through the process of coming back to here, modifying
      # a setting and then rebuilding - every time I want to
      # change something.
      /*
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

        # Hide the outline tab in the explorer pane.
        "outline.showOutline" = false;
        # Hide the timeline tab in the explorer pane.
        "timeline.visible" = false;
      };
      */
    };
  };
}
