{ inputs, lib, config, pkgs, ... }:
let
  useHostResolvConf = config.networking.resolvconf.enable && config.networking.useHostResolvConf;

  stage2patch = pkgs.substituteAll {
    src = pkgs.runCommand "stage-2-init.sh" {} ''
      sed '2i exec 1<>/dev/null' ${inputs.nixpkgs}/nixos/modules/system/boot/stage-2-init.sh > $out
    '';
    shellDebug = "${pkgs.bashInteractive}/bin/bash";
    shell = "${pkgs.bash}/bin/bash";
    inherit (config.boot) readOnlyNixStore systemdExecutable extraSystemdUnitPaths;
    inherit (config.system.nixos) distroName;
    isExecutable = true;
    inherit useHostResolvConf;
    inherit (config.system.build) earlyMountScript;
    path = lib.makeBinPath ([
        pkgs.coreutils
        pkgs.util-linux
      ]
      ++ lib.optional useHostResolvConf pkgs.openresolv);
    postBootCommands =
      pkgs.writeText "local-cmds"
      ''
        ${config.boot.postBootCommands}
        ${config.powerManagement.powerUpCommands}
      '';
  };
in {
  system.build.stage2patch = lib.mkForce stage2patch;
}