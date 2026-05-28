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


      # Sage has handled 32 in the past but its not reliable, also I had no reason to tune for low latency anyway I was just bored.
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate"          = 48000;
          "default.clock.allowed-rates" = [ 48000 ];
          "default.clock.force-rate"    = 48000;

          # 32/48000 = 0.67 ms
          "default.clock.quantum"       = 128;
          "default.clock.min-quantum"   = 128;
          "default.clock.max-quantum"   = 120;
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