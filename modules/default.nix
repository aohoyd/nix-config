{ config, pkgs, lib, ...}:
{
  imports = [
    ./system.nix
    ./packages.nix
    ./brew.nix
  ];
}