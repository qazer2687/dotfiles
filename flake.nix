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
    # Pinned because things usually go wrong on updates.
    asahi.url = "github:tpwrules/nixos-apple-silicon/e8c07c3ae199b55a8c1c35a7c067c5cef9c7e929";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake/main";
    swww.url = "github:LGFae/swww";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{
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
    flake-parts,
    ...
  }: 
  flake-parts.lib.mkFlake { inherit inputs; } {
    flake = {
      overlays = import ./overlays {inherit inputs;};
    };
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      #"aarch64-darwin"
    ];
    perSystem = { config, ... }: {

      packages = perSystem (system: import ./packages nixpkgs.legacyPackages.${system});

      nixosConfigurations = {
        jet = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; inherit (inputs) self; };
          modules = [
            ./hosts/jet
            nur.modules.nixos.default
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            asahi.nixosModules.apple-silicon-support
            {
              home-manager = {
                users.alex = ./homes/jet;
                extraSpecialArgs = { inherit inputs; inherit (inputs) self; };
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

        jade = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; inherit (inputs) self; };
          modules = [
            ./hosts/jade
            nur.modules.nixos.default
            sops-nix.nixosModules.sops
            nyx.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.alex = ./homes/jade;
                extraSpecialArgs = { inherit inputs; inherit (inputs) self; };
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

        ruby = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; inherit (inputs) self; };
          modules = [
            ./hosts/ruby
            nur.modules.nixos.default
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.alex = ./homes/ruby;
                extraSpecialArgs = { inherit inputs; inherit (inputs) self; };
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

        /*
        amber = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; inherit (inputs) self; };
          modules = [
            ./hosts/amber
          ];
        };
        */

        opal = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; inherit (inputs) self; };
          modules = [
            ./hosts/opal
            sops-nix.nixosModules.sops
            nyx.nixosModules.default
            # Add nix-minecraft module.
          ];
        };
      };
    };
  };
}

