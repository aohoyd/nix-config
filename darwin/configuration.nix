# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  user,
  host,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ./packages.nix
    ./brew.nix

    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    # useGlobalPkgs = true;
    # useUserPkgs = true;
    extraSpecialArgs = { inherit inputs outputs user host; };
    users.${user.username} = import ../home-manager/home.nix;
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  # nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      extra-nix-path = nixpkgs=flake:nixpkgs
    '';
  };

  users.users = {
    "${user.username}" = {
      home = "/Users/${user.username}";
      shell = "/bin/fish";
    };
    root = {
        home = "/var/root";
        shell = "/bin/fish";
    };
  };

  services.nix-daemon.enable = true;

  # Enable yabai service
  services.yabai.enable = true;
  # services.skhd.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = 1;
}
