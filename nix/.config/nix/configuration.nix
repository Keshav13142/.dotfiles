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
        "Iosevka"
        "IBMPlexMono"
        "CascadiaCode"
        "FiraCode"
      ];
    })
  ];

  # Enable sound
  sound.enable = true;

  # Set zsh as the default shell
  programs = {
    zsh.enable = true;
    dconf.enable = true;
    hyprland = {
      xwayland.enable = true;
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # nvidiaPatches = true;
    };
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
      # videoDrivers = [ "nvidia" ];
      enable = true;
      displayManager = {
        lightdm.enable = true;
        gdm = {
          enable = false;
          wayland = true;
        };
      };
      # X11 + i3
      # displayManager = {
      #   defaultSession = "none+i3";
      #   gdm.wayland = false;
      # };
      # layout = "us";
      # xkbOptions = "caps:escape_shifted_capslock";
      # xkbVariant = "";
      # libinput.enable = true;
      # windowManager.i3.enable = true;
    };
    # For nautilus to work properly
    gvfs.enable = true;
    printing.enable = true;
    flatpak.enable = true;
    cron.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf ];
    };
    thermald.enable = true;
    tlp = {
      enable = true;
      # Followed https://knowledgebase.frame.work/en_us/optimizing-fedora-battery-life-r1baXZh
      settings = {
        INTEL_GPU_MIN_FREQ_ON_AC = 100;
        INTEL_GPU_MIN_FREQ_ON_BAT = 100;
        INTEL_GPU_MAX_FREQ_ON_AC = 1500;
        INTEL_GPU_MAX_FREQ_ON_BAT = 800;
        INTEL_GPU_BOOST_FREQ_ON_AC = 1500;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 1000;
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";
        WOL_DISABLE = "Y";
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";
        RUNTIME_PM_ON_AC = 0;
        RUNTIME_PM_ON_BAT = 1;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 30;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        SCHED_POWERSAVE_ON_AC = 0;
        SCHED_POWERSAVE_ON_BAT = 1;
        NMI_WATHCDOG = 0;
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        USB_AUTOSUSPEND = 1;
        USE_EXCLUDE_AUDIO = 1;
        USE_EXCLUDE_BTUSB = 0;
        USE_EXCLUDE_PHONE = 0;
        USE_EXCLUDE_WWAN = 0;
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
    blueman.enable = true;
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
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
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
    # nvidia = {
    #   open = false;
    #   # package = config.boot.kernelPackages.nvidiaPackages.stable;
    #   forceFullCompositionPipeline = true;
    #   modesetting.enable = true;
    #   powerManagement.enable = true;
    #   prime = {
    #     reverseSync.enable = true;
    #     nvidiaBusId = "PCI:1:0:0";
    #     intelBusId = "PCI:0:2:0";
    #   };
    # };
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

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";
    stateVersion = "23.05";
  };
}
