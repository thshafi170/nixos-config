{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./fish.nix
      ./home-manager.nix
      # ./nixcord.nix
    ];
}
