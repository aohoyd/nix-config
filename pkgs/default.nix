# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ inputs, pkgs, ... }: let
  goArgs = { buildGoModule = pkgs.buildGo122Module; };
in {
  # example = pkgs.callPackage ./example { };
  cdebug = pkgs.callPackage ./cdebug goArgs;
  superfile = inputs.superfile.packages.${pkgs.system}.default;
}
