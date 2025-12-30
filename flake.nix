{
  description = "Darwin and NixOS system configurations";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager-stable.url = "github:nix-community/home-manager/release-25.11";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    darwinConfigurations.neo = inputs.nix-darwin.lib.darwinSystem {
      specialArgs = inputs;
      modules = [
        ./modules/common
        ./modules/darwin
        ./hosts/neo
        inputs.home-manager.darwinModules.home-manager
        inputs.mac-app-util.darwinModules.default
        {
          home-manager = {
            sharedModules = [inputs.mac-app-util.homeManagerModules.default];
          };
        }
      ];
    };

    nixosConfigurations.bluepill = inputs.nixpkgs-stable.lib.nixosSystem {
      specialArgs = inputs;
      modules = [
        ./modules/common
        ./modules/nixos
        ./hosts/bluepill
        inputs.agenix.nixosModules.default
        inputs.home-manager-stable.nixosModules.home-manager
        {
          nixpkgs.overlays = [
            (final: prev: {
              tailscale = inputs.nixpkgs.legacyPackages.${prev.stdenv.hostPlatform.system}.tailscale;
            })
          ];
        }
      ];
    };

    nixosConfigurations.tank-wsl = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = inputs;
      modules = [
        ./modules/common
        ./modules/nixos
        ./hosts/tank-wsl
        inputs.home-manager.nixosModules.home-manager
        inputs.nixos-wsl.nixosModules.default
      ];
    };

    formatter = {
      aarch64-darwin = inputs.nixpkgs.legacyPackages.aarch64-darwin.alejandra;
      x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
  };
}
