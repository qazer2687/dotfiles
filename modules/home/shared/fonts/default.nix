{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.fonts.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fonts.enable {
    
    home.file.".config/fontconfig/conf.d/10-tx02-alias.conf".text = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <alias>
          <family>TX02</family>
          <prefer>
            <family>TX-02</family>
          </prefer>
        </alias>
      </fontconfig>
    '';

    home.packages = with pkgs; [
      noto-fonts-color-emoji
      noto-fonts-cjk-sans

      atkinson-hyperlegible
      agave
      terminus_font
      departure-mono
      eb-garamond
      fixedsys-excelsior
      monaspace
      proggyfonts
      ibm-plex

      # Icons
      lucide

      # Custom
      TX02
      pragmatapro

      # Nerd Fonts
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.iosevka
      nerd-fonts.liberation
      nerd-fonts.jetbrains-mono
      maple-mono.NF
    ];
  };
}
