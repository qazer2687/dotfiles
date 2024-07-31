{
  lib,
  config,
  ...
}: {
  options.modules.sddm.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      defaultSession = "sway";
      wayland.enable = true;
      theme = ''
        [General]
        # Password mask character
        passwordCharacter=*
        # Mask password characters or not ("true" or "false")
        passwordMask=true
        # value "1" is all display width, "0.5" is a half of display width etc.
        passwordInputWidth=0.5
        # Background color of password input
        passwordInputBackground=
        # Radius of password input corners
        passwordInputRadius=
        # "true" for visible cursor, "false"
        passwordInputCursorVisible=true
        # Font size of password (in points)
        passwordFontSize=96
        passwordCursorColor=random
        passwordTextColor=
        # Allow blank password (e.g., if authentication is done by another PAM module)
        passwordAllowEmpty=false

        # Enable or disable cursor blink animation ("true" or "false")
        cursorBlinkAnimation=true

        # Show or not sessions choose label
        showSessionsByDefault=false
        # Font size of sessions choose label (in points).
        sessionsFontSize=24

        # Show or not users choose label
        showUsersByDefault=false
        # Font size of users choose label (in points)
        usersFontSize=48
        # Show user real name on label by default
        showUserRealNameByDefault=true

        # Path to background image
        background=
        # Or use just one color
        backgroundFill=#000000
        backgroundFillMode=aspect

        # Default text color for all labels
        basicTextColor=#ffffff

        # Blur radius for background image
        blurRadius=0

        # Hide cursor
        hideCursor=true
      '';
    };
  };
}
