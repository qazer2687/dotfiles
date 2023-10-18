{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options.homeModules.spicetify.enable = lib.mkEnableOption "";
  config = lib.mkIf config.homeModules.spicetify.enable {
    programs.spicetify = let
      spicetifyPkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
    in {
      enable = true;
      enabledExtensions = with spicetifyPkgs.extensions; [
        hidePodcasts
        genre
        songStats
        volumePercentage
        history
      ];
    };
  };
}
