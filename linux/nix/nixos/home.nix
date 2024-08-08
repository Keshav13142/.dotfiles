# Common packages user by all systems
{ pkgs, ... }:
{
  home =
    {
      packages = with pkgs; [
        # Cli utils
        cowsay
        figlet
        fontpreview
        ghostscript
        glow
        gum
        lf
        lolcat
        neofetch
        nh
        ninja
        pistol
        slides
        speechd
        tig
        timer
        tmatrix
        xdg-ninja
        mediainfo

        # Core utils
        cmake
        coreutils
        curl
        fd
        fzf
        gawk
        gcc
        gnumake
        jq
        killall
        libsecret
        ripgrep
        stdenv
        stow
        tldr
        tmux
        trash-cli
        tree
        unrar
        unzip
        wget
        zip

        # Dev
        cargo
        diff-so-fancy
        fnm
        gitmux
        go
        helix
        lazydocker
        nodejs
        nodePackages.pnpm
        nodePackages.typescript
        python3
        rustc
        watchman
        yarn

        # Language support
        deadnix
        gofumpt
        gotools
        nodePackages.pnpm
        statix

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
      package = pkgs.jdk21;
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batman batgrep batdiff ];
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
        br = "branch";
        c = "commit -m";
        cl = "clone";
        co = "checkout";
        d = "diff";
        fpush = "push --force-with-lease";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --topo-order --date=relative";
        lp = "log -p";
        ls = "ls-files";
        rl = "reflog";
        s = "status";
        st = "status -sb";
        wtf = "!git-wtf";
      };
      extraConfig = {
        branch.sort = "-commmiterdate";
        color.ui = true;
        column.ui = "always";
        commit = { verbose = true; gpgsign = true; };
        core = { editor = "nvim"; };
        github.user = "keshav13142";
        gpg = { format = "ssh"; ssh.allowedSignersFile = "~/.ssh/allowed_signers"; };
        http.sslVerify = true;
        init.defaultBranch = "main";
        pull.rebase = true;
        rerere = { enabled = true; autoUpdate = true; };
        user.signingKey = "~/.ssh/git_signing.pub";
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
