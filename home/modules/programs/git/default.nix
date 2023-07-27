{
  lib,
  config,
  ...
}: {
  options.homeModules.programs.git.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.git.enable {
    programs.git = {
      enable = true;
      userName = "alexvasilkovski";
      userEmail = "alexvasilkovski@outlook.com";
    };
  };
}
