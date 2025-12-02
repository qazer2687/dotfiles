{ config, lib, ... }:

{
  # SSH server for remote connections
  services.openssh = {
    enable = true;
    # STRONGLY RECOMMENDED: Disable password auth, use SSH keys only
    # settings.PasswordAuthentication = false;
  };

  # Open firewall for SSH (adjust if using custom port)
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Nix daemon configuration
  nix = {
    settings = {
      # ⚠️ IMPORTANT: Replace "client-user" with the username from your client machine
      # This user must be able to SSH into this server
      trusted-users = [ "root" "alex" ]; # e.g., "alex"
      
      # Features this builder provides
      system-features = [ "big-parallel" "kvm" "nixos-test" "benchmark" ];
      
      # Use all 16 threads (8c16t CPU)
      max-jobs = 16;
      
      # Auto-detect core allocation (balanced across physical cores)
      cores = 0;
    };
  };

  # Enable cross-architecture compilation (remove if not needed)
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}