#!/usr/bin/env bash

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$HOME/arch-setup-$(date +%Y%m%d-%H%M%S).log"
USERNAME="$USER"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${2:-$NC}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}" | tee -a "$LOG_FILE"
}

log_info() { log "$1" "$BLUE"; }
log_success() { log "$1" "$GREEN"; }
log_warning() { log "$1" "$YELLOW"; }
log_error() { log "$1" "$RED"; }

# Error handler
handle_error() {
    log_error "Error occurred in script at line $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

# Check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root!"
        exit 1
    fi
}

# Install paru AUR helper
install_paru() {
    log_info "Installing paru AUR helper..."

    if command -v paru &> /dev/null; then
        log_warning "paru is already installed, skipping..."
        return
    fi

    # Install base dependencies
    sudo pacman -S --needed git neovim curl wget unzip base-devel --noconfirm

    # Build and install paru
    mkdir -p ~/software
    cd ~/software
    if [[ ! -d "paru" ]]; then
        git clone https://aur.archlinux.org/paru.git
    fi
    cd paru
    makepkg -si --noconfirm
    cd ~

    log_success "paru installed successfully"
}

# Core system packages
install_core_packages() {
    log_info "Installing core packages..."

    local core_packages=(
        # System utilities
        git neovim tmux go python lazygit
        brillo kdeconnect cargo-binstall syncthing
        flameshot acpid blueman notepadnext-bin

        # Network and security
        networkmanager network-manager-applet
        nm-connection-editor wireless_tools wpa_supplicant
        ufw curl wget inetutils

        # Audio
        pavucontrol pamixer

        # Shell and terminal
        fish kitty starship

        # File management
        nautilus trash-cli stow tree unrar zip
        fd ripgrep bat fastfetch man less
        whois plocate bash-completion eza fzf

        # Development tools
        clang mise mariadb-libs postgresql-libs
        docker docker-compose
        pnpm unzip sqlitebrowser sqlite
    )

    paru -S --noconfirm --needed --skipreview --cleanafter "${core_packages[@]}"
    log_success "Core packages installed"
}

# Hyprland and desktop environment
install_hyprland_desktop() {
    log_info "Installing Hyprland desktop environment..."

    local hyprland_packages=(
        # Hyprland core
        hyprpicker hypridle hyprlock wlogout

        # Wayland utilities
        rofi-wayland swappy swww wev
        wayland-protocols wl-clipboard wlr-randr
        cliphist grim slurp nwg-displays nwg-look waybar
        hyprpolkitagent swaync

        # SDDM
        sddm qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg qt5ct qt6ct

        # X11 compatibility (if needed)
        # xorg-xev polybar picom sxhkd greenclip betterlockscreen
    )

    paru -S --noconfirm --needed --skipreview --cleanafter "${hyprland_packages[@]}"
    log_success "Hyprland desktop environment installed"
}

# Applications and media
install_applications() {
    log_info "Installing applications and media tools..."

    local app_packages=(
        # Web browsers
        brave-bin firefox

        # Media
        amberol mpv vlc qbittorrent
        imv loupe gimp imagemagick graphicsmagick
        yt-dlp mediainfo cava easyeffects lsp-plugins

        # Productivity
        libreoffice-fresh obsidian zathura
        bitwarden seahorse

        # Development
        zed visual-studio-code-bin
        intellij-idea-community-edition

        # Gaming
        obs-studio mangohud gamescope flatseal

        # System monitoring
        btop nvtop powertop

        # Utilities
        dmenu cheese playerctl rofimoji
        cowsay figlet ghostscript glow gum
        lf lolcat ninja pistol-bin slides-bin
        libspeechd tig sesh jq tldr
        localsend-bin discord

        # Theming
        gnome-themes-extra kvantum-qt5
        nordic-theme orchis-theme
        papirus-icon-theme la-capitaine-icon-theme numix-circle-icon-theme-git
        capitaine-cursors
        lxappearance

        # Fonts
        ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols noto-fonts-emoji noto-fonts-cjk

        # Virtualization
        libvirt qemu-full virt-manager dnsmasq dmidecode

        # virt-viewer vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs

    )

    paru -S --noconfirm --needed --skipreview --cleanafter "${app_packages[@]}"
    log_success "Applications installed"

    log_info "Enabling services for virtualization"
    sudo usermod -aG libvirt "$USER"
    sudo systemctl enable --now libvirtd.service virtlogd.service
    sudo virsh net-autostart default
    sudo virsh net-start default
}

# Development tools and runtime managers
install_development_tools() {
    log_info "Installing development tools..."

    local dev_packages=(
        # Database tools
        mongodb-bin mongodb-tools-bin mongodb-compass-bin
        lazydocker-bin sqlc

        # Additional dev tools
        statix-git gofumpt
        powershell-bin
        fontpreview fish-lsp spotify
        mongosh-bin
        auto-cpufreq
        vicinae-git
    )

    paru -S --noconfirm --needed --skipreview --cleanafter "${dev_packages[@]}"

    # Install Node.js version manager
    if [[ ! -d "$HOME/.local/share/fnm" ]]; then
        log_info "Installing fnm (Node.js version manager)..."
        curl -fsSL https://fnm.vercel.app/install | bash
    fi

    # Install SDKMAN
    if [[ ! -d "$HOME/.sdkman" ]]; then
        log_info "Installing SDKMAN..."
        curl -s "https://get.sdkman.io" | bash
    fi

    log_success "Development tools installed"
}

# Graphics drivers (NVIDIA)
install_graphics_drivers() {
    log_info "Graphics drivers section (commented out by default)"
    log_warning "Uncomment and modify the graphics section in the script if needed"

    # Uncomment and modify as needed for your specific graphics setup
    # log_info "Installing NVIDIA graphics drivers..."
    #
    # # Enable multilib repository first
    # sudo sed -i '/^#\[multilib\]/,/^#Include = \/etc\/pacman\.conf\.d\/mirrorlist/ s/^#//' /etc/pacman.conf
    #
    # local nvidia_packages=(
    #     nvidia prime-run nvidia-dkms nvidia-settings
    #     nvidia-utils libva libva-nvidia-driver
    #     xf86-video-intel optimus-manager optimus-manager-qt
    #     libva-utils
    # )
    #
    # paru -Syu --noconfirm
    # paru -S --noconfirm --needed --skipreview --cleanafter "${nvidia_packages[@]}"
    #
    # # Blacklist nouveau
    # sudo mkdir -p /etc/modprobe.d
    # echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
    #
    # log_success "NVIDIA graphics drivers installed"
}

# Flatpak applications
install_flatpak_apps() {
    log_info "Installing Flatpak applications..."

    local flatpak_apps=(
        "io.github.flattool.Warehouse"
        "net.lutris.Lutris"
        "net.davidotek.pupgui2"
        "com.github.Matoking.protontricks"
        "io.github.nokse22.inspector"
    )

    for app in "${flatpak_apps[@]}"; do
        log_info "Installing $app..."
        flatpak install flathub "$app" -y || log_warning "Failed to install $app"
    done

    log_success "Flatpak applications installed"
}

# System services and configuration
configure_system_services() {
    log_info "Configuring system services..."

    # Enable and start services
    local services=(
        "NetworkManager"
        "bluetooth.service"
        "cups.service"
        "docker"
        "acpid"
    )

    for service in "${services[@]}"; do
        sudo systemctl enable --now "$service" || log_warning "Failed to enable $service"
    done

    # User services
    systemctl --user enable --now syncthing.service || true

    # Add user to groups
    sudo usermod -aG audio,disk,input,kvm,power,render,video,wheel,docker "$USER"

    log_success "System services configured"
}

# SDDM theme setup
configure_sddm_theme() {
    log_info "Configuring SDDM astronaut theme..."

    local theme_dir="/usr/share/sddm/themes/sddm-astronaut-theme"

    if [[ ! -d "$theme_dir" ]]; then
        sudo git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git "$theme_dir"
        sudo cp -r "$theme_dir/Fonts/"* /usr/share/fonts/
        sudo fc-cache -fv
        log_success "SDDM theme configured"
    else
        log_warning "SDDM theme already exists"
    fi
}

# Firewall configuration
configure_firewall() {
    log_info "Configuring firewall..."

    # Default policies
    sudo ufw default deny incoming
    sudo ufw default allow outgoing

    # Application-specific rules
    sudo ufw allow 53317/udp comment 'LocalSend UDP'
    sudo ufw allow 53317/tcp comment 'LocalSend TCP'
    sudo ufw allow 1714:1764/tcp comment 'KDE Connect TCP'
    sudo ufw allow 1714:1764/udp comment 'KDE Connect UDP'
    sudo ufw allow 22/tcp comment 'SSH'

    # Docker DNS
    sudo ufw allow in on docker0 to any port 53 comment 'Docker DNS'

    # Enable firewall
    sudo ufw --force enable

    # Install and configure ufw-docker
    if command -v paru &> /dev/null; then
        paru -S --noconfirm ufw-docker || log_warning "Failed to install ufw-docker"
        sudo ufw-docker install || log_warning "Failed to configure ufw-docker"
        sudo ufw reload
    fi

    log_success "Firewall configured"
}

# Docker configuration
configure_docker() {
    log_info "Configuring Docker..."

    # Prevent Docker from blocking boot
    sudo mkdir -p /etc/systemd/system/docker.service.d
    sudo tee /etc/systemd/system/docker.service.d/no-block-boot.conf > /dev/null <<'EOF'
[Unit]
DefaultDependencies=no
EOF
    sudo systemctl daemon-reload

    log_success "Docker configured"
}

# Install development runtimes
setup_development_runtimes() {
    log_info "Setting up development runtimes..."

    # Source the necessary environment files
    [[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

    # Node.js setup
    if command -v fnm &> /dev/null; then
        log_info "Setting up Node.js..."
        eval "$(fnm env --use-on-cd)"
        fnm install --lts
        fnm default "$(fnm current)"

        # Package managers
        npm install -g corepack
        corepack enable

        # Install pnpm
        curl -fsSL https://get.pnpm.io/install.sh | sh -
    fi

    # SDKMAN setup (requires manual sourcing)
    log_info "SDKMAN installed - you'll need to manually install Java tools:"
    log_info "  source ~/.sdkman/bin/sdkman-init.sh"
    log_info "  sdk install maven"
    log_info "  sdk install gradle"

    # Tailscale
    if ! command -v tailscale &> /dev/null; then
        log_info "Installing Tailscale..."
        curl -fsSL https://tailscale.com/install.sh | sh
        sudo tailscale set --operator="$USERNAME"
    fi

    # Oh My Fish
    if [[ ! -d "$HOME/.local/share/omf" ]]; then
        log_info "Installing Oh My Fish..."
        curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
        fish -c 'omf install sdk fzf vi-mode'
    fi

    # Cargo binstall tools
    if command -v cargo-binstall &> /dev/null; then
        log_info "Installing Rust tools..."
        cargo-binstall rotz -y || log_warning "Failed to install rotz"
    fi

    log_success "Development runtimes setup completed"
}

# Post-installation notes
show_post_install_notes() {
    log_info "=== POST-INSTALLATION NOTES ==="
    log_warning "Manual tasks remaining:"
    echo "1. If using SSH, set up your SSH keys:"
    echo "   chmod 700 ~/.ssh"
    echo "   chmod 600 ~/.ssh/*"
    echo "   chmod 644 ~/.ssh/*.pub"
    echo ""
    echo "2. If you have NVIDIA graphics, uncomment and run the graphics section"
    echo ""
    echo "3. For SDKMAN tools, run:"
    echo "   source ~/.sdkman/bin/sdkman-init.sh"
    echo "   sdk install maven"
    echo "   sdk install gradle"
    echo ""
    echo "4. Reboot to ensure all services and drivers are properly loaded"
    echo ""
    echo "5. Configure your dotfiles and Hyprland configuration"
    echo ""
    log_info "Installation log saved to: $LOG_FILE"
}

# Main execution
main() {
    log_info "Starting Arch Linux Hyprland setup..."

    check_root

    # Core installation steps
    install_paru
    install_core_packages
    install_hyprland_desktop
    install_applications
    install_development_tools
    install_graphics_drivers  # This is mostly commented out by default
    install_flatpak_apps

    # System configuration
    configure_system_services
    configure_sddm_theme
    configure_firewall
    configure_gnome_settings
    configure_docker
    setup_development_runtimes

    log_success "Setup completed successfully!"
    show_post_install_notes
}

# Run the main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
