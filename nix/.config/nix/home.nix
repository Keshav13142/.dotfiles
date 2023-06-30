{ config, pkgs, user, ... }:

{
  home =
    {
      username = "${user}";
      homeDirectory = "/home/${user}";
      packages = with pkgs; [
        # Applications
        authy
        bitwarden
        brave
        gimp
        libreoffice-qt
        mpv
        obs-studio
        okular
        spotify
        virt-manager
        vlc
        espanso

        # Cli looks nice
        cmatrix
        cowsay
        figlet
        glow
        gum
        neofetch
        ninja
        tig

        # Build tools?
        clang-tools_9
        coreutils
        gcc
        gnumake

        # Nix language support
        deadnix
        nixpkgs-fmt
        statix

        # Utils
        cava
        fd
        ffmpeg
        fnm
        gitmux
        gparted
        graphicsmagick
        imagemagick
        killall
        lf
        libnotify
        nfs-utils
        openssl
        pciutils
        polkit_gnome
        powertop
        qemu
        ripgrep
        stdenv
        stow
        stylua
        tldr
        tmux
        trash-cli
        tree
        unrar
        unzip
        usbutils
        wget
        yt-dlp
        zip

        # Dev
        android-studio
        android-tools
        cargo
        docker
        docker-compose
        go
        mysql-workbench
        nodejs
        python310Packages.pip
        python3Full
        vscode
        watchman
        xdg-desktop-portal
        xdg-desktop-portal-gtk

        # Desktop
        brillo
        dmenu
        dracula-icon-theme
        dracula-theme
        dunst
        gnome.nautilus
        gtk3
        kitty
        networkmanagerapplet
        pamixer
        pavucontrol
        playerctl
        pywal
        rofimoji
        wlsunset
        xfce.thunar

        # Wayland
        cliphist
        glib
        grim
        hyprpicker
        libsForQt5.qt5.qtwayland
        rofi-wayland
        slurp
        swappy
        swaylock-effects
        swww
        waybar
        wayland-protocols
        wl-clipboard
        wlogout
        wlr-randr

        # Xorg/X11
        xclip
        xorg.xev
        # lxappearance
        # picom
        # polybar
        # rofi
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
        name = "Catpuccin Mocha";
        package = pkgs.catppuccin-cursors.mochaMauve;
        size = 16;
      };
    };

  services = {
    swayidle.enable = true;

    # Xorg X11
    # betterlockscreen.enable = true;
    # flameshot.enable = true;
    # clipmenu.enable = true;
  };

  programs = {
    home-manager.enable = true;
    # feh.enable = true;
    btop.enable = true;
    exa.enable = true;
    neovim.enable = true;
    alacritty.enable = true;
    lazygit.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman batgrep ];
      config = {
        theme = "Dracula";
        style = "plain"; # no line numbers, git status, etc... more like cat with colors
      };
    };
    nix-index.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
      defaultCommand = "fd --type f --color=never --hidden";
    };
    git = {
      enable = true;
      userName = "Keshav";
      userEmail = "s.keshav13142@gmail.com";
      aliases = {
        s = "status";
        co = "checkout";
        cl = "clone";
        br = "branch";
        st = "status -sb";
        wtf = "!git-wtf";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --topo-order --date=relative";
        lp = "log -p";
        rl = "reflog";
        ls = "ls-files";
        d = "diff";
      };
      extraConfig =
        {
          github.user = "keshav13142";
          color.ui = true;
          init.defaultBranch = "main";
          http.sslVerify = true;
          pull.rebase = true;
        };
      # Really nice looking diffs
      delta = {
        enable = false;
        options = {
          syntax-theme = "Dracula";
          line-numbers = true;
          navigate = true;
          side-by-side = true;
        };
      };
      # intelligent diffs that are syntax parse tree aware per language
      difftastic = {
        enable = true;
        background = "dark";
      };
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      #name = "Dracula";
      #package = pkgs.dracula-theme;
      name = "Catppuccin-Mocha";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme
      ;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
