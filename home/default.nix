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
  home.stateVersion = "23.11";

  programs = {
    nushell.enable = true;
    home-manager.enable = true;
  };
}
