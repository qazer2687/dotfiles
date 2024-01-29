{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.prismlauncher.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.prismlauncher.enable {
    home.packages = with pkgs; [
      prismlauncher
      gamemode
      mangohud
    ];
    home.file = {
      # Java 8
      ".jdks/8".source = lib.getBin pkgs.openjdk8;
      ".jdks/8-temurin".source = lib.getBin pkgs.temurin-bin-8;

      # Java 11
      ".jdks/11".source = lib.getBin pkgs.openjdk11;

      # Java 17
      ".jdks/17".source = lib.getBin pkgs.openjdk17;
      ".jdks/17-temurin".source = lib.getBin pkgs.temurin-bin-17;
    };
  };
}
