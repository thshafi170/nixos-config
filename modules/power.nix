{
  ...
}:

{
  # Enable power management features
  powerManagement.enable = true;

  # Configure sleep and hibernation behavior
  systemd.sleep.extraConfig = ''
    [Sleep]
    AllowSuspendThenHibernate=yes
    HibernateMode=shutdown
    HibernateDelaySec=3600
  '';
}
