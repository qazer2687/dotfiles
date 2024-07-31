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
        enableHidpi = true;
        wayland.enable = true;
        theme = "where-is-my-sddm-theme";
        settings = {
          Item = {
            id = "cursor";
            visible = "false";
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      where-is-my-sddm-theme
    ];
  };
}
