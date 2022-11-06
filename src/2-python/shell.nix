with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    python3Packages.numpy
    python3Packages.matplotlib
    jupyter
  ];
  shellHooks = ''
    echo "Python dev env"
  '';
}
