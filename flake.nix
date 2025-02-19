{
  description = "qazer2687's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    sops-nix.url = "github:Mic92/sops-nix";
    nur.url = "github:nix-community/NUR";
    darwin.url = "github:lnl7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
		# Ref required for 24.11 machines.
    asahi.url = "github:tpwrules/nixos-apple-silicon?ref=releasep2-2024-12-25";
		#asahi.url = "github:tpwrules/nixos-apple-silicon";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake";
    swww.url = "github:LGFae/swww";
    flake-parts.url = "github:hercules-ci/flake-parts";
    ags.url = "github:aylur/ags"; 

    /* Undo because broken.
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    */
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-linux" "x86_64-linux" "aarch64-darwin"];

      flake = {
        overlays = import ./overlays {inherit inputs;};

        nixosConfigurations = {
          jade = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/jade
              inputs.nur.modules.nixos.default
              inputs.sops-nix.nixosModules.sops
              inputs.nyx.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/jade;
                  extraSpecialArgs = {inherit inputs self;};
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

          jet = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/jet
              inputs.nur.modules.nixos.default
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              inputs.asahi.nixosModules.apple-silicon-support
              {
                home-manager = {
                  users.alex = ./homes/jet;
                  extraSpecialArgs = {inherit inputs self;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.niri.homeModules.niri
                    inputs.ags.homeManagerModules.default
                    inputs.nur.modules.homeManager.default
                    inputs.sops-nix.homeManagerModules.sops
                    inputs.nixvim.homeManagerModules.nixvim
                  ];
                };
              }
            ];
          };

          ruby = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/ruby
              inputs.nur.modules.nixos.default
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/ruby;
                  extraSpecialArgs = {inherit inputs;};
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

          opal = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/opal
              inputs.sops-nix.nixosModules.sops
              inputs.nyx.nixosModules.default
              # Add nix-minecraft module.
            ];
          };
        };
      };
    };
}
