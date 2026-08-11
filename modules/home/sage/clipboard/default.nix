{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.clipboard.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.clipboard.enable {
    systemd.user.services.wl-clip-persist = {
      Unit = {
        Description = "Clipboard persistence daemon";
        PartOf = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard both";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
