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
      SleepOperation = "suspend-then-hibernate";
      HandleLidSwitch = "suspend-then-hibernate";
      HandlePowerKey = "lock";
      HandlePowerKeyLongPress = "poweroff";
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
