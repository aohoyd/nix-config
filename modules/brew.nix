{ config, pkgs, lib, ...}:
{
  homebrew = {
    casks = [
      "marta"
      "raycast"
      "utm"
      "wezterm"
      "wireshark"
      "openlens"
    ];
  };
}