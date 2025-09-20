{
  description = "thshafi170's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";

    flake-utils.url = "github:numtide/flake-utils";

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

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
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

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:iedame/nixos-06cb-009a-fingerprint-sensor/25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      # Helper function to create package sets with unfree allowed
      mkPkgs = nixpkgsInput: import nixpkgsInput {
        inherit system overlays;
        config = nixpkgsConfig;
      };

      # Define overlays first
      overlays = [
        (import ./overlays.nix)
      ];

      # nixpkgs branches
      pkgs = mkPkgs inputs.nixpkgs;
      pkgsMaster = mkPkgs inputs.nixpkgs-master;
      pkgsStaging = mkPkgs inputs.nixpkgs-staging;
      pkgsNext = mkPkgs inputs.nixpkgs-staging-next;

      # nixpkgs configuration
      nixpkgsConfig = {
        allowUnfree = true;
      };

    in {
      packages.${system}.default = inputs.fenix.packages.${system}.stable.toolchain;

      nixosConfigurations."X1-Yoga-2nd" = nixpkgs.lib.nixosSystem {
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
          chaotic = inputs.chaotic.packages.${system};
        };

        modules = [
          ./hosts/default.nix
          inputs.chaotic.nixosModules.default
          inputs.niri.nixosModules.niri
          inputs.iio-niri.nixosModules.default
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              users.thshafi170 = import ./home/default.nix;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
    };
}
