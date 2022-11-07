---
title:
- Reproducible development environments with Nix
author:
- Átila Saraiva Quintela Soares
aspectratio:
- 169
---


# Introduction

## Development **Pains** while doing research

+ You have some code that works on your machine but reproducing your environment on another computer is too much of a pain
+ You have fear of upgrading your packages because you fear breaking changes
+ Want to send your code to other people but is afraid that they won't be able to compile it/run it
+ You know that Docker containers could more or less solve your problem but they are a pain to work with

If any of these problems happened or still happen to you, you might want to hear about Nix

## Meet Nix

The first tool to know is `nix-shell`

To create a shell with gcc available
```
> $ nix-shell -p gcc
```

To create a shell with `python` with the numpy package available
```
> $ nix-shell -p python3Packages.numpy
```

## Installing Nix

Just run this in the Linux Terminal:
```
$ sh <(curl -L https://nixos.org/nix/install) --daemon
```

For MacOS:
```
$ sh <(curl -L https://nixos.org/nix/install)
```

On Windows with WSL2
```
$ sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

Docker
```
$ docker run -it nixos/nix
```

## Defining the environment with a file

~~~nix
# shell.nix
# -------------------
{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name="dev environment";
  buildInputs = [
    pkgs.gcc
#   ...
#   other packages you might want
  ];
}
~~~

## Defining the environment with a file

~~~nix
# shell.nix
# -------------------
with (import <nixpkgs> { });

mkShell {
  name="dev environment";
  buildInputs = [
    gcc
#   ...
#   other packages you might want
  ];
}
~~~

## Python environment

~~~nix
# shell.nix
# -------------------
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
~~~

## Python environment with improvements

```nix
# shell.nix
# -------------------
with (import <nixpkgs> {});

let
  my-python-packages = python-packages: with python-packages; [
    numpy
    matplotlib
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
in
  mkShell {
    buildInputs = [
      python-with-my-packages
      jupyter
    ];
  };
```

## Creating Docker images with Nix

```nix
# shell.nix
# -------------------
with (import <nixpkgs> {});

dockerTools.streamLayeredImage {
  name = "saig";
  tag = "latest";
  contents = [
    gcc
    bash
  ];
  config = {
    Cmd = [
      "bash"
    ];
  };
}
```

# What is reproducibility?

## Pure functions

![Pure Functions](figs/pure_function.pdf){ style="width: 70%; margin: auto;" }

## Pure functions

Which of these functions is pure?
```julia
function f!(x)
    x = x^2
    return 2*x
end

function f(x)
    return 2*x
end
```

## Nix software stack

| Name    | Description             |
|---------|-------------------------|
| Nixpkgs | The software repository |
| Nix     | The package manager     |
| Nix     | The language            |
| NixOS   | The operating system    |

## How Nix packages software

![Nix packaging](figs/nixbuild.pdf){ style="width: 70%; margin: auto;" }

## How Nix packages software

![Nix packaging](figs/deptree.pdf){ style="width: 70%; margin: auto;" }

## Example of a package

```nix
{ mkDerivation, lib, fetchFromGitHub, tinyxml-2, cmake, qtbase, qtmultimedia }:
mkDerivation rec {
  version = "1.0.13";
  pname = "pro-office-calculator";

  src = fetchFromGitHub {
    owner  = "RobJinman";
    repo   = "pro_office_calc";
    rev    = "v${version}";
    sha256 = "1v75cysargmp4fk7px5zgib1p6h5ya4w39rndbzk614fcnv0iipd";
  };

  buildInputs = [ qtbase qtmultimedia tinyxml-2 ];

  nativeBuildInputs = [ cmake ];
}
```

## Example of a Python library package

```nix
{ buildPythonPackage, fetchPypi, lib, six }:

buildPythonPackage rec {
  pname = "dictionaries";
  version = "0.0.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "8fa92745eb7c707b8588888875234f2f0a61b67936d8deb91b2b7b4c32366112";
  };

  buildInputs = [ six ];
}
```

## Making shell.nix reproducible

Show file

## Making Julia reproducible environments

```
] activate .

add FFTW
add HDF5
```

## Conclusions

+ With Nix you can create reproducible environments and have it synchronized with several computers
+ You can ship your environment configuration along with your code on GitHub
