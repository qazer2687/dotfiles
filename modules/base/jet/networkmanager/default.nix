{
  lib,
  config,
  pkgs,
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

    # Disable problematic features in Broadcom driver
    boot.extraModprobeConfig = ''
      options brcmfmac roamoff=1 feature_disable=0x82000
    '';

    # Kill P2P interfaces immediately if created
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="net", KERNEL=="p2p-dev-*", RUN+="${pkgs.iproute2}/bin/ip link delete $name"
    '';

    networking.networkmanager = {
      enable = true;
      wifi = {
        backend = "wpa_supplicant";
        scanRandMacAddress = false;
        powersave = false;
      };
      settings = {
        device = {
          "wifi.scan-rand-mac-address" = false;
        };
        connection = {
          "wifi.powersave" = 2;
        };
        main = {
          # Disable P2P globally in NetworkManager
          "no-auto-default" = "*";
        };
      };
      # Append to wpa_supplicant configuration
      dispatcherScripts = [{
        source = pkgs.writeText "disable-p2p" ''
          #!/bin/sh
          # Disable P2P in wpa_supplicant
          ${pkgs.networkmanager}/bin/nmcli device set wlp1s0f0 managed yes
        '';
        type = "basic";
      }];
    };

    # Override wpa_supplicant to disable P2P
    systemd.services.wpa_supplicant.environment = {
      WPA_SUP_OPTIONS = "-Dnl80211 -c/etc/wpa_supplicant/wpa_supplicant.conf -p/run/wpa_supplicant";
    };

    environment.etc."wpa_supplicant/wpa_supplicant.conf" = {
      text = ''
        ctrl_interface=/run/wpa_supplicant
        ctrl_interface_group=wheel
        update_config=1
        p2p_disabled=1
      '';
      mode = "0600";
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