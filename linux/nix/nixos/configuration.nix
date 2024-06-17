{ pkgs, user, ... }:
{

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
      ];
    })
  ];

  # Nix Package Manager settings
  nix = {
    settings = {
      trusted-users = [ "${user}" "root" ];
      substituters = [
        "https://cache.nixos.org"
      ];
      auto-optimise-store = true; # Optimise syslinks
      max-jobs = "auto";
      cores = 0; # use them all
      allowed-users = [ "@wheel" ];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    # Enable nixFlakes on system
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";
    stateVersion = "23.05";
  };

  environment.sessionVariables = {
    FLAKE = "/home/keshav/.dotfiles/linux/nix";
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };
  documentation.man.generateCaches = true;
}
