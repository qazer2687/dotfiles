{ config, pkgs, ... }:

let
  minecraftDir = "/opt/minecraftserver";
  minecraftUrl = "https://mediafilez.forgecdn.net/files/4437/692/Enigmatica6Server-1.8.0.zip";
  minecraftZip = "$/opt/minecraftserver/Enigmatica6Server-1.8.0.zip";
  serverProperties = ''
  gamemode=survival
  difficulty=peaceful
  max-players=2
  server-port=25565
  '';

in {
  # Define a rule to create and accept EULA file and a rule to create and write to the server.properties file.
  systemd.tmpfiles.rules = [
    "w /opt/minecraftserver/eula.txt 0644 minecraft - - - eula=true"
    "w /opt/minecraftserver/server.properties 0644 minecraft - - - ${serverProperties}"
  ];
  
  # Install Java 11 & Unzip
  environment.systemPackages = with pkgs; [ jdk11 unzip ];

  # Minecraft Service User
  users.users.minecraftserver = {
    isSystemUser = true;
    home = "/opt/minecraftserver";
    extraGroups = [ "networking" ];
  };

  # Minecraft Installer Service
  systemd.services.installminecraftserver = {
    script = ''
      set -euxo pipefail
      mkdir -p /opt/minecraftserver
      chown minecraftserve /opt/minecraftserver
      chmod 700 /opt/minecraftserver
      curl -L -o /opt/minecraftserver ${minecraftUrl}
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
      ExecStart = "${pkgs.jdk11}/bin/java -Xms6G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -jar /opt/minecraftserver/forge.jar nogui";
      Type = "simple";
 #    Type = "forking";
    };
    after = [ "network.target" "installminecraftserver.service" ];
  };
}
