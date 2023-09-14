{ config, pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.btop
    pkgs.choose
    pkgs.lnav
    pkgs.cfssl
    pkgs.chezmoi
    pkgs.go-task
    pkgs.grpcurl
    pkgs.helix

    # containers
    pkgs.docker-client
    pkgs.oras
    pkgs.colima

    # programming
    pkgs.go
    pkgs.gofumpt
    pkgs.jdk17
    pkgs.rustup
    pkgs.python310
    pkgs.python310Packages.pip
    pkgs.poetry

    # cli
    pkgs.hck
    pkgs.starship
    pkgs.xh
    pkgs.viddy
    pkgs.tldr
    pkgs.ouch
    pkgs.ripgrep
    pkgs.jq
    pkgs.yq-go
    pkgs.bat
    pkgs.curl
    pkgs.exa
    pkgs.fd
    pkgs.fzf
    pkgs.gettext
    pkgs.docker-credential-helpers
    pkgs.nushell

    # git
    pkgs.git
    pkgs.delta
    # pkgs.git-get
    pkgs.git-lfs
    pkgs.glab
    pkgs.gh
    pkgs.tig

    # k8s
    pkgs.kind
    pkgs.kubectl
    pkgs.minikube
    pkgs.kubernetes-helm-wrapped
    pkgs.kustomize
    pkgs.krew
    pkgs.kube-linter
    pkgs.k9s

    # yabai
    pkgs.yabai
    pkgs.skhd
  ];
}
