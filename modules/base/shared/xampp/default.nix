{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.xampp.enable = lib.mkEnableOption "XAMPP-like stack";
  
  config = lib.mkIf config.modules.xampp.enable {
    # Firewall
    networking.firewall.allowedTCPPorts = [ 80 443 3306 ];
    
    # Apache with PHP
    services.httpd = {
      enable = true;
      adminAddr = "admin@website.org";
      enablePHP = true;
      phpPackage = pkgs.php;
      
      virtualHosts."xampp.local" = {
        documentRoot = "/var/www/xampp.local";
        extraConfig = ''
          <Directory "/var/www/xampp.local">
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
          </Directory>
        '';
      };
      
      # Optional: Add a default localhost vhost
      virtualHosts."localhost" = {
        documentRoot = "/var/www/xampp.local";
      };
    };
    
    # MySQL/MariaDB
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [ "testdb" ];
      ensureUsers = [
        {
          name = "root";
          ensurePermissions = {
            "*.*" = "ALL PRIVILEGES";
          };
        }
      ];
    };
    
    # Create the document root directory
    systemd.tmpfiles.rules = [
      "d /var/www/xampp.local 0755 wwwrun wwwrun -"
    ];
    
    # Optional: phpMyAdmin
    services.phpfpm.pools.phpmyadmin = {
      user = "wwwrun";
      settings = {
        "listen.owner" = "wwwrun";
        "pm" = "dynamic";
        "pm.max_children" = 5;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 1;
        "pm.max_spare_servers" = 3;
      };
    };
  };
}