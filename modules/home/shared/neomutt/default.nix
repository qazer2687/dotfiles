{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.neomutt.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.neomutt.enable {
    programs.neomutt = {
      enable = true;
      sidebar.enable = true;
    };
  };
}
