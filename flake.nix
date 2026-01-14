{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = {
    nixpkgs,
    nix-darwin,
    home-manager,
    mac-app-util,
    agenix,
    ...
  }: {
    darwinConfigurations = {
      neo = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/common
          ./modules/darwin
          ./hosts/neo
          home-manager.darwinModules.home-manager
          mac-app-util.darwinModules.default
          {home-manager.sharedModules = [mac-app-util.homeManagerModules.default];}
        ];
      };

      bluellama = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/common
          ./modules/darwin
          ./hosts/bluellama
          home-manager.darwinModules.home-manager
          mac-app-util.darwinModules.default
          {home-manager.sharedModules = [mac-app-util.homeManagerModules.default];}
        ];
      };
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
    };

    formatter = nixpkgs.lib.genAttrs ["aarch64-darwin" "x86_64-linux"] (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
