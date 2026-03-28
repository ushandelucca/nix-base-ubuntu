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