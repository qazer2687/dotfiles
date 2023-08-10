{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  

  # Imports
  imports = [inputs.spicetify-nix.homeManagerModule];

  

  options.homeModules.programs.spicetify.enable = lib.mkEnableOption "";

  

  config = lib.mkIf config.homeModules.programs.spicetify.enable {
    # Configuration
    programs.spicetify = let dynamicOptions = lib.attrsets.mapAttrs (name: _pkg: lib.mkOption { default = null; }) inputs.spicetify-nix.packages.${pkgs.system}.default; in { 
      enable = true;
      theme = default.dynamicOptions.default.themes.catppuccin-macchiato;
      colorScheme = "flamingo";
      enabledExtensions = with dynamicOptions.extensions; [
        hidePodcasts
        genre
        songStats
        volumePercentage
      ];
    };
  };
}