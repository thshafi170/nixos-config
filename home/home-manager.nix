{
  config,
  pkgs,
  lib,
  ...
}:

{
  home = {
    username = "thshafi170";
    homeDirectory = "/home/thshafi170";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
