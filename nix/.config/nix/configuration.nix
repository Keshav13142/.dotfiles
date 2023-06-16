{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
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
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "input"
      "disk"
      "libvirtd"
      "audio"
      "video"
      "camera"
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    alacritty
    authy
    bat
    betterlockscreen
    bitwarden
    blueman
    brave
    brillo
    btop
    cargo
    clang-tools_9
    clipmenu
    cmatrix
    coreutils
    cowsay
    dracula-icon-theme
    dracula-theme
    dunst
    exa
    fd
    feh
    ffmpeg
    figlet
    flameshot
    flatpak
    fnm
    fzf
    gcc
    gimp
    git
    glow
    gnome.nautilus
    gnumake
    gparted
    gum
    imagemagick
    killall
    lazygit
    lf
    libnotify
    libreoffice-qt
    lxappearance
    neofetch
    neovim
    networkmanagerapplet
    nfs-utils
    ninja
    nixpkgs-fmt
    nodejs
    obs-studio
    okular
    openssl
    pavucontrol
    pciutils
    picom
    polkit_gnome
    polybar
    powertop
    python310Packages.pip
    python3Full
    qemu
    ripgrep
    rofi
    rofimoji
    scrot
    stdenv
    stow
    sxhkd
    tig
    tldr
    tmux
    trash-cli
    tree
    unrar
    unzip
    usbutils
    virt-manager
    vlc
    vscode
    wget
    xclip
    xdg-desktop-portal-gtk
    xorg.libX11
    xorg.libX11.dev
    xorg.libxcb
    xorg.libXft
    xorg.libXinerama
    xorg.xbacklight
    xorg.xev
    xorg.xinit
    xorg.xinput
    xorg.xkill
    xorg.xmodmap
    xsel
    zip
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
    # auto-cpufreq.enable = true;
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

  # Nix Package Manager settings
  nix = {
    settings.auto-optimise-store = true; # Optimise syslinks
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    # Enable nixFlakes on system
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  # GTK3 global theme (widget and icon theme)
  environment.etc."xdg/gtk-3.0/settings.ini" = {
    text = ''
      [Settings]
      gtk-icon-theme-name=Dracula
      gtk-theme-name=Dracula
    '';
    mode = "444";
  };


  nixpkgs.config = {
    packageOverrides = pkgs: {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };
      rofi = pkgs.rofi.override {
        plugins = [
          pkgs.rofi-calc
        ];
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
