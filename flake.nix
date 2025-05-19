{
  description = "shafael170's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    lix-module = {
        url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-06cb-009a-fingerprint-sensor = {
        url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-master, lix-module, home-manager, nix-alien, chaotic, nur, nixos-06cb-009a-fingerprint-sensor, ... }:
  let
    system = "x86_64-linux";
    pkgsMaster = import nixpkgs-master {
      inherit system;
    };
    
  in {
    nixosConfigurations.X1-Yoga-2nd = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit self pkgsMaster; };
      modules = [
        ./hosts/default.nix
        lix-module.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shafael170 = import ./home.nix;
        }
        ({ self, pkgs, ... }: {
          nixpkgs.overlays = [
            self.inputs.nix-alien.overlays.default
          ];
          environment.systemPackages = with pkgs; [
            nix-alien
          ];
        })
        chaotic.nixosModules.default
        nur.modules.nixos.default
        nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
      ];
    };
  };
}
