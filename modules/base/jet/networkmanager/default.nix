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

    # Disable P2P for Broadcom WiFi
    boot.extraModprobeConfig = ''
      options brcmfmac p2pon=0 roamoff=1
    '';

    networking.networkmanager = {
      enable = true;
      wifi = {
        # IWD backend doesn't work directly with WPA3-Enterprise.
        backend = "wpa_supplicant";
        # Disable MAC randomization which can cause issues
        scanRandMacAddress = false;
        powersave = false;
      };
      # Disable P2P device creation using structured settings
      settings = {
        device = {
          "match-device" = "interface-name:p2p-dev-*";
          managed = false;
        };
        connection = {
          "wifi.powersave" = 2;
        };
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
      # Trooli
      "NetworkManager/system-connections/trooli.nmconnection" = {
        content = ''
          [connection]
          id=${config.sops.placeholder."trooli/id"}
          type=wifi
          autoconnect=true
          [wifi]
          mode=infrastructure
          ssid=${config.sops.placeholder."trooli/ssid"}
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
          [wifi]
          mode=infrastructure
          ssid=${config.sops.placeholder."eduroam/ssid"}
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