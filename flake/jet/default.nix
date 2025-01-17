
{
  inputs,
  inputs.self, 
  nixpkgs,
  ...
}: {
  jet = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs inputs.self outputs; };
    modules = [
      ./hosts/jet
      nur.modules.nixos.default
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      asahi.nixosModules.apple-silicon-support
      {
        home-manager = {
          users.alex = ./homes/jet;
          extraSpecialArgs = { inherit inputs inputs.self outputs; };
          useGlobalPkgs = true;
          useUserPackages = true;
          sharedModules = [
            inputs.niri.homeModules.niri
            inputs.nur.modules.homeManager.default
            inputs.sops-nix.homeManagerModules.sops
            inputs.nixvim.homeManagerModules.nixvim
          ];
        };
      }
    ];
  };
}