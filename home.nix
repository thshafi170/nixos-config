{ config, pkgs, lib, ... }:

{
  home = {
    username = "shafael170";
    homeDirectory = "/home/shafael170";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      free = "free -m";
      nix-switch = "sudo nixos-rebuild switch";
      nix-upgrade = "sudo nixos-rebuild switch --upgrade";
      nix-clean = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system && sudo nix-collect-garbage && sudo nixos-rebuild boot";
    };
    functions = {
      pythonEnv = ''
        function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
        if set -q argv[2]
          set argv $argv[2..-1]
        end
      
        for el in $argv
          set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end
      
        nix-shell -p $ppkgs
        end
      '';
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}