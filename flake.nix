{
  description = "qazer2687's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    darwin.url = "github:lnl7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Fork of tpwrules/nixos-apple-silicon with performance 
    # tweaks, vulkan, louder speakers and some other things.
    #asahi.url = "github:zzywysm/nixos-asahi";
    # Pinned because latest is broken.
    asahi.url = "github:tpwrules/nixos-apple-silicon/e8c07c3ae199b55a8c1c35a7c067c5cef9c7e929";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake/main";
    swww.url = "github:LGFae/swww";
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
    nix-minecraft,
    nyx,
    niri,
    swww,
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
    overlays = import ./overlays {inherit inputs (inputs) self;};

    nixosConfigurations = {
      jet = import ./flake/jet { inherit inputs inputs.self nixpkgs; };
    };
    
    nixosConfigurations = {
      jade = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs inputs.self;};
        modules = [
          ./hosts/jade
          nur.modules.nixos.default
          sops-nix.nixosModules.sops
          nyx.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.alex = ./homes/jade;
              extraSpecialArgs = {inherit inputs inputs.self;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.modules.homeManager.default
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
      ruby = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs inputs.self;};
        modules = [
          ./hosts/ruby
          nur.modules.nixos.default
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.alex = ./homes/ruby;
              extraSpecialArgs = {inherit inputs inputs.self;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.modules.homeManager.default
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
        specialArgs = {inherit inputs inputs.self;};
        modules = [
          ./hosts/onyx
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            home-manager = {
              users.alex = ./homes/onyx;
              extraSpecialArgs = {inherit inputs inputs.self;};
              useGlobalPkgs = true;
              useUserPackages = true;
              sharedModules = [
                inputs.nur.modules.homeManager.default
                inputs.sops-nix.homeManagerModules.sops
                inputs.nixvim.homeManagerModules.nixvim
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
      amber = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs inputs.self;};
        modules = [
          ./hosts/amber
        ];
      };
    };

    nixosConfigurations = {
      opal = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs inputs.self;};
        modules = [
          ./hosts/opal
          sops-nix.nixosModules.sops
          nyx.nixosModules.default
          # Add nix-minecraft module.
        ];
      };
    };
  };
}
