{
  description = "Qazer's NixOS Configuration";

  inputs = {

    # Unstable Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.inputs.nixpkgs.follows = "nixpkgs";
    
    # Home-Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Sops-Nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.follows.nixpkgs = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, sops-nix, ... }@inputs: {
    
    # Hosts
    nixosConfigurations = {

      # Desktop Configuration
      jade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/jade
          sops-nix.nixosModules.sops
          {
            nix.registry.nixpkgs.flake = nixpkgs;
          }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      # Laptop Configuration
      ruby = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/ruby
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
  };
};