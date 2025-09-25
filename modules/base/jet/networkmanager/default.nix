{
  lib,
  config,
  ...
}: {
  options.modules.networkmanager.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.networkmanager.enable {

    sops.secrets = let
      mkNetworkSecrets = network: keys: sopsFile:
        lib.genAttrs 
          (map (key: "${network}/${key}") keys)
          (name: { inherit sopsFile; });
    in
      (mkNetworkSecrets "wifinity" [ "id" "ssid" "psk" ] ../../../../secrets/networks/wifinity.yaml) //
      (mkNetworkSecrets "eduroam" [ "id" "ssid" "identity" "anonymous-identity" "phase2-identity" "phase2-password" ] ../../../../secrets/networks/eduroam.yaml);
    
    /*networking.wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };*/
    

    networking.networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        backend = "wpa_supplicant";
      };
    };

    users.users.alex.extraGroups = [ "networkmanager" ];

    
    sops.templates = {
      "NetworkManager/system-connections/wifinity.nmconnection" = {
        content = ''
          [connection]
          id=${config.sops.placeholder."wifinity/id"}
          type=wifi
          autoconnect=true

          [wifi]
          mode=infrastructure
          ssid=${config.sops.placeholder."wifinity/ssid"}

          [wifi-security]
          auth-alg=open
          key-mgmt=wpa-psk
          psk=${config.sops.placeholder."wifinity/psk"}

          [ipv4]
          method=auto

          [ipv6]
          addr-gen-mode=default
          method=auto
        '';
        path = "/etc/NetworkManager/system-connections/wifinity.nmconnection";
        mode = "0600";
        owner = "root";
        group = "root";
      };

      "NetworkManager/system-connections/eduroam.nmconnection" = {
        content = ''
          [connection]
          id=${config.sops.placeholder."eduroam/id"}
          type=wifi
          autoconnect=true

          [wifi]
          mode=infrastructure
          ssid=${config.sops.placeholder."eduroam/ssid"}

          [wifi-security]
          key-mgmt=wpa-eap

          [802-1x]
          eap=peap
          identity=${config.sops.placeholder."eduroam/identity"}
          anonymous-identity=${config.sops.placeholder."eduroam/anonymous-identity"}
          phase2-auth=mschapv2
          phase2-identity=${config.sops.placeholder."eduroam/phase2-identity"}
          password=${config.sops.placeholder."eduroam/phase2-password"}
          
          [ipv4]
          method=auto

          [ipv6]
          addr-gen-mode=default
          method=auto
        '';
        path = "/etc/NetworkManager/system-connections/eduroam.nmconnection";
        mode = "0600";
        owner = "root";
        group = "root";
      };
    };
  };
}