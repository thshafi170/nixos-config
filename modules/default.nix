{
  config,
  lib,
  ...
}:

{
  imports = [
    ./audio.nix
    ./boot.nix
    # ./cosmic.nix
    ./drivers.nix
    ./input-method.nix
    ./kernel.nix
    ./networking.nix
    ./niri.nix
    ./nix-ld.nix
    # ./plasma6.nix
    ./power.nix
    ./programs.nix
    ./shell-sudo.nix
    ./system-devenv.nix
    ./virtualisation.nix
    ./xorg.nix
  ];
}
