{
  description = "thshafi170's NixOS configuration";

  inputs = {
    # Repositories
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3.11.2";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    iio-niri = {
      url = "github:Zhaith-Izaliel/iio-niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dank-material-shell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      chaotic,
      home-manager,
      dank-material-shell,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

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

      # Create alternative package sets for use in modules
      pkgsMaster = mkPkgs inputs.nixpkgs-master;
      pkgsStaging = mkPkgs inputs.nixpkgs-staging;
      pkgsNext = mkPkgs inputs.nixpkgs-staging-next;
    in
    {
      packages.${system}.default = inputs.fenix.packages.${system}.stable.toolchain;

      nixosConfigurations."X1-Yoga-2nd" = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/default.nix
          determinate.nixosModules.default
          chaotic.nixosModules.default
          inputs.niri.nixosModules.niri
          inputs.iio-niri.nixosModules.default
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
          inputs.home-manager.nixosModules.home-manager

          # Configure nixpkgs with Chaotic overlay
          {
            nixpkgs = {
              config = nixpkgsConfig;
              # Use cache-friendly overlay for better performance
              overlays = [ chaotic.overlays.cache-friendly ];
            };
          }

          # Chaotic Nyx configuration
          {
            chaotic = {
              nyx = {
                # Enable binary cache for faster builds
                cache.enable = true;
                # Use cache-friendly overlay for better performance
                overlay = {
                  enable = true;
                  onTopOf = "flake-nixpkgs";
                };
                # Add to registry for convenience
                registry.enable = true;
              };
            };
          }

          # Home Manager configuration
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

        # Pass inputs through specialArgs
        specialArgs = {
          inherit
            self
            inputs
            pkgsMaster
            pkgsStaging
            pkgsNext
            ;
        };
      };
    };
}
