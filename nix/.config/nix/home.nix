{ config, pkgs, user, ... }:

{
  home =
    {
      username = "${user}";
      homeDirectory = "/home/${user}";
      packages = with pkgs; [
        android-studio
        android-tools
        authy
        bitwarden
        brave
        brillo
        cargo
        clang-tools_9
        cmatrix
        coreutils
        cowsay
        dmenu
        docker
        docker-compose
        dracula-icon-theme
        dracula-theme
        dunst
        espanso
        fd
        ffmpeg
        figlet
        fnm
        gcc
        gimp
        gitmux
        glow
        gnome.nautilus
        gnumake
        go
        gparted
        graphicsmagick
        grim
        gtk3
        gum
        hyprpicker
        imagemagick
        killall
        kitty
        lf
        libnotify
        libreoffice-qt
        lxappearance
        mpv
        mysql-workbench
        neofetch
        networkmanagerapplet
        nfs-utils
        ninja
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
        pywal
        qemu
        ripgrep
        rofi
        rofimoji
        spotify
        slurp
        # Nix language features
        nixpkgs-fmt
        statix
        deadnix
        stdenv
        stow
        stylua
        swayidle
        swaylock
        sxhkd
        swww
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
        wl-clipboard
        wofi
        waybar
        xclip
        xdg-desktop-portal-gtk
        xdotool
        xdg-desktop-portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
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
    # betterlockscreen.enable = true;
    # flameshot.enable = true;
    clipmenu.enable = true;
  };

  programs = {
    home-manager.enable = true;
    swaylock.enable = true;
    btop.enable = true;
    feh.enable = true;
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
  };
}
