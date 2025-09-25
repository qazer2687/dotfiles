{
  lib,
  config,
  ...
}: {
  options.modules.networkmanager.enable = lib.mkEnableOption "NetworkManager with SOPS secrets";
  
  config = lib.mkIf config.modules.networkmanager.enable {

    sops.secrets = let
      mkNetworkSecrets = network: keys: sopsFile:
        lib.genAttrs 
          (map (key: "${network}/${key}") keys)
          (name: { inherit sopsFile; });
    in
      (mkNetworkSecrets "wifinity" [ "id" "ssid" "psk" ] ../secrets/networks/wifinity.yaml) //
      (mkNetworkSecrets "eduroam" [ "id" "ssid" "identity" "anonymous-identity" "phase2-identity" "phase2-password" ] ../secrets/networks/eduroam.yaml);

    services.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };

    networking.networkmanager = {
      enable = true;
      users.users.alex.extraGroups = [ "networkmanager" ];

      wifi = {
        powersave = true;
        backend = "iwd";
      };

      connections = {
        wifinity = {
          id = config.sops.secrets."wifinity/id".path;
          type = "wifi";
          wifi.ssid = config.sops.secrets."wifinity/ssid".path;
          wifiSecurity = {
            keyMgmt = "wpa-psk";
            psk = config.sops.secrets."wifinity/psk".path;
          };
        };
      
        eduroam = {
          id = config.sops.secrets."eduroam/id".path;
          type = "wifi";
          wifi.ssid = config.sops.secrets."eduroam/ssid".path;
          wifiSecurity.keyMgmt = "wpa-eap";
          "802-1x" = {
            eap = [ "peap" ];
            identity = config.sops.secrets."eduroam/identity".path;
            anonymousIdentity = config.sops.secrets."eduroam/anonymous-identity".path;
            phase2Auth = "mschapv2";
            phase2Identity = config.sops.secrets."eduroam/phase2-identity".path;
            password = config.sops.secrets."eduroam/phase2-password".path;
          };
        };
      };
    };
  };
}