{
  pkgs,
  inputs,
  ...
}:

{
  # Import home-manager modules
  imports = [
    inputs.vicinae.homeManagerModules.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  # Basic home configuration
  home = {
    username = "tenshou170";
    homeDirectory = "/home/tenshou170";
    stateVersion = "26.05";
  };

  # Enable home-manager self-management
  programs.home-manager.enable = true;

  # XDG user directories configuration
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Configure Vicinae
  services.vicinae = {
    enable = true;
    autoStart = true;
  };

  # Configure Dank Material Shell
  # programs.dankMaterialShell.enable = true;
}
