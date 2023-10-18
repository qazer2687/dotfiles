{
  lib,
  pkgs,
  ...
}: {

  options.systemModules.opengl.enable = lib.mkEnableOption "";

  config = {
    systemModules.opengl.enable = {
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
          vulkan-validation-layers 
        ];
      };
    };
  };
}
