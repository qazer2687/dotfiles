{ config, pkgs, ... }:
{
  # Minecraft Runner Service
  systemd.services.mc = {
      
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
}