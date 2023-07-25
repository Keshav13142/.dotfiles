{ lib, user, inputs, home-manager, spicetify-nix, system }:
{
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./configuration.nix
      ./laptop
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user spicetify-nix;
        };
        home-manager.users.${user} = {
          imports = [
            ./home.nix
            ./laptop/home.nix
          ];
        };
      }
    ];
  };
}
