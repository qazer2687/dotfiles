{ config, pkgs, inputs, ... }:
{
  environment.etc = {
    "pipewire/pipewire.conf.d/pipewire.conf" = {
      text = ''
        context.properties = {
          default.clock.rate = 48000;
          default.clock.quantum = 32;
          default.clock.min-quantum = 32;
          default.clock.max-quantum = 32;
        };
      '';
    };
  };
}