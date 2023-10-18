{
  lib,
  config,
  ...
}: { 

  options.systemModules.gdm.enable = lib.mkEnableOption "";

  options.systemModules.gdm.backend = lib.mkOption {
    default = "xorg";
    type = lib.types.str;
    description = "Choose the GDM backend. ('xorg' or 'wayland')";
  };

  config = lib.mkIf config.systemModules.gdm.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };
  };
  systemModules.gdm.backend = {
    services.xserver.displayManager = {
      wayland.enable = if config.systemModules.gdm.backend == "wayland" then true else false;
    };
  };
}
