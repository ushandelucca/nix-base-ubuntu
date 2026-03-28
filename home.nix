{ config, pkgs, ... }:

{
  home.username = "peter";
  home.homeDirectory = "/home/peter";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    zsh
    tmux
    wget
    curl
    fzf
    ripgrep
  ];

  # -----------------------------
  # Homebrew (Linuxbrew) installieren
  # -----------------------------
  home.activation.installHomebrew = config.lib.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "$HOME/.linuxbrew" ]; then
      echo "Installing Homebrew..."

      NONINTERACTIVE=1 bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      eval "$($HOME/.linuxbrew/bin/brew shellenv)"
      echo 'eval "$($HOME/.linuxbrew/bin/brew shellenv)"' >> ~/.zshrc
    fi
  '';

  # -----------------------------
  # Neovim über Homebrew installieren
  # -----------------------------
  home.activation.installNeovim = config.lib.dag.entryAfter ["installHomebrew"] ''
    if ! command -v brew >/dev/null 2>&1; then
      eval "$($HOME/.linuxbrew/bin/brew shellenv)"
    fi

    if ! brew list neovim >/dev/null 2>&1; then
      echo "Installing Neovim via Homebrew..."
      brew install neovim
    fi
  '';

  # -----------------------------
  # ZSH
  # -----------------------------
  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      v = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      plugins = [
        "git"
        "sudo"
      ];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-z";
        src = pkgs.zsh-z;
      }
    ];
  };

  # -----------------------------
  # TMUX
  # -----------------------------
  programs.tmux = {
    enable = true;

    extraConfig = ''
      set -g mouse on
      set -g history-limit 10000
      set -g base-index 1
      setw -g pane-base-index 1

      bind r source-file ~/.tmux.conf \; display "Reloaded!"
    '';
  };

  home.stateVersion = "23.11";
}