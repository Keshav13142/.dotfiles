{ inputs, user, home-manager, pkgs, nixpkgs }:
{
  wsl = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs user; };
    modules = [
      ../nixos/home.nix
      {
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          packages = with pkgs; [
            eza
            zoxide
            fish
          ];

          stateVersion = "22.05";
        };
        nixpkgs.config.allowUnfreePredicate = _: true;
      }
    ];
  };
}
