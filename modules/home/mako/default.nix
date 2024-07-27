{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.mako.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.mako.enable {
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
      font = "Agave";
      borderRadius = 6;
      margin = "8";
      anchor = "top-right";
      width = 600;

      # Theme
      backgroundColor = "#000000";
      borderColor = "#000000";
      padding = "8,8,8,8";
    };
  };
}
