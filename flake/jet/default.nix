{
  jet = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs outputs;};
    modules = [
      ./hosts/jet
      nur.nixosModules.nur
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      asahi.nixosModules.apple-silicon-support
      {
        home-manager = {
          users.alex = ./homes/jet;
          extraSpecialArgs = {inherit inputs outputs;};
          useGlobalPkgs = true;
          useUserPackages = true;
          sharedModules = [
            inputs.nur.hmModules.nur
            inputs.sops-nix.homeManagerModules.sops
            inputs.nixvim.homeManagerModules.nixvim
          ];
        };
      }
    ];
  };
}