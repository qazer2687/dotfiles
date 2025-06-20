{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.xdg.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.xdg.enable {
    
    /*
    home.file.".local/share/applications" = {
      source = "${config.home.path}/share/applications";
      recursive = true;
    };
    */
    
    xdg = {
      enable = true;
      portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-wlr
          pkgs.xdg-desktop-portal-gtk
        ];
        xdgOpenUsePortal = true;
        config = {
          common = {
            default = ["wlr" "gtk"];
          };
        };
      };
    };
    
    home.packages = with pkgs; [
      xdg-utils
    ];
  };
}