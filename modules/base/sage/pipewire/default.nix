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
      pulseaudio-utils
      pavucontrol
      pwvucontrol
      pamixer
    ];

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

      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate"          = 48000;
          "default.clock.allowed-rates" = [ 48000 ];
          "default.clock.force-rate"    = 48000;

          # 32/48000 = 0.67 ms
          "default.clock.quantum"       = 32;
          "default.clock.min-quantum"   = 32;
          "default.clock.max-quantum"   = 32;
        };
        "context.modules" = [
          {
            name = "libpipewire-module-rt";
            args = {
              nice.level   = -11;
              rt.prio      = 88;
              rt.time.soft = 200000;
              rt.time.hard = 200000;
            };
          }
        ];
      };
    };
  };
}