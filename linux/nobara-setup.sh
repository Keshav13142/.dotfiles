#!/usr/bin/env bash

set -e

echo "🔧 Starting Nobara post-install setup..."

sudo dnf update nobara-updater --refresh
nobara-sync cli

# Update system
sudo dnf update -y

# Install essential packages
sudo dnf install -y \
  bat \
  btop \
  curl \
  dnf-plugins-core \
  fd-find \
  fish \
  fzf \
  git \
  go \
  grim \
  kitty \
  jq \
  nvtop \ #Gpu monitor
  loupe \ #image viewer
  mpv \
  neofetch \
  neovim \
  ripgrep \
  slurp \
  steam \
  swappy \
  syncthing \
  tmux \
  trash-cli \
  wget \
  python3-pip \
  pamixer \
  pavucontrol \
  zoxide \
  zsh

sudo dnf copr enable solopasha/hyprland -y

sudo dnf insall -y \
  hyprland \
  hypridle \
  hyprlock \
  hyprpolkitagent \
  swaync \
  swww \
  xdg-desktop-portal-hyprland \
  waybar \
  wlogout \
  foot \
  dconf \
  cliphist \
  wofi \
  wl-clipboard \
  brightnessctl \
  network-manager-applet

# Enable COPR for lazygit and bat-extras
sudo dnf copr enable atim/lazygit -y || true
sudo dnf copr enable awood/bat-extras -y || true
sudo dnf install -y bat-extras lazygit || true

# set ssh keys permissions
#chmod 700 ~/.ssh
#chmod 600 ~/.ssh/id_rsa ~/.ssh/git_signing ~/.ssh/mobile
#chmod 644 ~/.ssh/id_rsa.pub ~/.ssh/git_signing.pub ~/.ssh/mobile.pub
#ssh -T git@github.com

# Install Rust
if ! command -v cargo &> /dev/null; then
  echo "📦 Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Install cargo-binstall
cargo install cargo-binstall || true
cargo-binstall rotz kanata wallust -y

# Install fnm (Fast Node Manager)
if ! command -v fnm &> /dev/null; then
  echo "📦 Installing fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash
  export PATH="$HOME/.fnm:$PATH"
  eval "$(fnm env)"
fi

# Use latest LTS Node
fnm install --lts
fnm default "$(fnm current)"

# Install corepack, yarn, and pnpm
npm install -g corepack
corepack enable
yarn set version stable
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Install SDKMAN
if [ ! -d "$HOME/.sdkman" ]; then
  echo "📦 Installing SDKMAN..."
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

sdk insall maven
sdk insall gradle

sudo dnf install -y @virtualization virt-manager qemu-kvm libvirt virt-install bridge-utils
sudo systemctl enable --now libvirtd

sudo usermod -aG libvirt "$(whoami)"

sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --system com.dec05eba.gpu_screen_recorder

echo "[gemfury-nushell]
name=Gemfury Nushell Repo
baseurl=https://yum.fury.io/nushell/
enabled=1
gpgcheck=0
gpgkey=https://yum.fury.io/nushell/gpg.key" | sudo tee /etc/yum.repos.d/fury-nushell.repo
sudo dnf install -y nushell

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code

which fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

systemctl --user enable syncthing.service
systemctl --user start syncthing.service

pip install pywal

sudo dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
sudo dnf install tailscale

# Display session type
echo "🖥️ Session type: $XDG_SESSION_TYPE"

echo "✅ Setup complete! Restart shell or source your profiles if needed."
