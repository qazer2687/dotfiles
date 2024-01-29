{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.virt-manager.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.virt-manager.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = with pkgs; [OVMFFull.fd];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;

    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      gnome.adwaita-icon-theme
    ];

    users.users.alex.extraGroups = ["libvirtd"];
  };
}
