{
  lib,
  config,
  ...
}: {
  options.modules.sunshine.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      # Not needed over the tailnet, tailscale0 is already whitelisted.
      openFirewall = false;
      settings = {
        # AMF is unsupported on RDNA4/Linux, VAAPI via radeonsi is the working path.
        encoder = "vaapi";
        adapter_name = "/dev/dri/renderD128";
        # WLR capture renders the virtual STREAM output, decoupled from the OLED.
        capture = "wlr";
        output_name = "STREAM";
        # Caps the bitrate excursions on static content (LizardByte/Sunshine#3817).
        max_bitrate = 40000;
      };
    };
  };
}
