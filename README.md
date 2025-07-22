## All my dotfiles

- NixOs configuration can be found [here](linux/nix)
- Windows specific config [here](windows/)
- Managed using [rotz](https://github.com/volllly/rotz)

## Arch setup (partial)

```sh
yay -S amberol bitwarden espanso gimp libreoffice-fresh seahorse mpv zed easyeffects picard graphicsmagick yt-dlp imagemagick powertop kanata dmenu cheese nautilus pamixer pavucontrol playerctl rofimoji rofi-calc wezterm btop obs-studio obsidian zathura cowsay figlet fontpreview ghostscript glow gum lf lolcat ninja pistol-bin slides libspeechd tig timer tmatrix xdg-ninja mediainfo yazi sesh fd jq tldr trash-cli stow tree unrar zip statix-git gofumpt fish-lsp glib pnpm unzip brave-bin kitty firefox zoxide git neovim tmux go python lazygit brillo steam spotify sxhkd kde-connect network-manager-applet cargo-binstall syncthing obs-studio flameshot wallust code intellij-idea-community-edition cava visual-studio-code-bin redshift betterlockscreen python-pywal greenclip xorg-xev acpid xorg-xsetroot

yay -S hyprpicker hypridle rofi-wayland swappy swww wev wayland-protocols wl-clipboard wlr-randr cliphist libsecret hyprlock wlogout grip slurp os-prober hyprls-git

sudo usermod -aG audio,disk,input,kvm,power,render,video,wheel keshav

curl -fsSL https://fnm.vercel.app/install | bash
yay -S powershell-bin starship --noconfirm
yay -S docker sqlc docker-compose lazydocker bun-bin discord
curl -s "https://get.sdkman.io" | bash
yay -S mongodb-bin mongodb-tools-bin mongosh-bin mongodb-compass-bin

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
```

## TODO

- [ ] Prepare docs or install script for arch/non-nix distros
- [ ] Find out a way to automate installing rotz more effectively across platforms
- [ ] Checkout [this](https://github.com/khaneliman/dotfiles) for automated setup across different platforms
- [ ] Checkout rotz config for enhancements
- [ ] Fix komorebi border colors
