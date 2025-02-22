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
      neofetch
      chafa
    ];

    home.file.".config/assets/konata.png" = {
      source = ../../../assets/konata.png;
    };

    # This doesn't work properly for displaying images so 
    # I will make this a fastfetch config at some point. 
    home.file.".config/neofetch/config.conf".text = ''
      print_info() {
        prin ""
        info title
        info "\e[34m  " os
        info "\e[31m " kernel
        info "\e[33m " uptime
        info "\e[32m " shell
        info "\e[35m " wm
        prin "$(color 1)▂▂ $(color 2)▂▂ $(color 3)▂▂ $(color 4)▂▂ $(color 5)▂▂ $(color 6)▂▂ "
      }

      title_fqdn="off"
      kernel_shorthand="on"
      distro_shorthand="off"
      uptime_shorthand="tiny"

      image_backend="chafa"
      image_source="${config.home.homeDirectory}/.config/assets/konata.png"
      image_size="250px"
      image_loop="on"
      thumbnail_dir="${config.home.homeDirectory}/.cache/thumbnails/neofetch"
      crop_mode="fit"
      crop_offset="center"
      xoffset=0
      yoffset=0
      stdout="off"

      color_blocks="on"
      block_width=3
      block_height=1
      col_offset="auto"
      bar_char_elapsed="-"
      bar_char_total="="
      bar_border="on"
      bar_length=15
      bar_color_elapsed="distro"
      bar_color_total="distro"
    '';
  };
}