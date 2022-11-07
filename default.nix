with (import <nixpkgs> {});

stdenv.mkDerivation {
  pname = "nix-presentation";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [ texlive.combined.scheme-small ];
  buildInputs = [ pandoc ];

  installPhase = ''
    mkdir -p $out
    cp pres.pdf $out/pres.pdf
  '';
}
