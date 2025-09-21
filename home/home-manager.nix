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

    # Zed editor remote server setup
    file.".zed_server" = {
      source = "${pkgs.zed-editor.remote_server}/bin";
      recursive = true;
    };
  };

  # Enable home-manager self-management
  programs.home-manager.enable = true;

  # XDG user directories configuration
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Configure Dank Material Shell
  programs.dankMaterialShell = {
    enable = true;
    enableKeybinds = false;
    enableSystemd = true;
    enableSpawn = true;
    enableSystemMonitoring = true;
    enableClipboard = true;
    enableVPN = true;
    enableBrightnessControl = true;
    enableNightMode = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };
}
