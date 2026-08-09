{
  lib,
  config,
  ...
}: {
  options.modules.upower.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.upower.enable {
    services.upower = {
      enable = true;
      usePercentageForPolicy = true;
      percentageLow = 25;
      percentageCritical = 15;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };
}
