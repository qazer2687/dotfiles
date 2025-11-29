{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.prismlauncher.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.prismlauncher.enable {
    home.packages = with pkgs; [
      prismlauncher
      glfw
    ];

    home.file = {
      ".jdks/8".source = lib.getBin pkgs.jdk8;

      ".jdks/11".source = lib.getBin pkgs.jdk11;

      ".jdks/17".source = lib.getBin pkgs.jdk17;

      ".jdks/21".source = lib.getBin pkgs.jdk;
    };
  };
}
