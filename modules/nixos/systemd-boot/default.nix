{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  a = 1;
  /*
  useHostResolvConf = config.networking.resolvconf.enable && config.networking.useHostResolvConf;
  bootStage2 = pkgs.replaceVars {
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
  */
in {
  options.modules.systemd-boot.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.systemd-boot.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.timeout = 0;
    #system.build.bootStage2 = lib.mkForce bootStage2;
    environment.etc = {
      "issue" = {
        text = "[?12l[?25h";
        mode = "0444";
      };
    };
  };
}
