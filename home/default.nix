{user, ...}:
{
  imports = [
    ./git.nix
    ./starship.nix
    ./wezterm.nix
    ./fish.nix
    ./yabai.nix
    ./k9s.nix
    ./viddy.nix
    ./kitty.nix
  ];

  home = {
    username = user;
    homeDirectory = "/Users/${user}";
    stateVersion = "23.11";
  };

  programs = {
    nushell.enable = true;
  };
}
