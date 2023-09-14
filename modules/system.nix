{ config, pkgs, user, ... }: {
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  nix = {
    package = pkgs.nix;
    gc = {                                # Garbage collection
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  
  # Enable yabai service
  services.yabai.enable = true;
  services.skhd.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  users.users = {
    "${user}" = {
      home = "/Users/${user}";
      shell = "/bin/fish";
    };
    root = {
        home = "/var/root";
        shell = "/bin/fish";
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
