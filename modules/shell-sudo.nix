{
  pkgs,
  ...
}:

{
  # Sudo configuration
  security.sudo.extraConfig = ''
    Defaults env_reset,pwfeedback
    root ALL=(ALL:ALL) ALL
    thshafi170 ALL=(ALL:ALL) NOPASSWD:ALL
  '';

  # Default shell
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    # Fish plugins
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fishPlugins.grc

    # Zsh plugins
    zsh
    zsh-completions
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting

    # Utilities
    bat
    eza
    fastfetch
    fd
    fzf
    grc
    msedit
    nano
    neovim
    pywal
    pciutils
    vim
    zenity
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    # History settings
    histSize = 10000;
    histFile = "$HOME/.zsh_history";

    # Oh My Zsh
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "kubectl"
      ];
      theme = "alanpeabody";
    };
  };

  # Fish shell
  programs.fish = {
    enable = true;
    vendor = {
      config.enable = true;
      functions.enable = true;
      completions.enable = true;
    };

    # Fish config
    shellInit = ''
      set -g fish_greeting ""
      set -g fish_key_bindings fish_vi_key_bindings
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      format = "$all$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      git_branch = {
        symbol = " ";
        format = "[$symbol$branch]($style) ";
        style = "bold purple";
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold red";
        conflicted = "⚡";
        up_to_date = "✓";
        untracked = "🆕";
        ahead = "⇡\${count}";
        diverged = "🔀⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        stashed = "📦";
        modified = "📝";
        staged = "[🎯\(\${count}\)](green)";
        renamed = "🔄";
        deleted = "🗑️";
        typechanged = "🔧";
      };
      nix_shell = {
        symbol = "❄️ ";
        format = "[$symbol$state( \($name\))]($style) ";
        style = "bold blue";
        impure_msg = "[impure shell](bold red)";
        pure_msg = "[pure shell](bold green)";
        unknown_msg = "[unknown shell](bold yellow)";
      };
    };
  };
}
