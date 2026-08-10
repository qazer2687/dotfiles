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
      # KMS capture bypasses the compositor: no portal prompts, works on Hyprland.
      capSysAdmin = true;
      # Not needed over the tailnet, tailscale0 is already whitelisted.
      openFirewall = false;
      settings = {
        # AMF is unsupported on RDNA4/Linux, VAAPI via radeonsi is the working path.
        encoder = "vaapi";
        adapter_name = "/dev/dri/renderD128";
        capture = "kms";
        # Caps the bitrate excursions on static content (LizardByte/Sunshine#3817).
        max_bitrate = 40000;
      };
    };
  };
}
