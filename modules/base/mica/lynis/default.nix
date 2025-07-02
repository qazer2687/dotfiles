{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.lynis.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.lynis.enable {
    environment.systemPackages = with pkgs; [
      lynis
    ];

    environment.etc."lynis/custom.prf".text = builtins.readFile ./custom.prf;
  };
}
