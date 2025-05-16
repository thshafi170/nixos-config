{
  description = "shafael170's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
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

  outputs = { self, nixpkgs, home-manager, nix-alien, chaotic, nur, nixos-06cb-009a-fingerprint-sensor, ... }: {
    nixosConfigurations.X1-Yoga-2nd = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
            ./hosts/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.shafael170 = import ./home.nix;
            }
            ({ self, pkgs, ...}: {
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