{...}: {
  imports = [
    ../../modules
  ];

  systemModules = {
    user.oli.enable = true;
    fonts.enable = true;
    gdm.xorg.enable = true;
  };
}
