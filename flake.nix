{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-tlp-pr.url = "github:NixOS/nixpkgs/pull/473626/head";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-tlp-pr,
    nix-darwin,
    home-manager,
    home-manager-stable,
    mac-app-util,
    nixos-wsl,
    agenix,
  }: let
    commonModules = [./modules/common];
  in {
    darwinConfigurations.neo = nix-darwin.lib.darwinSystem {
      modules =
        commonModules
        ++ [
          ./modules/darwin
          ./hosts/neo
          home-manager.darwinModules.home-manager
          mac-app-util.darwinModules.default
          {home-manager.sharedModules = [mac-app-util.homeManagerModules.default];}
        ];
    };

    nixosConfigurations = {
      trinity = nixpkgs-tlp-pr.lib.nixosSystem {
        modules =
          commonModules
          ++ [
            ./modules/nixos
            ./hosts/trinity
            home-manager.nixosModules.home-manager
          ];
      };

      bluepill = nixpkgs-stable.lib.nixosSystem {
        modules =
          commonModules
          ++ [
            ./modules/nixos
            ./hosts/bluepill
            agenix.nixosModules.default
            home-manager-stable.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                (final: prev: {
                  tailscale = nixpkgs.legacyPackages.${prev.stdenv.hostPlatform.system}.tailscale;
                })
              ];
            }
          ];
      };

      tank-wsl = nixpkgs.lib.nixosSystem {
        modules =
          commonModules
          ++ [
            ./modules/nixos
            ./hosts/tank-wsl
            home-manager.nixosModules.home-manager
            nixos-wsl.nixosModules.default
          ];
      };
    };

    formatter = nixpkgs.lib.genAttrs ["aarch64-darwin" "x86_64-linux"] (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
