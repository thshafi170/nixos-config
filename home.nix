{ config, pkgs, lib, ... }:

{
  home = {
    username = "shafael170";
    homeDirectory = "/home/shafael170";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      free = "free -m";
      nix-switch = "sudo nixos-rebuild switch";
      nix-upgrade = "sudo nixos-rebuild switch --upgrade";
      nix-clean = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system && sudo nix-collect-garbage && sudo nixos-rebuild boot";
    };
    functions = {
      fish_greeting = {
        description = "Start fastfetch at launch.";
        body = "fastfetch";
      };
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
