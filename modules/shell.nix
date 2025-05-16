{ config, pkgs, lib, ... }:

{
    security.sudo.extraConfig = ''
    Defaults env_reset,pwfeedback
    root ALL=(ALL:ALL) ALL
    shafael170 ALL=(ALL:ALL) ALL
  '';

  users.defaultUserShell = pkgs.zsh;
  users.users.shafael170.useDefaultShell = lib.mkForce false;
  environment.systemPackages = with pkgs; [
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
    nano
    vim
    zsh
    zsh-completions
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.fish = {
    enable = true;
    vendor = {
      config.enable = true;
      functions.enable = true;
      completions.enable = true;
    };
  };

}