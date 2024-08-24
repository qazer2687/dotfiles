{
  lib,
  config,
  pkgs,
  ...
}: let
  gpuIDs = [
    ## For an RTX 2070 Super.
    "10de:2482" # Graphics
    "10de:228b" # Audio
  ];
in {
  options.modules.libvirtd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.libvirtd.enable {
    
    # Virtualisation Service
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

    # VFIO
    config = let cfg = config.libvirtd;
    in {
      boot = {
        initrd.kernelModules = [
          # VFIO
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
          "vfio_virqfd"

          # Nvidia
          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];

        kernelParams = [
          ## Enable IOMMU.
          "amd_iommu=on"
        ] ++ lib.optional cfg.enable
          ## Isolate the GPU.
          ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
      };
    };

    # Dconf
    programs.dconf.enable = true;
    
    # Required Packages
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

    # Add Group
    users.users.alex.extraGroups = ["libvirtd"];

  };
}