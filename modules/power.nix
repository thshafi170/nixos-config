{
  ...
}:

{
  # Enable power management
  powerManagement.enable = true;

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
      criticalPowerAction = "hibernate";
    };
  };

  # Configure sleep and hibernation behavior
  systemd.sleep.extraConfig = ''
    [Sleep]
    AllowSuspendThenHibernate=yes
    HibernateMode=shutdown
    HibernateDelaySec=3600
  '';
}
