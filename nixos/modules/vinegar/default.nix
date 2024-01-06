{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.vinegar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.vinegar.enable {
    environment.systemPackages = with pkgs; [
      vinegar
    ];
    # Required for building vinegar
    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };
}
