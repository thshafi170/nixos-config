{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./audio.nix
      ./boot.nix
      ./drivers.nix
      ./input-method.nix
      ./kernel.nix
      ./locale.nix
      ./networking.nix
      ./nix-ld.nix
      ./plasma6.nix
      ./power.nix
      ./programs.nix
      ./shell.nix
      ./virtualisation.nix
      ./xorg.nix
    ];
}
