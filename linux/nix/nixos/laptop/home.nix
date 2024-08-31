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
      floorp
      gimp
      libreoffice-qt
      mpv
      obsidian
      picard
      seahorse # gui secrets manager
      spotify
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
      cheese
      nautilus
      gtk3
      kitty
      networkmanagerapplet
      pamixer
      pavucontrol
      playerctl
      pywal
      rofimoji
      wezterm

      # Wayland
      cliphist
      glib
      grim
      hyprpicker
      hyprlock
      hypridle
      libsForQt5.qt5.qtwayland
      (rofi-wayland.override {
        plugins = [
          pkgs.rofi-calc
        ];
      })
      slurp
      swappy
      swww
      wev
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }))
      wayland-protocols
      wl-clipboard
      wlogout
      wlr-randr
    ];

    stateVersion = "23.05";
  };

  services = {
    syncthing.enable = true;
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
      enable = false;
      theme = spicePkgs.themes.Onepunch;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Gruvbox)";
    size = 16;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
  };
}
