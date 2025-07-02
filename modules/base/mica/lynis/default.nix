{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.lynis.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.lynis.enable {
    environment.systemPackages = with pkgs; [
      lynis
    ];

    environment.etc."lynis/custom.prf".text = ''
      # Mica is using chrony for NTP, lynis doesn't detect this.
      skip-test=TIME-3104

      # All viable sysctl options have been changed to the
      # recommended values, the ones skipped break functionality.
      skip-test=KRNL-6000

      # An /etc/issue has been configured, lynis doesn't detect this.
      skip-test=BANN-7126

      # Logrotate is enabled, lynis doesn't detect this.
      skip-test=LOGG-2146

      # All iptables rules are configured properly.
      skip-test=FIRE-4513

      # The DCCP, SCTP, RDS and TIPC kernel modules are blacklisted, lynis doesn't detect this.
      skip-test=NETW-3200

      # USB storage drivers are required for my external hard drive.
      skip-test=USB-1000

      # Using Cloudflare DNS, lynis doesn't detect this.
      skip-test=NAME-4028

      # All locked accounts which exist are neccesary.
      skip-test=AUTH-9284

      # Password rounds are configured via loginDefs, lynis doesn't detect this.
      skip-test=AUTH-9229

      # Password length requirements are configured via loginDefs, lynis doesn't detect this.
      skip-test=AUTH-9262

      # Critical files are generally stored in /nix/store which is read only, AIDE isn't suitable.
      skip-test=FINT-4350

      # Nix tools are used for system management, lynis doesn't detect this.
      skip-test=TOOL-5002
    '';
  };
}
