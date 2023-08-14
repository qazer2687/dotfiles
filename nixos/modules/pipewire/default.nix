{
  lib,
  config,
  ...
}: {
  options.systemModules.pipewire.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.pipewire.enable {
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
