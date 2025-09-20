{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Configure power management settings
  services = {
    logind.settings.Login = {
      HandlePowerKey = "lock";
      HandlePowerKeyLongPress = "poweroff";
      HandleLidSwitch = "suspend-then-hibernate";
    };

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 10;
      percentageAction = 6;
      criticalPowerAction = "Hibernate";
    };
  };
}
