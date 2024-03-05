# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {inherit inputs; pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # Rust example
    # mise = prev.mise.overrideAttrs (oldAttrs: rec {
    #   version = "2024.5.9";
    #   src = oldAttrs.src.override {
    #     rev = "v${version}";
    #     hash = "sha256-vmY+uI/NqMCLJwJaQU+aDppmn5OSLPUIbeqCSlN8Xb0=";
    #   };
    #   cargoDeps = oldAttrs.cargoDeps.overrideAttrs (_: rec {
    #     name = "${oldAttrs.pname}-${version}.tgz";
    #     inherit src;
    #     outputHash = "sha256-tE+2wOtLcwvy7aekKN2yG/CYyGIsQBinI1fO0O2ZHBc=";
    #   });
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };
}
