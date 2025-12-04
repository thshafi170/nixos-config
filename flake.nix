{
  description = "tenshou170's NixOS configuration";

  inputs = {
    # Repositories
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
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
      chaotic,
      home-manager,
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
          aagl.nixosModules.default
          inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
          inputs.home-manager.nixosModules.home-manager

          # Configure nixpkgs with overlays
          {
            nixpkgs = {
              config = nixpkgsConfig;
              overlays = [
                # Use cache-friendly overlay for better performance
                chaotic.overlays.cache-friendly
              ];
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
              users.tenshou170 = import ./home/default.nix;
              extraSpecialArgs = {
                inherit inputs pkgsMaster pkgsStaging pkgsNext;
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
            pkgsStaging
            pkgsNext
            ;
        };
      };
    };
}