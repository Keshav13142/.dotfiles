{ config, pkgs, lib, ... }:
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

  # i3 configuration
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "${user}";
      };
    };
    windowManager.i3.enable = true;
    layout = "us";
    xkbOptions = "caps:escape_shifted_capslock";
    xkbVariant = "";
    libinput.enable = true;
  };

  services = {
    printing.enable = true;
    gvfs.enable = true;
    flatpak.enable = true;
    cron.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf ];
    };
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          turbo = "always";
          #scalingMaxFreq = "1000000";
          #scalingMinFreq = "1000000";
        };
        battery = {
          turbo = "never";
          #scalingMaxFreq = "2800000";
          #scalingMinFreq = "1000000";
        };
      };
    };
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

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      # Modesetting is needed for most wayland compositors
      modesetting.enable = true;
      open = false;
      prime = {
        reverseSync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      nvidiaSettings = true;
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      #package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  programs = {
    dconf.enable = true;
    zsh.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo = {
      enable = true;
      execWheelOnly = true;
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };


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
      DefaultTimeoutStopSec=10s
    '';
  };

  # Nix Package Manager settings
  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
      trusted-users = [ "${user}" "root" ];
      max-jobs = 8;
      cores = 0; # use them all
      allowed-users = [ "@wheel" ];
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
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "nvidia-x11"
      ];
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

  # Add ~/.local/bin/ to $PATH
  environment.localBinInPath = true;

    system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";
    stateVersion = "23.05";
  };
}
