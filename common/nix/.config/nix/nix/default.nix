{ user, home-manager, pkgs, ... }:
{

  wsl = home-manager.lib.homeManagerConfiguration {
    inherit pkgs user;
    modules = [
      ../nixos/home.nix
      {
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          packages = with pkgs; [
            exa
            zoxide
            zsh
          ];

          nixpkgs.config.allowUnfreePredicate = _: true;

          stateVersion = "22.05";
        };
      }
    ];
  };
}
