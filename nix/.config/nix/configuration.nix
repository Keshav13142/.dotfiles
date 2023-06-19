{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  boot = {
    # Bootloader
    loader = {
      grub = {
        enable = true;
        useOSProber = true;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" "ntfs3" ];
    kernelPackages = pkgs.linuxPackages_latest;
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
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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
    brave
    brillo
    btop
    cargo
    clang-tools_9
    clipmenu
    cmatrix
    coreutils
    cowsay
    diff-so-fancy
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
    gitmux
    glow
    gnome.nautilus
    gnumake
    gparted
    gtk3
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
    pamixer
    pavucontrol
    pciutils
    picom
    playerctl
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
    spotify
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
    yt-dlp
    zip
    zoxide
  ];

  # i3 configuration
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "none+i3";
    windowManager.i3.enable = true;
    layout = "us";
    xkbOptions = "caps:escape_shifted_capslock";
    xkbVariant = "";
    libinput.enable = true;
  };

  programs.dconf.enable = true;

  services = {
    printing.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf ];
    };
    auto-cpufreq.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    # To allow polybar and other scripts to set brightness
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';
  };

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  hardware.bluetooth.enable = true;

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
    # Enable nixFlakes on system
    package = pkgs.nixVersions.unstable;
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

  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
        "Iosevka"
        "IBMPlexMono"
        "CascadiaCode"
        "FiraCode"
      ];
    })
  ];

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
