{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.gram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gram.enable {
    programs.gram = {
      enable = true;
    };

    home.shellAliases = {
      "zed" = "gram";
    };
  };
}
