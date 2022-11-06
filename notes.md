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
shell.nix
-------------------
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
shell.nix
-------------------
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
shell.nix
-------------------
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
