{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    }:
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
      nixosConfigurations = {
        laptop = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit user;
              };
              home-manager.users.${user} = {
                imports = [
                  ./home.nix
                ];
              };
            }
          ];
        };
      };
    };
}
