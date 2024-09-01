{ pkgs ? import <nixpkgs> { } }:

let
  # Bruk builtins.path for å referere til den lokale filen
  localDeb = builtins.path {
    path = ~/.dotfiles/packages/PureRef-2.0.2_x64.deb;
  };
in

pkgs.stdenv.mkDerivation rec {
  pname = "pureref";
  version = "1.11.1";

  src = localDeb; # Bruker den lokale filen som kilde

  nativeBuildInputs = [ pkgs.dpkg pkgs.xz pkgs.coreutils ];

  unpackPhase = "true"; # Vi hopper over den vanlige unpackPhase.

  buildPhase = ''
    echo "Starting buildPhase"

    # Pakk ut .deb-filen
    echo "Extracting .deb file..."
    dpkg-deb -x $src $TMPDIR/pureref || { echo "Failed to extract .deb file"; exit 1; }

    echo "BuildPhase complete"
  '';

  installPhase = ''
    echo "Starting installPhase"
    cp -r $TMPDIR/pureref/* $out/
    echo "InstallPhase complete"
  '';

  meta = with pkgs.lib; {
    description = "Reference Image Viewer";
    homepage = "http://www.pureref.com";
    license = licenses.unfree; # License is unknown, but not free
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
  };
}

