{ config, pkgs, ... }:

let
  minecraftDir = "/opt/minecraftserver";
  minecraftUrl = "https://mediafilez.forgecdn.net/files/4437/692/Enigmatica6Server-1.8.0.zip";
  minecraftZip = "$/opt/minecraftserver/Enigmatica6Server-1.8.0.zip";
  
in {
  # Define a rule to create and accept EULA file and a rule to create and write to the server.properties file.
  systemd.tmpfiles.rules = [
    "L+ /opt/minecraftserver/eula.txt 0755 minecraftserver minecraftserver - ${./eula.txt}"
    "L+ /opt/minecraftserver/server.properties 0755 minecraftserver minecraftserver - ${./server.properties}"
  ];
  
  # Install Deps
  environment.systemPackages = with pkgs; [ jdk8 unzip awk];

  # Minecraft Service User Group
  users.groups.minecraftserver = {};

  # Minecraft Service User
  users.users.minecraftserver = {
    isSystemUser = true;
    group = "minecraftserver";
    home = "/opt/minecraftserver";
    extraGroups = [ "networking" ];
  };

  # Minecraft Installer Service
  systemd.services.installminecraftserver = {
    script = ''
      set -euxo pipefail
      mkdir -p /opt/minecraftserver
      chown minecraftserver /opt/minecraftserver
      chmod 700 /opt/minecraftserver
      ${pkgs.curl}/bin/curl -L -o /opt/minecraftserver ${minecraftUrl}
      unzip ${minecraftZip} -d /opt/minecraftserver
      chown -R minecraftserver /opt/minecraftserver
      chmod -R 700 /opt/minecraftserver
      rm ${minecraftZip}
    '';
    wantedBy = [ "multi-user.target" ];
  };

  # Minecraft Runner Service
  systemd.services.minecraftserver = {

    serviceConfig = {
      ExecStart = "/opt/minecraftserver/start.sh";
      Type = "simple";
      User="minecraftserver";
      Group="minecraftserver";
      WorkingDirectory = "/opt/minecraftserver";
    };
    after = [ "network.target" ];
  };
}
