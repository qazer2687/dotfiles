{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.neofetch.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neofetch.enable {

    home.packages = with pkgs; [
      fastfetch
      chafa
      # Required dependancy for displaying images.
      imagemagick
    ];

    home.file.".config/assets/konata.png" = {
      source = ../../../assets/konata.png;
    };

    home.file.".config/fastfetch/config.jsonc".text = ''
      // ~/.config/fastfetch/config.jsonc
      {
          "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",

          // Modules to display
          "modules": [
              "title",
              {
                  "type": "os",
                  "key": "\u001b[34m  " // Blue colored OS label
              },
              {
                  "type": "kernel",
                  "key": "\u001b[31m  " // Red colored Kernel label
              },
              {
                  "type": "uptime",
                  "key": "\u001b[33m  " // Yellow colored Uptime label
              },
              {
                  "type": "shell",
                  "key": "\u001b[32m  " // Green colored Shell label
              },
              {
                  "type": "wm",
                  "key": "\u001b[35m  " // Magenta colored WM label
              },
              {
                  "type": "custom",
                  "key": "",
                  "value": "\u001b[31m▂▂ \u001b[32m▂▂ \u001b[33m▂▂ \u001b[34m▂▂ \u001b[35m▂▂ \u001b[36m▂▂ "
              }
          ],

          // Image settings
          "image": {
              "path": "$HOME/.config/assets/konata.png",
              "type": "chafa",
              "width": 250,
              "height": 250,
              "preserveAspectRatio": true
          },

          // General display settings
          "title": {
              "fqdn": false
          },
          "kernel": {
              "shorthand": true
          },
          "uptime": {
              "shorthand": "tiny"
          }
      }
    '';
  };
}