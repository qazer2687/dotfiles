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
    ];

    # EXPERIMENTAL - Enable realtime priority
    # to improve latency and reduce stuttering.
    security.pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "99";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "soft";
        value = "99999";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "hard";
        value = "99999";
      }
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # I found that 32 and 64 quant resulted in choppy audio;
      # 128 is the next option and results in a latency of 2.67ms.
      # Quant should be in powers of two for efficiency
      # with certain audio processing algorithms.
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 128;
          "default.clock.min-quantum" = 128;
          "default.clock.max-quantum" = 128;
        };
      };
    };
  };
}
