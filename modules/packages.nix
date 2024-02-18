{ config, pkgs, ... }:
let
  # acorn = pkgs.acorn.overrideAttrs (old: rec {
  #   version = "0.9.1";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "acorn-io";
  #     repo = "acorn";
  #     rev = "v${version}";
  #     hash = "sha256-FPnKmWKnEFVDXbDI+An3EKzleP43NEC9/dq4SJfWQrU=";
  #   };
  # });
  acorn = final: prev: {
    acorn = import ./acorn.nix { inherit (prev) lib buildGoModule fetchFromGitHub; };
  };
in {
# {
  nixpkgs.overlays = [ acorn ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.btop
    pkgs.choose
    pkgs.lnav
    pkgs.tailspin
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
    pkgs.go_1_21
    pkgs.gofumpt
    # pkgs.jdk17
    # pkgs.vagrant
    pkgs.rustup
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.nodejs_21
    # pkgs.poetry

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
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.gettext
    pkgs.docker-credential-helpers
    pkgs.nushell
    pkgs.neovim
    pkgs.neovide

    # git
    pkgs.git
    pkgs.delta
    pkgs.git-get
    pkgs.git-lfs
    pkgs.glab
    pkgs.gh
    pkgs.gitui
    pkgs.lazygit

    # k8s
    pkgs.kind
    pkgs.kubectl
    pkgs.minikube
    pkgs.kubernetes-helm-wrapped
    pkgs.kustomize
    pkgs.krew
    pkgs.kube-linter
    pkgs.k9s
    pkgs.acorn

    # yabai
    pkgs.yabai
    # pkgs.skhd

    # falkehub
    pkgs.fh
  ];
}
