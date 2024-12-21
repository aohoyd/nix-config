{ inputs, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    btop
    neovim
    git
    yabai
    ripgrep
    fd
    fzf
    fzy
    fish
    jq
    jankyborders

    # containers
    docker-client
    oras
    colima
    docker-credential-helpers

    # programming
    go_1_23
    gofumpt
    rustup
    python311
    python311Packages.pip

    # falkehub
    fh

    # home-manager
    inputs.home-manager.packages.${pkgs.system}.default  
  ];
}
