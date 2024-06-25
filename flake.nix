{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    nixvim.url = "github:nix-community/nixvim";
    darwin.url = "github:lnl7/nix-darwin/master";
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    nixvim,
    nur,
    darwin,
    ...
  } @ inputs: {
    nixosConfigurations = {
      jade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/jade
          ./hosts/shared
          nur.nixosModules.nur
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];

            home-manager = {
              users.alex = ./homes/jade;
              extraSpecialArgs = {inherit inputs;};
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
    };

    nixosConfigurations = {
      ruby = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/ruby
          ./hosts/shared
          nur.nixosModules.nur
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];

            home-manager = {
              users.alex = ./homes/ruby;
              extraSpecialArgs = {inherit inputs;};
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
    };

    nixosConfigurations = {
      opal = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/opal
          ./hosts/shared
          {
            nix.registry.nixpkgs.flake = nixpkgs;
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];
          }
          sops-nix.nixosModules.sops
        ];
      };
    };

    darwinConfigurations = {
      onyx = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/onyx
        ];
      };
    };
  };
}
