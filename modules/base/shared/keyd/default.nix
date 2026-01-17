{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.keyd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.keyd.enable {
    services.keyd = {
      enable = true;                                                            
        keyboards = {
          default = {
          ids = [ "*" ]; # Apply to all keyboards
          settings = {
            main = {
              # Tap for Escape, hold for Control
            capslock = "overload(control, esc)";
            };
          };
        };
      };
    };
  };
}
