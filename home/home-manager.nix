{
  pkgs,
  inputs,
  ...
}:

{
  # Import home-manager modules
  imports = [
    inputs.dank-material-shell.homeModules.dankMaterialShell
  ];

  # Basic home configuration
  home = {
    username = "thshafi170";
    homeDirectory = "/home/thshafi170";
    stateVersion = "25.11";
  };

  # Enable home-manager self-management
  programs.home-manager.enable = true;

  # XDG user directories configuration
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Configure Dank Material Shell
  # programs.dankMaterialShell.enable = true;
}
