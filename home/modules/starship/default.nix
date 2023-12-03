{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.starship.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.starship.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        rust = {
          format = "via [󰒓 $version](red bold) ";
        };
        nix-shell = {
          impure_msg = "[impure shell](bold red)";
          pure_msg = "[pure shell](bold green)";
          unknown_msg = "[unknown shell](bold yellow)";
          format = "on [$state( \($name\))](bold blue) ";
        };
      };
    };
  };
}
