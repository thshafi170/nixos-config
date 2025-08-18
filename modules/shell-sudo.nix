{
  pkgs,
  ...
}:

{
  # sudo configuration
  security.sudo.extraConfig = ''
    Defaults env_reset,pwfeedback
    root ALL=(ALL:ALL) ALL
    thshafi170 ALL=(ALL:ALL) ALL
  '';

  # Set default shell for all users
  users.defaultUserShell = pkgs.zsh;

  # Override for specific user to use fish instead
  users.users.thshafi170 = {
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    # Fish plugins
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc

    # Zsh plugins and tools
    zsh
    zsh-completions
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting

    # Common utilities
    bat
    eza
    fastfetch
    fd
    fzf
    grc
    msedit
    nano
    neovim
    vim
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    # Add some useful zsh configuration
    histSize = 10000;
    histFile = "$HOME/.zsh_history";

    # Enable oh-my-zsh if you want more features
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "kubectl"
      ];
      theme = "robbyrussell";
    };
  };

  # Enable fish shell
  programs.fish = {
    enable = true;
    vendor = {
      config.enable = true;
      functions.enable = true;
      completions.enable = true;
    };

    # Add some fish-specific configuration
    shellInit = ''
      set -g fish_greeting ""
      set -g fish_key_bindings fish_vi_key_bindings
    '';
  };

  # Optional: Configure starship prompt for both shells
  programs.starship = {
    enable = true;
    settings = {
      format = "$all$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
}
