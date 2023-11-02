{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.virt-manager.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.virt-manager.enable {
    virtualisation.libvirtd.enable = true;
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager ];
    users.users.alex.extraGroups = ["libvirtd"];
  };
}
