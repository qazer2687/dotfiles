{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.containers.caddy.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.containers.caddy.enable {

    sops.secrets.CLOUDFLARE_API_TOKEN = {
      sopsFile = ../../secrets/containers/caddy.yaml;
    };
    
    sops.templates."caddy" = {
      content = ''
        CLOUDFLARE_API_TOKEN=${config.sops.placeholder.CLOUDFLARE_API_TOKEN}
      '';
    };

    containers.caddy = {
      autoStart = true;
      # Enable host networking.
      privateNetwork = false;
      privateUsers = "pick";
      ephemeral = true;

      # NET_ADMIN
      allowedDevices = [
        {
          modifier = "rwm";
          node = "/dev/net/tun";
        }
      ];

      bindMounts = {
        "/etc/caddy" = {
          hostPath = "/srv/caddy/etc";
          isReadOnly = false;
        };
        "/data" = {
          hostPath = "/srv/caddy/data";
          isReadOnly = false;
        };
        "/config" = {
          hostPath = "/srv/caddy/config";
          isReadOnly = false;
        };
        "/srv/assets" = {
          hostPath = "/srv/assets";
          isReadOnly = false;
        };
        "/run/secrets/caddy" = {
          hostPath = config.sops.templates."caddy".path;
          isReadOnly = true;
        };
      };

      config = { config, pkgs, ... }: {
        
        users.users.caddy = {
          isSystemUser = true;
        };

        systemd.services.caddy.serviceConfig = {
          EnvironmentFile = "/run/secrets/caddy";
        };

        services.caddy = {
          enable = true;
          package = pkgs.caddy.withPlugins {
            plugins = [ "github.com/caddy-dns/cloudflare@2fc25ee62f40fe21b240f83ab2fb6e2be6dbb953" ];
            hash = "sha256-RLOwzx7+SH9sWVlr+gTOp5VKlS1YhoTXHV4k6r5BJ3U=";
          };
          dataDir = "/data";
          # configFile = "/etc/caddy/Caddyfile";
          
          # Move all of these into the container configurations themselves.
          virtualHosts = {
            "assets.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                root * /srv/assets
                file_server
              '';
            };
            
            "portainer.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:9000
              '';
            };
            
            "vaultwarden.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:8181
              '';
            };
            
            "searxng.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:8585
              '';
            };
            
            "prowlarr.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:9696
              '';
            };
            
            "radarr.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:7878
              '';
            };
            
            "bazarr.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:6767
              '';
            };
            
            "sonarr.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:8989
              '';
            };
            
            "readarr.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:8787
              '';
            };
            
            "qbittorrent.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:8080
              '';
            };
            
            "grafana.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:8084
              '';
            };
            
            "copyparty.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:3923
              '';
            };
            
            "speedtest.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:7978
              '';
            };
            
            "glance.qazer.org" = {
              serverAliases = [ "start.qazer.org" "qazer.org" ];
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:8140
              '';
            };
            
            "immich.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:2283
              '';
            };
            
            "audiobookshelf.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:13378
              '';
            };
            
            "jellyseerr.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:5055
              '';
            };
            
            "n8n.qazer.org" = {
              extraConfig = ''
                tls {
                  dns cloudflare {env.CLOUDFLARE_API_TOKEN}
                }
                reverse_proxy localhost:5678
              '';
            };
            
            "jellyfin.qazer.org" = {
              extraConfig = ''
                tls {
                  ca https://acme-v02.api.letsencrypt.org/directory
                }
                reverse_proxy localhost:8096
              '';
            };
          };
        };
      };
    };
  };
}
