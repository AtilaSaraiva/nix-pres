with (import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f09ad462c5a121d0239fde645aacb2221553a217.tar.gz") {});

let
  my-python-packages = python-packages: with python-packages; [
    numpy
    matplotlib
    pytorch
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
  mkShell {
    buildInputs = [
      python-with-my-packages
      jupyter
    ];
  }
