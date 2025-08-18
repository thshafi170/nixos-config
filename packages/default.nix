let
  pkgs = import <nixpkgs> { };
in
{
  inter-font = pkgs.callPackage ./inter-font.nix { };
  dgop = pkgs.callPackage ./dgop.nix { };
}
