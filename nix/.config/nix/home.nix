{ config, pkgs, user, ... }:

{
  home =
    {
      username = "${user}";
      homeDirectory = "/home/${user}";
      packages = with pkgs; [
        alacritty
        android-studio
        android-tools
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
        docker
        docker-compose
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
        mpv
        mysql-workbench
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
        watchman
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
      stateVersion = "23.05";
      pointerCursor = {
        gtk.enable = true;
        name = "Dracula-cursors";
        package = pkgs.dracula-theme;
        size = 16;
      };
    };

  programs = {
    home-manager.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme
      ;
    };
  };
}
