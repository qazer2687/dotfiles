{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      userName = "alexvasilkovski";
      userEmail = "alexvasilkovski@outlook.com";
    };
  };
}
