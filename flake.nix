{
  description = "tenshou170's NixOS configuration";

  inputs = {
    # Repositories
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };

    vicinae.url = "github:vicinaehq/vicinae";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cutecosmic.url = "github:tenshou170/cutecosmic-nix";

    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:iedame/nixos-06cb-009a-fingerprint-sensor/25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      determinate,
      nixpkgs,
      home-manager,
      nix-cachyos-kernel,
      dankMaterialShell,
      vicinae,
      aagl,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # nixpkgs configuration
      nixpkgsConfig = {
        allowUnfree = true;
      };

      # Helper function to create package sets with unfree allowed
      mkPkgs =
        nixpkgsInput:
        import nixpkgsInput {
          inherit system;
          config = nixpkgsConfig;
        };

      # Declare package sets
      pkgsMaster = mkPkgs inputs.nixpkgs-master;
    in
    {
      packages.${system}.default = inputs.fenix.packages.${system}.stable.toolchain;

      nixosConfigurations."X1-Yoga-2nd" = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/default.nix
          determinate.nixosModules.default
          aagl.nixosModules.default
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
          inputs.home-manager.nixosModules.home-manager

          # Configure nixpkgs with overlays
          {
            nixpkgs = {
              config = nixpkgsConfig;
              overlays = [
                nix-cachyos-kernel.overlays.default
              ];
            };
          }

          # Home Manager configuration
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              users.tenshou170 = import ./home/default.nix;
              extraSpecialArgs = {
                inherit
                  inputs
                  pkgsMaster
                  ;
                inherit (inputs) vicinae;
              };
            };
          }
        ];

        # Pass inputs through specialArgs
        specialArgs = {
          inherit
            self
            inputs
            pkgsMaster
            ;
        };
      };
    };
}
