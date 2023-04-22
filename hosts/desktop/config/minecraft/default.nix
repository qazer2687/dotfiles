{ config, pkgs, ... }:

let
  enigmatica6Dir = "/opt/enigmatica6";
  enigmatica6ZipUrl = "https://mediafilez.forgecdn.net/files/4437/692/Enigmatica6Server-1.8.0.zip";
  enigmatica6Zip = "${enigmatica6Dir}/enigmatica6.zip";
  serverProperties = ''
    gamemode=survival
    difficulty=peaceful
    max-players=2
    server-port=25565
  '';
in {
  environment.systemPackages = with pkgs; [ jdk11 unzip ];

  users.users.enigmatica6 = {
    isSystemUser = true;
    home = "/opt/enigmatica6";
    extraGroups = [ "networking" ];
  };

  systemd.services.enigmatica6-prep = {
    script = ''
      set -euxo pipefail
      mkdir -p ${enigmatica6Dir}
      chown enigmatica6 ${enigmatica6Dir}
      chmod 700 ${enigmatica6Dir}
      curl -L -o ${enigmatica6Zip} ${enigmatica6ZipUrl}
      unzip ${enigmatica6Zip} -d ${enigmatica6Dir}
      chown -R enigmatica6 ${enigmatica6Dir}
      chmod -R 700 ${enigmatica6Dir}
      rm ${enigmatica6Zip}
    '';
    wantedBy = [ "multi-user.target" ];
  };

  systemd.services.enigmatica6 = {
    user = "enigmatica6";
    group = "users";
    workingDirectory = enigmatica6Dir;
    permissionsStartOnly = true;
    permissions = {
      read = "enigmatica6";
      write = "enigmatica6";
      execute = "none";
    };
    serviceConfig = {
      ExecStart = "${pkgs.jdk11}/bin/java -Xms4G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -jar forge-1.16.5-36.2.2.jar nogui";
      Type = "forking";
    };
    after = [ "network.target" "enigmatica6-prep.service" ];
  };
  
# Create and Accept EULA File
builtins.writeTextFile "${enigmatica6Dir}/eula.txt" "eula=true";

# Create Server Properties File
builtins.writeTextFile "${enigmatica6Dir}/server.properties" serverProperties;
}
