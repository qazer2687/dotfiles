{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.ananicy.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.ananicy.enable {
    services.ananicy = {
      enable = true;
      package = lib.mkDefault pkgs.ananicy-cpp;
      rulesProvider = lib.mkDefault pkgs.ananicy-cpp;
      extraRules = [
        {
          "name" = "gamescope";
          "nice" = -20;
        }
      ];
    };
  };
}
