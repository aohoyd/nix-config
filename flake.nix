{
  description = "My first nix flake";

  inputs = {
      # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs";

      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      private-config.url = "github:aohoy/private-config";
      private-config.flake = false;
  };
  
  # add the inputs declared above to the argument attribute set
  outputs = { self, nixpkgs, home-manager, darwin, private-config, ... }:
    let
      mkDarwinSystem =
        { hostname
        , user
        , system ? "aarch64-darwin"
        , extraModules ? []
        , brewEnable ? false
        , ...}:
          darwin.lib.darwinSystem {
            inherit system;
            specialArgs = { inherit user; };
            modules = [
              ({...}: { homebrew.enable = brewEnable; })
              (./modules)
              home-manager.darwinModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user} = {...}:
                  {
                    imports = [ ./home "${private-config}/${hostname}/home" ];
                  };
                home-manager.extraSpecialArgs = { inherit user; };
              }
            ] ++ extraModules;
          };
    in
    {
      darwinConfigurations = {
        macbook-work = mkDarwinSystem {
          user = "aolshanskiy";
          hostname = "macbook-work";
          system = "aarch64-darwin";
          # Uncomment to enable Homebrew
          # brewEnable = true;
        };
      };
    };
}