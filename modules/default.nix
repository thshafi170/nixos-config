{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./audio.nix
      ./boot.nix
      ./drivers.nix
      ./fhs.nix
      ./input-method.nix
      ./kernel.nix
      ./locale.nix
      ./networking.nix
      ./plasma6.nix
      ./power.nix
      ./programs.nix
      ./shell-sudo.nix
      ./virtualisation.nix
      ./xorg.nix
    ];
}
