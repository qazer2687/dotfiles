{ config, pkgs, inputs, ... }:
{
  environment.etc = {
    # Creates /etc/nanorc
    nanorc = {
      text = ''
        context.properties = {
        default.clock.rate        = 48000
        default.clock.quantum     = 32
        default.clock.min-quantum = 32
      

        { name = libpipewire-module-rtkit
          args = {
            nice.level   = -15
            rt.prio      = 88
            rt.time.soft = 2000000
            rt.time.hard = 2000000
          }
          flags = [ ifexists nofail ]
        }
      '';

      # The UNIX file mode bits
      mode = "0440";
    };
  };
}