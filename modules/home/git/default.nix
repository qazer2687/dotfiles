{
  lib,
  config,
  ...
}: {
  options.homeModules.git.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.git.enable {
    programs.git = {
      enable = true;
      userName = "***REMOVED***";
      userEmail = "***REMOVED***@outlook.com";
    };
  };
}
