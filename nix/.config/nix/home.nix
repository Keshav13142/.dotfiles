{ config, pkgs, user, ... }:

{
  home =
    {
      username = "${user}";
      homeDirectory = "/home/${user}";
      packages = with pkgs; [
        # Applications
        authy
        amberol
        bitwarden
        brave
        espanso
        gimp
        libreoffice-qt
        mpv
        spotify
        virt-manager

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
        zip

        # Dev
        android-studio
        android-tools
        cargo
        diff-so-fancy
        docker
        docker-compose
        go
        helix
        mysql-workbench
        nodejs
        nodePackages.prettier
        python310Packages.pip
        python3Full
        shellcheck
        stylua
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
        papirus-icon-theme
        pavucontrol
        playerctl
        pywal
        qogir-icon-theme
        qogir-theme
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
        swayidle
        swaylock-effects
        swww
        wev
        waybar
        wayland-protocols
        wl-clipboard
        wlogout
        wlr-randr

        # Xorg/X11
        # xclip
        # xorg.xev
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
        package = pkgs.qogir-icon-theme;
        name = "Qogir";
        size = 16;
      };
    };

  services = {
    mpd = {
      enable = true;
      musicDirectory = "/run/media/keshav/Media/Music/";
    };
    # Xorg X11
    # betterlockscreen.enable = true;
    # flameshot.enable = true;
    # clipmenu.enable = true;
  };

  programs = {
    home-manager.enable = true;
    alacritty.enable = true;
    btop.enable = true;
    exa.enable = true;
    # feh.enable = true;
    lazygit.enable = true;
    mpv.enable = true;
    neovim.enable = true;
    obs-studio.enable = true;
    ssh.enable = true;
    yt-dlp.enable = true;
    zathura.enable = true;
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
          gpg = {
            format = "ssh";
            ssh.allowedSignersFile = "~/.ssh/allowed_signers";
          };
          user.signingKey = "~/.ssh/id_rsa.pub";
          core = {
            excludesFile = "~/.gitignore";
            editor = "nvim";
            fileMode = false;
          };
          github.user = "keshav13142";
          color.ui = true;
          init.defaultBranch = "main";
          http.sslVerify = true;
          pull.rebase = true;
          commit = {
            verbose = true;
            gpgsign = true;
          };
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

  gtk = {
    enable = true;
    theme = {
      name = "Qogir";
      package = pkgs.qogir-theme;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
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
        gtk-key-theme = "Qogir";
        color-scheme = "prefer-dark";
      };
    };
  };

  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];

}
