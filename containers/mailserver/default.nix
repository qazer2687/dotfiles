{
  lib,
  config,
  ...
}: {
  options.modules.containers.mailserver.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.containers.mailserver.enable {
  
    mailserver = {
      enable = true;
      fqdn = "mail.q4z3r0x.com";
      domains = [ "q4z3r0x.com" ];

      # IMAP (143)
      #enableImap = true;

      # SMTP (587)
      #enableSubmission = true;

      #localDnsResolver = false;
      #openFirewall = true;

      loginAccounts = {
        "mail@q4z3r0x.com" = {
          hashedPasswordFile = "/home/alex/.config/mailserver/password";
        };
      };
      certificateScheme = "selfsigned";
    };
    
    #security.acme.acceptTerms = true;
    #security.acme.defaults.email = "security@q4z3r0x.com";
  };
}