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

    home.file.".config/fastfetch/config.conf".text = ''
      title_fqdn = false
      kernel_shorthand = true
      distro_shorthand = false
      uptime_shorthand = "tiny"

      image_backend = "chafa"
      image_source = "$HOME/.config/assets/konata.png"
      image_size = "250px"
      image_loop = true
      thumbnail_dir = "$HOME/.cache/thumbnails/fastfetch"
      crop_mode = "fit"
      crop_offset = "center"
      xoffset = 0
      yoffset = 0
      stdout = false

      color_blocks = true
      block_width = 3
      block_height = 1
      col_offset = "auto"
      bar_char_elapsed = "-"
      bar_char_total = "="
      bar_border = true
      bar_length = 15
      bar_color_elapsed = "distro"
      bar_color_total = "distro"

      # Fastfetch lets you define the order (and custom strings) of the info to be printed.
      # In this example, we mimic your custom print_info() function:
      info_order = [
          "",
          "title",
          "\u001b[34m  os",      # Blue colored OS label
          "\u001b[31m  kernel",  # Red colored Kernel label
          "\u001b[33m  uptime",  # Yellow colored Uptime label
          "\u001b[32m  shell",   # Green colored Shell label
          "\u001b[35m  wm",      # Magenta colored WM label
          "$(color 1)▂▂ $(color 2)▂▂ $(color 3)▂▂ $(color 4)▂▂ $(color 5)▂▂ $(color 6)▂▂ "
      ]
    '';
  };
}