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
        docker
        docker-compose
        dracula-icon-theme
        dracula-theme
        dunst
        fd
        ffmpeg
        figlet
        flatpak
        fnm
        gcc
        gimp
        gitmux
        glow
        gnome.nautilus
        gnumake
        gparted
        gtk3
        gum
        imagemagick
        killall
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
        nixpkgs-fmt
        nodejs
        obs-studio
        okular
        openssl
        pamixer
        pavucontrol
        pciutils
        picom
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
        ueberzug
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
      ];
      file.".inputrc".text = ''
        set show-all-if-ambiguous on
        set completion-ignore-case on
        set mark-directories on
        set mark-symlinked-directories on

        # autocomplete hidden files
        set match-hidden-files on

        # Show extra file information when completing, like `ls -F` does
        set visible-stats on

        # Be more intelligent when autocompleting by also looking at the text after
        # the cursor. For example, when the current line is "cd ~/src/mozil", and
        # the cursor is on the "z", pressing Tab will not autocomplete it to "cd
        # ~/src/mozillail", but to "cd ~/src/mozilla". (This is supported by the
        # Readline used by Bash 4.)
        set skip-completed-text on

        # Allow UTF-8 input and output, instead of showing stuff like $'\0123\0456'
        set input-meta on
        set output-meta on
        set convert-meta off

        # Use Alt/Meta + Delete to delete the preceding word
        "\e[3;3~": kill-word

        set keymap vi
        set editing-mode vi-insert
        "\e\C-h": backward-kill-word
        "\e\C-?": backward-kill-word
        "\eb": backward-word
        "\C-a": beginning-of-line
        "\C-l": clear-screen
        "\C-e": end-of-line
        "\ef": forward-word
        "\C-k": kill-line
        "\C-y": yank
        # Go up a dir with ctrl-n
        "\C-n":"cd ..\n"
        set editing-mode vi
      '';

      stateVersion = "23.05";

      pointerCursor = {
        gtk.enable = true;
        name = "Dracula-cursors";
        package = pkgs.dracula-theme;
        size = 16;
      };
    };

  services = {
    playerctld.enable = true;
    betterlockscreen.enable = true;
    clipmenu.enable = true;
    flameshot.enable = true;
  };

  programs = {
    home-manager.enable = true;
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
      #ignores = import ./dotfiles/gitignore.nix;
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
