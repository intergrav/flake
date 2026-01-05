{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
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
    nixpkgs,
    nixpkgs-stable,
    nix-darwin,
    home-manager,
    home-manager-stable,
    mac-app-util,
    nixos-wsl,
    agenix,
    ...
  }: {
    darwinConfigurations.neo = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/common
        ./modules/darwin
        ./hosts/neo
        home-manager.darwinModules.home-manager
        mac-app-util.darwinModules.default
        {home-manager.sharedModules = [mac-app-util.homeManagerModules.default];}
      ];
    };

    nixosConfigurations = {
      trinity = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/common
          ./modules/nixos
          ./hosts/trinity
          home-manager.nixosModules.home-manager
        ];
      };

      bluepill = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/common
          ./modules/nixos
          ./hosts/bluepill
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
      };

      tank-wsl = nixpkgs.lib.nixosSystem {
        modules = [
          ./modules/common
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
