{ inputs, self, ... }:

inputs.nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs self; };
  modules = [
    ../../hosts/jet
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.asahi.nixosModules.apple-silicon-support
    {
      home-manager = {
        users.alex = ../../homes/jet;
        extraSpecialArgs = { inherit inputs self; };
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
      };
    }
  ];
}