{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.misc.colemak.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.misc.colemak.enable {
    console.keyMap = "colemak";
    services.xserver = {
      layout = "gb";
      xkbVariant = "colemak";
    };
  };
}
