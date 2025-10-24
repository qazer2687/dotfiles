{
  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    
    
    
    # Unable to play videos on firefox with latest.
    #nixpkgs.url = "github:NixOS/nixpkgs/8a6d5427d99ec71c64f0b93d45778c889005d9c2";


    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asahi.url = "github:nix-community/nixos-apple-silicon";

    nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    textfox.url = "github:adriankarlen/textfox";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Personal
    nix-base16.url = "github:qazer2687/nix-base16";
  };

  outputs = {self, ...} @ inputs: {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      # Desktop
      sage = (import ./flake/sage) {inherit inputs self;};

      # Laptop
      jet = (import ./flake/jet) {inherit inputs self;};

      # Server
      mica = (import ./flake/mica) {inherit inputs self;};
    };
  };
}
