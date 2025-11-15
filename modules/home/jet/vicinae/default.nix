{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.vicinae.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vicinae.enable {
    services.vicinae = {
      enable = true;
      autoStart = true;
      useLayerShell = true;
      # extensions = [ myExtensionPkg ];
      # themes = { ... };
      # settings = { ... };
    };
  };
}
