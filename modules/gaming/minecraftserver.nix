{ inputs, lib, config, pkgs, ... }:
{
  options.modules.gaming.minecraftserver.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.gaming.minecraftserver.enable { 
    systemd.services.minecraftserver = {
        path = with pkgs; [
        jdk8
        gawk
      ];
      serviceConfig = {
        ExecStart = "/opt/minecraftserver/start.sh";
        Type = "simple";
        WorkingDirectory = "/opt/minecraftserver";
      };
      after = [ "network.target" ];
    };
  };
}