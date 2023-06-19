{
  inputs = # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

      # home-manager = {
      #   # User Package Management
      #   url = "github:nix-community/home-manager/release-23.05";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };

      # nixgl = {
      #   # OpenGL
      #   url = "github:guibou/nixGL";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };

      # plasma-manager = {
      #   # KDE Plasma user settings
      #   url = "github:pjones/plasma-manager"; # Add "inputs.plasma-manager.homeManagerModules.plasma-manager" to the home-manager.users.${user}.imports
      #   inputs.nixpkgs.follows = "nixpkgs";
      #   inputs.home-manager.follows = "nixpkgs";
      # };
    };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        keshav = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
    };
}
