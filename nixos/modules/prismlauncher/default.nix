{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.prismlauncher.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.prismlauncher.enable {
    environment = {
      systemPackages = with pkgs; [
        prismlauncher
        temurin-bin-8
        graalvmCEPackages.graalvm17-ce-full
      ];
      etc = {
        "jdks/17".source = lib.getBin pkgs.openjdk17;
        "jdks/8".source = lib.getBin pkgs.openjdk8;
      };
    };
  };
}
