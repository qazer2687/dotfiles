{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Unable to play videos on firefox with latest.
    #nixpkgs.url = "github:NixOS/nixpkgs/8a6d5427d99ec71c64f0b93d45778c889005d9c2";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    asahi = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    hyprland.url = "github:hyprwm/Hyprland";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    textfox.url = "github:adriankarlen/textfox";

    nix-base16.url = "github:qazer2687/nix-base16";
  };

  outputs = {self, ...} @ inputs: {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      # Desktop
      sage = (import ./flake/sage) {inherit inputs self;};
      jade = (import ./flake/jade) {inherit inputs self;};

      # Laptop
      jet = (import ./flake/jet) {inherit inputs self;};

      # Server
      mica = (import ./flake/mica) {inherit inputs self;};
    };
  };
}
