{ user, inputs, pkgs, config, ... }:
{
  imports = [
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

  # Set zsh as the default shell
  programs = {
    fish.enable = true;
    dconf.enable = true;
    sniffnet.enable = true;
    nix-ld.enable = true;
    virt-manager.enable = true;
    hyprland = {
      xwayland.enable = true;
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };
    kdeconnect.enable = true;
  };
  users.defaultUserShell = pkgs.fish;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo = {
      enable = true;
      execWheelOnly = true;
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

  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    flatpak.enable = true;
    # Don't shutdown on powerBtn press
    logind.extraConfig = ''
      HandlePowerKey = ignore
    '';
    # Xserver config
    xserver = {
      enable = true;
      autorun = false;
      displayManager = {
        startx.enable = true;
      };
      xkb.layout = "us";
    };
    libinput.enable = true;

    # For filemanagers to work properly?
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf ];
    };
    # Power managerment
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
    ];
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };

  environment = {
    localBinInPath = true; # Add ~/.local/bin/ to $PATH
    sessionVariables.NIXOS_OZONE_WL = "1"; # This variable fixes electron apps in wayland
  };

  systemd = {
    services = {
      kanata = {
        enable = true;
        description = "Kanata keyboard remapper";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.kanata}/bin/kanata --cfg /home/${user}/.config/kanata/maps.kbd";
          Restart = "no";
        };
        wantedBy = [ "default.target" ];
      };
    };
    user.services.polkit-gnome-authentication-agent-1 = {
      enable = true;
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
}
