{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.xampp.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.xampp.enable {

    networking.firewall.allowedTCPPorts = [ 80 443  ];

    services.httpd.enable = true;
    services.httpd.adminAddr = "admin@website.org";
    services.httpd.enablePHP = true;

    services.httpd.virtualHosts."xampp.local" = {
      documentRoot = "/var/www/xampp.local";
    };

    services.mysql.enable = true;
    services.mysql.package = pkgs.mariadb;
  };
}
