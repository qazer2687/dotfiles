{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.xdg.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.xdg.enable {
    
    home.file.".local/share/applications" = {
      source = "${config.home.path}/share/applications";
      recursive = true;
    };
    
    xdg = {
      enable = true;
      portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-wlr
        ];
        #xdgOpenUsePortal = true;
        config = {
          common = {
            default = ["wlr" "gtk"];
          };
        };
      };
      
      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
        };
      };
      
      userDirs = {
        enable = true;
        createDirectories = true;
        # Default directories will be created automatically
        # You can customize them if needed:
        # desktop = "$HOME/Desktop";
        # documents = "$HOME/Documents";
        # download = "$HOME/Downloads";
        # music = "$HOME/Music";
        # pictures = "$HOME/Pictures";
        # videos = "$HOME/Videos";
        # publicShare = "$HOME/Public";
        # templates = "$HOME/Templates";
      };
    };
    
    home.packages = with pkgs; [
      xdg-utils
    ];
  };
}