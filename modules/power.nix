{ config, pkgs, lib, ... }:

{
  powerManagement.enable = true;
  
  systemd.sleep.extraConfig = ''
    [Sleep]
    AllowSuspendThenHibernate=yes
    HibernateMode=shutdown
    HibernateDelaySec=3600    
  '';
}
