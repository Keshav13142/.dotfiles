{ inputs, config, pkgs, ... }:
let
  user = "keshav";
in
{
  imports =
    [
      ./hardware-configuration.nix
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

  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [
      "audio"
      "camera"
      "disk"
      "docker"
      "input"
      "kvm"
      "libvirtd"
      "networkmanager"
      "power"
      "render"
      "video"
      "wheel"
    ];
  };

  fonts.fonts = with pkgs; [
    font-awesome
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
      ];
    })
  ];

  # Enable sound
  sound.enable = true;

  # Set zsh as the default shell
  programs = {
    zsh.enable = true;
    dconf.enable = true;
    sniffnet.enable = true;
    hyprland = {
      xwayland.enable = true;
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # nvidiaPatches = true;
    };
    kdeconnect.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo = {
      enable = true;
      execWheelOnly = true;
    };
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
    libvirtd.enable = true;
  };

  # Add ~/.local/bin/ to $PATH
  environment.localBinInPath = true;

  services = {
    # Xserver config
    xserver = {
      enable = true;

      displayManager = {
        lightdm = {
          # Lightdm custom theme
          enable = true;
          background = "/tmp/back.jpg";
          greeters.slick = {
            enable = true;
            theme = {
              package = pkgs.gruvbox-gtk-theme;
              name = "Gruvbox-Dark-BL";
            };
            iconTheme = {
              package = pkgs.gruvbox-dark-icons-gtk;
              name = "oomox-gruvbox-dark";
            };
            cursorTheme = {
              package = pkgs.capitaine-cursors-themed;
              name = "Capitaine Cursors (Gruvbox)";
            };
            extraConfig = "clock-format=%a, %-e %b %-l:%M %p ";
          };
        };

        # Enable wayland
        gdm.wayland = true;
      };

      layout = "us";
      libinput.enable = true;

      # X11 + i3
      # displayManager = {
      #   defaultSession = "none+i3";
      #   gdm.wayland = false;
      # };
      # xkbOptions = "caps:escape_shifted_capslock";
      # xkbVariant = "";
      # windowManager.i3.enable = true;
    };

    # For filemanagers to work properly?
    gvfs.enable = true;

    # printing.enable = true;
    # flatpak.enable = true;
    # cron.enable = true;

    gnome.gnome-keyring.enable = true;

    dbus = {
      enable = true;
      packages = with pkgs; [ dconf ];
    };

    ###### POWER MANAGEEMENT ############
    power-profiles-daemon.enable = false;

    thermald.enable = true;

    tlp = {
      # Followed https://knowledgebase.frame.work/en_us/optimizing-fedora-battery-life-r1baXZh
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_BAT = 60;
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        NMI_WATHCDOG = 0;
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        RUNTIME_PM_ON_AC = 0;
        RUNTIME_PM_ON_BAT = 1;
        SCHED_POWERSAVE_ON_AC = 0;
        SCHED_POWERSAVE_ON_BAT = 1;
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
        USB_AUTOSUSPEND = 1;
        USE_EXCLUDE_AUDIO = 1;
        USE_EXCLUDE_BTUSB = 0;
        USE_EXCLUDE_PHONE = 0;
        USE_EXCLUDE_WWAN = 0;
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
        WOL_DISABLE = "Y";
      };
    };

    # Bluetooth
    blueman.enable = true;

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    # To allow polybar and other scripts to set brightness
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
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
      DefaultTimeoutStopSec=10s
    '';

    #For lvim lsp modules to work
    tmpfiles = {
      rules = [
        "L+ /lib/${builtins.baseNameOf pkgs.stdenv.cc.bintools.dynamicLinker} - - - - ${pkgs.stdenv.cc.bintools.dynamicLinker}"
        "L+ /lib64 - - - - /lib"
      ];
    };
  };

  # Nix Package Manager settings
  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      trusted-users = [ "${user}" "root" ];
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
    package = pkgs.nixVersions.unstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config = {
    packageOverrides = pkgs: {
      polybar = pkgs.polybar.override {
        i3Support = true;
      };

      # When using X11
      # rofi = pkgs.rofi.override {
      #   plugins = [
      #     pkgs.rofi-calc
      #   ];
      # };

      rofi-wayland = pkgs.rofi-wayland.override {
        plugins = [
          pkgs.rofi-calc
        ];
      };

      # TO enable hyprland support
      waybar = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
    allowUnfree = true;
  };

  documentation.man.generateCaches = true;

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";
    stateVersion = "23.05";
  };
}
