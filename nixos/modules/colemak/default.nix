{
  lib,
  config,
  ...
}: {
  options.systemModules.colemak.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.colemak.enable {
    console.keyMap = "colemak";
    services.xserver = {
      layout = "gb";
      xkbVariant = "colemak";
    };
  };
}
