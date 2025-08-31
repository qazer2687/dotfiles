{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.fastfetch.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fastfetch.enable {
    home.packages = with pkgs; [
      fastfetch
      chafa
      # Required dependancy for displaying images.
      imagemagick
    ];

    home.shellAliases = {
      "fetch" = "fastfetch";
    };

    /*
      home.file.".config/assets/konata.png" = {
      source = ../../../../assets/konata.png;
    };
    */

    home.file.".config/fastfetch/config.jsonc".text = ''
        {
          "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
          "logo": {
            "source": "~/.config/assets/konata.png",
            "type": "sixel",
            "height": 10,
            "padding": {
              "top": 2,
              "left": 2,
              "bottom": 0
            }
          },
          "display": {
              "separator": " •  "
          },
          "modules": [
        "break",
        "break",
        {
                  "type": "title",
                  "color": {
                      "user": "33",  // = color2
                      "at": "37",
                      "host": "33"
                  }
              },
              "break",
              {
                  "type": "os",
                  "key": "distribution   ",
                  "keyColor": "34",
              },
              {
                  "type": "kernel",
                  "key": "linux kernel   ",
                  "keyColor": "34",
              },
              {
                  "type": "packages",
                  "format": "{}",
                  "key": "packages       ",
                  "keyColor": "34",
              },
              {
                  "type": "shell",
                  "key": "unix shell     ",
                  "keyColor": "34",
              },
              {
                  "type": "terminal",
                  "key": "terminal       ",
                  "keyColor": "34",
              },
              {
                  "type": "wm",
                  "format": "{} ({3})",
                  "key": "window manager ",
                  "keyColor": "34",
              },
              "break",
              {
                  "type": "colors",
                  "symbol": "triangle",
              },
              "break",
              "break",
          ]
      }
    '';
  };
}
