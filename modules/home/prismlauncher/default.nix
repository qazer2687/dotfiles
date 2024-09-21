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
      mangohud
    ];

    home.file = {
      # 8
      ".jdks/8".source = lib.getBin pkgs.openjdk8;
      ".jdks/8-temurin".source = lib.getBin pkgs.temurin-bin-8;

      # 11
      ".jdks/11".source = lib.getBin pkgs.openjdk11;

      # 17
      ".jdks/17".source = lib.getBin pkgs.openjdk17;
      ".jdks/17-temurin".source = lib.getBin pkgs.temurin-bin-17;
      ".jdks/17-zulu".source = lib.getBin pkgs.zulu17;

      # 21
      ".jdks/21-temurin".source = lib.getBin pkgs.temurin-bin;
    };
  };
}
