{ inputs, outputs, ... }:

with inputs;

let
  inherit (darwin.lib) darwinSystem;
  inherit (home-manager) darwinModules;

  homeModulesFor = hostname: [ ../home "${private-config}/${hostname}/home" ];

  mkHome = { hostname , user , system , ...}: (
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = homeModulesFor hostname;
      extraSpecialArgs = { inherit user; };
    }
  );

  mkDarwinSystem = { hostname , user , system , ...}: (
    darwinSystem {
      inherit system;
      specialArgs = { inherit user inputs outputs; };
      modules = [
        (../modules)
        home-manager.darwinModules.home-manager {
          home-manager.extraSpecialArgs = { inherit user inputs outputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = {...}: {
            imports = homeModulesFor hostname;
          };
        }                
        ({pkgs, ...}: {
          users.users.${user}.packages = [ pkgs.home-manager ];
        })
      ];
    }
  );

  mkHosts = hosts: (
    builtins.mapAttrs (hostname: conf: {
      system = mkDarwinSystem { inherit hostname; inherit (conf) user system; };
      home = mkHome { inherit hostname; inherit (conf) user system; };
      _system = conf.system;
    }) hosts
  );

in mkHosts {
  macbook-work = {
    user = "aolshanskiy";
    system = "aarch64-darwin";
  };
}
