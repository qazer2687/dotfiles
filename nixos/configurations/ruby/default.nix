 

  # Nix Experimental Features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Nix Miscellaneous Options
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  
  # No Login Manager
  environment.loginShellInit = '' 
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';
}
