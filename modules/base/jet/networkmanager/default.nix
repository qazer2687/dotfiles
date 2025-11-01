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
        (_name: {inherit sopsFile;});
    in
      (mkNetworkSecrets "eduroam" ["id" "ssid" "identity" "anonymous-identity" "phase2-password"] ../../../../secrets/networks/eduroam.yaml)
      // (mkNetworkSecrets "wifinity" ["id" "ssid" "psk"] ../../../../secrets/networks/wifinity.yaml)
      // (mkNetworkSecrets "trooli" ["id" "ssid" "psk"] ../../../../secrets/networks/trooli.yaml);

    networking.networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        # IWD backend doesn't work directly with WPA3-Enterprise.
        backend = "wpa_supplicant";
      };
    };

    users.users.alex.extraGroups = ["networkmanager"];

    sops.templates = {
      # Wifinity
      "NetworkManager/system-connections/wifinity.nmconnection" = {
        content = ''
          [connection]
          id=${config.sops.placeholder."wifinity/id"}
          type=wifi
          autoconnect=true
          # Connect to this network when found even if already on another network.
          autoconnect-priority=99

          [wifi]
          mode=infrastructure
          ssid=${config.sops.placeholder."wifinity/ssid"}
          powersave=0

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

      # Trooli
      "NetworkManager/system-connections/trooli.nmconnection" = {
        content = ''
          [connection]
          id=${config.sops.placeholder."trooli/id"}
          type=wifi
          autoconnect=true
          # Connect to this network when found even if already on another network.
          autoconnect-priority=99

          [wifi]
          mode=infrastructure
          ssid=${config.sops.placeholder."trooli/ssid"}
          powersave=0

          [wifi-security]
          auth-alg=open
          key-mgmt=wpa-psk
          psk=${config.sops.placeholder."trooli/psk"}

          [ipv4]
          method=auto

          [ipv6]
          addr-gen-mode=default
          method=auto
        '';
        path = "/etc/NetworkManager/system-connections/trooli.nmconnection";
        mode = "0600";
        owner = "root";
        group = "root";
      };

      # Eduroam
      "NetworkManager/system-connections/eduroam.nmconnection" = {
        content = ''
          [connection]
          id=${config.sops.placeholder."eduroam/id"}
          type=wifi
          autoconnect=true
          autoconnect-priority=1

          [wifi]
          mode=infrastructure
          ssid=${config.sops.placeholder."eduroam/ssid"}
          powersave=2

          [wifi-security]
          key-mgmt=wpa-eap
          
          # Fast BSS Transition
          #[802-11r]
          #ft-over-ds=true
          #ft-over-air=true

          [802-1x]
          eap=peap
          identity=${config.sops.placeholder."eduroam/identity"}
          anonymous-identity=${config.sops.placeholder."eduroam/anonymous-identity"}
          phase2-auth=mschapv2
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
