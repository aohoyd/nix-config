{
  description = "My first nix flake";

  inputs = {
      # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
      # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";

      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs";

      home-manager.url = "github:nix-community/home-manager";
      # home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.1.0.tar.gz";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      private-config.url = "github:aohoyd/private-config";
      private-config.flake = false;
  };
  
  # add the inputs declared above to the argument attribute set
  outputs = inputs:
    let
      inherit (inputs) self nixpkgs;
      darwinSystems = ["aarch64-darwin"];
      forAllSystems = nixpkgs.lib.genAttrs darwinSystems;

      mkApp = scriptName: system: {
        type = "app";
        program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
          #!/usr/bin/env bash
          PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
          echo "Running ${scriptName} for ${system}"
          exec ${self}/apps/${scriptName}
        '')}/bin/${scriptName}";
      };

      mkDarwinApps = system: {
        "build" = mkApp "build" system;
        "switch" = mkApp "switch" system;
        "home-build" = mkApp "home-build" system;
        "home-switch" = mkApp "home-switch" system;
      };

      darwinHosts = import ./outputs/darwin-conf.nix { inherit inputs outputs; };
    in
    {
      apps = forAllSystems mkDarwinApps;

      darwinConfigurations = builtins.mapAttrs (host: conf: conf.system) darwinHosts;
      homeConfigurations = builtins.mapAttrs (host: conf: conf.home) darwinHosts;
    };
}
