{
  description = "qazer2687's NixOS Flake";

  inputs = {
    /*
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    */

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    asahi.url = "github:tpwrules/nixos-apple-silicon";
    niri.url = "github:sodiboo/niri-flake";
    flake-parts.url = "github:hercules-ci/flake-parts";

    zen.url = "github:0xc000022070/zen-browser-flake";

    # Anything listed below I don't currently use but I
    # will leave here in case I need to bring something back.
    #
    # ags.url = "github:aylur/ags";
    # hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # darwin.url = "github:lnl7/nix-darwin";
    # swww.url = "github:LGFae/swww";
    # nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    # nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # nixvim.url = "github:nix-community/nixvim";
    # nix-flatpak.url = "github:gmodena/nix-flatpak";
    # nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # nur.url = "github:nix-community/NUR";
    # nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # astal.url = "github:qazer2687/astal";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-linux" "x86_64-linux"];

      flake = {
        overlays = import ./overlays { inherit inputs config; };

        nixosConfigurations = {
          jade = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/jade
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/jade;
                  extraSpecialArgs = {inherit inputs self;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.niri.homeModules.niri
                    inputs.sops-nix.homeManagerModules.sops
                  ];
                };
              }
            ];
          };

          jet = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/jet
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
                    inputs.sops-nix.homeManagerModules.sops
                  ];
                };
              }
            ];
          };

          ruby = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/ruby
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/ruby;
                  extraSpecialArgs = {inherit inputs;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.sops-nix.homeManagerModules.sops
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
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/opal;
                  extraSpecialArgs = {inherit inputs self;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.sops-nix.homeManagerModules.sops
                  ];
                };
              }
            ];
          };

          mica = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs self;};
            modules = [
              ./hosts/mica
              inputs.sops-nix.nixosModules.sops
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  users.alex = ./homes/mica;
                  extraSpecialArgs = {inherit inputs self;};
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                    inputs.niri.homeModules.niri
                    inputs.sops-nix.homeManagerModules.sops
                  ];
                };
              }
            ];
          };
        };
      };
    };
}
