{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.ollama.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.ollama.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-vulkan;
      host = "0.0.0.0";
      port = 11434;
    };
  };
}
