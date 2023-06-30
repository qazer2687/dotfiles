{
  description = "NixOS configuration";

  inputs = {
    # Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Fingerprint Drivers  
    nixos-06cb-009a-fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
  };

  outputs = {self, nixpkgs, nixpkgs-stable, home-manager, nixos-06cb-009a-fingerprint-sensor, ... }@inputs: {
    
    # Development Environments
    devShells.x86_64-linux.r = let pkgs = nixpkgs.legacyPackages.x86_64-linux; in pkgs.mkShellNoCC {
      packages = [
        (pkgs.rWrapper.override { packages = with pkgs.rPackages; [ ggplot2 stringr gsubfn languageserver ]; })
      ];
    };
    
    # Hosts
    nixosConfigurations = {

      # Desktop Configuration ~ Jade
      jade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/jade
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      # Laptop Configuration ~ Ruby
      ruby = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/ruby
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };

      # Server Configuration ~ Opal
        opal = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/opal ];
      };

    };
  };
}
