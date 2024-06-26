{ pkgs, user, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      # Applications
      amberol
      bitwarden
      brave
      espanso
      # floorp
      gimp
      gnome.seahorse # gui secrets manager
      libreoffice-qt
      mpv
      obsidian
      picard
      virt-manager

      # Utils
      acpi
      alsa-lib
      cava
      ffmpeg
      gparted
      graphicsmagick
      imagemagick
      libnotify
      libpcap
      nfs-utils
      pciutils
      polkit_gnome
      powertop
      pulseaudioFull
      qemu
      quickemu
      usbutils
      kanata
      lshw

      # Dev
      android-studio
      android-tools
      dbeaver-bin
      docker
      docker-compose
      jetbrains.idea-ultimate
      mysql-workbench
      ollama
      vscode

      # Desktop
      brillo
      dmenu
      dunst
      gnome.cheese
      gnome.nautilus
      gtk3
      kitty
      networkmanagerapplet
      pamixer
      pavucontrol
      playerctl
      pywal
      rofimoji
      wezterm
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xfce.thunar

      # Wayland
      cliphist
      glib
      grim
      hyprpicker
      libsForQt5.qt5.qtwayland
      (rofi-wayland.override {
        plugins = [
          pkgs.rofi-calc
        ];
      })
      slurp
      swappy
      swayidle
      swaylock-effects
      swww
      wev
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }))
      wayland-protocols
      wl-clipboard
      wlogout
      wlr-randr

      # Xorg/X11
      # xclip
      # xorg.xev
      # lxappearance
      # picom
      # (polybar.override {
      #   i3Support = true;
      # })
      # (rofi.override {
      #   plugins = [
      #     pkgs.rofi-calc
      #   ];
      # })
      # sxhkd
      # xdotool
      # xorg.libX11
      # xorg.libX11.dev
      # xorg.libxcb
      # xorg.libXft
      # xorg.libXinerama
      # xorg.xbacklight
      # xorg.xinit
      # xorg.xinput
      # xorg.xkill
      # xorg.xmodmap
      # xsel
    ];

    stateVersion = "23.05";
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 16;
    };
  };

  services = {
    syncthing.enable = true;

    # mpd = {
    #   enable = true;
    #   musicDirectory = "/run/media/keshav/Media/Music/";
    # };

    # Xorg X11
    # betterlockscreen.enable = true;
    # flameshot.enable = true;
    # clipmenu.enable = true;
  };

  programs = {
    alacritty.enable = true;
    btop.enable = true;
    eza.enable = true;
    mpv.enable = true;
    obs-studio.enable = true;
    yt-dlp.enable = true;
    zathura.enable = true;
    spicetify = {
      enable = true;
      theme = spicePkgs.themes.Onepunch;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark-BL";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
