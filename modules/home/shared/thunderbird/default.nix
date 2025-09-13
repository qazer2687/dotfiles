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
    programs.thunderbird = {
      enable = true;

      profiles = {
        default = {
          isDefault = true;
          settings = {
            "extensions.autoDisableScopes" = 0;
          };
          extensions = [ frappe ];
        };
      };
    };
  };
}
