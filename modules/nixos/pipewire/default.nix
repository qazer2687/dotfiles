{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.pipewire.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.pipewire.enable {
    security.rtkit.enable = true;
    environment.systemPackages = with pkgs; [
      pulseaudio
      pavucontrol
      pamixer
      easyeffects
      calf
      libebur128
      zam-plugins
      zita-convolver
      rnnoise
      speexdsp
      libbs2b
    ];
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        context.properties = {
          default.clock.rate = 44000;
          default.clock.quantum = 48;
          default.clock.min-quantum = 48;
          default.clock.max-quantum = 48;
        };
      };
    };
  };
}
