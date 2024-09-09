# Notes and TODO

- Get the gruvbox theme from [here](https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme) and the Grubox-Dark
  folder into `~/.icons/` (Should find a better way to do this)
- Try and find a way to package rotz (dotfiles manager) and also the theme

# Rotz install

```sh
curl -fsSL volllly.github.io/rotz/install.sh | sh
```

or

```sh
cargo install rotz
```

# Installation steps

- Check and connect to wifi [refer](https://www.makeuseof.com/connect-to-wifi-with-nmcli/)

  ```sh
  nmcli dev wifi list
  sudo nmcli dev wifi connect "network-ssid" password "network-password"
  ```

- Install git and neovim using nix-shell

  ```sh
  nix-shell -p git neovim
  ```

- Clone the repo

  ```sh
  git clone https://github.com/Keshav13142/.dotfiles.git
  cd ~/.dotfiles/linux/nix
  ```

- Copy hardware configuration file
  ```sh
  cp /etc/nixos/hardware-configuration.nix nixos/laptop/
  ```
- Enable flakes and rebuild NixOs
  ```sh
  mkdir -p ~/.config/nix
  echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
  sudo nixos-rebuild switch --flake .#laptop
  ```

## WSL setup

- First enable `systemd` in wsl, add the following to /etc/wsl.conf

  ```sh
  [boot]
  systemd=true

  [automount]
  enabled = true

  [interop]
  appendWindowsPath = false
  ```

- Install nix

  ```sh
  sh <(curl -L https://nixos.org/nix/install) --daemon
  ```

- Init home-manager

  ```sh
  nix run home-manager/master -- init --switch
  ```

- Build after cd'ing into the nix directory

  ```sh
  home-manager switch --flake .#wsl
  ```

- Set zsh as the default nix-shell, edit the `/etc/shells` file and add the zsh path `which zsh`

  ```sh
  chsh -s $(which zsh)
  ```
