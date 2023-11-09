{...}:
{
  imports = [
    ./git.nix
    ./starship.nix
    ./wezterm.nix
    ./fish.nix
    ./yabai.nix
    ./k9s.nix
    ./viddy.nix
  ];
  home.stateVersion = "22.11";

  programs = {
    nushell.enable = true;
  };
}
