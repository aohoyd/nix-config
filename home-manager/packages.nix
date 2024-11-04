{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  home.packages = with pkgs; [
    lnav
    tailspin
    cfssl
    go-task
    grpcurl
    helix

    # python
    uv

    # cli
    yazi
    choose
    hck
    starship
    xh
    viddy
    tldr
    ouch
    jq
    yq-go
    bat
    curl
    eza
    gettext
    nushell
    neovim
    neovide
    fx
    mise

    # git
    delta
    difftastic
    git-get
    git-lfs
    glab
    gh
    gitui
    lazygit

    # k8s
    kind
    kubectl
    minikube
    kubernetes-helm-wrapped
    helm-ls
    kustomize
    krew
    kube-linter
    k9s

    # custom packages
    cdebug
    superfile
  ];
}
