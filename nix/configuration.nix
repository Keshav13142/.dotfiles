{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/vda";
      useOSProber = true;
    };
  };

  networking = {
    firewall.enable = false;
    enableIPv6 = false;
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  users.users.keshav = {
    isNormalUser = true;
    description = "keshav";
    extraGroups = [ "networkmanager" "wheel" "kvm" "input" "disk" "libvirtd" ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    betterlockscreen
    brave
    brillo
    cargo
    clang-tools_9
    clipmenu
    dunst
    exa
    feh
    flatpak
    fnm
    gcc
    gimp
    git
    gnumake
    gparted
    lazygit
    lf
    neofetch
    neovim
    nfs-utils
    ninja
    nixpkgs-fmt
    nodejs
    openssl
    pavucontrol
    picom
    polkit_gnome
    polybar
    python310Packages.pip
    python3Full
    qemu
    ripgrep
    rofi
    scrot
    stdenv
    sxhkd
    tldr
    tmux
    trash-cli
    unzip
    virt-manager
    vscode
    wget
    xclip
    xdg-desktop-portal-gtk
    xorg.libX11
    xorg.libX11.dev
    xorg.libxcb
    xorg.libXft
    xorg.libXinerama
    xorg.xinit
    xorg.xinput
    zoxide
  ];

  # i3 configuration
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = false;
    };
    displayManager.defaultSession = "none+i3";
    windowManager.i3.enable = true;
    layout = "us";
    xkbVariant = "intl";
    libinput.enable = true;
  };

  services = {
    printing.enable = true;
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    picom.enable = true;
    # clipmenud.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;


  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec=1s
    '';
  };

  nixpkgs.config = {
    packageOverrides = pkgs: {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
    };
    allowUnfree = true;
  };

  system = {
    copySystemConfiguration = true;
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";
    stateVersion = "23.05";
  };
}
