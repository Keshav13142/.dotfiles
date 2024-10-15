{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , spicetify-nix
    , home-manager
    , ...
    } @ inputs:
    let
      user = "keshav";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      # NixOS configurations
      nixosConfigurations = (
        import ./nixos {
          inherit inputs home-manager lib nixpkgs pkgs spicetify-nix user system;
        }
      );

      # Non-NixOS configurations
      homeConfigurations = (
        import ./nix {
          inherit inputs home-manager nixpkgs user pkgs;
        }
      );
    };
}
