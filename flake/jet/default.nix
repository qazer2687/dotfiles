{
  inputs,
  self,
  ...
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs self;};
  modules = [
    ../../hosts/jet
    ../../modules/base/shared
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.asahi.nixosModules.apple-silicon-support
    inputs.nyx.nixosModules.default
    {
      home-manager = {
        users.alex = ../../homes/jet;
        extraSpecialArgs = {inherit inputs self;};
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
           inputs.niri.homeModules.niri
        ];
      };
    }
  ];
}
