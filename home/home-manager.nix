{
  pkgs,
  inputs,
  ...
}:

{
  # Import home-manager modules
  imports = [
    inputs.chaotic.homeManagerModules.default
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

  # Chaotic Nyx configuration for Home Manager
  chaotic = {
    nyx = {
      # Enable binary cache for home manager packages too
      cache.enable = true;
      # Disable overlay here since we're using useGlobalPkgs
      overlay.enable = false;
    };
  };

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