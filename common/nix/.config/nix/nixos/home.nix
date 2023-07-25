# Common packages user by all systems
{ pkgs, ... }:
{
  home =
    {
      packages = with pkgs; [
        # Cli looks nice
        cmatrix
        cowsay
        figlet
        glow
        gum
        lolcat
        neofetch
        ninja
        tig
        timer

        # Build tools?
        clang-tools_9
        coreutils
        gcc
        gnumake

        # Utils
        fd
        fnm
        gitmux
        jq
        killall
        lf
        ripgrep
        speechd
        stdenv
        stow
        stylua
        tldr
        tmux
        trash-cli
        tree
        unrar
        unzip
        wget
        xdg-ninja
        zip

        # Dev
        cargo
        diff-so-fancy
        go
        helix
        nodejs
        python310Packages.pip
        python3Full
        watchman

        # Language support
        deadnix
        gofumpt
        gotools
        nixpkgs-fmt
        nodePackages.eslint
        nodePackages.prettier
        shellcheck
        shfmt
        statix
        stylua

      ];
    };

  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
    neovim.enable = true;
    ssh.enable = true;
    nix-index.enable = true;

    java = {
      enable = true;
      package = pkgs.jdk11;
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman batgrep ];
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

      extraConfig = {
        user.signingKey = "~/.ssh/git_signing.pub";
        github.user = "keshav13142";
        color.ui = true;
        init.defaultBranch = "main";
        http.sslVerify = true;
        pull.rebase = true;

        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        };

        core = {
          excludesFile = "~/.gitignore";
          editor = "nvim";
          fileMode = false;
        };

        commit = {
          verbose = true;
          gpgsign = true;
        };
      };

      # Really nice looking diffs
      delta = {
        enable = false;
        options = {
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
}
