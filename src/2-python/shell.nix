with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    python3Packages.numpy
    python3Packages.matplotlib
    python3Packages.pandas
    jupyter
  ];
  shellHooks = ''
    echo "Python dev env"
  '';
}
