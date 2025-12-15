{
  inputs,
  self,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs self;};
  modules = [
    ../../hosts/mica
    ../../modules/base/shared
    ../../modules/base/mica
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.nyx.nixosModules.default
    inputs.flatpak.nixosModules.nix-flatpak
    {
      home-manager = {
        users.alex = ../../homes/mica;
        extraSpecialArgs = {inherit inputs self;};
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
      };
    }
  ];
}
