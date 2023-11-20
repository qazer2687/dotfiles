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
      ];
      etc = {
        "jdks/17".source = lib.getBin pkgs.jdk17;
        "jdks/8".source = lib.getBin pkgs.temurin-bin-8;
      };
    };
  };
}
