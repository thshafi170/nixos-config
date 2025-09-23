{
  pkgs,
  inputs,
  ...
}:

{
  # Import home-manager modules
  imports = [
    inputs.dank-material-shell.homeModules.dankMaterialShell
    inputs.chaotic.homeModules.default
  ];

  # Basic home configuration
  home = {
    username = "thshafi170";
    homeDirectory = "/home/thshafi170";
    stateVersion = "25.11";
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

  # Configure Dank Material Shell
  # programs.dankMaterialShell.enable = true;
}
