{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  fleet = {
    "sage" = { hostName = "sage"; maxJobs = 16;  speedFactor = 4; };
    "mica" = { hostName = "mica"; maxJobs = 2; speedFactor = 1; };
    "jet" = { hostName = "jet"; maxJobs = 8; speedFactor = 2; };
  };
  
  fleetUser = "alex";
  myName = config.networking.hostName;
  myMachine = fleet.${myName};
  otherMachines = lib.filterAttrs (n: v: n != myName) fleet;
  
  buildMachines = lib.attrValues (lib.mapAttrs (n: v: {
    inherit (v) hostName maxJobs speedFactor;
    sshUser = fleetUser;
    protocol = "ssh-ng";
    systems = [ "x86_64-linux" "aarch64-linux" ];
    supportedFeatures = [ "big-parallel" "kvm" ];
  }) otherMachines);

in {
  options.modules.remote-builder.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.remote-builder.enable {
  services.openssh = {
    enable = true;
  };

  #boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix = lib.mkMerge [
    {
      settings = {
        #builders = "@daemon";
        trusted-users = [ "root" fleetUser ];
        system-features = [ "big-parallel" "kvm" "nixos-test" ];
        cores = 0;
        max-jobs = myMachine.maxJobs;
      };
    }
    
    (lib.mkIf (otherMachines != {}) {
      inherit buildMachines;
      distributedBuilds = true;
      extraOptions = "builders-use-substitutes = true";
    })
  ];

  programs.ssh.extraConfig = lib.concatMapStrings (info: ''
    Host ${info.hostName}
      User ${fleetUser}
      Compression no
      ControlMaster auto
      ControlPath ~/.ssh/sockets/%r@%h-%p
      ControlPersist 600
      ServerAliveInterval 60
  '') (lib.attrValues fleet);
  };
}
