{ inputs, lib, config, pkgs, ... }:
{
  options.modules.audio.pipewire.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.audio.pipewire.enable {
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