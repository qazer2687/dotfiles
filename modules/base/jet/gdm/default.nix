{
  lib,
  config,
  ...
}: {
  options.modules.gdm.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gdm.enable {
    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
