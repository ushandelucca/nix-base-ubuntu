# nix-base-ubuntu

A blueprint with Nix to set up a fresh Ubuntu machine in minutes. Including:

- zsh as default shell
- Powerlevel10k prompt
- useful zsh plugins
- tmux + pre-configured setup
- homebrew + neovim
- fully reproducible

Intentionally minimal and quick to deploy (no NixOS required, runs directly on Ubuntu).

Architecture:

```md
    │
    ├── flake.nix
    ├── home.nix
    ├── zsh
    │   ├── .zshrc
    │   └── .p10k.zsh
    │
    └── tmux
        └── .tmux.conf
```

## Installation

```bash
# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# log in again
exit
ssh peter@your-server-ip

# enable flake support
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# install git
sudo apt update && sudo apt install -y git

# clone the repo
git clone https://github.com/YOUR-USER/ubuntu-server-blueprint.git
cd ubuntu-server-blueprint

# install everything
nix run home-manager -- switch --flake .#server

# set zsh as default shell
chsh -s $(which zsh)

```

---

## MIT License

Copyright (c) 2026 Peter Böhringer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
