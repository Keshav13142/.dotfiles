{ pkgs, user, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];
  home =
    {
      username = "${user}";
      homeDirectory = "/home/${user}";
      packages = with pkgs; [
        # Applications
        amberol
        authy
        bitwarden
        brave
        espanso
        gimp
        gnome.seahorse # gui secrets manager
        libreoffice-qt
        mpv
        obsidian
        virt-manager

        # Utils
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

        # Dev
        android-studio
        android-tools
        docker
        docker-compose
        mysql-workbench
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
        xfce.thunar
        xdg-desktop-portal
        xdg-desktop-portal-gtk

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
        package = pkgs.capitaine-cursors-themed;
        name = "Capitaine Cursors (Gruvbox)";
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
    exa.enable = true;
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
      name = "Gruvbox_Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-key-theme = "Gruvbox-Dark-BL";
        color-scheme = "prefer-dark";
      };
    };
  };

  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];
}
