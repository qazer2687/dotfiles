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
      wifi = {
        powersave = true;
        backend = "iwd";
      };
    };

    users.users.alex.extraGroups = [ "networkmanager" ];

    environment.etc = {
      "NetworkManager/system-connections/wifinity.nmconnection" = {
        text = ''
          [connection]
          id=${builtins.readFile config.sops.secrets."wifinity/id".path}
          type=wifi
          
          [wifi]
          mode=infrastructure
          ssid=${builtins.readFile config.sops.secrets."wifinity/ssid".path}
          
          [wifi-security]
          auth-alg=open
          key-mgmt=wpa-psk
          psk=${builtins.readFile config.sops.secrets."wifinity/psk".path}
          
          [ipv4]
          method=auto
          
          [ipv6]
          addr-gen-mode=default
          method=auto
        '';
        mode = "0600";
      };
      
      "NetworkManager/system-connections/eduroam.nmconnection" = {
        text = ''
          [connection]
          id=${builtins.readFile config.sops.secrets."eduroam/id".path}
          type=wifi
          
          [wifi]
          mode=infrastructure
          ssid=${builtins.readFile config.sops.secrets."eduroam/ssid".path}
          
          [wifi-security]
          key-mgmt=wpa-eap
          
          [802-1x]
          eap=peap;
          identity=${builtins.readFile config.sops.secrets."eduroam/identity".path}
          anonymous-identity=${builtins.readFile config.sops.secrets."eduroam/anonymous-identity".path}
          phase2-auth=mschapv2
          phase2-identity=${builtins.readFile config.sops.secrets."eduroam/phase2-identity".path}
          password=${builtins.readFile config.sops.secrets."eduroam/phase2-password".path}
          
          [ipv4]
          method=auto
          
          [ipv6]
          addr-gen-mode=default
          method=auto
        '';
        mode = "0600";
      };
    };
  };
}