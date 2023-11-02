{
  lib,
  config,
  ...
}: {
  options.systemModules.virt-manager.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.virt-manager.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.users.alex.extraGroups = [ "libvirtd" ];
  };
}
