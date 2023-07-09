{ inputs, lib, config, pkgs, ... }: {

  options.modules.desktop.i3.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.desktop.i3.enable {
    services.xserver = {
      windowManager.i3 = {
      enable = true;
      package = pkgs.i3-rounded;
      };
    };
  };
}