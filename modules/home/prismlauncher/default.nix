{
  lib,
  config,
  self,
  ...
}: {
  options.modules.prismlauncher.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.prismlauncher.enable {
    home.packages = with self.packages; [
      prismlauncher
      mangohud
    ];

    home.file = {
      ".jdks/8".source = lib.getBin self.packages.openjdk8;
      ".jdks/8-temurin".source = lib.getBin self.packages.temurin-bin-8;

      ".jdks/11".source = lib.getBin self.packages.openjdk11;

      ".jdks/17".source = lib.getBin self.packages.openjdk17;
      ".jdks/17-temurin".source = lib.getBin self.packages.temurin-bin-17;
      ".jdks/17-zulu".source = lib.getBin self.packages.zulu17;

      ".jdks/21-temurin".source = lib.getBin self.packages.temurin-bin;
    };
  };
}
