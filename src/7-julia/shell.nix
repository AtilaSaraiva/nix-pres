{ sources ? import ./nix/sources.nix }:
with (import sources.nixpkgs {});

let
  my-python-packages = python-packages: with python-packages; [
    matplotlib
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
  mkShell {
    buildInputs = [
      python-with-my-packages
      julia-bin
    ];
    shellHooks = ''
      julia -e "using Pkg; Pkg.activate("."); Pkg.precompile()"
    '';
  }
