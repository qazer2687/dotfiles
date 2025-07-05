{
  inputs,
  self,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs self;};
  modules = [
    ../../hosts/jade
    ../../modules/base/shared
    ../../modules/base/jade
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.nyx.nixosModules.default
    inputs.flatpak.nixosModules.nix-flatpak
    {
      home-manager = {
        users.alex = ../../homes/jade;
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
