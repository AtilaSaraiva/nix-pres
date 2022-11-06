with (import <nixpkgs> {});

mkShell rec {
  name = "my dev env";
  buildInputs = [
    gcc
  ];
  shellHooks = ''
    echo "Welcome to your new environment"
  '';
}
