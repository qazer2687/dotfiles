{ config, pkgs, ... }:

let
  enigmatica6Dir = "/opt/minecraftserver";
  enigmatica6ZipUrl = "https://mediafilez.forgecdn.net/files/4437/692/Enigmatica6Server-1.8.0.zip";
  enigmatica6Zip = "$/opt/minecraftserver/Enigmatica6Server-1.8.0.zip";

in {
  
  # Create and Accept EULA File
  pkgs.writeText "/opt/minecraftserver/eula.txt" ''
  eula=true
  '';

  # Create Server Properties File
  pkgs.writeText "/opt/minecraftserver/server.properties" ''
  gamemode=survival
  difficulty=peaceful
  max-players=2
  server-port=25565
  '';
  
  builtins.writeTextFile "/opt/minecraftserver}/server.properties" serverProperties;
  
  # Install Java 11 & Unzip
  environment.systemPackages = with pkgs; [ jdk11 unzip ];

  users.users.minecraftserver = {
    isSystemUser = true;
    home = "/opt/minecraftserver";
    extraGroups = [ "networking" ];
  };

  systemd.services.minecraftserver-prep = {
    script = ''
      set -euxo pipefail
      mkdir -p /opt/minecraftserver
      chown minecraftserve /opt/minecraftserver
      chmod 700 /opt/minecraftserver
      curl -L -o /opt/minecraftserver ${enigmatica6ZipUrl}
      unzip ${enigmatica6Zip} -d /opt/minecraftserver
      chown -R minecraftserver /opt/minecraftserver
      chmod -R 700 /opt/minecraftserver
      rm ${enigmatica6Zip}
    '';
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.minecraftserver = {
    user = "minecraftserver";
    group = "users";
    workingDirectory = /opt/minecraftserver;
    permissionsStartOnly = true;
    permissions = {
      read = "minecraftserver";
      write = "minecraftserver";
      execute = "minecraftserver";
    };
    serviceConfig = {
      ExecStart = "${pkgs.jdk11}/bin/java -Xms4G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -jar forge-1.16.5-36.2.2.jar nogui";
      Type = "forking";
    };
    after = [ "network.target" "enigmatica6-prep.service" ];
  };
}
