{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.sysctl.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sysctl.enable {

    # These options were recommended by the lynis security auditing tool.
    boot.kernel.sysctl = {
      # Network Hardening
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.log_martians" = 1;
      "net.ipv4.conf.default.log_martians" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.all.send_redirects" = 0;

      # Kernel Hardening
      "kernel.kptr_restrict" = 2;
      "kernel.unprivileged_bpf_disabled" = 1;
      "net.core.bpf_jit_harden" = 2;
      "kernel.core_uses_pid" = 1;
      "dev.tty.ldisc_autoload" = 0;

      # FS Hardening
      "fs.protected_hardlinks" = 1;
      "fs.protected_symlinks" = 1;
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;
    };
  };
}
