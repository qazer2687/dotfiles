{
  lib,
  config,
  ...
}: {

  imports = [
    (builtins.fetchTarball {
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-23.05/nixos-mailserver-nixos-23.05.tar.gz";
      sha256 = "1ngil2shzkf61qxiqw11awyl81cr7ks2kv3r3k243zz7v2xakm5c";
    })
  ];

  options.modules.containers.mailserver.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.containers.mailserver.enable {
  
    mailserver = {
      enable = true;
      fqdn = "mail.q4z3r0x.com";
      sendingFqdn = "q4z3r0x.com";
      domains = [ "q4z3r0x.com" ];

      # IMAP (143)
      enableImap = true;

      # SMTP (587)
      enableSubmission = true;

      localDnsResolver = false;
      openFirewall = true;

      loginAccounts = {
        "mail@q4z3r0x.com" = {
          hashedPasswordFile = "/home/alex/.config/mailserver/password";
        };
      };
      certificateScheme = "acme-nginx";
    };
    
    security.acme.acceptTerms = true;
    security.acme.defaults.email = "security@q4z3r0x.com";
  };
}