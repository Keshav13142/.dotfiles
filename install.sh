sudo pacman -S --needed git neovim curl wget unzip base-devel --noconfirm

mkdir ~/software
cd ~/software
git clone https://aur.archlinux.org/paru.git
makepkg -si --noconfirm

cd ~


# Graphics stuff
# paru -S nvidia prime-run nvidia-dkms nvidia-settings nvidia-utils libva libva-nvidia-driver xf86-video-intel
# un-comment multilib repo in /etc/pacman.conf
# Create /etc/modprobe.d/blacklist-nouveau.conf and settings to it?
# paru -Syu
# For steam choose the lib nvida provder

paru -S --noconfirm --needed --skipreview --cleanafter amberol bitwarden gimp libreoffice-fresh seahorse mpv zed graphicsmagick yt-dlp imagemagick powertop kanata-bin dmenu cheese nautilus playerctl rofimoji btop obs-studio obsidian zathura cowsay figlet ghostscript glow gum lf lolcat ninja pistol-bin slides-bin libspeechd tig mediainfo sesh fd jq tldr trash-cli stow tree unrar zip statix-git gofumpt glib pnpm unzip brave-bin kitty firefox zoxide git neovim tmux go python lazygit brillo kdeconnect cargo-binstall syncthing flameshot intellij-idea-community-edition cava visual-studio-code-bin redshift python-pywal acpid blueman cups cups-pdf cups-filters system-config-printer gnome-themes-extra kvantum-qt5 clang mise mariadb-libs postgresql-libs lazydocker-bin wget curl inetutils eza fzf ripgrep bat fastfetch man less whois plocate bash-completion gnome-calculator localsend-bin bun-bin discord ufw powershell-bin starship docker sqlc docker-compose mongodb-bin mongodb-tools-bin mongodb-compass-bin flatpak optimus-manager nvtop libva-utils ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols networkmanager network-manager-applet nm-connection-editor wireless_tools wpa_supplicant fish pavucontrol pamixer qbittorrent vlc lxappearance mangohud nvidia-prime mangoapp gamescope flatseal mousam imv libva-nvidia-driver lsp-plugins easyeffects swaync vicinae-git

paru -S xorg-xev polybar picom sxhkd greenclip betterlockscreen

paru -S fontpreview fish-lsp spotify ufw-docker mongosh-bin optimus-manager-qt auto-cpufreq

sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

# systemctl enable --now optimus-manager

# flatpak install flathub com.github.wwmm.easyeffects
flatpak install flathub io.github.flattool.Warehouse
flatpak install flathub net.lutris.Lutris
flatpak install flathub net.davidotek.pupgui2
flatpak install flathub com.github.Matoking.protontricks
flatpak install flathub io.github.nokse22.inspector

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

paru -S hyprpicker hypridle rofi-wayland swappy swww wev wayland-protocols wl-clipboard wlr-randr cliphist libsecret hyprlock wlogout grim slurp nwg-displays waybar hyprpolkitagent gnome-keyring sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg vicinae-git

# Sddm astronaut theme setup
sudo git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme
sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

sudo usermod -aG audio,disk,input,kvm,power,render,video,wheel $USER

curl -fsSL https://fnm.vercel.app/install | bash

## Docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
# Prevent Docker from preventing boot for network-online.target
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/no-block-boot.conf <<'EOF'
[Unit]
DefaultDependencies=no
EOF
sudo systemctl daemon-reload

curl -s "https://get.sdkman.io" | bash

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

# chmod 700 ~/.ssh
# chmod 600 ~/.ssh/*
# chmod 644 ~/.ssh/*.pub

curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale set --operator=$USER

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

cargo-binstall rotz
