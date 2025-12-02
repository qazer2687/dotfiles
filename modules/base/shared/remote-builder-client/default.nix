{ config, lib, ... }:

{
  # Remote builder configuration
  nix = {
    buildMachines = [
      {
        # ⚠️ IMPORTANT: Replace with your builder's hostname or IP address
        hostName = "sage";
        
        # Use SSH-ng protocol (more efficient)
        protocol = "ssh-ng";
        
        # Architectures this builder can produce
        systems = [ "x86_64-linux" "aarch64-linux" ];
        
        # Required features for builds
        supportedFeatures = [ "big-parallel" "kvm" "nixos-test" "benchmark" ];
        
        # Optional: Override server's max-jobs for this client
        maxJobs = 16;
        
        # Optional: Preference factor (higher = preferred)
        speedFactor = 2;
        
        # Optional: SSH user if different from local user
        # sshUser = "client-user";
      }
    ];

    # Enable distributed builds
    distributedBuilds = true;

    # Performance optimizations
    extraOptions = ''
      builders-use-substitutes = true
    '';

    # Local build settings (when not offloading)
    settings = {
      max-jobs = "auto"; # or 0 to disable local builds entirely
      cores = 0;
    };
  };

  # SSH performance optimizations
  programs.ssh.enable = true;
  programs.ssh.extraConfig = ''
    Host builder-hostname-or-ip
      Compression yes
      ControlMaster auto
      ControlPath ~/.ssh/sockets/%r@%h-%p
      ControlPersist 600
  '';
}