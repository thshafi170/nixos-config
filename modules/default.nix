{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./audio.nix
      ./boot.nix
      ./drivers.nix
      ./input-method.nix
      ./kernel.nix
      ./networking.nix
      ./nix-ld.nix
      ./plasma6.nix
      ./power.nix
      ./programs.nix
      ./shell-sudo.nix
      ./virtualisation.nix
      ./xorg.nix
    ];
}
