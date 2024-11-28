{
  lib,
  config,
  ...
}: {
  options.modules.server.homepage-dashboard.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.server.homepage-dashboard.enable {
    services.homepage-dashboard = {
      enable = true;
      listenPort = 8082;
      settings = {
        title = "alq.ae";
        startURL = "https://alq.ae";
        background = "https://images.unsplash.com/photo-1502790671504-542ad42d5189?auto=format&fit=crop&w=2560&q=80";
      };
      widgets = [
        {
          search = {
            provider = "custom";
            url = "https://search.alq.ae/search?q=";
            target = "_blank";
            suggestionUrl = "https://search.alq.ae/autocompleter?q=";
            showSearchSuggestions = true;
          };
        }
        {
          openmeteo = {
            latitude = "25.4018";
            longitude = "55.4788";
            timezone = "Asia/Dubai";
            units = "metric";
            cache = 15;
          };
        }
      ];
      services = [
        {
          "Entertainment" = [
            {
              "TV" = {
                description = "Movie Streaming (Jellyfish)";
                href = "https://tv.alq.ae/";
                siteMonitor = "https://tv.alq.ae";
                icon = "mdi-youtube-tv";
              };
            }
            {
              "Catalogue" = {
                description = "Movie Search Catalogue (Jellyseerr)";
                href = "https://catalogue.alq.ae/";
                siteMonitor = "https://catalogue.alq.ae/";
                icon = "mdi-movie-search";
              };
            }
            {
              "YouTube" = {
                description = "Ad-free YouTube (Invidious)";
                href = "https://yt.alq.ae/";
                siteMonitor = "https://yt.alq.ae";
                icon = "mdi-youtube";
              };
            }
            {
              "Reddit" = {
                description = "Fast Reddit (RedLib)";
                href = "https://reddit.alq.ae/";
                siteMonitor = "https://reddit.alq.ae";
                icon = "mdi-reddit";
              };
            }
          ];
        }
        {
          "Services" = [
            {
              "Search" = {
                description = "Meta Search Engine (Searxng)";
                href = "https://search.alq.ae/";
                siteMonitor = "https://search.alq.ae/";
                icon = "mdi-search-web";
              };
            }
            {
              "Vault" = {
                description = "Password Manager (Vaultwarden)";
                href = "https://vault.alq.ae/";
                siteMonitor = "https://vault.alq.ae/";
                icon = "mdi-shield-key";
              };
            }
            {
              "Git" = {
                description = "Software Forge (Forgejo)";
                href = "https://git.alq.ae/";
                siteMonitor = "https://git.alq.ae/";
                icon = "mdi-git";
              };
            }
            {
              "AI" = {
                description = "Local AI";
                href = "https://ai.alq.ae/";
                siteMonitor = "https://ai.alq.ae/";
                icon = "mdi-creation";
              };
            }
            {
              "Stirling PDF" = {
                description = "All-in-one PDF Toolbox";
                href = "https://pdf.alq.ae/";
                siteMonitor = "https://pdf.alq.ae/";
                icon = "mdi-file-pdf-box";
              };
            }
          ];
        }
        {
          "Resources" = [
            {
              "Images" = {
                description = "Photo Backups & Albums (Immich)";
                href = "https://img.alq.ae/";
                siteMonitor = "https://img.alq.ae/";
                icon = "mdi-image-album";
              };
            }
            {
              "Cloud" = {
                description = "Drive Storage & Office Suite";
                href = "https://cloud.alq.ae/";
                siteMonitor = "https://cloud.alq.ae/";
                icon = "mdi-apple-icloud";
              };
            }
            {
              "Paperless" = {
                description = "Document Management System";
                href = "https://paperless.alq.ae/";
                siteMonitor = "https://paperless.alq.ae/";
                icon = "mdi-leaf-circle";
              };
            }
            {
              "Recipes" = {
                description = "Recipe Book (Mealie)";
                href = "https://recipes.alq.ae/";
                siteMonitor = "https://recipes.alq.ae/";
                icon = "mdi-silverware-fork-knife";
              };
            }
            {
              "Books" = {
                description = "eBooks Library (Kavita)";
                href = "https://books.alq.ae/";
                siteMonitor = "https://books.alq.ae/";
                icon = "mdi-bookshelf";
              };
            }
            {
              "Audio Books" = {
                description = "Audio Books Library";
                href = "https://audiobooks.alq.ae/";
                siteMonitor = "https://audiobooks.alq.ae/";
                icon = "mdi-book-music";
              };
            }
          ];
        }
        {
          "Backend & Servers" = [
            {
              "Single Sign-On" = {
                description = "Local Identity Provider (Authentik)";
                href = "https://auth.alq.ae/";
                siteMonitor = "https://auth.alq.ae/";
                icon = "mdi-account-box-multiple";
              };
            }
            {
              "Grafana" = {
                description = "Observability Platform";
                href = "https://grafana.alq.ae/";
                siteMonitor = "https://grafana.alq.ae/";
                icon = "mdi-chart-box-multiple";
              };
            }
            {
              "Hydra" = {
                description = "Hydra CI Server";
                href = "https://hydra.alq.ae/";
                siteMonitor = "https://hydra.alq.ae/";
                icon = "mdi-autorenew";
              };
            }
            {
              "Cache" = {
                description = "Nix Binary Cache";
                href = "https://cache.alq.ae/";
                siteMonitor = "https://cache.alq.ae/";
                icon = "mdi-database-clock";
              };
            }
            {
              "Gertruda" = {
                description = "Prusa MK3S+ 3D Printer";
                href = "https://gertruda.alq.ae/";
                siteMonitor = "https://gertruda.alq.ae/";
                icon = "mdi-printer-3d-nozzle";
              };
            }
            {
              "Local DNS" = {
                description = "DNS+DoH with ad-blocking (blocky)";
                href = "https://dns.alq.ae/";
                siteMonitor = "https://dns.alq.ae/";
                icon = "mdi-security";
              };
            }
            {
              "Local NTP" = {
                description = "Your local time-keeper";
                href = "https://time.alq.ae/";
                siteMonitor = "https://time.alq.ae/";
                icon = "mdi-clock-time-two";
              };
            }
            {
              "Synology NAS" = {
                description = "Network Attached Storage (Synology)";
                href = "https://nas.alq.ae/";
                siteMonitor = "https://nas.alq.ae/";
                icon = "mdi-nas";
              };
            }
          ];
        }
        {
          "Media Services" = [
            {
              "Sonarr" = {
                description = "TV Shows Automation";
                href = "https://sonarr.alq.ae/";
                siteMonitor = "https://sonarr.alq.ae/";
                icon = "mdi-movie-search";
              };
            }
            {
              "Radarr" = {
                description = "Movies Automation";
                href = "https://radarr.alq.ae/";
                siteMonitor = "https://radarr.alq.ae/";
                icon = "mdi-movie-search";
              };
            }
            {
              "Prowlarr" = {
                description = "Torrent Indexing Service";
                href = "https://prowlarr.alq.ae/";
                siteMonitor = "https://prowlarr.alq.ae/";
                icon = "mdi-format-list-group";
              };
            }
            {
              "Bazarr" = {
                description = "Captions Fetching Service";
                href = "https://bazarr.alq.ae/";
                siteMonitor = "https://bazarr.alq.ae/";
                icon = "mdi-closed-caption";
              };
            }
            {
              "Deluge" = {
                description = "Torrent Download Client";
                href = "https://deluge.alq.ae/";
                siteMonitor = "https://deluge.alq.ae/";
                icon = "mdi-download-circle";
              };
            }
          ];
        }
      ];
    };
  };
}
