{ lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  frappe = pkgs.runCommand "frappe-xpi" { } ''
    mkdir -p $out
    cp ${./config/frappe.xpi} $out/frappe.xpi
  '';
in {
  options.modules.thunderbird.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.thunderbird.enable {

    sops.secrets = {
      personal-info = {
        sopsFile = ../../../../secrets/email.yaml;
        mode = "0400";
      };
    };

    programs.thunderbird = {
      enable = true;

      profiles = {
        default = {
          isDefault = true;
          settings = {
            "extensions.autoDisableScopes" = 0;
          };
          extensions = [ frappe ];
          accountsOrder = [ "gmail" "outlook" "sussex" "Local Folders" ];
        };
      };
    };

    accounts.email.accounts = {
      gmail = {
        address = builtins.readFile (config.sops.secrets.email.path + "/gmail");
        realName = builtins.readFile (config.sops.secrets.email.path + "/realname");
        imap.host = "imap.gmail.com";
        smtp.host = "smtp.gmail.com";
        thunderbird.enable = true;
        primary = true;
      };

      outlook = {
        address = builtins.readFile (config.sops.secrets.email.path + "/outlook");
        realName = builtins.readFile (config.sops.secrets.email.path + "/realname");
        imap.host = "outlook.office365.com";
        smtp.host = "smtp.office365.com";
        thunderbird.enable = true;
      };

      sussex = {
        address = builtins.readFile (config.sops.secrets.email.path + "/sussex");
        realName = builtins.readFile (config.sops.secrets.email.path + "/realname");
        imap.host = "outlook.office365.com";
        smtp.host = "smtp.office365.com";
        thunderbird.enable = true;
      };
    };
  };
}
