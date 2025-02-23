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
      {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": {
          "source": "~/.config/assets/konata.png",
          "type": "sixel",
          "height": 10,
          "padding": {
            "top": 1,
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
                    "user": "32",  // = color2
                    "at": "37",
                    "host": "32"
                }
            },
            "break",
            {
                "type": "os",
                "key": "distribution   ",
                "keyColor": "33",
            },
            {
                "type": "kernel",
                "key": "linux kernel   ",
                "keyColor": "33",
            },
            {
                "type": "packages",
                "format": "{}",
                "key": "packages       ",
                "keyColor": "33",  
            },
            {
                "type": "shell",
                "key": "unix shell     ",
                "keyColor": "33", 
            },
            {
                "type": "terminal",
                "key": "terminal       ",
                "keyColor": "33", 
            },
            {
                "type": "wm",
                "format": "{} ({3})",
                "key": "window manager ",
                "keyColor": "33", 
            },
            "break",
            {
                "type": "colors",
                "symbol": "block",
            },
            "break",
            "break",
        ]
    }  
    '';
  };
}