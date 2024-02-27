# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, ... }: let
  goArgs = { buildGoModule = pkgs.buildGo122Module; };
in {
  # example = pkgs.callPackage ./example { };
  acorn = pkgs.callPackage ./acorn goArgs;
  cdebug = pkgs.callPackage ./cdebug goArgs;
}
