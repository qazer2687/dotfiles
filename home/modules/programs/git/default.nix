{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.git.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.git.enable {
    programs.git = {
      enable = true;
      userName = "***REMOVED***";
      userEmail = "***REMOVED***@outlook.com";
    };
  };
}
