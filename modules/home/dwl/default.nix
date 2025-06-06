{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.dwl.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.dwl.enable {
    home.packages = with pkgs; [
      # The configuration is set in an overlay and defined in the config folder.
      # Enabling this is really just the same as adding dwl to packages but I guess I 
      # can add dependencies here.
      dwl
      swaybg
      brightnessctl
      pamixer
    ];
  };
}
