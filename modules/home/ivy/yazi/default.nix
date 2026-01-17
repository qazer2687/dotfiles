{
  lib,
  config,
  ...
}: {
  options.modules.yazi.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.yazi.enable {
    # TODO: Use xdg-desktop-portal-termfilechooser to make yazi work as a file picker.

    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        log = {
          enabled = false;
        };
        manager = {
          show_hidden = true;
          sort_by = "mtime";
          sort_dir_first = true;
          sort_reverse = true;
        };
      };
      theme = lib.importTOML ./config/theme.toml;
    };
  };
}
