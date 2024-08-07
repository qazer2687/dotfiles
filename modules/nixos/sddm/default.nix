{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.sddm.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sddm.enable {
    services.displayManager = {
      defaultSession = "sway";
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        enableHidpi = true;
        wayland.enable = true;
        theme = "where_is_my_sddm_theme";
        settings = {
          Item = {
            id = "cursor";
            visible = "false";
          };
        };
        extraPackages = with pkgs; [
          qt6.qt5compat
        ];
      };
    };
    environment.systemPackages = with pkgs; [
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          passwordCharacter = "*";
          passwordFontSize = "45";
          passwordInputCursorVisible = false;
          passwordInputWidth = "0.2";
        };
      })
    ];
  };
}
