{
  description = "thshafi170's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";

    flake-utils.url = "github:numtide/flake-utils";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iio-niri = {
      url = "github:Zhaith-Izaliel/iio-niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker.url = "github:abenz1267/walker/0.13.26";

    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-master,
      nixpkgs-staging,
      nixpkgs-staging-next,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      mkPkgs =
        nixpkgs:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      pkgs = mkPkgs nixpkgs;
      pkgsMaster = mkPkgs nixpkgs-master;
      pkgsStaging = mkPkgs nixpkgs-staging;
      pkgsNext = mkPkgs nixpkgs-staging-next;

    in
    {
      packages.x86_64-linux.default = inputs.fenix.packages.x86_64-linux.default.toolchain;
      nixosConfigurations.X1-Yoga-2nd = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            self
            inputs
            pkgs
            pkgsMaster
            pkgsStaging
            pkgsNext
            ;
        };
        modules = [
          # Core modules
          inputs.lix-module.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          inputs.chaotic.nixosModules.default
          inputs.nur.modules.nixos.default
          inputs.niri.nixosModules.niri
          inputs.iio-niri.nixosModules.default
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"

          # Configuration modules
          ./hosts/default.nix

          # Global nixpkgs configuration
          {
            nixpkgs.overlays = [
              inputs.fenix.overlays.default
              inputs.iio-niri.overlays.default
              (import ./overlays.nix)
            ];
            nixpkgs.config.allowUnfree = true;
          }

          # Home Manager configuration
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              users.thshafi170 = import ./home/default.nix;
            };
          }
        ];
      };
    };
}
