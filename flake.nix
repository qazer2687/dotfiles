{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      # url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    asahi.url = "github:tpwrules/nixos-apple-silicon";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = {self, ...} @ inputs: {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      # Desktop
      jade = (import ./flake/jade) {inherit inputs self;};

      # Laptop
      jet = (import ./flake/jet) {inherit inputs self;};

      # Server
      mica = (import ./flake/mica) {inherit inputs self;};
    };
  };
}
