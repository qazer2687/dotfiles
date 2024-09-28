{
  description = "Qazer's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    darwin.url = "github:lnl7/nix-darwin/master";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    asahi.url = "github:tpwrules/nixos-apple-silicon";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    nur,
    darwin,
    nixvim,
    nix-homebrew,
    asahi,
    nix-vscode-extensions,
    nix-flatpak,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
    ];
    # A function which generations an attribute by calling a
    # function you pass to it, with each system as an argument.
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      jade = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/jade
          nur.nixosModules.nur
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.alex = ./homes/jade;
              extraSpecialArgs = {inherit inputs outputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.hmModules.nur
                inputs.sops-nix.homeManagerModules.sops
                inputs.nixvim.homeManagerModules.nixvim
                inputs.nix-flatpak.homeManagerModules.nix-flatpak
              ];
            };
          }
        ];
      };
    };

    nixosConfigurations = {
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
    };

    nixosConfigurations = {
      ruby = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/ruby
          nur.nixosModules.nur
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
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

    darwinConfigurations = {
      onyx = darwin.lib.darwinSystem {
        pkgs = import inputs.nixpkgs {system = "aarch64-darwin";};
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/onyx
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            home-manager = {
              users.alex = ./homes/onyx;
              extraSpecialArgs = {inherit inputs;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.hmModules.nur
                inputs.sops-nix.homeManagerModules.sops
              ];
            };

            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "alex";
              autoMigrate = true;
            };
          }
        ];
      };
    };

    nixosConfigurations = {
      opal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/opal
          sops-nix.nixosModules.sops
        ];
      };
    };
  };
}
