{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.prismlauncher.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.prismlauncher.enable {
    environment = {
      systemPackages = with pkgs; [
        prismlauncher
        gamemode
        mangohud
        glfw-wayland-minecraft
      ];
      etc = {
        "jdks/8-temurin".source = lib.getBin pkgs.temurin-bin-8;
        "jdks/17-temurin".source = lib.getBin pkgs.temurin-bin-17;

        "jdks/17".source = lib.getBin pkgs.openjdk17;
        "jdks/11".source = lib.getBin pkgs.openjdk11;
        "jdks/8".source = lib.getBin pkgs.openjdk8;
      };
    };
  };
}
