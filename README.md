## All my dotfiles

- NixOs configuration can be found [here](linux/nix)
- Windows specific config [here](windows/)
- Managed using [rotz](https://github.com/volllly/rotz)

## Arch setup (partial)

```sh
yay -S amberol bitwarden espanso gimp libreoffice-fresh seahorse mpv zed picard graphicsmagick yt-dlp imagemagick powertop kanata dmenu cheese nautilus pamixer pavucontrol playerctl rofimoji rofi-calc wezterm btop obs-studio obsidian zathura cowsay figlet fontpreview ghostscript glow gum lf lolcat ninja pistol-bin slides libspeechd tig timer tmatrix xdg-ninja mediainfo yazi sesh fd jq tldr trash-cli stow tree unrar zip statix-git gofumpt fish-lsp glib pnpm unzip brave-bin kitty firefox zoxide git neovim tmux go python lazygit brillo steam spotify sxhkd kde-connect network-manager-applet cargo-binstall syncthing obs-studio flameshot wallust code intellij-idea-community-edition cava visual-studio-code-bin redshift betterlockscreen python-pywal greenclip xorg-xev acpid xorg-xsetroot pipewire wireplumber pipewire-audio pipewire-pulse pipewire-alsa blueman cups cups-pdf cups-filters system-config-printer gnome-themes-extra kvantum-qt5 clang mise mariadb-libs postgresql-libs lazydocker-bin wget curl inetutils eza fzf ripgrep bat fastfetch man less whois plocate bash-completion gnome-calculator localsend-bin bun-bin discord ufw ufw-docker powershell-bin starship docker sqlc docker-compose mongodb-bin mongodb-tools-bin mongosh-bin mongodb-compass-bin flatpak optimus-manager optimus-manager-qt auto-cpufreq nvtop libva-utils

systemctl enable --now optimus-manager

flatpak install flathub com.github.wwmm.easyeffects

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 53317/udp
sudo ufw allow 53317/tcp # Localsend
sudo ufw allow 1714:1764/tcp comment 'kde-connect'
sudo ufw allow 1714:1764/udp comment 'kde-connect'

sudo ufw allow 22/tcp # ssh

sudo ufw allow in on docker0 to any port 53 # Allow Docker containers to use DNS on host

sudo ufw enable

sudo ufw-docker install
sudo ufw reload

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

sudo systemctl enable --now bluetooth.service

sudo systemctl enable --now cups.service

yay -S hyprpicker hypridle rofi-wayland swappy swww wev wayland-protocols wl-clipboard wlr-randr cliphist libsecret hyprlock wlogout grip slurp os-prober hyprls-git

sudo usermod -aG audio,disk,input,kvm,power,render,video,wheel keshav

curl -fsSL https://fnm.vercel.app/install | bash

## Docker
sudo systemctl enable docker
sudo usermod -aG docker ${USER}
# Prevent Docker from preventing boot for network-online.target
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/no-block-boot.conf <<'EOF'
[Unit]
DefaultDependencies=no
EOF
sudo systemctl daemon-reload

curl -s "https://get.sdkman.io" | bash

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

systemctl --user start syncthing.service
systemctl --user enable syncthing.service
sudo systemctl enable --now acpid

fnm install --lts
fnm default "$(fnm current)"

npm install -g corepack
corepack enable
yarn set version stable
curl -fsSL https://get.pnpm.io/install.sh | sh -

sdk install maven
sdk install gradle

chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/*.pub

curl -fsSL https://tailscale.com/install.sh | sh
```

## TODO

- [ ] Prepare docs or install script for arch/non-nix distros
- [ ] Find out a way to automate installing rotz more effectively across platforms
- [ ] Checkout [this](https://github.com/khaneliman/dotfiles) for automated setup across different platforms
- [ ] Checkout rotz config for enhancements
- [ ] Fix komorebi border colors
