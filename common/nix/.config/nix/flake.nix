{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    spicetify-nix.url = "github:the-argus/spicetify-nix";
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
      pkgs = import nixpkgs {
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      # NixOS configurations
      nixosConfigurations = (
        import ./nixos {
          inherit inputs home-manager lib nixpkgs pkgs spicetify-nix user;
        }
      );

      # Home-manager configurations
      homeConfigurations = (
        # Non-NixOS configurations
        import ./nix {
          inherit inputs home-manager lib nixpkgs pkgs user;
        }
      );
    };
}
