{ config, pkgs, lib, ... }:

{
  powerManagement.enable = true;
  
  systemd.sleep.extraConfig = ''
    [Sleep]
    AllowSuspendThenHibernate=yes
    HibernateMode=platform
    HibernateDelaySec=3600    
  '';
}