{
  lib,
  config,
  ...
}: {
  options.modules.mako.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.mako.enable {
    services.mako = {
      enable = true;
      backgroundColor = "#FAFAFA";
      textColor = "#333333";
      borderColor = "#CCCCCC";
      borderRadius = 15;
      borderSize = 1;
      progressColor = "source #007AFF";
      font = "SF Pro Text 12";
      width = 300;
      height = 80;
      margin = "10";
      padding = "8";
      #iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
      defaultTimeout = 5000;
      layer = "top";
      anchor = "top-right";

      extraConfig = ''
        # These settings aren't exposed in the module
        text-alignment=left
        max-icon-size=64
        group-by=app-name
        history=yes
        ignore-timeout=yes
        markup=yes
        actions=inline
        inline-replies=yes
        
        # Only override urgency levels
        [urgency=low]
        background-color=#E8F2FC
        border-color=#B3D7FF
        
        [urgency=critical]
        background-color=#FFD1D1
        text-color=#CC0000
        border-color=#CC0000
      '';
    };
  };
}
