{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.starship.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.starship.enable {
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
          symbol = "󱄅";
          format = "via [$state( \($name\))](bold blue) ";
        };
      };
    };
  };
}
