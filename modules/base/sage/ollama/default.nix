{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.ollama.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.ollama.enable {
    services.ollama = {
      enable = true;
      acceleration = "rocm";
      # https://ollama.com/library
      loadModels = [ "deepseek-r1:1.5b"];
    };
    services.open-webui.enable = true;
  };
}
